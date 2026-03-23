package neuralnews.dao;

import neuralnews.model.Comment;
import neuralnews.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentDao {

    // COUNT METHODS

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

    // GET LIST (Staff views)

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

    // GET LIST (Public views)

    public List<Comment> getCommentsByArticle(long articleId, long currentUserId) {
        String sql = "SELECT c.*,"
                   + " u.id AS user_id, u.full_name AS user_name, u.avatar_url AS user_avatar,"
                   + " a.id AS article_id, a.title AS article_title,"
                   + " (SELECT COUNT(*) FROM comment_likes cl WHERE cl.comment_id = c.id AND cl.user_id = ?) > 0 AS is_liked_by_user"
                   + " FROM comments c"
                   + " JOIN users u ON c.user_id = u.id"
                   + " JOIN articles a ON c.article_id = a.id"
                   + " WHERE c.article_id = ? AND c.parent_id IS NULL AND c.status != 'HIDDEN'"
                   + " ORDER BY c.created_at DESC";
        List<Comment> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, currentUserId);
            ps.setLong(2, articleId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Comment c = mapRow(rs);
                c.setReplies(getReplies(c.getId(), currentUserId));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Comment> getReplies(long parentId, long currentUserId) {
        String sql = "SELECT c.*,"
                   + " u.id AS user_id, u.full_name AS user_name, u.avatar_url AS user_avatar,"
                   + " a.id AS article_id, a.title AS article_title,"
                   + " (SELECT COUNT(*) FROM comment_likes cl WHERE cl.comment_id = c.id AND cl.user_id = ?) > 0 AS is_liked_by_user"
                   + " FROM comments c"
                   + " JOIN users u ON c.user_id = u.id"
                   + " JOIN articles a ON c.article_id = a.id"
                   + " WHERE c.parent_id = ? AND c.status != 'HIDDEN'"
                   + " ORDER BY c.created_at ASC";
        List<Comment> list = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, currentUserId);
            ps.setLong(2, parentId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Comment c = mapRow(rs);
                c.setReplies(getReplies(c.getId(), currentUserId));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Lấy tất cả reply (bao gồm cả bị ẩn/spam) cho Dashboard quản lý
     */
    public List<Comment> getReplies(long parentId) {
        String sql = "SELECT c.*, u.full_name AS user_name, a.title AS article_title"
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
            while (rs.next()) {
                Comment c = mapRow(rs);
                c.setReplies(getReplies(c.getId()));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // ACTIONS (Add / Like)

    public boolean addComment(long articleId, long userId, Long parentId, String content) {
        String sql = "INSERT INTO comments (content, article_id, user_id, parent_id, status, likes_count) VALUES (?, ?, ?, ?, 'NEUTRAL', 0)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, content);
            ps.setLong(2, articleId);
            ps.setLong(3, userId);
            if (parentId != null) ps.setLong(4, parentId);
            else ps.setNull(4, Types.BIGINT);
            boolean ok = ps.executeUpdate() > 0;
            if (ok) {
                try (PreparedStatement ps2 = conn.prepareStatement(
                        "UPDATE articles SET popularity_score = popularity_score + 3 WHERE id = ?")) {
                    ps2.setLong(1, articleId);
                    ps2.executeUpdate();
                }
            }
            return ok;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public String toggleLikeComment(long commentId, long userId) {
        String checkSql = "SELECT 1 FROM comment_likes WHERE user_id = ? AND comment_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement psCheck = conn.prepareStatement(checkSql)) {
            psCheck.setLong(1, userId);
            psCheck.setLong(2, commentId);
            ResultSet rs = psCheck.executeQuery();
            if (rs.next()) {
                // Already liked, unlike it
                try (PreparedStatement psDel = conn.prepareStatement("DELETE FROM comment_likes WHERE user_id = ? AND comment_id = ?");
                     PreparedStatement psUpdate = conn.prepareStatement("UPDATE comments SET likes_count = GREATEST(likes_count - 1, 0) WHERE id = ?")) {
                    conn.setAutoCommit(false);
                    psDel.setLong(1, userId);
                    psDel.setLong(2, commentId);
                    psDel.executeUpdate();
                    
                    psUpdate.setLong(1, commentId);
                    psUpdate.executeUpdate();
                    
                    try (PreparedStatement psArticle = conn.prepareStatement(
                            "UPDATE articles SET popularity_score = GREATEST(popularity_score - 1, 0) WHERE id = " +
                            "(SELECT article_id FROM comments WHERE id = ?)")) {
                        psArticle.setLong(1, commentId);
                        psArticle.executeUpdate();
                    }
                    
                    conn.commit();
                    return "UNLIKED";
                }
            } else {
                // Not liked, like it
                try (PreparedStatement psIns = conn.prepareStatement("INSERT INTO comment_likes (user_id, comment_id) VALUES (?, ?)");
                     PreparedStatement psUpdate = conn.prepareStatement("UPDATE comments SET likes_count = likes_count + 1 WHERE id = ?")) {
                    conn.setAutoCommit(false);
                    psIns.setLong(1, userId);
                    psIns.setLong(2, commentId);
                    psIns.executeUpdate();
                    
                    psUpdate.setLong(1, commentId);
                    psUpdate.executeUpdate();

                    try (PreparedStatement psArticle = conn.prepareStatement(
                            "UPDATE articles SET popularity_score = popularity_score + 1 WHERE id = " +
                            "(SELECT article_id FROM comments WHERE id = ?)")) {
                        psArticle.setLong(1, commentId);
                        psArticle.executeUpdate();
                    }
                    
                    conn.commit();
                    return "LIKED";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR";
        }
    }

    // MANAGEMENT (Delete / Update)

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
            boolean ok = ps.executeUpdate() > 0;
            if (ok) {
                if ("HIDDEN".equals(status)) {
                    int hiddenCount = 1;
                    try (PreparedStatement countPs = conn.prepareStatement("SELECT COUNT(*) FROM comments WHERE parent_id = ? AND status != 'HIDDEN'")) {
                        countPs.setLong(1, commentId);
                        ResultSet countRs = countPs.executeQuery();
                        if (countRs.next()) {
                            hiddenCount += countRs.getInt(1);
                        }
                    }
                    
                    try (PreparedStatement scorePs = conn.prepareStatement(
                            "UPDATE articles SET popularity_score = GREATEST(popularity_score - ?, 0) WHERE id = " +
                            "(SELECT article_id FROM comments WHERE id = ?)")) {
                        scorePs.setInt(1, 3 * hiddenCount);
                        scorePs.setLong(2, commentId);
                        scorePs.executeUpdate();
                    }
                } else if ("ACTIVE".equals(status)) {
                    int restoreCount = 1;
                    try (PreparedStatement countPs = conn.prepareStatement("SELECT COUNT(*) FROM comments WHERE parent_id = ? AND status != 'HIDDEN'")) {
                        countPs.setLong(1, commentId);
                        ResultSet countRs = countPs.executeQuery();
                        if (countRs.next()) {
                            restoreCount += countRs.getInt(1);
                        }
                    }
                    
                    try (PreparedStatement scorePs = conn.prepareStatement(
                            "UPDATE articles SET popularity_score = popularity_score + ? WHERE id = " +
                            "(SELECT article_id FROM comments WHERE id = ?)")) {
                        scorePs.setInt(1, 3 * restoreCount);
                        scorePs.setLong(2, commentId);
                        scorePs.executeUpdate();
                    }
                }
            }
            return ok;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Comment getCommentById(long id) {
        String sql = "SELECT c.*, u.full_name as user_name, a.title as article_title "
                   + "FROM comments c "
                   + "JOIN users u ON c.user_id = u.id "
                   + "JOIN articles a ON c.article_id = a.id "
                   + "WHERE c.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // HELPER METHODS

    private Comment mapRow(ResultSet rs) throws SQLException {
        Comment c = new Comment();
        c.setId(rs.getLong("id"));
        c.setContent(rs.getString("content"));
        c.setStatus(rs.getString("status"));
        c.setCreatedAt(rs.getTimestamp("created_at"));
        c.setUserId(rs.getLong("user_id"));
        c.setUserName(rs.getString("user_name"));

        // Optional columns – safe fallback if not in SELECT
        try { c.setUserAvatar(rs.getString("user_avatar")); } catch (SQLException ignored) {}
        try { c.setLikesCount(rs.getInt("likes_count")); } catch (SQLException ignored) {}
        try { c.setLikedByUser(rs.getBoolean("is_liked_by_user")); } catch (SQLException ignored) {}

        c.setArticleId(rs.getLong("article_id"));
        c.setArticleTitle(rs.getString("article_title"));
        long parentId = rs.getLong("parent_id");
        if (!rs.wasNull()) c.setParentId(parentId);
        return c;
    }
}