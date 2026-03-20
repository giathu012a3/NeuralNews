package neuralnews.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.google.gson.Gson;
import neuralnews.dao.ArticleDao;
import neuralnews.dao.CategoryDao;
import neuralnews.model.Article;

@WebServlet("/admin/content")
public class AdminContentController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ArticleDao dao;
    private CategoryDao categoryDao;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        super.init();
        dao = new ArticleDao();
        categoryDao = new CategoryDao();
        gson = new Gson();

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // ── Params lọc ───────────────────────────────────────────────────────
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        String authorName = request.getParameter("authorName");
        String sortBy = request.getParameter("sortBy");
        String sortDir = request.getParameter("sortDir");
        String exportCsv = request.getParameter("export");

        String catIdStr = request.getParameter("categoryId");
        Integer categoryId = null;
        if (catIdStr != null && !catIdStr.isEmpty() && !"ALL".equals(catIdStr)) {
            try {
                categoryId = Integer.parseInt(catIdStr);
            } catch (NumberFormatException e) {
            }
        }
        if ("ALL".equals(status))
            status = null;

        // Map sortBy từ UI → column DB
        if ("date".equals(sortBy))
            sortBy = "a.created_at";
        else if ("views".equals(sortBy))
            sortBy = "a.views";
        else if ("title".equals(sortBy))
            sortBy = "a.title";
        else
            sortBy = "a.created_at";

        if (!"ASC".equalsIgnoreCase(sortDir))
            sortDir = "DESC";

        // ── Phân trang ───────────────────────────────────────────────────────
        int pageNum = 1, limit = 10;
        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                pageNum = Math.max(1, Integer.parseInt(pageStr));
            } catch (NumberFormatException e) {
            }
        }
        int offset = (pageNum - 1) * limit;

        // ── Lấy dữ liệu ──────────────────────────────────────────────────────
        List<Article> articles = dao.getAllArticlesFiltered(
                limit, offset, keyword, status, categoryId, authorName, sortBy, sortDir);
        int totalArticles = dao.getTotalArticleCount(keyword, status, categoryId, authorName);
        int totalPages = (int) Math.ceil((double) totalArticles / limit);

        // ── Label / Badge cho status ─────────────────────────────────────────
        for (Article a : articles) {
            String s = a.getStatus();
            if ("PUBLISHED".equals(s)) {
                a.setStatusLabel("ĐÃ ĐĂNG");
                a.setStatusBadgeClass("bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400");
            } else if ("PENDING".equals(s)) {
                a.setStatusLabel("CHỜ DUYỆT");
                a.setStatusBadgeClass("bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400");
            } else if ("REJECTED".equals(s)) {
                a.setStatusLabel("BỊ TỪ CHỐI");
                a.setStatusBadgeClass("bg-red-100 text-red-700 dark:bg-red-500/10 dark:text-red-400");
            } else if ("ARCHIVED".equals(s)) {
                a.setStatusLabel("ĐÃ LƯU TRỮ");
                a.setStatusBadgeClass("bg-slate-100 text-slate-600 dark:bg-slate-500/10 dark:text-slate-400");
            }
            int v = a.getViews();
            a.setFormattedViews(v >= 1000 ? String.format("%.1fK", v / 1000.0) : String.valueOf(v));
        }

        // ── Export CSV ───────────────────────────────────────────────────────
        if ("csv".equals(exportCsv)) {
            response.setContentType("text/csv; charset=UTF-8");
            response.setHeader("Content-Disposition", "attachment; filename=\"articles.csv\"");
            PrintWriter pw = response.getWriter();
            pw.println("ID,Tiêu đề,Tác giả,Danh mục,Trạng thái,Lượt xem,Ngày tạo");
            for (Article a : dao.getAllArticlesFiltered(Integer.MAX_VALUE, 0, keyword, status, categoryId, authorName,
                    sortBy, sortDir)) {
                pw.printf("\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"%n",
                        a.getId(),
                        esc(a.getTitle()),
                        esc(a.getAuthorName()),
                        esc(a.getCategoryName()),
                        esc(a.getStatus()),
                        a.getViews(),
                        a.getCreatedAt() != null ? a.getCreatedAt().toString() : "");
            }
            pw.flush();
            return;
        }

        // ── Stats bar (chỉ khi full-page load) ──────────────────────────────
        String requestedWith = request.getHeader("X-Requested-With");
        if (!"XMLHttpRequest".equals(requestedWith)) {
            Map<String, Integer> stats = dao.getArticleStatsByStatus();
            request.setAttribute("statTotal", stats.getOrDefault("TOTAL", 0));
            request.setAttribute("statPending", stats.getOrDefault("PENDING", 0));
            request.setAttribute("statPublished", stats.getOrDefault("PUBLISHED", 0));
            request.setAttribute("statRejected", stats.getOrDefault("REJECTED", 0));
            request.setAttribute("statArchived", stats.getOrDefault("ARCHIVED", 0));
        }

        request.setAttribute("articles", articles);
        request.setAttribute("currentPage", pageNum);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalArticles", totalArticles);
        request.setAttribute("limit", limit);
        request.setAttribute("categories", categoryDao.getAllCategory());

        request.setAttribute("currentSortBy",
                request.getParameter("sortBy") != null ? request.getParameter("sortBy") : "date");
        request.setAttribute("currentSortDir", sortDir);

        if ("XMLHttpRequest".equals(requestedWith)) {
            request.getRequestDispatcher("/admin/components/article_table_partial.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/admin/content.jsp").forward(request, response);
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
        String articleIdStr = request.getParameter("articleId");

        boolean success = false;
        HttpSession session = request.getSession();
        Long reviewerId = (Long) session.getAttribute("userId");
        String message = "";

        if ("bulk_approve".equals(action)) {
            String[] ids = request.getParameterValues("articleIds[]");
            if (ids == null)
                ids = request.getParameterValues("ids[]");
            if (ids != null && ids.length > 0) {
                try {
                    int count = 0;
                    for (String idStr : ids) {
                        if (dao.updateArticleStatus(Long.parseLong(idStr), "PUBLISHED", reviewerId))
                            count++;
                    }
                    success = true;
                    message = "Đã duyệt thành công " + count + " bài viết";
                } catch (Exception e) {
                    e.printStackTrace();
                    message = "Lỗi khi duyệt hàng loạt";
                }
            } else {
                message = "Không có bài viết nào được chọn để duyệt.";
            }

        } else if ("bulk_hide".equals(action)) {
            String[] ids = request.getParameterValues("articleIds[]");
            if (ids == null)
                ids = request.getParameterValues("ids[]");
            if (ids != null && ids.length > 0) {
                try {
                    int count = 0;
                    for (String idStr : ids) {
                        if (dao.updateArticleStatus(Long.parseLong(idStr), "ARCHIVED", reviewerId))
                            count++;
                    }
                    success = true;
                    message = "Đã ẩn " + count + " bài viết";
                } catch (Exception e) {
                    e.printStackTrace();
                    message = "Lỗi khi ẩn hàng loạt";
                }
            } else {
                message = "Không có bài viết nào được chọn.";
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
                    case "reject_with_reason":
                        String reason = request.getParameter("reason");
                        success = dao.updateArticleStatus(articleId, "REJECTED", reviewerId);
                        message = success
                                ? "Đã từ chối. Lý do: " + (reason != null ? reason.replace("\"", "'") : "")
                                : "Thao tác thất bại";
                        break;
                    case "archive":
                        success = dao.updateArticleStatus(articleId, "ARCHIVED", reviewerId);
                        message = success ? "Đã lưu trữ bài viết" : "Lỗi khi lưu trữ";
                        break;
                    case "hide":
                        success = dao.updateArticleStatus(articleId, "ARCHIVED", reviewerId);
                        message = success ? "Đã ẩn bài viết" : "Lỗi khi ẩn bài viết";
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

        PrintWriter out = response.getWriter();
        out.print("{\"success\": " + success + ", \"message\": \"" + message.replace("\"", "'") + "\"}");
        out.flush();
    }
}
