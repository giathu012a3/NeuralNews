<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="neuralnews.model.User" %>
<%
    User _sidebarUser = (request.getSession(false) != null)
            ? (User) request.getSession(false).getAttribute("currentUser") : null;
    String _sidebarName   = (_sidebarUser != null && _sidebarUser.getFullName() != null)
            ? _sidebarUser.getFullName() : "Người dùng";
    String _sidebarRole   = (_sidebarUser != null && _sidebarUser.getRole() != null)
            ? _sidebarUser.getRole().getName() : "READER";
    
    // Avatar initials
    String _initials = "?";
    if (_sidebarUser != null && _sidebarUser.getFullName() != null) {
        String[] _parts = _sidebarUser.getFullName().trim().split("\\s+");
        if (_parts.length >= 2)
            _initials = ("" + _parts[0].charAt(0) + _parts[_parts.length-1].charAt(0)).toUpperCase();
        else
            _initials = _sidebarName.substring(0, Math.min(2, _sidebarName.length())).toUpperCase();
    }
    String _ctxPath = request.getContextPath();
%>
<aside class="w-full lg:w-72 flex flex-col gap-6 shrink-0 sticky top-8 self-start">
    <!-- User Profile Card -->
    <div class="bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-2xl p-6 flex flex-col items-center text-center shadow-sm">
        <div class="relative mb-4">
            <% 
                String _sidebarAvatar = (_sidebarUser != null) ? _sidebarUser.getAvatarUrl() : null;
                if (_sidebarAvatar != null && !_sidebarAvatar.isBlank()) {
                    if (!(_sidebarAvatar.startsWith("http") || _sidebarAvatar.startsWith("https"))) {
                        _sidebarAvatar = _ctxPath + "/" + _sidebarAvatar;
                    }
            %>
            <img alt="<%= _sidebarName %>"
                 class="size-20 rounded-2xl object-cover border-4 border-white dark:border-slate-800 shadow-md shadow-black/10"
                 src="<%= _sidebarAvatar %>" />
            <% } else { %>
            <div class="size-20 rounded-2xl bg-primary/20 text-primary flex items-center justify-center font-bold text-2xl text-primary border-4 border-white dark:border-slate-800 shadow-md shadow-black/10">
                <%= _initials %>
            </div>
            <% } %>
        </div>
        <h3 class="text-slate-900 dark:text-white text-lg font-bold tracking-tight"><%= _sidebarName %></h3>
        <p class="text-slate-500 dark:text-slate-400 text-xs font-medium mt-1"><%= _sidebarRole %></p>
    </div>

    <!-- Navigation Menu -->
    <nav class="flex flex-col gap-1">
        <a class="sidebar-link flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-semibold transition-all group"
           href="<%= _ctxPath %>/user/profile.jsp" data-page="profile.jsp">
            <span class="material-symbols-outlined text-[22px]">grid_view</span>
            <span>Tổng quan hồ sơ</span>
        </a>
        <a class="sidebar-link flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-semibold transition-all group"
           href="<%= _ctxPath %>/user/settings.jsp" data-page="settings.jsp">
            <span class="material-symbols-outlined text-[22px]">settings</span>
            <span>Cài đặt tài khoản</span>
        </a>

    </nav>

    <!-- Logout at bottom -->
    <div class="mt-4 pt-4 border-t border-slate-100 dark:border-slate-800/50">
        <a href="<%= _ctxPath %>/auth/logout.jsp"
           class="flex items-center gap-3 px-4 py-3 rounded-xl text-sm font-semibold text-slate-500 hover:text-red-500 transition-all group">
            <span class="material-symbols-outlined text-[22px]">logout</span>
            <span>Đăng xuất</span>
        </a>
    </div>
</aside>

<script>
    document.addEventListener('DOMContentLoaded', () => {
        const currentPath = window.location.pathname;
        const links = document.querySelectorAll('.sidebar-link');

        links.forEach(link => {
            const page = link.getAttribute('data-page');
            if (currentPath.endsWith(page)) {
                link.classList.add('bg-primary', 'text-white', 'shadow-lg', 'shadow-primary/30');
            } else {
                link.classList.add('text-slate-500', 'dark:text-slate-400', 'hover:bg-slate-100', 'dark:hover:bg-slate-800/50');
            }
        });
    });
</script>