package neuralnews.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import neuralnews.dao.NotificationDao;
import neuralnews.model.User;

import java.io.IOException;

@WebServlet("/notification-ajax")
public class NotificationAjaxController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;
        if (user == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        String action = request.getParameter("action");
        NotificationDao dao = new NotificationDao();

        if ("markAllRead".equals(action)) {
            dao.markAllRead(user.getId());
            response.setStatus(HttpServletResponse.SC_OK);
        } else if ("markRead".equals(action)) {
            try {
                String idParam = request.getParameter("id");
                if (idParam != null && !idParam.isEmpty()) {
                    long id = Long.parseLong(idParam);
                    dao.markRead(id);
                    response.setStatus(HttpServletResponse.SC_OK);
                } else {
                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}
