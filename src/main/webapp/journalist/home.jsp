<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html class="dark" lang="en">

    <head>
        <jsp:include page="components/head.jsp" />
        <title>Bảng điều khiển Hiệu suất Nhà báo - NexusAI</title>
    </head>

    <body class="min-h-screen overflow-hidden">
        <div class="flex h-screen overflow-hidden">
            <jsp:include page="components/sidebar.jsp">
                <jsp:param name="activePage" value="dashboard" />
            </jsp:include>
            <main class="flex-1 flex flex-col min-w-0">
                <header
                    class="h-16 bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-border-dark flex items-center justify-between px-8 shrink-0 z-20">
                    <div class="flex items-center gap-6">
                        <h2 class="text-lg font-bold tracking-tight">Bảng điều khiển Nhà báo</h2>
                        <div class="hidden md:flex items-center gap-2 text-xs text-slate-500 font-medium">
                            <span>Cổng thông tin Nhà báo</span>
                            <span class="material-symbols-outlined text-sm">chevron_right</span>
                            <span class="text-slate-900 dark:text-slate-200">Tóm tắt Hiệu suất</span>
                        </div>
                    </div>
                    <div class="flex items-center gap-3">
                        <div class="relative group">
                            <span
                                class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-lg">search</span>
                            <input
                                class="bg-slate-100 dark:bg-slate-800 border-none rounded-lg py-1.5 pl-10 pr-4 w-64 focus:ring-2 focus:ring-primary text-xs transition-all"
                                placeholder="Tìm kiếm phân tích..." type="text" />
                        </div>
                        <div class="h-6 w-px bg-slate-200 dark:border-border-dark mx-1"></div>
                        <button
                            class="relative p-2 rounded-lg hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors text-slate-500">
                            <span class="material-symbols-outlined">notifications</span>
                            <span
                                class="absolute top-2.5 right-2.5 size-2 bg-red-500 rounded-full border-2 border-white dark:border-slate-900"></span>
                        </button>
                        <button
                            class="p-2 rounded-lg hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors text-slate-500"
                            title="Chuyển đổi Giao diện">
                            <span class="material-symbols-outlined">light_mode</span>
                        </button>
                    </div>
                </header>
                <div class="flex-1 overflow-y-auto">
                    <div class="p-8 max-w-7xl mx-auto space-y-8">
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                            <div class="card-stat">
                                <div class="flex items-center justify-between mb-4">
                                    <span
                                        class="p-2 bg-blue-100 dark:bg-blue-900/30 text-blue-600 dark:text-blue-400 rounded-lg material-symbols-outlined">visibility</span>
                                    <span class="text-[11px] font-bold text-emerald-500 flex items-center gap-1">
                                        <span class="material-symbols-outlined text-xs">trending_up</span> +12.5%
                                    </span>
                                </div>
                                <p
                                    class="text-slate-500 dark:text-slate-400 text-xs font-semibold uppercase tracking-wider">
                                    Tổng lượt xem</p>
                                <h3 class="text-3xl font-bold mt-1 tracking-tight">1.2M</h3>
                            </div>
                            <div class="card-stat">
                                <div class="flex items-center justify-between mb-4">
                                    <span
                                        class="p-2 bg-orange-100 dark:bg-orange-900/30 text-orange-600 dark:text-orange-400 rounded-lg material-symbols-outlined">timer</span>
                                    <span class="text-[11px] font-bold text-emerald-500 flex items-center gap-1">
                                        <span class="material-symbols-outlined text-xs">trending_up</span> +4.2%
                                    </span>
                                </div>
                                <p
                                    class="text-slate-500 dark:text-slate-400 text-xs font-semibold uppercase tracking-wider">
                                    Thời gian đọc trung bình</p>
                                <h3 class="text-3xl font-bold mt-1 tracking-tight">4m 32s</h3>
                            </div>
                            <div class="card-stat">
                                <div class="flex items-center justify-between mb-4">
                                    <span
                                        class="p-2 bg-purple-100 dark:bg-purple-900/30 text-purple-600 dark:text-purple-400 rounded-lg material-symbols-outlined">forum</span>
                                    <span class="text-[11px] font-bold text-rose-500 flex items-center gap-1">
                                        <span class="material-symbols-outlined text-xs">trending_down</span> -0.8%
                                    </span>
                                </div>
                                <p
                                    class="text-slate-500 dark:text-slate-400 text-xs font-semibold uppercase tracking-wider">
                                    Tỷ lệ tương tác</p>
                                <h3 class="text-3xl font-bold mt-1 tracking-tight">8.42%</h3>
                            </div>
                        </div>
                        <div
                            class="bg-white dark:bg-slate-900 border border-slate-200 dark:border-border-dark rounded-xl p-6">
                            <div class="flex items-center justify-between mb-8">
                                <div>
                                    <h4 class="text-base font-bold">Xu hướng lượt xem</h4>
                                    <p class="text-xs text-slate-500">Hiệu suất lưu lượng truy cập qua 30 ngày qua</p>
                                </div>
                                <div class="flex bg-slate-100 dark:bg-slate-800 p-1 rounded-lg">
                                    <button
                                        class="px-3 py-1 text-[11px] font-bold rounded-md bg-white dark:bg-slate-700 shadow-sm">Hàng
                                        ngày</button>
                                    <button class="px-3 py-1 text-[11px] font-bold text-slate-500">Hàng tuần</button>
                                </div>
                            </div>
                            <div class="h-[300px] w-full relative flex items-end justify-between gap-2 px-2">
                                <div class="flex-1 bg-primary/20 rounded-t-sm h-[40%]" title="Day 1"></div>
                                <div class="flex-1 bg-primary/20 rounded-t-sm h-[45%]" title="Day 2"></div>
                                <div class="flex-1 bg-primary/20 rounded-t-sm h-[38%]" title="Day 3"></div>
                                <div class="flex-1 bg-primary/20 rounded-t-sm h-[55%]" title="Day 4"></div>
                                <div class="flex-1 bg-primary/20 rounded-t-sm h-[65%]" title="Day 5"></div>
                                <div class="flex-1 bg-primary/40 rounded-t-sm h-[75%]" title="Day 6"></div>
                                <div class="flex-1 bg-primary/20 rounded-t-sm h-[60%]" title="Day 7"></div>
                                <div class="flex-1 bg-primary/20 rounded-t-sm h-[58%]" title="Day 8"></div>
                                <div class="flex-1 bg-primary/30 rounded-t-sm h-[80%]" title="Day 9"></div>
                                <div class="flex-1 bg-primary/40 rounded-t-sm h-[90%]" title="Day 10"></div>
                                <div class="flex-1 bg-primary/30 rounded-t-sm h-[85%]" title="Day 11"></div>
                                <div class="flex-1 bg-primary/20 rounded-t-sm h-[70%]" title="Day 12"></div>
                                <div class="flex-1 bg-primary/60 rounded-t-sm h-[95%]" title="Day 13"></div>
                                <div class="flex-1 bg-primary/40 rounded-t-sm h-[82%]" title="Day 14"></div>
                                <div class="flex-1 bg-primary/20 rounded-t-sm h-[60%]" title="Day 15"></div>
                            </div>
                            <div
                                class="flex justify-between mt-4 px-2 text-[10px] text-slate-400 font-medium uppercase tracking-tighter">
                                <span>01 Thg 10</span>
                                <span>15 Thg 10</span>
                                <span>30 Thg 10</span>
                            </div>
                        </div>
                        <div class="space-y-4">
                            <div class="flex items-center justify-between">
                                <h4 class="text-base font-bold">Bài viết có hiệu suất cao nhất</h4>
                                <button
                                    onclick="window.location.href='${pageContext.request.contextPath}/journalist/articles.jsp'"
                                    class="text-xs font-semibold text-primary hover:underline">Xem tất cả Bài
                                    viết</button>
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
                                                Tương tác</th>
                                            <th
                                                class="px-6 py-4 text-[11px] font-bold text-slate-500 uppercase tracking-wider text-center">
                                                Trạng thái</th>
                                        </tr>
                                    </thead>
                                    <tbody class="divide-y divide-slate-100 dark:divide-border-dark">
                                        <tr class="hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-colors">
                                            <td class="px-6 py-4">
                                                <div class="flex items-center gap-3">
                                                    <div
                                                        class="size-8 rounded bg-primary/10 flex items-center justify-center text-primary">
                                                        <span class="material-symbols-outlined text-lg">article</span>
                                                    </div>
                                                    <div>
                                                        <p class="text-xs font-bold truncate max-w-[240px]">Tương lai
                                                            của AI trong báo chí hiện đại</p>
                                                        <p class="text-[10px] text-slate-400">Xuất bản 2 ngày trước</p>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 text-right text-xs font-semibold">124,502</td>
                                            <td class="px-6 py-4 text-right text-xs font-semibold">5m 12s</td>
                                            <td class="px-6 py-4 text-right">
                                                <div
                                                    class="flex items-center justify-end gap-2 text-xs font-semibold text-emerald-500">
                                                    <span>12.4%</span>
                                                    <span class="material-symbols-outlined text-sm">trending_up</span>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 text-center">
                                                <span
                                                    class="inline-flex items-center px-2 py-0.5 rounded-full text-[10px] font-bold bg-emerald-100 text-emerald-700 dark:bg-emerald-500/10 dark:text-emerald-400">
                                                    TRỰC TIẾP
                                                </span>
                                            </td>
                                        </tr>
                                        <tr class="hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-colors">
                                            <td class="px-6 py-4">
                                                <div class="flex items-center gap-3">
                                                    <div
                                                        class="size-8 rounded bg-primary/10 flex items-center justify-center text-primary">
                                                        <span class="material-symbols-outlined text-lg">article</span>
                                                    </div>
                                                    <div>
                                                        <p class="text-xs font-bold truncate max-w-[240px]">An ninh mạng
                                                            trong kỷ nguyên điện toán lượng tử</p>
                                                        <p class="text-[10px] text-slate-400">Xuất bản 5 ngày trước</p>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 text-right text-xs font-semibold">98,211</td>
                                            <td class="px-6 py-4 text-right text-xs font-semibold">4m 45s</td>
                                            <td class="px-6 py-4 text-right">
                                                <div
                                                    class="flex items-center justify-end gap-2 text-xs font-semibold text-slate-500">
                                                    <span>9.1%</span>
                                                    <span class="material-symbols-outlined text-sm">remove</span>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 text-center">
                                                <span
                                                    class="inline-flex items-center px-2 py-0.5 rounded-full text-[10px] font-bold bg-emerald-100 text-emerald-700 dark:bg-emerald-500/10 dark:text-emerald-400">
                                                    TRỰC TIẾP
                                                </span>
                                            </td>
                                        </tr>
                                        <tr class="hover:bg-slate-50 dark:hover:bg-slate-800/30 transition-colors">
                                            <td class="px-6 py-4">
                                                <div class="flex items-center gap-3">
                                                    <div
                                                        class="size-8 rounded bg-primary/10 flex items-center justify-center text-primary">
                                                        <span class="material-symbols-outlined text-lg">article</span>
                                                    </div>
                                                    <div>
                                                        <p class="text-xs font-bold truncate max-w-[240px]">Tại sao các
                                                            tòa soạn địa phương không thể mở rộng</p>
                                                        <p class="text-[10px] text-slate-400">Xuất bản 1 tuần trước</p>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 text-right text-xs font-semibold">45,320</td>
                                            <td class="px-6 py-4 text-right text-xs font-semibold">3m 20s</td>
                                            <td class="px-6 py-4 text-right">
                                                <div
                                                    class="flex items-center justify-end gap-2 text-xs font-semibold text-rose-500">
                                                    <span>3.2%</span>
                                                    <span class="material-symbols-outlined text-sm">trending_down</span>
                                                </div>
                                            </td>
                                            <td class="px-6 py-4 text-center">
                                                <span
                                                    class="inline-flex items-center px-2 py-0.5 rounded-full text-[10px] font-bold bg-slate-100 text-slate-700 dark:bg-slate-800 dark:text-slate-400">
                                                    ĐÃ LƯU TRỮ
                                                </span>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </body>

    </html>