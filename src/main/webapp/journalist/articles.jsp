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

                    <%-- Nút Thông báo --%>
                    <div class="relative" id="notifWrapper">
                        <button id="notifBtn" onclick="toggleNotif()"
                                class="relative p-2 rounded-lg hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors text-slate-500">
                            <span class="material-symbols-outlined">notifications</span>
                            <span id="notifDot" class="absolute top-2 right-2 size-2 bg-red-500 rounded-full border-2 border-white dark:border-slate-900"></span>
                        </button>
                        <div id="notifDropdown"
                             class="hidden absolute right-0 top-12 w-80 bg-white dark:bg-slate-900 border border-slate-200 dark:border-border-dark rounded-xl shadow-xl z-50 overflow-hidden">
                            <div class="flex items-center justify-between px-4 py-3 border-b border-slate-100 dark:border-border-dark">
                                <div class="flex items-center gap-2">
                                    <span class="text-sm font-bold text-slate-800 dark:text-white">Thông báo</span>
                                    <span id="notifCount" class="bg-primary/10 text-primary text-[10px] font-bold px-1.5 py-0.5 rounded-full">2</span>
                                </div>
                                <button onclick="markAllRead()" class="text-[11px] text-primary hover:underline font-semibold">Đánh dấu đã đọc</button>
                            </div>
                            <ul class="max-h-80 overflow-y-auto divide-y divide-slate-100 dark:divide-border-dark">
                                <li class="notif-item unread flex items-start gap-3 px-4 py-3 hover:bg-slate-50 dark:hover:bg-slate-800/50 cursor-pointer transition-colors" data-id="a_notif_1" onclick="markOneRead(this)">
                                    <div class="size-8 rounded-full bg-emerald-100 dark:bg-emerald-500/10 flex items-center justify-center shrink-0 mt-0.5">
                                        <span class="material-symbols-outlined text-emerald-500 text-sm">check_circle</span>
                                    </div>
                                    <div class="flex-1 min-w-0">
                                        <p class="text-xs font-semibold text-slate-800 dark:text-white">Bài viết được duyệt</p>
                                        <p class="text-[11px] text-slate-500 mt-0.5">Bài "Sự bùng nổ của AI..." đã được xuất bản.</p>
                                        <p class="text-[10px] text-slate-400 mt-1">2 giờ trước</p>
                                    </div>
                                    <span class="unread-dot size-2 bg-primary rounded-full shrink-0 mt-2"></span>
                                </li>
                                <li class="notif-item unread flex items-start gap-3 px-4 py-3 hover:bg-slate-50 dark:hover:bg-slate-800/50 cursor-pointer transition-colors" data-id="a_notif_2" onclick="markOneRead(this)">
                                    <div class="size-8 rounded-full bg-red-100 dark:bg-red-500/10 flex items-center justify-center shrink-0 mt-0.5">
                                        <span class="material-symbols-outlined text-red-500 text-sm">cancel</span>
                                    </div>
                                    <div class="flex-1 min-w-0">
                                        <p class="text-xs font-semibold text-slate-800 dark:text-white">Bài viết bị từ chối</p>
                                        <p class="text-[11px] text-slate-500 mt-0.5">Vui lòng chỉnh sửa và gửi lại.</p>
                                        <p class="text-[10px] text-slate-400 mt-1">5 giờ trước</p>
                                    </div>
                                    <span class="unread-dot size-2 bg-primary rounded-full shrink-0 mt-2"></span>
                                </li>
                                <li class="notif-item flex items-start gap-3 px-4 py-3 hover:bg-slate-50 dark:hover:bg-slate-800/50 cursor-pointer transition-colors" data-id="a_notif_3" onclick="markOneRead(this)">
                                    <div class="size-8 rounded-full bg-blue-100 dark:bg-blue-500/10 flex items-center justify-center shrink-0 mt-0.5">
                                        <span class="material-symbols-outlined text-blue-500 text-sm">comment</span>
                                    </div>
                                    <div class="flex-1 min-w-0">
                                        <p class="text-xs font-semibold text-slate-800 dark:text-white">Bình luận mới</p>
                                        <p class="text-[11px] text-slate-500 mt-0.5">Có 3 bình luận mới trên bài viết của bạn.</p>
                                        <p class="text-[10px] text-slate-400 mt-1">1 ngày trước</p>
                                    </div>
                                </li>
                                <li class="notif-item flex items-start gap-3 px-4 py-3 hover:bg-slate-50 dark:hover:bg-slate-800/50 cursor-pointer transition-colors" data-id="a_notif_4" onclick="markOneRead(this)">
                                    <div class="size-8 rounded-full bg-amber-100 dark:bg-amber-500/10 flex items-center justify-center shrink-0 mt-0.5">
                                        <span class="material-symbols-outlined text-amber-500 text-sm">star</span>
                                    </div>
                                    <div class="flex-1 min-w-0">
                                        <p class="text-xs font-semibold text-slate-800 dark:text-white">Bài viết nổi bật</p>
                                        <p class="text-[11px] text-slate-500 mt-0.5">Bài của bạn được chọn vào Top tuần.</p>
                                        <p class="text-[10px] text-slate-400 mt-1">2 ngày trước</p>
                                    </div>
                                </li>
                                <li class="notif-item flex items-start gap-3 px-4 py-3 hover:bg-slate-50 dark:hover:bg-slate-800/50 cursor-pointer transition-colors" data-id="a_notif_5" onclick="markOneRead(this)">
                                    <div class="size-8 rounded-full bg-violet-100 dark:bg-violet-500/10 flex items-center justify-center shrink-0 mt-0.5">
                                        <span class="material-symbols-outlined text-violet-500 text-sm">bar_chart</span>
                                    </div>
                                    <div class="flex-1 min-w-0">
                                        <p class="text-xs font-semibold text-slate-800 dark:text-white">Lượt xem tăng mạnh</p>
                                        <p class="text-[11px] text-slate-500 mt-0.5">Bài viết đạt 10,000 lượt xem hôm nay.</p>
                                        <p class="text-[10px] text-slate-400 mt-1">3 ngày trước</p>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <%-- Nút Dark/Light mode --%>
                    <button id="themeToggleBtn" onclick="toggleTheme()"
                            class="p-2 rounded-lg hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors text-slate-500"
                            title="Chuyển giao diện">
                        <span id="themeIcon" class="material-symbols-outlined">light_mode</span>
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
                            <a href="${pageContext.request.contextPath}/journalist/create-article"
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
                                                    <% String imgUrl = a.getDisplayImageUrl(request.getContextPath()); %>
                                                    <img alt="<%= a.getTitle() %>"
                                                        class="size-full object-cover opacity-80"
                                                        src="<%= imgUrl %>" />
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
                                                <%
                                                    String st = a.getStatus() != null ? a.getStatus() : "";
                                                    boolean isPublished = "PUBLISHED".equals(st);
                                                    boolean isRejected  = "REJECTED".equals(st);
                                                %>

                                                <%-- Nút Chỉnh sửa: ẩn khi PUBLISHED --%>
                                                <% if (!isPublished) { %>
                                                <a href="${pageContext.request.contextPath}/journalist/create-article?id=<%= a.getId() %>"
                                                    class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-400 hover:text-primary transition-colors"
                                                    title="Chỉnh sửa">
                                                    <span class="material-symbols-outlined text-xl">edit</span>
                                                </a>
                                                <% } %>

                                                <%-- Nút Xem: luôn hiển thị --%>
                                                <a href="${pageContext.request.contextPath}/user/article?id=<%= a.getId() %>"
                                                    class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-400 hover:text-slate-200 transition-colors"
                                                    title="Xem bài viết">
                                                    <span class="material-symbols-outlined text-xl">visibility</span>
                                                </a>

                                                <%-- Nút Lưu trữ: chỉ hiện khi PUBLISHED --%>
                                                <% if (isPublished) { %>
                                                <a href="${pageContext.request.contextPath}/journalist/articles?action=archive&id=<%= a.getId() %>&page=<%= currentPage %>&<%= filterQS %>"
                                                    class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-400 hover:text-amber-500 transition-colors"
                                                    title="Lưu trữ bài viết"
                                                    onclick="return confirm('Bạn có chắc muốn lưu trữ bài viết này?')">
                                                    <span class="material-symbols-outlined text-xl">archive</span>
                                                </a>
                                                <% } %>

                                                <%-- Nút Xóa: hiện khi DRAFT / REJECTED / PENDING --%>
                                                <% if (isRejected || "DRAFT".equals(st) || "PENDING".equals(st)) { %>
                                                <a href="${pageContext.request.contextPath}/journalist/articles?action=delete&id=<%= a.getId() %>&page=<%= currentPage %>&<%= filterQS %>"
                                                    class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-400 hover:text-red-500 transition-colors"
                                                    title="Xóa bài viết"
                                                    onclick="return confirm('Bạn có chắc muốn xóa bài viết này? Hành động không thể hoàn tác.')">
                                                    <span class="material-symbols-outlined text-xl">delete</span>
                                                </a>
                                                <% } %>

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

        // ── Realtime search debounce 400ms ────────────────────────────────
        let searchTimer = null;
        const searchInput = document.getElementById('headerKeyword');

        // Tự động focus lại và đặt con trỏ cuối chuỗi sau khi reload
        if (searchInput && searchInput.value.length > 0) {
            searchInput.focus();
            const len = searchInput.value.length;
            searchInput.setSelectionRange(len, len);
        }

        searchInput.addEventListener('input', function () {
            clearTimeout(searchTimer);
            const keyword = this.value.trim();
            searchTimer = setTimeout(function () {
                window.location.href = '<%= servletUrl %>?page=1'
                    + '&keyword='  + encodeURIComponent(keyword)
                    + '&status='   + encodeURIComponent('<%= filterStatus %>')
                    + '&category=' + encodeURIComponent('<%= filterCategory %>')
                    + '&dateFrom=' + encodeURIComponent('<%= filterDateFrom %>')
                    + '&dateTo='   + encodeURIComponent('<%= filterDateTo %>');
            }, 400);
        });

        document.getElementById('headerSearchForm').addEventListener('submit', function (e) {
            e.preventDefault();
            clearTimeout(searchTimer);
            document.getElementById('filterKeywordHidden').value = searchInput.value;
            document.getElementById('filterForm').submit();
        });

        // ── Thông báo dropdown ────────────────────────────────────────
        var NOTIF_KEY_A = 'articles_read_notifs';

        function getReadSetA() {
            try { return JSON.parse(localStorage.getItem(NOTIF_KEY_A) || '[]'); } catch(e) { return []; }
        }
        function saveReadSetA(arr) {
            try { localStorage.setItem(NOTIF_KEY_A, JSON.stringify(arr)); } catch(e) {}
        }

        // Áp dụng trạng thái đã đọc khi load trang
        (function applyReadState() {
            var readIds = getReadSetA();
            document.querySelectorAll('.notif-item[data-id]').forEach(function(el) {
                if (readIds.indexOf(el.dataset.id) !== -1) {
                    el.classList.remove('unread');
                    var dot = el.querySelector('.unread-dot');
                    if (dot) dot.remove();
                }
            });
            updateNotifBadge();
        })();

        function toggleNotif() {
            document.getElementById('notifDropdown').classList.toggle('hidden');
        }

        function updateNotifBadge() {
            var count = document.querySelectorAll('.notif-item.unread').length;
            var dot   = document.getElementById('notifDot');
            var badge = document.getElementById('notifCount');
            if (count > 0) {
                dot.classList.remove('hidden');
                badge.textContent = count;
                badge.classList.remove('hidden');
            } else {
                dot.classList.add('hidden');
                badge.classList.add('hidden');
            }
        }

        function markOneRead(el) {
            if (el.classList.contains('unread')) {
                el.classList.remove('unread');
                var dot = el.querySelector('.unread-dot');
                if (dot) dot.remove();
                var readIds = getReadSetA();
                if (el.dataset.id && readIds.indexOf(el.dataset.id) === -1) {
                    readIds.push(el.dataset.id);
                    saveReadSetA(readIds);
                }
                updateNotifBadge();
            }
        }

        function markAllRead() {
            document.querySelectorAll('.notif-item.unread').forEach(function(el) {
                markOneRead(el);
            });
        }

        document.addEventListener('click', function (e) {
            var wrapper = document.getElementById('notifWrapper');
            if (wrapper && !wrapper.contains(e.target)) {
                document.getElementById('notifDropdown').classList.add('hidden');
            }
        });

        // ── Dark / Light mode ─────────────────────────────────────────────
        // Đồng bộ với các trang journalist khác qua localStorage('editor_theme')
        const html      = document.documentElement;
        const themeIcon = document.getElementById('themeIcon');

        // Áp dụng theme đã lưu ngay khi load (hỗ trợ key cũ 'theme')
        const savedTheme = localStorage.getItem('editor_theme') || localStorage.getItem('theme') || 'dark';
        if (savedTheme === 'light') {
            html.classList.remove('dark');
            if (themeIcon) themeIcon.textContent = 'dark_mode';
        } else {
            html.classList.add('dark');
            if (themeIcon) themeIcon.textContent = 'light_mode';
        }

        function toggleTheme() {
            const next = html.classList.contains('dark') ? 'light' : 'dark';
            localStorage.setItem('editor_theme', next);
            localStorage.setItem('theme', next); // giữ tương thích key cũ
            if (next === 'light') {
                html.classList.remove('dark');
                if (themeIcon) themeIcon.textContent = 'dark_mode';
            } else {
                html.classList.add('dark');
                if (themeIcon) themeIcon.textContent = 'light_mode';
            }
        }
    </script>
</body>
</html>
