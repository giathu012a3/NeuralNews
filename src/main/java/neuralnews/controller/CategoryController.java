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
            // --- TRƯỜNG HỢP VÀO TRANG CHỦ ---
            
            // 1. Lấy 4 bài NỔI BẬT NHẤT (Sắp xếp theo LIKE cao nhất)
            List<Article> featuredList = artDao.getFeaturedArticles(4); 
            if (!featuredList.isEmpty()) {
                request.setAttribute("featuredArt", featuredList.get(0)); // Bài to nhất (vị trí 0)
                if (featuredList.size() > 1) {
                    // 3 bài nhỏ tiếp theo (từ vị trí 1 đến hết)
                    request.setAttribute("subFeaturedArts", featuredList.subList(1, featuredList.size()));
                }
            }

            // 2. Lấy BÁO MỚI NHẤT (Cập nhật mới nhất - Theo thời gian)
            // Lấy 6 bài mới nhất, không cần offset vì mục này độc lập
//            request.setAttribute("latestArtsWithCat", artDao.getLatestArticles(6));
         // Nếu muốn bỏ qua 4 bài đã hiện ở mục Nổi bật để lấy các bài tiếp theo
            request.setAttribute("latestArtsWithCat", artDao.getArticlesCommon(6, 0, 0));

            // 3. Lấy BÁO ĐỌC NHIỀU NHẤT (Most Viewed - Cho Sidebar)
            request.setAttribute("mostViewedArts", artDao.getMostViewedArticles(5));
            
            // 4. Xử lý Gợi ý theo sở thích (Nếu đã đăng nhập)
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("currentUser");
            if (currentUser != null) {
                long excludeId = (!featuredList.isEmpty()) ? featuredList.get(0).getId() : 0;
                List<Article> recommended = artDao.getRecommendedByInterest(currentUser.getId(), excludeId);
                request.setAttribute("recommendedArts", recommended);
            }
            
            request.getRequestDispatcher("/user/home.jsp").forward(request, response);

        } else {
            // --- TRƯỜNG HỢP VÀO DANH MỤC CỤ THỂ ---
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
