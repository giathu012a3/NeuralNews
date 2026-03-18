package neuralnews.dao;

import neuralnews.model.Article;
import neuralnews.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ArticleDao {

    // ======================================================
    // CAC HAM CHO DOC GIA (VISITOR)
    // ======================================================

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

    public Article getFeaturedArticle() {
        List<Article> list = getArticlesCommon(1, 0, 0);
        return list.isEmpty() ? null : list.get(0);
    }

    public List<Article> getMostViewedArticles(int limit) {
        List<Article> list = new ArrayList<>();
        String sql = """
            SELECT a.*, c.name AS category_name FROM articles a 
            JOIN categories c ON a.category_id=c.id 
            WHERE a.status='PUBLISHED' ORDER BY a.views DESC LIMIT ?
        """;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapArticle(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public Article getArticleById(long id) {
        return getById(id);
    }

    // ── Lấy tất cả bài viết (Admin dùng) ───────────────────────────────────
    // ── Lấy tất cả bài viết có filter (Admin dùng) ──────────────────────────
    public List<Article> getAllArticlesFiltered(int limit, int offset, String keyword, String status, Integer categoryId) {
        StringBuilder sql = new StringBuilder("""
                    SELECT a.id, a.title, a.content, a.summary, a.image_url,
                           a.author_id, a.approved_by, a.category_id, a.status, a.views, a.likes_count, a.dislikes_count,
                           a.sentiment_label, a.source_score, a.popularity_score,
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

        sql.append(" ORDER BY a.created_at DESC LIMIT ? OFFSET ?");
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

    public List<Article> getAllArticles(int limit, int offset) {
        return getAllArticlesFiltered(limit, offset, null, null, null);
    }

    // ── Đếm tổng số bài viết (Admin dùng) ───────────────────────────────
    public int getTotalArticleCount(String keyword, String status, Integer categoryId) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM articles a WHERE a.status != 'DRAFT'");
        List<Object> params = new ArrayList<>();
        
        if (keyword != null && !keyword.isBlank()) {
            sql.append(" AND a.title LIKE ?");
            params.add("%" + keyword.trim() + "%");
        }
        if (status != null && !status.isBlank()) {
            sql.append(" AND a.status = ?");
            params.add(status.trim());
        }
        if (categoryId != null && categoryId > 0) {
            sql.append(" AND a.category_id = ?");
            params.add(categoryId);
        }

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    public int getTotalArticleCount() {
        return getTotalArticleCount(null, null, null);
    }

    // ── Lấy bài viết của một tác giả (Staff dùng) ──────────────────────────
    public List<Article> getArticlesByAuthor(long authorId) {
        return getArticlesByAuthorFiltered(authorId, "", "", "", "", "", 0, Integer.MAX_VALUE);
    }

    // ── Đếm tổng bài viết có filter (Staff dùng) ──────────────────────────
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

    // ── Lấy bài viết có filter + phân trang (Staff dùng) ──────────────────
    public List<Article> getArticlesByAuthorFiltered(long authorId,
                                                      String keyword, String status,
                                                      String category, String dateFrom, String dateTo,
                                                      int offset, int limit) {
        StringBuilder sql = new StringBuilder("""
            SELECT a.id, a.title, a.content, a.summary, a.image_url,
                   a.author_id, a.category_id, a.status, a.views, a.likes_count, a.dislikes_count,
                   a.sentiment_label, a.source_score, a.popularity_score,
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

    // ── Lấy danh sách danh mục của tác giả (Staff filter) ─────────────────
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

    // ── Lấy bài viết theo ID ──────────────────────────────────────────────
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

    // ── Tạo bài viết mới ─────────────────────────────────────────────────
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

    // ── Cập nhật bài viết ────────────────────────────────────────────────
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

    // ── Xóa bài viết (Chỉ tác giả) ──────────────────────────────────────
    public boolean deleteArticle(long articleId, long authorId) {
        String sql = "DELETE FROM articles WHERE id = ? AND author_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, articleId);
            ps.setLong(2, authorId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    // ── Cập nhật status (Admin) ──────────────────────────────────────────
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

    // ── Cập nhật status (Staff check author) ─────────────────────────────
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

    // ── Lấy tất cả danh mục ──────────────────────────────────────────────
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
        a.setSentimentLabel(rs.getString("sentiment_label"));
        a.setSourceScore(rs.getDouble("source_score"));
        a.setPopularityScore(rs.getDouble("popularity_score"));
        a.setPublishedAt(rs.getTimestamp("published_at"));
        a.setCreatedAt(rs.getTimestamp("created_at"));
        a.setCategoryName(rs.getString("category_name"));
        return a;
    }
}