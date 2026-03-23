package neuralnews.controller;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import neuralnews.dao.ArticleDao;
import neuralnews.model.Article;

import java.io.IOException;
import java.util.List;

@WebServlet("/home-ajax")
public class HomeAjaxController extends HttpServlet {
    private final ArticleDao articleDao = new ArticleDao();
    private final Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            if ("loadMoreLatest".equals(action)) {
                int limit = Integer.parseInt(request.getParameter("limit"));
                int offset = Integer.parseInt(request.getParameter("offset"));
                int catId = 0;
                String catIdStr = request.getParameter("catId");
                if (catIdStr != null && !catIdStr.isEmpty()) {
                	catId = Integer.parseInt(catIdStr);
                }
                List<Article> articles = articleDao.getArticlesCommon(limit, offset, catId);
                response.getWriter().write(gson.toJson(articles));
            } else if ("getFeatured".equals(action)) {
                String type = request.getParameter("type");
                List<Article> articles;
                if ("liked".equals(type)) {
                    articles = articleDao.getMostLikedArticles(4);
                } else {
                    articles = articleDao.getFeaturedArticles(4);
                }
                response.getWriter().write(gson.toJson(articles));
            } else {
                response.getWriter().write("[]");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Internal Server Error\"}");
        }
    }
}
