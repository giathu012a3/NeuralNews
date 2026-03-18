<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="neuralnews.model.Article" %>
<%@ page import="neuralnews.model.User" %>

<%
    List<Article> topArticles = (List<Article>) request.getAttribute("topArticles");
    if (topArticles == null) {
        request.getRequestDispatcher("/journalist/home").forward(request, response);
        return;
    }

    User   currentUser   = (User)    request.getSession(false).getAttribute("currentUser");
    String totalViews    = (String)  request.getAttribute("totalViews");
    int    totalPublished = (Integer) request.getAttribute("totalPublished");
    int    totalDraft    = (Integer) request.getAttribute("totalDraft");
    int    totalComments = (Integer) request.getAttribute("totalComments");
    String contextPath   = request.getContextPath();

    // Views theo period
    String views1d  = (String) request.getAttribute("views1d");
    String views7d  = (String) request.getAttribute("views7d");
    String views30d = (String) request.getAttribute("views30d");

    // Stats 3 card theo period
    int published1d  = request.getAttribute("published1d")  != null ? (Integer) request.getAttribute("published1d")  : 0;
    int published7d  = request.getAttribute("published7d")  != null ? (Integer) request.getAttribute("published7d")  : 0;
    int published30d = request.getAttribute("published30d") != null ? (Integer) request.getAttribute("published30d") : 0;
    int draft1d      = request.getAttribute("draft1d")      != null ? (Integer) request.getAttribute("draft1d")      : 0;
    int draft7d      = request.getAttribute("draft7d")      != null ? (Integer) request.getAttribute("draft7d")      : 0;
    int draft30d     = request.getAttribute("draft30d")     != null ? (Integer) request.getAttribute("draft30d")     : 0;
    int comments1d   = request.getAttribute("comments1d")   != null ? (Integer) request.getAttribute("comments1d")   : 0;
    int comments7d   = request.getAttribute("comments7d")   != null ? (Integer) request.getAttribute("comments7d")   : 0;
    int comments30d  = request.getAttribute("comments30d")  != null ? (Integer) request.getAttribute("comments30d")  : 0;

    // Chart data dạng JSON string — Controller đã chuẩn bị sẵn
    String chartJson1d  = (String) request.getAttribute("chartJson1d");
    String chartJson7d  = (String) request.getAttribute("chartJson7d");
    String chartJson30d = (String) request.getAttribute("chartJson30d");
    String chartJsonAll = (String) request.getAttribute("chartJsonAll");

    // Full label arrays cho từng cột
    String labelJson1d  = (String) request.getAttribute("labelJson1d");
    String labelJson7d  = (String) request.getAttribute("labelJson7d");
    String labelJson30d = (String) request.getAttribute("labelJson30d");
    String labelJsonAll = (String) request.getAttribute("labelJsonAll");
    if (chartJson1d  == null) chartJson1d  = "[]";
    if (chartJson7d  == null) chartJson7d  = "[]";
    if (chartJson30d == null) chartJson30d = "[]";
    if (chartJsonAll == null) chartJsonAll = "[]";
    if (labelJson1d  == null) labelJson1d  = "[]";
    if (labelJson7d  == null) labelJson7d  = "[]";
    if (labelJson30d == null) labelJson30d = "[]";
    if (labelJsonAll == null) labelJsonAll = "[]";
%>
<!DOCTYPE html>
<html class="dark" lang="vi">
<head>
    <jsp:include page="components/head.jsp" />
    <title>Bảng điều khiển Nhà báo - NexusAI</title>
    <style>
        .card-stat {
            background: white;
            border: 1px solid #e2e8f0;
            border-radius: 0.75rem;
            padding: 1.25rem;
        }
        .dark .card-stat {
            background: rgb(15 23 42);
            border-color: var(--border-dark, #1e293b);
        }
        .bar-tooltip {
            position: absolute;
            bottom: calc(100% + 6px);
            left: 50%;
            transform: translateX(-50%);
            background: #1e293b;
            color: white;
            font-size: 10px;
            font-weight: 700;
            padding: 3px 7px;
            border-radius: 5px;
            white-space: nowrap;
            pointer-events: none;
            opacity: 0;
            transition: opacity 0.15s;
            z-index: 10;
        }
        .chart-bar:hover .bar-tooltip { opacity: 1; }
        .chart-bar { position: relative; display: flex; flex-direction: column; justify-content: flex-end; flex: 1; }
    </style>
</head>
<body class="min-h-screen overflow-hidden bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100">
<div class="flex h-screen overflow-hidden">

    <jsp:include page="components/sidebar.jsp">
        <jsp:param name="activePage" value="dashboard" />
    </jsp:include>

    <main class="flex-1 flex flex-col min-w-0">

        <%-- HEADER --%>
        <header class="h-16 bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-border-dark flex items-center justify-between px-8 shrink-0 z-30">
            <div class="flex items-center gap-6">
                <h2 class="text-lg font-bold tracking-tight">Bảng điều khiển Nhà báo</h2>
                <div class="hidden md:flex items-center gap-2 text-xs text-slate-500 font-medium">
                    <span>Cổng thông tin Nhà báo</span>
                    <span class="material-symbols-outlined text-sm">chevron_right</span>
                    <span class="text-slate-900 dark:text-slate-200">Tóm tắt Hiệu suất</span>
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
                                <span id="notifCount" class="bg-primary/10 text-primary text-[10px] font-bold px-1.5 py-0.5 rounded-full">3</span>
                            </div>
                            <button id="markAllRead" class="text-[11px] text-primary font-semibold hover:underline">Đánh dấu đã đọc</button>
                        </div>
                        <ul class="max-h-80 overflow-y-auto divide-y divide-slate-100 dark:divide-border-dark">
                            <li class="notif-item unread flex items-start gap-3 px-4 py-3 hover:bg-slate-50 dark:hover:bg-slate-800/60 cursor-pointer transition-colors" data-id="h_notif_1" onclick="markRead(this)">
                                <div class="size-8 rounded-full bg-emerald-100 dark:bg-emerald-900/40 text-emerald-600 flex items-center justify-center shrink-0 mt-0.5">
                                    <span class="material-symbols-outlined text-sm">check_circle</span>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-xs font-semibold text-slate-800 dark:text-white">Bài viết được duyệt</p>
                                    <p class="text-[11px] text-slate-500 mt-0.5 truncate">Bài viết của bạn đã được xuất bản.</p>
                                    <p class="text-[10px] text-slate-400 mt-1">2 giờ trước</p>
                                </div>
                                <span class="unread-dot size-2 bg-primary rounded-full shrink-0 mt-2"></span>
                            </li>
                            <li class="notif-item unread flex items-start gap-3 px-4 py-3 hover:bg-slate-50 dark:hover:bg-slate-800/60 cursor-pointer transition-colors" data-id="h_notif_2" onclick="markRead(this)">
                                <div class="size-8 rounded-full bg-blue-100 dark:bg-blue-900/40 text-blue-600 flex items-center justify-center shrink-0 mt-0.5">
                                    <span class="material-symbols-outlined text-sm">comment</span>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-xs font-semibold text-slate-800 dark:text-white">Bình luận mới</p>
                                    <p class="text-[11px] text-slate-500 mt-0.5 truncate">Có 3 bình luận mới trên bài viết của bạn.</p>
                                    <p class="text-[10px] text-slate-400 mt-1">15 phút trước</p>
                                </div>
                                <span class="unread-dot size-2 bg-primary rounded-full shrink-0 mt-2"></span>
                            </li>
                            <li class="notif-item unread flex items-start gap-3 px-4 py-3 hover:bg-slate-50 dark:hover:bg-slate-800/60 cursor-pointer transition-colors" data-id="h_notif_3" onclick="markRead(this)">
                                <div class="size-8 rounded-full bg-amber-100 dark:bg-amber-900/40 text-amber-600 flex items-center justify-center shrink-0 mt-0.5">
                                    <span class="material-symbols-outlined text-sm">bar_chart</span>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-xs font-semibold text-slate-800 dark:text-white">Lượt xem tăng mạnh</p>
                                    <p class="text-[11px] text-slate-500 mt-0.5 truncate">Bài viết đạt 10,000 lượt xem hôm nay.</p>
                                    <p class="text-[10px] text-slate-400 mt-1">1 giờ trước</p>
                                </div>
                                <span class="unread-dot size-2 bg-primary rounded-full shrink-0 mt-2"></span>
                            </li>
                            <li class="notif-item flex items-start gap-3 px-4 py-3 hover:bg-slate-50 dark:hover:bg-slate-800/60 cursor-pointer transition-colors" data-id="h_notif_4" onclick="markRead(this)">
                                <div class="size-8 rounded-full bg-violet-100 dark:bg-violet-900/40 text-violet-600 flex items-center justify-center shrink-0 mt-0.5">
                                    <span class="material-symbols-outlined text-sm">star</span>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-xs font-semibold text-slate-800 dark:text-white">Bài viết nổi bật</p>
                                    <p class="text-[11px] text-slate-500 mt-0.5 truncate">Bài của bạn được chọn vào Top tuần.</p>
                                    <p class="text-[10px] text-slate-400 mt-1">2 ngày trước</p>
                                </div>
                            </li>
                            <li class="notif-item flex items-start gap-3 px-4 py-3 hover:bg-slate-50 dark:hover:bg-slate-800/60 cursor-pointer transition-colors" data-id="h_notif_5" onclick="markRead(this)">
                                <div class="size-8 rounded-full bg-slate-100 dark:bg-slate-800 text-slate-500 flex items-center justify-center shrink-0 mt-0.5">
                                    <span class="material-symbols-outlined text-sm">article</span>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-xs font-semibold text-slate-800 dark:text-white">Bản nháp chưa hoàn thành</p>
                                    <p class="text-[11px] text-slate-500 mt-0.5 truncate">Bạn có 1 bản nháp chưa được gửi duyệt.</p>
                                    <p class="text-[10px] text-slate-400 mt-1">3 ngày trước</p>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>

                <%-- DARK/LIGHT TOGGLE --%>
                <button id="themeBtn" onclick="toggleTheme()"
                        class="p-2 rounded-lg hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors text-slate-500">
                    <span id="themeIcon" class="material-symbols-outlined">light_mode</span>
                </button>
            </div>
        </header>

        <div class="flex-1 overflow-y-auto">
            <div class="p-8 max-w-7xl mx-auto space-y-8">

                <%-- ══ PERIOD FILTER ══ --%>
                <div class="flex flex-wrap items-center justify-between gap-3">
                    <div>
                        <p class="text-xs text-slate-400 mt-0.5" id="periodLabel">Tất cả thời gian</p>
                    </div>
                    <div class="flex items-center bg-slate-100 dark:bg-slate-800 rounded-xl p-1 gap-0.5">
                        <button onclick="setPeriod('1d')" id="pbtn-1d"
                                class="stat-period-btn px-3 py-1.5 text-[11px] font-bold rounded-lg transition-all text-slate-500 dark:text-slate-400 hover:text-slate-700 dark:hover:text-white">
                            1 Ngày
                        </button>
                        <button onclick="setPeriod('7d')" id="pbtn-7d"
                                class="stat-period-btn px-3 py-1.5 text-[11px] font-bold rounded-lg transition-all text-slate-500 dark:text-slate-400 hover:text-slate-700 dark:hover:text-white">
                            7 Ngày
                        </button>
                        <button onclick="setPeriod('30d')" id="pbtn-30d"
                                class="stat-period-btn px-3 py-1.5 text-[11px] font-bold rounded-lg transition-all text-slate-500 dark:text-slate-400 hover:text-slate-700 dark:hover:text-white">
                            30 Ngày
                        </button>
                        <button onclick="setPeriod('all')" id="pbtn-all"
                                class="stat-period-btn px-4 py-1.5 text-[11px] font-bold rounded-lg transition-all bg-white dark:bg-slate-700 text-primary shadow-sm">
                            Tất cả
                        </button>
                    </div>
                </div>

                <%-- ══ STAT CARDS ══ --%>
                <div class="grid grid-cols-1 md:grid-cols-4 gap-6">

                    <%-- Tổng lượt xem --%>
                    <div class="card-stat">
                        <div class="flex items-center justify-between mb-4">
                            <span class="p-2 bg-blue-100 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400 rounded-lg material-symbols-outlined">visibility</span>
                            <span class="text-[11px] font-bold text-emerald-500 flex items-center gap-1">
                                <span class="material-symbols-outlined text-xs">trending_up</span>
                                <span id="views-period-label">Tổng cộng</span>
                            </span>
                        </div>
                        <p class="text-slate-500 dark:text-slate-400 text-xs font-semibold uppercase tracking-wider">Tổng lượt xem</p>
                        <h3 class="text-3xl font-bold mt-1 tracking-tight" id="stat-views"><%= totalViews %></h3>
                    </div>

                    <%-- Bài đã xuất bản --%>
                    <div class="card-stat">
                        <div class="flex items-center justify-between mb-4">
                            <span class="p-2 bg-emerald-100 dark:bg-emerald-900/30 text-emerald-600 dark:text-emerald-400 rounded-lg material-symbols-outlined">check_circle</span>
                            <span class="text-[11px] font-bold text-emerald-500 flex items-center gap-1">
                                <span class="material-symbols-outlined text-xs">article</span>
                                Đã xuất bản
                            </span>
                        </div>
                        <p class="text-slate-500 dark:text-slate-400 text-xs font-semibold uppercase tracking-wider">Bài viết xuất bản</p>
                        <h3 class="text-3xl font-bold mt-1 tracking-tight" id="stat-published"><%= totalPublished %></h3>
                    </div>

                    <%-- Bản nháp --%>
                    <div class="card-stat">
                        <div class="flex items-center justify-between mb-4">
                            <span class="p-2 bg-amber-100 dark:bg-amber-900/30 text-amber-600 dark:text-amber-400 rounded-lg material-symbols-outlined">edit_note</span>
                            <span class="text-[11px] font-bold text-amber-500 flex items-center gap-1">
                                <span class="material-symbols-outlined text-xs">draft</span>
                                Bản nháp
                            </span>
                        </div>
                        <p class="text-slate-500 dark:text-slate-400 text-xs font-semibold uppercase tracking-wider">Đang soạn thảo</p>
                        <h3 class="text-3xl font-bold mt-1 tracking-tight" id="stat-draft"><%= totalDraft %></h3>
                    </div>

                    <%-- Bình luận --%>
                    <div class="card-stat">
                        <div class="flex items-center justify-between mb-4">
                            <span class="p-2 bg-purple-100 dark:bg-purple-900/30 text-purple-600 dark:text-purple-400 rounded-lg material-symbols-outlined">forum</span>
                            <span class="text-[11px] font-bold text-purple-500 flex items-center gap-1">
                                <span class="material-symbols-outlined text-xs">comment</span>
                                Bình luận
                            </span>
                        </div>
                        <p class="text-slate-500 dark:text-slate-400 text-xs font-semibold uppercase tracking-wider">Tổng bình luận</p>
                        <h3 class="text-3xl font-bold mt-1 tracking-tight" id="stat-comments"><%= totalComments %></h3>
                    </div>
                </div>

                <%-- ══ CHART: XU HƯỚNG LƯỢT XEM ══ --%>
                <div class="bg-white dark:bg-slate-900 border border-slate-200 dark:border-border-dark rounded-xl p-6">
                    <div class="flex flex-wrap items-center justify-between gap-4 mb-6">
                        <div>
                            <h4 class="text-base font-bold">Xu hướng lượt xem</h4>
                            <p class="text-xs text-slate-500 mt-0.5" id="chartSubtitle">Lượt xem trong 15 ngày gần nhất</p>
                        </div>
                        <a href="<%= contextPath %>/journalist/articles"
                           class="text-xs font-semibold text-primary hover:underline flex items-center gap-1">
                            <span class="material-symbols-outlined text-sm">open_in_new</span>
                            Xem tất cả bài viết
                        </a>
                    </div>
                    <div class="h-[220px] w-full flex items-end gap-1 px-1" id="chartBars"></div>
                    <%-- Nhãn dưới mỗi cột --%>
                    <div class="w-full flex gap-1 px-1 mt-1" id="chartXLabels" style="overflow:hidden;"></div>
                </div>

                <script>
                    var CHART_DATA = {
                        '1d':  <%= chartJson1d  %>,
                        '7d':  <%= chartJson7d  %>,
                        '30d': <%= chartJson30d %>,
                        'all': <%= chartJsonAll %>
                    };
                    var LABEL_DATA = {
                        '1d':  <%= labelJson1d  %>,
                        '7d':  <%= labelJson7d  %>,
                        '30d': <%= labelJson30d %>,
                        'all': <%= labelJsonAll %>
                    };
                    var VIEWS_DATA = {
                        '1d':  '<%= views1d  %>',
                        '7d':  '<%= views7d  %>',
                        '30d': '<%= views30d %>',
                        'all': '<%= totalViews %>'
                    };
                    var CHART_META = {
                        '1d':  { subtitle:'Lượt xem trong 24 giờ qua', period:'1 ngày qua' },
                        '7d':  { subtitle:'Lượt xem trong 7 ngày gần nhất', period:'7 ngày qua' },
                        '30d': { subtitle:'Lượt xem trong 30 ngày gần nhất', period:'30 ngày qua' },
                        'all': { subtitle:'Views theo tháng publish', period:'Tất cả thời gian' }
                    };
                    var STATS_DATA = {
                        '1d':  { published: <%= published1d %>,  draft: <%= draft1d %>,  comments: <%= comments1d %>  },
                        '7d':  { published: <%= published7d %>,  draft: <%= draft7d %>,  comments: <%= comments7d %>  },
                        '30d': { published: <%= published30d %>, draft: <%= draft30d %>, comments: <%= comments30d %> },
                        'all': { published: <%= totalPublished %>, draft: <%= totalDraft %>, comments: <%= totalComments %> }
                    };

                    function setPeriod(p) {
                        document.querySelectorAll('.stat-period-btn').forEach(function(b) {
                            b.classList.remove('bg-white','text-primary','shadow-sm');
                            b.classList.add('text-slate-500','dark:text-slate-400');
                        });
                        var btn = document.getElementById('pbtn-' + p);
                        if (btn) {
                            btn.classList.add('bg-white','text-primary','shadow-sm');
                            btn.classList.remove('text-slate-500','dark:text-slate-400');
                        }
                        var meta  = CHART_META[p];
                        var stats = STATS_DATA[p];
                        document.getElementById('periodLabel').textContent        = meta.period;
                        document.getElementById('chartSubtitle').textContent      = meta.subtitle;
                        document.getElementById('stat-views').textContent         = VIEWS_DATA[p];
                        document.getElementById('views-period-label').textContent = meta.period;
                        document.getElementById('stat-published').textContent     = stats.published;
                        document.getElementById('stat-draft').textContent         = stats.draft;
                        document.getElementById('stat-comments').textContent      = stats.comments;
                        renderChart(CHART_DATA[p], LABEL_DATA[p]);
                    }

                    function renderChart(data, labels) {
                        var max       = Math.max.apply(null, data) || 1;
                        var n         = data.length;
                        // Hiện nhãn thưa dần khi có nhiều cột
                        var showEvery = n >= 28 ? 5 : n >= 14 ? 2 : 1;

                        var barsHtml   = '';
                        var labelsHtml = '';
                        data.forEach(function(v, i) {
                            var pct    = Math.max(4, Math.round(v * 100 / max));
                            var isLast = i === n - 1;
                            var cls    = isLast ? 'bg-primary' : (pct > 60 ? 'bg-primary/60' : 'bg-primary/25');
                            var tip    = (v >= 1000 ? (v/1000).toFixed(1)+'k' : String(v)) + ' lượt xem';
                            var xLbl   = (labels && labels[i]) ? labels[i] : '';

                            barsHtml += '<div class="chart-bar" style="height:100%;flex:1">'
                                      + '<div class="bar-tooltip">' + xLbl + ': ' + tip + '</div>'
                                      + '<div class="' + cls + ' rounded-t-sm w-full transition-all hover:opacity-100" style="height:' + pct + '%"></div>'
                                      + '</div>';

                            var show = (i % showEvery === 0) || isLast;
                            labelsHtml += '<div style="flex:1;text-align:center;font-size:9px;color:#64748b;white-space:nowrap;overflow:hidden;">'
                                        + (show ? xLbl : '') + '</div>';
                        });

                        document.getElementById('chartBars').innerHTML    = barsHtml;
                        document.getElementById('chartXLabels').innerHTML = labelsHtml;
                    }

                    document.addEventListener('DOMContentLoaded', function() { setPeriod('all'); });
                </script>

                <%-- ══ TABLE: BÀI VIẾT HIỆU SUẤT CAO ══ --%>
                <div class="space-y-4">
                    <div class="flex items-center justify-between">
                        <h4 class="text-base font-bold">Bài viết có hiệu suất cao nhất</h4>
                        <a href="<%= contextPath %>/journalist/articles"
                           class="text-xs font-semibold text-primary hover:underline">Xem tất cả bài viết</a>
                    </div>

                    <div class="bg-white dark:bg-slate-900 border border-slate-200 dark:border-border-dark rounded-xl overflow-hidden">
                        <table class="w-full text-left">
                            <thead>
                                <tr class="bg-slate-50 dark:bg-slate-800/50 border-b border-slate-200 dark:border-border-dark">
                                    <th class="px-6 py-4 text-[11px] font-bold text-slate-500 uppercase tracking-wider">Tiêu đề bài viết</th>
                                    <th class="px-6 py-4 text-[11px] font-bold text-slate-500 uppercase tracking-wider text-right">Lượt xem</th>
                                    <th class="px-6 py-4 text-[11px] font-bold text-slate-500 uppercase tracking-wider text-right">Thời gian đọc</th>
                                    <th class="px-6 py-4 text-[11px] font-bold text-slate-500 uppercase tracking-wider text-right">Danh mục</th>
                                    <th class="px-6 py-4 text-[11px] font-bold text-slate-500 uppercase tracking-wider text-center">Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-100 dark:divide-border-dark">
                            <% if (topArticles.isEmpty()) { %>
                                <tr>
                                    <td colspan="5" class="px-6 py-12 text-center text-slate-400 text-sm">
                                        <span class="material-symbols-outlined text-4xl block mb-2">article</span>
                                        Chưa có bài viết nào được xuất bản.
                                    </td>
                                </tr>
                            <% } else {
                                for (Article a : topArticles) {
                                    // Tính published time label
                                    String timeLabel = "Chưa xuất bản";
                                    if (a.getPublishedAt() != null) {
                                        long diffMs = System.currentTimeMillis() - a.getPublishedAt().getTime();
                                        long diffDays = diffMs / (1000L * 60 * 60 * 24);
                                        if (diffDays == 0) timeLabel = "Hôm nay";
                                        else if (diffDays == 1) timeLabel = "1 ngày trước";
                                        else if (diffDays < 7)  timeLabel = diffDays + " ngày trước";
                                        else if (diffDays < 30) timeLabel = (diffDays/7) + " tuần trước";
                                        else                    timeLabel = (diffDays/30) + " tháng trước";
                                    }
                            %>
                                <tr class="hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-colors">
                                    <td class="px-6 py-4">
                                        <div class="flex items-center gap-3">
                                            <div class="size-8 rounded bg-primary/10 flex items-center justify-center text-primary shrink-0">
                                                <span class="material-symbols-outlined text-lg">article</span>
                                            </div>
                                            <div>
                                                <a href="<%= contextPath %>/user/article?id=<%= a.getId() %>"
                                                   class="text-xs font-bold truncate max-w-[280px] block hover:text-primary transition-colors">
                                                    <%= a.getTitle() %>
                                                </a>
                                                <p class="text-[10px] text-slate-400">Xuất bản <%= timeLabel %></p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 text-right text-xs font-semibold"><%= a.getFormattedViews() %></td>
                                    <td class="px-6 py-4 text-right text-xs font-semibold"><%= a.getReadingTime() %></td>
                                    <td class="px-6 py-4 text-right text-xs text-slate-500">
                                        <%= a.getCategoryName() != null ? a.getCategoryName() : "—" %>
                                    </td>
                                    <td class="px-6 py-4 text-center">
                                        <span class="inline-flex items-center px-2 py-0.5 rounded-full text-[10px] font-bold <%= a.getStatusBadgeClass() %>">
                                            <%= a.getStatusLabel() %>
                                        </span>
                                    </td>
                                </tr>
                            <% } } %>
                            </tbody>
                        </table>
                    </div>
                </div>

            </div>
        </div>
    </main>
</div>
<script>
    // ── Notification panel ────────────────────────────────────────────────────
    var NOTIF_KEY = 'home_read_notifs';

    function getReadSet() {
        try { return JSON.parse(localStorage.getItem(NOTIF_KEY) || '[]'); } catch(e) { return []; }
    }
    function saveReadSet(arr) {
        try { localStorage.setItem(NOTIF_KEY, JSON.stringify(arr)); } catch(e) {}
    }

    // Áp dụng trạng thái đã đọc khi load
    (function applyReadState() {
        var readIds = getReadSet();
        document.querySelectorAll('.notif-item[data-id]').forEach(function(el) {
            if (readIds.indexOf(el.dataset.id) !== -1) {
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
        if (count > 0) {
            dot.classList.remove('hidden');
            badge.textContent = count;
            badge.classList.remove('hidden');
        } else {
            dot.classList.add('hidden');
            badge.classList.add('hidden');
        }
    }

    document.getElementById('notifBtn').addEventListener('click', function(e) {
        e.stopPropagation();
        document.getElementById('notifPanel').classList.toggle('hidden');
    });

    document.addEventListener('click', function(e) {
        if (!document.getElementById('notifWrapper').contains(e.target)) {
            document.getElementById('notifPanel').classList.add('hidden');
        }
    });

    function markRead(el) {
        if (el.classList.contains('unread')) {
            el.classList.remove('unread');
            var dot = el.querySelector('.unread-dot');
            if (dot) dot.remove();
            var readIds = getReadSet();
            if (el.dataset.id && readIds.indexOf(el.dataset.id) === -1) {
                readIds.push(el.dataset.id);
                saveReadSet(readIds);
            }
            updateBadge();
        }
    }

    document.getElementById('markAllRead').addEventListener('click', function() {
        document.querySelectorAll('.notif-item.unread').forEach(function(item) {
            markRead(item);
        });
    });

    // ── Dark / Light mode ─────────────────────────────────────────────────────
    var themeIcon = document.getElementById('themeIcon');
    (function applyTheme() {
        var saved = localStorage.getItem('editor_theme');
        if (saved === 'light') {
            document.documentElement.classList.remove('dark');
            themeIcon.textContent = 'dark_mode';
        } else {
            document.documentElement.classList.add('dark');
            themeIcon.textContent = 'light_mode';
        }
    })();

    function toggleTheme() {
        var html = document.documentElement;
        if (html.classList.contains('dark')) {
            html.classList.remove('dark');
            localStorage.setItem('editor_theme', 'light');
            themeIcon.textContent = 'dark_mode';
        } else {
            html.classList.add('dark');
            localStorage.setItem('editor_theme', 'dark');
            themeIcon.textContent = 'light_mode';
        }
    }
</script>
</body>
</html>
