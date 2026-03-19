<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <jsp:useBean id="articleDao" class="neuralnews.dao.ArticleDao" />
        <c:set var="currentPage" value="${empty param.page ? 1 : param.page}" />
        <c:set var="limit" value="10" />
        <c:set var="offset" value="${(currentPage - 1) * limit}" />
        <c:set var="readArticles" value="${articleDao.getReadArticlesByUser(sessionScope.userId, limit, offset)}" />
        <c:set var="totalItems" value="${articleDao.getTotalReadArticlesByUser(sessionScope.userId)}" />
        <% Object totalObj=pageContext.getAttribute("totalItems"); Object limitObj=pageContext.getAttribute("limit");
            int total=totalObj !=null ? Integer.parseInt(totalObj.toString()) : 0; int lim=limitObj !=null ?
            Integer.parseInt(limitObj.toString()) : 1; int pages=(lim> 0) ? (int) Math.ceil((double) total / lim) : 0;
            pageContext.setAttribute("totalPages", pages);
            %>
            <!DOCTYPE html>
            <html class="dark" lang="en">
            <html class="dark" lang="en">

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
                        <div id="toast-success" class="fixed top-5 right-5 z-[110] pointer-events-none">
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
                        <div id="toast-error" class="fixed top-5 right-5 z-[110] pointer-events-none">
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
                                                            <div onclick="window.location.href='${pageContext.request.contextPath}/article?id=${article.id}'"
                                                                class="group cursor-pointer flex flex-col md:flex-row md:items-center gap-4 p-4 hover:bg-slate-50 dark:hover:bg-slate-800/50 rounded-xl transition-all border border-transparent hover:border-slate-100 dark:hover:border-slate-700">
                                                                <div
                                                                    class="size-16 rounded-lg bg-slate-200 shrink-0 overflow-hidden">
                                                                    <div class="size-full bg-cover bg-center"
                                                                        style="background-image: url('${pageContext.request.contextPath}/${article.imageUrl != null ? article.imageUrl : 'assets/images/placeholder.jpg'}');">
                                                                    </div>
                                                                </div>
                                                                <div class="flex-1 min-w-0">
                                                                    <div class="flex items-center gap-2 mb-1">
                                                                        <span
                                                                            class="px-2 py-0.5 bg-blue-500/10 text-blue-500 text-[10px] font-bold uppercase rounded">
                                                                            ${article.categoryName}
                                                                        </span>
                                                                        <span class="text-xs text-slate-400">• Đã đọc:
                                                                            ${article.createdAt}</span>
                                                                    </div>
                                                                    <h4
                                                                        class="text-base font-bold text-slate-900 dark:text-white truncate">
                                                                        ${article.title}
                                                                    </h4>
                                                                    <div
                                                                        class="flex items-center gap-4 mt-1 text-xs text-slate-500 line-clamp-1">
                                                                        ${article.summary}
                                                                    </div>
                                                                </div>
                                                                <div
                                                                    class="flex items-center gap-2 self-end md:self-center">
                                                                    <button
                                                                        onclick="event.stopPropagation(); openConfirmModal(this, '${article.id}')"
                                                                        class="p-2 text-red-500/70 hover:text-red-500 transition-colors bg-red-500/10 dark:bg-red-500/20 rounded-full flex items-center justify-center"
                                                                        title="Xóa lịch sử bài này">
                                                                        <span
                                                                            class="material-symbols-outlined text-lg">delete</span>
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

                                    <div class="mt-8 flex justify-center gap-2">
                                        <c:if test="${currentPage > 1}">
                                            <button onclick="window.location.href='?page=${currentPage - 1}'"
                                                class="px-4 py-2 bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-lg hover:text-primary transition-colors text-sm font-bold">
                                                Trước
                                            </button>
                                        </c:if>

                                        <c:forEach begin="1" end="${totalPages > 0 ? totalPages : 1}" var="i">
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
                                </div>
                            </div>
                            <div class="bg-gradient-to-r from-slate-900 to-primary-dark border border-white/10 rounded-2xl p-8 relative overflow-hidden group mt-6">
                        <div class="absolute top-0 right-0 p-12 opacity-10 pointer-events-none group-hover:scale-110 transition-transform duration-700">
                            <span class="material-symbols-outlined text-[160px]">edit_note</span>
                        </div>
                        <div class="relative z-10">
                            <div class="flex flex-col md:flex-row md:items-center justify-between gap-8">
                                <div class="max-w-xl">
                                    <span class="inline-flex items-center gap-1.5 px-3 py-1 bg-primary/20 backdrop-blur-md text-blue-400 text-[10px] font-bold uppercase tracking-widest rounded-full mb-4 border border-primary/30">
                                        <span class="material-symbols-outlined text-[14px]">stars</span>
                                        Chương trình Người sáng tạo Nexus
                                    </span>
                                    <h2 class="text-3xl md:text-4xl font-black text-white mb-4 tracking-tight">Trở thành Nhà báo Nexus</h2>
                                    <p class="text-lg text-blue-100/90 mb-2 font-medium">Tiếp cận hàng triệu độc giả với nền tảng tin tức thế hệ mới của chúng tôi.</p>
                                    <ul class="grid grid-cols-1 sm:grid-cols-2 gap-3 text-sm text-blue-100/70 mb-6">
                                        <li class="flex items-center gap-2">
                                            <span class="material-symbols-outlined text-primary text-[18px]">check_circle</span>
                                            Công cụ viết &amp; nghiên cứu AI
                                        </li>
                                        <li class="flex items-center gap-2">
                                            <span class="material-symbols-outlined text-primary text-[18px]">check_circle</span>
                                            Kiếm tiền từ báo cáo của bạn
                                        </li>
                                        <li class="flex items-center gap-2">
                                            <span class="material-symbols-outlined text-primary text-[18px]">check_circle</span>
                                            Truy cập nguồn cấp dữ liệu toàn cầu
                                        </li>
                                        <li class="flex items-center gap-2">
                                            <span class="material-symbols-outlined text-primary text-[18px]">check_circle</span>
                                            Tương tác trực tiếp với khán giả
                                        </li>
                                    </ul>
                                </div>
                                <div class="shrink-0 flex flex-col items-center gap-4">
                                    <c:choose>
                                        <c:when test="${userStatus == 'PENDING'}">
                                            <div class="px-8 py-4 bg-amber-500/20 border border-amber-500/30 text-amber-400 font-bold rounded-xl backdrop-blur-md">
                                                Đang chờ phê duyệt...
                                            </div>
                                        </c:when>
                                        <c:when test="${userRole == 'JOURNALIST' || userRole == 'ADMIN'}">
                                            <div class="px-8 py-4 bg-emerald-500/20 border border-emerald-500/30 text-emerald-400 font-bold rounded-xl backdrop-blur-md">
                                                Bạn đã là Nhà báo
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <button onclick="document.getElementById('upgradeModal').classList.remove('hidden')"
                                                class="w-full md:w-auto px-10 py-4 bg-white text-primary-dark font-black text-lg rounded-xl shadow-xl shadow-black/20 hover:bg-cyan-50 hover:text-primary hover:shadow-cyan-400/20 hover:scale-105 active:scale-95 transition-all duration-300">
                                                Đăng ký ngay
                                            </button>
                                            <p class="text-xs text-blue-200/60 font-medium">Nộp đơn mất &lt; 5 phút</p>
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
                            '<div id="' + toastId + '" class="fixed top-5 right-5 z-[150] pointer-events-none">' +
                                '<div class="' + colorClass + ' text-white px-6 py-4 rounded-2xl shadow-2xl flex items-center gap-3 pointer-events-auto transition-all duration-300">' +
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
                            const response = await fetch(`${pageContext.request.contextPath}/api/history?articleId=` + articleId + `&action=remove`, {
                                method: 'POST'
                            });

                            if (response.ok) {
                                const result = await response.text();
                                if (result === 'success') {
                                    showToast('success', 'Thành công!', 'Đã xóa khỏi lịch sử đọc.');
                                    const card = btn.closest('.group');
                                    if (card) {
                                        card.classList.add('opacity-0', 'scale-95', 'transition-all', 'duration-300');
                                        setTimeout(function() {
                                            card.remove();
                                            const historySection = document.querySelector('section > div.space-y-2');
                                            if (historySection && historySection.querySelectorAll('.group').length === 0) {
                                                historySection.innerHTML = '<p class="text-sm text-slate-500 dark:text-slate-400">Bạn chưa có lịch sử đọc nào.</p>';
                                            }
                                        }, 300);
                                    }
                                } else {
                                    showToast('error', 'Lỗi!', 'Không thể xóa lịch sử.');
                                }
                            } else {
                                showToast('error', 'Lỗi!', 'Lỗi kết nối máy chủ.');
                            }
                        } catch (error) {
                            console.error('Error:', error);
                            showToast('error', 'Lỗi!', 'Đã có lỗi không mong muốn xảy ra.');
                        }
                    }

                    async function clearAllHistory() {
                        if (!confirm('Bạn có chắc chắn muốn xóa toàn bộ lịch sử đọc?')) return;

                        try {
                            const response = await fetch(`${pageContext.request.contextPath}/api/history?action=clear`, {
                                method: 'POST'
                            });

                            if (response.ok) {
                                const result = await response.text();
                                if (result === 'success') {
                                    const historySection = document.querySelector('section > div.space-y-2');
                                    if (historySection) {
                                        historySection.innerHTML = '<p class="text-sm text-slate-500 dark:text-slate-400">Bạn chưa có lịch sử đọc nào.</p>';
                                    }
                                    location.reload(); // To update totalItems if needed
                                } else {
                                    alert('Lỗi khi xóa toàn bộ lịch sử.');
                                }
                            } else {
                                alert('Lỗi kết nối.');
                            }
                        } catch (error) {
                            console.error('Error:', error);
                            alert('Đã có lỗi xảy ra.');
                        }
                    }
                </script>
                <script>
            // Hide notifications after 5 seconds
            setTimeout(() => {
                const toasts = document.querySelectorAll('[id^="toast-"], .animate-in');
                toasts.forEach(toast => {
                    if(!toast.id.startsWith('toast-js-')) {
                        toast.classList.add('opacity-0', 'translate-y-10', 'transition-all', 'duration-500');
                        setTimeout(() => toast.remove(), 500);
                    }
                });
            }, 5000);
        </script>
            </body>

            </html>