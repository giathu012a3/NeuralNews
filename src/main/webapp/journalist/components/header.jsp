<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<jsp:useBean id="notifDao" class="neuralnews.dao.NotificationDao" scope="page" />
<c:if test="${not empty sessionScope.currentUser}">
    <c:set var="u" value="${sessionScope.currentUser}" />
    <c:set var="notifications" value="${notifDao.getNotificationsByUserId(u.id)}" />
    <c:set var="unreadCount" value="${notifDao.getUnreadCount(u.id)}" />
</c:if>

<header class="sticky top-0 z-[10000] w-full h-16 border-b border-border-light dark:border-border-dark bg-white/95 dark:bg-background-dark/95 backdrop-blur-md transition-all duration-200">
    <div class="max-w-full mx-auto px-8 h-full flex items-center justify-between gap-4">
        <div class="flex items-center gap-6">
            <!-- Back Button -->
            <c:if test="${not empty param.backUrl}">
                <a class="flex items-center gap-2 text-slate-400 hover:text-primary transition-colors group"
                   href="${param.backUrl}">
                    <span class="material-symbols-outlined text-xl transition-transform group-hover:-translate-x-1">arrow_back</span>
                    <span class="hidden lg:inline text-xs font-bold uppercase tracking-wider">Quay lại</span>
                </a>
                <div class="h-5 w-px bg-slate-200 dark:bg-slate-700"></div>
            </c:if>

            <!-- Branding & Title -->
            <div class="flex items-center gap-4">
                <a class="flex items-center gap-2 group" href="${pageContext.request.contextPath}/home">
                    <div class="flex items-center justify-center size-8 rounded bg-primary text-white shadow-sm shadow-primary/20">
                        <span class="material-symbols-outlined text-[18px]">newsmode</span>
                    </div>
                    <span class="text-lg font-extrabold tracking-tight hidden sm:block text-slate-900 dark:text-white">Nexus<span class="text-primary">AI</span></span>
                </a>
                <div class="h-5 w-px bg-slate-200 dark:bg-slate-700"></div>
                <div class="flex items-center gap-2">
                    <h2 class="text-sm font-bold text-slate-800 dark:text-white whitespace-nowrap">Cổng Nhà báo</h2>
                    <span class="material-symbols-outlined text-slate-400 text-sm">chevron_right</span>
                    <span class="text-xs font-medium text-primary bg-primary/5 px-2 py-0.5 rounded-full border border-primary/10">
                        <c:out value="${not empty param.pageTitle ? param.pageTitle : 'Dữ liệu'}" />
                    </span>
                </div>
            </div>
        </div>

        <div class="flex items-center gap-3">
            <!-- Extra Slot for custom buttons -->
            <div id="headerExtraSlot" class="flex items-center gap-3 mr-2"></div>

            <!-- Notifications -->
            <div class="relative" id="notifWrapper">
                <button type="button" onclick="toggleNotifPanel(event)" class="relative p-1.5 text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-full transition-colors focus:outline-none">
                    <span class="material-symbols-outlined text-[22px]">notifications</span>
                    <c:if test="${unreadCount > 0}">
                        <span id="notifDot" class="absolute top-1 right-1 size-2 bg-red-500 rounded-full border-2 border-white dark:border-background-dark"></span>
                    </c:if>
                </button>
                <div id="notifPanel" class="hidden absolute right-0 top-full mt-2 w-80 bg-white dark:bg-slate-900 border border-slate-200 dark:border-border-dark rounded-xl shadow-xl overflow-hidden z-[10001] animate-in fade-in slide-in-from-top-2 duration-200">
                    <div class="flex items-center justify-between px-4 py-3 border-b border-slate-100 dark:border-slate-800 bg-slate-50/50 dark:bg-slate-800/30">
                        <div class="flex items-center gap-2">
                            <span class="text-sm font-bold text-slate-900 dark:text-white">Thông báo</span>
                            <span id="notifCount" class="bg-primary/10 text-primary text-[10px] font-bold px-1.5 py-0.5 rounded-full">${unreadCount}</span>
                        </div>
                        <button id="markAllRead" onclick="markAllRead()" class="text-[11px] text-primary font-bold hover:underline uppercase tracking-wider">Đánh dấu đã đọc</button>
                    </div>
                    <ul id="notifList" class="max-h-80 overflow-y-auto divide-y divide-slate-100 dark:divide-border-dark custom-scrollbar">
                        <c:choose>
                            <c:when test="${empty notifications}">
                                <div class="p-8 text-center text-slate-400">
                                    <span class="material-symbols-outlined text-[48px] mb-2">notifications_off</span>
                                    <p class="text-xs">Không có thông báo mới.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="n" items="${notifications}">
                                    <li class="notif-item ${!n.isRead() ? 'unread' : ''} flex items-start gap-3 px-4 py-3 hover:bg-slate-50 dark:hover:bg-slate-800/60 cursor-pointer transition-colors border-l-2 ${!n.isRead() ? 'border-primary' : 'border-transparent'}" 
                                        data-id="${n.id}" data-url="${n.url}" onclick="markRead(this)">

                                        <div class="flex-1 min-w-0">
                                            <p class="text-xs font-bold text-slate-800 dark:text-white leading-tight">${n.title}</p>
                                            <p class="text-[11px] text-slate-500 mt-1 line-clamp-2">${n.content}</p>
                                            <p class="text-[10px] text-slate-400 mt-1">${n.timeAgo}</p>
                                        </div>
                                        <c:if test="${!n.isRead()}">
                                            <span class="unread-dot size-2 bg-primary rounded-full shrink-0 mt-2"></span>
                                        </c:if>
                                    </li>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </ul>
                </div>
            </div>

            <!-- Theme Toggle -->
            <button id="themeToggleBtn" onclick="window.toggleTheme()" class="p-1.5 text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-full transition-colors group">
                <span class="material-symbols-outlined text-[22px] group-hover:text-orange-500 hidden dark:block">light_mode</span>
                <span class="material-symbols-outlined text-[22px] group-hover:text-primary block dark:hidden">dark_mode</span>
            </button>

            <!-- Profile -->
            <c:if test="${not empty sessionScope.currentUser}">
                <c:set var="u" value="${sessionScope.currentUser}" />
                <div class="h-6 w-px bg-slate-200 dark:bg-slate-700 mx-1"></div>
                <div class="relative group" tabindex="0">
                    <button class="flex items-center gap-2 p-1 rounded-full hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors">
                        <div class="size-8 rounded-full bg-primary flex items-center justify-center text-white text-[10px] font-black border-2 border-white dark:border-slate-700 shadow-sm overflow-hidden">
                            <c:choose>
                                <c:when test="${not empty u.avatarUrl}">
                                    <c:set var="headerAvatar" value="${u.avatarUrl}" />
                                    <c:if test="${!(fn:startsWith(headerAvatar, 'http') || fn:startsWith(headerAvatar, 'https'))}">
                                        <c:set var="headerAvatar" value="${pageContext.request.contextPath}/${headerAvatar}" />
                                    </c:if>
                                    <img src="${headerAvatar}" class="size-full object-cover">
                                </c:when>
                                <c:otherwise>
                                    ${fn:toUpperCase(fn:substring(u.fullName, 0, 2))}
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </button>
                    <div class="hidden group-focus-within:block absolute right-0 top-full mt-2 w-56 bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-xl shadow-xl z-50 overflow-hidden py-1">
                        <div class="px-4 py-3 border-b border-slate-100 dark:border-slate-800">
                            <p class="text-xs font-bold text-slate-900 dark:text-white">${u.fullName}</p>
                            <p class="text-[10px] text-slate-500 truncate capitalize">
                                <c:choose>
                                    <c:when test="${u.role.name == 'ADMIN'}">Quản trị viên</c:when>
                                    <c:when test="${u.role.name == 'JOURNALIST'}">Nhà báo</c:when>
                                    <c:otherwise>Người dùng</c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                        <a href="${pageContext.request.contextPath}/home" class="flex items-center gap-3 px-4 py-2.5 text-xs font-bold text-slate-600 dark:text-slate-200 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors">
                            <span class="material-symbols-outlined text-[18px]">home</span>
                            Về trang chủ
                        </a>
                        <a href="${pageContext.request.contextPath}/auth/logout.jsp" class="flex items-center gap-3 px-4 py-2.5 text-xs font-bold text-red-500 hover:bg-red-50 dark:hover:bg-red-950/30 transition-colors">
                            <span class="material-symbols-outlined text-[18px]">logout</span>
                            Đăng xuất
                        </a>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</header>
<script>
    var contextPath = '${pageContext.request.contextPath}';
    function updateBadge() {
        var count = document.querySelectorAll('.notif-item.unread').length;
        var dot = document.getElementById('notifDot');
        var badge = document.getElementById('notifCount');
        if (count > 0) {
            if (dot) dot.style.display = 'block';
            if (badge) { badge.textContent = count; badge.style.display = 'inline-flex'; }
        } else {
            if (dot) dot.style.display = 'none';
            if (badge) badge.style.display = 'none';
        }
    }

    function markRead(el) {
        const nurl = el.getAttribute('data-url');
        let finalUrl = null;
        if (nurl && nurl !== 'null' && nurl.trim() !== '') {
            finalUrl = nurl;
            if (!nurl.startsWith('http')) {
               finalUrl = contextPath + (nurl.startsWith('/') ? nurl : '/' + nurl);
            }
        }

        if (el.classList.contains('unread')) {
            el.classList.remove('unread');
            el.style.borderLeftColor = 'transparent';
            el.querySelector('.unread-dot')?.remove();
            
            const nid = el.getAttribute('data-id');
            if (nid) {
                fetch(contextPath + '/notification-ajax', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'action=markRead&id=' + encodeURIComponent(nid)
                }).then(() => {
                    if(finalUrl) window.location.href = finalUrl;
                }).catch(e => {
                    console.error(e);
                    if(finalUrl) window.location.href = finalUrl;
                });
            } else {
                if(finalUrl) window.location.href = finalUrl;
            }
            updateBadge();
        } else {
            if(finalUrl) window.location.href = finalUrl;
        }
    }

    function markAllRead() {
        document.querySelectorAll('.notif-item.unread').forEach(el => {
            el.classList.remove('unread');
            el.style.borderLeftColor = 'transparent';
            el.querySelector('.unread-dot')?.remove();
        });
        updateBadge();
        
        fetch(contextPath + '/notification-ajax', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'action=markAllRead'
        }).catch(e => console.error(e));
    }

    function toggleNotifPanel(e) {
        if (e) {
            e.stopPropagation();
            e.preventDefault();
        }
        const panel = document.getElementById('notifPanel');
        if (panel) {
            const isHidden = panel.classList.contains('hidden');
            // Force hide all other dropdowns if any (optional, but good for UX)
            // For now just toggle this one
            panel.classList.toggle('hidden');
        }
    }

    // Close notifications when clicking outside
    document.addEventListener('click', (e) => {
        const panel = document.getElementById('notifPanel');
        const wrapper = document.getElementById('notifWrapper');
        if (panel && !panel.classList.contains('hidden')) {
            if (wrapper && !wrapper.contains(e.target)) {
                panel.classList.add('hidden');
            }
        }
    });

    document.addEventListener('DOMContentLoaded', function() {
        updateBadge();
    });
</script>
