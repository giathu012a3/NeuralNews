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
        java.time.LocalDate today = java.time.LocalDate.now();
        java.time.format.DateTimeFormatter dayFmt = java.time.format.DateTimeFormatter.ofPattern("dd/MM");

        // ── 1. Stat cards — tổng + theo period ────────────────────────────
        // Tổng (all time)
        long[] statsAll = getStatsByPeriod(authorId, -1, commentDao);
        // Theo period
        long[] stats1d  = getStatsByPeriod(authorId,  1, commentDao);
        long[] stats7d  = getStatsByPeriod(authorId,  7, commentDao);
        long[] stats30d = getStatsByPeriod(authorId, 30, commentDao);
        // stats = [views, likes, dislikes, comments]

        String fmtViews    = formatNumber(statsAll[0]);
        String fmtLikes    = formatNumber(statsAll[1]);
        String fmtDislikes = formatNumber(statsAll[2]);
        int    totalComments  = (int) statsAll[3];
        int    totalPublished = articleDao.countArticlesByAuthorFiltered(authorId,"","PUBLISHED","","","");

        // Sentiment score tổng
        long totVote = statsAll[1] + statsAll[2];
        int pctPositive = totVote > 0 ? (int) Math.round(statsAll[1] * 100.0 / totVote) : 50;
        int pctNegative = Math.max(0, 100 - pctPositive);
        int sentimentScore = pctPositive;

        // ── 2. Top 10 bài viết ────────────────────────────────────────────
        List<Article> topArticles = articleDao.getArticlesByAuthorFiltered(
                authorId,"","PUBLISHED","","","",0,10);
        topArticles.sort((a,b) -> b.getViews()-a.getViews());

        for (Article a : topArticles) {
            a.setFormattedViews(formatNumber(a.getViews()));
            int l = a.getLikesCount(), d = a.getDislikesCount();
            int voteTotal = l + d;
            double likeRatio = voteTotal > 0 ? (double) l / voteTotal : 0.5;
            int likePct    = voteTotal > 0 ? (int) Math.round(likeRatio * 100) : 0;
            int dislikePct = voteTotal > 0 ? Math.max(0, 100 - likePct) : 0;
            double eng = a.getViews() > 0 ? Math.min(100, voteTotal * 100.0 / a.getViews()) : 0;
            a.setEngagementRate(String.format("%.1f%%", eng));
            if (voteTotal == 0) {
                a.setTrendIcon("remove"); a.setTrendClass("text-slate-400");
            } else if (likeRatio >= 0.5) {
                a.setTrendIcon("trending_up"); a.setTrendClass("text-emerald-500");
            } else {
                a.setTrendIcon("trending_down"); a.setTrendClass("text-red-500");
            }
        }

        // ── 3. Top 5 danh mục ─────────────────────────────────────────────
        String[] catNames = new String[5];
        int[]    catViews = new int[5];
        getCategoryViews(authorId, catNames, catViews);

        // ── 4. Sentiment chart theo period ────────────────────────────────
        int[][] sentData1d  = getSentimentByDays(authorId, 1);
        int[][] sentData7d  = getSentimentByDays(authorId, 7);
        int[][] sentData30d = getSentimentByDays(authorId, 30);
        SentimentSeries sentAll = getSentimentByMonthsAllTime(authorId, 24);

        // Labels
        String[] labels7d  = new String[7];
        String[] labels30d = new String[30];
        for (int i = 0; i < 7;  i++) labels7d[i]  = today.minusDays(6-i).format(dayFmt);
        for (int i = 0; i < 30; i++) labels30d[i] = today.minusDays(29-i).format(dayFmt);

        // ── 5. Donut chart categories JSON ────────────────────────────────
        StringBuilder catNamesJson = new StringBuilder("[");
        StringBuilder catViewsJson = new StringBuilder("[");
        for (int i = 0; i < 5; i++) {
            if (i > 0) { catNamesJson.append(","); catViewsJson.append(","); }
            catNamesJson.append("\"").append(catNames[i] != null ? catNames[i] : "").append("\"");
            catViewsJson.append(catViews[i]);
        }
        catNamesJson.append("]"); catViewsJson.append("]");

        // ── Set attributes ─────────────────────────────────────────────────
        request.setAttribute("fmtViews",       fmtViews);
        request.setAttribute("fmtLikes",       fmtLikes);
        request.setAttribute("fmtDislikes",    fmtDislikes);
        request.setAttribute("totalComments",  totalComments);
        request.setAttribute("totalPublished", totalPublished);
        request.setAttribute("sentimentScore", sentimentScore);
        request.setAttribute("pctPositive",    pctPositive);
        request.setAttribute("pctNegative",    pctNegative);
        request.setAttribute("pctNeutral",     0);
        request.setAttribute("topArticles",    topArticles);
        request.setAttribute("catNames",       catNames);
        request.setAttribute("catViews",       catViews);
        request.setAttribute("catNamesJson",   catNamesJson.toString());
        request.setAttribute("catViewsJson",   catViewsJson.toString());
        request.setAttribute("fmtTotal",       fmtViews);

        // Stats theo period (JSON cho JS)
        request.setAttribute("statsJson", buildStatsJson(statsAll, stats1d, stats7d, stats30d));

        // Sentiment chart JSON
        request.setAttribute("sentJson1d",    toSentimentJson(sentData1d));
        request.setAttribute("sentJson7d",    toSentimentJson(sentData7d));
        request.setAttribute("sentJson30d",   toSentimentJson(sentData30d));
        request.setAttribute("sentJsonAll",   toSentimentJson(sentAll.data()));
        request.setAttribute("sentLabels7d",  toJsonStringArr(labels7d));
        request.setAttribute("sentLabels30d", toJsonStringArr(labels30d));
        request.setAttribute("sentLabelsAll", toJsonStringArr(sentAll.labels()));

        request.getRequestDispatcher("/journalist/analytics.jsp").forward(request, response);
    }

    // ── Stats tổng hợp theo period: [views, likes, dislikes, comments] ───
    // days=-1 nghĩa là all time
    private long[] getStatsByPeriod(long authorId, int days, CommentDao commentDao) {
        String where = days > 0
            ? " AND published_at >= DATE_SUB(CURDATE(), INTERVAL " + days + " DAY)"
            : "";
        String sql = "SELECT COALESCE(SUM(views),0), COALESCE(SUM(likes_count),0), COALESCE(SUM(dislikes_count),0) " +
                     "FROM articles WHERE author_id=? AND status='PUBLISHED'" + where;
        long views = 0, likes = 0, dislikes = 0;
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, authorId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) { views = rs.getLong(1); likes = rs.getLong(2); dislikes = rs.getLong(3); }
        } catch (Exception e) { e.printStackTrace(); }
        // Comments
        long comments = days > 0
            ? countCommentsByPeriod(authorId, days)
            : commentDao.countCommentsByAuthor(authorId);
        return new long[]{views, likes, dislikes, comments};
    }

    private long countCommentsByPeriod(long authorId, int days) {
        String sql = """
            SELECT COUNT(*) FROM comments c
            JOIN articles a ON c.article_id = a.id
            WHERE a.author_id = ? AND c.created_at >= DATE_SUB(NOW(), INTERVAL ? DAY)
        """;
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, authorId); ps.setInt(2, days);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getLong(1);
        } catch (Exception e) { e.printStackTrace(); }
        return 0;
    }

    // ── Build JSON stats cho tất cả periods ──────────────────────────────
    private String buildStatsJson(long[] all, long[] d1, long[] d7, long[] d30) {
        return "{"
            + "\"all\":{\"views\":\"" + formatNumber(all[0]) + "\",\"likes\":\"" + formatNumber(all[1])
            + "\",\"dislikes\":\"" + formatNumber(all[2]) + "\",\"comments\":" + all[3]
            + ",\"score\":" + (all[1]+all[2]>0 ? (int)Math.round(all[1]*100.0/(all[1]+all[2])) : 50) + "},"
            + "\"1d\":{\"views\":\"" + formatNumber(d1[0]) + "\",\"likes\":\"" + formatNumber(d1[1])
            + "\",\"dislikes\":\"" + formatNumber(d1[2]) + "\",\"comments\":" + d1[3]
            + ",\"score\":" + (d1[1]+d1[2]>0 ? (int)Math.round(d1[1]*100.0/(d1[1]+d1[2])) : 50) + "},"
            + "\"7d\":{\"views\":\"" + formatNumber(d7[0]) + "\",\"likes\":\"" + formatNumber(d7[1])
            + "\",\"dislikes\":\"" + formatNumber(d7[2]) + "\",\"comments\":" + d7[3]
            + ",\"score\":" + (d7[1]+d7[2]>0 ? (int)Math.round(d7[1]*100.0/(d7[1]+d7[2])) : 50) + "},"
            + "\"30d\":{\"views\":\"" + formatNumber(d30[0]) + "\",\"likes\":\"" + formatNumber(d30[1])
            + "\",\"dislikes\":\"" + formatNumber(d30[2]) + "\",\"comments\":" + d30[3]
            + ",\"score\":" + (d30[1]+d30[2]>0 ? (int)Math.round(d30[1]*100.0/(d30[1]+d30[2])) : 50) + "}"
            + "}";
    }

    // ── Sentiment theo từng ngày trong N ngày — SUM likes/dislikes ────────
    // FIX: ngày không có bài → pos=0, neg=0 (không điền 50/50 giả)
    private int[][] getSentimentByDays(long authorId, int days) {
        long[][] sums = new long[days][2]; // [likes, dislikes]
        String sql = """
            SELECT DATEDIFF(CURDATE(), DATE(published_at)) AS days_ago,
                   SUM(likes_count) AS lk, SUM(dislikes_count) AS dl
            FROM articles
            WHERE author_id = ? AND status = 'PUBLISHED'
              AND published_at >= DATE_SUB(CURDATE(), INTERVAL ? DAY)
            GROUP BY days_ago
        """;
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, authorId); ps.setInt(2, days);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int dAgo = rs.getInt("days_ago");
                int idx  = days - 1 - dAgo;
                if (idx >= 0 && idx < days) {
                    sums[idx][0] = rs.getLong("lk");
                    sums[idx][1] = rs.getLong("dl");
                }
            }
        } catch (Exception e) { e.printStackTrace(); }

        int[][] result = new int[days][2];
        for (int i = 0; i < days; i++) {
            long total = sums[i][0] + sums[i][1];
            if (total == 0) {
                result[i][0] = 0; result[i][1] = 0; // ngày không có data → 0
            } else {
                result[i][0] = (int) Math.round(sums[i][0] * 100.0 / total);
                result[i][1] = Math.max(0, 100 - result[i][0]);
            }
        }
        return result;
    }

    private record SentimentSeries(int[][] data, String[] labels) {}

    // ── Sentiment All-time theo THÁNG — SUM likes/dislikes ───────────────
    // Không cần sửa DB: chỉ gom dữ liệu từ published_at hiện có.
    // maxMonths: giới hạn số tháng để chart không quá dài (vd: 24)
    private SentimentSeries getSentimentByMonthsAllTime(long authorId, int maxMonths) {
        // Tháng đầu tiên có bài published
        String sqlFirst = "SELECT DATE_FORMAT(MIN(published_at), '%Y%m') FROM articles WHERE author_id=? AND status='PUBLISHED' AND published_at IS NOT NULL";
        int firstPeriod = 0;
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sqlFirst)) {
            ps.setLong(1, authorId);
            ResultSet rs = ps.executeQuery();
            if (rs.next() && rs.getString(1) != null) firstPeriod = rs.getInt(1); // yyyyMM
        } catch (Exception e) { e.printStackTrace(); }

        if (firstPeriod == 0) {
            return new SentimentSeries(new int[][]{{0,0}}, new String[]{"—"});
        }

        java.time.LocalDate now = java.time.LocalDate.now();
        int nowPeriod  = now.getYear() * 100 + now.getMonthValue();
        int firstYear  = firstPeriod / 100;
        int firstMonth = firstPeriod % 100;
        int nowYear    = nowPeriod  / 100;
        int nowMonth   = nowPeriod  % 100;

        int numMonths = (nowYear - firstYear) * 12 + (nowMonth - firstMonth) + 1;
        numMonths = Math.max(numMonths, 1);
        if (maxMonths > 0) numMonths = Math.min(numMonths, maxMonths);

        // Nếu bị cắt bởi maxMonths, dời firstPeriod đến (now - numMonths + 1)
        java.time.LocalDate start = java.time.LocalDate.of(firstYear, firstMonth, 1);
        java.time.LocalDate startCapped = java.time.LocalDate.of(nowYear, nowMonth, 1).minusMonths(numMonths - 1L);
        if (start.isBefore(startCapped)) start = startCapped;

        // Labels
        String[] labels = new String[numMonths];
        java.time.LocalDate cur = start;
        for (int i = 0; i < numMonths; i++) {
            labels[i] = "T" + cur.getMonthValue() + "/" + cur.getYear();
            cur = cur.plusMonths(1);
        }

        long[][] sums = new long[numMonths][2]; // [likes, dislikes]
        String sql = """
            SELECT DATE_FORMAT(published_at, '%Y%m') AS period,
                   SUM(likes_count) AS lk, SUM(dislikes_count) AS dl
            FROM articles
            WHERE author_id=? AND status='PUBLISHED' AND published_at IS NOT NULL
              AND published_at >= ?
            GROUP BY period
            ORDER BY period
        """;
        try (Connection c = DBConnection.getConnection(); PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setLong(1, authorId);
            ps.setDate(2, java.sql.Date.valueOf(start));
            ResultSet rs = ps.executeQuery();
            int baseYear = start.getYear();
            int baseMonth = start.getMonthValue();
            while (rs.next()) {
                int period = rs.getInt("period"); // yyyyMM
                int yr = period / 100, mo = period % 100;
                int idx = (yr - baseYear) * 12 + (mo - baseMonth);
                if (idx >= 0 && idx < numMonths) {
                    sums[idx][0] = rs.getLong("lk");
                    sums[idx][1] = rs.getLong("dl");
                }
            }
        } catch (Exception e) { e.printStackTrace(); }

        int[][] result = new int[numMonths][2];
        for (int i = 0; i < numMonths; i++) {
            long total = sums[i][0] + sums[i][1];
            if (total == 0) {
                result[i][0] = 0; result[i][1] = 0;
            } else {
                result[i][0] = (int) Math.round(sums[i][0] * 100.0 / total);
                result[i][1] = Math.max(0, 100 - result[i][0]);
            }
        }
        return new SentimentSeries(result, labels);
    }

    // ── Views theo top 5 danh mục ─────────────────────────────────────────
    private void getCategoryViews(long authorId, String[] names, int[] views) {
        String sql = """
            SELECT c.name, SUM(a.views) AS total
            FROM articles a JOIN categories c ON a.category_id = c.id
            WHERE a.author_id = ? AND a.status = 'PUBLISHED'
            GROUP BY c.id, c.name ORDER BY total DESC LIMIT 5
        """;
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, authorId);
            ResultSet rs = ps.executeQuery();
            int i = 0;
            while (rs.next() && i < 5) { names[i] = rs.getString("name"); views[i] = rs.getInt("total"); i++; }
            for (; i < 5; i++) { names[i] = ""; views[i] = 0; }
        } catch (Exception e) {
            for (int i = 0; i < 5; i++) { names[i] = ""; views[i] = 0; }
        }
    }

    private String toSentimentJson(int[][] data) {
        StringBuilder pos = new StringBuilder("["), neg = new StringBuilder("[");
        for (int i = 0; i < data.length; i++) {
            if (i > 0) { pos.append(","); neg.append(","); }
            pos.append(data[i][0]);
            neg.append(data[i].length > 1 ? data[i][1] : 0);
        }
        return "{\"pos\":" + pos + "],\"neg\":" + neg + "]}";
    }

    private String toJsonStringArr(String[] arr) {
        StringBuilder sb = new StringBuilder("[");
        for (int i = 0; i < arr.length; i++) {
            if (i > 0) sb.append(",");
            sb.append("\"").append(arr[i]).append("\"");
        }
        return sb.append("]").toString();
    }

    private String formatNumber(long n) {
        if      (n >= 1_000_000) return String.format("%.1fM", n/1_000_000.0);
        else if (n >= 1_000)     return String.format("%.1fk", n/1_000.0);
        else                     return String.valueOf(n);
    }
}