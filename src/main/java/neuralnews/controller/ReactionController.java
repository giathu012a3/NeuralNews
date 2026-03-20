package neuralnews.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import neuralnews.dao.ArticleDao;
import neuralnews.dao.CommentDao;
import neuralnews.model.User;
import neuralnews.model.Article;

@WebServlet("/handle-reaction")
public class ReactionController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        ArticleDao dao = new ArticleDao();
        CommentDao cmtDao = new CommentDao();
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        // 1. KIỂM TRA: Nếu là AJAX JSON (Của Like Bình luận)
        String contentType = request.getContentType();
        if (contentType != null && contentType.contains("application/json")) {
            if (currentUser == null) {
                out.print("{\"status\":\"UNAUTHORIZED\"}");
                return;
            }
            
            StringBuilder sb = new StringBuilder();
            String line;
            try (BufferedReader reader = request.getReader()) {
                while ((line = reader.readLine()) != null) sb.append(line);
            }
            String jsonData = sb.toString();

            if (jsonData.contains("\"commentId\":")) {
                if (currentUser == null) {
                    out.print("{\"status\":\"UNAUTHORIZED\"}");
                    return;
                }
                try {
                    String cmtIdStr = jsonData.split("\"commentId\":")[1].split("}")[0].replaceAll("[\"}]", "").trim();
                    long commentId = Long.parseLong(cmtIdStr);
                    
                    // Gọi hàm toggleLike bạn vừa viết
                    String resStatus = cmtDao.toggleLike(currentUser.getId(), commentId);
                    int newLikes = cmtDao.getCommentLikeCount(commentId);
                    
                    // Trả về JSON cho JS xử lý giao diện
                    out.print(String.format("{\"status\":\"%s\", \"newLikes\":%d}", resStatus, newLikes));
                } catch (Exception e) {
                    out.print("{\"status\":\"ERROR\"}");
                }
                return;
            }
        }

        // 2. NẾU KHÔNG PHẢI JSON -> XỬ LÝ THEO KIỂU PARAMETER CŨ (Like bài báo & View)
        String action = request.getParameter("action");
        String artIdParam = request.getParameter("articleId");
        String type = request.getParameter("type");

        // --- Tăng View ---
        if ("view".equals(action)) {
            if (artIdParam != null) {
                long articleId = Long.parseLong(artIdParam);
                long userId = (currentUser != null) ? currentUser.getId() : 0;
                dao.incrementViewCount(articleId, userId);
            }
            return; 
        }

        // --- Like/Dislike Bài báo ---
        if (currentUser == null) {
            out.print("{\"status\":\"UNAUTHORIZED\"}");
            return;
        }

        try {
            if (artIdParam != null && type != null) {
                long articleId = Long.parseLong(artIdParam);
                String newStatus = dao.handleReaction(currentUser.getId(), articleId, type);
                Article art = dao.getArticleById(articleId);

                if (art != null) {
                    out.print(String.format(
                        "{\"status\":\"%s\", \"newLikes\":%d, \"newDislikes\":%d}",
                        newStatus, art.getLikesCount(), art.getDislikesCount()
                    ));
                }
            }
        } catch (Exception e) {
            out.print("{\"status\":\"SERVER_ERROR\"}");
        } finally {
            out.flush();
            out.close();
        }
    }
}