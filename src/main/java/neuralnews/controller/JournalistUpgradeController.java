package neuralnews.controller;

import neuralnews.dao.NotificationDao;
import neuralnews.dao.UserDAO;
import neuralnews.model.Notification;
import neuralnews.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Handle existing user upgrading to Journalist: POST /JournalistUpgradeController
 */
@WebServlet("/JournalistUpgradeController")
public class JournalistUpgradeController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }

        String bio = request.getParameter("bio");
        String expStr = request.getParameter("experience");

        if (bio == null || bio.trim().isEmpty() || expStr == null) {
            response.sendRedirect(request.getContextPath() + "/user/profile.jsp?error=empty");
            return;
        }

        int experience = 0;
        try {
            experience = Integer.parseInt(expStr);
        } catch (NumberFormatException e) {
            experience = 0;
        }

        boolean success = userDAO.updateJournalistApplication(currentUser.getId(), bio.trim(), experience);

        if (success) {
            NotificationDao notiDao = new NotificationDao();
            // Gui thong bao cho user
            notiDao.create(new Notification(
                currentUser.getId(),
                "Yêu cầu được gửi",
                "Yêu cầu nâng cấp lên Nhà báo của bạn đã được gửi thành công. Vui lòng chờ Ban quản trị duyệt.",
                "SYSTEM",
                "/user/profile.jsp"
            ));

            // Thong bao cho tat ca Admin
            List<User> admins = userDAO.getAllUsersFiltered(null, "Admin", "ACTIVE", "date", "DESC", 100, 0);
            for (User admin : admins) {
                notiDao.create(new Notification(
                    admin.getId(),
                    "Yêu cầu Nhà báo mới",
                    "Người dùng " + currentUser.getFullName() + " vừa gửi yêu cầu nâng cấp lên Nhà báo.",
                    "SYSTEM",
                    "/admin/users"
                ));
            }

            // Update the session user object status
            currentUser.setStatus("PENDING");
            currentUser.setBio(bio.trim());
            currentUser.setExperienceYears(experience);
            session.setAttribute("currentUser", currentUser);
            session.setAttribute("userStatus", "PENDING");
            
            response.sendRedirect(request.getContextPath() + "/user/profile.jsp?success=applied");
        } else {
            response.sendRedirect(request.getContextPath() + "/user/profile.jsp?error=server");
        }
    }
}
