package neuralnews.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import neuralnews.dao.ArticleDao;

@WebServlet("/api/bookmark")
public class ProfileBookmarkController extends HttpServlet {
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
        String articleIdParam = request.getParameter("articleId");
        String action = request.getParameter("action"); // "add", "remove", or "toggle"

        if (articleIdParam == null) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("missing articleId");
            return;
        }

        try {
            long articleId = Long.parseLong(articleIdParam);
            if ("remove".equals(action)) {
                articleDao.removeBookmark(userId, articleId);
            } else if ("add".equals(action)) {
                articleDao.addBookmark(userId, articleId);
            } else {
                articleDao.toggleBookmark(userId, articleId);
            }
            response.getWriter().write("success");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("error");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.getWriter().write("false");
            return;
        }

        long userId = (long) session.getAttribute("userId");
        String articleIdParam = request.getParameter("articleId");
        
        if (articleIdParam != null) {
            try {
                long articleId = Long.parseLong(articleIdParam);
                boolean isBookmarked = articleDao.isBookmarked(userId, articleId);
                response.getWriter().write(String.valueOf(isBookmarked));
            } catch (NumberFormatException e) {
                response.getWriter().write("false");
            }
        } else {
            response.getWriter().write("false");
        }
    }
}
