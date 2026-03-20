package neuralnews.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import neuralnews.dao.ArticleDao;
import neuralnews.model.Article;
import neuralnews.model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/journalist/articles")
public class StaffArticlecontroller extends HttpServlet {

    private static final int PAGE_SIZE = 8;

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }

        // ── Xử lý action delete / archive ────────────────────────────────
        String action  = request.getParameter("action");
        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isBlank() && action != null) {
            String page    = request.getParameter("page");
            String keyword = req(request, "keyword");
            String status2 = req(request, "status");
            String cat     = req(request, "category");
            String dfrom   = req(request, "dateFrom");
            String dto     = req(request, "dateTo");

            try {
                long articleId = Long.parseLong(idParam);
                ArticleDao dao = new ArticleDao();
                switch (action) {
                    case "delete"  -> dao.deleteArticle(articleId, user.getId());
                    case "archive" -> dao.updateArticleStatus(articleId, user.getId(), "ARCHIVED");
                }
            } catch (NumberFormatException ignored) {}

            // Redirect về đúng trang đang đứng, giữ nguyên filter
            StringBuilder redirect = new StringBuilder(request.getContextPath() + "/journalist/articles?");
            if (page != null && !page.isBlank()) redirect.append("page=").append(page).append("&");
            redirect.append("keyword=").append(java.net.URLEncoder.encode(keyword, "UTF-8")).append("&");
            redirect.append("status=").append(java.net.URLEncoder.encode(status2, "UTF-8")).append("&");
            redirect.append("category=").append(java.net.URLEncoder.encode(cat, "UTF-8")).append("&");
            redirect.append("dateFrom=").append(java.net.URLEncoder.encode(dfrom, "UTF-8")).append("&");
            redirect.append("dateTo=").append(java.net.URLEncoder.encode(dto, "UTF-8")).append("&");
            redirect.append("success=true");
            response.sendRedirect(redirect.toString());
            return;
        }

        // ── Đọc tham số lọc ──────────────────────────────────────────────
        String keyword  = req(request, "keyword");
        String status   = req(request, "status");
        String category = req(request, "category");
        String dateFrom = req(request, "dateFrom");
        String dateTo   = req(request, "dateTo");

        // ── Phân trang ───────────────────────────────────────────────────
        int page = 1;
        try {
            String p = request.getParameter("page");
            if (p != null) page = Math.max(1, Integer.parseInt(p));
        } catch (NumberFormatException ignored) {}

        // ── Gọi DAO ──────────────────────────────────────────────────────
        ArticleDao dao = new ArticleDao();

        int total      = dao.countArticlesByAuthorFiltered(user.getId(), keyword, status, category, dateFrom, dateTo);
        int totalPages = Math.max(1, (int) Math.ceil((double) total / PAGE_SIZE));
        page           = Math.min(page, totalPages);
        int offset     = (page - 1) * PAGE_SIZE;

        List<Article> articles = dao.getArticlesByAuthorFiltered(
                user.getId(), keyword, status, category, dateFrom, dateTo, offset, PAGE_SIZE);

        List<String> categories = dao.getCategoriesByAuthor(user.getId());

        // ── Format badge / views ──────────────────────────────────────────
        for (Article a : articles) {
            switch (a.getStatus() != null ? a.getStatus() : "") {
                case "PUBLISHED":
                    a.setStatusLabel("Đã xuất bản");
                    a.setStatusBadgeClass("bg-emerald-100 text-emerald-700 dark:bg-emerald-500/10 dark:text-emerald-400 ring-emerald-500/20");
                    a.setStatusDotClass("bg-emerald-500");
                    break;
                case "DRAFT":
                    a.setStatusLabel("Bản nháp");
                    a.setStatusBadgeClass("bg-slate-100 text-slate-600 dark:bg-slate-500/10 dark:text-slate-400 ring-slate-500/20");
                    a.setStatusDotClass("bg-slate-400");
                    break;
                case "PENDING":
                    a.setStatusLabel("Đang chờ");
                    a.setStatusBadgeClass("bg-amber-100 text-amber-700 dark:bg-amber-500/10 dark:text-amber-400 ring-amber-500/20");
                    a.setStatusDotClass("bg-amber-500");
                    break;
                case "REJECTED":
                    a.setStatusLabel("Bị từ chối");
                    a.setStatusBadgeClass("bg-red-100 text-red-700 dark:bg-red-500/10 dark:text-red-400 ring-red-500/20");
                    a.setStatusDotClass("bg-red-500");
                    break;
                case "ARCHIVED":
                    a.setStatusLabel("Lưu trữ");
                    a.setStatusBadgeClass("bg-violet-100 text-violet-700 dark:bg-violet-500/10 dark:text-violet-400 ring-violet-500/20");
                    a.setStatusDotClass("bg-violet-400");
                    break;
                default:
                    a.setStatusLabel(a.getStatus() != null ? a.getStatus() : "");
                    a.setStatusBadgeClass("bg-slate-100 text-slate-600 dark:bg-slate-500/10 dark:text-slate-400 ring-slate-500/20");
                    a.setStatusDotClass("bg-slate-400");
            }
            int v = a.getViews();
            if      (v >= 1_000_000) a.setFormattedViews(String.format("%.1fM", v / 1_000_000.0));
            else if (v >= 1_000)     a.setFormattedViews(String.format("%.1fk", v / 1_000.0));
            else                     a.setFormattedViews(String.valueOf(v));
        }

        // ── Set attributes → forward sang JSP ────────────────────────────
        request.setAttribute("articles",       articles);
        request.setAttribute("categories",     categories);
        request.setAttribute("totalArticles",  total);
        request.setAttribute("totalPages",     totalPages);
        request.setAttribute("currentPage",    page);
        request.setAttribute("pageSize",       PAGE_SIZE);
        request.setAttribute("filterKeyword",  keyword);
        request.setAttribute("filterStatus",   status);
        request.setAttribute("filterCategory", category);
        request.setAttribute("filterDateFrom", dateFrom);
        request.setAttribute("filterDateTo",   dateTo);

        request.getRequestDispatcher("/journalist/articles.jsp").forward(request, response);
    }

    private String req(HttpServletRequest r, String name) {
        String v = r.getParameter(name);
        return v != null ? v.trim() : "";
    }
}