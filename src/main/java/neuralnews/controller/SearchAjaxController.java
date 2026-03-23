package neuralnews.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import neuralnews.dao.ArticleDao;
import neuralnews.model.Article;

import java.io.IOException;
import java.util.List;

@WebServlet("/search-ajax")
public class SearchAjaxController extends HttpServlet {
    private final ArticleDao articleDao = new ArticleDao();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (keyword == null || keyword.trim().isEmpty()) {
            response.getWriter().write("[]");
            return;
        }

        try {
            List<Article> results = articleDao.searchArticles(keyword, 5); // Giới hạn 5 kết quả
            String json = gson.toJson(results);
            response.getWriter().write(json);
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Internal Server Error\"}");
        }
    }
}
