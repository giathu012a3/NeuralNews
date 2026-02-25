package neuralnews.controller;

import neuralnews.dao.UserDAO;
import neuralnews.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * Xử lý đăng nhập: POST /LoginController
 */
@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String contextPath = request.getContextPath();

        // Validate đầu vào cơ bản
        if (email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            response.sendRedirect(contextPath + "/auth/login.jsp?error=empty");
            return;
        }

        // Tìm user theo email
        User user = userDAO.findByEmail(email.trim());
        if (user == null) {
            response.sendRedirect(contextPath + "/auth/login.jsp?error=invalid");
            return;
        }

        // Kiểm tra mật khẩu
        if (!userDAO.verifyPassword(password, user.getPasswordHash())) {
            response.sendRedirect(contextPath + "/auth/login.jsp?error=invalid");
            return;
        }

        // Kiểm tra trạng thái tài khoản
        if ("BANNED".equals(user.getStatus()) || "SUSPENDED".equals(user.getStatus())) {
            response.sendRedirect(contextPath + "/auth/login.jsp?error=banned");
            return;
        }
        if ("PENDING".equals(user.getStatus())) {
            response.sendRedirect(contextPath + "/auth/login.jsp?error=pending");
            return;
        }

        // Lưu thông tin user vào session
        HttpSession session = request.getSession();
        session.setAttribute("currentUser", user);
        session.setAttribute("userId", user.getId());
        session.setAttribute("userEmail", user.getEmail());
        session.setAttribute("userRole", user.getRole().getName());
        session.setAttribute("userName", user.getFullName());

        // Redirect theo role
        boolean isAdmin = user.hasRole("ADMIN");
        if (isAdmin) {
            response.sendRedirect(contextPath + "/admin/home.jsp");
        } else {
            response.sendRedirect(contextPath + "/index.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // GET /LoginController → chuyển về trang login
        response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
    }
}
