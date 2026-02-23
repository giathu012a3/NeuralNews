<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html class="dark" lang="en">

    <head>
        <title>Bảng điều khiển Người dùng - NexusAI</title>
        <jsp:include page="components/head.jsp" />
        <style>
            .scrollbar-hide::-webkit-scrollbar {
                display: none;
            }

            .scrollbar-hide {
                -ms-overflow-style: none;
                scrollbar-width: none;
            }
        </style>
    </head>

    <body
        class="bg-background-light dark:bg-background-dark text-text-main dark:text-white font-display antialiased overflow-x-hidden transition-colors duration-200">
        <div class="flex min-h-screen w-full flex-col">
            <jsp:include page="components/header.jsp" />

            <main class="flex-1 w-full max-w-[1440px] mx-auto p-4 lg:p-8 flex flex-col lg:flex-row gap-8">
                <jsp:include page="components/sidebar.jsp" />

                <div class="flex-1 flex flex-col gap-6">
                    <div
                        class="bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-xl overflow-hidden">
                        <div
                            class="flex border-b border-slate-200 dark:border-border-dark overflow-x-auto scrollbar-hide">
                            <button onclick="window.location.href='${pageContext.request.contextPath}/user/profile.jsp'"
                                class="px-6 py-4 text-sm font-bold text-primary border-b-2 border-primary whitespace-nowrap bg-primary/5">
                                Tổng quan
                            </button>
                            <button
                                onclick="window.location.href='${pageContext.request.contextPath}/user/saved_articles.jsp'"
                                class="px-6 py-4 text-sm font-bold text-slate-500 dark:text-slate-400 border-b-2 border-transparent hover:text-primary transition-colors whitespace-nowrap">
                                Bài viết đã lưu
                            </button>
                            <button
                                onclick="window.location.href='${pageContext.request.contextPath}/user/reading_history.jsp'"
                                class="px-6 py-4 text-sm font-bold text-slate-500 dark:text-slate-400 border-b-2 border-transparent hover:text-primary transition-colors whitespace-nowrap">
                                Lịch sử đọc
                            </button>
                            <button
                                onclick="window.location.href='${pageContext.request.contextPath}/user/ai_preferences.jsp'"
                                class="px-6 py-4 text-sm font-bold text-slate-500 dark:text-slate-400 border-b-2 border-transparent hover:text-primary transition-colors whitespace-nowrap">
                                Tùy chọn AI
                            </button>
                        </div>
                        <div class="p-6 md:p-8 space-y-8">
                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                <div
                                    class="p-5 bg-slate-50 dark:bg-background-dark/50 border border-slate-200 dark:border-border-dark rounded-xl flex items-center gap-4">
                                    <div
                                        class="size-12 bg-blue-500/10 text-blue-500 rounded-full flex items-center justify-center">
                                        <span class="material-symbols-outlined">bookmark</span>
                                    </div>
                                    <div>
                                        <p class="text-2xl font-black text-slate-900 dark:text-white leading-tight">42
                                        </p>
                                        <p class="text-xs text-slate-500 uppercase font-bold tracking-wider">Bài viết đã
                                            lưu
                                        </p>
                                    </div>
                                </div>
                                <div
                                    class="p-5 bg-slate-50 dark:bg-background-dark/50 border border-slate-200 dark:border-border-dark rounded-xl flex items-center gap-4">
                                    <div
                                        class="size-12 bg-green-500/10 text-green-500 rounded-full flex items-center justify-center">
                                        <span class="material-symbols-outlined">visibility</span>
                                    </div>
                                    <div>
                                        <p class="text-2xl font-black text-slate-900 dark:text-white leading-tight">158
                                        </p>
                                        <p class="text-xs text-slate-500 uppercase font-bold tracking-wider">Bài viết đã
                                            đọc
                                        </p>
                                    </div>
                                </div>
                                <div
                                    class="p-5 bg-slate-50 dark:bg-background-dark/50 border border-slate-200 dark:border-border-dark rounded-xl flex items-center gap-4">
                                    <div
                                        class="size-12 bg-purple-500/10 text-purple-500 rounded-full flex items-center justify-center">
                                        <span class="material-symbols-outlined">chat_bubble</span>
                                    </div>
                                    <div>
                                        <p class="text-2xl font-black text-slate-900 dark:text-white leading-tight">89
                                        </p>
                                        <p class="text-xs text-slate-500 uppercase font-bold tracking-wider">Bình luận
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                                <div class="space-y-4">
                                    <div class="flex items-center justify-between">
                                        <h3 class="font-bold text-slate-900 dark:text-white flex items-center gap-2">
                                            <span class="material-symbols-outlined text-primary">notifications</span>
                                            Thông báo
                                        </h3>
                                        <button class="text-xs text-primary font-bold hover:underline">Đánh dấu tất cả
                                            đã đọc</button>
                                    </div>
                                    <div class="space-y-3">
                                        <div
                                            class="p-3 bg-white dark:bg-slate-800/50 border border-slate-100 dark:border-slate-700 rounded-lg flex gap-3">
                                            <div
                                                class="size-2 bg-slate-300 dark:bg-slate-600 rounded-full mt-1.5 shrink-0">
                                            </div>
                                            <div>
                                                <p class="text-sm text-slate-800 dark:text-slate-200">AI đề xuất một
                                                    bài viết mới: "Tương lai của Điện toán Lượng tử"</p>
                                                <p class="text-xs text-slate-500 mt-0.5">5 giờ trước</p>
                                            </div>
                                        </div>
                                        <div
                                            class="p-3 bg-white dark:bg-slate-800/50 border border-slate-100 dark:border-slate-700 rounded-lg flex gap-3">
                                            <div
                                                class="size-2 bg-slate-300 dark:bg-slate-600 rounded-full mt-1.5 shrink-0">
                                            </div>
                                            <div>
                                                <p class="text-sm text-slate-800 dark:text-slate-200">Bình luận của bạn
                                                    đạt
                                                    50 lượt thích!</p>
                                                <p class="text-xs text-slate-500 mt-0.5">Hôm qua</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="space-y-4">
                                    <h3 class="font-bold text-slate-900 dark:text-white flex items-center gap-2">
                                        <span class="material-symbols-outlined text-primary">auto_fix</span>
                                        Thông tin chi tiết về Viết lách AI
                                    </h3>
                                    <div
                                        class="p-6 bg-slate-50 dark:bg-background-dark/50 border border-slate-200 dark:border-border-dark rounded-xl">
                                        <div class="flex flex-col items-center text-center gap-4">
                                            <div
                                                class="size-16 rounded-full bg-primary/10 flex items-center justify-center text-primary">
                                                <span class="material-symbols-outlined text-3xl">psychology</span>
                                            </div>
                                            <div>
                                                <p class="text-sm font-bold text-slate-900 dark:text-white">Bắt đầu
                                                    Đóng góp</p>
                                                <p class="text-xs text-slate-500 mt-2">Đăng ký trở thành nhà báo để
                                                    mở khóa các công cụ viết lách do AI hỗ trợ và tiếp cận khán giả toàn
                                                    cầu bằng các
                                                    câu chuyện của bạn.</p>
                                            </div>
                                            <button class="text-xs font-bold text-primary hover:underline">Tìm hiểu thêm
                                                về
                                                các công cụ của chúng tôi</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div
                        class="bg-gradient-to-r from-slate-900 to-primary-dark border border-white/10 rounded-2xl p-8 relative overflow-hidden group">
                        <div
                            class="absolute top-0 right-0 p-12 opacity-10 pointer-events-none group-hover:scale-110 transition-transform duration-700">
                            <span class="material-symbols-outlined text-[160px]">edit_note</span>
                        </div>
                        <div class="relative z-10">
                            <div class="flex flex-col md:flex-row md:items-center justify-between gap-8">
                                <div class="max-w-xl">
                                    <span
                                        class="inline-flex items-center gap-1.5 px-3 py-1 bg-primary/20 backdrop-blur-md text-blue-400 text-[10px] font-bold uppercase tracking-widest rounded-full mb-4 border border-primary/30">
                                        <span class="material-symbols-outlined text-[14px]">stars</span>
                                        Chương trình Người sáng tạo Nexus
                                    </span>
                                    <h2 class="text-3xl md:text-4xl font-black text-white mb-4 tracking-tight">Trở thành
                                        Nhà báo Nexus</h2>
                                    <p class="text-lg text-blue-100/90 mb-2 font-medium">Tiếp cận hàng triệu độc giả với
                                        nền
                                        tảng tin tức thế hệ mới của chúng tôi.</p>
                                    <ul class="grid grid-cols-1 sm:grid-cols-2 gap-3 text-sm text-blue-100/70 mb-6">
                                        <li class="flex items-center gap-2">
                                            <span
                                                class="material-symbols-outlined text-primary text-[18px]">check_circle</span>
                                            Công cụ viết &amp; nghiên cứu AI
                                        </li>
                                        <li class="flex items-center gap-2">
                                            <span
                                                class="material-symbols-outlined text-primary text-[18px]">check_circle</span>
                                            Kiếm tiền từ báo cáo của bạn
                                        </li>
                                        <li class="flex items-center gap-2">
                                            <span
                                                class="material-symbols-outlined text-primary text-[18px]">check_circle</span>
                                            Truy cập nguồn cấp dữ liệu toàn cầu
                                        </li>
                                        <li class="flex items-center gap-2">
                                            <span
                                                class="material-symbols-outlined text-primary text-[18px]">check_circle</span>
                                            Tương tác trực tiếp với khán giả
                                        </li>
                                    </ul>
                                </div>
                                <div class="shrink-0 flex flex-col items-center gap-4">
                                    <button
                                        class="w-full md:w-auto px-10 py-4 bg-white text-primary-dark font-black text-lg rounded-xl shadow-xl shadow-black/20 hover:bg-cyan-50 hover:text-primary hover:shadow-cyan-400/20 hover:scale-105 active:scale-95 transition-all duration-300">
                                        Đăng ký ngay
                                    </button>
                                    <p class="text-xs text-blue-200/60 font-medium">Nộp đơn mất &lt; 5 phút</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <jsp:include page="components/footer.jsp" />
        </div>

    </body>

    </html>