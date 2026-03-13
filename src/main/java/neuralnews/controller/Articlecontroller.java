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
public class Articlecontroller extends HttpServlet {

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

        // Fetch data from DB
        ArticleDao dao = new ArticleDao();
        List<Article> articles = dao.getArticlesByAuthor(user.getId());

        // Set status badge
        for (Article a : articles) {
            switch (a.getStatus()) {
                case "PUBLISHED":
                    a.setStatusLabel("\u0110\u00e3 xu\u1ea5t b\u1ea3n");
                    a.setStatusBadgeClass("bg-emerald-100 text-emerald-700 dark:bg-emerald-500/10 dark:text-emerald-400 ring-emerald-500/20");
                    a.setStatusDotClass("bg-emerald-500");
                    break;
                case "DRAFT":
                    a.setStatusLabel("B\u1ea3n nh\u00e1p");
                    a.setStatusBadgeClass("bg-slate-100 text-slate-600 dark:bg-slate-500/10 dark:text-slate-400 ring-slate-500/20");
                    a.setStatusDotClass("bg-slate-400");
                    break;
                case "PENDING":
                    a.setStatusLabel("\u0110ang ch\u1edd");
                    a.setStatusBadgeClass("bg-amber-100 text-amber-700 dark:bg-amber-500/10 dark:text-amber-400 ring-amber-500/20");
                    a.setStatusDotClass("bg-amber-500");
                    break;
                case "REJECTED":
                    a.setStatusLabel("B\u1ecb t\u1eeb ch\u1ed1i");
                    a.setStatusBadgeClass("bg-red-100 text-red-700 dark:bg-red-500/10 dark:text-red-400 ring-red-500/20");
                    a.setStatusDotClass("bg-red-500");
                    break;
                default:
                    a.setStatusLabel(a.getStatus());
                    a.setStatusBadgeClass("bg-slate-100 text-slate-600 dark:bg-slate-500/10 dark:text-slate-400 ring-slate-500/20");
                    a.setStatusDotClass("bg-slate-400");
            }

            // Format views
            int views = a.getViews();
            if (views >= 1_000_000) {
                a.setFormattedViews(String.format("%.1fM", views / 1_000_000.0));
            } else if (views >= 1_000) {
                a.setFormattedViews(String.format("%.1fk", views / 1_000.0));
            } else {
                a.setFormattedViews(String.valueOf(views));
            }
        }

        // Forward to JSP
        request.setAttribute("articles", articles);
        request.getRequestDispatcher("/journalist/articles.jsp")
                .forward(request, response);
    }
}