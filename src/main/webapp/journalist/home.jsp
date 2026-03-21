<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
            <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

                <c:set var="topArticles" value="${requestScope.topArticles}" />
                <c:if test="${empty topArticles}">
                    <jsp:forward page="/journalist/home" />
                </c:if>

                <c:set var="u" value="${sessionScope.currentUser}" />
                <c:set var="totalViews" value="${not empty requestScope.totalViews ? requestScope.totalViews : '0'}" />
                <c:set var="totalPublished"
                    value="${not empty requestScope.totalPublished ? requestScope.totalPublished : 0}" />
                <c:set var="totalDraft" value="${not empty requestScope.totalDraft ? requestScope.totalDraft : 0}" />
                <c:set var="totalComments"
                    value="${not empty requestScope.totalComments ? requestScope.totalComments : 0}" />

                <c:set var="views1d" value="${not empty requestScope.views1d ? requestScope.views1d : '0'}" />
                <c:set var="views7d" value="${not empty requestScope.views7d ? requestScope.views7d : '0'}" />
                <c:set var="views30d" value="${not empty requestScope.views30d ? requestScope.views30d : '0'}" />

                <c:set var="ctx" value="${pageContext.request.contextPath}" />

                <c:set var="pub_1d" value="${not empty requestScope.published1d ? requestScope.published1d : 0}" />
                <c:set var="drf_1d" value="${not empty requestScope.draft1d ? requestScope.draft1d : 0}" />
                <c:set var="cmt_1d" value="${not empty requestScope.comments1d ? requestScope.comments1d : 0}" />

                <c:set var="pub_7d" value="${not empty requestScope.published7d ? requestScope.published7d : 0}" />
                <c:set var="drf_7d" value="${not empty requestScope.draft7d ? requestScope.draft7d : 0}" />
                <c:set var="cmt_7d" value="${not empty requestScope.comments7d ? requestScope.comments7d : 0}" />

                <c:set var="pub_30d" value="${not empty requestScope.published30d ? requestScope.published30d : 0}" />
                <c:set var="drf_30d" value="${not empty requestScope.draft30d ? requestScope.draft30d : 0}" />
                <c:set var="cmt_30d" value="${not empty requestScope.comments30d ? requestScope.comments30d : 0}" />

                <c:set var="chartJson1d"
                    value="${not empty requestScope.chartJson1d ? requestScope.chartJson1d : '[]'}" />
                <c:set var="chartJson7d"
                    value="${not empty requestScope.chartJson7d ? requestScope.chartJson7d : '[]'}" />
                <c:set var="chartJson30d"
                    value="${not empty requestScope.chartJson30d ? requestScope.chartJson30d : '[]'}" />
                <c:set var="chartJsonAll"
                    value="${not empty requestScope.chartJsonAll ? requestScope.chartJsonAll : '[]'}" />

                <c:set var="labelJson1d"
                    value="${not empty requestScope.labelJson1d ? requestScope.labelJson1d : '[]'}" />
                <c:set var="labelJson7d"
                    value="${not empty requestScope.labelJson7d ? requestScope.labelJson7d : '[]'}" />
                <c:set var="labelJson30d"
                    value="${not empty requestScope.labelJson30d ? requestScope.labelJson30d : '[]'}" />
                <c:set var="labelJsonAll"
                    value="${not empty requestScope.labelJsonAll ? requestScope.labelJsonAll : '[]'}" />
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

                        .chart-bar:hover .bar-tooltip {
                            opacity: 1;
                        }

                        .chart-bar {
                            position: relative;
                            display: flex;
                            flex-direction: column;
                            justify-content: flex-end;
                            flex: 1;
                        }
                    </style>
                </head>

                <body
                    class="min-h-screen overflow-hidden bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100">
                    <div class="flex h-screen overflow-hidden">

                        <jsp:include page="components/sidebar.jsp">
                            <jsp:param name="activePage" value="dashboard" />
                        </jsp:include>

                        <main class="flex-1 flex flex-col min-w-0">

                            <%-- HEADER --%>
                                <jsp:include page="components/header.jsp">
                                    <jsp:param name="pageTitle" value="Tóm tắt Hiệu suất" />
                                </jsp:include>

                                <%-- Notifications (Top-Right) --%>
                                    <c:if test="${param.success == 'true'}">
                                        <div id="toast-success"
                                            class="fixed top-20 right-5 z-[10002] pointer-events-none">
                                            <div
                                                class="bg-emerald-500 text-white px-6 py-4 rounded-2xl shadow-2xl flex items-center gap-3 pointer-events-auto animate-in fade-in slide-in-from-top-4 duration-300">
                                                <span class="material-symbols-outlined text-2xl">check_circle</span>
                                                <div>
                                                    <p class="font-black tracking-tight text-sm">Thành công!</p>
                                                    <p class="text-xs opacity-90">Thao tác đã được thực hiện.</p>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${not empty param.error}">
                                        <div id="toast-error"
                                            class="fixed top-20 right-5 z-[10002] pointer-events-none">
                                            <div
                                                class="bg-red-500 text-white px-6 py-4 rounded-2xl shadow-2xl flex items-center gap-3 pointer-events-auto animate-in fade-in slide-in-from-top-4 duration-300">
                                                <span class="material-symbols-outlined text-2xl">error</span>
                                                <div>
                                                    <p class="font-black tracking-tight text-sm">Thất bại!</p>
                                                    <p class="text-xs opacity-90">Đã có lỗi xảy ra. Hãy thử lại.</p>
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>

                                    <div class="flex-1 overflow-y-auto">
                                        <div class="p-8 max-w-7xl mx-auto space-y-8">

                                            <%-- ══ PERIOD FILTER ══ --%>
                                                <div class="flex flex-wrap items-center justify-between gap-3">
                                                    <div>
                                                        <p class="text-xs text-slate-400 mt-0.5" id="periodLabel">Tất cả
                                                            thời gian</p>
                                                    </div>
                                                    <div
                                                        class="flex items-center bg-slate-100 dark:bg-slate-800 rounded-xl p-1 gap-0.5">
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
                                                            <div
                                                                class="card-stat hover:shadow-lg transition-all duration-300 border-l-4 border-l-blue-500">
                                                                <div class="flex items-center justify-between mb-4">
                                                                    <span
                                                                        class="p-2 bg-blue-100 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400 rounded-lg material-symbols-outlined">visibility</span>
                                                                    <span
                                                                        class="text-[11px] font-bold text-emerald-500 flex items-center gap-1">
                                                                        <span
                                                                            class="material-symbols-outlined text-xs">trending_up</span>
                                                                        <span id="views-period-label">Tổng cộng</span>
                                                                    </span>
                                                                </div>
                                                                <p
                                                                    class="text-slate-500 dark:text-slate-400 text-[10px] font-bold uppercase tracking-[0.1em]">
                                                                    Tổng lượt xem</p>
                                                                <h3 class="text-3xl font-black mt-1 tracking-tight"
                                                                    id="stat-views">${totalViews}</h3>
                                                            </div>

                                                            <%-- Bài đã xuất bản --%>
                                                                <div
                                                                    class="card-stat hover:shadow-lg transition-all duration-300 border-l-4 border-l-emerald-500">
                                                                    <div class="flex items-center justify-between mb-4">
                                                                        <span
                                                                            class="p-2 bg-emerald-100 dark:bg-emerald-900/30 text-emerald-600 dark:text-emerald-400 rounded-lg material-symbols-outlined">check_circle</span>
                                                                        <span
                                                                            class="text-[11px] font-bold text-emerald-500 flex items-center gap-1">
                                                                            <span
                                                                                class="material-symbols-outlined text-xs">article</span>
                                                                            Đã duyệt
                                                                        </span>
                                                                    </div>
                                                                    <p
                                                                        class="text-slate-500 dark:text-slate-400 text-[10px] font-bold uppercase tracking-[0.1em]">
                                                                        Bài viết xuất bản</p>
                                                                    <h3 class="text-3xl font-black mt-1 tracking-tight"
                                                                        id="stat-published">${totalPublished}</h3>
                                                                </div>

                                                                <%-- Bản nháp --%>
                                                                    <div
                                                                        class="card-stat hover:shadow-lg transition-all duration-300 border-l-4 border-l-amber-500">
                                                                        <div
                                                                            class="flex items-center justify-between mb-4">
                                                                            <span
                                                                                class="p-2 bg-amber-100 dark:bg-amber-900/30 text-amber-600 dark:text-amber-400 rounded-lg material-symbols-outlined">edit_note</span>
                                                                            <span
                                                                                class="text-[11px] font-bold text-amber-500 flex items-center gap-1">
                                                                                <span
                                                                                    class="material-symbols-outlined text-xs">draft</span>
                                                                                Nháp
                                                                            </span>
                                                                        </div>
                                                                        <p
                                                                            class="text-slate-500 dark:text-slate-400 text-[10px] font-bold uppercase tracking-[0.1em]">
                                                                            Đang soạn thảo</p>
                                                                        <h3 class="text-3xl font-black mt-1 tracking-tight"
                                                                            id="stat-draft">${totalDraft}</h3>
                                                                    </div>

                                                                    <%-- Bình luận --%>
                                                                        <div
                                                                            class="card-stat hover:shadow-lg transition-all duration-300 border-l-4 border-l-purple-500">
                                                                            <div
                                                                                class="flex items-center justify-between mb-4">
                                                                                <span
                                                                                    class="p-2 bg-purple-100 dark:bg-purple-900/30 text-purple-600 dark:text-purple-400 rounded-lg material-symbols-outlined">forum</span>
                                                                                <span
                                                                                    class="text-[11px] font-bold text-purple-500 flex items-center gap-1">
                                                                                    <span
                                                                                        class="material-symbols-outlined text-xs">comment</span>
                                                                                    Độc giả
                                                                                </span>
                                                                            </div>
                                                                            <p
                                                                                class="text-slate-500 dark:text-slate-400 text-[10px] font-bold uppercase tracking-[0.1em]">
                                                                                Tổng bình luận</p>
                                                                            <h3 class="text-3xl font-black mt-1 tracking-tight"
                                                                                id="stat-comments">${totalComments}</h3>
                                                                        </div>
                                                    </div>

                                                    <%-- ══ CHART: XU HƯỚNG LƯỢT XEM ══ --%>
                                                        <div
                                                            class="bg-white dark:bg-slate-900 border border-slate-200 dark:border-border-dark rounded-xl p-6">
                                                            <div
                                                                class="flex flex-wrap items-center justify-between gap-4 mb-6">
                                                                <div>
                                                                    <h4 class="text-base font-bold">Xu hướng lượt xem
                                                                    </h4>
                                                                    <p class="text-xs text-slate-500 mt-0.5"
                                                                        id="chartSubtitle">Dữ liệu phân tích bài viết
                                                                    </p>
                                                                </div>
                                                                <a href="${ctx}/journalist/articles"
                                                                    class="text-xs font-semibold text-primary hover:underline flex items-center gap-1">
                                                                    <span
                                                                        class="material-symbols-outlined text-sm">open_in_new</span>
                                                                    Xem tất cả bài viết
                                                                </a>
                                                            </div>
                                                            <div class="h-[220px] w-full flex items-end gap-1 px-1"
                                                                id="chartBars"></div>
                                                            <%-- Nhãn dưới mỗi cột --%>
                                                                <div class="w-full flex gap-1 px-1 mt-1"
                                                                    id="chartXLabels" style="overflow:hidden;"></div>
                                                        <script>
                                                            var CHART_DATA = {
                                                                '1d': ${chartJson1d},
                                                                '7d': ${chartJson7d},
                                                                '30d': ${chartJson30d},
                                                                'all': ${chartJsonAll}
                                                            };
                                                            var LABEL_DATA = {
                                                                '1d': ${labelJson1d},
                                                                '7d': ${labelJson7d},
                                                                '30d': ${labelJson30d},
                                                                'all': ${labelJsonAll}
                                                            };
                                                            var VIEWS_DATA = {
                                                                '1d': '${views1d}',
                                                                '7d': '${views7d}',
                                                                '30d': '${views30d}',
                                                                'all': '${totalViews}'
                                                            };
                                                            var CHART_META = {
                                                                '1d': { subtitle: 'Lượt xem trong 24 giờ qua', period: '1 ngày qua' },
                                                                '7d': { subtitle: 'Lượt xem trong 7 ngày gần nhất', period: '7 ngày qua' },
                                                                '30d': { subtitle: 'Lượt xem trong 30 ngày gần nhất', period: '30 ngày qua' },
                                                                'all': { subtitle: 'Views theo tháng publish', period: 'Tất cả thời gian' }
                                                            };
                                                            var STATS_DATA = {
                                                                '1d': { published: '${pub_1d}', draft: '${drf_1d}', comments: '${cmt_1d}' },
                                                                '7d': { published: '${pub_7d}', draft: '${drf_7d}', comments: '${cmt_7d}' },
                                                                '30d': { published: '${pub_30d}', draft: '${drf_30d}', comments: '${cmt_30d}' },
                                                                'all': { published: '${totalPublished}', draft: '${totalDraft}', comments: '${totalComments}' }
                                                            };

                                                            function setPeriod(p) {
                                                                document.querySelectorAll('.stat-period-btn').forEach(function (b) {
                                                                    b.classList.remove('bg-white', 'text-primary', 'shadow-sm');
                                                                    b.classList.add('text-slate-500', 'dark:text-slate-400');
                                                                });
                                                                var btn = document.getElementById('pbtn-' + p);
                                                                if (btn) {
                                                                    btn.classList.add('bg-white', 'text-primary', 'shadow-sm');
                                                                    btn.classList.remove('text-slate-500', 'dark:text-slate-400');
                                                                }
                                                                var meta = CHART_META[p];
                                                                var stats = STATS_DATA[p];
                                                                document.getElementById('periodLabel').textContent = meta.period;
                                                                document.getElementById('chartSubtitle').textContent = meta.subtitle;
                                                                document.getElementById('stat-views').textContent = VIEWS_DATA[p];
                                                                document.getElementById('views-period-label').textContent = meta.period;
                                                                document.getElementById('stat-published').textContent = stats.published;
                                                                document.getElementById('stat-draft').textContent = stats.draft;
                                                                document.getElementById('stat-comments').textContent = stats.comments;
                                                                renderChart(CHART_DATA[p], LABEL_DATA[p]);
                                                            }

                                                            function renderChart(data, labels) {
                                                                var max = Math.max.apply(null, data) || 1;
                                                                var n = data.length;
                                                                // Hiện nhãn thưa dần khi có nhiều cột
                                                                var showEvery = n >= 28 ? 5 : n >= 14 ? 2 : 1;

                                                                var barsHtml = '';
                                                                var labelsHtml = '';
                                                                data.forEach(function (v, i) {
                                                                    var pct = Math.max(4, Math.round(v * 100 / max));
                                                                    var isLast = i === n - 1;
                                                                    var cls = isLast ? 'bg-primary' : (pct > 60 ? 'bg-primary/60' : 'bg-primary/25');
                                                                    var tip = (v >= 1000 ? (v / 1000).toFixed(1) + 'k' : String(v)) + ' lượt xem';
                                                                    var xLbl = (labels && labels[i]) ? labels[i] : '';

                                                                    barsHtml += '<div class="chart-bar" style="height:100%;flex:1">'
                                                                        + '<div class="bar-tooltip">' + xLbl + ': ' + tip + '</div>'
                                                                        + '<div class="' + cls + ' rounded-t-sm w-full transition-all hover:opacity-100" style="height:' + pct + '%"></div>'
                                                                        + '</div>';

                                                                    var show = (i % showEvery === 0) || isLast;
                                                                    labelsHtml += '<div style="flex:1;text-align:center;font-size:9px;color:#64748b;white-space:nowrap;overflow:hidden;">'
                                                                        + (show ? xLbl : '') + '</div>';
                                                                });

                                                                document.getElementById('chartBars').innerHTML = barsHtml;
                                                                document.getElementById('chartXLabels').innerHTML = labelsHtml;
                                                            }

                                                            document.addEventListener('DOMContentLoaded', function () { setPeriod('all'); });
                                                        </script>

                                                        <%-- ══ TABLE: BÀI VIẾT HIỆU SUẤT CAO ══ --%>
                                                            <div class="space-y-4">
                                                                <div class="flex items-center justify-between">
                                                                    <h4 class="text-base font-bold">Bài viết có hiệu
                                                                        suất cao nhất</h4>
                                                                    <a href="${ctx}/journalist/articles"
                                                                        class="text-xs font-semibold text-primary hover:underline">Xem
                                                                        tất cả bài viết</a>
                                                                </div>

                                                                <div
                                                                    class="bg-white dark:bg-slate-900 border border-slate-200 dark:border-border-dark rounded-xl overflow-hidden">
                                                                    <table class="w-full text-left">
                                                                        <thead>
                                                                            <tr
                                                                                class="bg-slate-50 dark:bg-slate-800/50 border-b border-slate-200 dark:border-border-dark">
                                                                                <th
                                                                                    class="px-6 py-4 text-[11px] font-bold text-slate-500 uppercase tracking-wider">
                                                                                    Tiêu đề bài viết</th>
                                                                                <th
                                                                                    class="px-6 py-4 text-[11px] font-bold text-slate-500 uppercase tracking-wider text-right">
                                                                                    Lượt xem</th>
                                                                                <th
                                                                                    class="px-6 py-4 text-[11px] font-bold text-slate-500 uppercase tracking-wider text-right">
                                                                                    Thời gian đọc</th>
                                                                                <th
                                                                                    class="px-6 py-4 text-[11px] font-bold text-slate-500 uppercase tracking-wider text-right">
                                                                                    Danh mục</th>
                                                                                <c:choose>
                                                                                    <c:when test="${empty topArticles}">
                                                                            <tr>
                                                                                <td colspan="5"
                                                                                    class="px-6 py-12 text-center text-slate-400 text-sm">
                                                                                    <span
                                                                                        class="material-symbols-outlined text-4xl block mb-2">article</span>
                                                                                    Chưa có bài viết nào được xuất bản.
                                                                                </td>
                                                                            </tr>
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                <c:forEach var="a"
                                                                                    items="${topArticles}">
                                                                                    <tr
                                                                                        class="hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-colors">
                                                                                        <td class="px-6 py-4">
                                                                                            <div
                                                                                                class="flex items-center gap-3">
                                                                                                <div
                                                                                                    class="size-8 rounded bg-primary/10 flex items-center justify-center text-primary shrink-0">
                                                                                                    <span
                                                                                                        class="material-symbols-outlined text-lg">article</span>
                                                                                                </div>
                                                                                                <div>
                                                                                                    <a href="${ctx}/user/article?id=${a.id}"
                                                                                                        class="text-xs font-bold truncate max-w-[280px] block hover:text-primary transition-colors">
                                                                                                        <c:out
                                                                                                            value="${a.title}" />
                                                                                                    </a>
                                                                                                    <p
                                                                                                        class="text-[10px] text-slate-400">
                                                                                                        Đã xuất bản</p>
                                                                                                </div>
                                                                                            </div>
                                                                                        </td>
                                                                                        <td
                                                                                            class="px-6 py-4 text-right text-xs font-semibold">
                                                                                            ${a.formattedViews}</td>
                                                                                        <td
                                                                                            class="px-6 py-4 text-right text-xs font-semibold">
                                                                                            ${a.readingTime}</td>
                                                                                        <td
                                                                                            class="px-6 py-4 text-right text-xs text-slate-500">
                                                                                            <c:out
                                                                                                value="${not empty a.categoryName ? a.categoryName : '—'}" />
                                                                                        </td>
                                                                                        <td
                                                                                            class="px-6 py-4 text-center">
                                                                                            <span
                                                                                                class="inline-flex items-center px-2 py-0.5 rounded-full text-[10px] font-bold ${a.statusBadgeClass}">
                                                                                                ${a.statusLabel}
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
                                    </div>
                        </main>
                    </div>
                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            setPeriod('all');

                            // Auto-hide toasts
                            setTimeout(() => {
                                const toasts = document.querySelectorAll('#toast-success, #toast-error');
                                toasts.forEach(t => {
                                    t.style.opacity = '0';
                                    t.style.transform = 'translateY(-20px)';
                                    t.style.transition = 'all 0.5s ease-out';
                                    setTimeout(() => t.remove(), 500);
                                });
                            }, 4000);
                        });
                    </script>
                </body>

                </html>