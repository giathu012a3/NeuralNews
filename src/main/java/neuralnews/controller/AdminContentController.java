package neuralnews.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
        response.setContentType("text/html;charset=UTF-8");

        int pageNum = 1;
        int limit = 10;

        String pageStr = request.getParameter("page");
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                pageNum = Integer.parseInt(pageStr);
                if (pageNum < 1)
                    pageNum = 1;
            } catch (NumberFormatException e) {
                pageNum = 1;
            }
        }

        int offset = (pageNum - 1) * limit;

        List<Article> articles = dao.getAllArticles(limit, offset);

        for (Article article : articles) {
            String status = article.getStatus();
            // Set display label (tiếng Việt) và badge CSS cho JSP
            if ("PUBLISHED".equals(status)) {
                article.setStatusLabel("ĐÃ ĐĂNG");
                article.setStatusBadgeClass("bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400");
            } else if ("PENDING".equals(status)) {
                article.setStatusLabel("CHỜ DUYỆT");
                article.setStatusBadgeClass("bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400");
            } else if ("REJECTED".equals(status)) {
                article.setStatusLabel("BỊ TỪ CHỐI");
                article.setStatusBadgeClass("bg-red-100 text-red-700 dark:bg-red-500/10 dark:text-red-400");
            } else if ("ARCHIVED".equals(status)) {
                article.setStatusLabel("ĐÃ LƯU TRỮ");
                article.setStatusBadgeClass("bg-slate-100 text-slate-600 dark:bg-slate-500/10 dark:text-slate-400");
            } else {
                article.setStatusLabel(status != null ? status : "N/A");
                article.setStatusBadgeClass("bg-slate-100 text-slate-600");
            }

            // Format views
            int views = article.getViews();
            if (views >= 1000) {
                article.setFormattedViews(String.format("%.1fK", views / 1000.0));
            } else {
                article.setFormattedViews(String.valueOf(views));
            }
        }

        int totalArticles = dao.getTotalArticleCount();
        int totalPages = (int) Math.ceil((double) totalArticles / limit);

        request.setAttribute("articles", articles);
        request.setAttribute("currentPage", pageNum);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalArticles", totalArticles);
        request.setAttribute("limit", limit);

        request.getRequestDispatcher("/admin/content.jsp").forward(request, response);
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

        if ("bulk_approve".equals(action)) {
            String[] ids = request.getParameterValues("ids[]");
            if (ids != null && ids.length > 0) {
                try {
                    for (String idStr : ids) {
                        int id = Integer.parseInt(idStr);
                        dao.updateArticleStatus(id, "PUBLISHED");
                    }
                    success = true;
                } catch (Exception e) {
                    success = false;
                    e.printStackTrace();
                }
            }
        } else if (action != null && articleIdStr != null) {
            try {
                int articleId = Integer.parseInt(articleIdStr);

                switch (action) {
                    case "approve":
                        success = dao.updateArticleStatus(articleId, "PUBLISHED");
                        break;
                    case "reject":
                        success = dao.updateArticleStatus(articleId, "REJECTED");
                        break;
                    case "archive":
                        success = dao.updateArticleStatus(articleId, "ARCHIVED");
                        break;
                    default:
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                return;
            }
        }

        PrintWriter out = response.getWriter();
        out.print("{\"success\": " + success + "}");
        out.flush();
    }
}
