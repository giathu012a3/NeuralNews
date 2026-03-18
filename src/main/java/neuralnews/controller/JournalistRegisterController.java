package neuralnews.controller;

import neuralnews.dao.UserDAO;
import neuralnews.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * Handle new journalist account registration: POST /JournalistRegisterController
 */
@WebServlet("/JournalistRegisterController")
public class JournalistRegisterController extends HttpServlet {
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
        String bio = request.getParameter("bio");
        String expStr = request.getParameter("experience");

        String contextPath = request.getContextPath();

        // Validate: must not be empty
        if (fullName == null || fullName.trim().isEmpty() || email == null || email.trim().isEmpty() 
            || password == null || password.trim().isEmpty() || bio == null || bio.trim().isEmpty() || expStr == null) {
            response.sendRedirect(contextPath + "/auth/register_journalist.jsp?error=empty");
            return;
        }

        // Validate: passwords must match
        if (!password.equals(confirmPassword)) {
            response.sendRedirect(contextPath + "/auth/register_journalist.jsp?error=mismatch");
            return;
        }

        // Validate: password minimum 6 chars
        if (password.length() < 6) {
            response.sendRedirect(contextPath + "/auth/register_journalist.jsp?error=weakpassword");
            return;
        }

        // Check if email already exists
        if (userDAO.emailExists(email.trim())) {
            response.sendRedirect(contextPath + "/auth/register_journalist.jsp?error=exists");
            return;
        }

        int experience = 0;
        try {
            experience = Integer.parseInt(expStr);
        } catch (NumberFormatException e) {
            experience = 0;
        }

        // Create new journalist user
        User newUser = new User();
        newUser.setFullName(fullName.trim());
        newUser.setEmail(email.trim());
        newUser.setPasswordHash(password);
        newUser.setBio(bio.trim());
        newUser.setExperienceYears(experience);

        boolean isRegistered = userDAO.createJournalist(newUser);

        if (!isRegistered) {
            response.sendRedirect(contextPath + "/auth/register_journalist.jsp?error=servererror");
            return;
        }

        // Registration successful -> redirect to login with special success message
        response.sendRedirect(contextPath + "/auth/login.jsp?success=journalist_pending");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/auth/register_journalist.jsp");
    }
}
