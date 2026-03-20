package neuralnews.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.List;
import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import neuralnews.model.Report;
import neuralnews.util.DBConnection;

public class ReportDao {

    public int countPendingReports() {
        String sql = "SELECT COUNT(*) FROM reports WHERE status = 'PENDING'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Report> getAllReports(String targetType, String statusFilter) {
        List<Report> reports = new ArrayList<>();
        boolean isArticle = "ARTICLE".equals(targetType);
        
        String sql = "SELECT MIN(r.id) as id, r.target_id, r.target_type, MAX(r.status) as status, COUNT(*) as reportCount, " +
                     "GROUP_CONCAT(DISTINCT r.reason ORDER BY r.created_at DESC SEPARATOR ', ') as combined_reasons, " +
                     "MAX(r.created_at) as last_report_at, MAX(r.problematic_snippet) as problematic_snippet, " +
                     "GROUP_CONCAT(DISTINCT r.details ORDER BY r.created_at DESC SEPARATOR '|||') as combined_details, " +
                     "(SELECT r2.reporter_id FROM reports r2 WHERE r2.target_id = r.target_id AND r2.target_type = ? AND r2.status = ? ORDER BY r2.created_at DESC LIMIT 1) as reporter_id, " +
                     "(SELECT u2.full_name FROM reports r2 LEFT JOIN users u2 ON r2.reporter_id = u2.id WHERE r2.target_id = r.target_id AND r2.target_type = ? AND r2.status = ? ORDER BY r2.created_at DESC LIMIT 1) as reporter_name ";

        if (isArticle) {
            sql += ", a.title as target_title, author_a.full_name as author_name, cat_a.name as section_info " +
                   "FROM reports r LEFT JOIN articles a ON r.target_id = a.id " +
                   "LEFT JOIN users author_a ON a.author_id = author_a.id " +
                   "LEFT JOIN categories cat_a ON a.category_id = cat_a.id ";
        } else {
            sql += ", CONCAT('Comment: ', LEFT(c_t.content, 30), '...') as target_title, author_c.full_name as author_name, CONCAT('On: ', a_c.title) as section_info " +
                   "FROM reports r LEFT JOIN comments c_t ON r.target_id = c_t.id " +
                   "LEFT JOIN users author_c ON c_t.user_id = author_c.id " +
                   "LEFT JOIN articles a_c ON c_t.article_id = a_c.id ";
        }

        sql += "WHERE r.target_type = ? AND r.status = ? GROUP BY r.target_id, r.target_type ORDER BY reportCount DESC, last_report_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, targetType);
            ps.setString(2, statusFilter);
            ps.setString(3, targetType);
            ps.setString(4, statusFilter);
            ps.setString(5, targetType);
            ps.setString(6, statusFilter);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                reports.add(mapResultSetToReport(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reports;
    }

    public boolean updateReportStatus(long reportId, String status) {
        Report r = getReportById(reportId);
        if (r == null) return false;
        
        String sql = "UPDATE reports SET status = ? WHERE target_id = ? AND target_type = ? AND status = 'PENDING'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setLong(2, r.getTargetId());
            ps.setString(3, r.getTargetType());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public Report getReportById(long id) {
        String targetType = null;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement("SELECT target_type FROM reports WHERE id = ?")) {
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) targetType = rs.getString("target_type");
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        if (targetType == null) return null;

        String sql = "SELECT r.*, u.full_name as reporter_name, " +
                     "(SELECT GROUP_CONCAT(DISTINCT r2.details ORDER BY r2.created_at DESC SEPARATOR '|||') FROM reports r2 WHERE r2.target_id = r.target_id AND r2.target_type = r.target_type AND r2.status = r.status) as combined_details, " +
                     "(SELECT GROUP_CONCAT(DISTINCT r2.reason ORDER BY r2.created_at DESC SEPARATOR ', ') FROM reports r2 WHERE r2.target_id = r.target_id AND r2.target_type = r.target_type AND r2.status = r.status) as combined_reasons, " +
                     "(SELECT COUNT(*) FROM reports r2 WHERE r2.target_id = r.target_id AND r2.target_type = r.target_type AND r2.status = r.status) as reportCount ";
        
        if ("ARTICLE".equals(targetType)) {
            sql += ", a.title as target_title, author.full_name as author_name, cat.name as section_info " +
                   "FROM reports r LEFT JOIN users u ON r.reporter_id = u.id " +
                   "LEFT JOIN articles a ON r.target_id = a.id " +
                   "LEFT JOIN users author ON a.author_id = author.id " +
                   "LEFT JOIN categories cat ON a.category_id = cat.id ";
        } else {
            sql += ", CONCAT('Comment: ', LEFT(c.content, 30), '...') as target_title, author.full_name as author_name, CONCAT('On: ', a.title) as section_info " +
                   "FROM reports r LEFT JOIN users u ON r.reporter_id = u.id " +
                   "LEFT JOIN comments c ON r.target_id = c.id " +
                   "LEFT JOIN users author ON c.user_id = author.id " +
                   "LEFT JOIN articles a ON c.article_id = a.id ";
        }
        
        sql += "WHERE r.id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToReport(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean createReport(String targetType, long targetId, long reporterId, String reason, String details, 
                               String snippet) {
        return createReport(targetType, targetId, reporterId, reason, details, "PENDING", 0, 0, 0, snippet);
    }

    public boolean createReport(String targetType, long targetId, long reporterId, String reason, String details, 
                               String status, int confidence, int severity, int toxicity, String snippet) {
        String sql = "INSERT INTO reports (target_type, target_id, reporter_id, reason, details, status, " +
                     "problematic_snippet) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, targetType);
            ps.setLong(2, targetId);
            ps.setLong(3, reporterId);
            ps.setString(4, reason);
            ps.setString(5, details);
            ps.setString(6, status);
            ps.setString(7, snippet);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Report mapResultSetToReport(ResultSet rs) throws SQLException {
        Report r = new Report();
        r.setId(rs.getLong("id"));
        r.setTargetType(rs.getString("target_type"));
        r.setTargetId(rs.getLong("target_id"));
        
        r.setReporterId(getOptionalLong(rs, "reporter_id"));
        r.setReporterName(getOptionalString(rs, "reporter_name"));
        r.setReporterTrust(95); 
        
        r.setTargetTitle(getOptionalString(rs, "target_title"));
        r.setAuthorName(getOptionalString(rs, "author_name"));
        r.setSection(getOptionalString(rs, "section_info"));
        
        String reason = getOptionalString(rs, "combined_reasons");
        if (reason == null) reason = getOptionalString(rs, "reason");
        r.setReason(reason);
        
        r.setDetails(getOptionalString(rs, "combined_details"));
        r.setStatus(getOptionalString(rs, "status"));
        r.setProblematicSnippet(getOptionalString(rs, "problematic_snippet"));
        
        // Aggregated fields
        try {
            int count = rs.getInt("reportCount");
            if (!rs.wasNull()) r.setReportCount(count);
            
            Timestamp ts = rs.getTimestamp("last_report_at");
            if (ts != null) r.setCreatedAt(ts);
            else r.setCreatedAt(rs.getTimestamp("created_at"));
        } catch (SQLException ignored) {
            try {
                r.setCreatedAt(rs.getTimestamp("created_at"));
            } catch (SQLException ignored2) {}
        }
        
        return r;
    }

    private String getOptionalString(ResultSet rs, String col) {
        try { return rs.getString(col); } catch (SQLException e) { return null; }
    }

    private Long getOptionalLong(ResultSet rs, String col) {
        try { 
            long val = rs.getLong(col);
            return rs.wasNull() ? null : val;
        } catch (SQLException e) { return null; }
    }

    private int getOptionalInt(ResultSet rs, String col, int dflt) {
        try {
            int val = rs.getInt(col);
            return rs.wasNull() ? dflt : val;
        } catch (SQLException e) { return dflt; }
    }
}
