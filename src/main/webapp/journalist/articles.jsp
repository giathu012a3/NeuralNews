<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="neuralnews.model.Article" %>

<%
    // ── Nếu vào thẳng JSP (không qua Servlet) → redirect sang Servlet,
    //    giữ nguyên toàn bộ query string (page, keyword, status, ...)
    List<Article> articles = (List<Article>) request.getAttribute("articles");
    if (articles == null) {
        String qs = request.getQueryString();
        String redirectUrl = request.getContextPath() + "/journalist/articles"
                             + (qs != null && !qs.isEmpty() ? "?" + qs : "");
        response.sendRedirect(redirectUrl);
        return;
    }
%>

<!DOCTYPE html>
<html class="dark" lang="en">

<head>
    <jsp:include page="components/head.jsp" />
    <title>Thư viện Quản lý Bài viết của tôi - Newsroom</title>
</head>

<%
    int totalArticles = (Integer) request.getAttribute("totalArticles");
    int totalPages    = (Integer) request.getAttribute("totalPages");
    int currentPage   = (Integer) request.getAttribute("currentPage");
    int pageSize      = (Integer) request.getAttribute("pageSize");

    String filterKeyword  = (String) request.getAttribute("filterKeyword");
    String filterStatus   = (String) request.getAttribute("filterStatus");
    String filterCategory = (String) request.getAttribute("filterCategory");
    String filterDateFrom = (String) request.getAttribute("filterDateFrom");
    String filterDateTo   = (String) request.getAttribute("filterDateTo");

    @SuppressWarnings("unchecked")
    List<String> categories = (List<String>) request.getAttribute("categories");

    int startIndex = totalArticles == 0 ? 0 : (currentPage - 1) * pageSize + 1;
    int endIndex   = Math.min(currentPage * pageSize, totalArticles);

    boolean hasActiveFilter = !filterKeyword.isEmpty()
        || (!filterStatus.isEmpty()   && !filterStatus.equals("ALL"))
        || (!filterCategory.isEmpty() && !filterCategory.equals("ALL"))
        || !filterDateFrom.isEmpty()  || !filterDateTo.isEmpty();

    // Base URL luôn trỏ về Servlet
    String servletUrl = request.getContextPath() + "/journalist/articles";

    String filterQS = "keyword="  + java.net.URLEncoder.encode(filterKeyword,  "UTF-8")
                    + "&status="   + java.net.URLEncoder.encode(filterStatus,   "UTF-8")
                    + "&category=" + java.net.URLEncoder.encode(filterCategory, "UTF-8")
                    + "&dateFrom=" + java.net.URLEncoder.encode(filterDateFrom, "UTF-8")
                    + "&dateTo="   + java.net.URLEncoder.encode(filterDateTo,   "UTF-8");
%>

<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen">
    <div class="flex h-screen overflow-hidden">
        <jsp:include page="components/sidebar.jsp">
            <jsp:param name="activePage" value="articles" />
        </jsp:include>
        <main class="flex-1 flex flex-col min-w-0 bg-background-light dark:bg-background-dark">

            <%-- ═══ HEADER ══════════════════════════════════════════════════ --%>
            <header class="h-16 bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-border-dark flex items-center justify-between px-8 shrink-0 z-20">
                <div class="flex items-center gap-6">
                    <h2 class="text-lg font-bold tracking-tight">Thư viện Bài viết</h2>
                    <div class="hidden md:flex items-center gap-2 text-xs text-slate-500 font-medium">
                        <span>Cổng thông tin Nhà báo</span>
                        <span class="material-symbols-outlined text-sm">chevron_right</span>
                        <span class="text-slate-900 dark:text-slate-200">Quản lý</span>
                    </div>
                </div>
                <div class="flex items-center gap-3">
                    <form method="get" action="<%= servletUrl %>" id="headerSearchForm" class="relative group">
                        <input type="hidden" name="status"   value="<%= filterStatus %>">
                        <input type="hidden" name="category" value="<%= filterCategory %>">
                        <input type="hidden" name="dateFrom" value="<%= filterDateFrom %>">
                        <input type="hidden" name="dateTo"   value="<%= filterDateTo %>">
                        <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-lg">search</span>
                        <input id="headerKeyword" name="keyword" value="<%= filterKeyword %>"
                            class="bg-slate-100 dark:bg-slate-800 border-none rounded-lg py-1.5 pl-10 pr-4 w-64 focus:ring-2 focus:ring-primary text-xs transition-all"
                            placeholder="Tìm kiếm bài viết theo tiêu đề hoặc thẻ..." type="text" />
                    </form>
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

                    <%-- ═══ HEADER + ACTIONS ═════════════════════════════════ --%>
                    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-2">
                        <div>
                            <h3 class="text-xl font-bold">Bài viết của tôi</h3>
                            <p class="text-slate-500 dark:text-slate-400 text-xs mt-1">
                                Quản lý <span class="text-slate-900 dark:text-white font-semibold"><%= totalArticles %></span> bài viết của bạn
                            </p>
                        </div>
                        <div class="flex items-center gap-3">
                            <button onclick="toggleFilterPanel()"
                                class="flex items-center gap-2 px-3 py-2 bg-white dark:bg-slate-800 border border-slate-200 dark:border-border-dark hover:border-primary/50 rounded-lg text-xs font-semibold transition-all shadow-sm<%= hasActiveFilter ? " ring-2 ring-primary/40" : "" %>">
                                <span class="material-symbols-outlined text-sm">tune</span>
                                Bộ lọc Nâng cao
                                <% if (hasActiveFilter) { %>
                                <span class="size-1.5 rounded-full bg-primary inline-block"></span>
                                <% } %>
                            </button>
                            <a href="${pageContext.request.contextPath}/journalist/create_article.jsp"
                                class="flex items-center gap-2 px-4 py-2 bg-primary hover:bg-primary/90 text-white rounded-lg text-xs font-semibold transition-all shadow-sm">
                                <span class="material-symbols-outlined text-sm">add</span>
                                Tạo Bài viết Mới
                            </a>
                        </div>
                    </div>

                    <%-- ═══ PANEL BỘ LỌC NÂNG CAO ════════════════════════════ --%>
                    <div id="filterPanel" class="<%= hasActiveFilter ? "" : "hidden" %> bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm overflow-hidden">
                        <div class="px-6 py-3.5 border-b border-slate-100 dark:border-border-dark/50 flex items-center justify-between">
                            <span class="text-xs font-bold text-slate-600 dark:text-slate-300 flex items-center gap-2">
                                <span class="material-symbols-outlined text-sm text-primary">filter_list</span>
                                Bộ lọc Nâng cao
                            </span>
                            <% if (hasActiveFilter) { %>
                            <a href="<%= servletUrl %>"
                               class="text-xs text-red-500 hover:text-red-400 font-semibold flex items-center gap-1 transition-colors">
                                <span class="material-symbols-outlined text-sm">close</span>
                                Xoá bộ lọc
                            </a>
                            <% } %>
                        </div>
                        <form method="get" action="<%= servletUrl %>" id="filterForm">
                            <input type="hidden" name="keyword" id="filterKeywordHidden" value="<%= filterKeyword %>">
                            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 p-5">

                                <div class="space-y-1.5">
                                    <label class="text-[11px] font-semibold text-slate-400 uppercase tracking-wide">Trạng thái</label>
                                    <select name="status"
                                        class="w-full bg-slate-100 dark:bg-slate-800 border-none rounded-lg px-3 py-2 text-xs font-medium focus:ring-2 focus:ring-primary outline-none transition-all">
                                        <option value="ALL" <%= filterStatus.isEmpty() || filterStatus.equals("ALL") ? "selected" : "" %>>Tất cả trạng thái</option>
                                        <option value="PUBLISHED" <%= "PUBLISHED".equals(filterStatus) ? "selected" : "" %>>Đã xuất bản</option>
                                        <option value="DRAFT"     <%= "DRAFT".equals(filterStatus)     ? "selected" : "" %>>Bản nháp</option>
                                        <option value="PENDING"   <%= "PENDING".equals(filterStatus)   ? "selected" : "" %>>Đang chờ duyệt</option>
                                        <option value="REJECTED"  <%= "REJECTED".equals(filterStatus)  ? "selected" : "" %>>Bị từ chối</option>
                                    </select>
                                </div>

                                <div class="space-y-1.5">
                                    <label class="text-[11px] font-semibold text-slate-400 uppercase tracking-wide">Danh mục</label>
                                    <select name="category"
                                        class="w-full bg-slate-100 dark:bg-slate-800 border-none rounded-lg px-3 py-2 text-xs font-medium focus:ring-2 focus:ring-primary outline-none transition-all">
                                        <option value="ALL" <%= filterCategory.isEmpty() || filterCategory.equals("ALL") ? "selected" : "" %>>Tất cả danh mục</option>
                                        <% if (categories != null) { for (String cat : categories) { %>
                                        <option value="<%= cat %>" <%= cat.equals(filterCategory) ? "selected" : "" %>><%= cat %></option>
                                        <% } } %>
                                    </select>
                                </div>

                                <div class="space-y-1.5">
                                    <label class="text-[11px] font-semibold text-slate-400 uppercase tracking-wide">Từ ngày</label>
                                    <input type="date" name="dateFrom" value="<%= filterDateFrom %>"
                                        class="w-full bg-slate-100 dark:bg-slate-800 border-none rounded-lg px-3 py-2 text-xs font-medium focus:ring-2 focus:ring-primary outline-none transition-all" />
                                </div>

                                <div class="space-y-1.5">
                                    <label class="text-[11px] font-semibold text-slate-400 uppercase tracking-wide">Đến ngày</label>
                                    <input type="date" name="dateTo" value="<%= filterDateTo %>"
                                        class="w-full bg-slate-100 dark:bg-slate-800 border-none rounded-lg px-3 py-2 text-xs font-medium focus:ring-2 focus:ring-primary outline-none transition-all" />
                                </div>

                            </div>
                            <div class="px-5 pb-4 flex justify-end gap-2">
                                <a href="<%= servletUrl %>"
                                   class="px-4 py-1.5 rounded-lg border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800 text-xs font-semibold transition-all">
                                    Đặt lại
                                </a>
                                <button type="submit"
                                    class="flex items-center gap-1.5 px-4 py-1.5 bg-primary hover:bg-primary/90 text-white rounded-lg text-xs font-semibold transition-all shadow-sm">
                                    <span class="material-symbols-outlined text-sm">search</span>
                                    Áp dụng
                                </button>
                            </div>
                        </form>
                    </div>

                    <%-- ═══ TABLE ══════════════════════════════════════════════ --%>
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
                                            <% if (hasActiveFilter) { %>
                                            Không tìm thấy bài viết nào phù hợp.
                                            <% } else { %>
                                            Chưa có bài viết nào.
                                            <% } %>
                                        </td>
                                    </tr>
                                <% } else { %>
                                    <% for (Article a : articles) { %>
                                    <tr class="hover:bg-slate-50/50 dark:hover:bg-slate-800/30 transition-colors">

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

                                        <td class="table-cell">
                                            <div class="badge-base <%= a.getStatusBadgeClass() %> ring-1 ring-inset w-fit">
                                                <span class="size-1.5 rounded-full <%= a.getStatusDotClass() %>"></span>
                                                <%= a.getStatusLabel() %>
                                            </div>
                                        </td>

                                        <td class="table-cell font-medium">
                                            <%= a.getFormattedViews() %>
                                        </td>

                                        <td class="table-cell text-slate-500 text-xs">
                                            <%
                                                if (a.getCreatedAt() != null) {
                                                    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
                                                    out.print(sdf.format(a.getCreatedAt()));
                                                } else {
                                                    out.print("&#8212;");
                                                }
                                            %>
                                        </td>

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

                    <%-- ═══ PAGINATION ════════════════════════════════════════ --%>
                    <div class="flex items-center justify-between py-6 border-t border-slate-200 dark:border-border-dark">
                        <p class="text-xs font-medium text-slate-500 dark:text-slate-400">
                            Hiển thị
                            <span class="text-slate-900 dark:text-white">
                                <% if (totalArticles == 0) { %>0<% } else { %><%= startIndex %>&#8211;<%= endIndex %><% } %>
                            </span>
                            trong <span class="text-slate-900 dark:text-white"><%= totalArticles %></span> bài viết
                        </p>

                        <div class="flex items-center gap-1.5">
                            <%-- Nút Trước --%>
                            <% if (currentPage <= 1) { %>
                            <button disabled class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark disabled:opacity-40 transition-all text-xs font-semibold">Trước</button>
                            <% } else { %>
                            <a href="<%= servletUrl %>?page=<%= currentPage - 1 %>&<%= filterQS %>"
                               class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800 transition-all text-xs font-semibold">Trước</a>
                            <% } %>

                            <%-- Số trang (sliding window) --%>
                            <%
                                int wStart = Math.max(1, currentPage - 2);
                                int wEnd   = Math.min(totalPages, currentPage + 2);
                            %>
                            <% if (wStart > 1) { %>
                            <a href="<%= servletUrl %>?page=1&<%= filterQS %>"
                               class="px-4 py-1.5 rounded-md border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800 transition-all text-xs font-semibold">1</a>
                            <% if (wStart > 2) { %><span class="px-1 text-slate-400 text-xs">&#8230;</span><% } %>
                            <% } %>

                            <% for (int p = wStart; p <= wEnd; p++) { %>
                            <% if (p == currentPage) { %>
                            <button class="px-4 py-1.5 rounded-md bg-primary/10 text-primary text-xs font-bold"><%= p %></button>
                            <% } else { %>
                            <a href="<%= servletUrl %>?page=<%= p %>&<%= filterQS %>"
                               class="px-4 py-1.5 rounded-md border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800 transition-all text-xs font-semibold"><%= p %></a>
                            <% } %>
                            <% } %>

                            <% if (wEnd < totalPages) { %>
                            <% if (wEnd < totalPages - 1) { %><span class="px-1 text-slate-400 text-xs">&#8230;</span><% } %>
                            <a href="<%= servletUrl %>?page=<%= totalPages %>&<%= filterQS %>"
                               class="px-4 py-1.5 rounded-md border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800 transition-all text-xs font-semibold"><%= totalPages %></a>
                            <% } %>

                            <%-- Nút Tiếp --%>
                            <% if (currentPage >= totalPages) { %>
                            <button disabled class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark disabled:opacity-40 transition-all text-xs font-semibold">Tiếp</button>
                            <% } else { %>
                            <a href="<%= servletUrl %>?page=<%= currentPage + 1 %>&<%= filterQS %>"
                               class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800 transition-all text-xs font-semibold">Tiếp</a>
                            <% } %>
                        </div>
                    </div>

                </div>
            </div>
        </main>
    </div>

    <script>
        function toggleFilterPanel() {
            document.getElementById('filterPanel').classList.toggle('hidden');
        }
        document.getElementById('headerSearchForm').addEventListener('submit', function (e) {
            e.preventDefault();
            document.getElementById('filterKeywordHidden').value =
                document.getElementById('headerKeyword').value;
            document.getElementById('filterForm').submit();
        });
    </script>
</body>
</html>
