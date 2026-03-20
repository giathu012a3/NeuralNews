<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="neuralnews.dao.NotificationDao" %>

<c:if test="${empty listCategory}">
    <% 
        neuralnews.dao.CategoryDao headerCatDao = new neuralnews.dao.CategoryDao();
        request.setAttribute("listCategory", headerCatDao.getAllCategory());
    %>
</c:if>

<c:set var="u" value="${sessionScope.currentUser}" />
<c:set var="uid" value="${not empty u ? u.id : -1}" />

<%
    long _uidNum = (Long) pageContext.getAttribute("uid");
    if (_uidNum > 0) {
        NotificationDao _notifDao = new NotificationDao();
        pageContext.setAttribute("notifs", _notifDao.getNotificationsByUserId(_uidNum));
        pageContext.setAttribute("unreadCount", _notifDao.getUnreadCount(_uidNum));
    } else {
        pageContext.setAttribute("unreadCount", 0);
    }
%>

<header class="sticky top-0 z-[10000] w-full border-b border-border-light dark:border-border-dark bg-white/95 dark:bg-background-dark/95 backdrop-blur-md">
    <div class="max-w-[1440px] mx-auto px-4 lg:px-8 h-16 flex items-center justify-between gap-4">
        <a class="flex items-center gap-2 group" href="${pageContext.request.contextPath}/home">
            <div class="flex items-center justify-center size-9 rounded bg-primary text-white group-hover:bg-primary-dark transition-colors">
                <span class="material-symbols-outlined text-[22px]">newsmode</span>
            </div>
            <h1 class="text-xl font-extrabold tracking-tight text-slate-900 dark:text-white">Nexus<span class="text-primary">AI</span></h1>
        </a>
        <nav class="hidden lg:flex items-center gap-8">
            <jsp:include page="Category.jsp" />
        </nav>
        <div class="flex items-center gap-4 flex-1 lg:flex-none justify-end">
            <c:if test="${param.hideSearch ne 'true'}">
            <div class="relative hidden md:flex items-center w-full max-w-xs group search-container">
                <span class="absolute left-3 text-slate-400 material-symbols-outlined text-[20px] group-focus-within:text-primary">search</span>
                <input id="ajaxSearchInput" autocomplete="off" class="w-full h-10 pl-10 pr-10 bg-slate-100 dark:bg-surface-dark border-transparent focus:border-primary focus:bg-white dark:focus:bg-surface-dark focus:ring-0 rounded-full text-sm transition-all"
                    placeholder="Tìm kiếm tin tức bằng AI..." type="text" />
                <button id="searchClearBtn" class="hidden absolute right-10 text-slate-400 hover:text-red-500 material-symbols-outlined text-[18px]">close</button>
                <span class="absolute right-3 text-primary material-symbols-outlined text-[18px]" title="AI Enhanced">auto_awesome</span>
                
                <!-- Results Container -->
                <div id="ajaxSearchResults" class="hidden absolute top-full left-0 right-0 mt-2 bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-xl shadow-xl z-[100] overflow-hidden animate-in fade-in slide-in-from-top-2 duration-200">
                    <div id="searchLoading" class="hidden p-4 text-center text-slate-400 text-xs flex items-center justify-center gap-2">
                         <div class="size-3 border-2 border-primary border-t-transparent rounded-full animate-spin"></div>
                         Đang tìm kiếm...
                    </div>
                    <div id="searchResultsList" class="divide-y divide-slate-100 dark:divide-slate-800 max-h-[400px] overflow-y-auto custom-scrollbar"></div>
                    <div id="searchNoResults" class="hidden p-8 text-center text-slate-400">
                         <span class="material-symbols-outlined text-[32px] mb-2">search_off</span>
                         <p class="text-xs">Không tìm thấy bài báo nào phù hợp.</p>
                    </div>
                </div>
            </div>
            </c:if>
            <div class="flex items-center gap-3 border-l border-slate-200 dark:border-slate-700 pl-4">
                <button onclick="window.toggleTheme()" class="relative p-1.5 text-slate-500 hover:bg-slate-100 dark:hover:bg-surface-dark rounded-full transition-colors group" title="Toggle theme">
                    <span class="material-symbols-outlined text-[22px] group-hover:text-orange-500 hidden dark:block">light_mode</span>
                    <span class="material-symbols-outlined text-[22px] group-hover:text-primary block dark:hidden">dark_mode</span>
                </button>
                
                <!-- Notification Dropdown -->
                <div class="relative" id="notifWrapper">
                    <button type="button" onclick="toggleNotifPanel(event)" class="relative p-1.5 text-slate-500 hover:bg-slate-100 dark:hover:bg-surface-dark rounded-full transition-colors focus:outline-none">
                        <span class="material-symbols-outlined text-[22px]">notifications</span>
                        <c:if test="${unreadCount > 0}">
                            <span id="notifDot" class="absolute top-1 right-1 size-2 bg-red-500 rounded-full border border-white dark:border-background-dark"></span>
                        </c:if>
                    </button>
                    <div id="notifPanel" class="hidden absolute right-0 top-full mt-2 w-80 bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-xl shadow-xl z-[10001] overflow-hidden animate-in fade-in slide-in-from-top-2 duration-200">
                        <div class="p-4 border-b border-slate-100 dark:border-slate-800 flex justify-between items-center bg-slate-50/50 dark:bg-slate-800/30">
                            <div class="flex items-center gap-2">
                                <h3 class="text-sm font-bold text-slate-900 dark:text-white">Thông báo</h3>
                                <span id="notifCount" class="bg-primary/10 text-primary text-[10px] font-bold px-1.5 py-0.5 rounded-full">${unreadCount}</span>
                            </div>
                            <button onclick="markAllRead()" class="text-[10px] font-bold text-primary hover:underline uppercase tracking-wider">Đánh dấu đã đọc</button>
                        </div>
                        <div id="notifList" class="max-h-[320px] overflow-y-auto divide-y divide-slate-100 dark:divide-slate-800 custom-scrollbar">
                            <c:choose>
                                <c:when test="${empty notifs}">
                                    <div class="p-8 text-center text-slate-400">
                                        <span class="material-symbols-outlined text-[48px] mb-2">notifications_off</span>
                                        <p class="text-xs">Bạn không có thông báo nào.</p>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="n" items="${notifs}">
                                        <div class="notif-item ${not n.read ? 'unread' : ''} p-4 hover:bg-slate-50 dark:hover:bg-slate-800/40 cursor-pointer transition-colors flex items-start gap-4 border-l-2 ${not n.read ? 'border-primary' : 'border-transparent'}" 
                                             data-id="${n.id}" data-url="${n.url}" onclick="markRead(this)">

                                            <div class="flex-1 min-w-0">
                                                <p class="text-sm font-bold text-slate-900 dark:text-white">${n.title}</p>
                                                <p class="text-[11px] text-slate-500 mt-1 line-clamp-2">${n.content}</p>
                                                <p class="text-[10px] text-slate-400 mt-1">${n.timeAgo}</p>
                                            </div>
                                            <c:if test="${not n.read}">
                                                <span class="unread-dot size-2 bg-primary rounded-full shrink-0 mt-2"></span>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${not empty sessionScope.userName}">
                        <div class="profile-dropdown-container relative flex items-center outline-none" tabindex="0">
                            <div class="size-10 rounded-full p-0.5 hover:bg-slate-100 dark:hover:bg-surface-dark active:bg-slate-200 dark:active:bg-slate-800 transition-colors cursor-pointer flex items-center justify-center">
                                <div class="size-full rounded-full bg-slate-200 overflow-hidden border-2 border-white dark:border-slate-700 shadow-sm">
                                    <c:set var="avatar" value="${sessionScope.avatarUrl}" />
                                    <c:if test="${empty avatar}">
                                        <c:set var="avatar" value="${u.avatarUrl}" />
                                    </c:if>
                                    <c:if test="${empty avatar}">
                                        <c:set var="avatar" value="https://ui-avatars.com/api/?name=${sessionScope.userName}&background=0D8ABC&color=fff" />
                                    </c:if>
                                    <c:if test="${not (avatar.startsWith('http') || avatar.startsWith('https'))}">
                                        <c:set var="avatar" value="${pageContext.request.contextPath}/${avatar}" />
                                    </c:if>
                                    <img alt="${sessionScope.userName}" src="${avatar}" class="size-full object-cover">
                                </div>
                            </div>
                            <div class="profile-dropdown hidden absolute right-0 top-full mt-2 w-64 bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-xl shadow-xl overflow-visible z-50 dropdown-arrow">
                                <div class="p-4 border-b border-slate-100 dark:border-slate-700">
                                    <p class="text-sm font-bold text-slate-900 dark:text-white">${sessionScope.userName}</p>
                                    <p class="text-xs text-slate-500 dark:text-slate-400 capitalize">${sessionScope.userRole.toLowerCase()}</p>
                                </div>
                                <div class="py-2">
                                    <a class="flex items-center gap-3 px-4 py-2.5 text-sm text-slate-700 dark:text-slate-200 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors"
                                        href="${pageContext.request.contextPath}/user/profile.jsp">
                                        <span class="material-symbols-outlined text-xl text-slate-400">person</span>
                                        Hồ sơ của tôi
                                    </a>
                                    <c:choose>
                                        <c:when test="${sessionScope.userRole eq 'ADMIN'}">
                                            <a class="flex items-center justify-between px-4 py-2.5 text-sm text-slate-700 dark:text-slate-200 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors"
                                                href="${pageContext.request.contextPath}/admin/home.jsp">
                                                <div class="flex items-center gap-3">
                                                    <span class="material-symbols-outlined text-xl text-slate-400">shield_person</span>
                                                    Bảng điều khiển Admin
                                                </div>
                                                <span class="bg-red-500/10 text-red-500 text-[10px] font-bold px-1.5 py-0.5 rounded border border-red-500/20 uppercase">Admin</span>
                                            </a>
                                        </c:when>
                                        <c:when test="${sessionScope.userRole eq 'JOURNALIST'}">
                                            <a class="flex items-center justify-between px-4 py-2.5 text-sm text-slate-700 dark:text-slate-200 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors"
                                                href="${pageContext.request.contextPath}/journalist/home.jsp">
                                                <div class="flex items-center gap-3">
                                                    <span class="material-symbols-outlined text-xl text-slate-400">dashboard_customize</span>
                                                    Bảng điều khiển Nhà báo
                                                </div>
                                                <span class="bg-primary/10 text-primary text-[10px] font-bold px-1.5 py-0.5 rounded border border-primary/20 uppercase">Pro</span>
                                            </a>
                                        </c:when>
                                    </c:choose>
                                    <a class="flex items-center gap-3 px-4 py-2.5 text-sm text-slate-700 dark:text-slate-200 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors"
                                        href="${pageContext.request.contextPath}/user/settings.jsp">
                                        <span class="material-symbols-outlined text-xl text-slate-400">settings</span>
                                        Cài đặt tài khoản
                                    </a>
                                </div>
                                <div class="border-t border-slate-100 dark:border-slate-700 py-2">
                                    <a class="flex items-center gap-3 px-4 py-2.5 text-sm text-red-500 hover:bg-red-50 dark:hover:bg-red-950/30 transition-colors"
                                        href="${pageContext.request.contextPath}/logout">
                                        <span class="material-symbols-outlined text-xl">logout</span>
                                        Đăng xuất
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="flex items-center gap-2">
                            <a href="${pageContext.request.contextPath}/auth/login.jsp"
                                class="px-4 py-2 text-sm font-semibold text-slate-600 dark:text-slate-300 hover:text-primary dark:hover:text-primary transition-colors">
                                Đăng nhập
                            </a>
                            <a href="${pageContext.request.contextPath}/auth/register.jsp"
                                class="px-4 py-2 text-sm font-semibold text-white bg-primary hover:bg-primary-dark rounded-full transition-colors shadow-sm shadow-primary/30">
                                Đăng ký
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</header>

<script src="${pageContext.request.contextPath}/assets/js/header.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        initHeader('${pageContext.request.contextPath}');
    });
</script>