package neuralnews.dao;

import neuralnews.model.Article;
import neuralnews.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ArticleDao {

    // ── Existing method (kept) ────────────────────────────────────────────
    public List<Article> getArticlesByAuthor(long authorId) {
        return getArticlesByAuthorFiltered(authorId, "", "", "", "", "", 0, Integer.MAX_VALUE);
    }

    // ── Đếm tổng bài viết có filter ──────────────────────────────────────
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

    // ── Lấy bài viết có filter + phân trang ──────────────────────────────
    public List<Article> getArticlesByAuthorFiltered(long authorId,
                                                      String keyword, String status,
                                                      String category, String dateFrom, String dateTo,
                                                      int offset, int limit) {
        StringBuilder sql = new StringBuilder("""
            SELECT a.id, a.title, a.content, a.summary, a.image_url,
                   a.author_id, a.category_id, a.status, a.views, a.likes_count,
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

    // ── Lấy danh sách category name của author (dùng cho filter dropdown) ─
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

    // ── Lấy tất cả categories (cho create_article dropdown) ──────────────
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

    /**
     * Xóa bài viết. Chỉ author mới được xóa.
     */
    public boolean deleteArticle(long articleId, long authorId) {
        String sql = "DELETE FROM articles WHERE id = ? AND author_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, articleId);
            ps.setLong(2, authorId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    }

    /**
     * Cập nhật status bài viết. Chỉ author mới được đổi.
     */
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

    // ── Helper: append WHERE filters động ───────────────────────────────
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

    // ── Map ResultSet → Article ───────────────────────────────────────────
    private Article mapArticle(ResultSet rs) throws Exception {
        Article a = new Article();
        a.setId(rs.getLong("id"));
        a.setTitle(rs.getString("title"));
        a.setContent(rs.getString("content"));
        a.setSummary(rs.getString("summary"));
        a.setImageUrl(rs.getString("image_url"));
        a.setAuthorId(rs.getLong("author_id"));
        a.setCategoryId(rs.getInt("category_id"));
        a.setStatus(rs.getString("status"));
        a.setViews(rs.getInt("views"));
        a.setLikesCount(rs.getInt("likes_count"));
        a.setSentimentLabel(rs.getString("sentiment_label"));
        a.setSourceScore(rs.getDouble("source_score"));
        a.setPopularityScore(rs.getDouble("popularity_score"));
        a.setPublishedAt(rs.getTimestamp("published_at"));
        a.setCreatedAt(rs.getTimestamp("created_at"));
        a.setCategoryName(rs.getString("category_name"));
        return a;
    }
}