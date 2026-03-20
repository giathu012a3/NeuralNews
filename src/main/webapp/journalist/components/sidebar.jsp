<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="neuralnews.model.User" %>
<%
    User _sidebarUser = (request.getSession(false) != null)
            ? (User) request.getSession(false).getAttribute("currentUser") : null;
    String _sidebarName   = (_sidebarUser != null && _sidebarUser.getFullName() != null)
            ? _sidebarUser.getFullName() : "Nhà báo";
    String _sidebarRole   = (_sidebarUser != null && _sidebarUser.getRole() != null)
            ? _sidebarUser.getRole().getName() : "JOURNALIST";
    String _sidebarRoleVi;
    switch (_sidebarRole.toUpperCase()) {
        case "ADMIN"      -> _sidebarRoleVi = "Quản trị viên";
        case "JOURNALIST" -> _sidebarRoleVi = "Biên tập viên";
        default           -> _sidebarRoleVi = "Thành viên";
    }
    // Avatar initials
    String _initials = "?";
    if (_sidebarUser != null && _sidebarUser.getFullName() != null) {
        String[] _parts = _sidebarUser.getFullName().trim().split("\\s+");
        if (_parts.length >= 2)
            _initials = ("" + _parts[0].charAt(0) + _parts[_parts.length-1].charAt(0)).toUpperCase();
        else
            _initials = _sidebarUser.getFullName().substring(0, Math.min(2, _sidebarUser.getFullName().length())).toUpperCase();
    }
    String _ctxPath = request.getContextPath();
%>
<aside class="w-64 bg-white dark:bg-slate-900 border-r border-slate-200 dark:border-border-dark flex flex-col shrink-0">
    <div class="p-6">
        <div class="flex items-center gap-3 mb-8">
            <a href="<%= _ctxPath %>/home" class="flex items-center gap-3 group">
                <div class="bg-primary size-9 rounded-lg flex items-center justify-center text-white group-hover:bg-blue-600 transition-colors">
                    <span class="material-symbols-outlined text-xl">auto_stories</span>
                </div>
                <div>
                    <h1 class="text-sm font-bold leading-tight uppercase tracking-wider text-slate-900 dark:text-white">Phòng tin tức</h1>
                    <p class="text-slate-500 dark:text-slate-400 text-[10px] font-medium uppercase">Cổng AI</p>
                </div>
            </a>
        </div>
        <nav class="space-y-1">
            <a class="${param.activePage == 'dashboard' ? 'sidebar-item-active' : 'text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors'} flex items-center gap-3 px-3 py-2.5 rounded-md text-sm font-medium"
               href="<%= _ctxPath %>/journalist/home">
                <span class="material-symbols-outlined text-xl">dashboard</span>
                <span>Bảng điều khiển</span>
            </a>
            <a class="${param.activePage == 'articles' ? 'sidebar-item-active' : 'text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors'} flex items-center gap-3 px-3 py-2.5 rounded-md text-sm font-medium"
               href="<%= _ctxPath %>/journalist/articles">
                <span class="material-symbols-outlined text-xl">description</span>
                <span>Bài viết</span>
            </a>
            <a class="${param.activePage == 'comments' ? 'sidebar-item-active' : 'text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors'} flex items-center gap-3 px-3 py-2.5 rounded-md text-sm font-medium"
               href="<%= _ctxPath %>/journalist/comments">
                <span class="material-symbols-outlined text-xl">chat_bubble</span>
                <span>Bình luận</span>
            </a>
            <a class="${param.activePage == 'analytics' ? 'sidebar-item-active' : 'text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors'} flex items-center gap-3 px-3 py-2.5 rounded-md text-sm font-medium"
               href="<%= _ctxPath %>/journalist/analytics">
                <span class="material-symbols-outlined text-xl">analytics</span>
                <span>Phân tích</span>
            </a>
        </nav>
    </div>

    <%-- User info - lấy từ session --%>
    <div class="mt-auto p-4 border-t border-slate-200 dark:border-border-dark bg-slate-50/50 dark:bg-slate-900/50">
        <div class="flex items-center gap-3">
            <%-- Avatar: ảnh nếu có, chữ tắt nếu không --%>
            <% 
                String _sidebarAvatar = (_sidebarUser != null) ? _sidebarUser.getAvatarUrl() : null;
                if (_sidebarAvatar != null && !_sidebarAvatar.isBlank()) {
                    if (!(_sidebarAvatar.startsWith("http") || _sidebarAvatar.startsWith("https"))) {
                        _sidebarAvatar = _ctxPath + "/" + _sidebarAvatar;
                    }
            %>
            <img alt="<%= _sidebarName %>"
                 class="size-9 rounded-full object-cover ring-2 ring-slate-200 dark:ring-slate-700"
                 src="<%= _sidebarAvatar %>" />
            <% } else { %>
            <div class="size-9 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold text-sm ring-2 ring-slate-200 dark:ring-slate-700 shrink-0">
                <%= _initials %>
            </div>
            <% } %>
            <div class="flex-1 min-w-0">
                <p class="text-xs font-bold truncate text-slate-900 dark:text-white"><%= _sidebarName %></p>
                <p class="text-[10px] text-slate-500 truncate"><%= _sidebarRoleVi %></p>
            </div>
            <a href="${pageContext.request.contextPath}/user/settings.jsp"
               class="text-slate-400 hover:text-primary transition-colors" title="Cài đặt">
                <span class="material-symbols-outlined text-xl">settings</span>
            </a>
            <a href="${pageContext.request.contextPath}/logout"
               class="text-slate-400 hover:text-red-500 transition-colors ml-1" title="Đăng xuất">
                <span class="material-symbols-outlined text-xl">logout</span>
            </a>
        </div>
    </div>
</aside>
