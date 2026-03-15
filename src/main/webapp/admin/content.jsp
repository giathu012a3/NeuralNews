<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:if test="${empty categories}"><jsp:forward page="/admin/content" /></c:if>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="components/head.jsp" />
    <title>Quản lý nội dung | NeuralNews Admin</title>
</head>
<body class="bg-dashboard-bg dark:bg-background-dark">
    <div class="flex min-h-screen">
        <jsp:include page="components/sidebar.jsp"><jsp:param name="activePage" value="content" /></jsp:include>
        <main class="flex-1 ml-64 bg-dashboard-bg dark:bg-background-dark/95 min-h-screen">
            <header class="sticky top-0 z-40 bg-dashboard-bg/80 dark:bg-background-dark/80 backdrop-blur-md px-8 py-4 flex items-center justify-between border-b border-slate-200 dark:border-slate-800">
                <div>
                    <p class="text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-widest">Hệ thống</p>
                    <h2 class="text-2xl font-bold text-slate-800 dark:text-white">Quản lý nội dung</h2>
                </div>
                <div class="flex items-center gap-4">
                    <a href="${pageContext.request.contextPath}/admin/create_article.jsp" class="bg-primary hover:bg-primary/90 text-white px-4 py-2 rounded-lg text-sm font-bold flex items-center gap-2 shadow-lg shadow-primary/20 transition-all">
                        <span class="material-icons text-sm">add</span> Viết bài mới
                    </a>
                    <jsp:include page="components/header_profile.jsp" />
                </div>
            </header>
            <div class="p-8 space-y-6">
                <div class="bg-white dark:bg-slate-800 p-4 rounded-xl shadow-sm border border-slate-100 dark:border-slate-700 flex flex-wrap items-end gap-4">
                    <div class="flex-1 min-w-[200px]">
                        <label class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Tìm kiếm bài viết</label>
                        <input id="searchInput" class="w-full text-sm border-slate-200 dark:border-slate-600 dark:bg-slate-900 rounded-lg focus:ring-primary" placeholder="Tiêu đề, Tác giả, hoặc ID..." type="text" />
                    </div>
                    <div class="w-48">
                        <label class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Danh mục</label>
                        <select id="categoryFilter" class="w-full text-sm border-slate-200 dark:border-slate-600 dark:bg-slate-900 rounded-lg focus:ring-primary">
                            <option value="ALL">Tất cả danh mục</option>
                            <c:forEach items="${categories}" var="c"><option value="${c.id}">${c.name}</option></c:forEach>
                        </select>
                    </div>
                    <div class="w-48">
                        <label class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Trạng thái</label>
                        <select id="statusFilter" class="w-full text-sm border-slate-200 dark:border-slate-600 dark:bg-slate-900 rounded-lg focus:ring-primary">
                            <option value="ALL">Tất cả trạng thái</option>
                            <option value="PUBLISHED">Đã xuất bản</option>
                            <option value="PENDING">Đang chờ duyệt</option>
                            <option value="REJECTED">Bị từ chối</option>
                            <option value="ARCHIVED">Đã lưu trữ</option>
                        </select>
                    </div>
                    <button onclick="AdminContent.resetFilters()" class="px-4 py-2 border border-slate-200 dark:border-slate-600 rounded-lg text-sm font-medium hover:bg-slate-50 dark:hover:bg-slate-700 transition-colors">Xóa bộ lọc</button>
                </div>
                <div id="article-table-container" class="bg-white dark:bg-slate-800 rounded-xl shadow-sm border border-slate-100 dark:border-slate-700 overflow-hidden min-h-[400px]">
                    <jsp:include page="components/article_table_partial.jsp" />
                </div>
            </div>
        </main>
    </div>
    <script src="${pageContext.request.contextPath}/assets/js/app-utils.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/admin-content.js"></script>
    <script>
        AdminContent.init({ contextPath: '${pageContext.request.contextPath}', currentSearchPage: ${not empty currentPage ? currentPage : 1} });
        function changePage(p) { AdminContent.fetchArticles(p); }
        function toggleAll(cb) { AdminContent.toggleAll(cb); }
        function handleModerationAction(e, id, ac) { AdminContent.handleModerationAction(e, id, ac); }
        function handleBulkApprove(e) { AdminContent.handleBulkApprove(e); }
    </script>
</body>
</html>