package neuralnews.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.io.BufferedReader;
import neuralnews.dao.CommentDao;
import neuralnews.model.Comment;
import neuralnews.model.User;

@WebServlet("/add-comment")
public class CommentController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        if (user == null) {
            response.getWriter().write("{\"status\":\"error\", \"message\":\"UNAUTHORIZED\"}");
            return;
        }

        StringBuilder sb = new StringBuilder();
        String line;
        try (BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }
        String jsonData = sb.toString();

        try {
            // 1. Lấy articleId
            String articleIdStr = jsonData.split("\"articleId\":")[1].split(",")[0].replaceAll("[\"}]", "").trim();
            
            // 2. Lấy parentId (Xử lý an toàn hơn)
            long parentId = 0;
            if (jsonData.contains("\"parentId\":")) {
                String pIdStr = jsonData.split("\"parentId\":")[1].split("}")[0].replaceAll("[\"}]", "").trim();
                parentId = Long.parseLong(pIdStr);
            }

            // 3. Lấy content (SỬA LỖI DÍNH CHỮ TẠI ĐÂY)
            String contentPart = jsonData.split("\"content\":")[1];
            String content = contentPart.split(",\"")[0].split("}")[0].replaceAll("^\"|\"$", "").trim();

            // 4. Lưu vào Database
            Comment c = new Comment();
            c.setContent(content);
            c.setArticleId(Long.parseLong(articleIdStr));
            c.setUserId(user.getId());
            c.setParentId((Long)parentId); // Ép kiểu về int cho khớp với Model

            boolean isSuccess = new CommentDao().addComment(c);

            if (isSuccess) {
                response.getWriter().write("{\"status\":\"success\"}");
            } else {
                response.getWriter().write("{\"status\":\"error\", \"message\":\"DB_ERROR\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"status\":\"error\", \"message\":\"PARSE_ERROR\"}");
        }
    }
}