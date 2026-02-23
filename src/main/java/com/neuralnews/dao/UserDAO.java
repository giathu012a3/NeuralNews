package com.neuralnews.dao;

import com.neuralnews.model.User;
import com.neuralnews.util.DBConnection;

import java.sql.*;

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
                + "r.name as role_name, r.description as role_desc "
                + "FROM users u "
                + "LEFT JOIN roles r ON u.role_id = r.id "
                + "WHERE u.email = ?";

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    user = new User();
                    user.setId(rs.getLong("id"));
                    user.setEmail(rs.getString("email"));
                    user.setPasswordHash(rs.getString("password_hash"));
                    user.setFullName(rs.getString("full_name"));
                    user.setStatus(rs.getString("status"));
                    user.setAvatarUrl(rs.getString("avatar_url"));
                    user.setBio(rs.getString("bio"));
                    user.setExperienceYears(rs.getInt("experience_years"));
                    user.setCreatedAt(rs.getTimestamp("created_at"));

                    // Set Role duy nhất
                    int roleId = rs.getInt("role_id");
                    if (!rs.wasNull()) {
                        com.neuralnews.model.Role role = new com.neuralnews.model.Role();
                        role.setId(roleId);
                        role.setName(rs.getString("role_name"));
                        role.setDescription(rs.getString("role_desc"));
                        user.setRole(role);
                    }
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

        try (Connection conn = DBConnection.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, user.getEmail());
            // Mã hóa mật khẩu bằng BCrypt
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

        // If the stored hash doesn't start with $2a$ (BCrypt prefix),
        // fallback to plain text comparison (for existing data like admin)
        if (!storedHash.startsWith("$2a$")) {
            return rawPassword.equals(storedHash);
        }

        try {
            return org.mindrot.jbcrypt.BCrypt.checkpw(rawPassword, storedHash);
        } catch (Exception e) {
            return false; // In case of invalid hash format
        }
    }
}
