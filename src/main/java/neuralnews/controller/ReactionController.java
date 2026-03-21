package neuralnews.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import neuralnews.dao.ArticleDao;
import neuralnews.dao.NotificationDao;
import neuralnews.model.Article;
import neuralnews.model.Notification;
import neuralnews.model.User;

@WebServlet("/handle-reaction")
public class ReactionController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Khai báo biến chung ở đầu hàm (CHỈ KHAI BÁO 1 LẦN)
        String action = request.getParameter("action");
        String artIdParam = request.getParameter("articleId");
        ArticleDao dao = new ArticleDao(); // Biến dao dùng chung cho cả View và Reaction
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        // --- TRƯỜNG HỢP 1: TĂNG VIEW (Sau 30 giây) ---
        if ("view".equals(action)) {
            if (artIdParam != null && !artIdParam.isEmpty()) {
                try {
                    long articleId = Long.parseLong(artIdParam);
                    
                    // Lấy userId nếu đã đăng nhập, nếu chưa thì để 0
                    long userId = (currentUser != null) ? currentUser.getId() : 0;

                    // Gọi hàm (Đã khớp 2 tham số: articleId và userId)
                    dao.incrementViewCount(articleId, userId);
                    
                    System.out.println(">>> DA CONG VIEW VAO INTERACTIONS CHO ID: " + articleId);
                } catch (NumberFormatException e) {
                    System.out.println(">>> LOI: ID khong hop le (VIEW)");
                }
            }
            return; 
        }
    	
        // --- TRƯỜNG HỢP 2: LIKE / DISLIKE ---
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        if (currentUser == null) {
            out.print("{\"status\":\"UNAUTHORIZED\"}");
            out.flush();
            return;
        }

        try {
            String type = request.getParameter("type"); 

            if (artIdParam == null || artIdParam.trim().isEmpty() || action == null && type == null) {
                out.print("{\"status\":\"INVALID_DATA\"}");
                return;
            }

            long articleId = Long.parseLong(artIdParam);
            
            if ("bookmark".equals(action)) {
                boolean success = dao.toggleBookmark(currentUser.getId(), articleId);
                boolean isNowBookmarked = dao.isBookmarked(currentUser.getId(), articleId);
                out.print("{\"status\":\"SUCCESS\", \"isBookmarked\":" + isNowBookmarked + "}");
                return;
            }
            
            if ("report".equals(action)) {
                String reason = request.getParameter("reason");
                String details = request.getParameter("details");
                neuralnews.dao.ReportDao reportDao = new neuralnews.dao.ReportDao();
                boolean success = reportDao.createReport("ARTICLE", articleId, currentUser.getId(), reason, details, "");
                out.print("{\"status\":\"" + (success ? "SUCCESS" : "FAILED") + "\"}");
                return;
            }
            
            // Xử lý logic trong bảng interactions (LIKE/DISLIKE)
            String newStatus = dao.handleReaction(currentUser.getId(), articleId, type);
            
            Article art = dao.getArticleById(articleId); 

            if (art != null) {
                if (art.getAuthorId() != currentUser.getId()) {
                    String userNameStr = (String) session.getAttribute("userName");
                    if (userNameStr == null) userNameStr = "Doc gia";

                    Notification noti = new Notification();
                    noti.setUserId(art.getAuthorId());
                    noti.setUrl("/user/article?id=" + articleId);
                    
                    NotificationDao notiDao = new NotificationDao();

                    if ("LIKE".equals(newStatus)) {
                        noti.setTitle("Luot Thich Moi");
                        noti.setContent(userNameStr + " vua nhan Thich bai viet '" + art.getTitle() + "'.");
                        noti.setType("LIKE");
                        notiDao.create(noti);
                    } else if ("DISLIKE".equals(newStatus)) {
                        noti.setTitle("Luot Khong Thich");
                        noti.setContent(userNameStr + " vua nhan Khong Thich bài viết '" + art.getTitle() + "'.");
                        noti.setType("DISLIKE");
                        notiDao.create(noti);
                    }
                }

                String json = String.format(
                    "{\"status\":\"%s\", \"newLikes\":%d, \"newDislikes\":%d}",
                    newStatus,
                    art.getLikesCount(),
                    art.getDislikesCount()
                );
                out.print(json);
            } else {
                out.print("{\"status\":\"ARTICLE_NOT_FOUND\"}");
            }

        } catch (NumberFormatException e) {
            out.print("{\"status\":\"FORMAT_ERROR\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500);
            out.print("{\"status\":\"SERVER_ERROR\"}");
        } finally {
            out.flush();
            out.close();
        }
    }
}