<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="ctx" value="${pageContext.request.contextPath}" />
<c:set var="hasActiveFilter" value="${not empty filterKeyword or (not empty filterStatus and filterStatus != 'ALL') or (not empty filterCategory and filterCategory != 'ALL') or not empty filterDateFrom or not empty filterDateTo}" />
<c:set var="startIndex" value="${totalArticles == 0 ? 0 : (currentPage - 1) * pageSize + 1}" />
<c:set var="endIndex" value="${currentPage * pageSize > totalArticles ? totalArticles : currentPage * pageSize}" />

<!DOCTYPE html>
<html class="dark" lang="vi">
<head>
    <jsp:include page="components/head.jsp" />
    <title>Quản lý Bài viết</title>
</head>
<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen">
    <div class="flex h-screen overflow-hidden">
        <jsp:include page="components/sidebar.jsp">
            <jsp:param name="activePage" value="articles" />
        </jsp:include>
        <main class="flex-1 flex flex-col min-w-0 bg-background-light dark:bg-background-dark">

            <%-- ═══ HEADER ══════════════════════════════════════════════════ --%>
            <jsp:include page="components/header.jsp">
                <jsp:param name="pageTitle" value="Quản lý Bài viết" />
            </jsp:include>

            <%-- Toasts --%>
            <c:if test="${param.submitted == 'true'}">
                <div id="toast-success" class="fixed top-20 right-5 z-[10002] pointer-events-none">
                    <div class="bg-emerald-500 text-white px-6 py-4 rounded-2xl shadow-2xl flex items-center gap-3 pointer-events-auto animate-in fade-in slide-in-from-top-4 duration-300">
                        <div>
                            <p class="font-black tracking-tight text-sm">Gửi thành công!</p>
                            <p class="text-xs opacity-90">Bài viết của bạn đã được gửi đi và đang chờ duyệt.</p>
                        </div>
                    </div>
                </div>
            </c:if>
            <c:if test="${not empty param.error}">
                <div id="toast-error" class="fixed top-20 right-5 z-[10002] pointer-events-none">
                    <div class="bg-red-500 text-white px-6 py-4 rounded-2xl shadow-2xl flex items-center gap-3 pointer-events-auto animate-in fade-in slide-in-from-top-4 duration-300">
                        <div>
                            <p class="font-black tracking-tight text-sm">Thất bại!</p>
                            <p class="text-xs opacity-90">Đã có lỗi xảy ra. Vui lòng thử lại.</p>
                        </div>
                    </div>
                </div>
            </c:if>

            <div class="flex-1 overflow-y-auto">
                <div class="p-8 max-w-[1200px] mx-auto space-y-6">

                    <%-- HEADER + ACTIONS --%>
                        <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-2">
                            <div class="flex items-center gap-4">
                                <div>
                                    <h3 class="text-xl font-bold">Bài viết của tôi</h3>
                                    <p class="text-slate-500 dark:text-slate-400 text-xs mt-1">
                                        Quản lý <span class="text-slate-900 dark:text-white font-semibold">${totalArticles}</span> bài viết của bạn
                                    </p>
                                </div>
                                <div class="h-8 w-px bg-slate-200 dark:bg-border-dark hidden sm:block"></div>
                                <form method="get" action="${ctx}/journalist/articles" id="headerSearchForm" class="relative group">
                                    <input type="hidden" name="status"   value="${filterStatus}">
                                    <input type="hidden" name="category" value="${filterCategory}">
                                    <input type="hidden" name="dateFrom" value="${filterDateFrom}">
                                    <input type="hidden" name="dateTo"   value="${filterDateTo}">
                                    <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-lg transition-colors group-focus-within:text-primary">search</span>
                                    <input id="headerKeyword" name="keyword" value="${filterKeyword}"
                                        class="bg-white dark:bg-slate-900 border border-slate-200 dark:border-border-dark rounded-xl py-2 pl-10 pr-4 w-72 focus:ring-2 focus:ring-primary/20 focus:border-primary text-xs transition-all shadow-sm"
                                        placeholder="Tìm bài viết..." type="text" />
                                </form>
                            </div>
                        <div class="flex items-center gap-3">
                            <button onclick="toggleFilterPanel()"
                                class="flex items-center gap-2 px-3 py-2 bg-white dark:bg-slate-800 border border-slate-200 dark:border-border-dark hover:border-primary/50 rounded-lg text-xs font-semibold transition-all shadow-sm${hasActiveFilter ? ' ring-2 ring-primary/40' : ''}">
                                <span class="material-symbols-outlined text-sm">tune</span>
                                Bộ lọc Nâng cao
                                <c:if test="${hasActiveFilter}">
                                    <span class="size-1.5 rounded-full bg-primary inline-block"></span>
                                </c:if>
                            </button>
                            <a href="${ctx}/journalist/create-article"
                                class="flex items-center gap-2 px-4 py-2 bg-primary hover:bg-primary/90 text-white rounded-lg text-xs font-semibold transition-all shadow-sm">
                                <span class="material-symbols-outlined text-sm">add</span>
                                Tạo Bài viết Mới
                            </a>
                        </div>
                    </div>

                    <%-- PANEL BỘ LỌC NÂNG CAO --%>
                    <div id="filterPanel" class="${hasActiveFilter ? '' : 'hidden'} bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm overflow-hidden">
                        <div class="px-6 py-3.5 border-b border-slate-100 dark:border-border-dark/50 flex items-center justify-between">
                            <span class="text-xs font-bold text-slate-600 dark:text-slate-300 flex items-center gap-2">
                                <span class="material-symbols-outlined text-sm text-primary">filter_list</span>
                                Bộ lọc Nâng cao
                            </span>
                            <c:if test="${hasActiveFilter}">
                                <a href="${ctx}/journalist/articles"
                                   class="text-xs text-red-500 hover:text-red-400 font-semibold flex items-center gap-1 transition-colors">
                                    <span class="material-symbols-outlined text-sm">close</span>
                                    Xoá bộ lọc
                                </a>
                            </c:if>
                        </div>
                        <form method="get" action="${ctx}/journalist/articles" id="filterForm">
                            <input type="hidden" name="keyword" id="filterKeywordHidden" value="${filterKeyword}">
                            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 p-5">

                                <div class="space-y-1.5">
                                    <label class="text-[11px] font-semibold text-slate-400 uppercase tracking-wide">Trạng thái</label>
                                    <select name="status"
                                        class="w-full bg-slate-100 dark:bg-slate-800 border-none rounded-lg px-3 py-2 text-xs font-medium focus:ring-2 focus:ring-primary outline-none transition-all">
                                        <option value="ALL" ${filterStatus == 'ALL' or empty filterStatus ? 'selected' : ''}>Tất cả trạng thái</option>
                                        <option value="PUBLISHED" ${filterStatus == 'PUBLISHED' ? 'selected' : ''}>Đã xuất bản</option>
                                        <option value="DRAFT"     ${filterStatus == 'DRAFT' ? 'selected' : ''}>Bản nháp</option>
                                        <option value="PENDING"   ${filterStatus == 'PENDING' ? 'selected' : ''}>Đang chờ duyệt</option>
                                        <option value="REJECTED"  ${filterStatus == 'REJECTED' ? 'selected' : ''}>Bị từ chối</option>
                                    </select>
                                </div>

                                <div class="space-y-1.5">
                                    <label class="text-[11px] font-semibold text-slate-400 uppercase tracking-wide">Danh mục</label>
                                    <select name="category"
                                        class="w-full bg-slate-100 dark:bg-slate-800 border-none rounded-lg px-3 py-2 text-xs font-medium focus:ring-2 focus:ring-primary outline-none transition-all">
                                        <option value="ALL" ${filterCategory == 'ALL' or empty filterCategory ? 'selected' : ''}>Tất cả danh mục</option>
                                        <c:forEach var="cat" items="${categories}">
                                            <option value="${cat}" ${cat == filterCategory ? 'selected' : ''}>${cat}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="space-y-1.5">
                                    <label class="text-[11px] font-semibold text-slate-400 uppercase tracking-wide">Từ ngày</label>
                                    <input type="date" name="dateFrom" value="${filterDateFrom}"
                                        class="w-full bg-slate-100 dark:bg-slate-800 border-none rounded-lg px-3 py-2 text-xs font-medium focus:ring-2 focus:ring-primary outline-none transition-all" />
                                </div>

                                <div class="space-y-1.5">
                                    <label class="text-[11px] font-semibold text-slate-400 uppercase tracking-wide">Đến ngày</label>
                                    <input type="date" name="dateTo" value="${filterDateTo}"
                                        class="w-full bg-slate-100 dark:bg-slate-800 border-none rounded-lg px-3 py-2 text-xs font-medium focus:ring-2 focus:ring-primary outline-none transition-all" />
                                </div>

                            </div>
                            <div class="px-5 pb-4 flex justify-end gap-2">
                                <a href="${ctx}/journalist/articles"
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

                                <c:choose>
                                    <c:when test="${empty articles}">
                                        <tr>
                                            <td colspan="5" class="table-cell text-center text-slate-400 py-12">
                                                <c:out value="${hasActiveFilter ? 'Không tìm thấy bài viết nào phù hợp.' : 'Chưa có bài viết nào.'}" />
                                            </td>
                                        </tr>
                                    </c:when>
                                    <c:otherwise>
                                        <c:forEach var="a" items="${articles}">
                                            <tr class="hover:bg-slate-50/50 dark:hover:bg-slate-800/30 transition-colors">
                                                <td class="table-cell">
                                                    <div class="flex items-center gap-3">
                                                        <div class="size-12 rounded-lg bg-slate-200 dark:bg-slate-800 overflow-hidden shrink-0">
                                                            <img alt="${a.title}" class="size-full object-cover opacity-80" src="${a.getDisplayImageUrl(ctx)}" />
                                                        </div>
                                                        <div class="min-w-0">
                                                            <p class="font-bold text-slate-900 dark:text-white truncate">${a.title}</p>
                                                            <p class="text-[11px] text-slate-400 font-medium">
                                                                <c:out value="${not empty a.categoryName ? a.categoryName : 'Chưa phân loại'}" />
                                                            </p>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="table-cell">
                                                    <div class="badge-base ${a.getStatusBadgeClass()} ring-1 ring-inset w-fit">
                                                        <span class="size-1.5 rounded-full ${a.getStatusDotClass()}"></span>
                                                        <c:choose>
                                                            <c:when test="${a.status == 'PUBLISHED'}">Đã xuất bản</c:when>
                                                            <c:when test="${a.status == 'PENDING'}">Chờ duyệt</c:when>
                                                            <c:when test="${a.status == 'DRAFT'}">Bản nháp</c:when>
                                                            <c:when test="${a.status == 'REJECTED'}">Bị từ chối</c:when>
                                                            <c:otherwise>${a.getStatusLabel()}</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </td>
                                                <td class="table-cell font-medium">${a.formattedViews}</td>
                                                <td class="table-cell text-slate-500 text-xs">
                                                    <c:choose>
                                                        <c:when test="${not empty a.createdAt}">
                                                            <fmt:formatDate value="${a.createdAt}" pattern="dd/MM/yyyy" />
                                                        </c:when>
                                                        <c:otherwise>&#8212;</c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="table-cell">
                                                    <div class="flex items-center justify-end gap-1">
                                                        <c:set var="st" value="${not empty a.status ? a.status : ''}" />
                                                        <c:set var="isPublished" value="${st == 'PUBLISHED'}" />
                                                        <c:set var="isRejected" value="${st == 'REJECTED'}" />

                                                        <%-- Nút Chỉnh sửa: ẩn khi PUBLISHED --%>
                                                        <c:if test="${!isPublished}">
                                                            <a href="${ctx}/journalist/create-article?id=${a.id}"
                                                                class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-400 hover:text-primary transition-colors"
                                                                title="Chỉnh sửa">
                                                                <span class="material-symbols-outlined text-xl">edit</span>
                                                            </a>
                                                        </c:if>

                                                        <%-- Nút Xem: luôn hiển thị --%>
                                                        <a href="${ctx}/user/article?id=${a.id}"
                                                            class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-400 hover:text-slate-200 transition-colors"
                                                            title="Xem bài viết">
                                                            <span class="material-symbols-outlined text-xl">visibility</span>
                                                        </a>

                                                        <c:if test="${isPublished}">
                                                            <c:url var="archiveUrl" value="/journalist/articles">
                                                                <c:param name="action" value="archive" />
                                                                <c:param name="id" value="${a.id}" />
                                                                <c:param name="page" value="${currentPage}" />
                                                                <c:param name="keyword" value="${filterKeyword}" />
                                                                <c:param name="status" value="${filterStatus}" />
                                                                <c:param name="category" value="${filterCategory}" />
                                                                <c:param name="dateFrom" value="${filterDateFrom}" />
                                                                <c:param name="dateTo" value="${filterDateTo}" />
                                                            </c:url>
                                                            <a href="${archiveUrl}"
                                                                class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-400 hover:text-amber-500 transition-colors"
                                                                title="Lưu trữ bài viết"
                                                                onclick="return confirm('Bạn có chắc muốn lưu trữ bài viết này?')">
                                                                <span class="material-symbols-outlined text-xl">archive</span>
                                                            </a>
                                                        </c:if>

                                                        <c:if test="${isRejected or st == 'DRAFT' or st == 'PENDING'}">
                                                            <c:url var="deleteUrl" value="/journalist/articles">
                                                                <c:param name="action" value="delete" />
                                                                <c:param name="id" value="${a.id}" />
                                                                <c:param name="page" value="${currentPage}" />
                                                                <c:param name="keyword" value="${filterKeyword}" />
                                                                <c:param name="status" value="${filterStatus}" />
                                                                <c:param name="category" value="${filterCategory}" />
                                                                <c:param name="dateFrom" value="${filterDateFrom}" />
                                                                <c:param name="dateTo" value="${filterDateTo}" />
                                                            </c:url>
                                                            <a href="${deleteUrl}"
                                                                class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-400 hover:text-red-500 transition-colors"
                                                                title="Xóa bài viết"
                                                                onclick="return confirm('Bạn có chắc muốn xóa bài viết này? Hành động không thể hoàn tác.')">
                                                                <span class="material-symbols-outlined text-xl">delete</span>
                                                            </a>
                                                        </c:if>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>

                                </tbody>
                            </table>
                        </div>
                    </div>

                    <%-- PAGINATION --%>
                    <div class="flex items-center justify-between py-6 border-t border-slate-200 dark:border-border-dark">
                        <p class="text-xs font-medium text-slate-500 dark:text-slate-400">
                            Hiển thị <span class="text-slate-900 dark:text-white">${totalArticles == 0 ? 0 : startIndex}&#8211;${endIndex}</span> trong <span class="text-slate-900 dark:text-white">${totalArticles}</span> bài viết
                        </p>

                        <div class="flex items-center gap-1.5">
                            <c:set var="wStart" value="${currentPage - 2 > 1 ? currentPage - 2 : 1}" />
                            <c:set var="wEnd" value="${currentPage + 2 < totalPages ? currentPage + 2 : totalPages}" />

                            <%-- Nút Trước --%>
                            <c:choose>
                                <c:when test="${currentPage <= 1}">
                                    <button disabled class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark disabled:opacity-40 transition-all text-xs font-semibold">Trước</button>
                                </c:when>
                                <c:otherwise>
                                    <c:url var="prevPageUrl" value="/journalist/articles">
                                        <c:param name="page" value="${currentPage - 1}" />
                                        <c:param name="keyword" value="${filterKeyword}" />
                                        <c:param name="status" value="${filterStatus}" />
                                        <c:param name="category" value="${filterCategory}" />
                                        <c:param name="dateFrom" value="${filterDateFrom}" />
                                        <c:param name="dateTo" value="${filterDateTo}" />
                                    </c:url>
                                    <a href="${prevPageUrl}" class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800 transition-all text-xs font-semibold">Trước</a>
                                </c:otherwise>
                            </c:choose>

                            <c:if test="${wStart > 1}">
                                <c:url var="firstPageUrl" value="/journalist/articles">
                                    <c:param name="page" value="1" />
                                    <c:param name="keyword" value="${filterKeyword}" />
                                    <c:param name="status" value="${filterStatus}" />
                                    <c:param name="category" value="${filterCategory}" />
                                    <c:param name="dateFrom" value="${filterDateFrom}" />
                                    <c:param name="dateTo" value="${filterDateTo}" />
                                </c:url>
                                <a href="${firstPageUrl}" class="px-4 py-1.5 rounded-md border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800 transition-all text-xs font-semibold">1</a>
                                <c:if test="${wStart > 2}"><span class="px-1 text-slate-400 text-xs">&#8230;</span></c:if>
                            </c:if>

                            <c:forEach begin="${wStart}" end="${wEnd}" var="p">
                                <c:choose>
                                    <c:when test="${p == currentPage}">
                                        <button class="px-4 py-1.5 rounded-md bg-primary/10 text-primary text-xs font-bold">${p}</button>
                                    </c:when>
                                    <c:otherwise>
                                        <c:url var="pageUrl" value="/journalist/articles">
                                            <c:param name="page" value="${p}" />
                                            <c:param name="keyword" value="${filterKeyword}" />
                                            <c:param name="status" value="${filterStatus}" />
                                            <c:param name="category" value="${filterCategory}" />
                                            <c:param name="dateFrom" value="${filterDateFrom}" />
                                            <c:param name="dateTo" value="${filterDateTo}" />
                                        </c:url>
                                        <a href="${pageUrl}" class="px-4 py-1.5 rounded-md border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800 transition-all text-xs font-semibold">${p}</a>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>

                            <c:if test="${wEnd < totalPages}">
                                <c:if test="${wEnd < totalPages - 1}"><span class="px-1 text-slate-400 text-xs">&#8230;</span></c:if>
                                <c:url var="lastPageUrl" value="/journalist/articles">
                                    <c:param name="page" value="${totalPages}" />
                                    <c:param name="keyword" value="${filterKeyword}" />
                                    <c:param name="status" value="${filterStatus}" />
                                    <c:param name="category" value="${filterCategory}" />
                                    <c:param name="dateFrom" value="${filterDateFrom}" />
                                    <c:param name="dateTo" value="${filterDateTo}" />
                                </c:url>
                                <a href="${lastPageUrl}" class="px-4 py-1.5 rounded-md border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800 transition-all text-xs font-semibold">${totalPages}</a>
                            </c:if>

                            <%-- Nút Tiếp --%>
                            <c:choose>
                                <c:when test="${currentPage >= totalPages}">
                                    <button disabled class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark disabled:opacity-40 transition-all text-xs font-semibold">Tiếp</button>
                                </c:when>
                                <c:otherwise>
                                    <c:url var="nextPageUrl" value="/journalist/articles">
                                        <c:param name="page" value="${currentPage + 1}" />
                                        <c:param name="keyword" value="${filterKeyword}" />
                                        <c:param name="status" value="${filterStatus}" />
                                        <c:param name="category" value="${filterCategory}" />
                                        <c:param name="dateFrom" value="${filterDateFrom}" />
                                        <c:param name="dateTo" value="${filterDateTo}" />
                                    </c:url>
                                    <a href="${nextPageUrl}" class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800 transition-all text-xs font-semibold">Tiếp</a>
                                </c:otherwise>
                            </c:choose>
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

        let searchTimer = null;
        const searchInput = document.getElementById('headerKeyword');

        if (searchInput && searchInput.value.length > 0) {
            searchInput.focus();
            const len = searchInput.value.length;
            searchInput.setSelectionRange(len, len);
        }

        searchInput.addEventListener('input', function () {
            clearTimeout(searchTimer);
            const keyword = this.value.trim();
            searchTimer = setTimeout(function () {
                window.location.href = '${ctx}/journalist/articles?page=1'
                    + '&keyword='  + encodeURIComponent(keyword)
                    + '&status='   + encodeURIComponent('${filterStatus}')
                    + '&category=' + encodeURIComponent('${filterCategory}')
                    + '&dateFrom=' + encodeURIComponent('${filterDateFrom}')
                    + '&dateTo='   + encodeURIComponent('${filterDateTo}');
            }, 400);
        });

        document.getElementById('headerSearchForm').addEventListener('submit', function (e) {
            e.preventDefault();
            clearTimeout(searchTimer);
            document.getElementById('filterKeywordHidden').value = searchInput.value;
            document.getElementById('filterForm').submit();
        });

        document.addEventListener('DOMContentLoaded', function() {
            setTimeout(() => {
                const toasts = document.querySelectorAll('#toast-success, #toast-error');
                toasts.forEach(t => {
                    t.style.opacity = '0';
                    t.style.transform = 'translateY(-20px)';
                    t.style.transition = 'all 0.5s ease-out';
                    setTimeout(() => t.remove(), 500);
                });
            }, 4000);
        });
    </script>
</body>
</html>
