<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
            <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

                

                <c:set var="ctx" value="${pageContext.request.contextPath}" />
                <c:set var="sort" value="${not empty sort ? sort : 'latest'}" />
                <c:set var="keyword" value="${not empty keyword ? keyword : ''}" />
                <c:set var="hasKeyword" value="${not empty keyword}" />

                <c:url var="baseUrl" value="/journalist/comments">
                    <c:param name="sort" value="${sort}" />
                    <c:param name="keyword" value="${keyword}" />
                </c:url>
                <!DOCTYPE html>
                <html class="dark" lang="vi">

                <head>
                    <jsp:include page="components/head.jsp" />
                    <title>Quản lý Bình luận</title>
                    <style>
                        .badge-base {
                            display: inline-flex;
                            align-items: center;
                            gap: 0.375rem;
                            padding: 0.25rem 0.625rem;
                            border-radius: 9999px;
                            font-size: 0.65rem;
                            font-weight: 700;
                            letter-spacing: 0.05em;
                            text-transform: uppercase;
                        }

                        mark.hl {
                            background: rgba(13, 127, 242, 0.18);
                            color: inherit;
                            border-radius: 2px;
                            padding: 0 2px;
                        }
                    </style>
                </head>

                <body
                    class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen">
                    <div class="flex h-screen overflow-hidden">

                        <jsp:include page="components/sidebar.jsp">
                            <jsp:param name="activePage" value="comments" />
                        </jsp:include>

                        <main class="flex-1 flex flex-col min-w-0 bg-background-light dark:bg-background-dark">
                            <jsp:include page="components/header.jsp">
                                <jsp:param name="pageTitle" value="Kiểm duyệt Bình luận" />
                            </jsp:include>

                            <%-- Notifications (Top-Right) --%>
                                <c:if test="${param.success == 'true'}">
                                    <div id="toast-success" class="fixed top-20 right-5 z-[10002] pointer-events-none">
                                        <div
                                            class="bg-emerald-500 text-white px-6 py-4 rounded-2xl shadow-2xl flex items-center gap-3 pointer-events-auto animate-in fade-in slide-in-from-top-4 duration-300">
                                            <span class="material-symbols-outlined text-2xl">check_circle</span>
                                            <div>
                                                <p class="font-black tracking-tight text-sm">Thành công!</p>
                                                <p class="text-xs opacity-90">Thao tác của bạn đã được thực hiện.</p>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${not empty param.error}">
                                    <div id="toast-error" class="fixed top-20 right-5 z-[10002] pointer-events-none">
                                        <div
                                            class="bg-red-500 text-white px-6 py-4 rounded-2xl shadow-2xl flex items-center gap-3 pointer-events-auto animate-in fade-in slide-in-from-top-4 duration-300">
                                            <span class="material-symbols-outlined text-2xl">error</span>
                                            <div>
                                                <p class="font-black tracking-tight text-sm">Thất bại!</p>
                                                <p class="text-xs opacity-90">Đã có lỗi xảy ra. Vui lòng thử lại.</p>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>

                                <%-- CONTENT --%>
                                    <div class="flex-1 overflow-y-auto">
                                        <div class="p-8 max-w-5xl mx-auto space-y-6">

                                            <%-- Toolbar --%>
                                                <div
                                                    class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-2">
                                                    <div class="flex items-center gap-4">
                                                        <div>
                                                            <h3 class="text-xl font-bold">
                                                                <c:out
                                                                    value="${hasKeyword ? 'Kết quả tìm kiếm' : 'Nguồn Cấp dữ liệu Hoạt động'}" />
                                                            </h3>
                                                            <p class="text-slate-500 dark:text-slate-400 text-xs mt-1">
                                                                <c:choose>
                                                                    <c:when test="${hasKeyword}">
                                                                        Tìm thấy <strong
                                                                            class="text-slate-700 dark:text-slate-200">${totalComments}</strong>
                                                                        bình luận cho từ khoá "<span
                                                                            class="text-primary font-semibold">${keyword}</span>"
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        Đang xem xét <strong
                                                                            class="text-slate-700 dark:text-slate-200">${totalComments}</strong>
                                                                        bình luận từ độc giả
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </p>
                                                        </div>
                                                        <div
                                                            class="h-8 w-px bg-slate-200 dark:bg-border-dark hidden sm:block">
                                                        </div>
                                                        <form id="searchForm" method="get"
                                                            action="${ctx}/journalist/comments" class="relative group">
                                                            <span
                                                                class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-lg pointer-events-none transition-colors group-focus-within:text-primary">search</span>
                                                            <input id="searchInput" name="keyword" value="${keyword}"
                                                                type="text" autocomplete="off"
                                                                placeholder="Tìm kiếm bình luận..."
                                                                class="bg-white dark:bg-slate-900 border border-slate-200 dark:border-border-dark rounded-xl py-2 pl-10 pr-8 w-72 focus:ring-2 focus:ring-primary/20 focus:border-primary text-xs transition-all shadow-sm" />
                                                            <input type="hidden" name="sort" value="${sort}" />
                                                            <input type="hidden" name="page" value="1" />
                                                            <button type="button" id="clearSearch"
                                                                class="absolute right-2.5 top-1/2 -translate-y-1/2 text-slate-400 hover:text-red-500 transition-colors ${hasKeyword ? '' : 'invisible'}"
                                                                title="Xoá">
                                                                <span
                                                                    class="material-symbols-outlined text-base leading-none">close</span>
                                                            </button>
                                                        </form>
                                                    </div>
                                                    <div class="flex items-center gap-2">
                                                        <div class="relative">
                                                            <select id="sortSelect"
                                                                class="appearance-none bg-white dark:bg-slate-800 border border-slate-200
                                           dark:border-border-dark rounded-lg px-3 py-2 pr-8 text-xs font-semibold
                                           shadow-sm cursor-pointer focus:outline-none focus:ring-2 focus:ring-primary">
                                                                <option value="latest" ${sort=='latest' ? 'selected'
                                                                    : '' }>⬇ Mới nhất</option>
                                                                <option value="oldest" ${sort=='oldest' ? 'selected'
                                                                    : '' }>⬆ Cũ nhất</option>
                                                            </select>
                                                            <span class="material-symbols-outlined absolute right-2 top-1/2 -translate-y-1/2
                                         text-slate-400 text-sm pointer-events-none">expand_more</span>
                                                        </div>
                                                    </div>
                                                </div>

                                                <%-- Banner search đang active --%>
                                                    <c:if test="${hasKeyword}">
                                                        <div class="flex items-center gap-3 px-4 py-3 bg-primary/5 dark:bg-primary/10
                                border border-primary/20 rounded-xl text-xs">
                                                            <span
                                                                class="material-symbols-outlined text-primary text-lg">manage_search</span>
                                                            <span class="text-slate-600 dark:text-slate-300">
                                                                Đang lọc theo từ khoá: <strong
                                                                    class="text-primary">"${keyword}"</strong>
                                                            </span>
                                                            <a href="${ctx}/journalist/comments?sort=${sort}"
                                                                class="ml-auto flex items-center gap-1 px-3 py-1.5 bg-white dark:bg-slate-800
                                  border border-slate-200 dark:border-slate-700 rounded-lg font-semibold
                                  text-slate-600 dark:text-slate-300 hover:border-primary hover:text-primary transition-all">
                                                                <span
                                                                    class="material-symbols-outlined text-sm">close</span>
                                                                Xoá bộ lọc
                                                            </a>
                                                        </div>
                                                    </c:if>

                                                    <!-- ══════════════════ COMMENT LIST ══════════════════ -->
                                                    <div class="grid gap-4">
                                                        <c:choose>
                                                            <c:when test="${empty comments}">
                                                                <div class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200
                                    dark:border-border-dark p-16 text-center">
                                                                    <span
                                                                        class="material-symbols-outlined text-5xl text-slate-300 dark:text-slate-600">
                                                                        <c:out
                                                                            value="${hasKeyword ? 'search_off' : 'chat_bubble_outline'}" />
                                                                    </span>
                                                                    <p
                                                                        class="mt-4 text-slate-500 dark:text-slate-400 text-sm font-medium">
                                                                        <c:choose>
                                                                            <c:when test="${hasKeyword}">
                                                                                Không tìm thấy bình luận nào khớp với
                                                                                "${keyword}".
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                Chưa có bình luận nào cho bài viết của
                                                                                bạn.
                                                                            </c:otherwise>
                                                                        </c:choose>
                                                                    </p>
                                                                    <c:if test="${hasKeyword}">
                                                                        <a href="${ctx}/journalist/comments?sort=${sort}"
                                                                            class="inline-flex items-center gap-2 mt-4 px-4 py-2 bg-primary/10 text-primary
                                      rounded-lg text-xs font-semibold hover:bg-primary/20 transition-colors">
                                                                            <span
                                                                                class="material-symbols-outlined text-sm">arrow_back</span>
                                                                            Xem tất cả bình luận
                                                                        </a>
                                                                    </c:if>
                                                                </div>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:forEach var="c" items="${comments}">
                                                                    <c:set var="isSpam" value="${c.status == 'SPAM'}" />
                                                                    <c:set var="isHidden"
                                                                        value="${c.status == 'HIDDEN'}" />
                                                                    <c:set var="isReviewRequired"
                                                                        value="${isSpam or isHidden}" />

                                                                    <div
                                                                        class="group relative ${isReviewRequired ? 'bg-slate-50/50 dark:bg-slate-950/20 border-dashed border-red-200/50 dark:border-red-900/30' : 'bg-white dark:bg-slate-900 border-slate-200 dark:border-border-dark'} 
                                        rounded-2xl border shadow-sm hover:shadow-md transition-all duration-300 overflow-hidden">

                                                                        <c:if test="${isReviewRequired}">
                                                                            <div
                                                                                class="absolute top-0 right-0 px-3 py-1 bg-red-500 text-white text-[9px] font-black uppercase tracking-tighter rounded-bl-xl z-10">
                                                                                Vô hiệu hóa
                                                                            </div>
                                                                        </c:if>

                                                                        <div class="p-6">

                                                                            <%-- Avatar + Info + Badge --%>
                                                                                <div
                                                                                    class="flex justify-between items-start gap-4 mb-4">
                                                                                    <div class="flex items-start gap-3">
                                                                                        <div
                                                                                            class="size-10 rounded-full ${c.userAvatarBgClass} flex items-center justify-center font-bold shrink-0 text-sm">
                                                                                            ${c.userAvatar}
                                                                                        </div>
                                                                                        <div class="min-w-0">
                                                                                            <div
                                                                                                class="flex items-center flex-wrap gap-x-2">
                                                                                                <h5
                                                                                                    class="text-sm font-bold text-slate-900 dark:text-white">
                                                                                                    ${c.userName}</h5>
                                                                                                <span
                                                                                                    class="text-[11px] text-slate-400 font-medium">${c.formattedTime}</span>
                                                                                            </div>
                                                                                            <a href="${ctx}/user/article?id=${c.articleId}"
                                                                                                class="flex items-center gap-1.5 text-xs text-primary font-semibold mt-0.5 truncate hover:underline">
                                                                                                <span
                                                                                                    class="material-symbols-outlined text-[14px]">article</span>
                                                                                                ${c.articleTitle}
                                                                                            </a>
                                                                                        </div>
                                                                                    </div>
                                                                                    <div
                                                                                        class="badge-base ${c.statusBadgeClass} ring-1 ring-inset shrink-0">
                                                                                        <span
                                                                                            class="size-1.5 rounded-full ${c.statusDotClass}"></span>
                                                                                        <c:choose>
                                                                                            <c:when
                                                                                                test="${c.status == 'PUBLISHED'}">
                                                                                                Đã hiển thị</c:when>
                                                                                            <c:when
                                                                                                test="${c.status == 'PENDING'}">
                                                                                                Đang chờ</c:when>
                                                                                            <c:when
                                                                                                test="${c.status == 'HIDDEN'}">
                                                                                                Đã ẩn</c:when>
                                                                                            <c:when
                                                                                                test="${c.status == 'SPAM'}">
                                                                                                Vi phạm</c:when>
                                                                                            <c:otherwise>
                                                                                                ${c.statusLabel}
                                                                                            </c:otherwise>
                                                                                        </c:choose>
                                                                                    </div>
                                                                                </div>

                                                                                <%-- Nội dung --%>
                                                                                    <p
                                                                                        class="comment-content text-slate-600 dark:text-slate-300 text-sm leading-relaxed mb-4 pl-[52px] ${(isSpam or isHidden) ? 'italic text-slate-400 dark:text-slate-500' : ''}">
                                                                                        ${c.content}
                                                                                    </p>

                                                                                    <%-- Replies --%>
                                                                                        <c:if
                                                                                            test="${not empty c.replies}">
                                                                                            <div
                                                                                                class="pl-[52px] space-y-2 mb-4">
                                                                                                <c:forEach var="r"
                                                                                                    items="${c.replies}">
                                                                                                    <div
                                                                                                        class="flex items-start gap-2 bg-slate-50 dark:bg-slate-800/60 rounded-lg p-3">
                                                                                                        <div
                                                                                                            class="size-7 rounded-full ${r.userAvatarBgClass} flex items-center justify-center font-bold shrink-0 text-xs">
                                                                                                            ${r.userAvatar}
                                                                                                        </div>
                                                                                                        <div>
                                                                                                            <div
                                                                                                                class="flex items-center gap-2">
                                                                                                                <span
                                                                                                                    class="text-xs font-bold text-slate-900 dark:text-white">${r.userName}</span>
                                                                                                                <span
                                                                                                                    class="text-[10px] text-slate-400">${r.formattedTime}</span>
                                                                                                            </div>
                                                                                                            <p
                                                                                                                class="text-xs text-slate-600 dark:text-slate-300 mt-0.5">
                                                                                                                ${r.content}
                                                                                                            </p>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </c:forEach>
                                                                                            </div>
                                                                                        </c:if>

                                                                                        <%-- Actions --%>
                                                                                            <div
                                                                                                class="flex items-center justify-between pt-5 border-t border-slate-100 dark:border-slate-800/50 pl-[52px]">
                                                                                                <div
                                                                                                    class="flex items-center gap-5">
                                                                                                    <c:choose>
                                                                                                        <c:when
                                                                                                            test="${isReviewRequired}">
                                                                                                            <div
                                                                                                                class="flex items-center gap-2 text-slate-400 dark:text-slate-600 italic text-[11px]">
                                                                                                                <span
                                                                                                                    class="material-symbols-outlined text-base">lock</span>
                                                                                                                <span>Bình
                                                                                                                    luận
                                                                                                                    này
                                                                                                                    đã
                                                                                                                    bị
                                                                                                                    hạn
                                                                                                                    chế</span>
                                                                                                            </div>
                                                                                                        </c:when>
                                                                                                        <c:otherwise>
                                                                                                            <button
                                                                                                                onclick="toggleReply('reply-${c.id}')"
                                                                                                                class="flex items-center gap-1.5 text-slate-500 hover:text-primary transition-all text-[11px] font-bold uppercase tracking-widest group/btn">
                                                                                                                <span
                                                                                                                    class="material-symbols-outlined text-lg group-hover/btn:rotate-12 transition-transform">reply</span>
                                                                                                                Phản hồi
                                                                                                            </button>

                                                                                                            <form
                                                                                                                method="post"
                                                                                                                action="${ctx}/journalist/comments"
                                                                                                                class="inline">
                                                                                                                <input
                                                                                                                    type="hidden"
                                                                                                                    name="action"
                                                                                                                    value="hide" />
                                                                                                                <input
                                                                                                                    type="hidden"
                                                                                                                    name="commentId"
                                                                                                                    value="${c.id}" />
                                                                                                                <input
                                                                                                                    type="hidden"
                                                                                                                    name="page"
                                                                                                                    value="${currentPage}" />
                                                                                                                <input
                                                                                                                    type="hidden"
                                                                                                                    name="sort"
                                                                                                                    value="${sort}" />
                                                                                                                <c:if
                                                                                                                    test="${hasKeyword}">
                                                                                                                    <input
                                                                                                                        type="hidden"
                                                                                                                        name="keyword"
                                                                                                                        value="${keyword}" />
                                                                                                                </c:if>
                                                                                                                <button
                                                                                                                    type="submit"
                                                                                                                    class="flex items-center gap-1.5 text-slate-500 hover:text-slate-900 dark:hover:text-white text-[11px] font-bold uppercase tracking-widest transition-colors">
                                                                                                                    <span
                                                                                                                        class="material-symbols-outlined text-lg">visibility_off</span>
                                                                                                                    Ẩn
                                                                                                                </button>
                                                                                                            </form>
                                                                                                        </c:otherwise>
                                                                                                    </c:choose>
                                                                                                </div>
                                                                                                <div class="relative">
                                                                                                    <button
                                                                                                        type="button"
                                                                                                        onclick="toggleReportMenu('report-${c.id}')"
                                                                                                        class="flex items-center gap-1.5 text-slate-400 hover:text-red-500 transition-colors text-[11px] font-semibold uppercase tracking-wider">
                                                                                                        <span
                                                                                                            class="material-symbols-outlined text-lg">flag</span>
                                                                                                        <span>Báo
                                                                                                            cáo</span>
                                                                                                    </button>
                                                                                                    <div id="report-${c.id}"
                                                                                                        class="hidden absolute right-0 top-8 w-56 bg-white dark:bg-slate-900 border border-slate-200 dark:border-border-dark rounded-xl shadow-xl z-40">
                                                                                                        <div
                                                                                                            class="px-3 py-2 border-b border-slate-100 dark:border-border-dark">
                                                                                                            <p
                                                                                                                class="text-[11px] font-bold text-slate-500 uppercase tracking-wider">
                                                                                                                Báo cáo
                                                                                                                bình
                                                                                                                luận</p>
                                                                                                        </div>
                                                                                                        <div
                                                                                                            class="py-1">
                                                                                                            <c:forEach
                                                                                                                var="reason"
                                                                                                                items="${['OFFENSIVE', 'ADS', 'OFFTOPIC']}">
                                                                                                                <form
                                                                                                                    method="post"
                                                                                                                    action="${ctx}/journalist/comments">
                                                                                                                    <input
                                                                                                                        type="hidden"
                                                                                                                        name="action"
                                                                                                                        value="spam" />
                                                                                                                    <input
                                                                                                                        type="hidden"
                                                                                                                        name="commentId"
                                                                                                                        value="${c.id}" />
                                                                                                                    <input
                                                                                                                        type="hidden"
                                                                                                                        name="page"
                                                                                                                        value="${currentPage}" />
                                                                                                                    <input
                                                                                                                        type="hidden"
                                                                                                                        name="sort"
                                                                                                                        value="${sort}" />
                                                                                                                    <c:if
                                                                                                                        test="${hasKeyword}">
                                                                                                                        <input
                                                                                                                            type="hidden"
                                                                                                                            name="keyword"
                                                                                                                            value="${keyword}" />
                                                                                                                    </c:if>
                                                                                                                    <button
                                                                                                                        type="submit"
                                                                                                                        name="reason"
                                                                                                                        value="${reason}"
                                                                                                                        class="w-full text-left px-3 py-2 text-xs text-slate-600 dark:text-slate-200 hover:bg-slate-50 dark:hover:bg-slate-800">
                                                                                                                        <c:choose>
                                                                                                                            <c:when
                                                                                                                                test="${reason == 'OFFENSIVE'}">
                                                                                                                                Ngôn
                                                                                                                                từ
                                                                                                                                xúc
                                                                                                                                phạm
                                                                                                                                /
                                                                                                                                công
                                                                                                                                kích
                                                                                                                                cá
                                                                                                                                nhân
                                                                                                                            </c:when>
                                                                                                                            <c:when
                                                                                                                                test="${reason == 'ADS'}">
                                                                                                                                Spam
                                                                                                                                /
                                                                                                                                Quảng
                                                                                                                                cáo
                                                                                                                            </c:when>
                                                                                                                            <c:when
                                                                                                                                test="${reason == 'OFFTOPIC'}">
                                                                                                                                Lạc
                                                                                                                                chủ
                                                                                                                                đề
                                                                                                                                /
                                                                                                                                Không
                                                                                                                                liên
                                                                                                                                quan
                                                                                                                                bài
                                                                                                                                viết
                                                                                                                            </c:when>
                                                                                                                        </c:choose>
                                                                                                                    </button>
                                                                                                                </form>
                                                                                                            </c:forEach>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>

                                                                                            <%-- Reply form --%>
                                                                                                <c:if
                                                                                                    test="${!isSpam and !isHidden}">
                                                                                                    <div id="reply-${c.id}"
                                                                                                        class="hidden pl-[52px] mt-3">
                                                                                                        <form
                                                                                                            method="post"
                                                                                                            action="${ctx}/journalist/comments"
                                                                                                            class="flex gap-2">
                                                                                                            <input
                                                                                                                type="hidden"
                                                                                                                name="action"
                                                                                                                value="reply" />
                                                                                                            <input
                                                                                                                type="hidden"
                                                                                                                name="commentId"
                                                                                                                value="${c.id}" />
                                                                                                            <input
                                                                                                                type="hidden"
                                                                                                                name="articleId"
                                                                                                                value="${c.articleId}" />
                                                                                                            <input
                                                                                                                type="hidden"
                                                                                                                name="page"
                                                                                                                value="${currentPage}" />
                                                                                                            <input
                                                                                                                type="hidden"
                                                                                                                name="sort"
                                                                                                                value="${sort}" />
                                                                                                            <c:if
                                                                                                                test="${hasKeyword}">
                                                                                                                <input
                                                                                                                    type="hidden"
                                                                                                                    name="keyword"
                                                                                                                    value="${keyword}" />
                                                                                                            </c:if>
                                                                                                            <input
                                                                                                                type="text"
                                                                                                                name="replyContent"
                                                                                                                required
                                                                                                                placeholder="Nhập phản hồi của bạn..."
                                                                                                                class="flex-1 bg-slate-100 dark:bg-slate-800 border border-slate-200
                                                              dark:border-border-dark rounded-lg px-3 py-2 text-xs
                                                              focus:outline-none focus:ring-2 focus:ring-primary" />
                                                                                                            <button
                                                                                                                type="submit"
                                                                                                                class="px-4 py-2 bg-primary hover:bg-primary/90 text-white rounded-lg text-xs font-semibold transition-all">Gửi</button>
                                                                                                            <button
                                                                                                                type="button"
                                                                                                                onclick="toggleReply('reply-${c.id}')"
                                                                                                                class="px-3 py-2 bg-slate-100 dark:bg-slate-800 hover:bg-slate-200 dark:hover:bg-slate-700 rounded-lg text-xs font-semibold transition-all">Hủy</button>
                                                                                                        </form>
                                                                                                    </div>
                                                                                                </c:if>

                                                                        </div>
                                                                    </div>
                                                                </c:forEach>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                        </div>

                                        <!-- ══════════════════ PAGINATION ══════════════════ -->
                                        <c:if test="${totalPages > 1}">
                                            <div
                                                class="flex items-center justify-between py-6 border-t border-slate-200 dark:border-border-dark">
                                                <p class="text-xs font-medium text-slate-500 dark:text-slate-400">
                                                    Hiển thị
                                                    <span class="text-slate-900 dark:text-white">
                                                        <c:set var="currentEnd"
                                                            value="${(currentPage - 1) * 10 + fn:length(comments)}" />
                                                        <c:out
                                                            value="${currentEnd < totalComments ? currentEnd : totalComments}" />
                                                    </span>
                                                    /
                                                    <span class="text-slate-900 dark:text-white">${totalComments}</span>
                                                    bình luận
                                                </p>
                                                <div class="flex items-center gap-1.5">
                                                    <c:set var="startPage"
                                                        value="${currentPage - 2 > 1 ? currentPage - 2 : 1}" />
                                                    <c:set var="endPage"
                                                        value="${currentPage + 2 < totalPages ? currentPage + 2 : totalPages}" />

                                                    <c:if test="${currentPage > 1}">
                                                        <a href="${baseUrl}&page=${currentPage - 1}"
                                                            class="px-3 py-1.5 rounded-lg border border-slate-200 dark:border-border-dark
                                          hover:bg-slate-50 dark:hover:bg-slate-800 text-xs font-semibold transition-colors">Trước</a>
                                                    </c:if>

                                                    <c:if test="${startPage > 1}">
                                                        <a href="${baseUrl}&page=1"
                                                            class="px-3 py-1.5 rounded-lg border border-slate-200 dark:border-border-dark text-xs font-bold">1</a>
                                                        <c:if test="${startPage > 2}"><span
                                                                class="px-1 text-slate-400 text-xs">...</span></c:if>
                                                    </c:if>

                                                    <c:forEach begin="${startPage}" end="${endPage}" var="i">
                                                        <a href="${baseUrl}&page=${i}"
                                                            class="px-3 py-1.5 rounded-lg text-xs font-bold transition-all duration-200
                                          ${i == currentPage ? 'bg-primary text-white shadow-lg shadow-primary/25' : 'border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800'}">
                                                            ${i}
                                                        </a>
                                                    </c:forEach>

                                                    <c:if test="${endPage < totalPages}">
                                                        <c:if test="${endPage < totalPages - 1}"><span
                                                                class="px-1 text-slate-400 text-xs">...</span></c:if>
                                                        <a href="${baseUrl}&page=${totalPages}"
                                                            class="px-3 py-1.5 rounded-lg border border-slate-200 dark:border-border-dark text-xs font-bold">${totalPages}</a>
                                                    </c:if>

                                                    <c:if test="${currentPage < totalPages}">
                                                        <a href="${baseUrl}&page=${currentPage + 1}"
                                                            class="px-3 py-1.5 rounded-lg border border-slate-200 dark:border-border-dark
                                          hover:bg-slate-50 dark:hover:bg-slate-800 text-xs font-semibold transition-colors">Tiếp</a>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </c:if>

                                    </div>
                    </div>
                    </main>
                    </div>

                    <script>
                        var CONTEXT = '${ctx}';
                        var SORT = '${sort}';
                        // Escape single quote for JS
                        var KEYWORD = '${fn:replace(keyword, "'", "\\'")}';
                        var DEBOUNCE_MS = 400;
                        var _debounceTimer = null;

                        function toggleReply(id) {
                            var el = document.getElementById(id);
                            if (!el) return;
                            el.classList.toggle('hidden');
                            if (!el.classList.contains('hidden')) {
                                var inp = el.querySelector('input[name="replyContent"]');
                                if (inp) inp.focus();
                            }
                        }

                        document.getElementById('sortSelect').addEventListener('change', function () {
                            var url = CONTEXT + '/journalist/comments?sort=' + this.value + '&page=1';
                            if (KEYWORD) url += '&keyword=' + encodeURIComponent(KEYWORD);
                            window.location.href = url;
                        });

                        var searchInput = document.getElementById('searchInput');
                        var clearBtn = document.getElementById('clearSearch');
                        var searchForm = document.getElementById('searchForm');

                        function doSearch() {
                            var val = searchInput.value.trim();
                            var url = CONTEXT + '/journalist/comments?sort=' + SORT + '&page=1';
                            if (val) url += '&keyword=' + encodeURIComponent(val);
                            window.location.href = url;
                        }

                        if (searchInput) {
                            searchInput.addEventListener('input', function () {
                                if (this.value.length > 0) { clearBtn.classList.remove('invisible'); }
                                else { clearBtn.classList.add('invisible'); }

                                clearTimeout(_debounceTimer);
                                _debounceTimer = setTimeout(function () {
                                    var val = searchInput.value.trim();
                                    var cursorPos = searchInput.selectionStart;
                                    sessionStorage.setItem('searchKw', val);
                                    sessionStorage.setItem('searchCursor', cursorPos);
                                    var url = CONTEXT + '/journalist/comments?sort=' + SORT + '&page=1';
                                    if (val) url += '&keyword=' + encodeURIComponent(val);
                                    window.location.href = url;
                                }, DEBOUNCE_MS);
                            });

                            searchInput.addEventListener('keydown', function (e) {
                                if (e.key === 'Enter') {
                                    e.preventDefault();
                                    clearTimeout(_debounceTimer);
                                    sessionStorage.removeItem('searchKw');
                                    sessionStorage.removeItem('searchCursor');
                                    doSearch();
                                }
                                if (e.key === 'Escape') {
                                    clearTimeout(_debounceTimer);
                                    searchInput.value = '';
                                    clearBtn.classList.add('invisible');
                                    sessionStorage.removeItem('searchKw');
                                    sessionStorage.removeItem('searchCursor');
                                    doSearch();
                                }
                            });

                            (function restoreFocus() {
                                var savedKw = sessionStorage.getItem('searchKw');
                                var savedCursor = sessionStorage.getItem('searchCursor');
                                if (savedKw !== null && searchInput.value === savedKw) {
                                    sessionStorage.removeItem('searchKw');
                                    sessionStorage.removeItem('searchCursor');
                                    var pos = savedCursor !== null ? parseInt(savedCursor) : searchInput.value.length;
                                    searchInput.focus();
                                    try { searchInput.setSelectionRange(pos, pos); } catch (e) { }
                                }
                            })();
                        }

                        if (clearBtn) {
                            clearBtn.addEventListener('click', function () {
                                clearTimeout(_debounceTimer);
                                searchInput.value = '';
                                clearBtn.classList.add('invisible');
                                doSearch();
                            });
                        }

                        function toggleReportMenu(id) {
                            var el = document.getElementById(id);
                            if (!el) return;
                            var isHidden = el.classList.contains('hidden');
                            document.querySelectorAll('[id^="report-"]').forEach(function (m) {
                                if (m !== el) m.classList.add('hidden');
                            });
                            if (isHidden) el.classList.remove('hidden'); else el.classList.add('hidden');
                        }

                        document.addEventListener('click', function (e) {
                            var inside = e.target.closest('[id^="report-"]') || e.target.closest('button[onclick^="toggleReportMenu"]');
                            if (!inside) {
                                document.querySelectorAll('[id^="report-"]').forEach(function (m) { m.classList.add('hidden'); });
                            }
                        });

                        (function () {
                            var kw = KEYWORD.trim();
                            if (!kw) return;
                            var escaped = kw.replace(/[-.*+?^{}()|[\]\\]/g, function (c) { return '\\' + c; });
                            var regex = new RegExp('(' + escaped + ')', 'gi');
                            document.querySelectorAll('.comment-content').forEach(function (el) {
                                el.innerHTML = el.textContent.replace(regex, '<mark class="hl">$1</mark>');
                            });
                        })();

                        document.addEventListener('DOMContentLoaded', function () {
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