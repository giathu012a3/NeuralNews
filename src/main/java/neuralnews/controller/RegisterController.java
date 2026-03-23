package neuralnews.controller;

import neuralnews.dao.NotificationDao;
import neuralnews.dao.UserDAO;
import neuralnews.model.Notification;
import neuralnews.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

/**
 * Handle new account registration: POST /RegisterController
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

		// Validate: must not be empty
		if (fullName == null || fullName.trim().isEmpty() || email == null || email.trim().isEmpty() || password == null
				|| password.trim().isEmpty()) {
			response.sendRedirect(contextPath + "/auth/register.jsp?error=empty");
			return;
		}

		// Validate: passwords must match
		if (!password.equals(confirmPassword)) {
			response.sendRedirect(contextPath + "/auth/register.jsp?error=mismatch");
			return;
		}

		// Validate: password minimum 6 chars
		if (password.length() < 6) {
			response.sendRedirect(contextPath + "/auth/register.jsp?error=weakpassword");
			return;
		}

		// Check if email already exists
		if (userDAO.emailExists(email.trim())) {
			response.sendRedirect(contextPath + "/auth/register.jsp?error=exists");
			return;
		}

		// Create new user (plain-text password - upgrade to BCrypt if needed)
		User newUser = new User();
		newUser.setFullName(fullName.trim());
		newUser.setEmail(email.trim());
		newUser.setPasswordHash(password); // Store plain password for now, hash later

		boolean isRegistered = userDAO.createUser(newUser);

		if (!isRegistered) {
			response.sendRedirect(contextPath + "/auth/register.jsp?error=servererror");
			return;
		}

		if (isRegistered) {
			User registeredUser = userDAO.findByEmail(newUser.getEmail());
			if (registeredUser != null) {
				Notification welcomeNoti = new Notification(
					registeredUser.getId(),
					"Chào mừng!",
					"Chào mừng " + registeredUser.getFullName() + " đến với NeuralNews. Hãy bắt đầu khám phá tin tức hữu ích nhé!",
					"SYSTEM",
					"/user/profile.jsp"
				);
				new NotificationDao().create(welcomeNoti);
			}
		}

		// Registration successful -> redirect to login
		response.sendRedirect(contextPath + "/auth/login.jsp?success=registered");
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.sendRedirect(request.getContextPath() + "/auth/register.jsp");
	}
}
