<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="neuralnews.dao.NotificationDao" %>
<%@ page import="neuralnews.model.Notification" %>
<%@ page import="java.util.List" %>
<%@ page import="neuralnews.model.User" %>

<%
    String contextPath = request.getContextPath();
    User _u = (User) session.getAttribute("currentUser");
    long _uid = (_u != null) ? _u.getId() : -1;
    NotificationDao _notifDao = new NotificationDao();
    List<Notification> _notifs = (_uid > 0) ? _notifDao.getNotificationsByUserId(_uid) : new java.util.ArrayList<>();
    int _unreadCount = (_uid > 0) ? _notifDao.getUnreadCount(_uid) : 0;
%>
<header class="sticky top-0 z-[10000] w-full h-16 border-b border-border-light dark:border-border-dark bg-white/95 dark:bg-background-dark/95 backdrop-blur-md transition-all duration-200">
    <div class="max-w-full mx-auto px-8 h-full flex items-center justify-between gap-4">
        <div class="flex items-center gap-6">
            <!-- Back Button -->
            <% if (request.getParameter("backUrl") != null) { %>
                <a class="flex items-center gap-2 text-slate-400 hover:text-primary transition-colors group"
                   href="<%= request.getParameter("backUrl") %>">
                    <span class="material-symbols-outlined text-xl transition-transform group-hover:-translate-x-1">arrow_back</span>
                    <span class="hidden lg:inline text-xs font-bold uppercase tracking-wider">Quay lại</span>
                </a>
                <div class="h-5 w-px bg-slate-200 dark:bg-slate-700"></div>
            <% } %>

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
                        <%= request.getParameter("pageTitle") != null ? request.getParameter("pageTitle") : "Dữ liệu" %>
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
                    <% if (_unreadCount > 0) { %>
                        <span id="notifDot" class="absolute top-1 right-1 size-2 bg-red-500 rounded-full border-2 border-white dark:border-background-dark"></span>
                    <% } %>
                </button>
                <div id="notifPanel" class="hidden absolute right-0 top-full mt-2 w-80 bg-white dark:bg-slate-900 border border-slate-200 dark:border-border-dark rounded-xl shadow-xl overflow-hidden z-[10001] animate-in fade-in slide-in-from-top-2 duration-200">
                    <div class="flex items-center justify-between px-4 py-3 border-b border-slate-100 dark:border-slate-800 bg-slate-50/50 dark:bg-slate-800/30">
                        <div class="flex items-center gap-2">
                            <span class="text-sm font-bold text-slate-900 dark:text-white">Thông báo</span>
                            <span id="notifCount" class="bg-primary/10 text-primary text-[10px] font-bold px-1.5 py-0.5 rounded-full"><%= _unreadCount %></span>
                        </div>
                        <button id="markAllRead" onclick="markAllRead()" class="text-[11px] text-primary font-bold hover:underline uppercase tracking-wider">Đánh dấu đã đọc</button>
                    </div>
                    <ul id="notifList" class="max-h-80 overflow-y-auto divide-y divide-slate-100 dark:divide-border-dark custom-scrollbar">
                        <% if (_notifs.isEmpty()) { %>
                            <div class="p-8 text-center text-slate-400">
                                <span class="material-symbols-outlined text-[48px] mb-2">notifications_off</span>
                                <p class="text-xs">Không có thông báo mới.</p>
                            </div>
                        <% } else { %>
                            <% for (Notification n : _notifs) { %>
                                <li class="notif-item <%= !n.isRead()?"unread":"" %> flex items-start gap-3 px-4 py-3 hover:bg-slate-50 dark:hover:bg-slate-800/60 cursor-pointer transition-colors border-l-2 <%= !n.isRead()?"border-primary":"border-transparent" %>" 
                                    data-id="<%= n.getId() %>" data-url="<%= n.getUrl() %>" onclick="markRead(this)">

                                    <div class="flex-1 min-w-0">
                                        <p class="text-xs font-bold text-slate-800 dark:text-white leading-tight"><%= n.getTitle() %></p>
                                        <p class="text-[11px] text-slate-500 mt-1 line-clamp-2"><%= n.getContent() %></p>
                                        <p class="text-[10px] text-slate-400 mt-1"><%= n.getTimeAgo() %></p>
                                    </div>
                                    <% if (!n.isRead()) { %>
                                        <span class="unread-dot size-2 bg-primary rounded-full shrink-0 mt-2"></span>
                                    <% } %>
                                </li>
                            <% } %>
                        <% } %>
                    </ul>
                </div>
            </div>

            <!-- Theme Toggle -->
            <button id="themeToggleBtn" onclick="window.toggleTheme()" class="p-1.5 text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-full transition-colors group">
                <span class="material-symbols-outlined text-[22px] group-hover:text-orange-500 hidden dark:block">light_mode</span>
                <span class="material-symbols-outlined text-[22px] group-hover:text-primary block dark:hidden">dark_mode</span>
            </button>

            <!-- Profile -->
            <% if (_u != null) { %>
                <div class="h-6 w-px bg-slate-200 dark:bg-slate-700 mx-1"></div>
                <div class="relative group" tabindex="0">
                    <button class="flex items-center gap-2 p-1 rounded-full hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors">
                        <div class="size-8 rounded-full bg-primary flex items-center justify-center text-white text-[10px] font-black border-2 border-white dark:border-slate-700 shadow-sm overflow-hidden">
                            <% 
                                String _headerAvatar = (_u != null) ? _u.getAvatarUrl() : null;
                                if (_headerAvatar != null && !_headerAvatar.isBlank()) { 
                                    if (!(_headerAvatar.startsWith("http") || _headerAvatar.startsWith("https"))) {
                                        _headerAvatar = contextPath + "/" + _headerAvatar;
                                    }
                            %>
                                <img src="<%= _headerAvatar %>" class="size-full object-cover">
                            <% } else { %>
                                <%= _u != null && _u.getFullName() != null && _u.getFullName().length() >= 2 ? _u.getFullName().substring(0, 2).toUpperCase() : "US" %>
                            <% } %>
                        </div>
                    </button>
                    <div class="hidden group-focus-within:block absolute right-0 top-full mt-2 w-56 bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-xl shadow-xl z-50 overflow-hidden py-1">
                        <div class="px-4 py-3 border-b border-slate-100 dark:border-slate-800">
                            <p class="text-xs font-bold text-slate-900 dark:text-white"><%= _u.getFullName() %></p>
                            <p class="text-[10px] text-slate-500 truncate capitalize">
                                <%= (_u.getRole() != null) ? _u.getRole().getName().toLowerCase() : "nhà báo" %>
                            </p>
                        </div>
                        <a href="<%= contextPath %>/home" class="flex items-center gap-3 px-4 py-2.5 text-xs font-bold text-slate-600 dark:text-slate-200 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors">
                            <span class="material-symbols-outlined text-[18px]">home</span>
                            Về trang chủ
                        </a>
                        <a href="<%= contextPath %>/auth/logout.jsp" class="flex items-center gap-3 px-4 py-2.5 text-xs font-bold text-red-500 hover:bg-red-50 dark:hover:bg-red-950/30 transition-colors">
                            <span class="material-symbols-outlined text-[18px]">logout</span>
                            Đăng xuất
                        </a>
                    </div>
                </div>
            <% } %>
        </div>
    </div>
</header>
<script>
    var contextPath = '<%= contextPath %>';
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
