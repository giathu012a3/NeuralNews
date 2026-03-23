<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:if test="${empty sessionScope.currentUser}">
    <c:redirect url="/auth/login.jsp" />
</c:if>

<jsp:useBean id="articleDao" class="neuralnews.dao.ArticleDao" scope="request" />
<jsp:useBean id="commentDao" class="neuralnews.dao.CommentDao" scope="request" />
<jsp:useBean id="notifDao" class="neuralnews.dao.NotificationDao" scope="request" />

<c:set var="ctx" value="${pageContext.request.contextPath}" />

<%-- Fetch stats and notifications using EL-friendly beans --%>
<c:set var="u" value="${sessionScope.currentUser}" />
<c:set var="countSaved" value="${articleDao.countSavedByUser(u.id)}" />
<c:set var="countRead" value="${articleDao.countReadByUser(u.id)}" />
<c:set var="countComments" value="${commentDao.countCommentsByUser(u.id)}" />
<c:set var="profileNotifs" value="${notifDao.getNotificationsByUserId(u.id, 10, 0)}" />

<!DOCTYPE html>
<html class="dark" lang="en">
<head>
    <title>Bảng điều khiển Người dùng - NexusAI</title>
    <jsp:include page="components/head.jsp" />
    <style>
        .scrollbar-hide::-webkit-scrollbar { display: none; }
        .scrollbar-hide { -ms-overflow-style: none; scrollbar-width: none; }
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark text-text-main dark:text-white font-display antialiased overflow-x-hidden transition-colors duration-200">
    <div class="flex min-h-screen w-full flex-col">
        <jsp:include page="components/header.jsp">
            <jsp:param name="hideSearch" value="true" />
        </jsp:include>

        <!-- Beautiful Notifications (Center) -->
        <c:if test="${not empty param.success}">
            <div id="toast-success" class="fixed inset-0 z-[110] flex items-center justify-center p-4 pointer-events-none">
                <div class="bg-emerald-500 text-white px-8 py-4 rounded-2xl shadow-2xl flex items-center gap-4 animate-in fade-in zoom-in duration-300 pointer-events-auto">
                    <span class="material-symbols-outlined text-3xl">check_circle</span>
                    <div>
                        <p class="font-black tracking-tight">Thành công!</p>
                        <p class="text-sm opacity-90">Thao tác của bạn đã hoàn tất.</p>
                    </div>
                </div>
            </div>
        </c:if>
        <c:if test="${not empty param.error}">
            <div id="toast-error" class="fixed inset-0 z-[110] flex items-center justify-center p-4 pointer-events-none">
                <div class="bg-red-500 text-white px-8 py-4 rounded-2xl shadow-2xl flex items-center gap-4 animate-in fade-in zoom-in duration-300 pointer-events-auto">
                    <span class="material-symbols-outlined text-3xl">error</span>
                    <div>
                        <p class="font-black tracking-tight">Đã có lỗi xảy ra!</p>
                        <p class="text-sm opacity-90">Chúng tôi không thể thực hiện yêu cầu này. Thử lại sau.</p>
                    </div>
                </div>
            </div>
        </c:if>

        <main class="flex-1 w-full max-w-[1440px] mx-auto p-4 lg:p-8 flex flex-col lg:flex-row gap-8 items-start">
            <div class="w-full lg:w-72 shrink-0 sticky top-24">
                <jsp:include page="components/sidebar.jsp" />
            </div>

            <div class="flex-1 flex flex-col gap-6">
                <div class="bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-xl overflow-hidden">
                    <div class="flex border-b border-slate-200 dark:border-border-dark overflow-x-auto scrollbar-hide">
                        <button onclick="window.location.href='${pageContext.request.contextPath}/user/profile.jsp'"
                            class="px-6 py-4 text-sm font-bold text-primary border-b-2 border-primary whitespace-nowrap bg-primary/5">
                            Tổng quan
                        </button>
                        <button onclick="window.location.href='${pageContext.request.contextPath}/user/saved_articles.jsp'"
                            class="px-6 py-4 text-sm font-bold text-slate-500 dark:text-slate-400 border-b-2 border-transparent hover:text-primary transition-colors whitespace-nowrap">
                            Bài viết đã lưu
                        </button>
                        <button onclick="window.location.href='${pageContext.request.contextPath}/user/reading_history.jsp'"
                            class="px-6 py-4 text-sm font-bold text-slate-500 dark:text-slate-400 border-b-2 border-transparent hover:text-primary transition-colors whitespace-nowrap">
                            Lịch sử đọc
                        </button>
                    </div>

                    <div class="p-6 md:p-8 space-y-8">
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                            <%-- Saved Articles --%>
                            <div class="p-6 bg-white dark:bg-slate-900 border border-slate-100 dark:border-slate-800 rounded-2xl flex items-center gap-5 hover:shadow-xl hover:-translate-y-1 transition-all duration-300 border-b-4 border-b-blue-500 shadow-sm shadow-blue-500/5 group">
                                <div class="size-14 bg-blue-500/10 text-blue-500 rounded-xl flex items-center justify-center shrink-0 group-hover:scale-110 transition-transform">
                                    <span class="material-symbols-outlined text-3xl">bookmark</span>
                                </div>
                                <div>
                                    <p class="text-xs text-slate-500 dark:text-slate-400 font-black uppercase tracking-widest mb-1">Đã lưu</p>
                                    <h4 class="text-3xl font-black text-slate-900 dark:text-white leading-tight">${not empty countSaved ? countSaved : 0}</h4>
                                </div>
                            </div>
                            <%-- Reading History --%>
                            <div class="p-6 bg-white dark:bg-slate-900 border border-slate-100 dark:border-slate-800 rounded-2xl flex items-center gap-5 hover:shadow-xl hover:-translate-y-1 transition-all duration-300 border-b-4 border-b-emerald-500 shadow-sm shadow-emerald-500/5 group">
                                <div class="size-14 bg-emerald-500/10 text-emerald-500 rounded-xl flex items-center justify-center shrink-0 group-hover:scale-110 transition-transform">
                                    <span class="material-symbols-outlined text-3xl">history</span>
                                </div>
                                <div>
                                    <p class="text-xs text-slate-500 dark:text-slate-400 font-black uppercase tracking-widest mb-1">Lịch sử</p>
                                    <h4 class="text-3xl font-black text-slate-900 dark:text-white leading-tight">${not empty countRead ? countRead : 0}</h4>
                                </div>
                            </div>
                            <%-- Comments --%>
                            <div class="p-6 bg-white dark:bg-slate-900 border border-slate-100 dark:border-slate-800 rounded-2xl flex items-center gap-5 hover:shadow-xl hover:-translate-y-1 transition-all duration-300 border-b-4 border-b-purple-500 shadow-sm shadow-purple-500/5 group">
                                <div class="size-14 bg-purple-500/10 text-purple-500 rounded-xl flex items-center justify-center shrink-0 group-hover:scale-110 transition-transform">
                                    <span class="material-symbols-outlined text-3xl">forum</span>
                                </div>
                                <div>
                                    <p class="text-xs text-slate-500 dark:text-slate-400 font-black uppercase tracking-widest mb-1">Bình luận</p>
                                    <h4 class="text-3xl font-black text-slate-900 dark:text-white leading-tight">${not empty countComments ? countComments : 0}</h4>
                                </div>
                            </div>
                        </div>

                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                            <div class="space-y-6">
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center gap-2">
                                        <div class="p-2 bg-primary/10 rounded-lg">
                                            <span class="material-symbols-outlined text-primary text-xl">notifications</span>
                                        </div>
                                        <h3 class="font-bold text-slate-900 dark:text-white">Thông báo mới</h3>
                                    </div>
                                    <button onclick="markAllRead()"
                                            class="text-[11px] text-primary font-bold hover:underline uppercase tracking-wider">
                                        Đánh dấu đã đọc
                                    </button>
                                </div>
                                <div class="space-y-4">
                                    <c:choose>
                                        <c:when test="${not empty profileNotifs}">
                                            <c:forEach var="n" items="${profileNotifs}">
                                                <div class="notif-item ${not n.read ? 'unread' : ''} p-4 bg-white dark:bg-slate-800/40 border border-slate-100 dark:border-slate-700/50 rounded-xl flex items-start gap-4 hover:shadow-md transition-all cursor-pointer group border-l-2 ${not n.read ? 'border-primary' : 'border-transparent'}"
                                                     data-id="${n.id}" onclick="markRead(this)">
                                                    <div class="size-10 rounded-full ${n.bgColor} flex items-center justify-center shrink-0 group-hover:scale-110 transition-transform">
                                                        <span class="material-symbols-outlined text-lg">${n.iconClass}</span>
                                                    </div>
                                                    <div class="flex-1 min-w-0">
                                                        <div class="flex items-center justify-between gap-2">
                                                            <p class="text-sm font-bold text-slate-800 dark:text-slate-100 truncate">${n.title}</p>
                                                            <c:if test="${not n.read}">
                                                                <span class="unread-dot size-2 bg-primary rounded-full shrink-0"></span>
                                                            </c:if>
                                                        </div>
                                                        <p class="text-xs text-slate-500 dark:text-slate-400 mt-1 line-clamp-1">${n.content}</p>
                                                        <div class="flex items-center gap-3 mt-2">
                                                            <span class="text-[10px] font-medium text-slate-400">${n.timeAgo}</span>
                                                            <span class="size-1 bg-slate-300 rounded-full"></span>
                                                            <span class="text-[10px] font-bold text-primary uppercase tracking-tighter capitalize">${n.type.toLowerCase()}</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="py-12 flex flex-col items-center justify-center text-center bg-slate-50 dark:bg-slate-800/20 rounded-2xl border border-dashed border-slate-200 dark:border-slate-700">
                                                <span class="material-symbols-outlined text-4xl text-slate-300 dark:text-slate-600 mb-3">notifications_off</span>
                                                <p class="text-sm text-slate-500 dark:text-slate-400">Bạn chưa có thông báo mới nào.</p>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
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
                                
                                <div class="grid grid-cols-1 sm:grid-cols-2 gap-y-4 gap-x-8 text-sm text-slate-300/80 mb-8">
                                    <div class="flex items-center gap-3">
                                        <div class="size-6 bg-emerald-500/20 text-emerald-400 rounded-full flex items-center justify-center shrink-0">
                                            <span class="material-symbols-outlined text-sm">check</span>
                                        </div>
                                        Hỗ trợ biên tập viên ảo AI
                                    </div>
                                    <div class="flex items-center gap-3">
                                        <div class="size-6 bg-emerald-500/20 text-emerald-400 rounded-full flex items-center justify-center shrink-0">
                                            <span class="material-symbols-outlined text-sm">check</span>
                                        </div>
                                        Cơ chế thu nhập công bằng
                                    </div>
                                    <div class="flex items-center gap-3">
                                        <div class="size-6 bg-emerald-500/20 text-emerald-400 rounded-full flex items-center justify-center shrink-0">
                                            <span class="material-symbols-outlined text-sm">check</span>
                                        </div>
                                        Tiếp cận số liệu Real-time
                                    </div>
                                    <div class="flex items-center gap-3">
                                        <div class="size-6 bg-emerald-500/20 text-emerald-400 rounded-full flex items-center justify-center shrink-0">
                                            <span class="material-symbols-outlined text-sm">check</span>
                                        </div>
                                        Xây dựng thương hiệu cá nhân
                                    </div>
                                </div>
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
                                        <div class="px-10 py-6 bg-emerald-500/10 border border-emerald-500/30 text-emerald-500 font-black rounded-2xl backdrop-blur-xl flex flex-col items-center gap-1">
                                            <span class="material-symbols-outlined text-3xl">workspace_premium</span>
                                            Cấp độ Chuyên gia
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="button" onclick="openUpgradeModal()"
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
    </div>

    <div id="upgradeModal" class="fixed inset-0 z-[120] hidden overflow-y-auto">
        <div class="fixed inset-0 bg-slate-900/80 backdrop-blur-sm transition-opacity" onclick="closeUpgradeModal()"></div>
        <div class="flex min-h-full items-center justify-center p-4">
            <div class="bg-white dark:bg-slate-900 w-full max-w-lg rounded-2xl shadow-2xl relative overflow-hidden z-10" onclick="event.stopPropagation()">
                <div class="bg-gradient-to-r from-slate-900 to-primary p-6 text-white text-center">
                    <h2 class="text-2xl font-black">Đăng ký Cộng tác viên</h2>
                    <p class="text-blue-100/70 text-sm mt-1">Cung cấp thông tin để chúng tôi xem xét hồ sơ của bạn</p>
                </div>
                <form action="${pageContext.request.contextPath}/JournalistUpgradeController" method="post" class="p-6 space-y-5">
                    <div class="space-y-1.5">
                        <label class="text-xs font-bold text-slate-400 uppercase tracking-widest">Kinh nghiệm viết lách (năm)</label>
                        <input type="number" name="experience" min="0" required class="w-full h-12 px-4 bg-slate-50 dark:bg-slate-800 border-slate-200 dark:border-slate-700 rounded-xl focus:ring-2 focus:ring-primary transition-all text-slate-900 dark:text-white" placeholder="Ví dụ: 3">
                    </div>
                    <div class="space-y-1.5">
                        <label class="text-xs font-bold text-slate-400 uppercase tracking-widest">Giới thiệu ngắn / Link Portfolio</label>
                        <textarea name="bio" required rows="4" class="w-full p-4 bg-slate-50 dark:bg-slate-800 border-slate-200 dark:border-slate-700 rounded-xl focus:ring-2 focus:ring-primary transition-all text-slate-900 dark:text-white resize-none" placeholder="Mô tả các lĩnh vực bạn am hiểu hoặc dẫn link bài viết tiêu biểu..."></textarea>
                    </div>
                    <div class="flex gap-4 pt-2">
                        <button type="button" onclick="closeUpgradeModal()" class="flex-1 h-12 text-sm font-bold text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-xl transition-colors">Hủy</button>
                        <button type="submit" class="flex-1 h-12 bg-primary text-white font-bold rounded-xl shadow-lg shadow-primary/20 hover:bg-primary-dark transition-all">Gửi yêu cầu</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script>
        function openUpgradeModal() {
            document.getElementById('upgradeModal').classList.remove('hidden');
            document.body.classList.add('overflow-hidden');
        }
        function closeUpgradeModal() {
            document.getElementById('upgradeModal').classList.add('hidden');
            document.body.classList.remove('overflow-hidden');
        }
    </script>
    <script>
        // Hide notifications after 5 seconds
        setTimeout(() => {
            const toasts = document.querySelectorAll('[id^="toast-"]');
            toasts.forEach(toast => {
                toast.classList.add('opacity-0', 'translate-y-10', 'transition-all', 'duration-500');
                setTimeout(() => toast.remove(), 500);
            });
        }, 5000);
    </script>
</body>
</html>