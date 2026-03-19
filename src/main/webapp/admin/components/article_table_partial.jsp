<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<c:set var="startItem" value="${totalArticles == 0 ? 0 : (currentPage - 1) * limit + 1}" />
<c:set var="endItem"   value="${(currentPage * limit) > totalArticles ? totalArticles : (currentPage * limit)}" />

<div id="article-ajax-bundle">
    <%-- Toolbar --%>
    <div class="p-4 border-b border-slate-100 dark:border-slate-700 flex items-center justify-between bg-slate-50/50 dark:bg-slate-900/20 flex-wrap gap-3">
        <div class="flex items-center gap-3 flex-wrap">
            <input class="rounded border-slate-300 text-primary focus:ring-primary" type="checkbox" id="selectAll" onclick="toggleAll(this)" />
            <span class="text-sm font-medium text-slate-600 dark:text-slate-400">Chọn tất cả</span>
            <button onclick="handleBulkApprove(event)"
                class="px-3 py-1.5 bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 rounded-md text-xs font-bold hover:bg-green-200 transition-colors flex items-center gap-1">
                <span class="material-icons text-[14px]">check_circle</span>Duyệt hàng loạt
            </button>
            <button onclick="handleBulkDelete(event)"
                class="px-3 py-1.5 bg-slate-100 text-slate-700 dark:bg-slate-700 dark:text-slate-300 rounded-md text-xs font-bold hover:bg-slate-200 transition-colors flex items-center gap-1">
                <span class="material-icons text-[14px]">visibility_off</span>Ẩn hàng loạt
            </button>
        </div>
        <p class="text-sm text-slate-500">
            Hiển thị <span class="font-semibold text-slate-800 dark:text-white">${startItem}–${endItem}</span>
            / <span class="font-semibold text-slate-800 dark:text-white">${totalArticles}</span>
        </p>
    </div>

    <div class="overflow-x-auto">
        <table class="w-full text-left">
            <thead>
                <tr class="bg-slate-50 dark:bg-slate-900/50 border-b border-slate-100 dark:border-slate-700">
                    <th class="px-4 py-3 w-10"></th>
                    <th class="px-4 py-3 text-[11px] font-bold text-slate-400 uppercase tracking-wider">Bài viết</th>
                    <th class="px-4 py-3 text-[11px] font-bold text-slate-400 uppercase tracking-wider">Danh mục</th>
                    <th class="px-4 py-3 text-[11px] font-bold text-slate-400 uppercase tracking-wider">Tác giả</th>
                    <th class="px-4 py-3 text-[11px] font-bold text-slate-400 uppercase tracking-wider text-center">Trạng thái</th>
                    <th class="px-4 py-3 text-[11px] font-bold text-slate-400 uppercase tracking-wider text-center">
                        <button onclick="AdminContent.toggleSort('views')" class="flex items-center gap-1 mx-auto hover:text-primary transition-colors">
                            Lượt xem <span class="material-icons text-[14px]">swap_vert</span>
                        </button>
                    </th>
                    <th class="px-4 py-3 text-[11px] font-bold text-slate-400 uppercase tracking-wider">Người duyệt</th>
                    <th class="px-4 py-3 text-[11px] font-bold text-slate-400 uppercase tracking-wider text-right">Thao tác</th>
                </tr>
            </thead>
            <tbody id="articleTableBody" class="divide-y divide-slate-100 dark:divide-slate-700/80">
                <c:choose>
                    <c:when test="${empty articles}">
                        <tr><td colspan="8" class="text-center text-slate-400 py-16">
                            <span class="material-icons text-5xl block mb-3 text-slate-300">search_off</span>
                            Không tìm thấy bài viết nào.
                        </td></tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach items="${articles}" var="a">
                            <c:set var="sumEscaped" value="${fn:replace(a.summary, '\"', '&quot;')}" />
                            <tr class="hover:bg-slate-50/80 dark:hover:bg-slate-700/20 transition-colors group ${a.status == 'PENDING' ? 'bg-amber-50/30 dark:bg-amber-900/10' : ''}">
                                <td class="px-4 py-4">
                                    <input class="rounded border-slate-300 text-primary focus:ring-primary article-checkbox" type="checkbox" value="${a.id}" data-status="${a.status}" />
                                </td>
                                <td class="px-4 py-4">
                                    <div class="flex items-center gap-3">
                                        <img alt="${a.title}" class="w-12 h-12 rounded-lg object-cover flex-shrink-0 cursor-pointer"
                                            src="${a.getDisplayImageUrl(pageContext.request.contextPath)}"
                                            onclick="window.open('${pageContext.request.contextPath}/user/article?id=${a.id}', '_blank')" />
                                        <div class="min-w-0">
                                            <h4 class="text-sm font-semibold text-slate-800 dark:text-white hover:text-primary cursor-pointer truncate max-w-[200px]"
                                                onclick="window.open('${pageContext.request.contextPath}/user/article?id=${a.id}', '_blank')">${a.title}</h4>
                                            <p class="text-[11px] text-slate-400 mt-0.5">
                                                <c:choose>
                                                    <c:when test="${not empty a.createdAt}"><fmt:formatDate value="${a.createdAt}" pattern="dd/MM/yyyy HH:mm"/></c:when>
                                                    <c:otherwise>—</c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-4 py-4 text-sm text-slate-500 dark:text-slate-400">${not empty a.categoryName ? a.categoryName : 'N/A'}</td>
                                <td class="px-4 py-4 text-sm font-medium text-slate-700 dark:text-slate-300">${not empty a.authorName ? a.authorName : 'Khuyết danh'}</td>
                                <td class="px-4 py-4 text-center">
                                    <span class="px-2.5 py-1 text-[10px] font-bold rounded-full whitespace-nowrap ${a.statusBadgeClass}">${a.statusLabel}</span>
                                </td>
                                <td class="px-4 py-4 text-center text-slate-400">
                                    <div class="flex items-center justify-center gap-1 text-[12px]">
                                        <span class="material-icons text-[14px]">visibility</span>${a.formattedViews}
                                    </div>
                                </td>
                                <td class="px-4 py-4 text-sm text-slate-500">${not empty a.reviewerName ? a.reviewerName : (a.status == 'PUBLISHED' ? 'AI' : '—')}</td>
                                <td class="px-4 py-4 text-right">
                                    <div class="flex justify-end gap-0.5">
                                        <%-- Edit --%>
                                        <a href="${pageContext.request.contextPath}/staff/edit-article?id=${a.id}&adminMode=true"
                                            class="p-2 text-slate-400 hover:text-blue-500 hover:bg-blue-50 dark:hover:bg-blue-900/20 rounded-lg transition-all" title="Chỉnh sửa">
                                            <span class="material-symbols-outlined text-[20px]">edit</span>
                                        </a>
                                        <%-- Status actions --%>
                                        <c:choose>
                                            <c:when test="${a.status == 'PENDING'}">
                                                <button type="button" onclick="handleModerationAction(event, ${a.id}, 'approve')"
                                                    class="p-2 text-green-500 hover:bg-green-50 dark:hover:bg-green-900/20 rounded-lg transition-all" title="Duyệt">
                                                    <span class="material-symbols-outlined text-[20px]">check_circle</span>
                                                </button>
                                                <button type="button" onclick="AdminContent.openRejectModal(${a.id})"
                                                    class="p-2 text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all" title="Từ chối">
                                                    <span class="material-symbols-outlined text-[20px]">cancel</span>
                                                </button>
                                            </c:when>
                                            <c:when test="${a.status == 'PUBLISHED'}">
                                                <button type="button" onclick="handleModerationAction(event, ${a.id}, 'archive')"
                                                    class="p-2 text-slate-500 hover:bg-slate-200 dark:hover:bg-slate-700 rounded-lg transition-all" title="Lưu trữ">
                                                    <span class="material-symbols-outlined text-[20px]">archive</span>
                                                </button>
                                            </c:when>
                                        </c:choose>
                                        <%-- Toggle visibility --%>
                                        <c:choose>
                                            <c:when test="${a.status == 'ARCHIVED'}">
                                                <button type="button" onclick="handleModerationAction(event, ${a.id}, 'approve')"
                                                    class="p-2 text-slate-400 hover:text-green-600 hover:bg-green-50 dark:hover:bg-green-900/20 rounded-lg transition-all" title="Đang ẩn – bấm để hiện lại">
                                                    <span class="material-symbols-outlined text-[20px]">visibility_off</span>
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <button type="button" onclick="handleModerationAction(event, ${a.id}, 'hide')"
                                                    class="p-2 text-slate-400 hover:text-slate-700 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg transition-all" title="Đang hiện – bấm để ẩn">
                                                    <span class="material-symbols-outlined text-[20px]">visibility</span>
                                                </button>
                                            </c:otherwise>
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

    <%-- Pagination --%>
    <div class="flex items-center justify-between p-4 border-t border-slate-100 dark:border-slate-700 bg-slate-50 dark:bg-slate-800/50">
        <p class="text-xs font-medium text-slate-500">Tổng <span class="text-slate-900 dark:text-white font-bold">${totalArticles}</span> bài viết</p>
        <div class="flex items-center gap-1.5">
            <c:if test="${currentPage > 1}">
                <a href="javascript:void(0);" onclick="changePage(${currentPage - 1})"
                    class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-slate-600 hover:bg-slate-100 dark:hover:bg-slate-700 text-xs font-semibold">Trước</a>
            </c:if>
            <c:forEach begin="1" end="${totalPages}" var="i">
                <c:choose>
                    <c:when test="${i == currentPage}">
                        <span class="px-4 py-1.5 rounded-md bg-primary text-white text-xs font-bold shadow">${i}</span>
                    </c:when>
                    <c:when test="${i <= 2 || i >= totalPages - 1 || (i >= currentPage - 1 && i <= currentPage + 1)}">
                        <a href="javascript:void(0);" onclick="changePage(${i})"
                            class="px-4 py-1.5 rounded-md border border-slate-200 dark:border-slate-600 hover:bg-slate-100 dark:hover:bg-slate-700 text-xs font-semibold text-slate-600 dark:text-slate-300">${i}</a>
                    </c:when>
                    <c:when test="${(i == 3 && currentPage > 4) || (i == totalPages - 2 && currentPage < totalPages - 3)}">
                        <span class="px-2 text-slate-400 text-xs">…</span>
                    </c:when>
                </c:choose>
            </c:forEach>
            <c:if test="${currentPage < totalPages}">
                <a href="javascript:void(0);" onclick="changePage(${currentPage + 1})"
                    class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-slate-600 hover:bg-slate-100 dark:hover:bg-slate-700 text-xs font-semibold">Tiếp</a>
            </c:if>
        </div>
    </div>
</div>