<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="neuralnews.model.Article" %>
<%@ page import="neuralnews.model.User" %>

<%
    List<Article> topArticles = (List<Article>) request.getAttribute("topArticles");
    if (topArticles == null) {
        request.getRequestDispatcher("/journalist/analytics").forward(request, response);
        return;
    }

    String  fmtViews      = (String)  request.getAttribute("fmtViews");
    String  fmtLikes      = (String)  request.getAttribute("fmtLikes");
    int     totalComments = (Integer) request.getAttribute("totalComments");
    int     totalPublished= (Integer) request.getAttribute("totalPublished");
    int     sentimentScore= (Integer) request.getAttribute("sentimentScore");
    int     pctPositive   = (Integer) request.getAttribute("pctPositive");
    int     pctNeutral    = (Integer) request.getAttribute("pctNeutral");
    int     pctNegative   = (Integer) request.getAttribute("pctNegative");
    int     srcSearch     = (Integer) request.getAttribute("srcSearch");
    int     srcSocial     = (Integer) request.getAttribute("srcSocial");
    int     srcEmail      = (Integer) request.getAttribute("srcEmail");
    int     srcOther      = (Integer) request.getAttribute("srcOther");
    String  fmtTotal      = (String)  request.getAttribute("fmtTotal");
    String  contextPath   = request.getContextPath();

    // weekData thật từ Controller (tính từ DB theo từng ngày trong tuần)
    int[][] weekData = (int[][]) request.getAttribute("weekData");
    if (weekData == null) {
        // fallback nếu null
        weekData = new int[7][3];
        for (int[] d : weekData) { d[0]=pctPositive; d[1]=pctNeutral; d[2]=pctNegative; }
    }
    String[] dayLabels = {"T2","T3","T4","T5","T6","T7","CN"};
%>
<!DOCTYPE html>
<html class="dark" lang="vi">
<head>
    <jsp:include page="components/head.jsp" />
    <title>Trung tâm Dữ liệu Phân tích Nâng cao</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/4.4.1/chart.umd.min.js"></script>
</head>
<body class="min-h-screen overflow-hidden bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100">
<div class="flex h-screen">

    <jsp:include page="components/sidebar.jsp">
        <jsp:param name="activePage" value="analytics" />
    </jsp:include>

    <main class="flex-1 flex flex-col min-w-0">

        <%-- HEADER --%>
        <header class="h-16 bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-border-dark flex items-center justify-between px-8 shrink-0 z-30">
            <div class="flex items-center gap-6">
                <h2 class="text-lg font-bold tracking-tight">Trung tâm Dữ liệu Phân tích</h2>
                <div class="hidden md:flex items-center gap-2 text-xs text-slate-500 font-medium">
                    <span>Cổng thông tin Nhà báo</span>
                    <span class="material-symbols-outlined text-sm">chevron_right</span>
                    <span class="text-slate-900 dark:text-slate-200">Trung tâm Dữ liệu</span>
                </div>
            </div>
            <div class="flex items-center gap-3">

                <%-- NOTIFICATION BELL --%>
                <div class="relative" id="notifWrapper">
                    <button id="notifBtn" class="relative p-2 rounded-lg hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors text-slate-500">
                        <span class="material-symbols-outlined">notifications</span>
                        <span id="notifDot" class="absolute top-2 right-2 size-2 bg-red-500 rounded-full border-2 border-white dark:border-slate-900"></span>
                    </button>
                    <div id="notifPanel" class="hidden absolute right-0 top-12 w-80 bg-white dark:bg-slate-900 border border-slate-200 dark:border-border-dark rounded-xl shadow-xl overflow-hidden z-50">
                        <div class="flex items-center justify-between px-4 py-3 border-b border-slate-100 dark:border-border-dark">
                            <div class="flex items-center gap-2">
                                <span class="text-sm font-bold">Thông báo</span>
                                <span id="notifCount" class="bg-primary/10 text-primary text-[10px] font-bold px-1.5 py-0.5 rounded-full">2</span>
                            </div>
                            <button id="markAllRead" class="text-[11px] text-primary font-semibold hover:underline">Đánh dấu đã đọc</button>
                        </div>
                        <ul class="max-h-80 overflow-y-auto divide-y divide-slate-100 dark:divide-border-dark">
                            <li class="notif-item unread flex items-start gap-3 px-4 py-3 hover:bg-slate-50 dark:hover:bg-slate-800/60 cursor-pointer transition-colors" data-id="an_notif_1" onclick="markRead(this)">
                                <div class="size-8 rounded-full bg-blue-100 dark:bg-blue-900/40 text-blue-600 flex items-center justify-center shrink-0 mt-0.5">
                                    <span class="material-symbols-outlined text-sm">bar_chart</span>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-xs font-semibold text-slate-800 dark:text-white">Báo cáo tuần sẵn sàng</p>
                                    <p class="text-[11px] text-slate-500 mt-0.5 truncate">Báo cáo hiệu suất tuần này đã được tạo.</p>
                                    <p class="text-[10px] text-slate-400 mt-1">1 giờ trước</p>
                                </div>
                                <span class="unread-dot size-2 bg-primary rounded-full shrink-0 mt-2"></span>
                            </li>
                            <li class="notif-item unread flex items-start gap-3 px-4 py-3 hover:bg-slate-50 dark:hover:bg-slate-800/60 cursor-pointer transition-colors" data-id="an_notif_2" onclick="markRead(this)">
                                <div class="size-8 rounded-full bg-emerald-100 dark:bg-emerald-900/40 text-emerald-600 flex items-center justify-center shrink-0 mt-0.5">
                                    <span class="material-symbols-outlined text-sm">trending_up</span>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-xs font-semibold text-slate-800 dark:text-white">Lượt xem tăng 20%</p>
                                    <p class="text-[11px] text-slate-500 mt-0.5 truncate">Bài viết của bạn đang tăng trưởng mạnh.</p>
                                    <p class="text-[10px] text-slate-400 mt-1">3 giờ trước</p>
                                </div>
                                <span class="unread-dot size-2 bg-primary rounded-full shrink-0 mt-2"></span>
                            </li>
                            <li class="notif-item flex items-start gap-3 px-4 py-3 hover:bg-slate-50 dark:hover:bg-slate-800/60 cursor-pointer transition-colors" data-id="an_notif_3" onclick="markRead(this)">
                                <div class="size-8 rounded-full bg-amber-100 dark:bg-amber-900/40 text-amber-600 flex items-center justify-center shrink-0 mt-0.5">
                                    <span class="material-symbols-outlined text-sm">sentiment_neutral</span>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-xs font-semibold text-slate-800 dark:text-white">Cảm xúc trung lập tăng</p>
                                    <p class="text-[11px] text-slate-500 mt-0.5 truncate">Tỉ lệ bình luận trung lập tăng nhẹ.</p>
                                    <p class="text-[10px] text-slate-400 mt-1">1 ngày trước</p>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>

                <%-- DARK/LIGHT --%>
                <button id="themeBtn" onclick="toggleTheme()"
                        class="p-2 rounded-lg hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors text-slate-500">
                    <span id="themeIcon" class="material-symbols-outlined">light_mode</span>
                </button>
            </div>
        </header>

        <div class="flex-1 overflow-y-auto bg-slate-50 dark:bg-background-dark/50">
            <div class="p-8 space-y-8 max-w-[1400px] mx-auto">

                <%-- ══ STAT CARDS ══ --%>
                <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                    <div class="bg-white dark:bg-slate-900 p-5 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm">
                        <p class="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1">Tổng lượt xem</p>
                        <div class="flex items-end justify-between">
                            <h3 class="text-2xl font-bold"><%= fmtViews %></h3>
                            <span class="text-emerald-500 text-xs font-bold flex items-center mb-1">
                                <span class="material-symbols-outlined text-sm">trending_up</span> Tổng cộng
                            </span>
                        </div>
                    </div>
                    <div class="bg-white dark:bg-slate-900 p-5 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm">
                        <p class="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1">Bình luận</p>
                        <div class="flex items-end justify-between">
                            <h3 class="text-2xl font-bold"><%= totalComments %></h3>
                            <span class="text-emerald-500 text-xs font-bold flex items-center mb-1">
                                <span class="material-symbols-outlined text-sm">forum</span> Tổng
                            </span>
                        </div>
                    </div>
                    <div class="bg-white dark:bg-slate-900 p-5 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm">
                        <p class="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1">Lượt thích</p>
                        <div class="flex items-end justify-between">
                            <h3 class="text-2xl font-bold"><%= fmtLikes %></h3>
                            <span class="text-emerald-500 text-xs font-bold flex items-center mb-1">
                                <span class="material-symbols-outlined text-sm">favorite</span> Tổng
                            </span>
                        </div>
                    </div>
                    <div class="bg-white dark:bg-slate-900 p-5 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm">
                        <p class="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1">Điểm cảm xúc</p>
                        <div class="flex items-end justify-between">
                            <h3 class="text-2xl font-bold"><%= sentimentScore %>/100</h3>
                            <span class="<%= sentimentScore >= 60 ? "text-emerald-500" : sentimentScore >= 40 ? "text-amber-500" : "text-red-500" %> text-xs font-bold flex items-center mb-1">
                                <span class="material-symbols-outlined text-sm"><%= sentimentScore >= 60 ? "trending_up" : sentimentScore >= 40 ? "trending_flat" : "trending_down" %></span>
                                <%= sentimentScore >= 60 ? "Tốt" : sentimentScore >= 40 ? "Trung bình" : "Thấp" %>
                            </span>
                        </div>
                    </div>
                </div>

                <%-- ══ CHARTS ROW ══ --%>
                <div class="grid grid-cols-1 lg:grid-cols-12 gap-6">

                    <%-- Biểu đồ cảm xúc theo tuần — dùng Canvas Chart.js --%>
                    <div class="lg:col-span-8 bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark p-6 shadow-sm">
                        <div class="flex items-center justify-between mb-4">
                            <div>
                                <h4 class="font-bold text-slate-900 dark:text-white">Phân tích Cảm xúc theo Thời gian</h4>
                                <p class="text-xs text-slate-500 mt-0.5">Phân bổ cảm xúc người đọc trên tất cả bài viết</p>
                            </div>
                            <div class="flex gap-4">
                                <div class="flex items-center gap-1.5">
                                    <span class="size-2.5 rounded-full bg-emerald-500"></span>
                                    <span class="text-[10px] font-bold text-slate-500 uppercase">Tích cực</span>
                                </div>
                                <div class="flex items-center gap-1.5">
                                    <span class="size-2.5 rounded-full bg-amber-400"></span>
                                    <span class="text-[10px] font-bold text-slate-500 uppercase">Trung lập</span>
                                </div>
                                <div class="flex items-center gap-1.5">
                                    <span class="size-2.5 rounded-full bg-red-400"></span>
                                    <span class="text-[10px] font-bold text-slate-500 uppercase">Tiêu cực</span>
                                </div>
                            </div>
                        </div>
                        <%-- Chart.js canvas --%>
                        <div class="relative" style="height:220px">
                            <canvas id="sentimentChart"></canvas>
                        </div>
                        <%-- Legend tổng --%>
                        <div class="mt-4 grid grid-cols-3 gap-3 pt-4 border-t border-slate-100 dark:border-border-dark">
                            <div class="text-center">
                                <p class="text-2xl font-bold text-emerald-500"><%= pctPositive %>%</p>
                                <p class="text-[10px] text-slate-400 uppercase font-semibold mt-0.5">Tích cực</p>
                                <div class="w-full h-1.5 bg-slate-100 dark:bg-slate-800 rounded-full mt-2 overflow-hidden">
                                    <div class="h-full bg-emerald-500 rounded-full transition-all" style="width:<%= pctPositive %>%"></div>
                                </div>
                            </div>
                            <div class="text-center">
                                <p class="text-2xl font-bold text-amber-400"><%= pctNeutral %>%</p>
                                <p class="text-[10px] text-slate-400 uppercase font-semibold mt-0.5">Trung lập</p>
                                <div class="w-full h-1.5 bg-slate-100 dark:bg-slate-800 rounded-full mt-2 overflow-hidden">
                                    <div class="h-full bg-amber-400 rounded-full transition-all" style="width:<%= pctNeutral %>%"></div>
                                </div>
                            </div>
                            <div class="text-center">
                                <p class="text-2xl font-bold text-red-400"><%= pctNegative %>%</p>
                                <p class="text-[10px] text-slate-400 uppercase font-semibold mt-0.5">Tiêu cực</p>
                                <div class="w-full h-1.5 bg-slate-100 dark:bg-slate-800 rounded-full mt-2 overflow-hidden">
                                    <div class="h-full bg-red-400 rounded-full transition-all" style="width:<%= pctNegative %>%"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%-- Nguồn lưu lượng — Donut Chart.js --%>
                    <div class="lg:col-span-4 bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark p-6 shadow-sm">
                        <h4 class="font-bold text-slate-900 dark:text-white mb-4">Nguồn Lưu lượng</h4>
                        <div class="relative flex justify-center mb-6" style="height:180px">
                            <canvas id="donutChart"></canvas>
                            <div class="absolute inset-0 flex flex-col items-center justify-center pointer-events-none">
                                <p class="text-[9px] font-bold text-slate-400 uppercase tracking-widest">Tổng</p>
                                <p class="text-lg font-bold text-slate-900 dark:text-white"><%= fmtTotal %></p>
                            </div>
                        </div>
                        <div class="space-y-2.5">
                            <div class="flex items-center justify-between">
                                <div class="flex items-center gap-2">
                                    <span class="size-2.5 rounded-sm" style="background:#0d7ff2"></span>
                                    <span class="text-xs font-medium text-slate-600 dark:text-slate-400">Tìm kiếm Trực tiếp</span>
                                </div>
                                <div class="flex items-center gap-2">
                                    <div class="w-16 h-1 bg-slate-100 dark:bg-slate-800 rounded-full overflow-hidden">
                                        <div class="h-full rounded-full" style="width:<%= srcSearch %>%;background:#0d7ff2"></div>
                                    </div>
                                    <span class="text-xs font-bold w-8 text-right"><%= srcSearch %>%</span>
                                </div>
                            </div>
                            <div class="flex items-center justify-between">
                                <div class="flex items-center gap-2">
                                    <span class="size-2.5 rounded-sm" style="background:#10b981"></span>
                                    <span class="text-xs font-medium text-slate-600 dark:text-slate-400">Mạng Xã hội</span>
                                </div>
                                <div class="flex items-center gap-2">
                                    <div class="w-16 h-1 bg-slate-100 dark:bg-slate-800 rounded-full overflow-hidden">
                                        <div class="h-full rounded-full" style="width:<%= srcSocial %>%;background:#10b981"></div>
                                    </div>
                                    <span class="text-xs font-bold w-8 text-right"><%= srcSocial %>%</span>
                                </div>
                            </div>
                            <div class="flex items-center justify-between">
                                <div class="flex items-center gap-2">
                                    <span class="size-2.5 rounded-sm" style="background:#f59e0b"></span>
                                    <span class="text-xs font-medium text-slate-600 dark:text-slate-400">Email / Newsletter</span>
                                </div>
                                <div class="flex items-center gap-2">
                                    <div class="w-16 h-1 bg-slate-100 dark:bg-slate-800 rounded-full overflow-hidden">
                                        <div class="h-full rounded-full" style="width:<%= srcEmail %>%;background:#f59e0b"></div>
                                    </div>
                                    <span class="text-xs font-bold w-8 text-right"><%= srcEmail %>%</span>
                                </div>
                            </div>
                            <div class="flex items-center justify-between">
                                <div class="flex items-center gap-2">
                                    <span class="size-2.5 rounded-sm" style="background:#f43f5e"></span>
                                    <span class="text-xs font-medium text-slate-600 dark:text-slate-400">Referrals</span>
                                </div>
                                <div class="flex items-center gap-2">
                                    <div class="w-16 h-1 bg-slate-100 dark:bg-slate-800 rounded-full overflow-hidden">
                                        <div class="h-full rounded-full" style="width:<%= srcOther %>%;background:#f43f5e"></div>
                                    </div>
                                    <span class="text-xs font-bold w-8 text-right"><%= srcOther %>%</span>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <%-- ══ BẢNG XẾP HẠNG ══ --%>
                <div class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark overflow-hidden shadow-sm">
                    <div class="px-6 py-4 border-b border-slate-200 dark:border-border-dark flex items-center justify-between">
                        <h4 class="font-bold">Bảng xếp hạng Hiệu suất Nội dung</h4>
                        <a href="<%= contextPath %>/journalist/articles"
                           class="text-xs text-primary font-semibold hover:underline flex items-center gap-1">
                            <span class="material-symbols-outlined text-sm">open_in_new</span>
                            Xem tất cả
                        </a>
                    </div>
                    <table class="w-full text-left text-sm">
                        <thead>
                            <tr class="bg-slate-50 dark:bg-slate-800/50 text-[11px] font-bold text-slate-500 uppercase tracking-wider">
                                <th class="px-6 py-3 w-8">#</th>
                                <th class="px-6 py-3">Tiêu đề Bài viết</th>
                                <th class="px-6 py-3">Lượt xem</th>
                                <th class="px-6 py-3">Tương tác</th>
                                <th class="px-6 py-3">Cảm xúc AI</th>
                                <th class="px-6 py-3 text-right">Xu hướng</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-100 dark:divide-slate-800">
                        <% if (topArticles.isEmpty()) { %>
                            <tr>
                                <td colspan="6" class="px-6 py-12 text-center text-slate-400 text-sm">
                                    <span class="material-symbols-outlined text-4xl block mb-2">analytics</span>
                                    Chưa có bài viết nào được xuất bản để phân tích.
                                </td>
                            </tr>
                        <% } else {
                            int rank = 0;
                            for (Article a : topArticles) {
                                rank++;
                        %>
                            <tr class="hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-colors">
                                <td class="px-6 py-4 text-xs font-bold text-slate-400"><%= rank %></td>
                                <td class="px-6 py-4">
                                    <a href="<%= contextPath %>/user/article?id=<%= a.getId() %>"
                                       class="font-semibold text-slate-800 dark:text-white hover:text-primary transition-colors truncate max-w-xs block">
                                        <%= a.getTitle() %>
                                    </a>
                                    <p class="text-[11px] text-slate-400 mt-0.5">
                                        <%= a.getCategoryName() != null ? a.getCategoryName() : "—" %>
                                    </p>
                                </td>
                                <td class="px-6 py-4 font-semibold"><%= a.getFormattedViews() %></td>
                                <td class="px-6 py-4 text-slate-600 dark:text-slate-400"><%= a.getEngagementRate() %></td>
                                <td class="px-6 py-4">
                                    <span class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full text-[10px] font-bold uppercase ring-1 ring-inset <%= a.getSentimentBadgeClass() %>">
                                        <span class="size-1.5 rounded-full <%= a.getSentimentDotClass() %>"></span>
                                        <%= a.getSentimentText() %>
                                    </span>
                                </td>
                                <td class="px-6 py-4 text-right">
                                    <span class="material-symbols-outlined text-lg <%= a.getTrendClass() %>">
                                        <%= a.getTrendIcon() %>
                                    </span>
                                </td>
                            </tr>
                        <% } } %>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </main>
</div>

<script>
    // ── Notification panel ────────────────────────────────────────────────────
    var NOTIF_KEY = 'analytics_read_notifs';
    function getReadSet() { try { return JSON.parse(localStorage.getItem(NOTIF_KEY)||'[]'); } catch(e){ return []; } }
    function saveReadSet(a) { try { localStorage.setItem(NOTIF_KEY, JSON.stringify(a)); } catch(e){} }

    (function applyReadState() {
        var ids = getReadSet();
        document.querySelectorAll('.notif-item[data-id]').forEach(function(el) {
            if (ids.indexOf(el.dataset.id) !== -1) {
                el.classList.remove('unread');
                var dot = el.querySelector('.unread-dot');
                if (dot) dot.remove();
            }
        });
        updateBadge();
    })();

    function updateBadge() {
        var count = document.querySelectorAll('.notif-item.unread').length;
        var dot   = document.getElementById('notifDot');
        var badge = document.getElementById('notifCount');
        if (count > 0) { dot.classList.remove('hidden'); badge.textContent = count; badge.classList.remove('hidden'); }
        else           { dot.classList.add('hidden');    badge.classList.add('hidden'); }
    }

    document.getElementById('notifBtn').addEventListener('click', function(e) {
        e.stopPropagation();
        document.getElementById('notifPanel').classList.toggle('hidden');
    });

    document.addEventListener('click', function(e) {
        if (!document.getElementById('notifWrapper').contains(e.target))
            document.getElementById('notifPanel').classList.add('hidden');
    });

    function markRead(el) {
        if (!el.classList.contains('unread')) return;
        el.classList.remove('unread');
        var dot = el.querySelector('.unread-dot');
        if (dot) dot.remove();
        var ids = getReadSet();
        if (el.dataset.id && ids.indexOf(el.dataset.id) === -1) { ids.push(el.dataset.id); saveReadSet(ids); }
        updateBadge();
    }

    document.getElementById('markAllRead').addEventListener('click', function() {
        document.querySelectorAll('.notif-item.unread').forEach(function(el) { markRead(el); });
    });

    // ── Dark / Light mode ─────────────────────────────────────────────────────
    var themeIcon = document.getElementById('themeIcon');
    (function() {
        var saved = localStorage.getItem('editor_theme');
        if (saved === 'light') { document.documentElement.classList.remove('dark'); themeIcon.textContent = 'dark_mode'; }
        else                   { document.documentElement.classList.add('dark');    themeIcon.textContent = 'light_mode'; }
    })();

    function toggleTheme() {
        var html = document.documentElement;
        if (html.classList.contains('dark')) {
            html.classList.remove('dark'); localStorage.setItem('editor_theme','light'); themeIcon.textContent = 'dark_mode';
        } else {
            html.classList.add('dark');    localStorage.setItem('editor_theme','dark');  themeIcon.textContent = 'light_mode';
        }
    }

    // ── Chart.js: Biểu đồ cảm xúc — 3 cột riêng mỗi ngày ─────────────────
    var isDark     = document.documentElement.classList.contains('dark');
    var gridColor  = isDark ? 'rgba(255,255,255,0.06)' : 'rgba(0,0,0,0.06)';
    var labelColor = isDark ? '#94a3b8' : '#64748b';

    var posData = [<%= weekData[0][0] %>,<%= weekData[1][0] %>,<%= weekData[2][0] %>,<%= weekData[3][0] %>,<%= weekData[4][0] %>,<%= weekData[5][0] %>,<%= weekData[6][0] %>];
    var neuData = [<%= weekData[0][1] %>,<%= weekData[1][1] %>,<%= weekData[2][1] %>,<%= weekData[3][1] %>,<%= weekData[4][1] %>,<%= weekData[5][1] %>,<%= weekData[6][1] %>];
    var negData = posData.map(function(p,i){ return Math.max(0, 100-p-neuData[i]); });

    // Gradient factory
    function makeGradient(ctx, colorTop, colorBot) {
        var g = ctx.createLinearGradient(0, 0, 0, 200);
        g.addColorStop(0, colorTop);
        g.addColorStop(1, colorBot);
        return g;
    }

    var sentCtx = document.getElementById('sentimentChart').getContext('2d');
    new Chart(sentCtx, {
        type: 'bar',
        data: {
            labels: ['T2','T3','T4','T5','T6','T7','CN'],
            datasets: [
                {
                    label: 'Tích cực',
                    data: posData,
                    backgroundColor: makeGradient(sentCtx, 'rgba(16,185,129,0.95)', 'rgba(16,185,129,0.45)'),
                    borderRadius: 5,
                    borderSkipped: false,
                    borderWidth: 0,
                    barPercentage: 0.75,
                    categoryPercentage: 0.92
                },
                {
                    label: 'Trung lập',
                    data: neuData,
                    backgroundColor: makeGradient(sentCtx, 'rgba(251,191,36,0.95)', 'rgba(251,191,36,0.45)'),
                    borderRadius: 5,
                    borderSkipped: false,
                    borderWidth: 0,
                    barPercentage: 0.75,
                    categoryPercentage: 0.92
                },
                {
                    label: 'Tiêu cực',
                    data: negData,
                    backgroundColor: makeGradient(sentCtx, 'rgba(248,113,113,0.95)', 'rgba(248,113,113,0.45)'),
                    borderRadius: 5,
                    borderSkipped: false,
                    borderWidth: 0,
                    barPercentage: 0.75,
                    categoryPercentage: 0.92
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            interaction: { mode: 'index', intersect: false },
            plugins: {
                legend: { display: false },
                tooltip: {
                    backgroundColor: isDark ? '#1e293b' : '#fff',
                    titleColor: isDark ? '#e2e8f0' : '#1e293b',
                    bodyColor: isDark ? '#94a3b8' : '#475569',
                    borderColor: isDark ? '#334155' : '#e2e8f0',
                    borderWidth: 1,
                    padding: 10,
                    callbacks: {
                        label: function(ctx) {
                            var icons = ['✅','🟡','🔴'];
                            return '  ' + icons[ctx.datasetIndex] + ' ' + ctx.dataset.label + ': ' + ctx.raw + '%';
                        }
                    }
                }
            },
            scales: {
                x: {
                    grid: { display: false },
                    ticks: { color: labelColor, font: { size: 11, weight: '600' } },
                    border: { display: false }
                },
                y: {
                    max: 100,
                    grid: { color: gridColor },
                    ticks: {
                        color: labelColor,
                        font: { size: 10 },
                        callback: function(v) { return v + '%'; },
                        maxTicksLimit: 5
                    },
                    border: { display: false }
                }
            }
        }
    });

    // ── Chart.js: Donut chart nguồn lưu lượng ────────────────────────────────
    new Chart(document.getElementById('donutChart'), {
        type: 'doughnut',
        data: {
            labels: ['Tìm kiếm', 'Mạng XH', 'Email', 'Referrals'],
            datasets: [{
                data: [<%= srcSearch %>, <%= srcSocial %>, <%= srcEmail %>, <%= srcOther %>],
                backgroundColor: ['#0d7ff2','#10b981','#f59e0b','#f43f5e'],
                borderWidth: 0,
                hoverOffset: 8,
                borderRadius: 4
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            cutout: '72%',
            plugins: {
                legend: { display: false },
                tooltip: {
                    callbacks: {
                        label: function(ctx) { return ' ' + ctx.label + ': ' + ctx.raw + '%'; }
                    }
                }
            }
        }
    });
</script>
</body>
</html>
