<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
            <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

                <c:set var="catName" value="${requestScope.categoryName}" />
                <c:set var="listArt" value="${requestScope.listArticles}" />
                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <!DOCTYPE html>
                <html class="dark" lang="vi">

                <head>
                    <title>
                        <c:out value="${catName}" /> - NexusAI News
                    </title>
                    <jsp:include page="components/head.jsp" />
                    <style type="text/tailwindcss">
                        @layer utilities {
            .active-nav {
                @apply text-primary border-b-2 border-primary;
            }
        }
    </style>
                </head>

                <body
                    class="bg-background-light dark:bg-background-dark text-text-main dark:text-white font-display antialiased overflow-x-hidden transition-colors duration-200">
                    <div class="flex min-h-screen w-full flex-col">
                        <jsp:include page="components/header.jsp" />

                        <div
                            class="w-full bg-surface-light dark:bg-slate-900/50 border-b border-border-light dark:border-border-dark">
                            <div class="max-w-[1440px] mx-auto px-4 lg:px-8 py-10">
                                <nav
                                    class="flex items-center gap-2 text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-4">
                                    <a class="hover:text-primary transition-colors" href="${ctx}/home">Trang chủ</a>
                                    <span class="material-symbols-outlined text-[14px]">chevron_right</span>
                                    <span class="text-slate-600 dark:text-slate-300 font-black">
                                        <c:out value="${catName}" />
                                    </span>
                                </nav>
                                <h1
                                    class="text-4xl md:text-5xl font-black text-slate-900 dark:text-white mb-6 tracking-tight">
                                    <c:out value="${catName}" />
                                </h1>

                                <c:if test="${catName == 'Công nghệ'}">
                                    <div class="flex flex-wrap gap-2">
                                        <button
                                            class="px-4 py-1.5 rounded-full bg-primary text-white text-[10px] font-bold uppercase tracking-wider shadow-lg shadow-primary/20">Tất
                                            cả</button>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <main
                            class="flex-1 w-full max-w-[1440px] mx-auto p-4 lg:p-8 grid grid-cols-1 lg:grid-cols-12 gap-8">
                            <div class="lg:col-span-8 flex flex-col gap-6">
                                <div
                                    class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 py-4 border-b border-slate-200 dark:border-border-dark">
                                    <div class="flex items-center gap-6">
                                        <button
                                            class="text-sm font-bold text-primary border-b-2 border-primary pb-1">Mới
                                            nhất</button>
                                        <button
                                            class="text-sm font-medium text-slate-500 hover:text-primary pb-1 transition-colors">Cũ
                                            nhất</button>
                                        <button
                                            class="text-sm font-medium text-slate-500 hover:text-primary pb-1 transition-colors">Xem
                                            nhiều nhất</button>
                                        <button
                                            class="text-sm font-medium text-slate-500 hover:text-primary pb-1 transition-colors">Bình
                                            luận
                                            nhiều nhất</button>
                                    </div>
                                    <button
                                        class="flex items-center gap-2 text-xs font-bold text-slate-600 dark:text-slate-400 bg-slate-100 dark:bg-surface-dark px-3 py-1.5 rounded border border-transparent hover:border-slate-300 transition-all">
                                        <span class="material-symbols-outlined text-sm">filter_list</span>
                                        Bộ lọc Nâng cao
                                    </button>
                                </div>
                                <div id="category-articles-list" class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <c:choose>
                                        <c:when test="${not empty listArt}">
                                            <c:forEach var="art" items="${listArt}" varStatus="status">
                                                <c:choose>
                                                    <%-- Hero Article (First Item) --%>
                                                        <c:when test="${status.first}">
                                                            <article
                                                                onclick="window.location.href='${ctx}/user/article?id=${art.id}'"
                                                                class="md:col-span-2 flex flex-col md:flex-row gap-8 bg-white dark:bg-slate-900 p-6 rounded-2xl border border-slate-100 dark:border-slate-800/60 hover:shadow-2xl hover:border-primary/20 transition-all duration-500 group cursor-pointer overflow-hidden relative">
                                                                <div
                                                                    class="md:w-3/5 h-[360px] md:h-96 shrink-0 rounded-xl overflow-hidden shadow-sm">
                                                                    <div class="w-full h-full bg-cover bg-center transition-transform duration-1000 group-hover:scale-105"
                                                                        style="background-image: url('${art.getDisplayImageUrl(ctx)}');">
                                                                    </div>
                                                                </div>
                                                                <div class="flex flex-col justify-center py-2 flex-1">
                                                                    <div>
                                                                        <span
                                                                            class="inline-flex items-center px-2 py-0.5 rounded bg-primary/10 text-primary text-[10px] font-black uppercase tracking-widest mb-5 border border-primary/10">
                                                                            <c:out value="${catName}" />
                                                                        </span>
                                                                        <h2
                                                                            class="text-3xl lg:text-4xl font-black text-slate-900 dark:text-white mb-5 group-hover:text-primary transition-colors leading-[1.15] tracking-tight">
                                                                            <c:out value="${art.title}" />
                                                                        </h2>
                                                                        <p
                                                                            class="text-slate-600 dark:text-slate-400 text-base leading-relaxed line-clamp-3 mb-8">
                                                                            <c:out value="${art.summary}" />
                                                                        </p>
                                                                    </div>
                                                                    <div
                                                                        class="flex items-center justify-between pt-6 border-t border-slate-100 dark:border-slate-800">
                                                                        <div
                                                                            class="flex items-center gap-5 text-[11px] font-bold text-slate-400 uppercase tracking-widest">
                                                                            <span
                                                                                class="flex items-center gap-1.5"><span
                                                                                    class="material-symbols-outlined text-[16px]">schedule</span>
                                                                                ${art.createdAt}</span>
                                                                            <span
                                                                                class="flex items-center gap-1.5"><span
                                                                                    class="material-symbols-outlined text-[16px]">visibility</span>
                                                                                ${art.formattedViews}</span>
                                                                        </div>
                                                                        <span
                                                                            class="material-symbols-outlined text-primary group-hover:translate-x-1 transition-transform">arrow_forward</span>
                                                                    </div>
                                                                </div>
                                                            </article>
                                                        </c:when>

                                                        <%-- Normal Article Cards --%>
                                                            <c:otherwise>
                                                                <article
                                                                    onclick="window.location.href='${ctx}/user/article?id=${art.id}'"
                                                                    class="bg-white dark:bg-slate-900 rounded-2xl border border-slate-100 dark:border-slate-800/60 overflow-hidden hover:shadow-xl hover:border-primary/20 transition-all duration-500 group cursor-pointer">
                                                                    <div class="h-56 overflow-hidden relative">
                                                                        <div class="absolute top-4 left-4 z-10">
                                                                            <span
                                                                                class="px-2 py-1 rounded-lg bg-black/40 backdrop-blur-md text-white text-[9px] font-black uppercase tracking-widest border border-white/10">
                                                                                <c:out
                                                                                    value="${not empty art.categoryName ? art.categoryName : catName}" />
                                                                            </span>
                                                                        </div>
                                                                        <div class="w-full h-full bg-cover bg-center transition-transform duration-700 group-hover:scale-105"
                                                                            style="background-image: url('${art.getDisplayImageUrl(ctx)}');">
                                                                        </div>
                                                                    </div>
                                                                    <div class="p-6">
                                                                        <h3
                                                                            class="text-lg font-bold text-slate-900 dark:text-white mb-3 line-clamp-2 group-hover:text-primary transition-colors leading-snug">
                                                                            <c:out value="${art.title}" />
                                                                        </h3>
                                                                        <p
                                                                            class="text-slate-500 dark:text-slate-400 text-xs leading-relaxed line-clamp-2 mb-6">
                                                                            <c:out value="${art.summary}" />
                                                                        </p>
                                                                        <div
                                                                            class="flex items-center justify-between text-[10px] text-slate-400 font-bold uppercase tracking-widest pt-4 border-t border-slate-50 dark:border-slate-800/50">
                                                                            <span
                                                                                class="flex items-center gap-1.5"><span
                                                                                    class="material-symbols-outlined text-[14px]">calendar_today</span>
                                                                                ${art.createdAt}</span>
                                                                            <button
                                                                                class="text-slate-400 hover:text-primary transition-colors"><span
                                                                                    class="material-symbols-outlined text-lg">bookmark</span></button>
                                                                        </div>
                                                                    </div>
                                                                </article>
                                                            </c:otherwise>
                                                </c:choose>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div
                                                class="md:col-span-2 flex flex-col items-center justify-center py-24 text-center">
                                                <div
                                                    class="size-20 bg-slate-100 dark:bg-slate-800 rounded-full flex items-center justify-center mb-6">
                                                    <span
                                                        class="material-symbols-outlined text-4xl text-slate-300 dark:text-slate-600">article</span>
                                                </div>
                                                <h3 class="text-xl font-bold text-slate-900 dark:text-white">Chưa có bài
                                                    viết nào</h3>
                                                <p class="text-sm text-slate-500 dark:text-slate-400 mt-2 max-w-xs">
                                                    Tuyệt vời, dường như chúng tôi đang cập nhật nội dung cho danh mục
                                                    này. Quay lại sau nhé!</p>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <button id="btn-load-more"
                                    class="w-full py-4 mt-8 text-sm font-bold text-primary border border-primary/20 rounded-xl hover:bg-primary/5 transition-all flex items-center justify-center gap-2">
                                    Tải thêm bài viết ${catName}
                                    <span class="material-symbols-outlined text-lg">expand_more</span>
                                </button>
                            </div>
                            <aside class="lg:col-span-4 flex flex-col gap-8">
                                <div class="bg-primary rounded-xl p-6 text-white shadow-lg">
                                    <h3 class="text-lg font-bold mb-2">Bản tin Công nghệ hàng tuần</h3>
                                    <p class="text-blue-100 text-sm mb-4">Nhận những tin tức công nghệ quan trọng nhất
                                        vào sáng thứ
                                        6 hàng tuần.</p>
                                    <div class="flex flex-col gap-2">
                                        <input
                                            class="w-full h-10 px-4 rounded bg-white/10 border-white/20 placeholder:text-blue-200 text-sm focus:ring-0 focus:border-white"
                                            placeholder="email@example.com" type="email" />
                                        <button
                                            class="w-full h-10 bg-white text-primary font-bold rounded text-sm hover:bg-blue-50 transition-colors">Đăng
                                            ký ngay</button>
                                    </div>
                                </div>
                                <div
                                    class="bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-xl p-5">
                                    <h3
                                        class="text-lg font-bold text-slate-900 dark:text-white mb-4 flex items-center gap-2">
                                        <span class="material-symbols-outlined text-primary">bolt</span>
                                        Xu hướng Công nghệ
                                    </h3>
                                    <div class="flex flex-col gap-5">
                                        <a class="group flex gap-3 items-start" href="#">
                                            <div class="size-16 shrink-0 rounded bg-slate-100 overflow-hidden">
                                                <div class="size-full bg-cover bg-center"
                                                    style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDK__sk7UjLv8i1C_8OHskL_--6IxKe9kO8HlawaMoDvWPXzVAQWnbThQjVa0NVKFWNMCwOHhF4khSP0E_iZOi7RX0wNJGAhrrV9IBkrII3avkUkJqYRdYoqMN4vZtX7Hr92xkiHXYOiJcnUs5PwQTBaVtE8oC_BeGZZjLA9164Wl-nvsV7-_Gjkad5oNqMnIjkDMH5-Y5alDP_q1TM4Ci9fQeYtLaHDUKNaSMNTGU2zTN4IErbtptamGaFY02xGy2BLfE6iQY91cts');">
                                                </div>
                                            </div>
                                            <div>
                                                <h4
                                                    class="text-sm font-bold text-slate-800 dark:text-slate-200 leading-tight group-hover:text-primary transition-colors line-clamp-2">
                                                    Tiêu chuẩn bảo mật mới cho Kỷ nguyên Điện toán Lượng tử
                                                </h4>
                                                <span
                                                    class="text-[10px] text-slate-500 font-bold uppercase mt-1 block">4,200
                                                    yêu thích</span>
                                            </div>
                                        </a>
                                        <a class="group flex gap-3 items-start" href="#">
                                            <div class="size-16 shrink-0 rounded bg-slate-100 overflow-hidden">
                                                <div class="size-full bg-cover bg-center"
                                                    style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCrc_7XThJ5bAFGC03h2RGUpg2i4LGEanIMHmTjsApYkKda1tlYEyQlB0qYKhYImQ4lOhybrDjFu3zamKplFgbncnCxd7y4Y3S_EefRhQgK224OagGlzOIC6sFI_CafUwt_kXS-8vLmfW8iH5e8gXhSt0pmZBRpwc2Gd0DK1BeTFHNVeEWi8Kvc2fffea280_KCVJI5lZOJoH3D1IVjtPQgvmXXQ51k0UBribsipHUPoK0RCeTAOuNoBnmbyDqQIfikd98VZOU0GsaT');">
                                                </div>
                                            </div>
                                            <div>
                                                <h4
                                                    class="text-sm font-bold text-slate-800 dark:text-slate-200 leading-tight group-hover:text-primary transition-colors line-clamp-2">
                                                    Python 4.0: Những điều nhà phát triển cần biết
                                                </h4>
                                                <span
                                                    class="text-[10px] text-slate-500 font-bold uppercase mt-1 block">3,850
                                                    lượt xem</span>
                                            </div>
                                        </a>
                                        <a class="group flex gap-3 items-start" href="#">
                                            <div class="size-16 shrink-0 rounded bg-slate-100 overflow-hidden">
                                                <div class="size-full bg-cover bg-center"
                                                    style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDobs8RjnWif8UQ50Z-fZfKRUVaMxulVKyLJdFLEkjgEgdaSwAwySOmh-X4NXt6Z2EbuQkjyJKhAzNOg1h9iYcrccPrjPrIifqBxE-4KvC_pF7Legf3GjHjeRwugZMYsc2FLVCs5rm4MknfVKmOfFUDY8yM6gV7kSjA5JUZAAcRP6dT2BhOfWs_avYZVJyfqlMMUG2gdgv7BBGrbdKqdKD5U4WLCsDMajC0Q5TVJK3OtfMFNb3ejHCdFOdOm2FtjsuJ2Mk5HWKu91Ms');">
                                                </div>
                                            </div>
                                            <div>
                                                <h4
                                                    class="text-sm font-bold text-slate-800 dark:text-slate-200 leading-tight group-hover:text-primary transition-colors line-clamp-2">
                                                    Robot chăm nom người cao tuổi
                                                </h4>
                                                <span
                                                    class="text-[10px] text-slate-500 font-bold uppercase mt-1 block">2,900
                                                    lượt xem</span>
                                            </div>
                                        </a>
                                    </div>
                                </div>
                                <div
                                    class="h-[450px] w-full bg-slate-100 dark:bg-surface-dark border border-dashed border-slate-300 dark:border-slate-700 rounded-xl flex flex-col items-center justify-center p-6 text-center relative overflow-hidden group">
                                    <div class="absolute inset-0 bg-slate-200 dark:bg-slate-800/40 opacity-50"></div>
                                    <div class="relative z-10">
                                        <span
                                            class="text-[10px] font-black text-slate-400 uppercase tracking-widest mb-4 block">Nội
                                            dung được tài trợ</span>
                                        <div
                                            class="size-20 bg-primary/10 rounded-full flex items-center justify-center mx-auto mb-4">
                                            <span
                                                class="material-symbols-outlined text-4xl text-primary">cloud_done</span>
                                        </div>
                                        <h4
                                            class="text-xl font-black text-slate-900 dark:text-white mb-2 leading-tight">
                                            Mở rộng nền
                                            tảng AI của bạn</h4>
                                        <p class="text-sm text-slate-500 dark:text-slate-400 mb-6">Phản giải các bài
                                            toán Machine
                                            Learning quy mô với công nghệ được tài trợ
                                            được đội ngũ AI xây dựng.</p>
                                        <button
                                            class="px-6 py-2.5 bg-primary text-white text-xs font-bold rounded-lg shadow-lg hover:bg-primary-dark transition-all uppercase tracking-wider">DÙNG
                                            THỬ BẢN MIỄN PHÍ</button>
                                    </div>
                                </div>
                            </aside>
                        </main>
                        <jsp:include page="components/footer.jsp" />
                    </div>

                    <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            const ctxPath = '${ctx}';
                            const catId = '${param.id}';
                            const btnLoadMore = document.getElementById('btn-load-more');
                            const articlesList = document.getElementById('category-articles-list');

                            let offset = 20; // Ban đầu đã load 20 bài
                            const limit = 10;

                            function getImageUrl(img) {
                                if (!img) return ctxPath + '/uploads/images/placeholder.jpg';
                                if (img.startsWith('http')) return img;
                                let path = img.startsWith('/') ? img : '/' + img;
                                return ctxPath + path;
                            }

                            if (btnLoadMore) {
                                btnLoadMore.addEventListener('click', function () {
                                    const originalText = btnLoadMore.innerHTML;
                                    btnLoadMore.innerHTML = 'Đang tải...';
                                    btnLoadMore.disabled = true;

                                    fetch(ctxPath + '/home-ajax?action=loadMoreLatest&offset=' + offset + '&limit=' + limit + '&catId=' + catId)
                                        .then(res => res.json())
                                        .then(data => {
                                            if (data.length > 0) {
                                                let html = '';
                                                data.forEach(art => {
                                                    let ds = art.createdAt ? new Date(art.createdAt).toLocaleDateString('vi-VN') : '';

                                                    html += `
                                    <article onclick="window.location.href='\${ctxPath}/user/article?id=\${art.id}'"
                                        class="bg-white dark:bg-surface-dark rounded-xl border border-slate-100 dark:border-border-dark overflow-hidden hover:shadow-md transition-all group cursor-pointer">
                                        <div class="h-48 overflow-hidden relative">
                                            <div class="absolute top-3 left-3 z-10">
                                                <span class="px-2 py-1 rounded bg-black/60 backdrop-blur-md text-white text-[10px] font-bold uppercase tracking-wider">\${art.categoryName || 'Tin tức'}</span>
                                            </div>
                                            <div class="w-full h-full bg-cover bg-center transition-transform duration-500 group-hover:scale-105"
                                                style="background-image: url('\${getImageUrl(art.imageUrl)}');">
                                            </div>
                                        </div>
                                        <div class="p-4">
                                            <h3 class="text-base font-bold text-slate-900 dark:text-white mb-2 line-clamp-2 group-hover:text-primary transition-colors">
                                                \${art.title}</h3>
                                            <p class="text-slate-500 dark:text-slate-400 text-xs line-clamp-2 mb-4">\${art.summary}</p>
                                            <div class="flex items-center justify-between text-[10px] text-slate-400 font-bold uppercase tracking-widest pt-3 border-t border-slate-50 dark:border-slate-800">
                                                <span>\${ds}</span>
                                                <button class="text-slate-400 hover:text-primary"><span class="material-symbols-outlined text-lg">bookmark</span></button>
                                            </div>
                                        </div>
                                    </article>`;
                                                });
                                                articlesList.insertAdjacentHTML('beforeend', html);
                                                offset += limit;
                                                btnLoadMore.innerHTML = originalText;
                                                btnLoadMore.disabled = false;

                                                if (data.length < limit) {
                                                    btnLoadMore.style.display = 'none';
                                                }
                                            } else {
                                                btnLoadMore.innerHTML = 'Đã hết bài viết';
                                                btnLoadMore.disabled = true;
                                            }
                                        })
                                        .catch(err => {
                                            console.error(err);
                                            btnLoadMore.innerHTML = 'Lỗi khi tải, thử lại';
                                            btnLoadMore.disabled = false;
                                        });
                                });
                            }
                        });
                    </script>
                </body>

                </html>