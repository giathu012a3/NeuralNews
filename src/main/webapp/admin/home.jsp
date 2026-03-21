<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <jsp:include page="components/head.jsp" />
        <title>Bảng điều khiển Quản trị toàn cầu NexusAI</title>
    </head>

    <body class="bg-background-light dark:bg-background-dark font-display text-slate-800 dark:text-slate-100">
        <div class="flex min-h-screen">
            <!-- Sidebar -->
            <jsp:include page="components/sidebar.jsp">
                <jsp:param name="activePage" value="dashboard" />
            </jsp:include>

            <!-- Main Content -->
            <main class="flex-1 ml-64 bg-[#F4F7FE] dark:bg-background-dark/95 min-h-screen">
                <!-- Header -->
                <header
                    class="sticky top-0 z-40 bg-[#F4F7FE]/80 dark:bg-background-dark/80 backdrop-blur-md px-8 py-4 flex items-center justify-between">
                    <div>
                        <p class="text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-widest">
                            Trang / Bảng điều khiển</p>
                        <h2 class="text-2xl font-bold text-slate-800 dark:text-white">Bảng điều khiển hệ thống</h2>
                    </div>
                    <div class="flex items-center gap-4">
                        <jsp:include page="components/header_profile.jsp" />
                    </div>
                </header>
                <div class="p-8 space-y-8">
                    <!-- Row 1: KPI Cards -->
                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                        <!-- Card 1 -->
                        <div
                            class="bg-white dark:bg-slate-800 p-6 rounded-xl shadow-sm flex items-center gap-4 border border-slate-50 dark:border-slate-700">
                            <div class="w-12 h-12 bg-primary/10 rounded-full flex items-center justify-center">
                                <span class="material-icons text-primary">groups</span>
                            </div>
                            <div>
                                <p class="text-sm font-medium text-slate-500 dark:text-slate-400">Người dùng đang hoạt
                                    động</p>
                                <h3 class="text-2xl font-bold text-slate-800 dark:text-white">${totalUsers}</h3>
                            </div>
                        </div>
                        <!-- Card 2 -->
                        <div
                            class="bg-white dark:bg-slate-800 p-6 rounded-xl shadow-sm flex items-center gap-4 border border-slate-50 dark:border-slate-700">
                            <div
                                class="w-12 h-12 bg-green-100 dark:bg-green-900/30 rounded-full flex items-center justify-center">
                                <span class="material-icons text-green-500">article</span>
                            </div>
                            <div>
                                <p class="text-sm font-medium text-slate-500 dark:text-slate-400">Bài viết mới hôm nay
                                </p>
                                <h3 class="text-2xl font-bold text-slate-800 dark:text-white">${todayArticles}</h3>
                            </div>
                        </div>
                        <!-- Card 3 -->
                        <div
                            class="bg-white dark:bg-slate-800 p-6 rounded-xl shadow-sm flex items-center gap-4 border border-slate-50 dark:border-slate-700">
                            <div
                                class="w-12 h-12 bg-amber-100 dark:bg-amber-900/30 rounded-full flex items-center justify-center">
                                <span class="material-icons text-amber-500">person_add</span>
                            </div>
                            <div>
                                <p class="text-sm font-medium text-slate-500 dark:text-slate-400">Yêu cầu Nhà báo</p>
                                <h3 class="text-2xl font-bold text-slate-800 dark:text-white">${journalistApplications}</h3>
                            </div>
                        </div>
                        <!-- Card 4 -->
                        <div
                            class="bg-white dark:bg-slate-800 p-6 rounded-xl shadow-sm flex items-center gap-4 border border-slate-50 dark:border-slate-700">
                            <div
                                class="w-12 h-12 bg-red-100 dark:bg-red-900/30 rounded-full flex items-center justify-center">
                                <span class="material-icons text-red-500">report_problem</span>
                            </div>
                            <div>
                                <p class="text-sm font-medium text-slate-500 dark:text-slate-400">Vi phạm đang chờ xử lý
                                </p>
                                <h3 class="text-2xl font-bold text-slate-800 dark:text-white">${pendingViolations}</h3>
                            </div>
                        </div>
                    </div>
                    <!-- Row 2: Traffic and AI Insights -->
                    <div class="grid grid-cols-1 lg:grid-cols-10 gap-6">
                        <!-- Traffic Chart -->
                        <div
                            class="lg:col-span-7 bg-white dark:bg-slate-800 p-6 rounded-xl shadow-sm border border-slate-50 dark:border-slate-700">
                            <div class="flex items-center justify-between mb-6">
                                <div>
                                    <h3 class="font-bold text-slate-800 dark:text-white">Tổng quan Lưu lượng ${currentDays != null ? currentDays : 7} ngày qua</h3>
                                    <p class="text-xs text-slate-500">Dựa trên số lượt xem thực tế theo từng ngày</p>
                                </div>
                                <div>
                                    <select onchange="window.location.href='${pageContext.request.contextPath}/admin/home?days=' + this.value"
                                            class="bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-700 text-slate-700 dark:text-slate-300 rounded-lg text-sm px-3 py-1.5 focus:ring-primary focus:border-primary outline-none cursor-pointer">
                                        <option value="7" ${currentDays == 7 ? 'selected' : ''}>7 Ngày</option>
                                        <option value="30" ${currentDays == 30 ? 'selected' : ''}>30 Ngày</option>
                                        <option value="365" ${currentDays == 365 ? 'selected' : ''}>1 Năm</option>
                                    </select>
                                </div>
                            </div>
                            <div class="h-64 relative">
                                <canvas id="trafficChart"></canvas>
                            </div>
                        </div>
                        <!-- Category Distribution Chart -->
                        <div
                            class="lg:col-span-3 bg-white dark:bg-slate-800 p-6 rounded-xl shadow-sm border border-slate-50 dark:border-slate-700 flex flex-col items-center">
                            <h3 class="font-bold text-slate-800 dark:text-white mb-6 self-start">Tỉ lệ Danh mục</h3>
                            <div class="w-full h-64 relative">
                                <canvas id="categoryChart"></canvas>
                            </div>
                            <div class="mt-4 grid grid-cols-2 gap-4 w-full">
                                <c:forEach var="cat" items="${categoryStats}" varStatus="loop">
                                    <c:if test="${loop.index < 4}">
                                        <div class="flex items-center gap-2">
                                            <div class="w-3 h-3 rounded-full" style="background-color: ${loop.index == 0 ? '#0d7ff2' : (loop.index == 1 ? '#00e396' : (loop.index == 2 ? '#feb019' : '#ff4560'))}"></div>
                                            <span class="text-xs text-slate-500 truncate">${cat.name}</span>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </div>

                    <!-- Chart.js Script -->
                    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
                    <script>
                        document.addEventListener("DOMContentLoaded", function() {
                            // 1. Category Chart
                            const catCtx = document.getElementById('categoryChart').getContext('2d');
                            const categories = [
                                <c:forEach var="cat" items="${categoryStats}" varStatus="loop">
                                    '${cat.name}'${!loop.last ? ',' : ''}
                                </c:forEach>
                            ];
                            const catCounts = [
                                <c:forEach var="cat" items="${categoryStats}" varStatus="loop">
                                    ${cat.articleCount}${!loop.last ? ',' : ''}
                                </c:forEach>
                            ];

                            new Chart(catCtx, {
                                type: 'doughnut',
                                data: {
                                    labels: categories,
                                    datasets: [{
                                        data: catCounts,
                                        backgroundColor: ['#0d7ff2', '#00e396', '#feb019', '#ff4560', '#775dd0'],
                                        borderWidth: 0
                                    }]
                                },
                                options: {
                                    responsive: true,
                                    maintainAspectRatio: false,
                                    plugins: { legend: { display: false } },
                                    cutout: '75%'
                                }
                            });

                            // 2. Traffic Chart
                            const trafficCtx = document.getElementById('trafficChart').getContext('2d');
                            const trafficDates = [
                                <c:forEach var="entry" items="${trafficStats}" varStatus="loop">
                                    '${entry.key}'${!loop.last ? ',' : ''}
                                </c:forEach>
                            ];
                            const trafficCounts = [
                                <c:forEach var="entry" items="${trafficStats}" varStatus="loop">
                                    ${entry.value}${!loop.last ? ',' : ''}
                                </c:forEach>
                            ];

                            new Chart(trafficCtx, {
                                type: 'line',
                                data: {
                                    labels: trafficDates,
                                    datasets: [{
                                        label: 'Lượt xem',
                                        data: trafficCounts,
                                        borderColor: '#0d7ff2',
                                        backgroundColor: 'rgba(13, 127, 242, 0.1)',
                                        fill: true,
                                        tension: 0.4,
                                        pointRadius: 4,
                                        pointBackgroundColor: '#0d7ff2'
                                    }]
                                },
                                options: {
                                    responsive: true,
                                    maintainAspectRatio: false,
                                    plugins: { legend: { display: false } },
                                    scales: {
                                        y: { beginAtZero: true, grid: { display: false } },
                                        x: { grid: { display: false } }
                                    }
                                }
                            });
                        });
                    </script>
                    </div>
                    <!-- Row 3: Quick Action Table -->
                    <div
                        class="bg-white dark:bg-slate-800 rounded-xl shadow-sm border border-slate-50 dark:border-slate-700 overflow-hidden">
                        <div
                            class="p-6 border-b border-slate-50 dark:border-slate-700 flex items-center justify-between">
                            <h3 class="text-lg font-bold text-slate-800 dark:text-white">Bài viết mới cập nhật</h3>
                            <a href="${pageContext.request.contextPath}/admin/content" class="text-primary text-sm font-semibold hover:underline">Xem tất cả</a>
                        </div>
                        <div class="overflow-x-auto">
                            <table class="w-full text-left">
                                <thead class="bg-slate-50 dark:bg-slate-700/50">
                                    <tr>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider">
                                            Bài viết</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider">
                                            Danh mục</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider">
                                            Trạng thái</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider text-right">
                                            Hành động</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-slate-50 dark:divide-slate-700">
                                    <c:forEach var="art" items="${recentArticles}">
                                    <tr class="hover:bg-slate-50/50 dark:hover:bg-slate-700/30 transition-colors">
                                        <td class="px-6 py-4">
                                            <div class="flex items-center gap-3">
                                                <div class="w-10 h-10 rounded bg-slate-200 dark:bg-slate-700 flex-shrink-0">
                                                    <img class="w-full h-full object-cover rounded" src="${art.imageUrl}" onerror="this.src='https://placehold.co/100x100?text=News'" />
                                                </div>
                                                <div class="max-w-xs xl:max-w-md">
                                                    <p class="text-sm font-semibold text-slate-800 dark:text-white truncate">${art.title}</p>
                                                    <p class="text-[10px] text-slate-500">ID: #${art.id}</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4">
                                            <span class="text-xs font-medium px-2.5 py-0.5 rounded-full bg-blue-100 text-blue-800 dark:bg-blue-900/30 dark:text-blue-300">
                                                ${art.categoryName}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4">
                                            <c:choose>
                                                <c:when test="${art.status == 'PUBLISHED'}">
                                                    <span class="px-2 py-1 text-[10px] font-bold rounded-full bg-green-100 text-green-600">ĐÃ ĐĂNG</span>
                                                </c:when>
                                                <c:when test="${art.status == 'PENDING'}">
                                                    <span class="px-2 py-1 text-[10px] font-bold rounded-full bg-amber-100 text-amber-600">CHỜ DUYỆT</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-2 py-1 text-[10px] font-bold rounded-full bg-slate-100 text-slate-600">${art.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-6 py-4 text-right">
                                            <div class="flex justify-end gap-2">
                                                <a href="${pageContext.request.contextPath}/admin/content?action=edit&id=${art.id}"
                                                     class="p-2 bg-primary/10 text-primary hover:bg-primary hover:text-white rounded-lg transition-all">
                                                    <span class="material-icons text-[18px]">edit</span>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </body>

    </html>