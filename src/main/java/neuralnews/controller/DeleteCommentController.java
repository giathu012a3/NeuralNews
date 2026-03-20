package neuralnews.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import neuralnews.dao.CommentDao;
import neuralnews.model.User;

import java.io.IOException;

/**
 * Servlet implementation class DeleteCommentController
 */
@WebServlet("/delete-comment")
public class DeleteCommentController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");
        
        if (user == null) {
            response.getWriter().print("{\"status\":\"error\", \"message\":\"Chưa đăng nhập\"}");
            return;
        }

        long commentId = Long.parseLong(request.getParameter("commentId"));
        boolean success = new CommentDao().softDeleteComment(commentId, user.getId());
        
        if (success) {
            response.getWriter().print("{\"status\":\"success\"}");
        } else {
            response.getWriter().print("{\"status\":\"error\"}");
        }
    }
}
