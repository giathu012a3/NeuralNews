package neuralnews.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import neuralnews.dao.CategoryDao;
import neuralnews.dao.ArticleDao;
import neuralnews.model.Category;
import neuralnews.model.User;
import neuralnews.model.Article;

@WebServlet(urlPatterns = {"/home", "", "/category"})
public class CategoryController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        CategoryDao catDao = new CategoryDao();
        ArticleDao artDao = new ArticleDao();

        List<Category> listCat = catDao.getAllCategory();
        request.setAttribute("listCategory", listCat);

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {

            List<Article> featuredList = artDao.getFeaturedArticles(4); 
            if (!featuredList.isEmpty()) {
                request.setAttribute("featuredArt", featuredList.get(0)); 
                if (featuredList.size() > 1) {

                    request.setAttribute("subFeaturedArts", featuredList.subList(1, featuredList.size()));
                }
            }
            request.setAttribute("latestArtsWithCat", artDao.getArticlesCommon(6, 0, 0));

            request.setAttribute("mostViewedArts", artDao.getMostViewedArticles(5));

            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("currentUser");
            if (currentUser != null) {
                long excludeId = (!featuredList.isEmpty()) ? featuredList.get(0).getId() : 0;
                List<Article> recommended = artDao.getRecommendedByInterest(currentUser.getId(), excludeId);
                request.setAttribute("recommendedArts", recommended);
            }
            
            request.getRequestDispatcher("/user/home.jsp").forward(request, response);

        } else {

            try {
                int catId = Integer.parseInt(idParam);
                String currentName = "Danh mục";
                for(Category c : listCat) {
                    if(c.getId() == catId) {
                        currentName = c.getName();
                        break;
                    }
                }
                request.setAttribute("categoryName", currentName);
                request.setAttribute("listArticles", artDao.getArticlesCommon(20, 0, catId));
                request.getRequestDispatcher("/user/category.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        }
    }
}
