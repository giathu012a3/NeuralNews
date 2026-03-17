package neuralnews.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.google.gson.Gson;
import neuralnews.dao.ArticleDao;
import neuralnews.model.Article;

@WebServlet("/admin/content")
public class AdminContentController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ArticleDao dao;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        super.init();
        dao = new ArticleDao();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        
        // Nhận tham số lọc
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        String catIdStr = request.getParameter("categoryId");
        Integer categoryId = null;
        if (catIdStr != null && !catIdStr.isEmpty() && !"ALL".equals(catIdStr)) {
            try { categoryId = Integer.parseInt(catIdStr); } catch (NumberFormatException e) {}
        }
        if ("ALL".equals(status)) status = null;

        int pageNum = 1;
        int limit = 10;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                pageNum = Integer.parseInt(pageStr);
                if (pageNum < 1) pageNum = 1;
            } catch (NumberFormatException e) { pageNum = 1; }
        }

        int offset = (pageNum - 1) * limit;

        // Lấy dữ liệu có filter
        List<Article> articles = dao.getAllArticlesFiltered(limit, offset, keyword, status, categoryId);
        int totalArticles = dao.getTotalArticleCount(keyword, status, categoryId);
        int totalPages = (int) Math.ceil((double) totalArticles / limit);

        for (Article article : articles) {
            String s = article.getStatus();
            if ("PUBLISHED".equals(s)) {
                article.setStatusLabel("ĐÃ ĐĂNG");
                article.setStatusBadgeClass("bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400");
            } else if ("PENDING".equals(s)) {
                article.setStatusLabel("CHỜ DUYỆT");
                article.setStatusBadgeClass("bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400");
            } else if ("REJECTED".equals(s)) {
                article.setStatusLabel("BỊ TỪ CHỐI");
                article.setStatusBadgeClass("bg-red-100 text-red-700 dark:bg-red-500/10 dark:text-red-400");
            } else if ("ARCHIVED".equals(s)) {
                article.setStatusLabel("ĐÃ LƯU TRỮ");
                article.setStatusBadgeClass("bg-slate-100 text-slate-600 dark:bg-slate-500/10 dark:text-slate-400");
            }

            int v = article.getViews();
            article.setFormattedViews(v >= 1000 ? String.format("%.1fK", v / 1000.0) : String.valueOf(v));
        }

        request.setAttribute("articles", articles);
        request.setAttribute("currentPage", pageNum);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalArticles", totalArticles);
        request.setAttribute("limit", limit);
        request.setAttribute("categories", dao.getAllCategories());

        // Kiểm tra nếu là AJAX request
        String requestedWith = request.getHeader("X-Requested-With");
        if ("XMLHttpRequest".equals(requestedWith)) {
            request.getRequestDispatcher("/admin/components/article_table_partial.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/admin/content.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String articleIdStr = request.getParameter("articleId");

        boolean success = false;

        HttpSession session = request.getSession();
        Long reviewerId = (Long) session.getAttribute("userId");

        String message = "";
        if ("bulk_approve".equals(action)) {
            String[] ids = request.getParameterValues("articleIds[]");
            if (ids == null) ids = request.getParameterValues("ids[]");
            
            if (ids != null && ids.length > 0) {
                try {
                    int count = 0;
                    for (String idStr : ids) {
                        long id = Long.parseLong(idStr);
                        if(dao.updateArticleStatus(id, "PUBLISHED", reviewerId)) count++;
                    }
                    success = true;
                    message = "Đã duyệt thành công " + count + " bài viết";
                } catch (Exception e) {
                    success = false;
                    message = "Lỗi hệ thống khi duyệt hàng loạt";
                    e.printStackTrace();
                }
            } else {
                message = "Không có bài viết nào được chọn để duyệt.";
            }
        } else if (action != null && articleIdStr != null) {
            try {
                long articleId = Long.parseLong(articleIdStr);
                switch (action) {
                    case "approve":
                        success = dao.updateArticleStatus(articleId, "PUBLISHED", reviewerId);
                        message = success ? "Phê duyệt bài viết thành công" : "Không thể phê duyệt bài viết";
                        break;
                    case "reject":
                        success = dao.updateArticleStatus(articleId, "REJECTED", reviewerId);
                        message = success ? "Đã từ chối bài viết" : "Thao tác thất bại";
                        break;
                    case "archive":
                        success = dao.updateArticleStatus(articleId, "ARCHIVED", reviewerId);
                        message = success ? "Đã đưa bài viết vào kho lưu trữ" : "Lỗi khi lưu trữ";
                        break;
                    default:
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        message = "Hành động không hợp lệ.";
                        return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                message = "ID bài viết không hợp lệ.";
                return;
            } catch (Exception e) {
                e.printStackTrace();
                success = false;
                message = "Lỗi xử lý yêu cầu";
            }
        } else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            message = "Yêu cầu không hợp lệ.";
            return;
        }

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.print("{\"success\": " + success + ", \"message\": \"" + message + "\"}");
        out.flush();
    }
}
