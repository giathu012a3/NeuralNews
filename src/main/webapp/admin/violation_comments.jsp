<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="components/head.jsp" />
    <title>Xử lý Vi phạm Bình luận | NexusAI Admin</title>
</head>
<body class="bg-dashboard-bg dark:bg-background-dark font-sans text-slate-800 dark:text-slate-100 overflow-hidden">
    <div class="flex h-screen overflow-hidden">
        <jsp:include page="components/sidebar.jsp">
            <jsp:param name="activePage" value="violation" />
        </jsp:include>
        <main class="flex-1 ml-64 flex flex-col min-w-0 bg-dashboard-bg dark:bg-slate-900 overflow-hidden">
            <header class="bg-white dark:bg-slate-800 px-8 py-4 flex items-center justify-between border-b border-slate-200 dark:border-slate-700">
                <div>
                    <p class="text-[10px] font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-widest">
                        Tuân thủ / Kiểm duyệt</p>
                    <h2 class="text-2xl font-bold text-slate-800 dark:text-white">Xử lý Vi phạm</h2>
                </div>
                <div class="flex items-center gap-4"> 
                    <button class="bg-primary text-white px-5 py-2.5 rounded-lg flex items-center gap-2 font-semibold shadow-md shadow-primary/20 hover:bg-primary/90 transition-all">
                        <span class="material-symbols-outlined text-[20px]">auto_fix_high</span> AI Tự động dọn dẹp
                    </button>
                    <jsp:include page="components/header_profile.jsp" />
                </div>
            </header>
            <div class="px-8 bg-white dark:bg-slate-800 border-b border-slate-200 dark:border-slate-700 flex gap-8">
                <a href="${pageContext.request.contextPath}/admin/violation.jsp"
                    class="py-4 text-sm font-bold text-slate-400 hover:text-slate-600 dark:hover:text-slate-300 transition-all">Báo cáo Bài viết</a> 
                <button class="py-4 text-sm font-bold border-b-2 border-primary text-primary transition-all flex items-center gap-2">
                    Báo cáo Bình luận <span class="bg-primary/10 text-primary px-2 py-0.5 rounded-full text-xs">15</span> 
                </button>
            </div>
            <div class="flex-1 flex overflow-hidden">
                <div class="flex-1 overflow-y-auto p-8">
                    <div class="bg-white dark:bg-slate-800 rounded-xl shadow-sm border border-slate-200 dark:border-slate-700 overflow-hidden">
                        <table class="w-full text-left border-collapse">
                            <thead class="bg-slate-50 dark:bg-slate-700/50 sticky top-0 z-10">
                                <tr>
                                    <th class="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider">Đối tượng</th>
                                    <th class="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider">Lý do</th>
                                    <th class="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider">Người báo cáo</th>
                                    <th class="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider">Đánh giá AI</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-100 dark:divide-slate-700">
                                <tr class="bg-primary/5 hover:bg-primary/10 transition-colors cursor-pointer border-l-4 border-l-primary">
                                    <td class="px-6 py-5">
                                        <div>
                                            <p class="text-sm font-semibold text-slate-800 dark:text-white line-clamp-1">
                                                "Toàn bộ câu chuyện này là một sự bịa đặt hoàn toàn bởi deep state..." </p>
                                            <p class="text-[10px] text-slate-400 mt-1 uppercase font-medium">
                                                Dưới bài viết: Breaking News Coverage #291</p>
                                        </div>
                                    </td>
                                    <td class="px-6 py-5">
                                        <div class="flex items-center gap-2"> 
                                            <span class="material-symbols-outlined text-red-500 text-lg">warning</span>
                                            <span class="text-sm text-slate-600 dark:text-slate-300">Tin giả</span>
                                        </div>
                                    </td>
                                    <td class="px-6 py-5">
                                        <div>
                                            <p class="text-sm font-medium text-slate-800 dark:text-white">Sarah Jenkins </p>
                                            <p class="text-[10px] text-green-500 font-bold">Độ tin cậy: 98%</p>
                                        </div>
                                    </td>
                                    <td class="px-6 py-5"> 
                                        <span class="px-3 py-1 text-[10px] font-bold rounded-full bg-red-100 text-red-600 border border-red-200 uppercase">Rủi ro cao</span> 
                                    </td>
                                </tr>
                                <tr class="hover:bg-slate-50 dark:hover:bg-slate-700/50 transition-colors cursor-pointer">
                                    <td class="px-6 py-5">
                                        <div>
                                            <p class="text-sm font-medium text-slate-600 dark:text-slate-400 line-clamp-1">
                                                "Bạn thực sự không hiểu về kinh tế cơ bản của chính sách này..." </p>
                                            <p class="text-[10px] text-slate-400 mt-1 uppercase">Dưới bài viết: Dự báo kinh tế 2025</p>
                                        </div>
                                    </td>
                                    <td class="px-6 py-5">
                                        <div class="flex items-center gap-2"> 
                                            <span class="material-symbols-outlined text-slate-400 text-lg">forum</span>
                                            <span class="text-sm text-slate-600 dark:text-slate-300">Quấy rối</span>
                                        </div>
                                    </td>
                                    <td class="px-6 py-5">
                                        <div>
                                            <p class="text-sm font-medium text-slate-800 dark:text-white">Ẩn danh #821</p>
                                            <p class="text-[10px] text-amber-500 font-bold">Độ tin cậy: 45%</p>
                                        </div>
                                    </td>
                                    <td class="px-6 py-5"> 
                                        <span class="px-3 py-1 text-[10px] font-bold rounded-full bg-amber-100 text-amber-600 border border-amber-200 uppercase">Cần xem xét</span> 
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <aside class="w-96 bg-white dark:bg-slate-800 border-l border-slate-200 dark:border-slate-700 flex flex-col overflow-y-auto">
                    <div class="p-6 border-b border-slate-100 dark:border-slate-700">
                        <div class="flex items-center justify-between mb-2">
                            <h3 class="font-bold text-slate-800 dark:text-white">Chi tiết báo cáo</h3> 
                            <span class="text-[10px] font-bold text-primary bg-primary/10 px-2 py-1 rounded">#RPT-9942</span>
                        </div>
                        <p class="text-xs text-slate-500">Đã báo cáo vào 24 Th10, 14:22</p>
                    </div>
                    <div class="p-6 space-y-8 flex-1">
                        <section>
                            <h4 class="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-4">Bối cảnh</h4>
                            <div class="bg-slate-50 dark:bg-slate-900/50 p-4 rounded-xl border border-slate-100 dark:border-slate-700">
                                <div class="flex items-center gap-2 mb-3"> 
                                    <div class="size-6 rounded-full bg-slate-200"></div>
                                    <p class="text-xs font-bold text-slate-800 dark:text-white">Marcus Thorne</p> 
                                    <span class="text-[10px] text-slate-400">• 2 giờ trước</span>
                                </div>
                                <p class="text-sm text-slate-600 dark:text-slate-300 leading-relaxed italic border-l-2 border-slate-300 pl-3">
                                    "Toàn bộ câu chuyện này là một sự bịa đặt hoàn toàn... Họ đang nói dối về dữ liệu..." </p>
                            </div>
                        </section>
                        <section>
                            <h4 class="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-4">Lịch sử vi phạm</h4>
                            <div class="space-y-3">
                                <div class="flex items-center justify-between text-xs"> 
                                    <span class="text-slate-600 dark:text-slate-400">Số lần vi phạm</span> 
                                    <span class="font-bold text-red-500">2 / 3</span> 
                                </div>
                                <div class="w-full bg-slate-100 dark:bg-slate-700 h-1.5 rounded-full overflow-hidden">
                                    <div class="bg-red-500 h-full w-[66%]"></div>
                                </div>
                            </div>
                        </section>
                    </div>
                    <div class="p-6 bg-slate-50 dark:bg-slate-900/50 border-t border-slate-200 dark:border-slate-700 space-y-3">
                        <button class="w-full py-2.5 bg-slate-200 dark:bg-slate-700 text-slate-700 dark:text-slate-200 rounded-lg text-sm font-bold hover:bg-slate-300 dark:hover:bg-slate-600 transition-all">
                            Bác bỏ báo cáo </button>
                        <div class="grid grid-cols-2 gap-3"> 
                            <button class="py-2.5 bg-amber-500 text-white rounded-lg text-sm font-bold shadow-md shadow-amber-500/20 hover:bg-amber-600 transition-all"> Gỡ nội dung </button> 
                            <button class="py-2.5 bg-red-600 text-white rounded-lg text-sm font-bold shadow-md shadow-red-600/20 hover:bg-red-700 transition-all"> Khóa người dùng </button> 
                        </div>
                    </div>
                </aside>
            </div>
        </main>
    </div>
</body>
</html>