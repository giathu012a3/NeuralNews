<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<jsp:useBean id="articleDao" class="neuralnews.dao.ArticleDao" />

<c:set var="u" value="${sessionScope.currentUser}" />
<c:set var="currentPage" value="${not empty param.page ? param.page : 1}" />
<c:set var="limit" value="10" />
<c:set var="offset" value="${(currentPage - 1) * limit}" />
<c:set var="readArticles" value="${articleDao.getReadArticlesByUser(u.id, limit, offset)}" />
<c:set var="totalItems" value="${articleDao.getTotalReadArticlesByUser(u.id)}" />
<c:set var="totalPages" value="${totalItems > 0 ? (totalItems + limit - 1) / limit : 0}" />
<fmt:parseNumber var="totalPages" integerOnly="true" value="${totalPages}" />

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html class="dark" lang="vi">

            <head>
                <title>Lịch sử đọc - Bảng điều khiển NexusAI</title>
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
                    <jsp:include page="components/header.jsp">
                        <jsp:param name="hideSearch" value="true" />
                    </jsp:include>

                    <!-- Notifications (Top-Right) -->
                    <c:if test="${not empty param.success}">
                        <div id="toast-success" class="fixed top-24 right-5 z-[110] pointer-events-none">
                            <div class="bg-emerald-500 text-white px-6 py-4 rounded-2xl shadow-2xl flex items-center gap-3 pointer-events-auto transition-all duration-300">
                                <span class="material-symbols-outlined text-2xl">check_circle</span>
                                <div>
                                    <p class="font-black tracking-tight text-sm">Thành công!</p>
                                    <p class="text-xs opacity-90">Thao tác của bạn đã hoàn tất.</p>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${not empty param.error}">
                        <div id="toast-error" class="fixed top-24 right-5 z-[110] pointer-events-none">
                            <div class="bg-red-500 text-white px-6 py-4 rounded-2xl shadow-2xl flex items-center gap-3 pointer-events-auto transition-all duration-300">
                                <span class="material-symbols-outlined text-2xl">error</span>
                                <div>
                                    <p class="font-black tracking-tight text-sm">Đã có lỗi xảy ra!</p>
                                    <p class="text-xs opacity-90">Chúng tôi không thể thực hiện yêu cầu này. Thử lại sau.</p>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Custom Confirm Modal -->
                    <div id="confirmModal" class="fixed inset-0 z-[120] hidden overflow-y-auto">
                        <!-- Backdrop -->
                        <div class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm transition-opacity" onclick="closeConfirmModal()"></div>
                        
                        <!-- Center modal box -->
                        <div class="flex min-h-full items-center justify-center p-4">
                            <div class="relative overflow-hidden rounded-3xl bg-white dark:bg-surface-dark text-left shadow-2xl sm:w-full sm:max-w-md transition-all duration-300 border border-slate-200 dark:border-border-dark">
                                <div class="px-6 pt-6 pb-4">
                                    <div class="flex items-center gap-4 mb-4">
                                        <div class="size-12 rounded-2xl bg-red-500/10 flex items-center justify-center text-red-600">
                                            <span class="material-symbols-outlined text-2xl">history_toggle_off</span>
                                        </div>
                                        <h3 class="text-xl font-black text-slate-900 dark:text-white tracking-tight">Xóa lịch sử đọc?</h3>
                                    </div>
                                    <p class="text-sm text-slate-500 dark:text-slate-400 font-medium leading-relaxed">
                                        Bạn có chắc chắn muốn xóa bài viết này khỏi lịch sử đọc của mình không?
                                    </p>
                                </div>
                                <div class="px-6 py-4 bg-slate-50 dark:bg-background-dark/50 flex flex-col-reverse sm:flex-row sm:justify-end gap-3">
                                    <button type="button" onclick="closeConfirmModal()" class="px-6 py-2.5 text-sm font-bold text-slate-600 dark:text-slate-400 hover:bg-slate-200/50 dark:hover:bg-slate-800 rounded-xl transition-colors">Hủy bỏ</button>
                                    <button type="button" id="modalConfirmBtn" class="px-8 py-2.5 text-sm font-bold bg-red-500 text-white rounded-xl hover:bg-red-600 shadow-lg shadow-red-500/20 transition-all text-center">Xác nhận xóa</button>
                                </div>
                            </div>
                        </div>
                    </div>

                    <main class="flex-1 w-full max-w-[1440px] mx-auto p-4 lg:p-8 flex flex-col lg:flex-row gap-8 items-start">
                        <div class="w-full lg:w-72 shrink-0 sticky top-24">
                            <jsp:include page="components/sidebar.jsp" />
                        </div>

                        <div class="flex-1 flex flex-col gap-6">
                            <div
                                class="bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-xl overflow-hidden">
                                <div
                                    class="flex border-b border-slate-200 dark:border-border-dark overflow-x-auto scrollbar-hide">
                                    <button
                                        onclick="window.location.href='${pageContext.request.contextPath}/user/profile.jsp'"
                                        class="px-6 py-4 text-sm font-bold text-slate-500 dark:text-slate-400 border-b-2 border-transparent hover:text-primary transition-colors whitespace-nowrap">
                                        Tổng quan
                                    </button>
                                    <button
                                        onclick="window.location.href='${pageContext.request.contextPath}/user/saved_articles.jsp'"
                                        class="px-6 py-4 text-sm font-bold text-slate-500 dark:text-slate-400 border-b-2 border-transparent hover:text-primary transition-colors whitespace-nowrap">
                                        Bài viết đã lưu
                                    </button>
                                    <button
                                        onclick="window.location.href='${pageContext.request.contextPath}/user/reading_history.jsp'"
                                        class="px-6 py-4 text-sm font-bold text-primary border-b-2 border-primary whitespace-nowrap bg-primary/5">
                                        Lịch sử đọc
                                    </button>
                                </div>
                                <div class="p-6 md:p-8 space-y-8">
                                    <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
                                        <div>
                                            <h2 class="text-xl font-bold text-slate-900 dark:text-white">Lịch sử đọc
                                            </h2>
                                            <p class="text-sm text-slate-500 dark:text-slate-400">Theo dõi
                                                hành trình tri thức của bạn trên NexusAI.</p>
                                        </div>
                                        <div class="flex items-center gap-2">

                                            <button onclick="clearAllHistory()"
                                                class="flex items-center gap-2 px-4 py-2 text-sm font-semibold border border-red-200 dark:border-red-900/30 text-red-500 rounded-lg hover:bg-red-50 dark:hover:bg-red-500/5 transition-colors">
                                                <span class="material-symbols-outlined text-sm">delete</span>
                                                Xóa Lịch sử
                                            </button>
                                        </div>
                                    </div>
                                    <div class="space-y-4">
                                        <section>
                                            <h3
                                                class="flex items-center gap-2 text-xs font-black uppercase tracking-[0.2em] text-slate-400 dark:text-slate-500 mb-4 px-1">
                                                <span class="size-1.5 bg-primary rounded-full"></span>
                                                Lịch sử gần đây
                                            </h3>
                                            <div class="space-y-2">
                                                <c:choose>
                                                    <c:when test="${not empty readArticles}">
                                                        <c:forEach var="article" items="${readArticles}">
                                                            <div onclick="window.location.href='${ctx}/user/article?id=${article.id}'"
                                                                class="group cursor-pointer flex flex-col md:flex-row md:items-center gap-5 p-4 bg-white dark:bg-slate-900/50 hover:bg-slate-50 dark:hover:bg-slate-800/80 rounded-2xl transition-all border border-slate-100 dark:border-slate-800/60 hover:border-primary/20 hover:shadow-xl">
                                                                <div class="size-20 rounded-xl bg-slate-200 shrink-0 overflow-hidden shadow-sm">
                                                                    <div class="size-full bg-cover bg-center transition-transform duration-700 group-hover:scale-110"
                                                                        style="background-image: url('${article.getDisplayImageUrl(ctx)}');">
                                                                    </div>
                                                                </div>
                                                                <div class="flex-1 min-w-0">
                                                                    <div class="flex items-center gap-2 mb-2">
                                                                        <span class="px-2 py-0.5 bg-primary/10 text-primary text-[10px] font-black uppercase tracking-widest rounded-md border border-primary/10">
                                                                            ${article.categoryName}
                                                                        </span>
                                                                        <span class="text-[10px] font-bold text-slate-400 uppercase tracking-widest flex items-center gap-1">
                                                                            <span class="material-symbols-outlined text-[14px]">schedule</span>
                                                                            ${article.createdAt}
                                                                        </span>
                                                                    </div>
                                                                    <h4 class="text-lg font-black text-slate-900 dark:text-white truncate group-hover:text-primary transition-colors tracking-tight">
                                                                        ${article.title}
                                                                    </h4>
                                                                    <p class="text-xs text-slate-500 dark:text-slate-400 mt-1 line-clamp-1 italic">
                                                                        ${article.summary}
                                                                    </p>
                                                                </div>
                                                                <div class="flex items-center gap-3 self-end md:self-center">
                                                                    <button onclick="event.stopPropagation(); openConfirmModal(this, '${article.id}')"
                                                                        class="size-10 text-red-500/70 hover:text-white hover:bg-red-500 transition-all bg-red-500/5 dark:bg-red-500/10 rounded-xl flex items-center justify-center group/del shadow-sm"
                                                                        title="Xóa khỏi lịch sử">
                                                                        <span class="material-symbols-outlined text-[20px] group-hover/del:rotate-12 transition-transform">delete</span>
                                                                    </button>
                                                                </div>
                                                            </div>
                                                        </c:forEach>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <p class="text-sm text-slate-500 dark:text-slate-400">Bạn chưa
                                                            có lịch sử đọc nào.</p>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </section>
                                    </div>

                                    <c:if test="${totalPages > 1}">
                                        <div class="mt-8 flex justify-center gap-2">
                                            <c:if test="${currentPage > 1}">
                                                <button onclick="window.location.href='?page=${currentPage - 1}'"
                                                    class="px-4 py-2 bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-lg hover:text-primary transition-colors text-sm font-bold">
                                                    Trước
                                                </button>
                                            </c:if>

                                            <c:forEach begin="1" end="${totalPages}" var="i">
                                                <button onclick="window.location.href='?page=${i}'"
                                                    class="px-4 py-2 rounded-lg text-sm font-bold transition-colors ${i == currentPage ? 'bg-primary text-white' : 'bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark hover:text-primary'}">
                                                    ${i}
                                                </button>
                                            </c:forEach>

                                            <c:if test="${currentPage < totalPages}">
                                                <button onclick="window.location.href='?page=${currentPage + 1}'"
                                                    class="px-4 py-2 bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-lg hover:text-primary transition-colors text-sm font-bold">
                                                    Sau
                                                </button>
                                            </c:if>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                            <div class="bg-gradient-to-br from-slate-950 via-slate-900 to-indigo-950 border border-white/10 rounded-3xl p-8 lg:p-12 relative overflow-hidden group mt-6 shadow-2xl shadow-indigo-500/10">
                                <%-- Accent glow --%>
                                <div class="absolute -top-24 -right-24 size-96 bg-primary/20 rounded-full blur-[100px] pointer-events-none"></div>
                                <div class="absolute -bottom-24 -left-24 size-96 bg-indigo-500/10 rounded-full blur-[100px] pointer-events-none"></div>
                                
                                <div class="absolute top-0 right-0 p-12 opacity-5 pointer-events-none group-hover:scale-110 transition-transform duration-1000">
                                    <span class="material-symbols-outlined text-[200px] text-white">news</span>
                                </div>

                                <div class="relative z-10">
                                    <div class="flex flex-col lg:flex-row lg:items-center justify-between gap-12">
                                        <div class="max-w-2xl">
                                            <div class="inline-flex items-center gap-2 px-3 py-1.5 bg-primary/20 backdrop-blur-xl text-primary-light text-[10px] font-black uppercase tracking-[0.2em] rounded-full mb-6 border border-primary/20 shadow-lg shadow-primary/20">
                                                <span class="material-symbols-outlined text-[14px]">verified</span>
                                                Cơ hội nghề nghiệp
                                            </div>
                                            <h2 class="text-4xl md:text-5xl font-black text-white mb-6 tracking-tight leading-[1.1]">
                                                Kế khai tiếng nói của bạn <br/>
                                                <span class="text-transparent bg-clip-text bg-gradient-to-r from-blue-400 to-indigo-400">cùng Nexus AI.</span>
                                            </h2>
                                            <p class="text-lg text-slate-300 mb-8 font-medium leading-relaxed">Tham gia mạng lưới hơn 500 nhà báo chuyên nghiệp và cộng tác viên để cùng xây dựng nền tảng tin tức thông minh nhất thế giới.</p>
                                        </div>
                                        
                                        <div class="shrink-0 flex flex-col items-center gap-6">
                                            <c:choose>
                                                <c:when test="${userStatus == 'PENDING'}">
                                                    <div class="px-10 py-5 bg-amber-500/10 border border-amber-500/30 text-amber-500 font-black rounded-2xl backdrop-blur-xl flex flex-col items-center gap-2">
                                                        <span class="material-symbols-outlined animate-spin">sync</span>
                                                        Đang chờ duyệt hồ sơ
                                                    </div>
                                                </c:when>
                                                <c:when test="${userRole == 'JOURNALIST' || userRole == 'ADMIN'}">
                                                    <div class="px-10 py-6 bg-emerald-500/10 border border-emerald-500/30 text-emerald-400 font-black rounded-2xl backdrop-blur-xl flex flex-col items-center gap-1">
                                                        <span class="material-symbols-outlined text-3xl">workspace_premium</span>
                                                        Cấp độ Chuyên gia
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <button type="button" onclick="document.getElementById('upgradeModal').classList.remove('hidden')"
                                                        class="group relative px-12 py-5 bg-white text-slate-900 font-black text-xl rounded-2xl shadow-[0_0_30px_-5px_rgba(255,255,255,0.3)] hover:shadow-primary/40 hover:-translate-y-1 active:scale-95 transition-all duration-300 overflow-hidden">
                                                        <span class="relative z-10">Gửi đơn ngay</span>
                                                        <div class="absolute inset-0 bg-gradient-to-r from-blue-50 to-indigo-50 opacity-0 group-hover:opacity-100 transition-opacity"></div>
                                                    </button>
                                                    <p class="text-[11px] text-slate-500 font-bold uppercase tracking-widest">Phản hồi hồ sơ trong 24h</p>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </main>
                    <jsp:include page="components/footer.jsp" />
                    <div id="upgradeModal" class="fixed inset-0 z-[100] flex items-center justify-center p-4 hidden">
                        <div class="fixed inset-0 bg-slate-900/80 backdrop-blur-sm shadow-2xl" onclick="this.parentElement.classList.add('hidden')"></div>
                        <div class="bg-white dark:bg-slate-900 w-full max-w-lg rounded-2xl shadow-2xl relative overflow-hidden z-10 animate-in fade-in zoom-in duration-300">
                            <div class="bg-gradient-to-r from-slate-900 to-primary p-6 text-white text-center">
                                <h2 class="text-2xl font-black">Đăng ký Cộng tác viên</h2>
                                <p class="text-blue-100/70 text-sm mt-1">Cung cấp thông tin để chúng tôi xem xét hồ sơ của bạn</p>
                            </div>
                            <form action="${pageContext.request.contextPath}/JournalistUpgradeController" method="post" class="p-6 space-y-5">
                                <div class="space-y-1.5">
                                    <label class="text-xs font-bold text-slate-400 uppercase tracking-widest">Kinh nghiệm viết lách (năm)</label>
                                    <input type="number" name="experience" min="0" required
                                        class="w-full h-12 px-4 bg-slate-50 dark:bg-slate-800 border-slate-200 dark:border-slate-700 rounded-xl focus:ring-2 focus:ring-primary transition-all text-slate-900 dark:text-white"
                                        placeholder="Ví dụ: 3">
                                </div>
                                <div class="space-y-1.5">
                                    <label class="text-xs font-bold text-slate-400 uppercase tracking-widest">Giới thiệu ngắn / Link Portfolio</label>
                                    <textarea name="bio" required rows="4"
                                        class="w-full p-4 bg-slate-50 dark:bg-slate-800 border-slate-200 dark:border-slate-700 rounded-xl focus:ring-2 focus:ring-primary transition-all text-slate-900 dark:text-white resize-none"
                                        placeholder="Mô tả các lĩnh vực bạn am hiểu hoặc dán link bài viết tiêu biểu..."></textarea>
                                </div>
                                <div class="flex gap-4 pt-2">
                                    <button type="button" onclick="document.getElementById('upgradeModal').classList.add('hidden')"
                                        class="flex-1 h-12 text-sm font-bold text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-xl transition-colors">Hủy</button>
                                    <button type="submit"
                                        class="flex-1 h-12 bg-primary text-white font-bold rounded-xl shadow-lg shadow-primary/20 hover:bg-primary-dark transition-all">Gửi yêu cầu</button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <script>
                        function openConfirmModal(btn, articleId) {
                            const modal = document.getElementById('confirmModal');
                            const confirmBtn = document.getElementById('modalConfirmBtn');
                            modal.classList.remove('hidden');
                            document.body.classList.add('overflow-hidden');
                            confirmBtn.onclick = function() {
                                closeConfirmModal();
                                deleteHistoryItem(btn, articleId);
                            };
                        }

                        function closeConfirmModal() {
                            document.getElementById('confirmModal').classList.add('hidden');
                            document.body.classList.remove('overflow-hidden');
                        }

                        function showToast(type, title, message) {
                            const toastId = 'toast-js-' + Date.now();
                            const colorClass = type === 'success' ? 'bg-emerald-500' : 'bg-red-500';
                            const iconName   = type === 'success' ? 'check_circle'   : 'error';
                            const toastHtml =
                                '<div id="' + toastId + '" class="fixed top-24 right-5 z-[150] pointer-events-none">' +
                                    '<div class="' + colorClass + ' text-white px-6 py-4 rounded-2xl shadow-2xl flex items-center gap-3 pointer-events-auto transition-all duration-300 animate-in fade-in slide-in-from-top-4">' +
                                        '<span class="material-symbols-outlined text-2xl">' + iconName + '</span>' +
                                        '<div>' +
                                            '<p class="font-black tracking-tight text-sm">' + title + '</p>' +
                                            '<p class="text-xs opacity-90">' + message + '</p>' +
                                        '</div>' +
                                    '</div>' +
                                '</div>';
                            document.body.insertAdjacentHTML('beforeend', toastHtml);
                            setTimeout(function() {
                                const t = document.getElementById(toastId);
                                if (t) {
                                    t.querySelector('div').classList.add('opacity-0', 'translate-y-[-10px]', 'transition-all', 'duration-500');
                                    setTimeout(function() { t.remove(); }, 500);
                                }
                            }, 5000);
                        }

                        async function deleteHistoryItem(btn, articleId) {
                            try {
                                const response = await fetch(`${ctx}/api/history?articleId=` + articleId + `&action=remove`, {
                                    method: 'POST'
                                });

                                if (response.ok) {
                                    const result = await response.text();
                                    if (result === 'success') {
                                        showToast('success', 'Thành công!', 'Đã xóa khỏi lịch sử đọc.');
                                        const card = btn.closest('.group');
                                        if (card) {
                                            card.classList.add('opacity-0', 'scale-95', 'transition-all', 'duration-300');
                                            setTimeout(function() { card.remove(); }, 300);
                                        }
                                    } else {
                                        showToast('error', 'Lỗi!', 'Không thể xóa lịch sử.');
                                    }
                                }
                            } catch (error) {
                                console.error('Error:', error);
                                showToast('error', 'Lỗi!', 'Đã có lỗi xảy ra.');
                            }
                        }

                        async function clearAllHistory() {
                            if (!confirm('Bạn có chắc chắn muốn xóa toàn bộ lịch sử đọc?')) return;
                            try {
                                const response = await fetch(`${ctx}/api/history?action=clear`, { method: 'POST' });
                                if (response.ok) {
                                    location.reload();
                                }
                            } catch (error) {
                                console.error('Error:', error);
                            }
                        }

                        // Auto-hide existing toasts
                        setTimeout(() => {
                            const toasts = document.querySelectorAll('[id^="toast-"]');
                            toasts.forEach(toast => {
                                toast.classList.add('opacity-0', 'translate-y-10', 'transition-all', 'duration-500');
                                setTimeout(() => toast.remove(), 500);
                            });
                        }, 5000);
                    </script>
                </div>
            </body>
            </html>
```