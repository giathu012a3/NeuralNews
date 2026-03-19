package neuralnews.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import neuralnews.dao.CategoryDao;

/**
 * Servlet xử lý CRUD danh mục cho Admin.
 * URL mapping: /admin/categories
 *
 *  GET  /admin/categories          -> hiển thị trang categories.jsp
 *  POST /admin/categories?action=create  -> tạo mới
 *  POST /admin/categories?action=update  -> cập nhật (params: id, name, description)
 *  POST /admin/categories?action=delete  -> xóa (param: id)
 */
@WebServlet("/admin/categories")
public class AdminCategoryController extends HttpServlet {

    private final CategoryDao categoryDao = new CategoryDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("categories", categoryDao.getAllCategoryWithArticleCount());
        req.getRequestDispatcher("/admin/categories.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");
        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        String action = req.getParameter("action");
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String idStr = req.getParameter("id");

        try {
            switch (action == null ? "" : action) {
                case "create": {
                    if (name == null || name.trim().isEmpty()) {
                        resp.setStatus(400);
                        out.print("{\"success\":false,\"message\":\"Tên danh mục không được để trống.\"}");
                        return;
                    }
                    if (categoryDao.nameExists(name, -1)) {
                        resp.setStatus(409);
                        out.print("{\"success\":false,\"message\":\"Tên danh mục đã tồn tại.\"}");
                        return;
                    }
                    boolean ok = categoryDao.createCategory(name, description);
                    if (ok) {
                        out.print("{\"success\":true,\"message\":\"Tạo danh mục thành công.\"}");
                    } else {
                        resp.setStatus(500);
                        out.print("{\"success\":false,\"message\":\"Lỗi server khi tạo danh mục.\"}");
                    }
                    break;
                }
                case "update": {
                    int id = Integer.parseInt(idStr);
                    if (name == null || name.trim().isEmpty()) {
                        resp.setStatus(400);
                        out.print("{\"success\":false,\"message\":\"Tên danh mục không được để trống.\"}");
                        return;
                    }
                    if (categoryDao.nameExists(name, id)) {
                        resp.setStatus(409);
                        out.print("{\"success\":false,\"message\":\"Tên danh mục đã tồn tại.\"}");
                        return;
                    }
                    boolean ok = categoryDao.updateCategory(id, name, description);
                    if (ok) {
                        out.print("{\"success\":true,\"message\":\"Cập nhật danh mục thành công.\"}");
                    } else {
                        resp.setStatus(500);
                        out.print("{\"success\":false,\"message\":\"Lỗi server khi cập nhật.\"}");
                    }
                    break;
                }
                case "delete": {
                    int id = Integer.parseInt(idStr);
                    boolean ok = categoryDao.deleteCategory(id);
                    if (ok) {
                        out.print("{\"success\":true,\"message\":\"Xóa danh mục thành công. Các bài viết liên quan sẽ được bỏ phân loại.\"}");
                    } else {
                        resp.setStatus(500);
                        out.print("{\"success\":false,\"message\":\"Lỗi server khi xóa.\"}");
                    }
                    break;
                }
                default:
                    resp.setStatus(400);
                    out.print("{\"success\":false,\"message\":\"Action không hợp lệ.\"}");
            }
        } catch (NumberFormatException e) {
            resp.setStatus(400);
            out.print("{\"success\":false,\"message\":\"ID không hợp lệ.\"}");
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(500);
            out.print("{\"success\":false,\"message\":\"Lỗi server.\"}");
        }
    }
}
