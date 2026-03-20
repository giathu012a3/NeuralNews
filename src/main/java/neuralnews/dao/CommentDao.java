package neuralnews.dao;

import neuralnews.model.Comment;
import neuralnews.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentDao {
	
	// --- GIỮ LẠI BẢN NÀY (BẢN CHUẨN) ---
	// Thêm tham số userId vào hàm này
	public List<Comment> getCommentsByArticle(long articleId, long userId) {
	    List<Comment> list = new ArrayList<>();
	    String sql = "SELECT c.*, u.full_name, u.avatar_url, " +
	                "(SELECT COUNT(*) FROM comment_likes cl WHERE cl.comment_id = c.id AND cl.user_id = ?) as is_liked " +
	                "FROM comments c " +
	                "JOIN users u ON c.user_id = u.id " +
	                "WHERE c.article_id = ? AND c.status = 'NEUTRAL' ORDER BY c.created_at DESC";

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        
	        ps.setLong(1, userId); 
	        ps.setLong(2, articleId);
	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            Comment c = new Comment();
	            c.setId(rs.getLong("id"));
	            c.setContent(rs.getString("content"));
	            c.setLikesCount(rs.getInt("likes_count"));
	            c.setParentId(rs.getLong("parent_id"));
	            c.setUserName(rs.getString("full_name"));
	            c.setUserAvatar(rs.getString("avatar_url"));
	            c.setCreatedAt(rs.getTimestamp("created_at"));
	            
	            // --- DÒNG QUAN TRỌNG NHẤT ĐÂY NÈ THỊNH ---
	            c.setUserId(rs.getLong("user_id")); 
	            // ----------------------------------------

	            c.setLikedByUser(rs.getInt("is_liked") > 0); 
	            list.add(c);
	        }
	    } catch (Exception e) { e.printStackTrace(); }
	    return list;
	}

	// Hàm addComment giữ nguyên
	public boolean addComment(Comment c) {
	    // Thêm parent_id vào câu SQL
	    String sql = "INSERT INTO comments (content, article_id, user_id, parent_id, status, created_at) " +
	                 "VALUES (?, ?, ?, ?, 'NEUTRAL', NOW())";
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setString(1, c.getContent());
	        ps.setLong(2, c.getArticleId());
	        ps.setLong(3, c.getUserId());
	        
	        // Nếu là cmt gốc thì parentId = 0, nếu là reply thì dùng parentId thật
	        if (c.getParentId() > 0) {
	            ps.setLong(4, c.getParentId());
	        } else {
	            ps.setNull(4, java.sql.Types.INTEGER);
	        }
	        
	        return ps.executeUpdate() > 0;
	    } catch (Exception e) { 
	        e.printStackTrace(); 
	        return false; 
	    }
	}

	public String toggleLike(long userId, long commentId) {
	    Connection conn = null;
	    try {
	        conn = DBConnection.getConnection();
	        conn.setAutoCommit(false); 

	        String checkSql = "SELECT 1 FROM comment_likes WHERE user_id = ? AND comment_id = ?";
	        PreparedStatement psCheck = conn.prepareStatement(checkSql);
	        psCheck.setLong(1, userId);
	        psCheck.setLong(2, commentId);
	        ResultSet rs = psCheck.executeQuery();

	        if (rs.next()) {
	            // ĐÃ LIKE -> BỎ LIKE
	            String deleteLike = "DELETE FROM comment_likes WHERE user_id = ? AND comment_id = ?";
	            PreparedStatement psDel = conn.prepareStatement(deleteLike);
	            psDel.setLong(1, userId);
	            psDel.setLong(2, commentId);
	            psDel.executeUpdate();

	            String descLike = "UPDATE comments SET likes_count = GREATEST(0, likes_count - 1) WHERE id = ?";
	            PreparedStatement psUpdate = conn.prepareStatement(descLike);
	            psUpdate.setLong(1, commentId);
	            psUpdate.executeUpdate();

	            conn.commit();
	            return "UNLIKED";
	        } else {
	            // CHƯA LIKE -> THÊM LIKE
	            String insertLike = "INSERT INTO comment_likes (user_id, comment_id) VALUES (?, ?)";
	            PreparedStatement psIns = conn.prepareStatement(insertLike);
	            psIns.setLong(1, userId);
	            psIns.setLong(2, commentId);
	            psIns.executeUpdate();

	            String incLike = "UPDATE comments SET likes_count = likes_count + 1 WHERE id = ?";
	            PreparedStatement psUpdate = conn.prepareStatement(incLike);
	            psUpdate.setLong(1, commentId);
	            psUpdate.executeUpdate();

	            conn.commit();
	            return "LIKED";
	        }
	    } catch (Exception e) {
	        try { if(conn != null) conn.rollback(); } catch(Exception ex) {}
	        e.printStackTrace();
	        return "ERROR";
	    } finally {
	        try { if(conn != null) conn.close(); } catch(Exception ex) {}
	    }
	}

	// Thêm hàm này để lấy số like mới nhất trả về cho AJAX
	public int getCommentLikeCount(long commentId) {
	    String sql = "SELECT likes_count FROM comments WHERE id = ?";
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setLong(1, commentId);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) return rs.getInt("likes_count");
	    } catch (Exception e) {}
	    return 0;
	}
	
	public boolean softDeleteComment(long commentId, long userId) {
	    // Cập nhật status thành 'DELETED' thay vì xóa hẳn
	    String sql = "UPDATE comments SET status = 'DELETED' WHERE id = ? AND user_id = ?";
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setLong(1, commentId);
	        ps.setLong(2, userId);
	        return ps.executeUpdate() > 0;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}
	
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

    public Comment getCommentById(long id) {
        String sql = "SELECT c.*, u.full_name as user_name, a.title as article_title " +
                     "FROM comments c " +
                     "JOIN users u ON c.user_id = u.id " +
                     "JOIN articles a ON c.article_id = a.id " +
                     "WHERE c.id = ?";
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