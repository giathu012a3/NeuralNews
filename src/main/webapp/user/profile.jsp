<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="neuralnews.dao.NotificationDao" %>
<%@ page import="neuralnews.model.Notification" %>
<%@ page import="java.util.List" %>

<c:if test="${empty sessionScope.currentUser}">
    <c:redirect url="/auth/login.jsp" />
</c:if>

<jsp:useBean id="articleDao" class="neuralnews.dao.ArticleDao" />
<jsp:useBean id="commentDao" class="neuralnews.dao.CommentDao" />

<%
    Object _uidObj = session.getAttribute("userId");
    if (_uidObj != null) {
        try {
            long _profUid = -1;
            if (_uidObj instanceof Long) _profUid = (Long)_uidObj;
            else if (_uidObj instanceof Integer) _profUid = ((Integer)_uidObj).longValue();
            else if (_uidObj instanceof String) _profUid = Long.parseLong((String)_uidObj);
            
            if (_profUid > 0) {
                NotificationDao _notifDao = new NotificationDao();
                
                int _limit = 5; // Display 5 notifications per page
                int _currPage = 1;
                String _pStr = request.getParameter("page");
                if (_pStr != null) try { _currPage = Integer.parseInt(_pStr); } catch(Exception e) {}
                if (_currPage < 1) _currPage = 1;
                
                int _offset = (_currPage - 1) * _limit;
                int _totalNotifs = _notifDao.countTotal(_profUid);
                int _totalPages = (int) Math.ceil((double) _totalNotifs / _limit);
                if (_totalPages < 1) _totalPages = 1;
                if (_currPage > _totalPages) _currPage = _totalPages;

                List<Notification> _pNotifs = _notifDao.getNotificationsByUserId(_profUid, _limit, _offset);
                request.setAttribute("profileNotifs", _pNotifs);
                request.setAttribute("totalNotifPages", _totalPages);
                request.setAttribute("currNotifPage", _currPage);
                
                request.setAttribute("countSaved", articleDao.countSavedByUser(_profUid));
                request.setAttribute("countRead", articleDao.countReadByUser(_profUid));
                request.setAttribute("countComments", commentDao.countCommentsByUser(_profUid));
            }
        } catch(Exception e) { e.printStackTrace(); }
    }
%>

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
                        <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                            <div class="p-5 bg-slate-50 dark:bg-background-dark/50 border border-slate-200 dark:border-border-dark rounded-xl flex items-center gap-4">
                                <div class="size-12 bg-blue-500/10 text-blue-500 rounded-full flex items-center justify-center">
                                    <span class="material-symbols-outlined">bookmark</span>
                                </div>
                                <div>
                                    <p class="text-2xl font-black text-slate-900 dark:text-white leading-tight">${not empty countSaved ? countSaved : 0}</p>
                                    <p class="text-xs text-slate-500 uppercase font-bold tracking-wider">Bài viết đã lưu</p>
                                </div>
                            </div>
                            <div class="p-5 bg-slate-50 dark:bg-background-dark/50 border border-slate-200 dark:border-border-dark rounded-xl flex items-center gap-4">
                                <div class="size-12 bg-green-500/10 text-green-500 rounded-full flex items-center justify-center">
                                    <span class="material-symbols-outlined">visibility</span>
                                </div>
                                <div>
                                    <p class="text-2xl font-black text-slate-900 dark:text-white leading-tight">${not empty countRead ? countRead : 0}</p>
                                    <p class="text-xs text-slate-500 uppercase font-bold tracking-wider">Bài viết đã đọc</p>
                                </div>
                            </div>
                            <div class="p-5 bg-slate-50 dark:bg-background-dark/50 border border-slate-200 dark:border-border-dark rounded-xl flex items-center gap-4">
                                <div class="size-12 bg-purple-500/10 text-purple-500 rounded-full flex items-center justify-center">
                                    <span class="material-symbols-outlined">chat_bubble</span>
                                </div>
                                <div>
                                    <p class="text-2xl font-black text-slate-900 dark:text-white leading-tight">${not empty countComments ? countComments : 0}</p>
                                    <p class="text-xs text-slate-500 uppercase font-bold tracking-wider">Bình luận</p>
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
                                <c:if test="${totalNotifPages > 1}">
                                    <div class="flex items-center justify-between border-t border-slate-100 dark:border-slate-700/50 pt-6">
                                        <p class="text-xs text-slate-500">Trang <span class="font-bold">${currNotifPage}</span> / ${totalNotifPages}</p>
                                        <div class="flex items-center gap-1">
                                            <a href="?page=${currNotifPage - 1}" 
                                               class="${currNotifPage == 1 ? 'pointer-events-none opacity-50' : ''} size-8 flex items-center justify-center rounded-lg border border-slate-200 dark:border-slate-700 text-slate-600 dark:text-slate-400 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors">
                                                <span class="material-symbols-outlined text-[18px]">chevron_left</span>
                                            </a>
                                            <c:forEach var="i" begin="1" end="${totalNotifPages}">
                                                <a href="?page=${i}" 
                                                   class="size-8 flex items-center justify-center rounded-lg text-xs font-bold transition-all ${i == currNotifPage ? 'bg-primary text-white shadow-sm shadow-primary/30' : 'border border-slate-200 dark:border-slate-700 text-slate-600 dark:text-slate-400 hover:bg-slate-50 dark:hover:bg-slate-800'}">
                                                    ${i}
                                                </a>
                                            </c:forEach>
                                            <a href="?page=${currNotifPage + 1}" 
                                               class="${currNotifPage == totalNotifPages ? 'pointer-events-none opacity-50' : ''} size-8 flex items-center justify-center rounded-lg border border-slate-200 dark:border-slate-700 text-slate-600 dark:text-slate-400 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors">
                                                <span class="material-symbols-outlined text-[18px]">chevron_right</span>
                                            </a>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
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
    </div>

    <!-- Upgrade Modal -->
    <div id="upgradeModal" class="fixed inset-0 z-[100] flex items-center justify-center p-4 hidden">
        <div class="fixed inset-0 bg-slate-900/80 backdrop-blur-sm" onclick="this.parentElement.classList.add('hidden')"></div>
        <div class="bg-white dark:bg-slate-900 w-full max-w-lg rounded-2xl shadow-2xl relative overflow-hidden z-10 animate-in fade-in zoom-in duration-300">
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
                    <textarea name="bio" required rows="4" class="w-full p-4 bg-slate-50 dark:bg-slate-800 border-slate-200 dark:border-slate-700 rounded-xl focus:ring-2 focus:ring-primary transition-all text-slate-900 dark:text-white resize-none" placeholder="Mô tả các lĩnh vực bạn am hiểu..."></textarea>
                </div>
                <div class="flex gap-4 pt-2">
                    <button type="button" onclick="document.getElementById('upgradeModal').classList.add('hidden')" class="flex-1 h-12 text-sm font-bold text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-xl transition-colors">Hủy</button>
                    <button type="submit" class="flex-1 h-12 bg-primary text-white font-bold rounded-xl shadow-lg shadow-primary/20 hover:bg-primary-dark transition-all">Gửi yêu cầu</button>
                </div>
            </form>
        </div>
        <script>
            // Hide notifications after 5 seconds
            setTimeout(() => {
                const toasts = document.querySelectorAll('[id^="toast-"], .animate-in');
                toasts.forEach(toast => {
                    toast.classList.add('opacity-0', 'translate-y-10', 'transition-all', 'duration-500');
                    setTimeout(() => toast.remove(), 500);
                });
            }, 5000);
        </script>
    </div>
</body>
</html>