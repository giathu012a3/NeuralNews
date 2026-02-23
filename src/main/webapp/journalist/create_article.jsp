<!DOCTYPE html>
<html class="dark" lang="en">

<head>
    <jsp:include page="components/head.jsp" />
    <title>Trình soạn thảo AI - Cổng thông tin Nhà báo Thống nhất</title>
    <!-- Page specific styles -->
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@300;400;500;600;700&amp;display=swap"
        rel="stylesheet" />
    <style type="text/tailwindcss">
        body {
            font-family: "Work Sans", sans-serif;
        }
        .editor-container::-webkit-scrollbar {
            width: 6px;
        }
        .editor-container::-webkit-scrollbar-thumb {
            background-color: rgba(156, 163, 175, 0.2);
            border-radius: 10px;
        }
        .ai-badge {
            @apply text-[10px] px-2 py-0.5 rounded-full font-bold uppercase tracking-wider;
        }
    </style>
    <script>
        tailwind.config.theme.extend.fontFamily.display = ["Work Sans"];
    </script>
</head>

<body
    class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen overflow-hidden">
    <div class="flex h-screen">
        <aside
            class="w-72 bg-white dark:bg-surface-dark border-r border-slate-200 dark:border-border-dark flex flex-col shrink-0">
            <div class="p-5 border-b border-slate-200 dark:border-border-dark flex items-center justify-between">
                <div class="flex items-center gap-3">
                    <div class="bg-primary size-8 rounded flex items-center justify-center text-white">
                        <span class="material-symbols-outlined text-xl">auto_fix_high</span>
                    </div>
                    <h2 class="text-sm font-bold tracking-tight">TRỢ LÝ AI</h2>
                </div>
                <button class="text-slate-400 hover:text-white transition-colors">
                    <span class="material-symbols-outlined text-xl">keyboard_double_arrow_left</span>
                </button>
            </div>
            <div class="flex-1 overflow-y-auto py-6 px-4 space-y-8">
                <section>
                    <div class="flex items-center justify-between mb-4 px-1">
                        <h3 class="text-[11px] font-bold uppercase tracking-[0.1em] text-slate-500">Kiểm tra lỗi Chính
                            tả &amp;
                            Ngữ pháp</h3>
                        <span class="ai-badge bg-rose-500/10 text-rose-500">3 Lỗi</span>
                    </div>
                    <div class="space-y-3">
                        <div
                            class="p-3 bg-slate-50 dark:bg-white/[0.03] border border-slate-200 dark:border-border-dark rounded-lg">
                            <p class="text-[11px] text-slate-500 mb-1">Sai chính tả tiềm ẩn</p>
                            <p class="text-xs font-medium mb-3">"...future of <span
                                    class="border-b border-rose-500 text-rose-400">tecnology</span>..."</p>
                            <div class="flex gap-2">
                                <button
                                    class="text-[10px] bg-primary text-white px-3 py-1 rounded font-semibold uppercase tracking-wide">technology</button>
                                <button
                                    class="text-[10px] text-slate-400 hover:text-slate-200 px-2 py-1 transition-colors">BỎ
                                    QUA</button>
                            </div>
                        </div>
                    </div>
                </section>
                <section>
                    <div class="flex items-center justify-between mb-4 px-1">
                        <h3 class="text-[11px] font-bold uppercase tracking-[0.1em] text-slate-500">Trình tối ưu SEO
                        </h3>
                        <span class="ai-badge bg-emerald-500/10 text-emerald-500">Điểm: 84</span>
                    </div>
                    <div class="space-y-4 px-1">
                        <div>
                            <div class="flex items-center justify-between text-[11px] mb-2">
                                <span class="text-slate-400">Mật độ Từ khóa</span>
                                <span class="text-emerald-500 font-bold uppercase">Tối ưu</span>
                            </div>
                            <div class="w-full bg-slate-200 dark:bg-slate-800 h-1 rounded-full">
                                <div
                                    class="bg-emerald-500 h-1 rounded-full w-[84%] shadow-[0_0_8px_rgba(16,185,129,0.4)]">
                                </div>
                            </div>
                        </div>
                        <div
                            class="p-3 bg-slate-50 dark:bg-white/[0.03] border border-slate-200 dark:border-border-dark rounded-lg">
                            <div class="flex items-center gap-2 mb-1">
                                <span class="material-symbols-outlined text-primary text-sm">lightbulb</span>
                                <p class="text-[11px] text-slate-400">Đề xuất</p>
                            </div>
                            <p class="text-xs leading-relaxed">Thêm "Trí tuệ Nhân tạo" vào 100 từ đầu tiên.</p>
                        </div>
                    </div>
                </section>
                <section>
                    <div class="flex items-center justify-between mb-4 px-1">
                        <h3 class="text-[11px] font-bold uppercase tracking-[0.1em] text-slate-500">Phân tích Giọng văn
                        </h3>
                        <span class="ai-badge bg-primary/10 text-primary">Cân bằng</span>
                    </div>
                    <div class="grid grid-cols-2 gap-3">
                        <div
                            class="p-3 bg-slate-50 dark:bg-white/[0.03] border border-slate-200 dark:border-border-dark rounded-lg flex flex-col items-center justify-center text-center">
                            <span class="text-primary text-lg font-bold">72%</span>
                            <span class="text-[9px] text-slate-500 uppercase font-bold tracking-tighter">Chuyên
                                nghiệp</span>
                        </div>
                        <div
                            class="p-3 bg-slate-50 dark:bg-white/[0.03] border border-slate-200 dark:border-border-dark rounded-lg flex flex-col items-center justify-center text-center">
                            <span class="text-amber-500 text-lg font-bold">18%</span>
                            <span class="text-[9px] text-slate-500 uppercase font-bold tracking-tighter">Khẩn cấp</span>
                        </div>
                    </div>
                </section>
            </div>
            <div class="p-4 border-t border-slate-200 dark:border-border-dark">
                <button
                    class="w-full flex items-center justify-center gap-2 py-2 text-xs font-bold text-slate-500 hover:text-primary transition-colors uppercase tracking-widest">
                    <span class="material-symbols-outlined text-lg">settings_suggest</span>
                    Cấu hình Trợ lý
                </button>
            </div>
        </aside>
        <main class="flex-1 flex flex-col relative bg-[#0a0f14]">
            <header
                class="h-16 bg-white dark:bg-surface-dark border-b border-slate-200 dark:border-border-dark flex items-center justify-between px-6 shrink-0 z-30">
                <div class="flex items-center gap-6">
                    <a class="flex items-center gap-2 text-slate-400 hover:text-white transition-colors group"
                        href="${pageContext.request.contextPath}/journalist/articles.jsp">
                        <span
                            class="material-symbols-outlined text-xl transition-transform group-hover:-translate-x-1">arrow_back</span>
                        <span class="text-sm font-semibold uppercase tracking-wider">Quay lại Bảng điều khiển</span>
                    </a>
                    <div class="h-6 w-px bg-slate-200 dark:bg-border-dark"></div>
                    <div class="flex items-center gap-2">
                        <span class="size-2 bg-emerald-500 rounded-full animate-pulse"></span>
                        <span class="text-[11px] font-medium text-slate-500 uppercase tracking-widest">Đã lưu bản nháp:
                            10:45 AM</span>
                    </div>
                </div>
                <div class="flex items-center gap-3">
                    <button
                        class="px-4 py-2 text-xs font-bold text-slate-600 dark:text-slate-300 border border-transparent hover:border-slate-700 rounded transition-all uppercase tracking-widest">
                        Lưu Bản nháp
                    </button>
                    <button
                        class="px-4 py-2 text-xs font-bold text-slate-600 dark:text-slate-300 border border-slate-200 dark:border-border-dark hover:bg-slate-100 dark:hover:bg-slate-800 rounded transition-all flex items-center gap-2 uppercase tracking-widest">
                        <span class="material-symbols-outlined text-lg">visibility</span>
                        Xem trước
                    </button>
                    <button
                        class="px-6 py-2 bg-primary hover:bg-blue-600 text-white text-xs font-bold rounded transition-all uppercase tracking-widest shadow-lg shadow-primary/20">
                        Gửi để Đánh giá
                    </button>
                </div>
            </header>
            <div class="flex-1 overflow-y-auto editor-container p-8 lg:p-16">
                <div class="max-w-4xl mx-auto space-y-10">
                    <div class="space-y-6">
                        <input
                            class="w-full bg-transparent border-none focus:ring-0 text-5xl font-bold placeholder-slate-700 dark:text-white leading-tight"
                            placeholder="Nhập tiêu đề bài viết..." type="text"
                            value="Tương lai của AI trong Báo chí Hiện đại" />
                        <div class="flex items-center gap-6 py-4 border-y border-slate-200 dark:border-border-dark">
                            <div class="flex items-center gap-3">
                                <img alt="Alex Morgan" class="size-8 rounded-full ring-2 ring-primary/20"
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuCu5P-oe2o3J0xfxWv88PBTR1uz19l6jglgnhh6GRzByG4ylsxMB1GVFma_iBV1yYWlch0aHRuplqgZ8W30qvu0sVpaDffNqMxkvE6pNxjgwaDrYXAyHCEkhZVxm-22e_nBbywshWhPmiwUhpOU0xU7WAPajc8_byjVWY7seMDsynKUCM5RqSMaueCmACC31lVHHqTUUUOkdmdc4OZlliCDh07RRlq3Koas1uJdQrC26A5ikSDYEkHJNhG82L3yS3dPfUymldQLmYoJ" />
                                <div class="flex flex-col">
                                    <span class="text-xs font-bold text-slate-300">Alex Morgan</span>
                                    <span class="text-[10px] text-slate-500 uppercase tracking-tighter">Biên tập viên
                                        Công nghệ
                                        Cấp cao</span>
                                </div>
                            </div>
                            <div class="flex items-center gap-4">
                                <span class="ai-badge bg-primary/10 text-primary border border-primary/20">Công
                                    nghệ</span>
                                <div class="flex items-center gap-1.5 text-slate-500">
                                    <span class="material-symbols-outlined text-sm">schedule</span>
                                    <span class="text-[11px] font-medium">5 PHÚT ĐỌC</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="prose prose-slate dark:prose-invert max-w-none">
                        <p class="text-xl leading-[1.8] text-slate-600 dark:text-slate-300 font-light">
                            Sự tích hợp trí tuệ nhân tạo vào tòa soạn không còn là một khả năng xa xỉ nữa — nó là một
                            thực tế đang hoạt động,
                            đang định hình lại cách các câu chuyện được khám phá, xác minh và cung cấp cho khán giả trên
                            toàn thế giới.
                            Từ phân tích dữ liệu tự động đến dịch thuật và phiên âm thời gian thực, AI đang cung cấp cho
                            các nhà báo các công cụ mạnh mẽ
                            để nâng cao kỹ năng báo chí của họ.
                        </p>
                        <div class="my-10 group relative rounded-2xl overflow-hidden border border-border-dark">
                            <img alt="AI Technology Visualization"
                                class="w-full h-auto object-cover opacity-80 group-hover:opacity-100 transition-opacity"
                                src="https://lh3.googleusercontent.com/aida-public/AB6AXuCe5f1aMHa30MbTUOV9kgjgWzQFwT9vKW1FwcE_WURKBUf6wSU-k5MZcXGZ_fD_u2WuHzABVSmlPPfLES6UYkxJhp6m2MAezTBDY_k2jZHc1y2-ODdQu-OLx5Jk-8rzx1p6VFXl7GkYLeXjqIPdwje2k7iPSzyKpAbtexSQjtWEeasA-BjDhDEAYLFLXzrKe7Q8a1FWwNwrSpeVleYSvrb_T4JrYiGXWCNR0hP4-OSrs6QLLFPIbJh2qAiuARLjKx1-CUk66vuLGKy1" />
                            <div class="absolute inset-0 bg-gradient-to-t from-background-dark/80 to-transparent"></div>
                            <div class="absolute bottom-4 left-6">
                                <p class="text-xs text-slate-400 italic">Hình 1: Hình ảnh trực quan hóa quá trình xử lý
                                    của mạng nơ-ron cho
                                    phân tích ngữ nghĩa.</p>
                            </div>
                        </div>
                        <p class="text-xl leading-[1.8] text-slate-600 dark:text-slate-300 font-light">
                            Tuy nhiên, khi chúng ta đón nhận những tiến bộ này, ngành công nghiệp phải đối mặt với những
                            câu hỏi quan trọng về
                            đạo đức, sự thiên vị và yếu tố con người thiết yếu trong việc kể chuyện. Làm thế nào để
                            chúng ta đảm bảo rằng AI
                            vẫn là một công cụ hỗ trợ cho sự sáng tạo hơn là một sự thay thế cho tính nghiêm ngặt trong
                            điều tra và
                            tính toàn vẹn của báo chí?
                        </p>
                        <div class="mt-12 p-6 border-l-2 border-primary/40 bg-primary/5 rounded-r-xl">
                            <p class="text-xl leading-relaxed text-slate-400 italic">
                                Bắt đầu viết đoạn văn tiếp theo của bạn ở đây hoặc sử dụng công cụ 'Hỏi Trợ lý' cho một
                                bước đột phá...
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <div
                class="absolute bottom-10 left-1/2 -translate-x-1/2 flex items-center gap-1.5 p-2.5 bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-xl shadow-[0_20px_50px_rgba(0,0,0,0.5)] backdrop-blur-xl z-40">
                <div class="flex items-center gap-0.5 border-r border-slate-200 dark:border-border-dark pr-2">
                    <button
                        class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-600 dark:text-slate-300 transition-colors">
                        <span class="material-symbols-outlined text-xl">format_bold</span>
                    </button>
                    <button
                        class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-600 dark:text-slate-300 transition-colors">
                        <span class="material-symbols-outlined text-xl">format_italic</span>
                    </button>
                    <button
                        class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-600 dark:text-slate-300 transition-colors">
                        <span class="material-symbols-outlined text-xl">format_underlined</span>
                    </button>
                </div>
                <div class="flex items-center gap-0.5 border-r border-slate-200 dark:border-border-dark pr-2">
                    <button
                        class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-600 dark:text-slate-300 transition-colors">
                        <span class="material-symbols-outlined text-xl">format_list_bulleted</span>
                    </button>
                    <button
                        class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-600 dark:text-slate-300 transition-colors">
                        <span class="material-symbols-outlined text-xl">link</span>
                    </button>
                    <button
                        class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-600 dark:text-slate-300 transition-colors">
                        <span class="material-symbols-outlined text-xl">image</span>
                    </button>
                </div>
                <button
                    class="flex items-center gap-3 px-5 py-2.5 bg-primary hover:bg-blue-600 text-white rounded-lg font-bold transition-all text-[11px] uppercase tracking-widest group ml-2">
                    <span
                        class="material-symbols-outlined text-lg group-hover:rotate-12 transition-transform">bolt</span>
                    Hỏi Trợ lý
                </button>
            </div>
            <div class="absolute top-24 right-8 flex flex-col gap-4">
                <button
                    class="size-12 bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-full shadow-xl flex items-center justify-center hover:border-primary transition-colors group"
                    title="Chế độ Không phân tâm">
                    <span class="material-symbols-outlined text-slate-500 group-hover:text-primary">fullscreen</span>
                </button>
                <button
                    class="size-12 bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-full shadow-xl flex items-center justify-center hover:border-primary transition-colors group"
                    title="Chuyển đổi Giao diện">
                    <span class="material-symbols-outlined text-slate-500 group-hover:text-primary">contrast</span>
                </button>
            </div>
        </main>
    </div>
</body>

</html>