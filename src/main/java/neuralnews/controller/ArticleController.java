package neuralnews.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import neuralnews.dao.ArticleDao;
import neuralnews.dao.CategoryDao;
import neuralnews.model.Article;
import neuralnews.model.Category;

@WebServlet("/user/article")
public class ArticleController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                long articleId = Long.parseLong(idParam);
                ArticleDao artDao = new ArticleDao();
                Article article = artDao.getArticleById(articleId);
                request.setAttribute("articleDetail", article);

                CategoryDao catDao = new CategoryDao();
                List<Category> listCat = catDao.getAllCategory();
                request.setAttribute("listCategory", listCat);
            } catch (NumberFormatException ignored) {}
        }
        request.getRequestDispatcher("/user/article.jsp").forward(request, response);
    }
}
