package neuralnews.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import neuralnews.dao.CategoryDao;
import neuralnews.dao.ArticleDao;
import neuralnews.model.Category;
import neuralnews.model.Article;

@WebServlet(urlPatterns = {"/home", ""})
public class CategoryController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        CategoryDao catDao = new CategoryDao();
        ArticleDao artDao = new ArticleDao();

        // 1. Luôn lấy danh mục cho Header
        List<Category> listCat = catDao.getAllCategory();
        request.setAttribute("listCategory", listCat);

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            request.setAttribute("featuredArt", artDao.getFeaturedArticle()); // Bài to nhất
            request.setAttribute("subFeaturedArts", artDao.getArticlesCommon(3, 1, 0)); // 3 bài nhỏ (bỏ qua bài 1)
            request.setAttribute("latestArtsWithCat", artDao.getArticlesCommon(6, 4, 0)); // 6 bài mới (bỏ qua 4 bài đầu)
            request.setAttribute("mostViewedArts", artDao.getMostViewedArticles(5));
            // Trường hợp vào trang chủ
            request.getRequestDispatcher("/user/home.jsp").forward(request, response);
        } else {
            // Trường hợp nhấn vào một danh mục cụ thể
            try {
                int catId = Integer.parseInt(idParam);
                
                // Tìm tên danh mục hiện tại để hiển thị lên tiêu đề
                String currentName = "Danh mục";
                for(Category c : listCat) {
                    if(c.getId() == catId) {
                        currentName = c.getName();
                        break;
                    }
                }
                request.setAttribute("categoryName", currentName);

                // Lấy danh sách bài viết theo Category ID
                List<Article> listArt = artDao.getArticlesCommon(20, 0, catId);
                request.setAttribute("listArticles", listArt);

                request.getRequestDispatcher("/user/category.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        }
    }
}
