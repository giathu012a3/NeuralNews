<!DOCTYPE html>
<html class="dark" lang="en">

<head>
    <jsp:include page="components/head.jsp" />
    <title>Thư viện Quản lý Bài viết của tôi - Newsroom</title>
</head>

<%@ page import="java.util.List" %>
<%@ page import="neuralnews.model.Article" %>

<%
    List<Article> articles = (List<Article>) request.getAttribute("articles");
    if (articles == null) {
        request.getRequestDispatcher("/journalist/articles").forward(request, response);
        return;
    }
%>

<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen">
    <div class="flex h-screen overflow-hidden">
        <jsp:include page="components/sidebar.jsp">
            <jsp:param name="activePage" value="articles" />
        </jsp:include>
        <main class="flex-1 flex flex-col min-w-0 bg-background-light dark:bg-background-dark">
            <header
                class="h-16 bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-border-dark flex items-center justify-between px-8 shrink-0 z-20">
                <div class="flex items-center gap-6">
                    <h2 class="text-lg font-bold tracking-tight">Thư viện Bài viết</h2>
                    <div class="hidden md:flex items-center gap-2 text-xs text-slate-500 font-medium">
                        <span>Cổng thông tin Nhà báo</span>
                        <span class="material-symbols-outlined text-sm">chevron_right</span>
                        <span class="text-slate-900 dark:text-slate-200">Quản lý</span>
                    </div>
                </div>
                <div class="flex items-center gap-3">
                    <div class="relative group">
                        <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-lg">search</span>
                        <input
                            class="bg-slate-100 dark:bg-slate-800 border-none rounded-lg py-1.5 pl-10 pr-4 w-64 focus:ring-2 focus:ring-primary text-xs transition-all"
                            placeholder="Tìm kiếm bài viết theo tiêu đề hoặc thẻ..." type="text" />
                    </div>
                    <div class="h-6 w-px bg-slate-200 dark:border-border-dark mx-1"></div>
                    <button class="relative p-2 rounded-lg hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors text-slate-500">
                        <span class="material-symbols-outlined">notifications</span>
                        <span class="absolute top-2.5 right-2.5 size-2 bg-red-500 rounded-full border-2 border-white dark:border-slate-900"></span>
                    </button>
                    <button class="p-2 rounded-lg hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors text-slate-500">
                        <span class="material-symbols-outlined">light_mode</span>
                    </button>
                </div>
            </header>

            <div class="flex-1 overflow-y-auto">
                <div class="p-8 max-w-[1200px] mx-auto space-y-6">

                    <!-- Header + actions -->
                    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-2">
                        <div>
                            <h3 class="text-xl font-bold">Bài viết của tôi</h3>
                            <p class="text-slate-500 dark:text-slate-400 text-xs mt-1">
                                Quản lý <%= articles.size() %> bài viết của bạn
                            </p>
                        </div>
                        <div class="flex items-center gap-3">
                            <button class="flex items-center gap-2 px-3 py-2 bg-white dark:bg-slate-800 border border-slate-200 dark:border-border-dark hover:border-primary/50 rounded-lg text-xs font-semibold transition-all shadow-sm">
                                <span class="material-symbols-outlined text-sm">tune</span>
                                Bộ lọc Nâng cao
                            </button>
                            <a href="${pageContext.request.contextPath}/journalist/create_article.jsp"
                                class="flex items-center gap-2 px-4 py-2 bg-primary hover:bg-primary/90 text-white rounded-lg text-xs font-semibold transition-all shadow-sm">
                                <span class="material-symbols-outlined text-sm">add</span>
                                Tạo Bài viết Mới
                            </a>
                        </div>
                    </div>

                    <!-- Table -->
                    <div class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm overflow-hidden">
                        <div class="overflow-x-auto">
                            <table class="w-full border-collapse">
                                <thead>
                                    <tr>
                                        <th class="table-header w-1/2">Tiêu đề Bài viết</th>
                                        <th class="table-header">Trạng thái</th>
                                        <th class="table-header">Lượt xem</th>
                                        <th class="table-header">Ngày</th>
                                        <th class="table-header text-right">Hành động</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-slate-100 dark:divide-border-dark/30">

                                <% if (articles.isEmpty()) { %>
                                    <tr>
                                        <td colspan="5" class="table-cell text-center text-slate-400 py-12">
                                            Chưa có bài viết nào.
                                        </td>
                                    </tr>
                                <% } else { %>
                                    <% for (Article a : articles) { %>
                                    <tr class="hover:bg-slate-50/50 dark:hover:bg-slate-800/30 transition-colors">

                                        <!-- Tiêu đề + ảnh + danh mục -->
                                        <td class="table-cell">
                                            <div class="flex items-center gap-3">
                                                <div class="size-12 rounded-lg bg-slate-200 dark:bg-slate-800 overflow-hidden shrink-0">
                                                    <img alt="<%= a.getTitle() %>"
                                                        class="size-full object-cover opacity-80"
                                                        src="<%= a.getImageUrl() != null ? a.getImageUrl() : "" %>" />
                                                </div>
                                                <div class="min-w-0">
                                                    <p class="font-bold text-slate-900 dark:text-white truncate">
                                                        <%= a.getTitle() %>
                                                    </p>
                                                    <p class="text-[11px] text-slate-400 font-medium">
                                                        <%= a.getCategoryName() != null ? a.getCategoryName() : "Chưa phân loại" %>
                                                    </p>
                                                </div>
                                            </div>
                                        </td>

                                        <!-- Trạng thái badge -->
                                        <td class="table-cell">
                                            <div class="badge-base <%= a.getStatusBadgeClass() %> ring-1 ring-inset w-fit">
                                                <span class="size-1.5 rounded-full <%= a.getStatusDotClass() %>"></span>
                                                <%= a.getStatusLabel() %>
                                            </div>
                                        </td>

                                        <!-- Lượt xem -->
                                        <td class="table-cell font-medium">
                                            <%= a.getFormattedViews() %>
                                        </td>

                                        <!-- Ngày -->
                                        <td class="table-cell text-slate-500 text-xs">
                                            <%
                                                if (a.getCreatedAt() != null) {
                                                    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
                                                    out.print(sdf.format(a.getCreatedAt()));
                                                } else {
                                                    out.print("—");
                                                }
                                            %>
                                        </td>

                                        <!-- Hành động -->
                                        <td class="table-cell">
                                            <div class="flex items-center justify-end gap-1">
                                                <a href="${pageContext.request.contextPath}/journalist/create_article.jsp?id=<%= a.getId() %>"
                                                    class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-400 hover:text-primary transition-colors"
                                                    title="Chỉnh sửa">
                                                    <span class="material-symbols-outlined text-xl">edit</span>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/user/article.jsp?id=<%= a.getId() %>"
                                                    class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-400 hover:text-slate-200 transition-colors"
                                                    title="Xem trước">
                                                    <span class="material-symbols-outlined text-xl">visibility</span>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/journalist/analytics.jsp?id=<%= a.getId() %>"
                                                    class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-400 hover:text-emerald-500 transition-colors"
                                                    title="Phân tích">
                                                    <span class="material-symbols-outlined text-xl">insights</span>
                                                </a>
                                            </div>
                                        </td>

                                    </tr>
                                    <% } %>
                                <% } %>

                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Pagination -->
                    <div class="flex items-center justify-between py-6 border-t border-slate-200 dark:border-border-dark">
                        <p class="text-xs font-medium text-slate-500 dark:text-slate-400">
                            Hiển thị <span class="text-slate-900 dark:text-white"><%= articles.size() %></span> bài viết
                        </p>
                        <div class="flex items-center gap-1.5">
                            <button class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800 disabled:opacity-40 transition-all text-xs font-semibold" disabled>
                                Trước
                            </button>
                            <button class="px-4 py-1.5 rounded-md bg-primary/10 text-primary text-xs font-bold">1</button>
                            <button class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800 transition-all text-xs font-semibold">
                                Tiếp
                            </button>
                        </div>
                    </div>

                </div>
            </div>
        </main>
    </div>
</body>

</html>
