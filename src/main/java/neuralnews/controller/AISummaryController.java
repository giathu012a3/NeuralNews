package neuralnews.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import neuralnews.dao.ArticleDao;
import neuralnews.model.Article;
import neuralnews.service.GeminiService;

import java.io.IOException;

@WebServlet("/ai-summary")
public class AISummaryController extends HttpServlet {
    private final GeminiService geminiService = new GeminiService();
    private final ArticleDao articleDao = new ArticleDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String articleIdStr = request.getParameter("articleId");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            if (articleIdStr == null || articleIdStr.isEmpty()) {
                response.getWriter().write("{\"error\": \"Không có ID bài viết\"}");
                return;
            }

            long articleId = Long.parseLong(articleIdStr);
            Article article = articleDao.getArticleById(articleId);

            if (article != null) {
                String summary = geminiService.generateSummary(article.getContent());
                
                // Format summary to HTML-friendly structure
                String formattedSummary = summary.replaceAll("\\n", "<br/>").trim();
                
                response.getWriter().write("{\"summary\": \"" + escapeJson(formattedSummary) + "\"}");
            } else {
                response.getWriter().write("{\"error\": \"Không tìm thấy bài viết\"}");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Lỗi máy chủ nội bộ khi tạo tóm tắt\"}");
        }
    }

    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\"", "\\\"");
    }
}
