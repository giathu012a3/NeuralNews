package neuralnews.controller;

import neuralnews.dao.UserDAO;
import neuralnews.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * Xử lý đăng ký tài khoản mới: POST /RegisterController
 */
@WebServlet("/RegisterController")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        String contextPath = request.getContextPath();

        // Validate: không được để trống
        if (fullName == null || fullName.trim().isEmpty() ||
                email == null || email.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            response.sendRedirect(contextPath + "/auth/register.jsp?error=empty");
            return;
        }

        // Validate: mật khẩu xác nhận phải khớp
        if (!password.equals(confirmPassword)) {
            response.sendRedirect(contextPath + "/auth/register.jsp?error=mismatch");
            return;
        }

        // Validate: mật khẩu tối thiểu 6 ký tự
        if (password.length() < 6) {
            response.sendRedirect(contextPath + "/auth/register.jsp?error=weakpassword");
            return;
        }

        // Kiểm tra email đã tồn tại
        if (userDAO.emailExists(email.trim())) {
            response.sendRedirect(contextPath + "/auth/register.jsp?error=exists");
            return;
        }

        // Tạo user mới (plain-text password — nâng cấp lên BCrypt nếu cần)
        User newUser = new User();
        newUser.setFullName(fullName.trim());
        newUser.setEmail(email.trim());
        newUser.setPasswordHash(password); // Store plain password for now, hash later

        boolean isRegistered = userDAO.createUser(newUser);

        if (!isRegistered) {
            response.sendRedirect(contextPath + "/auth/register.jsp?error=servererror");
            return;
        }

        // Đăng ký thành công → chuyển về login
        response.sendRedirect(contextPath + "/auth/login.jsp?success=registered");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/auth/register.jsp");
    }
}
