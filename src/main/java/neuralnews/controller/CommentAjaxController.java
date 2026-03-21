package neuralnews.controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import neuralnews.dao.ArticleDao;
import neuralnews.dao.CommentDao;
import neuralnews.dao.NotificationDao;
import neuralnews.model.Article;
import neuralnews.model.Comment;
import neuralnews.model.Notification;
import neuralnews.model.User;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/comments")
public class CommentAjaxController extends HttpServlet {

    private final CommentDao commentDao = new CommentDao();
    private final Gson gson = new Gson();

    // GET /comments?articleId=X  →  trả về JSON danh sách bình luận
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");
        long currentUserId = (user != null) ? user.getId() : -1L;

        String articleIdStr = request.getParameter("articleId");
        if (articleIdStr == null || articleIdStr.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\": \"Missing articleId\"}");
            return;
        }
        try {
            long articleId = Long.parseLong(articleIdStr);
            List<Comment> comments = commentDao.getCommentsByArticle(articleId, currentUserId);
            out.print(gson.toJson(comments));
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print("{\"error\": \"Invalid articleId\"}");
        }
    }

    // POST /comments  →  đăng bình luận mới hoặc like bình luận
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");

        if (user == null) {
            out.print("{\"status\": \"UNAUTHORIZED\"}");
            return;
        }

        String action = request.getParameter("action");

        // --- LIKE ACTION ---
        if ("like".equals(action)) {
            String commentIdStr = request.getParameter("commentId");
            if (commentIdStr == null) {
                out.print("{\"status\": \"ERROR\", \"message\": \"Missing commentId\"}");
                return;
            }
            try {
                long commentId = Long.parseLong(commentIdStr);
                String toggleResult = commentDao.toggleLikeComment(commentId, user.getId());
                out.print("{\"status\": \"SUCCESS\", \"toggleResult\": \"" + toggleResult + "\"}");
            } catch (NumberFormatException e) {
                out.print("{\"status\": \"ERROR\", \"message\": \"Invalid commentId\"}");
            }
            return;
        }

        // --- REPORT ACTION ---
        if ("report".equals(action)) {
            if (user == null) {
                out.print("{\"status\": \"UNAUTHORIZED\"}");
                return;
            }
            String commentIdStr = request.getParameter("commentId");
            String reason = request.getParameter("reason");
            String details = request.getParameter("details");
            if (commentIdStr == null || commentIdStr.trim().isEmpty() || reason == null || reason.trim().isEmpty()) {
                out.print("{\"status\": \"ERROR\", \"message\": \"Missing data\"}");
                return;
            }
            try {
                long commentId = Long.parseLong(commentIdStr);
                neuralnews.dao.ReportDao reportDao = new neuralnews.dao.ReportDao();
                boolean success = reportDao.createReport("COMMENT", commentId, user.getId(), reason, details, "");
                out.print("{\"status\": \"" + (success ? "SUCCESS" : "ERROR") + "\"}");
            } catch (Exception e) {
                out.print("{\"status\": \"ERROR\", \"message\": \"Invalid data\"}");
            }
            return;
        }

        // --- POST NEW COMMENT ---
        String articleIdStr = request.getParameter("articleId");
        String content      = request.getParameter("content");
        String parentIdStr  = request.getParameter("parentId");

        if (articleIdStr == null || content == null || content.trim().isEmpty()) {
            out.print("{\"status\": \"ERROR\", \"message\": \"Missing data\"}");
            return;
        }

        try {
            long articleId = Long.parseLong(articleIdStr);
            Long parentId = (parentIdStr != null && !parentIdStr.isEmpty())
                    ? Long.parseLong(parentIdStr) : null;

            boolean success = commentDao.addComment(articleId, user.getId(), parentId, content.trim());
            
            if (success) {
                NotificationDao notiDao = new NotificationDao();
                ArticleDao artDao = new ArticleDao();
                Article art = artDao.getArticleById(articleId);
                
                if (art != null) {
                    String userName = user.getFullName() != null ? user.getFullName() : "Doc gia";
                    String articleUrl = "/user/article?id=" + articleId;

                    if (parentId == null) {
                        if (art.getAuthorId() != user.getId()) {
                            Notification n = new Notification(
                                art.getAuthorId(),
                                "Binh luan moi",
                                userName + " da binh luan ve bai viet: '" + art.getTitle() + "'.",
                                "COMMENT",
                                articleUrl
                            );
                            notiDao.create(n);
                        }
                    } else {
                        Comment parentComment = commentDao.getCommentById(parentId);
                        if (parentComment != null && parentComment.getUserId() != user.getId()) {
                            Notification n = new Notification(
                                parentComment.getUserId(),
                                "Phan hoi binh luan",
                                userName + " da phan hoi binh luan cua ban trong bai viet: '" + art.getTitle() + "'.",
                                "COMMENT",
                                articleUrl
                            );
                            notiDao.create(n);
                        }
                        
                        if (art.getAuthorId() != user.getId() && (parentComment == null || art.getAuthorId() != parentComment.getUserId())) {
                            Notification n = new Notification(
                                art.getAuthorId(),
                                "Binh luan moi",
                                userName + " da phan hoi mot binh luan trong bai viet: '" + art.getTitle() + "'.",
                                "COMMENT",
                                articleUrl
                            );
                            notiDao.create(n);
                        }
                    }
                }
            }
            
            out.print("{\"status\": \"" + (success ? "SUCCESS" : "ERROR") + "\"}");
        } catch (Exception e) {
            out.print("{\"status\": \"ERROR\", \"message\": \"" + e.getMessage() + "\"}");
        }
    }
}
