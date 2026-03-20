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
import neuralnews.dao.CommentDao;
import neuralnews.model.Article;
import neuralnews.model.Category;
import neuralnews.model.Comment;
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
                CategoryDao catDao = new CategoryDao();
                CommentDao cmtDao = new CommentDao(); 
                
                // 1. Kiểm tra User đang đăng nhập (Lấy ID để check trạng thái Like cmt)
                HttpSession session = request.getSession();
                User user = (User) session.getAttribute("currentUser");
                long currentUserId = (user != null) ? user.getId() : 0;
                
                // 2. Lấy thông tin bài viết chi tiết
                Article article = artDao.getArticleById(articleId);
                request.setAttribute("articleDetail", article);

                // 3. Lấy danh sách bình luận (TRUYỀN THÊM currentUserId VÀO ĐÂY)
                // Hàm này trong CommentDao của Thịnh giờ phải nhận 2 tham số nhé
                List<Comment> listComments = cmtDao.getCommentsByArticle(articleId, currentUserId);

                System.out.println(">>> Article ID: " + articleId);
                System.out.println(">>> So luong cmt tim thay: " + listComments.size());
                
                request.setAttribute("listComments", listComments); 
                request.setAttribute("commentCount", listComments.size()); 
                
                // 4. Kiểm tra trạng thái tương tác của User với BÀI VIẾT (Like/Dislike)
                String userReaction = "NONE";
                if (user != null) {
                    userReaction = artDao.getUserReaction(user.getId(), articleId);
                }
                request.setAttribute("userReaction", userReaction);

                // 5. Lấy danh sách danh mục để hiện trên menu/sidebar
                List<Category> listCat = catDao.getAllCategory();
                request.setAttribute("listCategory", listCat);

            } catch (NumberFormatException ignored) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
        }
        
        request.getRequestDispatcher("/user/article.jsp").forward(request, response);
    }
}