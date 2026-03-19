package neuralnews.dao;

import neuralnews.model.Comment;
import neuralnews.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentDao {

    // ─────────────────────────────────────────────────────────────────────────
    // COUNT
    // ─────────────────────────────────────────────────────────────────────────

    public int countCommentsByAuthor(long authorId) {
        return countCommentsByAuthor(authorId, null);
    }

    public int countCommentsByAuthor(long authorId, String keyword) {
        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
        String sql = "SELECT COUNT(*) FROM comments c"
                   + " JOIN articles a ON c.article_id = a.id"
                   + " JOIN users u ON c.user_id = u.id"
                   + " WHERE a.author_id = ? AND c.parent_id IS NULL"
                   + (hasKeyword ? " AND (c.content LIKE ? OR u.full_name LIKE ? OR a.title LIKE ?)" : "");
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, authorId);
            if (hasKeyword) {
                String like = "%" + keyword.trim() + "%";
                ps.setString(2, like);
                ps.setString(3, like);
                ps.setString(4, like);
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int countCommentsByUser(long userId) {
        String sql = "SELECT COUNT(*) FROM comments WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // ─────────────────────────────────────────────────────────────────────────
    // GET LIST (phân trang + sort + keyword)
    // ─────────────────────────────────────────────────────────────────────────

    public List<Comment> getCommentsByAuthor(long authorId, int offset, int limit, String sort) {
        return getCommentsByAuthor(authorId, offset, limit, sort, null);
    }

    public List<Comment> getCommentsByAuthor(long authorId, int offset, int limit, String sort, String keyword) {
        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
        String orderBy = "oldest".equals(sort) ? "c.created_at ASC" : "c.created_at DESC";
        String sql = "SELECT c.id, c.content, c.status, c.created_at, c.parent_id,"
                   + " u.id AS user_id, u.full_name AS user_name,"
                   + " a.id AS article_id, a.title AS article_title"
                   + " FROM comments c"
                   + " JOIN users u ON c.user_id = u.id"
                   + " JOIN articles a ON c.article_id = a.id"
                   + " WHERE a.author_id = ? AND c.parent_id IS NULL"
                   + (hasKeyword ? " AND (c.content LIKE ? OR u.full_name LIKE ? OR a.title LIKE ?)" : "")
                   + " ORDER BY " + orderBy
                   + " LIMIT ? OFFSET ?";
        List<Comment> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            int idx = 1;
            ps.setLong(idx++, authorId);
            if (hasKeyword) {
                String like = "%" + keyword.trim() + "%";
                ps.setString(idx++, like);
                ps.setString(idx++, like);
                ps.setString(idx++, like);
            }
            ps.setInt(idx++, limit);
            ps.setInt(idx, offset);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ─────────────────────────────────────────────────────────────────────────
    // GET REPLIES
    // ─────────────────────────────────────────────────────────────────────────

    public List<Comment> getReplies(long parentId) {
        String sql = "SELECT c.id, c.content, c.status, c.created_at, c.parent_id,"
                   + " u.id AS user_id, u.full_name AS user_name,"
                   + " a.id AS article_id, a.title AS article_title"
                   + " FROM comments c"
                   + " JOIN users u ON c.user_id = u.id"
                   + " JOIN articles a ON c.article_id = a.id"
                   + " WHERE c.parent_id = ?"
                   + " ORDER BY c.created_at ASC";
        List<Comment> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, parentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ─────────────────────────────────────────────────────────────────────────
    // ADD REPLY
    // ─────────────────────────────────────────────────────────────────────────

    public boolean addReply(long articleId, long userId, long parentId, String content) {
        String sql = "INSERT INTO comments (content, article_id, user_id, parent_id, status) VALUES (?, ?, ?, ?, 'NEUTRAL')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, content);
            ps.setLong(2, articleId);
            ps.setLong(3, userId);
            ps.setLong(4, parentId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ─────────────────────────────────────────────────────────────────────────
    // DELETE / UPDATE STATUS
    // ─────────────────────────────────────────────────────────────────────────

    public boolean deleteComment(long commentId) {
        String sql = "DELETE FROM comments WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, commentId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateStatus(long commentId, String status) {
        String sql = "UPDATE comments SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setLong(2, commentId);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // ─────────────────────────────────────────────────────────────────────────
    // HELPER
    // ─────────────────────────────────────────────────────────────────────────

    private Comment mapRow(ResultSet rs) throws SQLException {
        Comment c = new Comment();
        c.setId(rs.getLong("id"));
        c.setContent(rs.getString("content"));
        c.setStatus(rs.getString("status"));
        c.setCreatedAt(rs.getTimestamp("created_at"));
        c.setUserId(rs.getLong("user_id"));
        c.setUserName(rs.getString("user_name"));
        c.setArticleId(rs.getLong("article_id"));
        c.setArticleTitle(rs.getString("article_title"));
        long parentId = rs.getLong("parent_id");
        if (!rs.wasNull()) c.setParentId(parentId);
        return c;
    }
}