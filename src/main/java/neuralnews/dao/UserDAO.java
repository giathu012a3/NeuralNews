package neuralnews.dao;

import neuralnews.model.User;
import neuralnews.model.Role;
import neuralnews.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object cho bảng `users`.
 */
public class UserDAO {

	/**
	 * Tìm user qua Email, trả về đầy đủ Role.
	 */
	public User findByEmail(String email) {
		User user = null;
		String sql = "SELECT u.id, u.email, u.password_hash, u.full_name, u.status, u.avatar_url, "
				+ "u.bio, u.experience_years, u.created_at, u.role_id, "
				+ "r.name as role_name, r.description as role_desc " + "FROM users u "
				+ "LEFT JOIN roles r ON u.role_id = r.id " + "WHERE u.email = ?";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

			stmt.setString(1, email);
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					user = mapUser(rs);
					user.setPasswordHash(rs.getString("password_hash")); // mapUser không map password
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return user;
	}

	/**
	 * Kiểm tra email đã tồn tại hay chưa.
	 */
	public boolean emailExists(String email) {
		return findByEmail(email) != null;
	}

	/**
	 * Tạo tài khoản mới, mặc định gán role_id = 1 (USER)
	 */
	public boolean createUser(User user) {
		String sql = "INSERT INTO users (email, password_hash, full_name, role_id, status) VALUES (?, ?, ?, 1, 'ACTIVE')";

		try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

			stmt.setString(1, user.getEmail());
			String hashedPassword = org.mindrot.jbcrypt.BCrypt.hashpw(user.getPasswordHash(),
					org.mindrot.jbcrypt.BCrypt.gensalt());
			stmt.setString(2, hashedPassword);
			stmt.setString(3, user.getFullName());

			int affectedRows = stmt.executeUpdate();
			return affectedRows > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	/**
	 * Xác minh mật khẩu người dùng nhập với hash lưu trong DB bằng BCrypt.
	 */
	public boolean verifyPassword(String rawPassword, String storedHash) {
		if (rawPassword == null || storedHash == null)
			return false;

		if (!storedHash.startsWith("$2a$")) {
			return rawPassword.equals(storedHash);
		}

		try {
			return org.mindrot.jbcrypt.BCrypt.checkpw(rawPassword, storedHash);
		} catch (Exception e) {
			return false;
		}
	}

	/**
	 * Lấy danh sách người dùng có bộ lọc và phân trang.
	 */
	public List<User> getAllUsersFiltered(String keyword, String role, String status, int limit, int offset) {
		List<User> list = new ArrayList<>();
		List<Object> params = new ArrayList<>();

		StringBuilder sql = new StringBuilder(
				"SELECT u.id, u.email, u.full_name, u.status, u.avatar_url, u.bio, u.experience_years, u.created_at, "
				+ "r.id as role_id, r.name as role_name, r.description as role_desc "
				+ "FROM users u "
				+ "LEFT JOIN roles r ON u.role_id = r.id "
				+ "WHERE 1=1"
		);

		if (keyword != null && !keyword.isBlank()) {
			sql.append(" AND (u.full_name LIKE ? OR u.email LIKE ?)");
			String k = "%" + keyword.trim() + "%";
			params.add(k);
			params.add(k);
		}
		if (role != null && !role.isBlank() && !"ALL".equals(role)) {
			sql.append(" AND r.name = ?");
			params.add(role.trim());
		}
		if (status != null && !status.isBlank() && !"ALL".equals(status)) {
			sql.append(" AND u.status = ?");
			params.add(status.trim());
		}

		sql.append(" ORDER BY u.created_at DESC LIMIT ? OFFSET ?");
		params.add(limit);
		params.add(offset);

		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql.toString())) {
			for (int i = 0; i < params.size(); i++) {
				ps.setObject(i + 1, params.get(i));
			}
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				list.add(mapUser(rs));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	/**
	 * Đếm tổng số người dùng theo bộ lọc (phục vụ phân trang).
	 */
	public int getTotalUserCount(String keyword, String role, String status) {
		StringBuilder sql = new StringBuilder(
				"SELECT COUNT(*) FROM users u "
				+ "LEFT JOIN roles r ON u.role_id = r.id "
				+ "WHERE 1=1"
		);
		List<Object> params = new ArrayList<>();

		if (keyword != null && !keyword.isBlank()) {
			sql.append(" AND (u.full_name LIKE ? OR u.email LIKE ?)");
			String k = "%" + keyword.trim() + "%";
			params.add(k); params.add(k);
		}
		if (role != null && !role.isBlank() && !"ALL".equals(role)) {
			sql.append(" AND r.name = ?");
			params.add(role.trim());
		}
		if (status != null && !status.isBlank() && !"ALL".equals(status)) {
			sql.append(" AND u.status = ?");
			params.add(status.trim());
		}

		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement ps = conn.prepareStatement(sql.toString())) {
			for (int i = 0; i < params.size(); i++) {
				ps.setObject(i + 1, params.get(i));
			}
			ResultSet rs = ps.executeQuery();
			if (rs.next()) return rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;
	}

	/**
	 * Cập nhật Role và Status của người dùng (dùng cho phê duyệt nhà báo).
	 */
	public boolean updateUserRoleAndStatus(long userId, int roleId, String status) {
		String sql = "UPDATE users SET role_id = ?, status = ? WHERE id = ?";
		try (Connection conn = DBConnection.getConnection(); 
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, roleId);
			ps.setString(2, status);
			ps.setLong(3, userId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	/**
	 * Xóa người dùng (hoặc từ chối đơn đăng ký).
	 */
	public boolean deleteUser(long userId) {
		String sql = "DELETE FROM users WHERE id = ?";
		try (Connection conn = DBConnection.getConnection(); 
			 PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setLong(1, userId);
			return ps.executeUpdate() > 0;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	/**
	 * Helper: Map ResultSet sang Object User.
	 */
	private User mapUser(ResultSet rs) throws SQLException {
		User user = new User();
		user.setId(rs.getLong("id"));
		user.setEmail(rs.getString("email"));
		user.setFullName(rs.getString("full_name"));
		user.setStatus(rs.getString("status"));
		user.setAvatarUrl(rs.getString("avatar_url"));
		user.setBio(rs.getString("bio"));
		user.setExperienceYears(rs.getInt("experience_years"));
		user.setCreatedAt(rs.getTimestamp("created_at"));

		int roleId = rs.getInt("role_id");
		if (!rs.wasNull()) {
			Role role = new Role();
			role.setId(roleId);
			role.setName(rs.getString("role_name"));
			role.setDescription(rs.getString("role_desc"));
			user.setRole(role);
		}
		return user;
	}
}
