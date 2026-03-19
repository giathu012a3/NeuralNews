package neuralnews.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import neuralnews.dao.ArticleDao;
import neuralnews.dao.CategoryDao;
import neuralnews.model.Article;
import neuralnews.model.Category;
import neuralnews.model.User;

@WebServlet("/user/article")
public class ArticleController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");
        
        if (idParam != null) {
            try {
                long articleId = Long.parseLong(idParam);
                ArticleDao artDao = new ArticleDao();
                
                // 1. Lấy thông tin bài viết
                Article article = artDao.getArticleById(articleId);
                request.setAttribute("articleDetail", article);

                // 2. LẤY TRẠNG THÁI LIKE/DISLIKE (Phần quan trọng nhất)
                HttpSession session = request.getSession();
                User user = (User) session.getAttribute("currentUser");
                
                String userReaction = "NONE";
                if (user != null) {
                    // Gọi hàm kiểm tra từ DB
                    userReaction = artDao.getUserReaction(user.getId(), articleId);
                }
                // Gửi "màu sắc" sang cho JSP
                request.setAttribute("userReaction", userReaction);

                // 3. Lấy danh sách danh mục (cho menu hoặc sidebar)
                CategoryDao catDao = new CategoryDao();
                List<Category> listCat = catDao.getAllCategory();
                request.setAttribute("listCategory", listCat);

            } catch (NumberFormatException ignored) {
                // Nếu ID không phải là số, có thể redirect về trang chủ
            }
        }
        
        // CHỈ GỌI FORWARD MỘT LẦN DUY NHẤT Ở CUỐI CÙNG
        request.getRequestDispatcher("/user/article.jsp").forward(request, response);
    }
}