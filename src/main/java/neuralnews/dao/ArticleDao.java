package neuralnews.dao;

import neuralnews.model.Article;
import neuralnews.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.LinkedHashMap;

public class ArticleDao {


    public List<Article> getArticlesCommon(int limit, int offset, int categoryId) {
        List<Article> list = new ArrayList<>();
        String sql = """
            SELECT a.*, c.name AS category_name FROM articles a 
            JOIN categories c ON a.category_id = c.id 
            WHERE a.status='PUBLISHED' 
        """;
        if (categoryId > 0) sql += "AND a.category_id=? ";
        sql += "ORDER BY a.published_at DESC LIMIT ? OFFSET ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            int i = 1;
            if (categoryId > 0) ps.setInt(i++, categoryId);
            ps.setInt(i++, limit);
            ps.setInt(i, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapArticle(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Article> getFeaturedArticles(int limit) {
        List<Article> list = new ArrayList<>();
        String sql = """
            SELECT a.*, c.name AS category_name FROM articles a 
            JOIN categories c ON a.category_id = c.id 
            WHERE a.status='PUBLISHED' 
            ORDER BY (a.popularity_score + 1) / (DATEDIFF(NOW(), a.created_at) + 1) DESC 
            LIMIT ?
        """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapArticle(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    
    public List<Article> getLatestArticles(int limit) {
        return getArticlesCommon(limit, 0, 0);
    }

    public List<Article> getMostViewedArticles(int limit) {
        List<Article> list = new ArrayList<>();
        String sql = """
            SELECT a.*, c.name AS category_name FROM articles a 
            JOIN categories c ON a.category_id = c.id 
            WHERE a.status='PUBLISHED' 
            ORDER BY a.views DESC LIMIT ?
        """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapArticle(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    
    public List<Article> getRecommendedArticles(int limit, long excludeId) {
        List<Article> list = new ArrayList<>();
        String sql = "SELECT a.*, c.name AS category_name FROM articles a " +
                     "JOIN categories c ON a.category_id = c.id " +
                     "WHERE a.id != ? " +
                     "ORDER BY RAND() LIMIT ?";
                     
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setLong(1, excludeId);
            ps.setInt(2, limit);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapArticle(rs)); 
            }
        } catch (Exception e) { 
            e.printStackTrace(); 
        }
        return list;
    }
    
    /**
     * Lấy bài đề xuất dựa trên các Category mà User đã tương tác nhiều nhất.
     */
    public List<Article> getRecommendedByInterest(long userId, long excludeId) {
        List<Article> list = new ArrayList<>();
        // Lấy Category mà user đã xem/like nhiều nhất từ bảng interactions
        String sql = "SELECT a.*, c.name AS category_name FROM articles a " +
                     "JOIN categories c ON a.category_id = c.id " +
                     "WHERE a.id != ? AND a.category_id = (" +
                     "  SELECT a2.category_id FROM interactions i " +
                     "  JOIN articles a2 ON i.article_id = a2.id " +
                     "  WHERE i.user_id = ? " +
                     "  GROUP BY a2.category_id ORDER BY COUNT(*) DESC LIMIT 1" + 
                     ") ORDER BY a.published_at DESC LIMIT 4";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, excludeId);
            ps.setLong(2, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapArticle(rs));
        } catch (Exception e) { e.printStackTrace(); }
        
        // Nếu user mới chưa có tương tác (list rỗng), lấy Random 4 bài
        if (list.isEmpty()) return getRecommendedArticles(4, excludeId); 
        return list;
    }

    public List<Article> searchArticles(String keyword, int limit) {
        List<Article> list = new ArrayList<>();
        String sql = "SELECT a.*, c.name AS category_name FROM articles a " +
                     "LEFT JOIN categories c ON a.category_id = c.id " +
                     "WHERE a.status = 'PUBLISHED' AND (a.title LIKE ? OR a.summary LIKE ?) " +
                     "ORDER BY a.published_at DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            String k = "%" + keyword + "%";
            ps.setString(1, k);
            ps.setString(2, k);
            ps.setInt(3, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapArticle(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
    
    public String handleReaction(long userId, long articleId, String type) {
        String resultStatus = "NONE";
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);

            String checkSql = "SELECT type FROM interactions WHERE user_id = ? AND article_id = ? AND type IN ('LIKE', 'DISLIKE')";
            
            try (PreparedStatement psCheck = conn.prepareStatement(checkSql)) {
                psCheck.setLong(1, userId);
                psCheck.setLong(2, articleId);
                ResultSet rs = psCheck.executeQuery();

                if (rs.next()) {
                    String oldType = rs.getString("type");
                    
                    if (oldType.equals(type)) {
                        // Bấm lại cái cũ -> Xóa interaction
                        executeSql(conn, "DELETE FROM interactions WHERE user_id = ? AND article_id = ? AND type = ?", userId, articleId, type);
                        updateCount(conn, articleId, type, -1);
                        resultStatus = "NONE";
                    } else {
                        // Đổi từ LIKE sang DISLIKE (hoặc ngược lại)
                        executeSql(conn, "UPDATE interactions SET type = ? WHERE user_id = ? AND article_id = ? AND type = ?", type, userId, articleId, oldType);
                        updateCount(conn, articleId, oldType, -1);
                        updateCount(conn, articleId, type, 1);
                        resultStatus = type;
                    }
                } else {
                        // Tương tác mới
                    executeSql(conn, "INSERT INTO interactions (user_id, article_id, type) VALUES (?, ?, ?)", userId, articleId, type);
                    updateCount(conn, articleId, type, 1);
                    resultStatus = type;
                }
            }
            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultStatus;
    }

    private void updateCount(Connection conn, long artId, String type, int value) throws SQLException {
        String column = type.equalsIgnoreCase("LIKE") ? "likes_count" : "dislikes_count";
        // Logic: Like +1 đồng thời popularity +5. Undo Like (value=-1) thì trừ lại.
        String sql = "UPDATE articles SET " + column + " = " + column + " + ?, popularity_score = popularity_score + ? WHERE id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, value);
            ps.setInt(2, type.equalsIgnoreCase("LIKE") ? (value * 5) : 0);
            ps.setLong(3, artId);
            ps.executeUpdate();
        }
    }

    private void executeSql(Connection conn, String sql, Object... params) throws SQLException {
        PreparedStatement ps = conn.prepareStatement(sql);
        for (int i = 0; i < params.length; i++) ps.setObject(i + 1, params[i]);
        ps.executeUpdate();
    }
    
    public String getUserReaction(long userId, long articleId) {
        String sql = "SELECT type FROM interactions WHERE user_id = ? AND article_id = ? AND type IN ('LIKE', 'DISLIKE')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ps.setLong(2, articleId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getString("type");
        } catch (Exception e) { e.printStackTrace(); }
        return "NONE";
    }
    
    public void incrementViewCount(long articleId, long userId) {
        String logSql = "INSERT INTO interactions (user_id, article_id, type) VALUES (?, ?, 'VIEW')";
        
        // 1. Cập nhật số view tổng và điểm phổ biến (+1)
        String updateSql = "UPDATE articles SET views = views + 1, popularity_score = popularity_score + 1 WHERE id = ?";
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false); // Dùng transaction để đảm bảo cả 2 cùng thành công
            
            try (PreparedStatement ps1 = conn.prepareStatement(updateSql)) {
                ps1.setLong(1, articleId);
                ps1.executeUpdate();
            }
            
            // 2. Ghi nhật ký vào bảng interactions (chỉ ghi nếu user đã đăng nhập)
            if (userId > 0) {
                try (PreparedStatement ps2 = conn.prepareStatement(logSql)) {
                    ps2.setLong(1, userId);
                    ps2.setLong(2, articleId);
                    ps2.executeUpdate();
                }
            }
            
            conn.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Article getArticleById(long id) {
        return getById(id);
    }

    // -- Admin Methods --
    public List<Article> getAllArticlesFiltered(int limit, int offset,
            String keyword, String status, Integer categoryId,
            String authorName, String sortBy, String sortDir) {
        // Whitelist sort columns
        java.util.Set<String> allowed = java.util.Set.of("a.created_at","a.views","a.title","a.status");
        String col = allowed.contains(sortBy) ? sortBy : "a.created_at";
        String dir = "ASC".equalsIgnoreCase(sortDir) ? "ASC" : "DESC";

        StringBuilder sql = new StringBuilder("""
                    SELECT a.id, a.title, a.content, a.summary, a.image_url,
                           a.author_id, a.approved_by, a.category_id, a.status, a.views, a.likes_count, a.dislikes_count,
                           a.popularity_score,
                           a.published_at, a.created_at,
                           c.name AS category_name,
                           u.full_name AS author_name,
                           u2.full_name AS reviewer_name
                    FROM articles a
                    LEFT JOIN categories c ON a.category_id = c.id
                    LEFT JOIN users u ON a.author_id = u.id
                    LEFT JOIN users u2 ON a.approved_by = u2.id
                    WHERE a.status != 'DRAFT'
                """);
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.isBlank()) {
            sql.append(" AND (a.title LIKE ? OR u.full_name LIKE ? OR CAST(a.id AS CHAR) LIKE ?)");
            String k = "%" + keyword.trim() + "%";
            params.add(k); params.add(k); params.add(k);
        }
        if (status != null && !status.isBlank()) {
            sql.append(" AND a.status = ?");
            params.add(status.trim());
        }
        if (categoryId != null && categoryId > 0) {
            sql.append(" AND a.category_id = ?");
            params.add(categoryId);
        }
        if (authorName != null && !authorName.isBlank()) {
            sql.append(" AND u.full_name LIKE ?");
            params.add("%" + authorName.trim() + "%");
        }

        sql.append(" ORDER BY " + col + " " + dir + " LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        List<Article> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Article a = mapArticle(rs);
                try { a.setAuthorName(rs.getString("author_name")); } catch(Exception e) {}
                try { a.setReviewerName(rs.getString("reviewer_name")); } catch(Exception e) {}
                list.add(a);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // Overload giữ tương thích ngược với code cũ
    public List<Article> getAllArticlesFiltered(int limit, int offset, String keyword, String status, Integer categoryId) {
        return getAllArticlesFiltered(limit, offset, keyword, status, categoryId, null, "a.created_at", "DESC");
    }

    public List<Article> getAllArticles(int limit, int offset) {
        return getAllArticlesFiltered(limit, offset, null, null, null);
    }

    public int getTotalArticleCount(String keyword, String status, Integer categoryId, String authorName) {
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) FROM articles a LEFT JOIN users u ON a.author_id = u.id WHERE a.status != 'DRAFT'");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.isBlank()) {
            sql.append(" AND (a.title LIKE ? OR u.full_name LIKE ?)");
            String k = "%" + keyword.trim() + "%";
            params.add(k); params.add(k);
        }
        if (status != null && !status.isBlank()) {
            sql.append(" AND a.status = ?");
            params.add(status.trim());
        }
        if (categoryId != null && categoryId > 0) {
            sql.append(" AND a.category_id = ?");
            params.add(categoryId);
        }
        if (authorName != null && !authorName.isBlank()) {
            sql.append(" AND u.full_name LIKE ?");
            params.add("%" + authorName.trim() + "%");
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public int getTotalArticleCount(String keyword, String status, Integer categoryId) {
        return getTotalArticleCount(keyword, status, categoryId, null);
    }


    public int getTotalArticleCount() {
        return getTotalArticleCount(null, null, null);
    }

    public List<Article> getArticlesByAuthor(long authorId) {
        return getArticlesByAuthorFiltered(authorId, "", "", "", "", "", 0, Integer.MAX_VALUE);
    }

    public int countArticlesByAuthorFiltered(long authorId,
                                              String keyword, String status,
                                              String category, String dateFrom, String dateTo) {
        StringBuilder sql = new StringBuilder("""
            SELECT COUNT(*) FROM articles a
            LEFT JOIN categories c ON a.category_id = c.id
            WHERE a.author_id = ?
        """);
        List<Object> params = new ArrayList<>();
        params.add(authorId);
        appendFilters(sql, params, keyword, status, category, dateFrom, dateTo);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public List<Article> getArticlesByAuthorFiltered(long authorId,
                                                      String keyword, String status,
                                                      String category, String dateFrom, String dateTo,
                                                      int offset, int limit) {
        StringBuilder sql = new StringBuilder("""
            SELECT a.id, a.title, a.content, a.summary, a.image_url,
                   a.author_id, a.approved_by, a.category_id, a.status, a.views, a.likes_count, a.dislikes_count,
                   a.popularity_score,
                   a.published_at, a.created_at,
                   c.name AS category_name
            FROM articles a
            LEFT JOIN categories c ON a.category_id = c.id
            WHERE a.author_id = ?
        """);
        List<Object> params = new ArrayList<>();
        params.add(authorId);
        appendFilters(sql, params, keyword, status, category, dateFrom, dateTo);
        sql.append(" ORDER BY a.created_at DESC LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        List<Article> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapArticle(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<String> getCategoriesByAuthor(long authorId) {
        List<String> list = new ArrayList<>();
        String sql = """
            SELECT DISTINCT c.name
            FROM articles a
            JOIN categories c ON a.category_id = c.id
            WHERE a.author_id = ?
            ORDER BY c.name
        """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, authorId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(rs.getString("name"));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public Article getById(long id) {
        String sql = """
            SELECT a.*, c.name AS category_name
            FROM articles a
            LEFT JOIN categories c ON a.category_id = c.id
            WHERE a.id = ?
        """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapArticle(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public long save(Article a) {
        String sql = """
            INSERT INTO articles
                (title, content, summary, image_url, author_id, category_id, status, published_at)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?)
        """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, a.getTitle());
            ps.setString(2, a.getContent());
            ps.setString(3, a.getSummary());
            ps.setString(4, a.getImageUrl());
            ps.setLong(5, a.getAuthorId());
            if (a.getCategoryId() > 0) ps.setInt(6, a.getCategoryId());
            else                       ps.setNull(6, Types.INTEGER);
            ps.setString(7, a.getStatus());
            if ("PUBLISHED".equals(a.getStatus()))
                ps.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
            else
                ps.setNull(8, Types.TIMESTAMP);
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) return keys.getLong(1);
        } catch (Exception e) { e.printStackTrace(); }
        return -1;
    }

    public boolean update(Article a) {
        String sql = """
            UPDATE articles
            SET title=?, content=?, summary=?, image_url=?, category_id=?, status=?,
                published_at = CASE WHEN ? = 'PUBLISHED' AND published_at IS NULL
                                    THEN NOW() ELSE published_at END
            WHERE id=? AND author_id=?
        """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, a.getTitle());
            ps.setString(2, a.getContent());
            ps.setString(3, a.getSummary());
            ps.setString(4, a.getImageUrl());
            if (a.getCategoryId() > 0) ps.setInt(5, a.getCategoryId());
            else                       ps.setNull(5, Types.INTEGER);
            ps.setString(6, a.getStatus());
            ps.setString(7, a.getStatus());
            ps.setLong(8, a.getId());
            ps.setLong(9, a.getAuthorId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    public boolean deleteArticleById(long articleId) {
        String sql = "DELETE FROM articles WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, articleId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    public java.util.Map<String, Integer> getArticleStatsByStatus() {
        java.util.Map<String, Integer> map = new java.util.LinkedHashMap<>();
        map.put("TOTAL", 0);
        map.put("PENDING", 0);
        map.put("PUBLISHED", 0);
        map.put("REJECTED", 0);
        map.put("ARCHIVED", 0);
        String sql = "SELECT status, COUNT(*) AS cnt FROM articles WHERE status != 'DRAFT' GROUP BY status";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            int total = 0;
            while (rs.next()) {
                String st = rs.getString("status");
                int cnt = rs.getInt("cnt");
                map.put(st, cnt);
                total += cnt;
            }
            map.put("TOTAL", total);
        } catch (Exception e) { e.printStackTrace(); }
        return map;
    }

    public boolean deleteArticle(long articleId, long authorId) {
        String sql = "DELETE FROM articles WHERE id = ? AND author_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, articleId);
            ps.setLong(2, authorId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    public long getAuthorIdByArticleId(long articleId) {
        String sql = "SELECT author_id FROM articles WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, articleId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getLong("author_id");
        } catch (Exception e) { e.printStackTrace(); }
        return -1;
    }

    public boolean updateArticleStatus(long articleId, String status) {
        return updateArticleStatus(articleId, status, null);
    }

    public boolean updateArticleStatus(long articleId, String status, Long approvedBy) {
        String sql = "UPDATE articles SET status = ?, approved_by = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            if (approvedBy != null) ps.setLong(2, approvedBy);
            else ps.setNull(2, java.sql.Types.BIGINT);
            ps.setLong(3, articleId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    public boolean updateArticleStatus(long articleId, long authorId, String status) {
        String sql = "UPDATE articles SET status = ? WHERE id = ? AND author_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setLong(2, articleId);
            ps.setLong(3, authorId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    public List<neuralnews.model.Category> getAllCategories() {
        List<neuralnews.model.Category> list = new ArrayList<>();
        String sql = "SELECT id, name FROM categories ORDER BY name";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                neuralnews.model.Category cat = new neuralnews.model.Category();
                cat.setId(rs.getInt("id"));
                cat.setName(rs.getString("name"));
                list.add(cat);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    // -- Profile Methods --

    /**
     * Đếm số bài viết user đã lưu (interactions loại SAVE).
     */
    public int countSavedByUser(long userId) {
        String sql = "SELECT COUNT(*) FROM interactions WHERE user_id = ? AND type = 'BOOKMARK'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    /**
     * Đếm số bài viết user đã đọc (interactions loại VIEW).
     */
    public int countReadByUser(long userId) {
        String sql = "SELECT COUNT(*) FROM interactions WHERE user_id = ? AND type = 'VIEW'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }


    public int getTotalSavedArticlesByUser(long userId) {
        String sql = "SELECT COUNT(*) FROM interactions WHERE user_id = ? AND type = 'BOOKMARK'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public int getTotalReadArticlesByUser(long userId) {
        String sql = "SELECT COUNT(DISTINCT article_id) FROM interactions WHERE user_id = ? AND type = 'VIEW'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public List<Article> getSavedArticlesByUser(long userId, int limit, int offset) {
        String sql = "SELECT a.*, c.name AS category_name FROM articles a " +
                     "JOIN interactions i ON a.id = i.article_id " +
                     "LEFT JOIN categories c ON a.category_id = c.id " +
                     "WHERE i.user_id = ? AND i.type = 'BOOKMARK' " +
                     "ORDER BY i.created_at DESC LIMIT ? OFFSET ?";
        List<Article> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ps.setInt(2, limit);
            ps.setInt(3, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapArticle(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<Article> getReadArticlesByUser(long userId, int limit, int offset) {
        String sql = "SELECT a.*, c.name AS category_name FROM articles a " +
                     "JOIN interactions i ON a.id = i.article_id " +
                     "LEFT JOIN categories c ON a.category_id = c.id " +
                     "WHERE i.user_id = ? AND i.type = 'VIEW' " +
                     "GROUP BY a.id, c.name, i.created_at " +
                     "ORDER BY i.created_at DESC LIMIT ? OFFSET ?";
        List<Article> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ps.setInt(2, limit);
            ps.setInt(3, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapArticle(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }


    /**
     * Lấy bài viết mới trong các chủ đề user quan tâm, dùng cho thông báo profile.
     * Trả về List<String[]> với mỗi phần tử: [message, timeAgo]
     */
    public List<String[]> getRecentArticlesForUser(long userId, int limit) {
        List<String[]> list = new ArrayList<>();
        String sql = """
            SELECT DISTINCT a.title,
                TIMESTAMPDIFF(HOUR, a.published_at, NOW()) AS hours_ago
            FROM articles a
            WHERE a.status = 'PUBLISHED'
              AND a.category_id IN (
                  SELECT DISTINCT a2.category_id
                  FROM interactions i
                  JOIN articles a2 ON i.article_id = a2.id
                  WHERE i.user_id = ?
              )
              AND a.published_at >= DATE_SUB(NOW(), INTERVAL 3 DAY)
            ORDER BY a.published_at DESC
            LIMIT ?
        """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ps.setInt(2, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String title = rs.getString("title");
                int hoursAgo = rs.getInt("hours_ago");
                String timeAgo = hoursAgo < 1 ? "Vừa xong"
                        : hoursAgo < 24 ? hoursAgo + " giờ trước"
                        : (hoursAgo / 24) + " ngày trước";
                list.add(new String[]{
                        "AI đề xuất bài viết mới: \u201c" + title + "\u201d",
                        timeAgo
                });
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }


    public boolean isBookmarked(long userId, long articleId) {
        String sql = "SELECT COUNT(*) FROM interactions WHERE user_id = ? AND article_id = ? AND type = 'BOOKMARK'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ps.setLong(2, articleId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean addBookmark(long userId, long articleId) {
        String sql = "INSERT INTO interactions (user_id, article_id, type) VALUES (?, ?, 'BOOKMARK')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ps.setLong(2, articleId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean removeBookmark(long userId, long articleId) {
        String sql = "DELETE FROM interactions WHERE user_id = ? AND article_id = ? AND type = 'BOOKMARK'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ps.setLong(2, articleId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean toggleBookmark(long userId, long articleId) {
        if (isBookmarked(userId, articleId)) {
            return removeBookmark(userId, articleId);
        } else {
            return addBookmark(userId, articleId);
        }
    }

    public boolean removeReadingHistory(long userId, long articleId) {
        String sql = "DELETE FROM interactions WHERE user_id = ? AND article_id = ? AND type = 'VIEW'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ps.setLong(2, articleId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }

    public boolean clearReadingHistory(long userId) {
        String sql = "DELETE FROM interactions WHERE user_id = ? AND type = 'VIEW'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); }
        return false;
    }


    // ── Helper: append filters ──────────────────────────────────────────
    private void appendFilters(StringBuilder sql, List<Object> params,
                                String keyword, String status,
                                String category, String dateFrom, String dateTo) {
        if (keyword != null && !keyword.isBlank()) {
            sql.append(" AND a.title LIKE ?");
            params.add("%" + keyword.trim() + "%");
        }
        if (status != null && !status.isBlank()) {
            sql.append(" AND a.status = ?");
            params.add(status.trim());
        }
        if (category != null && !category.isBlank()) {
            sql.append(" AND c.name = ?");
            params.add(category.trim());
        }
        if (dateFrom != null && !dateFrom.isBlank()) {
            sql.append(" AND DATE(a.created_at) >= ?");
            params.add(dateFrom.trim());
        }
        if (dateTo != null && !dateTo.isBlank()) {
            sql.append(" AND DATE(a.created_at) <= ?");
            params.add(dateTo.trim());
        }
    }

    public java.util.Map<String, Integer> getDailyTraffic(int days) {
        java.util.Map<String, Integer> stats = new java.util.LinkedHashMap<>();
        String sql = "SELECT DATE(created_at) as date, COUNT(*) as count " +
                     "FROM interactions " +
                     "WHERE type = 'VIEW' " +
                     "AND created_at >= DATE_SUB(CURDATE(), INTERVAL ? DAY) " +
                     "GROUP BY DATE(created_at) " +
                     "ORDER BY date ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, days);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                stats.put(rs.getString("date"), rs.getInt("count"));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return stats;
    }

    // ── Map ResultSet → Article ──────────────────────────────────────────
    private Article mapArticle(ResultSet rs) throws Exception {
        Article a = new Article();
        a.setId(rs.getLong("id"));
        a.setTitle(rs.getString("title"));
        a.setContent(rs.getString("content"));
        a.setSummary(rs.getString("summary"));
        a.setImageUrl(rs.getString("image_url"));
        a.setAuthorId(rs.getLong("author_id"));
        long ab = rs.getLong("approved_by");
        a.setApprovedBy(rs.wasNull() ? null : ab);
        a.setCategoryId(rs.getInt("category_id"));
        a.setStatus(rs.getString("status"));
        a.setViews(rs.getInt("views"));
        a.setLikesCount(rs.getInt("likes_count"));
        try { a.setDislikesCount(rs.getInt("dislikes_count")); } catch (Exception ignored) {}
        a.setPopularityScore(rs.getDouble("popularity_score"));
        a.setPublishedAt(rs.getTimestamp("published_at"));
        a.setCreatedAt(rs.getTimestamp("created_at"));
        a.setCategoryName(rs.getString("category_name"));
        return a;
    }
}
