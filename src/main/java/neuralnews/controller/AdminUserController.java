package neuralnews.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import neuralnews.dao.UserDAO;
import neuralnews.model.User;

@WebServlet("/admin/users")
public class AdminUserController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDao;

    @Override
    public void init() throws ServletException {
        super.init();
        userDao = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        // 1. Nhận các tham số lọc từ URL
        String keyword = request.getParameter("keyword");
        String role = request.getParameter("role");
        String status = request.getParameter("status");
        
        // 2. Xử lý phân trang
        int pageNum = 1;
        int limit = 10;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                pageNum = Integer.parseInt(pageStr);
            } catch (NumberFormatException e) {
                pageNum = 1;
            }
        }
        int offset = (pageNum - 1) * limit;

        // 3. Gọi DAO lấy dữ liệu
        List<User> users = userDao.getAllUsersFiltered(keyword, role, status, limit, offset);
        int totalUsers = userDao.getTotalUserCount(keyword, role, status);
        int totalPages = (int) Math.ceil((double) totalUsers / limit);

        // 4. Lấy danh sách chờ duyệt (PENDING) để hiển thị ở khu vực riêng
        List<User> pendingUsers = userDao.getAllUsersFiltered(null, null, "PENDING", 5, 0);

        // 5. Đẩy dữ liệu vào request attribute
        request.setAttribute("users", users);
        request.setAttribute("pendingUsers", pendingUsers);
        request.setAttribute("currentPage", pageNum);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("filterKeyword", keyword);
        request.setAttribute("filterRole", role);
        request.setAttribute("filterStatus", status);

        // 5. Chuyển hướng sang file JSP
        // Kiểm tra nếu là AJAX request (chỉ gửi về phần bảng nếu cần)
        String requestedWith = request.getHeader("X-Requested-With");
        if ("XMLHttpRequest".equals(requestedWith)) {
            // Sau này bạn có thể tách phần <tbody> ra file riêng để update AJAX mượt hơn
            request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");
        String userIdStr = request.getParameter("userId");

        if (userIdStr != null && action != null) {
            try {
                long userId = Long.parseLong(userIdStr);
                boolean success = false;
                String message = "";

                if ("approve".equals(action)) {
                    // Cấp quyền JOURNALIST (2) và đặt trạng thái ACTIVE
                    success = userDao.updateUserRoleAndStatus(userId, 2, "ACTIVE");
                    message = success ? "Người dùng đã được phê duyệt làm Nhà báo!" : "Lỗi khi phê duyệt.";
                } else if ("reject".equals(action)) {
                    // Từ chối: Đưa về quyền USER (1) và đặt trạng thái REJECTED để họ biết
                    success = userDao.updateUserRoleAndStatus(userId, 1, "REJECTED");
                    message = success ? "Đã từ chối đơn đăng ký. Người dùng sẽ nhận được thông báo." : "Lỗi khi thực hiện.";
                } else if ("delete".equals(action)) {
                    success = userDao.deleteUser(userId);
                    message = success ? "Tài khoản người dùng đã được xóa hoàn toàn!" : "Lỗi khi xóa.";
                }

                // Trả về JSON cho đồng bộ với App.ajax.post
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                String json = String.format("{\"success\": %b, \"message\": \"%s\"}", success, message);
                response.getWriter().write(json);
                return;

            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}
