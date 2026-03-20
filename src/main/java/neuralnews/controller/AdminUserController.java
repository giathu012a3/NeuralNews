package neuralnews.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.google.gson.Gson;
import neuralnews.dao.UserDAO;
import neuralnews.model.User;

@WebServlet("/admin/users")
public class AdminUserController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDao;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        super.init();
        userDao = new UserDAO();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        // Lấy tham số lọc và sắp xếp
        String keyword = request.getParameter("keyword");
        String role    = request.getParameter("role");
        String status  = request.getParameter("status");
        String sortBy  = request.getParameter("sortBy");
        String sortDir = request.getParameter("sortDir");
        String export  = request.getParameter("export");

        if ("ALL".equals(role)) role = null;
        if ("ALL".equals(status)) status = null;
        if (sortBy == null || sortBy.isEmpty()) sortBy = "created_at";
        if (sortDir == null || sortDir.isEmpty()) sortDir = "DESC";
        
        // Xử lý phân trang
        int pageNum = 1, limit = 10;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try { pageNum = Math.max(1, Integer.parseInt(pageStr)); } catch (NumberFormatException e) {}
        }
        int offset = (pageNum - 1) * limit;

        // Xuất file CSV nếu có yêu cầu
        if ("csv".equals(export)) {
            response.setContentType("text/csv; charset=UTF-8");
            response.setHeader("Content-Disposition", "attachment; filename=\"users_export.csv\"");
            PrintWriter pw = response.getWriter();
            pw.write('\ufeff'); // Thêm BOM để Excel nhận diện được UTF-8
            pw.println("ID,Họ và tên,Email,Vai trò,Trạng thái,Ngày tham gia");
            List<User> all = userDao.getAllUsersFiltered(keyword, role, status, sortBy, sortDir, Integer.MAX_VALUE, 0);
            for (User u : all) {
                pw.printf("\"%d\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"%n",
                    u.getId(), esc(u.getFullName()), esc(u.getEmail()),
                    u.getRole() != null ? u.getRole().getName() : "",
                    u.getStatus(),
                    u.getCreatedAt() != null ? u.getCreatedAt().toString() : "");
            }
            pw.flush();
            return;
        }

        // Lấy dữ liệu người dùng
        List<User> users = userDao.getAllUsersFiltered(keyword, role, status, sortBy, sortDir, limit, offset);
        int totalUsers = userDao.getTotalUserCount(keyword, role, status);
        int totalPages = (int) Math.ceil((double) totalUsers / limit);

        // Load thống kê cho Dashboard
        String requestedWith = request.getHeader("X-Requested-With");
        Map<String, Integer> stats = userDao.getUserStats();
        request.setAttribute("statTotal",   stats.getOrDefault("TOTAL", 0));
        request.setAttribute("statActive",  stats.getOrDefault("ACTIVE", 0));
        request.setAttribute("statBanned",  stats.getOrDefault("BANNED", 0));
        request.setAttribute("statPending", stats.getOrDefault("PENDING", 0));
        request.setAttribute("statRejected", stats.getOrDefault("REJECTED", 0));
        request.setAttribute("statDeleted",  stats.getOrDefault("DELETED", 0));

        // Danh sách Nhà báo đang chờ duyệt
        List<User> pendingUsers = userDao.getAllUsersFiltered(null, null, "PENDING", "created_at", "DESC", 6, 0);

        request.setAttribute("users", users);
        request.setAttribute("pendingUsers", pendingUsers);
        request.setAttribute("currentPage", pageNum);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("filterKeyword", keyword);
        request.setAttribute("filterRole", request.getParameter("role"));
        request.setAttribute("filterStatus", request.getParameter("status"));
        request.setAttribute("currentSortBy", sortBy);
        request.setAttribute("currentSortDir", sortDir);

        if ("XMLHttpRequest".equals(requestedWith)) {
            request.getRequestDispatcher("/admin/components/user_table_partial.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
        }
    }

    private String esc(String s) {
        return s != null ? s.replace("\"", "\"\"") : "";
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String userIdStr = request.getParameter("userId");

        boolean success = false;
        String message = "";

        try {
            if ("bulk_approve".equals(action) || "bulk_ban".equals(action) || "bulk_delete".equals(action) || "bulk_restore".equals(action)) {
                String[] ids = request.getParameterValues("ids[]");
                if (ids != null && ids.length > 0) {
                    int count = 0;
                    for (String id : ids) {
                        try {
                            long uid = Long.parseLong(id);
                            if ("bulk_approve".equals(action)) success = userDao.updateUserRoleAndStatus(uid, 2, "ACTIVE");
                            else if ("bulk_ban".equals(action)) success = userDao.updateUserStatus(uid, "BANNED");
                            else if ("bulk_delete".equals(action)) success = userDao.deleteUser(uid);
                            else if ("bulk_restore".equals(action)) success = userDao.updateUserStatus(uid, "ACTIVE");
                            if (success) count++;
                        } catch (Exception e) {}
                    }
                    success = true;
                    message = "Đã xử lý thành công " + count + " người dùng";
                } else { message = "Không có người dùng được chọn."; }
            } else if (userIdStr != null && !userIdStr.trim().isEmpty()) {
                long userId = Long.parseLong(userIdStr);
                switch (action) {
                    case "approve":
                        success = userDao.updateUserRoleAndStatus(userId, 2, "ACTIVE");
                        message = success ? "Đã phê duyệt Nhà báo!" : "Thất bại.";
                        break;
                    case "reject":
                        success = userDao.updateUserRoleAndStatus(userId, 1, "REJECTED");
                        message = success ? "Đã từ chối đơn đăng ký." : "Thất bại.";
                        break;
                    case "ban":
                        success = userDao.updateUserStatus(userId, "BANNED");
                        message = success ? "Đã khóa tài khoản này." : "Lỗi khi khóa.";
                        break;
                    case "unban":
                        success = userDao.updateUserStatus(userId, "ACTIVE");
                        message = success ? "Đã mở khóa tài khoản." : "Lỗi khi mở khóa.";
                        break;
                    case "delete":
                        success = userDao.deleteUser(userId);
                        message = success ? "Đã xóa (ẩn) tài khoản này." : "Lỗi khi xóa.";
                        break;
                    case "restore":
                        success = userDao.updateUserStatus(userId, "ACTIVE");
                        message = success ? "Đã khôi phục tài khoản thành công!" : "Lỗi khi khôi phục.";
                        break;
                    case "changeRole":
                        try {
                            int nrId = Integer.parseInt(request.getParameter("roleId"));
                            success = userDao.updateUserRoleAndStatus(userId, nrId, "ACTIVE");
                            message = success ? "Cập nhật vai trò thành công!" : "Không thể cập nhật.";
                        } catch (Exception e) { message = "ID vai trò không hợp lệ."; }
                        break;
                    case "resetPassword":
                        String newPwd = request.getParameter("newPassword");
                        if (newPwd != null && !newPwd.trim().isEmpty()) {
                            success = userDao.resetPassword(userId, newPwd);
                            message = success ? "Cập nhật mật khẩu thành công!" : "Lỗi khi cập nhật mật khẩu.";
                        } else {
                            message = "Mật khẩu không được để trống.";
                        }
                        break;
                }
            } else if ("add".equals(action)) {
                String fullName = request.getParameter("fullName");
                String email = request.getParameter("email");
                int roleId = Integer.parseInt(request.getParameter("roleId"));

                if (userDao.emailExists(email)) {
                    message = "Email này đã được sử dụng.";
                } else {
                    User newUser = new User();
                    newUser.setFullName(fullName);
                    newUser.setEmail(email);
                    newUser.setPasswordHash("123456"); // Mật khẩu mặc định

                    success = userDao.createUserWithRole(newUser, roleId);
                    message = success ? "Thêm thành viên thành công!" : "Lỗi khi thêm thành viên.";
                }
            } else { message = "Yêu cầu không hợp lệ."; }
        } catch (Exception e) {
            e.printStackTrace();
            message = "Lỗi hệ thống: " + e.getMessage();
        }

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("success", success);
        resultMap.put("message", message);
        response.getWriter().write(gson.toJson(resultMap));
    }
}
