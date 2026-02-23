<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html class="dark" lang="en">

    <head>
        <title>Trang chủ Tin tức AI</title>
        <jsp:include page="components/head.jsp" />
    </head>

    <body
        class="bg-background-light dark:bg-background-dark text-text-main dark:text-white font-display antialiased overflow-x-hidden transition-colors duration-200">
        <div class="flex min-h-screen w-full flex-col">
            <jsp:include page="components/header.jsp" />

            <main class="flex-1 w-full max-w-[1440px] mx-auto p-4 lg:p-8 grid grid-cols-1 lg:grid-cols-12 gap-8">
                <div class="lg:col-span-8 flex flex-col gap-10">
                    <section class="grid grid-cols-1 md:grid-cols-2 gap-6">
                        <article onclick="window.location.href='${pageContext.request.contextPath}/user/article.jsp'"
                            class="relative md:col-span-2 lg:col-span-1 xl:col-span-1 h-[450px] rounded-xl overflow-hidden group cursor-pointer shadow-sm hover:shadow-md transition-shadow">
                            <div class="absolute inset-0 bg-cover bg-center transition-transform duration-700 group-hover:scale-105"
                                style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuAJYXTTOH-j3MgaNT2onqeIEXdT2yZnwu0uY83A9u6SXAwhdNe0mIGM1L0eh3j5wGCVrRHfKSbV2NhX2YL1tqdHhnvL4S3raWE13J3n_CcoRUW1_cAw5OhcC2OgvV3JXF63Z_pRn7iEl1OeuAYmSlghfJXddKECmxVUZI5XCsBY4BfQsSArn3on1In-WLU3B7YZtRuPFofa9W5LArXz-UR8XDxzXKPQ6IWyOYZkGxgwksAZqztiXXLawxLkRB6Aq8Ivn1bo8KOFL8pu');">
                            </div>
                            <div class="absolute inset-0 bg-gradient-to-t from-black/90 via-black/40 to-transparent">
                            </div>
                            <div class="absolute bottom-0 left-0 p-6 w-full">
                                <span
                                    class="inline-block px-2.5 py-0.5 rounded bg-primary text-white text-[10px] font-bold uppercase tracking-wider mb-3">Nổi
                                    bật</span>
                                <h2
                                    class="text-2xl md:text-3xl font-bold text-white leading-tight mb-2 group-hover:text-blue-100 transition-colors">
                                    Mô hình AI dự báo thời tiết với độ chính xác 99%</h2>
                                <p class="text-slate-300 text-sm line-clamp-2 mb-4 hidden md:block">
                                    Bước đột phá trong xử lý dữ liệu khí tượng cho phép các mô hình transformer mới dự
                                    báo biến đổi khí hậu trước nhiều tuần.
                                </p>
                                <div class="flex items-center text-xs text-slate-400 gap-3">
                                    <span class="flex items-center gap-1"><span
                                            class="material-symbols-outlined text-sm">schedule</span> 2 giờ trước</span>
                                    <span class="flex items-center gap-1"><span
                                            class="material-symbols-outlined text-sm">visibility</span> 14k</span>
                                </div>
                            </div>
                        </article>
                        <div class="flex flex-col gap-4 h-[450px]">
                            <article
                                onclick="window.location.href='${pageContext.request.contextPath}/user/article.jsp'"
                                class="flex-1 flex gap-4 bg-white dark:bg-surface-dark p-3 rounded-lg border border-border-light dark:border-border-dark hover:border-primary/50 transition-colors cursor-pointer group">
                                <div class="w-1/3 h-full rounded-md overflow-hidden bg-slate-100">
                                    <div class="w-full h-full bg-cover bg-center"
                                        style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDK__sk7UjLv8i1C_8OHskL_--6IxKe9kO8HlawaMoDvWPXzVAQWnbThQjVa0NVKFWNMCwOHhF4khSP0E_iZOi7RX0wNJGAhrrV9IBkrII3avkUkJqYRdYoqMN4vZtX7Hr92xkiHXYOiJcnUs5PwQTBaVtE8oC_BeGZZjLA9164Wl-nvsV7-_Gjkad5oNqMnIjkDMH5-Y5alDP_q1TM4Ci9fQeYtLaHDUKNaSMNTGU2zTN4IErbtptamGaFY02xGy2BLfE6iQY91cts');">
                                    </div>
                                </div>
                                <div class="w-2/3 flex flex-col justify-center">
                                    <span class="text-[10px] font-bold text-primary uppercase mb-1">Công nghệ</span>
                                    <h3
                                        class="text-sm font-bold text-slate-900 dark:text-white leading-snug group-hover:text-primary transition-colors line-clamp-2">
                                        Giao thức bảo mật mới cho kỷ nguyên Điện toán lượng tử</h3>
                                </div>
                            </article>
                            <article
                                onclick="window.location.href='${pageContext.request.contextPath}/user/article.jsp'"
                                class="flex-1 flex gap-4 bg-white dark:bg-surface-dark p-3 rounded-lg border border-border-light dark:border-border-dark hover:border-primary/50 transition-colors cursor-pointer group">
                                <div class="w-1/3 h-full rounded-md overflow-hidden bg-slate-100">
                                    <div class="w-full h-full bg-cover bg-center"
                                        style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCrc_7XThJ5bAFGC03h2RGUpg2i4LGEanIMHmTjsApYkKda1tlYEyQlB0qYKhYImQ4lOhybrDjFu3zamKplFgbncnCxd7y4Y3S_EefRhQgK224OagGlzOIC6sFI_CafUwt_kXS-8vLmfW8iH5e8gXhSt0pmZBRpwc2Gd0DK1BeTFHNVeEWi8Kvc2fffea280_KCVJI5lZOJoH3D1IVjtPQgvmXXQ51k0UBribsipHUPoK0RCeTAOuNoBnmbyDqQIfikd98VZOU0GsaT');">
                                    </div>
                                </div>
                                <div class="w-2/3 flex flex-col justify-center">
                                    <span class="text-[10px] font-bold text-purple-600 uppercase mb-1">Lập trình</span>
                                    <h3
                                        class="text-sm font-bold text-slate-900 dark:text-white leading-snug group-hover:text-primary transition-colors line-clamp-2">
                                        Python 4.0: Những điều lập trình viên cần biết</h3>
                                </div>
                            </article>
                            <article
                                onclick="window.location.href='${pageContext.request.contextPath}/user/article.jsp'"
                                class="flex-1 flex gap-4 bg-white dark:bg-surface-dark p-3 rounded-lg border border-border-light dark:border-border-dark hover:border-primary/50 transition-colors cursor-pointer group">
                                <div class="w-1/3 h-full rounded-md overflow-hidden bg-slate-100">
                                    <div class="w-full h-full bg-cover bg-center"
                                        style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDobs8RjnWif8UQ50Z-fZfKRUVaMxulVKyLJdFLEkjgEgdaSwAwySOmh-X4NXt6Z2EbuQkjyJKhAzNOg1h9iYcrccPrjPrIifqBxE-4KvC_pF7Legf3GjHjeRwugZMYsc2FLVCs5rm4MknfVKmOfFUDY8yM6gV7kSjA5JUZAAcRP6dT2BhOfWs_avYZVJyfqlMMUG2gdgv7BBGrbdKqdKD5U4WLCsDMajC0Q5TVJK3OtfMFNb3ejHCdFOdOm2FtjsuJ2Mk5HWKu91Ms');">
                                    </div>
                                </div>
                                <div class="w-2/3 flex flex-col justify-center">
                                    <span class="text-[10px] font-bold text-green-600 uppercase mb-1">Đời sống</span>
                                    <h3
                                        class="text-sm font-bold text-slate-900 dark:text-white leading-snug group-hover:text-primary transition-colors line-clamp-2">
                                        Robot trong chăm sóc người cao tuổi: Sự tiếp xúc của con người?</h3>
                                </div>
                            </article>
                        </div>
                    </section>
                    <div class="h-px w-full bg-slate-200 dark:bg-slate-700"></div>
                    <section>
                        <div class="flex items-center justify-between mb-6">
                            <h3 class="text-xl font-bold flex items-center gap-2 text-slate-900 dark:text-white">
                                <span class="w-1.5 h-6 bg-primary rounded-full"></span>
                                Cập nhật mới nhất
                            </h3>
                            <div class="flex gap-2 text-sm text-slate-500">
                                <span class="cursor-pointer hover:text-primary font-medium">Thịnh hành</span>
                                <span class="text-slate-300">|</span>
                                <span class="cursor-pointer hover:text-primary font-medium">Bàn luận nhiều nhất</span>
                            </div>
                        </div>
                        <div class="flex flex-col gap-6">
                            <article
                                onclick="window.location.href='${pageContext.request.contextPath}/user/article.jsp'"
                                class="flex flex-col sm:flex-row gap-5 bg-white dark:bg-surface-dark p-4 rounded-xl border border-slate-100 dark:border-border-dark hover:shadow-lg hover:border-primary/30 transition-all duration-300 group">
                                <div class="sm:w-56 h-40 shrink-0 rounded-lg overflow-hidden relative">
                                    <div
                                        class="absolute top-2 left-2 bg-black/60 backdrop-blur-sm text-white text-[10px] font-bold px-2 py-0.5 rounded">
                                        Công nghệ</div>
                                    <div class="w-full h-full bg-cover bg-center transition-transform duration-500 group-hover:scale-105"
                                        style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDjfrR0s1j9yaictFquQ1vY_YE1u56tiWzBQ1LqmWRlgixs9IPvIsK3E7dGf8FscFvnq2072Uz9jW2aP6A2x66gpkP3cKgu2YMmsC-re9FDsqOzul02RsRchF-xKxG5PCjjy6JhuAPBtMUmQd-RUAF46PPsEzQjHQnBLbl46Fkv2MgEW1TvPkm5He6Z_bLXIlNHUk2QMXmDcBqDZASnyqwAjWyaywA5RofmCZ_ZCvc1D9k1OONtsjCRJkTyChUSTjM4bgN2_CBMpbT0');">
                                    </div>
                                </div>
                                <div class="flex flex-col flex-1 justify-between py-1">
                                    <div>
                                        <h3
                                            class="text-lg font-bold text-slate-900 dark:text-white mb-2 group-hover:text-primary transition-colors leading-snug">
                                            Quy định về AI tạo sinh được thắt chặt trên toàn Liên minh Châu Âu
                                        </h3>
                                        <p class="text-slate-600 dark:text-slate-400 text-sm line-clamp-2 mb-3">
                                            Đạo luật AI mới nhằm phân loại các hệ thống AI dựa trên mức độ rủi ro. Các
                                            công ty phải đối mặt với mức phạt lớn nếu không tuân thủ bắt đầu từ quý tới.
                                        </p>
                                    </div>
                                    <div
                                        class="flex items-center justify-between text-xs text-slate-400 border-t border-slate-100 dark:border-slate-800 pt-3">
                                        <div class="flex items-center gap-4">
                                            <span class="flex items-center gap-1"><span
                                                    class="material-symbols-outlined text-sm">calendar_today</span> Oct
                                                24,
                                                2023</span>
                                            <span class="flex items-center gap-1"><span
                                                    class="material-symbols-outlined text-sm">schedule</span> 5 min
                                                read</span>
                                        </div>
                                        <button class="text-slate-400 hover:text-primary"><span
                                                class="material-symbols-outlined text-lg">bookmark_add</span></button>
                                    </div>
                                </div>
                            </article>
                            <article
                                onclick="window.location.href='${pageContext.request.contextPath}/user/article.jsp'"
                                class="flex flex-col sm:flex-row gap-5 bg-white dark:bg-surface-dark p-4 rounded-xl border border-slate-100 dark:border-border-dark hover:shadow-lg hover:border-primary/30 transition-all duration-300 group">
                                <div class="sm:w-56 h-40 shrink-0 rounded-lg overflow-hidden relative">
                                    <div
                                        class="absolute top-2 left-2 bg-black/60 backdrop-blur-sm text-white text-[10px] font-bold px-2 py-0.5 rounded">
                                        Chính trị</div>
                                    <div class="w-full h-full bg-cover bg-center transition-transform duration-500 group-hover:scale-105"
                                        style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDK__sk7UjLv8i1C_8OHskL_--6IxKe9kO8HlawaMoDvWPXzVAQWnbThQjVa0NVKFWNMCwOHhF4khSP0E_iZOi7RX0wNJGAhrrV9IBkrII3avkUkJqYRdYoqMN4vZtX7Hr92xkiHXYOiJcnUs5PwQTBaVtE8oC_BeGZZjLA9164Wl-nvsV7-_Gjkad5oNqMnIjkDMH5-Y5alDP_q1TM4Ci9fQeYtLaHDUKNaSMNTGU2zTN4IErbtptamGaFY02xGy2BLfE6iQY91cts');">
                                    </div>
                                </div>
                                <div class="flex flex-col flex-1 justify-between py-1">
                                    <div>
                                        <h3
                                            class="text-lg font-bold text-slate-900 dark:text-white mb-2 group-hover:text-primary transition-colors leading-snug">
                                            Dự luật Bảo mật kỹ thuật số bị đình trệ tại Thượng viện
                                        </h3>
                                        <p class="text-slate-600 dark:text-slate-400 text-sm line-clamp-2 mb-3">
                                            Các tập đoàn công nghệ lớn đang đẩy lùi các luật đề xuất về chủ quyền dữ
                                            liệu, viện dẫn những lo ngại về đổi mới.
                                        </p>
                                    </div>
                                    <div
                                        class="flex items-center justify-between text-xs text-slate-400 border-t border-slate-100 dark:border-slate-800 pt-3">
                                        <div class="flex items-center gap-4">
                                            <span class="flex items-center gap-1"><span
                                                    class="material-symbols-outlined text-sm">calendar_today</span> 23
                                                Thg 10,
                                                2023</span>
                                            <span class="flex items-center gap-1"><span
                                                    class="material-symbols-outlined text-sm">schedule</span> 8 phút
                                                đọc</span>
                                        </div>
                                        <button class="text-slate-400 hover:text-primary"><span
                                                class="material-symbols-outlined text-lg">bookmark_add</span></button>
                                    </div>
                                </div>
                            </article>
                            <article
                                onclick="window.location.href='${pageContext.request.contextPath}/user/article.jsp'"
                                class="flex flex-col sm:flex-row gap-5 bg-white dark:bg-surface-dark p-4 rounded-xl border border-slate-100 dark:border-border-dark hover:shadow-lg hover:border-primary/30 transition-all duration-300 group">
                                <div class="sm:w-56 h-40 shrink-0 rounded-lg overflow-hidden relative">
                                    <div
                                        class="absolute top-2 left-2 bg-black/60 backdrop-blur-sm text-white text-[10px] font-bold px-2 py-0.5 rounded">
                                        Thể thao</div>
                                    <div class="w-full h-full bg-cover bg-center transition-transform duration-500 group-hover:scale-105"
                                        style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDjfrR0s1j9yaictFquQ1vY_YE1u56tiWzBQ1LqmWRlgixs9IPvIsK3E7dGf8FscFvnq2072Uz9jW2aP6A2x66gpkP3cKgu2YMmsC-re9FDsqOzul02RsRchF-xKxG5PCjjy6JhuAPBtMUmQd-RUAF46PPsEzQjHQnBLbl46Fkv2MgEW1TvPkm5He6Z_bLXIlNHUk2QMXmDcBqDZASnyqwAjWyaywA5RofmCZ_ZCvc1D9k1OONtsjCRJkTyChUSTjM4bgN2_CBMpbT0');">
                                    </div>
                                </div>
                                <div class="flex flex-col flex-1 justify-between py-1">
                                    <div>
                                        <h3
                                            class="text-lg font-bold text-slate-900 dark:text-white mb-2 group-hover:text-primary transition-colors leading-snug">
                                            Phân tích AI cách mạng hóa việc tuyển trạch trong Giải bóng chày nhà nghề
                                        </h3>
                                        <p class="text-slate-600 dark:text-slate-400 text-sm line-clamp-2 mb-3">
                                            Các đội đang sử dụng thị giác máy tính để phân tích cơ sinh học của cầu thủ
                                            theo thời gian thực, ngăn ngừa chấn thương.
                                        </p>
                                    </div>
                                    <div
                                        class="flex items-center justify-between text-xs text-slate-400 border-t border-slate-100 dark:border-slate-800 pt-3">
                                        <div class="flex items-center gap-4">
                                            <span class="flex items-center gap-1"><span
                                                    class="material-symbols-outlined text-sm">calendar_today</span> 23
                                                Thg 10,
                                                2023</span>
                                            <span class="flex items-center gap-1"><span
                                                    class="material-symbols-outlined text-sm">schedule</span> 4 phút
                                                đọc</span>
                                        </div>
                                        <button class="text-slate-400 hover:text-primary"><span
                                                class="material-symbols-outlined text-lg">bookmark_add</span></button>
                                    </div>
                                </div>
                            </article>
                        </div>
                        <button
                            class="w-full py-3 mt-8 text-sm font-semibold text-primary border border-primary/20 rounded-lg hover:bg-primary/5 transition-colors flex items-center justify-center gap-2">
                            Tải thêm bài viết
                            <span class="material-symbols-outlined text-lg">expand_more</span>
                        </button>
                    </section>
                </div>
                <aside class="lg:col-span-4 flex flex-col gap-8">
                    <div
                        class="bg-gradient-to-br from-primary to-primary-dark rounded-xl p-5 text-white shadow-lg relative overflow-hidden">
                        <div class="absolute top-0 right-0 p-8 opacity-10">
                            <span class="material-symbols-outlined text-9xl">cloud</span>
                        </div>
                        <div class="relative z-10 flex justify-between items-start mb-4">
                            <div>
                                <p class="text-blue-100 text-xs font-medium uppercase tracking-wider mb-1">Thời tiết địa
                                    phương</p>
                                <h3 class="text-2xl font-bold">San Francisco</h3>
                                <div class="flex items-center gap-2 mt-1">
                                    <span class="text-4xl font-light">72°</span>
                                    <div class="flex flex-col text-xs text-blue-100">
                                        <span>Nắng</span>
                                        <span>C:75° T:62°</span>
                                    </div>
                                </div>
                            </div>
                            <span class="material-symbols-outlined text-4xl text-yellow-300">sunny</span>
                        </div>
                        <div class="relative z-10 pt-4 border-t border-white/20">
                            <div class="flex justify-between items-center text-sm">
                                <span class="font-medium">USD/EUR</span>
                                <span class="font-bold">0.94 <span class="text-green-300 text-xs">▲ +0.1%</span></span>
                            </div>
                            <div class="flex justify-between items-center text-sm mt-2">
                                <span class="font-medium">BTC/USD</span>
                                <span class="font-bold">64,230 <span class="text-red-300 text-xs">▼ -1.2%</span></span>
                            </div>
                        </div>
                    </div>
                    <div
                        class="bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-xl p-5">
                        <h3 class="text-lg font-bold text-slate-900 dark:text-white mb-4 flex items-center gap-2">
                            <span class="material-symbols-outlined text-primary">trending_up</span>
                            Đọc nhiều nhất
                        </h3>
                        <div class="flex flex-col gap-4">
                            <a class="group flex gap-3 items-start" href="#">
                                <span
                                    class="text-2xl font-black text-slate-200 dark:text-slate-700 leading-none group-hover:text-primary transition-colors">1</span>
                                <div>
                                    <h4
                                        class="text-sm font-semibold text-slate-800 dark:text-slate-200 leading-snug group-hover:text-primary transition-colors">
                                        Tại sao Thung lũng Silicon lại đầu tư mạnh vào nhiệt hạch hạt nhân
                                    </h4>
                                    <span class="text-xs text-slate-500 mt-1 block">4 giờ trước</span>
                                </div>
                            </a>
                            <a class="group flex gap-3 items-start" href="#">
                                <span
                                    class="text-2xl font-black text-slate-200 dark:text-slate-700 leading-none group-hover:text-primary transition-colors">2</span>
                                <div>
                                    <h4
                                        class="text-sm font-semibold text-slate-800 dark:text-slate-200 leading-snug group-hover:text-primary transition-colors">
                                        Tâm lý học khi tương tác với chatbot
                                    </h4>
                                    <span class="text-xs text-slate-500 mt-1 block">8 giờ trước</span>
                                </div>
                            </a>
                            <a class="group flex gap-3 items-start" href="#">
                                <span
                                    class="text-2xl font-black text-slate-200 dark:text-slate-700 leading-none group-hover:text-primary transition-colors">3</span>
                                <div>
                                    <h4
                                        class="text-sm font-semibold text-slate-800 dark:text-slate-200 leading-snug group-hover:text-primary transition-colors">
                                        Top 5 LLM mã nguồn mở đáng chú ý tháng này
                                    </h4>
                                    <span class="text-xs text-slate-500 mt-1 block">12 giờ trước</span>
                                </div>
                            </a>
                            <a class="group flex gap-3 items-start" href="#">
                                <span
                                    class="text-2xl font-black text-slate-200 dark:text-slate-700 leading-none group-hover:text-primary transition-colors">4</span>
                                <div>
                                    <h4
                                        class="text-sm font-semibold text-slate-800 dark:text-slate-200 leading-snug group-hover:text-primary transition-colors">
                                        SpaceX công bố lịch phóng mới cho Starship
                                    </h4>
                                    <span class="text-xs text-slate-500 mt-1 block">1 ngày trước</span>
                                </div>
                            </a>
                            <a class="group flex gap-3 items-start" href="#">
                                <span
                                    class="text-2xl font-black text-slate-200 dark:text-slate-700 leading-none group-hover:text-primary transition-colors">5</span>
                                <div>
                                    <h4
                                        class="text-sm font-semibold text-slate-800 dark:text-slate-200 leading-snug group-hover:text-primary transition-colors">
                                        Phỏng vấn Sam Altman về tương lai của AGI
                                    </h4>
                                    <span class="text-xs text-slate-500 mt-1 block">1 ngày trước</span>
                                </div>
                            </a>
                        </div>
                    </div>
                    <div
                        class="h-[300px] w-full bg-slate-100 dark:bg-surface-dark border border-dashed border-slate-300 dark:border-slate-700 rounded-xl flex flex-col items-center justify-center p-4 text-center relative overflow-hidden group">
                        <div class="absolute inset-0 bg-slate-200 dark:bg-slate-800 opacity-50"></div>
                        <span
                            class="relative z-10 text-xs font-bold text-slate-400 uppercase tracking-widest mb-2">Quảng
                            cáo</span>
                        <h4 class="relative z-10 text-lg font-bold text-slate-600 dark:text-slate-300">Giải pháp AI Đám
                            mây
                        </h4>
                        <p class="relative z-10 text-xs text-slate-500 mt-2 max-w-[200px]">Tăng tốc doanh nghiệp của bạn
                            với học máy cấp doanh nghiệp.</p>
                        <button
                            class="relative z-10 mt-4 px-4 py-2 bg-white dark:bg-surface-dark border border-slate-200 dark:border-slate-600 text-xs font-bold rounded shadow-sm hover:shadow text-slate-700 dark:text-slate-200">Tìm
                            hiểu thêm</button>
                    </div>
                </aside>
            </main>

            <jsp:include page="components/footer.jsp" />
        </div>
    </body>

    </html>