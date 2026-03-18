package neuralnews.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import neuralnews.dao.CommentDao;
import neuralnews.model.Comment;
import neuralnews.model.User;

import java.io.IOException;
import java.time.Duration;
import java.time.Instant;
import java.util.List;

@WebServlet("/journalist/comments")
public class StaffCommentController extends HttpServlet {

    private static final int PAGE_SIZE = 10;

    // ─────────────────────────────────────────────────────────────────────────
    // GET — hiển thị danh sách bình luận (có hỗ trợ search, sort, phân trang)
    // ─────────────────────────────────────────────────────────────────────────
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Kiểm tra đăng nhập
        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }

        // ── Sort ─────────────────────────────────────────────────────────────
        String sort = request.getParameter("sort");
        if (!"oldest".equals(sort)) sort = "latest";

        // ── Keyword search ───────────────────────────────────────────────────
        String keyword = request.getParameter("keyword");
        if (keyword != null && keyword.trim().isEmpty()) keyword = null;

        // ── Phân trang ───────────────────────────────────────────────────────
        int page = 1;
        try {
            page = Math.max(1, Integer.parseInt(request.getParameter("page")));
        } catch (Exception ignored) {}

        // ── Query DB ─────────────────────────────────────────────────────────
        CommentDao dao    = new CommentDao();
        int total         = dao.countCommentsByAuthor(user.getId(), keyword);
        int totalPages    = Math.max(1, (int) Math.ceil((double) total / PAGE_SIZE));
        if (page > totalPages) page = totalPages;

        List<Comment> comments = dao.getCommentsByAuthor(
                user.getId(), (page - 1) * PAGE_SIZE, PAGE_SIZE, sort, keyword);

        // ── Trang trí mỗi comment (status, time, avatar, replies) ────────────
        for (Comment c : comments) {
            setStatusStyle(c);
            setFormattedTime(c);
            setUserAvatar(c);
            List<Comment> replies = dao.getReplies(c.getId());
            for (Comment r : replies) {
                setStatusStyle(r);
                setFormattedTime(r);
                setUserAvatar(r);
            }
            c.setReplies(replies);
        }

        // ── Set attributes cho JSP ───────────────────────────────────────────
        request.setAttribute("comments",      comments);
        request.setAttribute("totalComments", total);
        request.setAttribute("currentPage",   page);
        request.setAttribute("totalPages",    totalPages);
        request.setAttribute("sort",          sort);
        request.setAttribute("keyword",       keyword != null ? keyword : "");

        request.getRequestDispatcher("/journalist/comments.jsp").forward(request, response);
    }

    // ─────────────────────────────────────────────────────────────────────────
    // POST — xử lý action: spam, hide, delete, restore, reply
    // ─────────────────────────────────────────────────────────────────────────
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }

        String action   = request.getParameter("action");
        String idParam  = request.getParameter("commentId");
        String page     = request.getParameter("page");
        String sort     = request.getParameter("sort");
        String keyword  = request.getParameter("keyword");
        if (sort == null) sort = "latest";

        if (idParam != null && action != null) {
            long commentId = Long.parseLong(idParam);
            CommentDao dao = new CommentDao();
            switch (action) {
                case "delete"  -> dao.deleteComment(commentId);
                case "spam"    -> dao.updateStatus(commentId, "SPAM");
                case "hide"    -> dao.updateStatus(commentId, "HIDDEN");
                case "restore" -> dao.updateStatus(commentId, "NEUTRAL");
                case "reply"   -> {
                    String content    = request.getParameter("replyContent");
                    String articleStr = request.getParameter("articleId");
                    if (content != null && !content.isBlank() && articleStr != null)
                        dao.addReply(Long.parseLong(articleStr), user.getId(), commentId, content.trim());
                }
            }
        }

        // Redirect về lại trang, giữ nguyên sort + page + keyword
        StringBuilder redirect = new StringBuilder(request.getContextPath() + "/journalist/comments");
        redirect.append("?sort=").append(sort);
        if (page != null && !page.isEmpty())    redirect.append("&page=").append(page);
        if (keyword != null && !keyword.isEmpty()) redirect.append("&keyword=").append(
                java.net.URLEncoder.encode(keyword, "UTF-8"));

        response.sendRedirect(redirect.toString());
    }

    // ─────────────────────────────────────────────────────────────────────────
    // HELPERS
    // ─────────────────────────────────────────────────────────────────────────

    private void setStatusStyle(Comment c) {
        switch (c.getStatus() == null ? "" : c.getStatus()) {
            case "SPAM"   -> {
                // Với nhà báo, hiển thị mềm hơn: "Đã báo cáo"
                c.setStatusLabel("Đã báo cáo");
                c.setStatusBadgeClass("bg-red-100 text-red-700 dark:bg-red-500/10 dark:text-red-400 ring-red-500/20");
                c.setStatusDotClass("bg-red-500");
            }
            case "HIDDEN" -> {
                c.setStatusLabel("Đã ẩn");
                c.setStatusBadgeClass("bg-slate-100 text-slate-600 dark:bg-slate-500/10 dark:text-slate-400 ring-slate-500/20");
                c.setStatusDotClass("bg-slate-400");
            }
            default -> {
                c.setStatusLabel("Bình thường");
                c.setStatusBadgeClass("bg-emerald-100 text-emerald-700 dark:bg-emerald-500/10 dark:text-emerald-400 ring-emerald-500/20");
                c.setStatusDotClass("bg-emerald-500");
            }
        }
    }

    private void setFormattedTime(Comment c) {
        if (c.getCreatedAt() == null) { c.setFormattedTime("Không rõ"); return; }
        Duration diff = Duration.between(c.getCreatedAt().toInstant(), Instant.now());
        long m = diff.toMinutes(), h = diff.toHours(), d = diff.toDays();
        if      (m < 1)  c.setFormattedTime("Vừa xong");
        else if (m < 60) c.setFormattedTime(m + " phút trước");
        else if (h < 24) c.setFormattedTime(h + " giờ trước");
        else if (d < 30) c.setFormattedTime(d + " ngày trước");
        else             c.setFormattedTime(d / 30 + " tháng trước");
    }

    private void setUserAvatar(Comment c) {
        String name = c.getUserName();
        if (name == null || name.isBlank()) {
            c.setUserAvatar("?");
            c.setUserAvatarBgClass("bg-slate-100 dark:bg-slate-800 text-slate-600");
            return;
        }
        String[] parts = name.trim().split("\\s+");
        String initials = parts.length >= 2
                ? ("" + parts[0].charAt(0) + parts[parts.length - 1].charAt(0)).toUpperCase()
                : name.substring(0, Math.min(2, name.length())).toUpperCase();
        c.setUserAvatar(initials);
        String[] colors = {
            "bg-blue-100 dark:bg-blue-900/40 text-blue-600 dark:text-blue-400",
            "bg-violet-100 dark:bg-violet-900/40 text-violet-600 dark:text-violet-400",
            "bg-amber-100 dark:bg-amber-900/40 text-amber-600 dark:text-amber-400",
            "bg-emerald-100 dark:bg-emerald-900/40 text-emerald-600 dark:text-emerald-400",
            "bg-rose-100 dark:bg-rose-900/40 text-rose-600 dark:text-rose-400",
        };
        c.setUserAvatarBgClass(colors[(int)(c.getUserId() % colors.length)]);
    }
}