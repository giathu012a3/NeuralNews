package neuralnews.dao;


import neuralnews.model.Article;
import neuralnews.model.Article_Model;
import neuralnews.model.Category_Model;
import neuralnews.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class Article_Dao {

    // ======================================================
    // CAC HAM CHO NGUOI DUNG (Dung Article_Model)
    // ======================================================

    public List<Article_Model> getArticlesCommon(int limit, int offset, int categoryId) {
        List<Article_Model> list = new ArrayList<>();
        String sql = "SELECT a.*, c.name AS category_name FROM articles a " +
                     "JOIN categories c ON a.category_id = c.id " +
                     "WHERE a.status='PUBLISHED' ";
        if (categoryId > 0) sql += "AND a.category_id=? ";
        sql += "ORDER BY a.published_at DESC LIMIT ?,?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            int i = 1;
            if (categoryId > 0) ps.setInt(i++, categoryId);
            ps.setInt(i++, offset);
            ps.setInt(i, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapArticleModel(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public Article_Model getFeaturedArticle() {
        List<Article_Model> list = getArticlesCommon(1, 0, 0);
        return list.isEmpty() ? null : list.get(0);
    }

    public List<Article_Model> getMostViewedArticles(int limit) {
        List<Article_Model> list = new ArrayList<>();
        String sql = "SELECT a.*, c.name AS category_name FROM articles a " +
                     "JOIN categories c ON a.category_id=c.id " +
                     "WHERE a.status='PUBLISHED' ORDER BY a.views DESC LIMIT ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, limit);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapArticleModel(rs));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public Article_Model getArticleById(long id) {
        String sql = "SELECT a.*,c.name AS category_name FROM articles a " +
                     "LEFT JOIN categories c ON a.category_id=c.id WHERE a.id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapArticleModel(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    private Article_Model mapArticleModel(ResultSet rs) throws Exception {
        Article_Model a = new Article_Model();
        a.setId(rs.getInt("id"));
        a.setTitle(rs.getString("title"));
        a.setSummary(rs.getString("summary"));
        a.setContent(rs.getString("content"));
        a.setImageUrl(rs.getString("image_url"));
        a.setViews(rs.getInt("views"));
        a.setCreatedAt(rs.getTimestamp("created_at"));
        a.setCategoryName(rs.getString("category_name"));
        return a;
    }

    // ======================================================
    // CAC HAM CHO NHA BAO (Dung Article)
    // ======================================================

    public List<Article> getArticlesByAuthorFiltered(long authorId, String keyword, String status, String category, String dateFrom, String dateTo, int offset, int limit) {
        StringBuilder sql = new StringBuilder("SELECT a.*, c.name AS category_name FROM articles a LEFT JOIN categories c ON a.category_id = c.id WHERE a.author_id = ?");
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
//
    public int countArticlesByAuthorFiltered(long authorId, String keyword, String status, String category, String dateFrom, String dateTo) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM articles a LEFT JOIN categories c ON a.category_id = c.id WHERE a.author_id = ?");
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
//
    public Article getById(long id) {
        String sql = "SELECT a.*, c.name AS category_name FROM articles a LEFT JOIN categories c ON a.category_id = c.id WHERE a.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapArticle(rs);
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    public long save(Article a) {
        String sql = "INSERT INTO articles(title, content, summary, image_url, author_id, category_id, status, published_at) VALUES(?,?,?,?,?,?,?,?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, a.getTitle());
            ps.setString(2, a.getContent());
            ps.setString(3, a.getSummary());
            ps.setString(4, a.getImageUrl());
            ps.setLong(5, a.getAuthorId());
            if (a.getCategoryId() > 0) ps.setInt(6, a.getCategoryId());
            else ps.setNull(6, Types.INTEGER);
            ps.setString(7, a.getStatus());
            if ("PUBLISHED".equals(a.getStatus())) ps.setTimestamp(8, new Timestamp(System.currentTimeMillis()));
            else ps.setNull(8, Types.TIMESTAMP);
            ps.executeUpdate();
            ResultSet keys = ps.getGeneratedKeys();
            if (keys.next()) return keys.getLong(1);
        } catch (Exception e) { e.printStackTrace(); }
        return -1;
    }
//
    public boolean update(Article a) {
        String sql = "UPDATE articles SET title=?, content=?, summary=?, image_url=?, category_id=?, status=?, " +
                     "published_at = CASE WHEN ?='PUBLISHED' AND published_at IS NULL THEN NOW() ELSE published_at END " +
                     "WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, a.getTitle());
            ps.setString(2, a.getContent());
            ps.setString(3, a.getSummary());
            ps.setString(4, a.getImageUrl());
            if (a.getCategoryId() > 0) ps.setInt(5, a.getCategoryId());
            else ps.setNull(5, Types.INTEGER);
            ps.setString(6, a.getStatus());
            ps.setString(7, a.getStatus());
            ps.setLong(8, a.getId());
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
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
//
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

    public List<String> getCategoriesByAuthor(long authorId) {
        List<String> list = new ArrayList<>();
        String sql = "SELECT DISTINCT c.name FROM articles a JOIN categories c ON a.category_id = c.id WHERE a.author_id = ? ORDER BY c.name";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, authorId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(rs.getString("name"));
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public List<neuralnews.model.Category> getAllCategories() {
        List<neuralnews.model.Category> list = new ArrayList<>();
        String sql = "SELECT id, name FROM categories ORDER BY name";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                neuralnews.model.Category c = new neuralnews.model.Category();
                c.setId(rs.getInt("id"));
                c.setName(rs.getString("name"));
                list.add(c);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
//
    private void appendFilters(StringBuilder sql, List<Object> params, String keyword, String status, String category, String dateFrom, String dateTo) {
        if (keyword != null && !keyword.isBlank()) { sql.append(" AND a.title LIKE ?"); params.add("%" + keyword.trim() + "%"); }
        if (status != null && !status.isBlank()) { sql.append(" AND a.status = ?"); params.add(status.trim()); }
        if (category != null && !category.isBlank()) { sql.append(" AND c.name = ?"); params.add(category.trim()); }
        if (dateFrom != null && !dateFrom.isBlank()) { sql.append(" AND DATE(a.created_at) >= ?"); params.add(dateFrom.trim()); }
        if (dateTo != null && !dateTo.isBlank()) { sql.append(" AND DATE(a.created_at) <= ?"); params.add(dateTo.trim()); }
    }
    private Article mapArticle(ResultSet rs) throws Exception {
        Article a = new Article();
        a.setId(rs.getLong("id"));
        a.setTitle(rs.getString("title"));
        a.setSummary(rs.getString("summary"));
        a.setContent(rs.getString("content"));
        a.setImageUrl(rs.getString("image_url"));
        a.setAuthorId(rs.getLong("author_id"));
        a.setCategoryId(rs.getInt("category_id"));
        a.setStatus(rs.getString("status"));
        a.setViews(rs.getInt("views"));
        a.setPublishedAt(rs.getTimestamp("published_at"));
        a.setCreatedAt(rs.getTimestamp("created_at"));
        a.setCategoryName(rs.getString("category_name"));
        return a;
    }
}
