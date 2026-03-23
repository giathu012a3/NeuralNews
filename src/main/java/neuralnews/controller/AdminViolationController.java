package neuralnews.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import neuralnews.dao.ReportDao;
import neuralnews.dao.ArticleDao;
import neuralnews.dao.CommentDao;
import neuralnews.dao.UserDAO;
import neuralnews.model.Report;

@WebServlet("/admin/violation")
public class AdminViolationController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReportDao reportDao;
    private ArticleDao articleDao;
    private CommentDao commentDao;
    private UserDAO userDAO;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        super.init();
        reportDao = new ReportDao();
        articleDao = new ArticleDao();
        commentDao = new CommentDao();
        userDAO = new UserDAO();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String reportIdStr = request.getParameter("reportId");
        if (reportIdStr != null) {
            long reportId = Long.parseLong(reportIdStr);
            Report r = reportDao.getReportById(reportId);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            PrintWriter out = response.getWriter();
            out.print("{\"success\": " + (r != null) + ", \"report\": " + gson.toJson(r) + "}");
            out.flush();
            return;
        }

        String targetType = request.getParameter("targetType");
        if (targetType == null) targetType = "ARTICLE";
        
        String status = request.getParameter("status");
        if (status == null) status = "PENDING";

        List<Report> reports = reportDao.getAllReports(targetType, status);
        request.setAttribute("reports", reports);
        request.setAttribute("currentTargetType", targetType);
        request.setAttribute("currentStatus", status);
        request.getRequestDispatcher("/admin/violation.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        String reportIdStr = request.getParameter("reportId");
        
        boolean success = false;
        String message = "";
        
        if (action == null || reportIdStr == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            message = "Missing action or reportId";
        } else {
            long reportId = Long.parseLong(reportIdStr);
            Report r = reportDao.getReportById(reportId);
            
            if (r == null) {
                message = "Report not found";
            } else {
                switch (action) {
                    case "dismiss":
                        success = reportDao.updateReportStatus(reportId, "DISMISSED");
                        message = success ? "Report dismissed" : "Failed to dismiss report";
                        break;
                        
                    case "take_down":
                        success = reportDao.updateReportStatus(reportId, "RESOLVED");
                        if (success) {
                            if ("ARTICLE".equals(r.getTargetType())) {
                                success = articleDao.updateArticleStatus(r.getTargetId(), "ARCHIVED", 0L);
                                message = success ? "Article taken down and report resolved" : "Failed to take down article";
                            } else {
                                success = commentDao.updateStatus(r.getTargetId(), "HIDDEN");
                                message = success ? "Comment hidden and report resolved" : "Failed to hide comment";
                            }
                        }
                        break;
                        
                    case "suspend":
                        success = reportDao.updateReportStatus(reportId, "RESOLVED");
                        if (success) {
                            long authorId = -1;
                            if ("ARTICLE".equals(r.getTargetType())) {
                                articleDao.updateArticleStatus(r.getTargetId(), "ARCHIVED", 0L);
                                authorId = articleDao.getAuthorIdByArticleId(r.getTargetId());
                            } else {
                                commentDao.updateStatus(r.getTargetId(), "HIDDEN");
                                // Need to get user_id of the comment creator. 
                                // I'll assume we can get it from CommentDao if needed, 
                                // or the ReportDao could have provided it.
                                // Quick fix: Add getUserIdByCommentId to CommentDao or use generic query.
                                // For now, let's assume we implement a quick helper.
                            }
                            
                            if (authorId == -1 && "COMMENT".equals(r.getTargetType())) {
                                authorId = getUserIdFromComment(r.getTargetId());
                            }
                            
                            if (authorId != -1) {
                                success = userDAO.updateUserStatus(authorId, "SUSPENDED");
                                message = success ? "Content removed and author suspended" : "Content removed but failed to suspend author";
                            } else {
                                message = "Content removed but author not found";
                                success = true;
                            }
                        }
                        break;
                        
                    default:
                        message = "Invalid action";
                }
            }
        }
        
        PrintWriter out = response.getWriter();
        out.print("{\"success\": " + success + ", \"message\": \"" + message.replace("\"", "'") + "\"}");
        out.flush();
    }

    private long getUserIdFromComment(long commentId) {
        String sql = "SELECT user_id FROM comments WHERE id = ?";
        try (Connection conn = neuralnews.util.DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, commentId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getLong("user_id");
        } catch (Exception e) { e.printStackTrace(); }
        return -1;
    }
}
