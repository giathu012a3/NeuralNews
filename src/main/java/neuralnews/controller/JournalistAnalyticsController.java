package neuralnews.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import neuralnews.dao.ArticleDao;
import neuralnews.dao.CommentDao;
import neuralnews.model.Article;
import neuralnews.model.User;
import neuralnews.util.DBConnection;

import java.io.IOException;
import java.sql.*;
import java.util.List;

@WebServlet("/journalist/analytics")
public class JournalistAnalyticsController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("currentUser") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }

        long authorId = user.getId();
        ArticleDao articleDao = new ArticleDao();
        CommentDao  commentDao = new CommentDao();

        // ── 1. Stat cards ──────────────────────────────────────────────────
        long totalViews    = getTotalViews(authorId);
        int  totalComments = commentDao.countCommentsByAuthor(authorId);
        int  totalLikes    = getTotalLikes(authorId);
        int  totalPublished= articleDao.countArticlesByAuthorFiltered(authorId,"","PUBLISHED","","","");

        String fmtViews = formatNumber(totalViews);
        String fmtLikes = formatNumber(totalLikes);

        // ── 2. Sentiment tổng từ DB ────────────────────────────────────────
        int[] sentimentCounts = getSentimentCounts(authorId); // [pos, neu, neg]
        int   totalSentiment  = sentimentCounts[0] + sentimentCounts[1] + sentimentCounts[2];
        int   sentimentScore  = totalSentiment > 0
                ? (int)((sentimentCounts[0] * 100.0 + sentimentCounts[1] * 50.0) / totalSentiment) : 50;

        int pctPositive = totalSentiment > 0 ? Math.round(sentimentCounts[0] * 100.0f / totalSentiment) : 0;
        int pctNeutral  = totalSentiment > 0 ? Math.round(sentimentCounts[1] * 100.0f / totalSentiment) : 0;
        int pctNegative = Math.max(0, 100 - pctPositive - pctNeutral);

        // ── 3. weekData[7][3]: sentiment thật theo từng ngày trong tuần ───
        // [dayIndex][0=pos, 1=neu, 2=neg]
        int[][] weekData = getSentimentByDayOfWeek(authorId, pctPositive, pctNeutral, pctNegative);

        // ── 4. Top bài viết ────────────────────────────────────────────────
        List<Article> topArticles = articleDao.getArticlesByAuthorFiltered(
                authorId,"","PUBLISHED","","","",0,10);
        topArticles.sort((a,b) -> b.getViews()-a.getViews());

        for (Article a : topArticles) {
            a.setFormattedViews(formatNumber(a.getViews()));
            double eng = a.getViews() > 0
                    ? Math.min(100, a.getLikesCount() * 100.0 / a.getViews()) : 0;
            a.setEngagementRate(String.format("%.1f%%", eng));
            // Sentiment từ likes/views
            double ratio = a.getViews() > 0 ? (double) a.getLikesCount() / a.getViews() : 0;
            if (ratio >= 0.10) {
                a.setSentimentBadgeClass("bg-emerald-100 text-emerald-700 dark:bg-emerald-500/10 dark:text-emerald-400 ring-emerald-500/20");
                a.setSentimentDotClass("bg-emerald-500"); a.setSentimentText("Tích cực");
                a.setTrendIcon("trending_up"); a.setTrendClass("text-emerald-500");
            } else if (ratio >= 0.03) {
                a.setSentimentBadgeClass("bg-slate-100 text-slate-600 dark:bg-slate-500/10 dark:text-slate-400 ring-slate-500/20");
                a.setSentimentDotClass("bg-slate-400"); a.setSentimentText("Trung lập");
                a.setTrendIcon("trending_flat"); a.setTrendClass("text-amber-500");
            } else {
                a.setSentimentBadgeClass("bg-red-100 text-red-700 dark:bg-red-500/10 dark:text-red-400 ring-red-500/20");
                a.setSentimentDotClass("bg-red-500"); a.setSentimentText("Tiêu cực");
                a.setTrendIcon("trending_down"); a.setTrendClass("text-red-500");
            }
        }

        // ── 5. Nguồn lưu lượng — tính từ tỉ lệ likes/views/comments ──────
        int[] traffic = estimateTrafficSources(authorId, totalViews, totalLikes, totalComments);

        // ── Set attributes ──────────────────────────────────────────────────
        request.setAttribute("fmtViews",       fmtViews);
        request.setAttribute("fmtLikes",       fmtLikes);
        request.setAttribute("totalComments",  totalComments);
        request.setAttribute("totalPublished", totalPublished);
        request.setAttribute("sentimentScore", sentimentScore);
        request.setAttribute("pctPositive",    pctPositive);
        request.setAttribute("pctNeutral",     pctNeutral);
        request.setAttribute("pctNegative",    pctNegative);
        request.setAttribute("weekData",       weekData);
        request.setAttribute("topArticles",    topArticles);
        request.setAttribute("srcSearch",      traffic[0]);
        request.setAttribute("srcSocial",      traffic[1]);
        request.setAttribute("srcEmail",       traffic[2]);
        request.setAttribute("srcOther",       traffic[3]);
        request.setAttribute("fmtTotal",       fmtViews);

        request.getRequestDispatcher("/journalist/analytics.jsp").forward(request, response);
    }

    // ── Tổng views ────────────────────────────────────────────────────────
    private long getTotalViews(long authorId) {
        String sql = "SELECT COALESCE(SUM(views),0) FROM articles WHERE author_id=?";
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, authorId); ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getLong(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // ── Tổng likes ────────────────────────────────────────────────────────
    private int getTotalLikes(long authorId) {
        String sql = "SELECT COALESCE(SUM(likes_count),0) FROM articles WHERE author_id=?";
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, authorId); ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // ── Sentiment tổng [pos, neu, neg] tính từ likes_count/views ────────
    // Không dùng sentiment_label (có thể NULL)
    // Ngưỡng: likes/views >= 10% → POSITIVE, >= 3% → NEUTRAL, còn lại → NEGATIVE
    private int[] getSentimentCounts(long authorId) {
        int[] counts = {0, 0, 0}; // [pos, neu, neg]
        String sql = "SELECT views, likes_count FROM articles " +
                     "WHERE author_id = ? AND status = 'PUBLISHED'";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, authorId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int v = rs.getInt("views");
                int l = rs.getInt("likes_count");
                if (v == 0) { counts[1]++; continue; }
                double ratio = (double) l / v;
                if      (ratio >= 0.10) counts[0]++;
                else if (ratio >= 0.03) counts[1]++;
                else                    counts[2]++;
            }
        } catch (Exception e) { e.printStackTrace(); }
        if (counts[0] + counts[1] + counts[2] == 0) { counts[0] = 1; counts[1] = 1; counts[2] = 0; }
        return counts;
    }

    // ── Sentiment theo ngày trong tuần từ likes_count/views ─────────────
    private int[][] getSentimentByDayOfWeek(long authorId, int defPos, int defNeu, int defNeg) {
        int[][] raw = new int[7][3]; // raw[dayIdx][pos/neu/neg] số bài
        String sql = "SELECT DAYOFWEEK(created_at) AS dow, views, likes_count " +
                     "FROM articles WHERE author_id = ? AND status = 'PUBLISHED'";
        try (Connection c = DBConnection.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, authorId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int dow = rs.getInt("dow"); // 1=CN,2=T2..7=T7
                int idx = (dow == 1) ? 6 : (dow - 2);
                if (idx < 0 || idx > 6) continue;
                int v = rs.getInt("views");
                int l = rs.getInt("likes_count");
                if (v == 0) { raw[idx][1]++; continue; }
                double ratio = (double) l / v;
                if      (ratio >= 0.10) raw[idx][0]++;
                else if (ratio >= 0.03) raw[idx][1]++;
                else                    raw[idx][2]++;
            }
        } catch (Exception e) { e.printStackTrace(); }

        // Chuyển count → %
        int[][] result = new int[7][3];
        for (int i = 0; i < 7; i++) {
            int total = raw[i][0] + raw[i][1] + raw[i][2];
            if (total == 0) {
                result[i][0] = defPos;
                result[i][1] = defNeu;
                result[i][2] = defNeg;
            } else {
                result[i][0] = Math.round(raw[i][0] * 100.0f / total);
                result[i][1] = Math.round(raw[i][1] * 100.0f / total);
                result[i][2] = Math.max(0, 100 - result[i][0] - result[i][1]);
            }
        }
        return result;
    }

    // ── Ước tính nguồn lưu lượng từ tỉ lệ tương tác ──────────────────────
    // Không có bảng traffic_source trong DB → tính dựa trên views/likes/comments
    private int[] estimateTrafficSources(long authorId, long views, int likes, int comments) {
        // Tỉ lệ social = likes nhiều → social cao
        // Tỉ lệ organic/search ~ phần còn lại
        if (views == 0) return new int[]{42, 28, 18, 12};
        double likeRate    = Math.min(1.0, likes    / (double) Math.max(1, views));
        double commentRate = Math.min(1.0, comments / (double) Math.max(1, views));
        // Social tỉ lệ với likes (chia sẻ MXH → nhiều likes)
        int social  = (int) Math.min(45, Math.max(10, likeRate * 300));
        // Email ~ comment rate (newsletter reader hay comment)
        int email   = (int) Math.min(30, Math.max(8,  commentRate * 200));
        int other   = (int) Math.min(20, Math.max(5,  (likeRate + commentRate) * 50));
        int search  = Math.max(5, 100 - social - email - other);
        // Normalize về 100
        int total   = search + social + email + other;
        search = Math.round(search * 100.0f / total);
        social = Math.round(social * 100.0f / total);
        email  = Math.round(email  * 100.0f / total);
        other  = 100 - search - social - email;
        return new int[]{search, social, email, Math.max(0, other)};
    }

    private String formatNumber(long n) {
        if      (n >= 1_000_000) return String.format("%.1fM", n/1_000_000.0);
        else if (n >= 1_000)     return String.format("%.1fk", n/1_000.0);
        else                     return String.valueOf(n);
    }
}