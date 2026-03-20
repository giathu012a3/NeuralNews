package neuralnews.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import neuralnews.dao.ArticleDao;
import neuralnews.dao.UserDAO;
import neuralnews.dao.ReportDao;
import neuralnews.model.Article;
import neuralnews.model.Report;

@WebServlet("/admin/home")
public class AdminHomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        ArticleDao articleDao = new ArticleDao();
        UserDAO userDao = new UserDAO();
        ReportDao reportDao = new ReportDao();

        // 1. Thống kê bài viết
        java.util.Map<String, Integer> articleStats = articleDao.getArticleStatsByStatus();
        request.setAttribute("totalArticles", articleStats.get("TOTAL"));
        request.setAttribute("pendingArticles", articleStats.get("PENDING"));
        
        // 2. Thống kê người dùng
        int totalUsers = userDao.getTotalUserCount();
        request.setAttribute("totalUsers", totalUsers);
        
        // 3. Thống kê báo cáo vi phạm
        int pendingViolations = reportDao.countPendingReports();
        request.setAttribute("pendingViolations", pendingViolations);

        // 4. Lấy 5 bài viết mới nhất cho Dashboard
        List<Article> recentArticles = articleDao.getAllArticlesFiltered(5, 0, null, null, null);
        request.setAttribute("recentArticles", recentArticles);

        // Chuyển hướng sang trang JSP
        request.getRequestDispatcher("/admin/home.jsp").forward(request, response);
    }
}
