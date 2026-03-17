<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<c:set var="startItem" value="${totalArticles == 0 ? 0 : (currentPage - 1) * limit + 1}" />
<c:set var="endItem" value="${(currentPage * limit) > totalArticles ? totalArticles : (currentPage * limit)}" />

<div id="article-ajax-bundle">
    <div class="p-4 border-b border-slate-100 dark:border-slate-700 flex items-center justify-between bg-slate-50/50 dark:bg-slate-900/20">
        <div class="flex items-center gap-3">
            <input class="rounded border-slate-300 text-primary focus:ring-primary" type="checkbox" id="selectAll" onclick="toggleAll(this)" />
            <span class="text-sm font-medium text-slate-600 dark:text-slate-400">Chọn tất cả bài viết</span>
            <button onclick="handleBulkApprove(event)" class="ml-4 px-3 py-1.5 bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 rounded-md text-xs font-bold hover:bg-green-200 transition-colors">Duyệt hàng loạt</button>
        </div>
        <div class="text-sm text-slate-500">
            Đang hiển thị từ <span class="font-semibold text-slate-800 dark:text-white">${startItem}-${endItem}</span> trên tổng số <span class="font-semibold text-slate-800 dark:text-white">${totalArticles}</span> bài viết
        </div>
    </div>

    <div class="overflow-x-auto">
        <table class="w-full text-left table-auto">
            <thead>
                <tr class="bg-slate-50 dark:bg-slate-900/50 border-b border-slate-100 dark:border-slate-700">
                    <th class="px-6 py-4 w-12"></th>
                    <th class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider">Bài viết</th>
                    <th class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider">Danh mục</th>
                    <th class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider">Tác giả</th>
                    <th class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider text-center">Trạng thái</th>
                    <th class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider text-center">Thống kê</th>
                    <th class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider">Người duyệt</th>
                    <th class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider text-right">Thao tác</th>
                </tr>
            </thead>
            <tbody id="articleTableBody" class="divide-y divide-slate-100 dark:divide-slate-700">
                <c:choose>
                    <c:when test="${empty articles}">
                        <tr><td colspan="8" class="text-center text-slate-400 py-12">Không tìm thấy bài viết nào phù hợp.</td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${articles}" var="a">
                            <tr class="hover:bg-slate-50 dark:hover:bg-slate-700/20 transition-colors cursor-pointer group ${a.status == 'PENDING' ? 'bg-amber-50/30 dark:bg-amber-900/10' : ''}">
                                <td class="px-6 py-4">
                                    <input class="rounded border-slate-300 text-primary focus:ring-primary article-checkbox" type="checkbox" value="${a.id}" data-status="${a.status}" />
                                </td>
                                <td class="px-6 py-4">
                                    <div class="flex items-center gap-4">
                                        <img alt="${a.title}" class="w-12 h-12 rounded object-cover" src="${a.getDisplayImageUrl(pageContext.request.contextPath)}" />
                                        <div class="min-w-0">
                                            <h4 class="text-sm font-semibold text-slate-800 dark:text-white group-hover:text-primary transition-colors truncate max-w-[200px]">${a.title}</h4>
                                            <p class="text-[11px] text-slate-500 mt-0.5">
                                                <c:choose>
                                                    <c:when test="${not empty a.createdAt}"><fmt:formatDate value="${a.createdAt}" pattern="dd/MM/yyyy/HH:mm" /></c:when>
                                                    <c:otherwise>—</c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4 text-sm font-medium text-slate-500 dark:text-slate-400">${not empty a.categoryName ? a.categoryName : 'N/A'}</td>
                                <td class="px-6 py-4"><a class="text-sm text-primary hover:underline font-medium" href="#">${not empty a.authorName ? a.authorName : 'Khuyết danh'}</a></td>
                                <td class="px-6 py-4 text-center"><span class="px-2.5 py-1 text-[10px] font-bold rounded-full whitespace-nowrap ${a.statusBadgeClass}">${a.statusLabel}</span></td>
                                <td class="px-6 py-4 text-center text-slate-400">
                                    <div class="flex items-center justify-center gap-2 text-[11px]"><span class="material-icons text-sm">visibility</span>${a.formattedViews}</div>
                                </td>
                                <td class="px-6 py-4">
                                    <div class="flex items-center gap-2">
                                        <span class="text-sm font-medium text-slate-600 dark:text-slate-400">
                                            ${not empty a.reviewerName ? a.reviewerName : (a.status == 'PUBLISHED' ? 'Hệ thống AI' : '—')}
                                        </span>
                                    </div>
                                </td>
                                <td class="px-6 py-4 text-right">
                                    <div class="flex justify-end gap-1">
                                        <a href="${pageContext.request.contextPath}/user/article?id=${a.id}" target="_blank" class="p-2 text-slate-400 hover:text-primary hover:bg-primary/10 rounded-lg transition-all" title="Xem bài viết">
                                            <span class="material-symbols-outlined text-[20px]">visibility</span>
                                        </a>
                                        <c:choose>
                                            <c:when test="${a.status == 'PENDING'}">
                                                <button type="button" onclick="handleModerationAction(event, ${a.id}, 'approve')" class="p-2 text-green-500 hover:bg-green-50 dark:hover:bg-green-900/20 rounded-lg transition-all"><span class="material-symbols-outlined text-[20px]">check_circle</span></button>
                                                <button type="button" onclick="handleModerationAction(event, ${a.id}, 'reject')" class="p-2 text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all"><span class="material-symbols-outlined text-[20px]">cancel</span></button>
                                            </c:when>
                                            <c:when test="${a.status == 'PUBLISHED'}">
                                                <button type="button" onclick="handleModerationAction(event, ${a.id}, 'archive')" class="p-2 text-slate-500 hover:bg-slate-200 dark:hover:bg-slate-700 rounded-lg transition-all"><span class="material-symbols-outlined text-[20px]">archive</span></button>
                                            </c:when>
                                            <c:when test="${a.status == 'ARCHIVED'}">
                                                <button type="button" onclick="handleModerationAction(event, ${a.id}, 'approve')" class="p-2 text-green-500 hover:bg-green-50 dark:hover:bg-green-900/20 rounded-lg transition-all"><span class="material-symbols-outlined text-[20px]">settings_backup_restore</span></button>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>

    <div class="flex items-center justify-between p-4 border-t border-slate-100 dark:border-slate-700 bg-slate-50 dark:bg-slate-800/50">
        <p class="text-xs font-medium text-slate-500">Hiển thị <span class="text-slate-900 dark:text-white">${not empty articles ? articles.size() : 0}</span> bài viết</p>
        <div class="flex items-center gap-1.5">
            <c:set var="prevClass" value="px-3 py-1.5 rounded-md border border-slate-200 dark:border-slate-600 hover:bg-slate-100 dark:hover:bg-slate-700 transition-all text-xs font-semibold ${currentPage <= 1 ? 'opacity-50 pointer-events-none' : ''}" />
            <a href="javascript:void(0);" onclick="changePage(${currentPage - 1})" class="${prevClass}">Trước</a>
            <c:forEach begin="1" end="${totalPages}" var="i">
                <c:choose>
                    <c:when test="${i == currentPage}"><span class="px-4 py-1.5 rounded-md bg-primary text-white text-xs font-bold shadow-md">${i}</span></c:when>
                    <c:when test="${i <= 3 || i >= totalPages - 2 || (i >= currentPage - 1 && i <= currentPage + 1)}">
                        <a href="javascript:void(0);" onclick="changePage(${i})" class="px-4 py-1.5 rounded-md border border-slate-200 dark:border-slate-600 hover:bg-slate-100 dark:hover:bg-slate-700 transition-all text-xs font-semibold text-slate-600 dark:text-slate-300">${i}</a>
                    </c:when>
                    <c:when test="${i == 4 && currentPage > 5}"><span class="px-2 text-slate-400">...</span></c:when>
                    <c:when test="${i == totalPages - 3 && currentPage < totalPages - 4}"><span class="px-2 text-slate-400">...</span></c:when>
                </c:choose>
            </c:forEach>
            <c:set var="nextClass" value="px-3 py-1.5 rounded-md border border-slate-200 dark:border-slate-600 hover:bg-slate-100 dark:hover:bg-slate-700 transition-all text-xs font-semibold ${currentPage >= totalPages ? 'opacity-50 pointer-events-none' : ''}" />
            <a href="javascript:void(0);" onclick="changePage(${currentPage + 1})" class="${nextClass}">Tiếp</a>
        </div>
    </div>
</div>