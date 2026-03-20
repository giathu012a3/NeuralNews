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
import neuralnews.dao.CategoryDao;
import neuralnews.model.Article;
import neuralnews.model.Category;
import neuralnews.model.Report;

@WebServlet("/admin/home")
public class AdminHomeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        ArticleDao articleDao = new ArticleDao();
        UserDAO userDao = new UserDAO();
        ReportDao reportDao = new ReportDao();
        CategoryDao categoryDao = new CategoryDao();

        // 1. Thống kê bài viết
        java.util.Map<String, Integer> articleStats = articleDao.getArticleStatsByStatus();
        request.setAttribute("totalArticles", articleStats.get("TOTAL"));
        request.setAttribute("pendingArticles", articleStats.get("PENDING"));
        
        // 2. Thống kê người dùng
        int totalUsers = userDao.getTotalUserCount();
        int journalistApplications = userDao.getTotalUserCount(null, "JOURNALIST", "PENDING");
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("journalistApplications", journalistApplications);

        // 3. Thống kê báo cáo vi phạm
        int pendingViolations = reportDao.countPendingReports();
        request.setAttribute("pendingViolations", pendingViolations);

        // 4. Thống kê bài viết theo danh mục (cho biểu đồ)
        List<Category> categoryStats = categoryDao.getAllCategoryWithArticleCount();
        request.setAttribute("categoryStats", categoryStats);

        // 5. Thống kê lưu lượng
        String daysParam = request.getParameter("days");
        int days = 7; // Mặc định 7 ngày
        if (daysParam != null && !daysParam.isEmpty()) {
            try {
                days = Integer.parseInt(daysParam);
            } catch (NumberFormatException e) {
                // Ignore and use default
            }
        }
        java.util.Map<String, Integer> trafficStats = articleDao.getDailyTraffic(days);
        request.setAttribute("trafficStats", trafficStats);
        request.setAttribute("currentDays", days);

        // 6. Lấy 5 bài viết mới nhất cho Dashboard
        List<Article> recentArticles = articleDao.getAllArticlesFiltered(5, 0, null, null, null);
        request.setAttribute("recentArticles", recentArticles);

        // Chuyển hướng sang trang JSP
        request.getRequestDispatcher("/admin/home.jsp").forward(request, response);
    }
}
