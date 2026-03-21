<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="u" value="${sessionScope.currentUser}" />
<c:set var="role" value="${not empty u.role ? u.role.name : 'JOURNALIST'}" />
<c:set var="roleVi">
    <c:choose>
        <c:when test="${role == 'ADMIN'}">Quản trị viên</c:when>
        <c:when test="${role == 'JOURNALIST'}">Biên tập viên</c:when>
        <c:otherwise>Thành viên</c:otherwise>
    </c:choose>
</c:set>

<aside class="w-64 bg-white dark:bg-slate-900 border-r border-slate-200 dark:border-border-dark flex flex-col shrink-0">
    <div class="p-6">
        <div class="flex items-center gap-3 mb-8">
            <a href="${pageContext.request.contextPath}/home" class="flex items-center gap-3 group">
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
            <c:set var="active" value="${param.activePage}" />
            
            <a class="${active == 'dashboard' ? 'sidebar-item-active' : 'text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors'} flex items-center gap-3 px-3 py-2.5 rounded-md text-sm font-medium"
               href="${pageContext.request.contextPath}/journalist/home">
                <span class="material-symbols-outlined text-xl">dashboard</span>
                <span>Bảng điều khiển</span>
            </a>
            <a class="${active == 'articles' ? 'sidebar-item-active' : 'text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors'} flex items-center gap-3 px-3 py-2.5 rounded-md text-sm font-medium"
               href="${pageContext.request.contextPath}/journalist/articles">
                <span class="material-symbols-outlined text-xl">description</span>
                <span>Bài viết</span>
            </a>
            <a class="${active == 'comments' ? 'sidebar-item-active' : 'text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors'} flex items-center gap-3 px-3 py-2.5 rounded-md text-sm font-medium"
               href="${pageContext.request.contextPath}/journalist/comments">
                <span class="material-symbols-outlined text-xl">chat_bubble</span>
                <span>Bình luận</span>
            </a>
            <a class="${active == 'analytics' ? 'sidebar-item-active' : 'text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors'} flex items-center gap-3 px-3 py-2.5 rounded-md text-sm font-medium"
               href="${pageContext.request.contextPath}/journalist/analytics">
                <span class="material-symbols-outlined text-xl">analytics</span>
                <span>Phân tích</span>
            </a>
        </nav>
    </div>

    <%-- User info - lấy từ session --%>
    <div class="mt-auto p-4 border-t border-slate-200 dark:border-border-dark bg-slate-50/50 dark:bg-slate-900/50">
        <div class="flex items-center gap-3">
            <c:choose>
                <c:when test="${not empty u.avatarUrl}">
                    <c:set var="avatar" value="${u.avatarUrl}" />
                    <c:if test="${!(fn:startsWith(avatar, 'http') || fn:startsWith(avatar, 'https'))}">
                        <c:set var="avatar" value="${pageContext.request.contextPath}/${avatar}" />
                    </c:if>
                    <img alt="${u.fullName}"
                         class="size-9 rounded-full object-cover ring-2 ring-slate-200 dark:ring-slate-700"
                         src="${avatar}" />
                </c:when>
                <c:otherwise>
                    <div class="size-9 rounded-full bg-primary/20 text-primary flex items-center justify-center font-bold text-sm ring-2 ring-slate-200 dark:ring-slate-700 shrink-0">
                        ${fn:toUpperCase(fn:substring(u.fullName, 0, 2))}
                    </div>
                </c:otherwise>
            </c:choose>
            <div class="flex-1 min-w-0">
                <p class="text-xs font-bold truncate text-slate-900 dark:text-white">${not empty u.fullName ? u.fullName : 'Biên tập viên'}</p>
                <p class="text-[10px] text-slate-500 truncate">${roleVi}</p>
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
