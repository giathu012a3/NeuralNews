package neuralnews.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import neuralnews.dao.ArticleDao;
import neuralnews.model.Article;
import neuralnews.model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/journalist/create-article")
public class CreateArticleController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }

        ArticleDao dao = new ArticleDao();

        // Nếu có ?id=xxx thì load bài viết để edit
        String idParam = request.getParameter("id");
        if (idParam != null) {
            try {
                long articleId = Long.parseLong(idParam);
                Article article = dao.getById(articleId);
                if (article != null && article.getAuthorId() == user.getId()) {
                    request.setAttribute("article", article);
                }
            } catch (NumberFormatException ignored) {}
        }

        // Load categories cho dropdown
        List<neuralnews.model.Category> categories = dao.getAllCategories();
        request.setAttribute("categories", categories);
        request.setAttribute("currentUser", user);

        request.getRequestDispatcher("/journalist/create_article.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }

        // ── Đọc form ─────────────────────────────────────────────────────
        String idParam     = request.getParameter("articleId");
        String title       = request.getParameter("title");
        String content     = request.getParameter("content");
        String summary     = request.getParameter("summary");
        String imageUrl    = request.getParameter("imageUrl");
        String categoryStr = request.getParameter("categoryId");
        String action      = request.getParameter("action"); // "draft" | "submit"

        // Validate
        if (title == null || title.isBlank()) {
            response.sendRedirect(request.getContextPath() + "/journalist/create-article?error=empty_title");
            return;
        }

        // ── Xác định trạng thái ───────────────────────────────────────────
        // "draft"  → DRAFT  (lưu nháp, chưa gửi)
        // "submit" → PENDING (gửi để admin duyệt)
        // PUBLISHED chỉ do admin set, journalist không được tự publish
        String status = "submit".equals(action) ? "PENDING" : "DRAFT";

        Article article = new Article();
        article.setTitle(title.trim());
        article.setContent(content != null ? content : "");
        article.setSummary(summary != null ? summary.trim() : "");
        String normalizedImageUrl = imageUrl != null ? imageUrl.trim() : "";
        // Nếu client gửi full path có contextPath (vd: /NeuralNews/uploads/..)
        // thì strip để DB luôn lưu relative (uploads/..) hoặc URL tuyệt đối (http..)
        String ctx = request.getContextPath();
        if (!normalizedImageUrl.isEmpty() && !normalizedImageUrl.startsWith("http")) {
            if (normalizedImageUrl.startsWith(ctx + "/")) {
                normalizedImageUrl = normalizedImageUrl.substring(ctx.length() + 1);
            } else if (normalizedImageUrl.startsWith("/")) {
                normalizedImageUrl = normalizedImageUrl.substring(1);
            }
        }
        article.setImageUrl(normalizedImageUrl);
        article.setAuthorId(user.getId());
        article.setStatus(status);
        try {
            if (categoryStr != null && !categoryStr.isBlank())
                article.setCategoryId(Integer.parseInt(categoryStr));
        } catch (NumberFormatException ignored) {}

        ArticleDao dao = new ArticleDao();

        if (idParam != null && !idParam.isBlank()) {
            // ── Edit bài cũ ───────────────────────────────────────────────
            article.setId(Long.parseLong(idParam));

            // Nếu bài đang PUBLISHED thì không cho đổi status
            // (tránh journalist tự ý kéo bài đã duyệt về DRAFT)
            Article existing = dao.getById(article.getId());
            if (existing != null && "PUBLISHED".equals(existing.getStatus())) {
                article.setStatus("PUBLISHED");
            }

            dao.update(article);
            response.sendRedirect(request.getContextPath() + "/journalist/articles");

        } else {
            // ── Tạo mới ───────────────────────────────────────────────────
            long newId = dao.save(article);
            if (newId > 0) {
                if ("submit".equals(action)) {
                    // Gửi duyệt → về danh sách bài viết
                    response.sendRedirect(request.getContextPath() + "/journalist/articles?submitted=true");
                } else {
                    // Lưu nháp → ở lại trang edit để tiếp tục viết
                    response.sendRedirect(request.getContextPath()
                            + "/journalist/create-article?id=" + newId + "&saved=true");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/journalist/create-article?error=save_failed");
            }
        }
    }
}