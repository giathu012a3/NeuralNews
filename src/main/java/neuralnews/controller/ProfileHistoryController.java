package neuralnews.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import neuralnews.dao.ArticleDao;

@WebServlet("/api/history")
public class ProfileHistoryController extends HttpServlet {
    private final ArticleDao articleDao = new ArticleDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("unauthorized");
            return;
        }

        long userId = (long) session.getAttribute("userId");
        String action = request.getParameter("action"); // "remove" or "clear"
        String articleIdParam = request.getParameter("articleId");

        try {
            if ("clear".equals(action)) {
                articleDao.clearReadingHistory(userId);
            } else if ("remove".equals(action) && articleIdParam != null) {
                long articleId = Long.parseLong(articleIdParam);
                articleDao.removeReadingHistory(userId, articleId);
            }
            response.getWriter().write("success");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("error");
        }
    }
}
