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

    public List<Report> getAllReports(String targetType, String statusFilter) {
        List<Report> reports = new ArrayList<>();
        String sql = "SELECT " +
                     "  MIN(r.id) as id, " +
                     "  r.target_id, " +
                     "  r.target_type, " +
                     "  MAX(r.status) as status, " +
                     "  COUNT(*) as reportCount, " +
                     "  GROUP_CONCAT(DISTINCT r.reason ORDER BY r.created_at DESC SEPARATOR ', ') as combined_reasons, " +
                     "  MAX(r.created_at) as last_report_at, " +
                     "  MAX(r.problematic_snippet) as problematic_snippet, " +
                     "  GROUP_CONCAT(DISTINCT r.details ORDER BY r.created_at DESC SEPARATOR '|||') as combined_details, " +
                     "  (SELECT r2.reporter_id FROM reports r2 WHERE r2.target_id = r.target_id AND r2.target_type = r.target_type AND r2.status = ? ORDER BY r2.created_at DESC LIMIT 1) as reporter_id, " +
                     "  (SELECT u2.full_name FROM reports r2 LEFT JOIN users u2 ON r2.reporter_id = u2.id WHERE r2.target_id = r.target_id AND r2.target_type = r.target_type AND r2.status = ? ORDER BY r2.created_at DESC LIMIT 1) as reporter_name, " +
                     "  CASE WHEN r.target_type = 'ARTICLE' THEN a.title ELSE CONCAT('Comment: ', LEFT(c_t.content, 30), '...') END as target_title, " +
                     "  CASE WHEN r.target_type = 'ARTICLE' THEN author_a.full_name ELSE author_c.full_name END as author_name, " +
                     "  CASE WHEN r.target_type = 'ARTICLE' THEN cat_a.name ELSE CONCAT('On: ', a_c.title) END as section_info " +
                     "FROM reports r " +
                     "LEFT JOIN articles a ON r.target_id = a.id AND r.target_type = 'ARTICLE' " +
                     "LEFT JOIN users author_a ON a.author_id = author_a.id " +
                     "LEFT JOIN categories cat_a ON a.category_id = cat_a.id " +
                     "LEFT JOIN comments c_t ON r.target_id = c_t.id AND r.target_type = 'COMMENT' " +
                     "LEFT JOIN users author_c ON c_t.user_id = author_c.id " +
                     "LEFT JOIN articles a_c ON c_t.article_id = a_c.id " +
                     "WHERE r.target_type = ? AND r.status = ? " +
                     "GROUP BY r.target_id, r.target_type " +
                     "ORDER BY reportCount DESC, last_report_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, statusFilter);
            ps.setString(2, statusFilter);
            ps.setString(3, targetType);
            ps.setString(4, statusFilter);
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
        String sql = "SELECT r.*, u.full_name as reporter_name, " +
                     "(SELECT GROUP_CONCAT(DISTINCT r2.details ORDER BY r2.created_at DESC SEPARATOR '|||') FROM reports r2 WHERE r2.target_id = r.target_id AND r2.target_type = r.target_type AND r2.status = r.status) as combined_details, " +
                     "(SELECT GROUP_CONCAT(DISTINCT r2.reason ORDER BY r2.created_at DESC SEPARATOR ', ') FROM reports r2 WHERE r2.target_id = r.target_id AND r2.target_type = r.target_type AND r2.status = r.status) as combined_reasons, " +
                     "(SELECT COUNT(*) FROM reports r2 WHERE r2.target_id = r.target_id AND r2.target_type = r.target_type AND r2.status = r.status) as reportCount, " +
                     "CASE WHEN r.target_type = 'ARTICLE' THEN a.title " +
                     "     ELSE CONCAT('Comment: ', LEFT(c_t.content, 30), '...') END as target_title, " +
                     "CASE WHEN r.target_type = 'ARTICLE' THEN author_a.full_name " +
                     "     ELSE author_c.full_name END as author_name, " +
                     "CASE WHEN r.target_type = 'ARTICLE' THEN cat_a.name " +
                     "     ELSE CONCAT('On: ', a_c.title) END as section_info " +
                     "FROM reports r " +
                     "LEFT JOIN users u ON r.reporter_id = u.id " +
                     "LEFT JOIN articles a ON r.target_id = a.id AND r.target_type = 'ARTICLE' " +
                     "LEFT JOIN users author_a ON a.author_id = author_a.id " +
                     "LEFT JOIN categories cat_a ON a.category_id = cat_a.id " +
                     "LEFT JOIN comments c_t ON r.target_id = c_t.id AND r.target_type = 'COMMENT' " +
                     "LEFT JOIN users author_c ON c_t.user_id = author_c.id " +
                     "LEFT JOIN articles a_c ON c_t.article_id = a_c.id " +
                     "WHERE r.id = ?";
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
        String sql = "INSERT INTO reports (target_type, target_id, reporter_id, reason, details, " +
                     "problematic_snippet) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, targetType);
            ps.setLong(2, targetId);
            ps.setLong(3, reporterId);
            ps.setString(4, reason);
            ps.setString(5, details);
            ps.setString(6, snippet);
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
