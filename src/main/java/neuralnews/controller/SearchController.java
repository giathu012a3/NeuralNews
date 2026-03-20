package neuralnews.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import neuralnews.dao.ArticleDao;
import neuralnews.model.Article;

import java.io.IOException;
import java.util.List;

@WebServlet("/user/search")
public class SearchController extends HttpServlet {
    private final ArticleDao articleDao = new ArticleDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        
        if (keyword != null && !keyword.trim().isEmpty()) {
            List<Article> articles = articleDao.searchArticles(keyword, 30); // Lấy tối đa 30 kết quả cho trang search
            request.setAttribute("articles", articles);
            request.setAttribute("keyword", keyword);
        } else {
            request.setAttribute("keyword", "");
        }
        
        request.getRequestDispatcher("/user/search.jsp").forward(request, response);
    }
}
