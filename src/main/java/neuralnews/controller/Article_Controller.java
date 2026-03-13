package neuralnews.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import neuralnews.dao.Article_Dao;
import neuralnews.dao.Category_Dao;
import neuralnews.model.Article_Model;
import neuralnews.model.Category_Model;

@WebServlet("/user/article")
public class Article_Controller extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                int articleId = Integer.parseInt(idParam);
                Article_Dao artDao = new Article_Dao();
                Article_Model article = artDao.getArticleById(articleId);
                request.setAttribute("articleDetail", article);

                Category_Dao catDao = new Category_Dao();
                List<Category_Model> listCat = catDao.getAllCategory();
                request.setAttribute("listCategory", listCat);
            } catch (NumberFormatException ignored) {}
        }
        request.getRequestDispatcher("/user/article.jsp").forward(request, response);
    }
}
