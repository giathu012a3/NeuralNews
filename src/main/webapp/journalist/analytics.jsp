<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:if test="${empty topArticles}">
    <jsp:forward page="/journalist/analytics" />
</c:if>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="dislikes" value="${not empty fmtDislikes ? fmtDislikes : '0'}" />
<c:set var="score" value="${not empty sentimentScore ? sentimentScore : 0}" />

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
        <jsp:include page="components/header.jsp">
            <jsp:param name="pageTitle" value="Trung tâm Dữ liệu Phân tích" />
        </jsp:include>

        <div class="flex-1 overflow-y-auto bg-slate-50 dark:bg-background-dark/50">
            <div class="p-8 space-y-8 max-w-[1400px] mx-auto">

                <%-- ══ PERIOD FILTER ══ --%>
                <div class="flex flex-wrap items-center justify-between gap-3">
                    <p class="text-xs text-slate-400" id="analyticsperiodLabel">Tất cả thời gian</p>
                    <div class="flex items-center bg-slate-100 dark:bg-slate-800 rounded-xl p-1 gap-0.5">
                        <button onclick="setAnalyticsPeriod('1d')" id="apbtn-1d"
                                class="analytics-period-btn px-3 py-1.5 text-[11px] font-bold rounded-lg transition-all text-slate-500 dark:text-slate-400 hover:text-slate-700 dark:hover:text-white">
                            1 Ngày
                        </button>
                        <button onclick="setAnalyticsPeriod('7d')" id="apbtn-7d"
                                class="analytics-period-btn px-3 py-1.5 text-[11px] font-bold rounded-lg transition-all text-slate-500 dark:text-slate-400 hover:text-slate-700 dark:hover:text-white">
                            7 Ngày
                        </button>
                        <button onclick="setAnalyticsPeriod('30d')" id="apbtn-30d"
                                class="analytics-period-btn px-3 py-1.5 text-[11px] font-bold rounded-lg transition-all text-slate-500 dark:text-slate-400 hover:text-slate-700 dark:hover:text-white">
                            30 Ngày
                        </button>
                        <button onclick="setAnalyticsPeriod('all')" id="apbtn-all"
                                class="analytics-period-btn px-4 py-1.5 text-[11px] font-bold rounded-lg transition-all bg-white dark:bg-slate-700 text-primary shadow-sm">
                            Tất cả
                        </button>
                    </div>
                </div>

                <%-- ══ STAT CARDS ══ --%>
                <div class="grid grid-cols-2 md:grid-cols-5 gap-4">
                    <div class="bg-white dark:bg-slate-900 p-5 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm">
                        <p class="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1">Tổng lượt xem</p>
                        <div class="flex items-end justify-between">
                            <h3 class="text-2xl font-bold" id="stat-views">${fmtViews}</h3>
                            <span class="text-blue-500 text-xs font-bold flex items-center mb-1">
                                <span class="material-symbols-outlined text-sm">visibility</span>
                            </span>
                        </div>
                    </div>
                    <div class="bg-white dark:bg-slate-900 p-5 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm">
                        <p class="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1">Bình luận</p>
                        <div class="flex items-end justify-between">
                            <h3 class="text-2xl font-bold" id="stat-comments">${totalComments}</h3>
                            <span class="text-purple-500 text-xs font-bold flex items-center mb-1">
                                <span class="material-symbols-outlined text-sm">forum</span>
                            </span>
                        </div>
                    </div>
                    <div class="bg-white dark:bg-slate-900 p-5 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm">
                        <p class="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1">Lượt thích</p>
                        <div class="flex items-end justify-between">
                            <h3 class="text-2xl font-bold" id="stat-likes">${fmtLikes}</h3>
                            <span class="text-emerald-500 text-xs font-bold flex items-center mb-1">
                                <span class="material-symbols-outlined text-sm">thumb_up</span>
                            </span>
                        </div>
                    </div>
                    <div class="bg-white dark:bg-slate-900 p-5 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm">
                        <p class="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1">Không thích</p>
                        <div class="flex items-end justify-between">
                            <h3 class="text-2xl font-bold" id="stat-dislikes">${dislikes}</h3>
                            <span class="text-red-400 text-xs font-bold flex items-center mb-1">
                                <span class="material-symbols-outlined text-sm">thumb_down</span>
                            </span>
                        </div>
                    </div>
                    <div class="bg-white dark:bg-slate-900 p-5 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm">
                        <p class="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1">Điểm cảm xúc</p>
                        <div class="flex items-end justify-between">
                            <h3 class="text-2xl font-bold" id="stat-score">${score}/100</h3>
                            <span id="stat-score-label" class="${score >= 60 ? 'text-emerald-500' : score >= 40 ? 'text-amber-500' : 'text-red-500'} text-xs font-bold flex items-center mb-1">
                                <span class="material-symbols-outlined text-sm">${score >= 60 ? 'trending_up' : score >= 40 ? 'trending_flat' : 'trending_down'}</span>
                                ${score >= 60 ? 'Tốt' : score >= 40 ? 'TB' : 'Thấp'}
                            </span>
                        </div>
                    </div>
                </div>

                <%-- ══ CHARTS ROW ══ --%>
                <div class="grid grid-cols-1 lg:grid-cols-12 gap-6">

                    <%-- Biểu đồ cảm xúc theo Thời gian --%>
                    <div class="lg:col-span-8 bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark p-6 shadow-sm">
                        <div class="flex flex-wrap items-center justify-between gap-3 mb-4">
                            <div>
                                <h4 class="font-bold text-slate-900 dark:text-white">Phân tích Cảm xúc theo Thời gian</h4>
                                <p class="text-xs text-slate-500 mt-0.5" id="sentSubtitle">Tỉ lệ like/dislike theo ngày trong tuần</p>
                            </div>
                            <div class="flex items-center gap-3">
                                <div class="flex items-center gap-3">
                                    <div class="flex items-center gap-1.5">
                                        <span class="size-2.5 rounded-full bg-emerald-500"></span>
                                        <span class="text-[10px] font-bold text-slate-500 uppercase">Tích cực</span>
                                    </div>
                                    <div class="flex items-center gap-1.5">
                                        <span class="size-2.5 rounded-full bg-red-400"></span>
                                        <span class="text-[10px] font-bold text-slate-500 uppercase">Tiêu cực</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%-- Chart.js canvas --%>
                        <div class="relative" style="height:220px">
                            <canvas id="sentimentChart"></canvas>
                        </div>
                        <%-- Legend tổng — chỉ 2 cột --%>
                        <div class="mt-4 grid grid-cols-2 gap-3 pt-4 border-t border-slate-100 dark:border-border-dark">
                            <div class="text-center">
                                <p class="text-2xl font-bold text-emerald-500">${not empty pctPositive ? pctPositive : 0}%</p>
                                <p class="text-[10px] text-slate-400 uppercase font-semibold mt-0.5">Tích cực</p>
                                <div class="w-full h-1.5 bg-slate-100 dark:bg-slate-800 rounded-full mt-2 overflow-hidden">
                                    <div class="h-full bg-emerald-500 rounded-full transition-all" style="width:${not empty pctPositive ? pctPositive : 0}%"></div>
                                </div>
                            </div>
                            <div class="text-center">
                                <p class="text-2xl font-bold text-red-400">${not empty pctNegative ? pctNegative : 0}%</p>
                                <p class="text-[10px] text-slate-400 uppercase font-semibold mt-0.5">Tiêu cực</p>
                                <div class="w-full h-1.5 bg-slate-100 dark:bg-slate-800 rounded-full mt-2 overflow-hidden">
                                    <div class="h-full bg-red-400 rounded-full transition-all" style="width:${not empty pctNegative ? pctNegative : 0}%"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <%-- Views theo Danh mục — Donut Chart --%>
                    <div class="lg:col-span-4 bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark p-6 shadow-sm">
                        <h4 class="font-bold text-slate-900 dark:text-white mb-1">Views theo Danh mục</h4>
                        <p class="text-xs text-slate-400 mb-4">Top 5 danh mục nhiều lượt xem nhất</p>

                        <div class="relative flex justify-center mb-5" style="height:170px">
                            <canvas id="categoryDonut"></canvas>
                            <div class="absolute inset-0 flex flex-col items-center justify-center pointer-events-none">
                                <p class="text-[9px] font-bold text-slate-400 uppercase tracking-widest">Tổng</p>
                                <p class="text-base font-bold text-slate-900 dark:text-white">${fmtTotal}</p>
                            </div>
                        </div>

                        <div class="space-y-2">
                        <c:set var="catColors" value="${fn:split('#0d7ff2,#10b981,#f59e0b,#f43f5e,#8b5cf6', ',')}" />
                        <c:forEach begin="0" end="4" var="ci">
                            <c:if test="${not empty catNames[ci]}">
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center gap-2">
                                        <span class="size-2.5 rounded-sm shrink-0" style="background:${catColors[ci]}"></span>
                                        <span class="text-xs font-medium text-slate-600 dark:text-slate-300 truncate max-w-[130px]">${catNames[ci]}</span>
                                    </div>
                                    <c:set var="cv" value="${catViews[ci]}" />
                                    <span class="text-xs font-bold text-slate-700 dark:text-slate-200">
                                        <c:choose>
                                            <c:when test="${cv >= 1000}"><c:out value="${fn:substring(cv/1000.0, 0, 3)}k" /></c:when>
                                            <c:otherwise>${cv}</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                            </c:if>
                        </c:forEach>
                        </div>
                    </div>

                </div>

                <%-- ══ BẢNG XẾP HẠNG ══ --%>
                <div class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark overflow-hidden shadow-sm">
                    <div class="px-6 py-4 border-b border-slate-200 dark:border-border-dark flex items-center justify-between">
                        <h4 class="font-bold">Bảng xếp hạng Hiệu suất Nội dung</h4>
                        <a href="${ctx}/journalist/articles"
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
                                <th class="px-6 py-3 text-emerald-500">
                                    <span class="flex items-center gap-1"><span class="material-symbols-outlined" style="font-size:13px">thumb_up</span> Like</span>
                                </th>
                                <th class="px-6 py-3 text-red-400">
                                    <span class="flex items-center gap-1"><span class="material-symbols-outlined" style="font-size:13px">thumb_down</span> Dislike</span>
                                </th>
                                <th class="px-6 py-3">Tương tác</th>
                                <th class="px-6 py-3 text-right">Xu hướng</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-100 dark:divide-slate-800">
                        <c:choose>
                            <c:when test="${empty topArticles}">
                                <tr>
                                    <td colspan="7" class="px-6 py-12 text-center text-slate-400 text-sm">
                                        <span class="material-symbols-outlined text-4xl block mb-2">analytics</span>
                                        Chưa có bài viết nào được xuất bản để phân tích.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="a" items="${topArticles}" varStatus="vs">
                                    <tr class="hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-colors">
                                        <td class="px-6 py-4 text-xs font-bold text-slate-400">${vs.count}</td>
                                        <td class="px-6 py-4">
                                            <a href="${ctx}/user/article?id=${a.id}"
                                               class="font-semibold text-slate-800 dark:text-white hover:text-primary transition-colors truncate max-w-xs block">
                                                ${a.title}
                                            </a>
                                            <p class="text-[11px] text-slate-400 mt-0.5">
                                                ${not empty a.categoryName ? a.categoryName : '—'}
                                            </p>
                                        </td>
                                        <td class="px-6 py-4 font-semibold">${a.formattedViews}</td>
                                        <td class="px-6 py-4">
                                            <span class="flex items-center gap-1 text-emerald-500 font-semibold text-xs">
                                                <span class="material-symbols-outlined" style="font-size:14px">thumb_up</span>
                                                ${a.likesCount}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4">
                                            <span class="flex items-center gap-1 text-red-400 font-semibold text-xs">
                                                <span class="material-symbols-outlined" style="font-size:14px">thumb_down</span>
                                                ${a.dislikesCount}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 text-slate-600 dark:text-slate-400">${a.engagementRate}</td>
                                        <td class="px-6 py-4 text-right">
                                            <span class="material-symbols-outlined text-lg ${a.trendClass}">
                                                ${a.trendIcon}
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                        </tbody>
                    </table>
                </div>

            </div>
        </div>
    </main>
</div>

<script>
    const isDark     = document.documentElement.classList.contains('dark');
    const gridColor  = isDark ? 'rgba(255,255,255,0.06)' : 'rgba(0,0,0,0.06)';
    const labelColor = isDark ? '#94a3b8' : '#64748b';

    var SENT_DATA = {
        '1d':  ${not empty sentJson1d ? sentJson1d : '{"pos":[0],"neg":[0]}'},
        '7d':  ${not empty sentJson7d ? sentJson7d : '{"pos":[0,0,0,0,0,0,0],"neg":[0,0,0,0,0,0,0]}'},
        '30d': ${not empty sentJson30d ? sentJson30d : '{"pos":[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],"neg":[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]}'},
        'all': ${not empty sentJsonAll ? sentJsonAll : '{"pos":[0],"neg":[0]}'}
    };
    var SENT_LABELS = {
        '1d':  ['Hôm nay'],
        '7d':  ${not empty sentLabels7d ? sentLabels7d : '[]'},
        '30d': ${not empty sentLabels30d ? sentLabels30d : '[]'},
        'all': ${not empty sentLabelsAll ? sentLabelsAll : '["—"]'}
    };
    var SENT_SUBTITLES = {
        '1d':  'Tỉ lệ like/dislike hôm nay',
        '7d':  'Tỉ lệ like/dislike 7 ngày gần nhất',
        '30d': 'Tỉ lệ like/dislike 30 ngày gần nhất',
        'all': 'Tỉ lệ like/dislike theo ngày trong tuần'
    };

    var sentCtx = document.getElementById('sentimentChart').getContext('2d');
    function makeGradient(ctx, colorTop, colorBot) {
        var g = ctx.createLinearGradient(0, 0, 0, 200);
        g.addColorStop(0, colorTop); g.addColorStop(1, colorBot);
        return g;
    }

    var sentChart = new Chart(sentCtx, {
        type: 'bar',
        data: { labels: [], datasets: [
            {
                label: 'Tích cực', data: [],
                backgroundColor: makeGradient(sentCtx, 'rgba(16,185,129,0.95)', 'rgba(16,185,129,0.45)'),
                borderRadius: 5, borderSkipped: false, borderWidth: 0,
                barPercentage: 0.6, categoryPercentage: 0.9
            },
            {
                label: 'Tiêu cực', data: [],
                backgroundColor: makeGradient(sentCtx, 'rgba(248,113,113,0.95)', 'rgba(248,113,113,0.45)'),
                borderRadius: 5, borderSkipped: false, borderWidth: 0,
                barPercentage: 0.6, categoryPercentage: 0.9
            }
        ]},
        options: {
            responsive: true, maintainAspectRatio: false,
            interaction: { mode: 'index', intersect: false },
            plugins: {
                legend: { display: false },
                tooltip: {
                    backgroundColor: isDark ? '#1e293b' : '#fff',
                    titleColor: isDark ? '#e2e8f0' : '#1e293b',
                    bodyColor: isDark ? '#94a3b8' : '#475569',
                    borderColor: isDark ? '#334155' : '#e2e8f0',
                    borderWidth: 1, padding: 10,
                    callbacks: {
                        label: function(ctx) {
                            var icons = ['✅','🔴'];
                            return '  ' + icons[ctx.datasetIndex] + ' ' + ctx.dataset.label + ': ' + ctx.raw + '%';
                        }
                    }
                }
            },
            scales: {
                x: { grid: { display: false }, ticks: { color: labelColor, font: { size: 11, weight: '600' } }, border: { display: false } },
                y: { max: 100, grid: { color: gridColor }, ticks: { color: labelColor, font: { size: 10 }, callback: function(v){ return v+'%'; }, maxTicksLimit: 5 }, border: { display: false } }
            }
        }
    });

    function setSentPeriod(p) {
        document.querySelectorAll('.sent-period-btn').forEach(function(b) {
            b.classList.remove('bg-white','dark:bg-slate-700','text-primary','shadow-sm');
            b.classList.add('text-slate-500');
        });
        var btn = document.getElementById('spbtn-' + p);
        if (btn) { btn.classList.add('bg-white','text-primary','shadow-sm'); btn.classList.remove('text-slate-500'); }
        document.getElementById('sentSubtitle').textContent = SENT_SUBTITLES[p];
        var d = SENT_DATA[p];
        sentChart.data.labels            = SENT_LABELS[p];
        sentChart.data.datasets[0].data  = d.pos;
        sentChart.data.datasets[1].data  = d.neg;
        sentChart.update();
    }

    var STATS_JSON = ${not empty statsJson ? statsJson : '{}'};
    var AP_LABELS  = { '1d':'1 ngày qua','7d':'7 ngày qua','30d':'30 ngày qua','all':'Tất cả thời gian' };

    function setAnalyticsPeriod(p) {
        document.querySelectorAll('.analytics-period-btn').forEach(function(b) {
            b.classList.remove('bg-white','text-primary','shadow-sm');
            b.classList.add('text-slate-500','dark:text-slate-400');
        });
        var btn = document.getElementById('apbtn-' + p);
        if (btn) { btn.classList.add('bg-white','text-primary','shadow-sm'); btn.classList.remove('text-slate-500','dark:text-slate-400'); }
        document.getElementById('analyticsperiodLabel').textContent = AP_LABELS[p];
        var s = STATS_JSON[p];
        if (s) {
            document.getElementById('stat-views').textContent    = s.views;
            document.getElementById('stat-comments').textContent = s.comments;
            document.getElementById('stat-likes').textContent    = s.likes;
            document.getElementById('stat-dislikes').textContent = s.dislikes;
            document.getElementById('stat-score').textContent    = s.score + '/100';
            var sc = s.score;
            var scoreEl = document.getElementById('stat-score-label');
            scoreEl.className = (sc >= 60 ? 'text-emerald-500' : sc >= 40 ? 'text-amber-500' : 'text-red-500') + ' text-xs font-bold flex items-center mb-1';
            scoreEl.innerHTML = '<span class="material-symbols-outlined text-sm">' + (sc >= 60 ? 'trending_up' : sc >= 40 ? 'trending_flat' : 'trending_down') + '</span>' + (sc >= 60 ? 'Tốt' : sc >= 40 ? 'TB' : 'Thấp');
        }
        setSentPeriod(p);
    }

    var catNames = ${not empty catNamesJson ? catNamesJson : '[]'};
    var catData  = ${not empty catViewsJson ? catViewsJson : '[]'};
    var filteredNames = [], filteredData = [], filteredColors = [];
    var allColors = ['#0d7ff2','#10b981','#f59e0b','#f43f5e','#8b5cf6'];
    catNames.forEach(function(n, i) {
        if (n && n.length > 0) {
            filteredNames.push(n);
            filteredData.push(catData[i]);
            filteredColors.push(allColors[i]);
        }
    });

    new Chart(document.getElementById('categoryDonut'), {
        type: 'doughnut',
        data: {
            labels: filteredNames,
            datasets: [{
                data: filteredData,
                backgroundColor: filteredColors,
                borderWidth: 0,
                hoverOffset: 8,
                borderRadius: 4
            }]
        },
        options: {
            responsive: true, maintainAspectRatio: false, cutout: '70%',
            plugins: {
                legend: { display: false },
                tooltip: {
                    backgroundColor: isDark ? '#1e293b' : '#fff',
                    titleColor: isDark ? '#e2e8f0' : '#1e293b',
                    bodyColor: isDark ? '#94a3b8' : '#475569',
                    borderColor: isDark ? '#334155' : '#e2e8f0',
                    borderWidth: 1,
                    callbacks: {
                        label: function(ctx) {
                            var total = ctx.dataset.data.reduce(function(a,b){return a+b;}, 0);
                            var pct = total > 0 ? Math.round(ctx.raw * 100 / total) : 0;
                            var val = ctx.raw >= 1000 ? (ctx.raw/1000).toFixed(1)+'k' : ctx.raw;
                            return ' ' + ctx.label + ': ' + val + ' (' + pct + '%)';
                        }
                    }
                }
            }
        }
    });

    document.addEventListener('DOMContentLoaded', function() { setAnalyticsPeriod('all'); });
</script>
</body>
</html>
