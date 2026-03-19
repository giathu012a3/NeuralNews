package neuralnews.dao;

import neuralnews.model.User;
import neuralnews.model.Role;
import neuralnews.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Quản lý dữ liệu người dùng (CRUD, Thống kê, Lọc)
 */
public class UserDAO {

    /**
     * Tìm người dùng qua Email (kèm theo Vai trò)
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
                    user.setPasswordHash(rs.getString("password_hash"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean emailExists(String email) {
        return findByEmail(email) != null;
    }

    public boolean createUser(User user) {
        return createUserWithRole(user, 1);
    }

    /**
     * Tạo tài khoản mới với vai trò chỉ định
     */
    public boolean createUserWithRole(User user, int roleId) {
        String sql = "INSERT INTO users (email, password_hash, full_name, role_id, status) VALUES (?, ?, ?, ?, 'ACTIVE')";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getEmail());
            String hashedPassword = org.mindrot.jbcrypt.BCrypt.hashpw(user.getPasswordHash(),
                    org.mindrot.jbcrypt.BCrypt.gensalt());
            stmt.setString(2, hashedPassword);
            stmt.setString(3, user.getFullName());
            stmt.setInt(4, roleId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Đăng ký tài khoản Nhà báo (Chờ duyệt)
     */
    public boolean createJournalist(User user) {
        String sql = "INSERT INTO users (email, password_hash, full_name, role_id, status, bio, experience_years) VALUES (?, ?, ?, 2, 'PENDING', ?, ?)";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getEmail());
            String hashedPassword = org.mindrot.jbcrypt.BCrypt.hashpw(user.getPasswordHash(),
                    org.mindrot.jbcrypt.BCrypt.gensalt());
            stmt.setString(2, hashedPassword);
            stmt.setString(3, user.getFullName());
            stmt.setString(4, user.getBio());
            stmt.setInt(5, user.getExperienceYears());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * Xác thực mật khẩu với BCrypt
     */
    public boolean verifyPassword(String rawPassword, String storedHash) {
        if (rawPassword == null || storedHash == null) return false;
        if (!storedHash.startsWith("$2a$")) return rawPassword.equals(storedHash);
        try {
            return org.mindrot.jbcrypt.BCrypt.checkpw(rawPassword, storedHash);
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * Lấy thống kê số lượng người dùng theo trạng thái
     */
    public Map<String, Integer> getUserStats() {
        Map<String, Integer> stats = new HashMap<>();
        String sql = "SELECT status, COUNT(*) as count FROM users GROUP BY status";
        int total = 0;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String status = rs.getString("status");
                int count = rs.getInt("count");
                stats.put(status, count);
                total += count;
            }
            stats.put("TOTAL", total);
        } catch (SQLException e) { e.printStackTrace(); }
        return stats;
    }

    /**
     * Lấy danh sách người dùng có lọc, sắp xếp và phân trang
     */
    public List<User> getAllUsersFiltered(String keyword, String role, String status, String sortBy, String sortDir, int limit, int offset) {
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

        // Sắp xếp
        String sortCol = "u.created_at";
        if ("name".equals(sortBy)) sortCol = "u.full_name";
        else if ("role".equals(sortBy)) sortCol = "r.name";
        else if ("email".equals(sortBy)) sortCol = "u.email";
        
        String dir = "DESC".equalsIgnoreCase(sortDir) ? "DESC" : "ASC";
        sql.append(" ORDER BY ").append(sortCol).append(" ").append(dir);
        
        sql.append(" LIMIT ? OFFSET ?");
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
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

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
        } catch (SQLException e) { e.printStackTrace(); }
        return 0;
    }

    public boolean updateUserRoleAndStatus(long userId, int roleId, String status) {
        String sql = "UPDATE users SET role_id = ?, status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roleId);
            ps.setString(2, status);
            ps.setLong(3, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public boolean updateUserStatus(long userId, String status) {
        String sql = "UPDATE users SET status = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setLong(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public boolean resetPassword(long userId, String newPassword) {
        String sql = "UPDATE users SET password_hash = ? WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            String hashedPassword = org.mindrot.jbcrypt.BCrypt.hashpw(newPassword,
                    org.mindrot.jbcrypt.BCrypt.gensalt());
            ps.setString(1, hashedPassword);
            ps.setLong(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public boolean updateJournalistApplication(long userId, String bio, int experienceYears) {
        String sql = "UPDATE users SET bio = ?, experience_years = ?, status = 'PENDING' WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, bio);
            ps.setInt(2, experienceYears);
            ps.setLong(3, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    public boolean deleteUser(long userId) {
        String sql = "UPDATE users SET status = 'DELETED' WHERE id = ?";
        try (Connection conn = DBConnection.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

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
