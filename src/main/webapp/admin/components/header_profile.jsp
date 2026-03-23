<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="neuralnews.dao.NotificationDao" %>
<%@ page import="neuralnews.model.Notification" %>
<%@ page import="java.util.List" %>
<%@ page import="neuralnews.model.User" %>

<%
    String _contextPath = request.getContextPath();
    User _u = (User) session.getAttribute("currentUser");
    long _uid = (_u != null) ? _u.getId() : -1;
    NotificationDao _notifDao = new NotificationDao();
    List<Notification> _notifs = (_uid > 0) ? _notifDao.getNotificationsByUserId(_uid) : new java.util.ArrayList<>();
    int _unreadCount = (_uid > 0) ? _notifDao.getUnreadCount(_uid) : 0;
%>

<c:set var="displayName" value="${not empty sessionScope.userName ? sessionScope.userName : 'Quản trị viên'}" />
<c:set var="userRole" value="${not empty sessionScope.userRole ? sessionScope.userRole : 'Admin'}" />
<c:set var="avatarUrl" value="${sessionScope.avatarUrl}" />

<c:if test="${empty avatarUrl}">
    <c:set var="avatarUrl" value="https://ui-avatars.com/api/?name=${displayName}&background=0D8ABC&color=fff" />
</c:if>

<!-- Notification Dropdown -->
<div class="relative group dropdown-container" id="notifWrapper">
    <button onclick="toggleNotifPanel(event)" class="relative p-2 text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-full transition-colors focus:outline-none">
        <span class="material-icons text-[24px]">notifications</span>
        <% if (_unreadCount > 0) { %>
            <span id="notifDot" class="absolute top-1.5 right-1.5 w-2.5 h-2.5 bg-red-500 rounded-full border-2 border-white dark:border-slate-800"></span>
        <% } %>
    </button>
    <div id="notifPanel" class="hidden absolute right-0 top-full mt-2 w-80 bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-700 rounded-xl shadow-xl overflow-hidden z-[10001] animate-in fade-in slide-in-from-top-2 duration-200 text-left">
        <div class="flex items-center justify-between px-4 py-3 border-b border-slate-100 dark:border-slate-800 bg-slate-50/50 dark:bg-slate-800/50">
            <div class="flex items-center gap-2">
                <span class="text-sm font-bold text-slate-900 dark:text-white">Thông báo</span>
                <span id="notifCount" class="bg-primary/10 text-primary text-[10px] font-bold px-1.5 py-0.5 rounded-full"><%= _unreadCount %></span>
            </div>
            <button id="markAllRead" onclick="markAllRead()" class="text-[11px] text-primary font-bold hover:underline uppercase tracking-wider">Đánh dấu đã đọc</button>
        </div>
        <ul id="notifList" class="max-h-80 overflow-y-auto divide-y divide-slate-100 dark:divide-slate-800 custom-scrollbar">
            <% if (_notifs.isEmpty()) { %>
                <div class="p-8 text-center text-slate-400">
                    <span class="material-icons text-[48px] mb-2 opacity-50">notifications_off</span>
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
                            <span class="unread-dot w-2 h-2 bg-primary rounded-full shrink-0 mt-2"></span>
                        <% } %>
                    </li>
                <% } %>
            <% } %>
        </ul>
    </div>
</div>

<div class="relative z-50">
    <button onclick="toggleAdminProfile()" id="adminProfileBtn"
        class="block h-10 w-10 rounded-full overflow-hidden border-2 border-slate-100 dark:border-slate-700 shadow-sm cursor-pointer hover:border-primary transition-all focus:ring-4 focus:ring-primary/20 outline-none">
        <img alt="${displayName}" class="w-full h-full object-cover" src="${avatarUrl}" />
    </button>

    <!-- Dropdown Menu -->
    <div id="adminProfileDropdown"
        class="hidden absolute right-0 top-full mt-2 w-64 bg-white dark:bg-slate-800 border border-slate-100 dark:border-slate-700 rounded-xl shadow-xl overflow-hidden animate-in fade-in slide-in-from-top-2 duration-200 origin-top-right transform transition-all">
        
        <div class="p-4 border-b border-slate-100 dark:border-slate-700 bg-slate-50/50 dark:bg-slate-900/50">
            <p class="text-sm font-bold text-slate-800 dark:text-white">
                ${displayName}
            </p>
            <p class="text-xs text-slate-500 dark:text-slate-400 capitalize">
                ${userRole.toLowerCase()}
            </p>
        </div>

        <div class="p-2">
            <a href="${pageContext.request.contextPath}/admin/settings.jsp"
                class="flex items-center gap-3 px-4 py-2.5 text-sm font-medium text-slate-600 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-slate-700/50 hover:text-primary dark:hover:text-primary rounded-lg transition-colors">
                <span class="material-icons text-[20px]">manage_accounts</span>
                Cài đặt Tài khoản
            </a>

            <a href="#"
                class="flex items-center gap-3 px-4 py-2.5 text-sm font-medium text-slate-600 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-slate-700/50 hover:text-primary dark:hover:text-primary rounded-lg transition-colors">
                <span class="material-icons text-[20px]">help_outline</span>
                Trợ giúp & Hỗ trợ
            </a>
        </div>

        <div class="p-2 border-t border-slate-100 dark:border-slate-700">
            <a href="${pageContext.request.contextPath}/logout"
                class="flex items-center gap-3 px-4 py-2.5 text-sm font-medium text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-colors">
                <span class="material-icons text-[20px]">logout</span>
                Đăng xuất
            </a>
        </div>
    </div>
</div>

<script>
    function toggleAdminProfile() {
        const dropdown = document.getElementById('adminProfileDropdown');
        const btn = document.getElementById('adminProfileBtn');
        if (dropdown.classList.contains('hidden')) {
            dropdown.classList.remove('hidden');
            btn.classList.add('ring-4', 'ring-primary/20', 'border-primary');
        } else {
            dropdown.classList.add('hidden');
            btn.classList.remove('ring-4', 'ring-primary/20', 'border-primary');
        }
    }

    // Close dropdown when clicking outside
    document.addEventListener('click', function (event) {
        const dropdown = document.getElementById('adminProfileDropdown');
        const btn = document.getElementById('adminProfileBtn');
        if (dropdown && btn) {
            if (!btn.contains(event.target) && !dropdown.contains(event.target)) {
                dropdown.classList.add('hidden');
                btn.classList.remove('ring-4', 'ring-primary/20', 'border-primary');
            }
        }
    });

    // Close on Escape key
    document.addEventListener('keydown', function (event) {
        if (event.key === 'Escape') {
            const dropdown = document.getElementById('adminProfileDropdown');
            const btn = document.getElementById('adminProfileBtn');
            if (dropdown && btn) {
                dropdown.classList.add('hidden');
                btn.classList.remove('ring-4', 'ring-primary/20', 'border-primary');
            }
        }
    });

    function toggleNotifPanel(event) {
        if (event) {
            event.stopPropagation();
            event.preventDefault();
        }
        const panel = document.getElementById('notifPanel');
        if (panel) {
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

    var _notifContextPath = '<%= _contextPath %>';
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
               finalUrl = _notifContextPath + (nurl.startsWith('/') ? nurl : '/' + nurl);
            }
        }

        if (el.classList.contains('unread')) {
            el.classList.remove('unread');
            el.style.borderLeftColor = 'transparent';
            el.querySelector('.unread-dot')?.remove();
            
            const nid = el.getAttribute('data-id');
            if (nid) {
                fetch(_notifContextPath + '/notification-ajax', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'action=markRead&id=' + encodeURIComponent(nid)
                }).then(() => {
                    if(finalUrl && finalUrl !== '#') window.location.href = finalUrl;
                }).catch(e => {
                    console.error(e);
                    if(finalUrl && finalUrl !== '#') window.location.href = finalUrl;
                });
            } else {
                if(finalUrl && finalUrl !== '#') window.location.href = finalUrl;
            }
            updateBadge();
        } else {
            if(finalUrl && finalUrl !== '#') window.location.href = finalUrl;
        }
    }

    function markAllRead() {
        document.querySelectorAll('.notif-item.unread').forEach(el => {
            el.classList.remove('unread');
            el.style.borderLeftColor = 'transparent';
            el.querySelector('.unread-dot')?.remove();
        });
        updateBadge();
        
        fetch(_notifContextPath + '/notification-ajax', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'action=markAllRead'
        }).catch(e => console.error(e));
    }
</script>