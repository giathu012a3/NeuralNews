<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="art" value="${articleDetail}" />
<c:set var="uReaction" value="${userReaction != null ? userReaction : 'NONE'}" />
<!DOCTYPE html>
<html class="dark" lang="en">
<head>
    <title><c:out value="${not empty art ? art.title : 'Bài viết'}" /> - NexusAI</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <jsp:include page="components/head.jsp" />
    <style>
        .line-clamp-2 {
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
        .article-content p {
            margin-bottom: 1.5rem;
            line-height: 1.8;
            font-size: 1.125rem;
            color: #334155;
        }
        .dark .article-content p { color: #cbd5e1; }
        .fill-icon { font-variation-settings: 'FILL' 1; }
        .text-primary { color: #3b82f6; }
        .text-red-500 { color: #ef4444; }
    </style>
</head>

<body class="bg-background-light dark:bg-background-dark text-text-main dark:text-white font-display antialiased overflow-x-hidden transition-colors duration-200">

    <div class="flex min-h-screen w-full flex-col">
        <jsp:include page="components/header.jsp" />

        <main class="flex-1 w-full max-w-[1000px] mx-auto p-4 lg:p-12">
            <article class="relative">

                <%-- Category Badge --%>
                <div class="flex items-center gap-2 mb-4">
                    <span class="inline-block px-3 py-1 rounded bg-primary/10 text-primary text-[11px] font-bold uppercase tracking-wider">
                        <c:out value="${not empty art and not empty art.categoryName ? art.categoryName : 'Tin tức'}" />
                    </span>
                </div>

                <%-- Title --%>
                <h1 class="text-4xl md:text-5xl lg:text-6xl font-black text-slate-900 dark:text-white leading-[1.1] mb-8">
                    <c:out value="${not empty art ? art.title : 'Không tìm thấy bài viết'}" />
                </h1>

                <%-- Author & Actions Bar --%>
                <div class="flex flex-wrap items-center justify-between gap-4 pb-8 border-b border-slate-200 dark:border-slate-800">
                    <div class="flex items-center gap-4">
                        <div class="size-10 rounded-full bg-slate-200 overflow-hidden">
                            <c:choose>
                                <c:when test="${not empty art and not empty art.authorAvatar}">
                                    <c:choose>
                                        <c:when test="${fn:startsWith(art.authorAvatar, 'http')}">
                                            <img src="${art.authorAvatar}" class="size-full object-cover" alt="Author Avatar">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}${art.authorAvatar}" class="size-full object-cover" alt="Author Avatar">
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise>
                                    <div class="size-full bg-slate-300 flex items-center justify-center">
                                        <span class="material-symbols-outlined text-slate-500">person</span>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div>
                            <p class="text-sm font-bold text-slate-900 dark:text-white">
                                <c:out value="${not empty art and not empty art.authorName ? art.authorName : 'Tác giả'}" />
                            </p>
                            <p class="text-xs text-slate-500">
                                <c:if test="${not empty art}">
                                    <fmt:formatDate value="${art.publishedAt}" pattern="dd 'Tháng' MM, yyyy" /> •
                                    <c:out value="${not empty art.readingTime ? art.readingTime : 'Đọc ... phút'}" />
                                </c:if>
                            </p>
                        </div>
                    </div>
                    <div class="flex items-center gap-3">
                        <button id="btnBookmark" onclick="toggleBookmark()"
                            class="flex items-center gap-2 px-4 py-2 rounded-full border border-slate-200 dark:border-slate-700 text-sm font-medium hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors">
                            <span class="material-symbols-outlined text-xl">bookmark</span>
                            <span id="bookmarkText">Lưu</span>
                        </button>
                        <button onclick="openReportModal()" class="p-2 rounded-full hover:bg-slate-100 dark:hover:bg-slate-800 text-slate-500 hover:text-red-500 transition-colors" title="Báo cáo vi phạm">
                            <span class="material-symbols-outlined text-xl">report</span>
                        </button>
                        <button class="p-2 rounded-full hover:bg-slate-100 dark:hover:bg-slate-800">
                            <span class="material-symbols-outlined text-xl">share</span>
                        </button>
                    </div>
                </div>

                <%-- AI Summary Button --%>
                <div class="my-8">
                    <button id="btnAiSummary" onclick="generateAiSummary()"
                        class="w-full flex items-center justify-between p-4 rounded-xl bg-slate-50 dark:bg-surface-dark border border-slate-200 dark:border-slate-700 hover:border-primary/50 transition-all group">
                        <div class="flex items-center gap-3">
                            <div class="size-8 rounded-lg bg-primary/10 text-primary flex items-center justify-center">
                                <span class="material-symbols-outlined text-xl">auto_awesome</span>
                            </div>
                            <span class="font-bold text-slate-900 dark:text-white">Tạo Tóm tắt AI</span>
                        </div>
                        <span class="material-symbols-outlined text-slate-400 group-hover:text-primary">expand_more</span>
                    </button>
                    <div id="aiSummaryContent" class="hidden mt-4 p-6 bg-blue-50/50 dark:bg-primary/5 rounded-xl border border-primary/10">
                        <h4 class="text-xs font-bold text-primary uppercase tracking-widest mb-4">Nổi bật nhanh (AI Tạo)</h4>
                        <div id="aiSummaryBody" class="text-slate-700 dark:text-slate-300 text-sm leading-relaxed">
                            Đang chuẩn bị tóm tắt...
                        </div>
                    </div>
                </div>

                <%-- Featured Image --%>
                <c:if test="${not empty art and not empty art.imageUrl}">
                    <div class="my-8 rounded-2xl overflow-hidden shadow-2xl">
                        <img src="${art.getDisplayImageUrl(pageContext.request.contextPath)}"
                             alt="${art.title}"
                             class="w-full h-auto object-cover max-h-[500px]" />
                    </div>
                </c:if>

                <%-- Article Content --%>
                <div class="article-content prose prose-slate dark:prose-invert max-w-none">
                    <c:out value="${not empty art ? art.getContentProcessed(pageContext.request.contextPath) : 'Nội dung đang được cập nhật...'}" escapeXml="false" />
                </div>

                <%-- Reactions + Comments Section --%>
                <div class="mt-16 pt-12 border-t border-slate-200 dark:border-slate-800">

                    <%-- Top bar: Title + Like/Dislike --%>
                    <div class="flex flex-wrap items-center justify-between gap-4 pb-8 border-b border-slate-200 dark:border-slate-800">
                        <h3 id="commentCountHeader" class="text-2xl font-bold text-slate-900 dark:text-white">Thảo luận (0)</h3>
                        <div class="flex items-center gap-3">
                            <button id="btnLike" onclick="sendReaction('LIKE')"
                                    class="p-2 flex items-center gap-1 transition-all hover:text-primary ${uReaction == 'LIKE' ? 'text-primary' : ''}">
                                <span class="material-symbols-outlined text-2xl ${uReaction == 'LIKE' ? 'fill-icon' : ''}">thumb_up</span>
                                <span id="likeCount">${not empty art ? art.likesCount : 0}</span>
                            </button>
                            <button id="btnDislike" onclick="sendReaction('DISLIKE')"
                                    class="p-2 flex items-center gap-1 transition-all hover:text-red-500 ${uReaction == 'DISLIKE' ? 'text-red-500' : ''}">
                                <span class="material-symbols-outlined text-2xl ${uReaction == 'DISLIKE' ? 'fill-icon' : ''}">thumb_down</span>
                                <span id="dislikeCount">${not empty art ? art.dislikesCount : 0}</span>
                            </button>
                        </div>
                    </div>

                    <%-- Comment Input --%>
                    <div class="flex gap-4 mb-10 mt-8">
                        <c:choose>
                            <c:when test="${not empty sessionScope.currentUser}">
                                <div class="size-10 rounded-full bg-slate-200 overflow-hidden shrink-0">
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.currentUser.avatarUrl}">
                                            <c:set var="avatarUrl" value="${sessionScope.currentUser.avatarUrl}" />
                                            <c:choose>
                                                <c:when test="${fn:startsWith(avatarUrl, 'http')}">
                                                    <img src="${avatarUrl}" class="size-full object-cover" alt="User Avatar">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="${pageContext.request.contextPath}/${avatarUrl}" class="size-full object-cover" alt="User Avatar">
                                                </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="size-full bg-primary/10 text-primary flex items-center justify-center">
                                                <span class="material-symbols-outlined">person</span>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="flex-1">
                                    <textarea id="mainCommentText"
                                        class="w-full p-4 rounded-xl bg-slate-50 dark:bg-surface-dark border border-slate-200 dark:border-slate-700 focus:ring-1 focus:ring-primary focus:border-primary text-sm transition-all"
                                        placeholder="Tham gia cuộc trò chuyện..." rows="3"></textarea>
                                    <div class="mt-2 flex justify-end">
                                        <button onclick="postComment()"
                                            class="px-6 py-2 bg-primary text-white text-sm font-bold rounded-full hover:bg-primary-dark transition-colors">Đăng bình luận</button>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="w-full p-6 text-center rounded-xl border border-dashed border-slate-300 dark:border-slate-700">
                                    <p class="text-sm text-slate-500 mb-3">Bạn cần đăng nhập để tham gia bình luận</p>
                                    <a href="${pageContext.request.contextPath}/auth/login.jsp" class="px-6 py-2 bg-primary text-white text-sm font-bold rounded-full inline-block">Đăng nhập ngay</a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <%-- Comments Container --%>
                    <div id="commentsContainer" class="space-y-8">
                        <div class="flex justify-center p-10">
                            <div class="size-8 border-4 border-primary border-t-transparent rounded-full animate-spin"></div>
                        </div>
                    </div>

                </div><%-- End Reactions + Comments --%>

            </article>
        </main>

        <jsp:include page="components/footer.jsp" />

    </div><%-- End flex min-h-screen --%>

    <%-- Report Modal --%>
    <div id="reportModal" class="hidden fixed inset-0 z-[100] flex items-center justify-center p-4">
        <div class="absolute inset-0 bg-slate-900/60 backdrop-blur-sm" onclick="closeReportModal()"></div>
        <div class="relative w-full max-w-md bg-white dark:bg-surface-dark rounded-2xl shadow-2xl overflow-hidden animate-in zoom-in duration-200">
            <div class="p-6 border-b border-slate-100 dark:border-slate-800 flex items-center justify-between">
                <h3 class="text-xl font-bold text-slate-900 dark:text-white">Báo cáo bài viết</h3>
                <button onclick="closeReportModal()" class="text-slate-400 hover:text-slate-600 dark:hover:text-slate-200">
                    <span class="material-symbols-outlined">close</span>
                </button>
            </div>
            <form id="reportForm" onsubmit="submitReport(event)" class="p-6 space-y-4">
                <div>
                    <label class="block text-sm font-bold text-slate-700 dark:text-slate-300 mb-2">Lý do báo cáo</label>
                    <select name="reason" required class="w-full p-3 rounded-xl bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-sm">
                        <option value="">Chọn một lý do...</option>
                        <option value="Nội dung sai sự thật">Nội dung sai sự thật</option>
                        <option value="Ngôn từ thù ghét">Ngôn từ thù ghét</option>
                        <option value="Vi phạm bản quyền">Vi phạm bản quyền</option>
                        <option value="Nội dung nhạy cảm">Nội dung nhạy cảm</option>
                        <option value="Khác">Lý do khác</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-bold text-slate-700 dark:text-slate-300 mb-2">Chi tiết (Tùy chọn)</label>
                    <textarea name="details" rows="4" class="w-full p-3 rounded-xl bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-sm" placeholder="Mô tả thêm về vi phạm..."></textarea>
                </div>
                <div class="flex gap-3 pt-2">
                    <button type="button" onclick="closeReportModal()" class="flex-1 px-4 py-2 rounded-full border border-slate-200 dark:border-slate-700 text-sm font-bold hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors">Hủy</button>
                    <button type="submit" class="flex-1 px-4 py-2 bg-red-500 text-white text-sm font-bold rounded-full hover:bg-red-600 transition-colors">Gửi báo cáo</button>
                </div>
            </form>
        </div>
    </div>

    <%-- Report Comment Modal --%>
    <div id="reportCommentModal" class="hidden fixed inset-0 z-[100] flex items-center justify-center p-4">
        <div class="absolute inset-0 bg-slate-900/60 backdrop-blur-sm" onclick="closeCommentReportModal()"></div>
        <div class="relative w-full max-w-md bg-white dark:bg-surface-dark rounded-2xl shadow-2xl overflow-hidden animate-in zoom-in duration-200">
            <div class="p-6 border-b border-slate-100 dark:border-slate-800 flex items-center justify-between">
                <h3 class="text-xl font-bold text-slate-900 dark:text-white">Báo cáo bình luận</h3>
                <button onclick="closeCommentReportModal()" class="text-slate-400 hover:text-slate-600 dark:hover:text-slate-200">
                    <span class="material-symbols-outlined">close</span>
                </button>
            </div>
            <form id="reportCommentForm" onsubmit="submitCommentReport(event)" class="p-6 space-y-4">
                <div>
                    <label class="block text-sm font-bold text-slate-700 dark:text-slate-300 mb-2">Lý do báo cáo</label>
                    <select name="reason" required class="w-full p-3 rounded-xl bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-sm">
                        <option value="">Chọn một lý do...</option>
                        <option value="Ngôn từ thù ghét/Lăng mạ">Ngôn từ thù ghét/Lăng mạ</option>
                        <option value="Spam/Quảng cáo">Spam/Quảng cáo</option>
                        <option value="Bắt nạt/Quấy rối">Bắt nạt/Quấy rối</option>
                        <option value="Tin giả/Sai sự thật">Tin giả/Sai sự thật</option>
                        <option value="Khác">Lý do khác</option>
                    </select>
                </div>
                <div>
                    <label class="block text-sm font-bold text-slate-700 dark:text-slate-300 mb-2">Chi tiết (Tùy chọn)</label>
                    <textarea name="details" rows="4" class="w-full p-3 rounded-xl bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-sm" placeholder="Mô tả thêm về vi phạm..."></textarea>
                </div>
                <div class="flex gap-3 pt-2">
                    <button type="button" onclick="closeCommentReportModal()" class="flex-1 px-4 py-2 rounded-full border border-slate-200 dark:border-slate-700 text-sm font-bold hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors">Hủy</button>
                    <button type="submit" class="flex-1 px-4 py-2 bg-red-500 text-white text-sm font-bold rounded-full hover:bg-red-600 transition-colors">Gửi báo cáo</button>
                </div>
            </form>
        </div>
    </div>

    <script>
        const ARTICLE_CONFIG = {
            ctx: '${pageContext.request.contextPath}',
            id: '${not empty art ? art.id : ""}',
            uReaction: '${uReaction}'
        };
    </script>
    <script src="${pageContext.request.contextPath}/assets/js/article-detail.js"></script>
</body>
</html>