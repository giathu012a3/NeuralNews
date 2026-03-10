package neuralnews.dao;

import neuralnews.model.Article;
import neuralnews.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ArticleDao {

    // ── Giữ lại method gốc (không phân trang) ────────────────────────────
    public List<Article> getArticlesByAuthor(long authorId) {
        return getArticlesByAuthorFiltered(authorId, null, null, null, null, null, 0, Integer.MAX_VALUE);
    }

    // ── Đếm tổng bài thoả điều kiện ──────────────────────────────────────
    public int countArticlesByAuthorFiltered(long authorId,
                                             String keyword, String status,
                                             String category, String dateFrom, String dateTo) {
        StringBuilder sql = new StringBuilder(
            "SELECT COUNT(*) FROM articles a " +
            "LEFT JOIN categories c ON a.category_id = c.id " +
            "WHERE a.author_id = ?"
        );
        List<Object> params = new ArrayList<>();
        params.add(authorId);
        appendFilters(sql, params, keyword, status, category, dateFrom, dateTo);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = build(conn, sql.toString(), params);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ── Lấy bài viết có phân trang + lọc ─────────────────────────────────
    public List<Article> getArticlesByAuthorFiltered(long authorId,
                                                     String keyword, String status,
                                                     String category, String dateFrom, String dateTo,
                                                     int offset, int limit) {
        List<Article> list = new ArrayList<>();

        StringBuilder sql = new StringBuilder(
            "SELECT a.id, a.title, a.content, a.summary, a.image_url, " +
            "       a.author_id, a.category_id, a.status, a.views, a.likes_count, " +
            "       a.sentiment_label, a.source_score, a.popularity_score, " +
            "       a.published_at, a.created_at, c.name AS category_name " +
            "FROM articles a " +
            "LEFT JOIN categories c ON a.category_id = c.id " +
            "WHERE a.author_id = ?"
        );
        List<Object> params = new ArrayList<>();
        params.add(authorId);
        appendFilters(sql, params, keyword, status, category, dateFrom, dateTo);
        sql.append(" ORDER BY a.created_at DESC LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = build(conn, sql.toString(), params);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
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
                list.add(a);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ── Danh mục của tác giả (cho dropdown filter) ────────────────────────
    public List<String> getCategoriesByAuthor(long authorId) {
        List<String> cats = new ArrayList<>();
        String sql = "SELECT DISTINCT c.name FROM articles a " +
                     "JOIN categories c ON a.category_id = c.id " +
                     "WHERE a.author_id = ? ORDER BY c.name";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, authorId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) cats.add(rs.getString("name"));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cats;
    }

    // ── Helper: WHERE động ────────────────────────────────────────────────
    private void appendFilters(StringBuilder sql, List<Object> params,
                                String keyword, String status,
                                String category, String dateFrom, String dateTo) {
        if (keyword != null && !keyword.isBlank()) {
            sql.append(" AND (a.title LIKE ? OR a.summary LIKE ?)");
            String like = "%" + keyword.trim() + "%";
            params.add(like);
            params.add(like);
        }
        if (status != null && !status.isBlank() && !status.equals("ALL")) {
            sql.append(" AND a.status = ?");
            params.add(status.trim());
        }
        if (category != null && !category.isBlank() && !category.equals("ALL")) {
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

    // ── Helper: bind params ───────────────────────────────────────────────
    private PreparedStatement build(Connection conn, String sql, List<Object> params)
            throws SQLException {
        PreparedStatement ps = conn.prepareStatement(sql);
        for (int i = 0; i < params.size(); i++) ps.setObject(i + 1, params.get(i));
        return ps;
    }
}