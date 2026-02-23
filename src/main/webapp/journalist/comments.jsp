<!DOCTYPE html>
<html class="dark" lang="en">

<head>
    <jsp:include page="components/head.jsp" />
    <title>Giao diện Quản lý Bình luận Nhà báo</title>
</head>

<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen">
    <div class="flex h-screen overflow-hidden">
        <jsp:include page="components/sidebar.jsp">
            <jsp:param name="activePage" value="comments" />
        </jsp:include>
        <main class="flex-1 flex flex-col min-w-0 bg-background-light dark:bg-background-dark">
            <header
                class="h-16 bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-border-dark flex items-center justify-between px-8 shrink-0 z-20">
                <div class="flex items-center gap-6">
                    <h2 class="text-lg font-bold tracking-tight">Quản lý Bình luận</h2>
                    <div class="hidden md:flex items-center gap-2 text-xs text-slate-500 font-medium">
                        <span>Cổng thông tin Nhà báo</span>
                        <span class="material-symbols-outlined text-sm">chevron_right</span>
                        <span class="text-slate-900 dark:text-slate-200">Kiểm duyệt</span>
                    </div>
                </div>
                <div class="flex items-center gap-3">
                    <div class="relative group">
                        <span
                            class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-lg">search</span>
                        <input
                            class="bg-slate-100 dark:bg-slate-800 border-none rounded-lg py-1.5 pl-10 pr-4 w-64 focus:ring-2 focus:ring-primary text-xs transition-all"
                            placeholder="Tìm kiếm bình luận theo từ khóa..." type="text" />
                    </div>
                    <div class="h-6 w-px bg-slate-200 dark:border-border-dark mx-1"></div>
                    <button
                        class="relative p-2 rounded-lg hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors text-slate-500">
                        <span class="material-symbols-outlined">notifications</span>
                        <span
                            class="absolute top-2.5 right-2.5 size-2 bg-red-500 rounded-full border-2 border-white dark:border-slate-900"></span>
                    </button>
                    <button
                        class="p-2 rounded-lg hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors text-slate-500">
                        <span class="material-symbols-outlined">light_mode</span>
                    </button>
                </div>
            </header>
            <div class="flex-1 overflow-y-auto">
                <div class="p-8 max-w-5xl mx-auto space-y-6">
                    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-2">
                        <div>
                            <h3 class="text-xl font-bold">Nguồn Cấp dữ liệu Hoạt động</h3>
                            <p class="text-slate-500 dark:text-slate-400 text-xs mt-1">Đang xem xét 482 bình luận từ
                                độc giả của bạn</p>
                        </div>
                        <div class="flex items-center gap-2">
                            <button
                                class="flex items-center gap-2 px-3 py-2 bg-white dark:bg-slate-800 border border-slate-200 dark:border-border-dark hover:border-primary/50 rounded-lg text-xs font-semibold transition-all shadow-sm">
                                <span class="material-symbols-outlined text-sm">filter_list</span>
                                Sort: Mới nhất
                            </button>
                            <button
                                class="flex items-center gap-2 px-4 py-2 bg-primary hover:bg-primary/90 text-white rounded-lg text-xs font-semibold transition-all shadow-sm">
                                <span class="material-symbols-outlined text-sm">download</span>
                                Xuất Dữ liệu
                            </button>
                        </div>
                    </div>
                    <div class="grid gap-4">
                        <div
                            class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm hover:shadow-md transition-shadow overflow-hidden">
                            <div class="p-5">
                                <div class="flex justify-between items-start gap-4 mb-4">
                                    <div class="flex items-start gap-3">
                                        <div
                                            class="size-10 rounded-full bg-blue-100 dark:bg-blue-900/40 flex items-center justify-center text-blue-600 dark:text-blue-400 font-bold shrink-0">
                                            JS
                                        </div>
                                        <div class="min-w-0">
                                            <div class="flex items-center flex-wrap gap-x-2">
                                                <h5 class="text-sm font-bold text-slate-900 dark:text-white">Julian
                                                    Sterling</h5>
                                                <span class="text-[11px] text-slate-400 font-medium tracking-tight">2
                                                    giờ trước</span>
                                            </div>
                                            <div
                                                class="flex items-center gap-1.5 text-xs text-primary font-semibold mt-0.5 truncate">
                                                <span class="material-symbols-outlined text-[14px]">article</span>
                                                Tương lai của AI trong Báo chí Hiện đại
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        class="badge-base bg-emerald-100 text-emerald-700 dark:bg-emerald-500/10 dark:text-emerald-400 ring-1 ring-inset ring-emerald-500/20">
                                        <span class="size-1.5 rounded-full bg-emerald-500"></span>
                                        Tích cực
                                    </div>
                                </div>
                                <p class="text-slate-600 dark:text-slate-300 text-sm leading-relaxed mb-5 pl-[52px]">
                                    Đây là một phân tích tuyệt vời về cách các mô hình ngôn ngữ lớn đang hỗ trợ quy
                                    trình làm việc của nhà báo
                                    chưa không phải là thay thế họ. Phần về "kiểm tra tính xác thực tự động" đặc biệt
                                    đáng giá. Làm tốt lắm, Alex!
                                </p>
                                <div
                                    class="flex items-center justify-between pt-4 border-t border-slate-100 dark:border-border-dark pl-[52px]">
                                    <div class="flex items-center gap-4">
                                        <button
                                            class="flex items-center gap-1.5 text-slate-500 hover:text-primary transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">reply</span> Phản hồi
                                        </button>
                                        <button
                                            class="flex items-center gap-1.5 text-slate-500 hover:text-orange-500 transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">block</span> Spam
                                        </button>
                                        <button
                                            class="flex items-center gap-1.5 text-slate-500 hover:text-slate-900 dark:hover:text-white transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">visibility_off</span> Ẩn
                                        </button>
                                    </div>
                                    <button class="text-slate-400 hover:text-slate-600 dark:hover:text-slate-300">
                                        <span class="material-symbols-outlined">more_horiz</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div
                            class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm hover:shadow-md transition-shadow overflow-hidden">
                            <div class="p-5">
                                <div class="flex justify-between items-start gap-4 mb-4">
                                    <div class="flex items-start gap-3">
                                        <div
                                            class="size-10 rounded-full bg-orange-100 dark:bg-orange-900/40 flex items-center justify-center text-orange-600 dark:text-orange-400 font-bold shrink-0">
                                            MK
                                        </div>
                                        <div class="min-w-0">
                                            <div class="flex items-center flex-wrap gap-x-2">
                                                <h5 class="text-sm font-bold text-slate-900 dark:text-white">Marcus Kane
                                                </h5>
                                                <span class="text-[11px] text-slate-400 font-medium tracking-tight">5
                                                    giờ trước</span>
                                            </div>
                                            <div
                                                class="flex items-center gap-1.5 text-xs text-primary font-semibold mt-0.5 truncate">
                                                <span class="material-symbols-outlined text-[14px]">article</span>
                                                An ninh mạng trong Kỷ nguyên Lượng tử
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        class="badge-base bg-amber-100 text-amber-700 dark:bg-amber-500/10 dark:text-amber-400 ring-1 ring-inset ring-amber-500/20">
                                        <span class="size-1.5 rounded-full bg-amber-500"></span>
                                        Tiêu cực
                                    </div>
                                </div>
                                <p class="text-slate-600 dark:text-slate-300 text-sm leading-relaxed mb-5 pl-[52px]">
                                    Tôi nghĩ bạn đang đánh giá quá cao khoảng thời gian để thuật toán Shor có thể
                                    khả thi về mặt thương mại. Hầu hết các chuyên gia cho rằng chúng ta vẫn còn 10-15
                                    năm nữa,
                                    nhưng bạn ngụ ý rằng nó là một mối đe dọa trực tiếp đối với RSA hiện tại.
                                </p>
                                <div
                                    class="flex items-center justify-between pt-4 border-t border-slate-100 dark:border-border-dark pl-[52px]">
                                    <div class="flex items-center gap-4">
                                        <button
                                            class="flex items-center gap-1.5 text-slate-500 hover:text-primary transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">reply</span> Reply
                                        </button>
                                        <button
                                            class="flex items-center gap-1.5 text-slate-500 hover:text-orange-500 transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">block</span> Spam
                                        </button>
                                        <button
                                            class="flex items-center gap-1.5 text-slate-500 hover:text-slate-900 dark:hover:text-white transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">visibility_off</span> Hide
                                        </button>
                                    </div>
                                    <button class="text-slate-400 hover:text-slate-600 dark:hover:text-slate-300">
                                        <span class="material-symbols-outlined">more_horiz</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div
                            class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm hover:shadow-md transition-shadow overflow-hidden">
                            <div class="p-5">
                                <div class="flex justify-between items-start gap-4 mb-4">
                                    <div class="flex items-start gap-3">
                                        <div
                                            class="size-10 rounded-full bg-slate-100 dark:bg-slate-800 flex items-center justify-center text-slate-600 dark:text-slate-400 font-bold shrink-0">
                                            EL
                                        </div>
                                        <div class="min-w-0">
                                            <div class="flex items-center flex-wrap gap-x-2">
                                                <h5 class="text-sm font-bold text-slate-900 dark:text-white">Elena Lopez
                                                </h5>
                                                <span class="text-[11px] text-slate-400 font-medium tracking-tight">1
                                                    ngày trước</span>
                                            </div>
                                            <div
                                                class="flex items-center gap-1.5 text-xs text-primary font-semibold mt-0.5 truncate">
                                                <span class="material-symbols-outlined text-[14px]">article</span>
                                                Tương lai của AI trong Báo chí Hiện đại
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        class="badge-base bg-slate-100 text-slate-600 dark:bg-slate-500/10 dark:text-slate-400 ring-1 ring-inset ring-slate-500/20">
                                        <span class="size-1.5 rounded-full bg-slate-400"></span>
                                        Trung lập
                                    </div>
                                </div>
                                <p class="text-slate-600 dark:text-slate-300 text-sm leading-relaxed mb-5 pl-[52px]">
                                    Sẽ có một bài viết tiếp theo tập trung cụ thể vào các tòa soạn tin tức địa phương
                                    chứ? Họ
                                    có ngân sách ít hơn nhiều cho các loại công cụ này.
                                </p>
                                <div
                                    class="flex items-center justify-between pt-4 border-t border-slate-100 dark:border-border-dark pl-[52px]">
                                    <div class="flex items-center gap-4">
                                        <button
                                            class="flex items-center gap-1.5 text-slate-500 hover:text-primary transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">reply</span> Reply
                                        </button>
                                        <button
                                            class="flex items-center gap-1.5 text-slate-500 hover:text-orange-500 transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">block</span> Spam
                                        </button>
                                        <button
                                            class="flex items-center gap-1.5 text-slate-500 hover:text-slate-900 dark:hover:text-white transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">visibility_off</span> Hide
                                        </button>
                                    </div>
                                    <button class="text-slate-400 hover:text-slate-600 dark:hover:text-slate-300">
                                        <span class="material-symbols-outlined">more_horiz</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div
                            class="bg-slate-50/80 dark:bg-slate-900/40 rounded-xl border border-dashed border-red-200 dark:border-red-900/30 shadow-none transition-shadow overflow-hidden opacity-90">
                            <div class="p-5">
                                <div class="flex justify-between items-start gap-4 mb-4">
                                    <div class="flex items-start gap-3">
                                        <div
                                            class="size-10 rounded-full bg-red-100 dark:bg-red-900/40 flex items-center justify-center text-red-600 dark:text-red-400 font-bold shrink-0">
                                            B9
                                        </div>
                                        <div class="min-w-0">
                                            <div class="flex items-center flex-wrap gap-x-2">
                                                <h5 class="text-sm font-bold text-slate-900 dark:text-white">
                                                    Bot_Account_99</h5>
                                                <span class="text-[11px] text-slate-400 font-medium tracking-tight">2
                                                    ngày trước</span>
                                            </div>
                                            <div
                                                class="flex items-center gap-1.5 text-xs text-primary/70 font-semibold mt-0.5 truncate italic">
                                                <span class="material-symbols-outlined text-[14px]">article</span>
                                                Sự trỗi dậy của Nền tảng Low-Code
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        class="badge-base bg-red-100 text-red-700 dark:bg-red-500/10 dark:text-red-400 ring-1 ring-inset ring-red-500/20">
                                        <span class="size-1.5 rounded-full bg-red-500"></span>
                                        Spam
                                    </div>
                                </div>
                                <p
                                    class="text-slate-500 dark:text-slate-400 text-sm leading-relaxed mb-5 pl-[52px] italic">
                                    "Khám phá mã thông báo tiền điện tử mới của chúng tôi để kiếm tiền trong khi đọc tin
                                    tức! Nhấn vào đây:
                                    http://bit.ly/spam-link-example"
                                </p>
                                <div
                                    class="flex items-center justify-between pt-4 border-t border-slate-100 dark:border-border-dark pl-[52px]">
                                    <div class="flex items-center gap-4">
                                        <button
                                            class="flex items-center gap-1.5 text-red-500 hover:text-red-600 transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">delete_forever</span> Xóa
                                        </button>
                                        <button
                                            class="flex items-center gap-1.5 text-slate-500 hover:text-slate-900 dark:hover:text-white transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">undo</span> Khôi phục
                                        </button>
                                    </div>
                                    <button class="text-slate-400 hover:text-slate-600 dark:hover:text-slate-300">
                                        <span class="material-symbols-outlined">more_horiz</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div
                        class="flex items-center justify-between py-6 border-t border-slate-200 dark:border-border-dark">
                        <p class="text-xs font-medium text-slate-500 dark:text-slate-400">
                            Hiển thị <span class="text-slate-900 dark:text-white">1-10</span> trong số 482 bình luận
                        </p>
                        <div class="flex items-center gap-1.5">
                            <button
                                class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800 disabled:opacity-40 transition-all text-xs font-semibold"
                                disabled="">
                                Trước
                            </button>
                            <button
                                class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800 transition-all text-xs font-semibold">
                                Tiếp
                            </button>
                        </div>
                    </div>
                </div>
        </main>
    </div>

</body>

</html>