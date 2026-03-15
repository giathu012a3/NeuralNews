<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="neuralnews.model.Comment" %>
<%@ page import="neuralnews.model.User" %>

<%
    List<Comment> comments = (List<Comment>) request.getAttribute("comments");
    if (comments == null) {
        request.getRequestDispatcher("/journalist/comments").forward(request, response);
        return;
    }
    int totalComments = (Integer) request.getAttribute("totalComments");
    int currentPage   = (Integer) request.getAttribute("currentPage");
    int totalPages    = (Integer) request.getAttribute("totalPages");
    String sort       = (String)  request.getAttribute("sort");
    if (sort == null) sort = "latest";

    String keyword = (String) request.getAttribute("keyword");
    if (keyword == null) keyword = "";
    boolean hasKeyword = !keyword.isEmpty();

    String encodedKeyword = java.net.URLEncoder.encode(keyword, "UTF-8");
    String contextPath    = request.getContextPath();
    String baseUrl        = contextPath + "/journalist/comments?sort=" + sort
                          + (hasKeyword ? "&keyword=" + encodedKeyword : "");
%>
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
            background: rgba(13,127,242,0.18);
            color: inherit;
            border-radius: 2px;
            padding: 0 2px;
        }
    </style>
</head>
<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen">
<div class="flex h-screen overflow-hidden">

    <jsp:include page="components/sidebar.jsp">
        <jsp:param name="activePage" value="comments" />
    </jsp:include>

    <main class="flex-1 flex flex-col min-w-0 bg-background-light dark:bg-background-dark">

        <!-- ══════════════════ HEADER ══════════════════ -->
        <header class="h-16 bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-border-dark flex items-center justify-between px-8 shrink-0 z-30">
            <div class="flex items-center gap-6">
                <h2 class="text-lg font-bold tracking-tight">Quản lý Bình luận</h2>
                <div class="hidden md:flex items-center gap-2 text-xs text-slate-500 font-medium">
                    <span>Cổng thông tin Nhà báo</span>
                    <span class="material-symbols-outlined text-sm">chevron_right</span>
                    <span class="text-slate-900 dark:text-slate-200">Kiểm duyệt</span>
                </div>
            </div>
            <div class="flex items-center gap-3">

                <%-- SEARCH FORM: debounce + enter + clear --%>
                <form id="searchForm" method="get" action="<%= contextPath %>/journalist/comments" class="relative">
                    <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-lg pointer-events-none">search</span>
                    <input id="searchInput" name="keyword" value="<%= keyword %>" type="text" autocomplete="off"
                           placeholder="Tìm kiếm bình luận..."
                           class="bg-slate-100 dark:bg-slate-800 border-none rounded-lg py-1.5 pl-10 pr-8 w-64 focus:ring-2 focus:ring-primary text-xs transition-all" />
                    <input type="hidden" name="sort" value="<%= sort %>" />
                    <input type="hidden" name="page" value="1" />
                    <button type="button" id="clearSearch"
                            class="absolute right-2.5 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-700 dark:hover:text-white transition-colors <%= hasKeyword ? "" : "invisible" %>"
                            title="Xoá">
                        <span class="material-symbols-outlined text-base leading-none">close</span>
                    </button>
                </form>

                <div class="h-6 w-px bg-slate-200 dark:bg-slate-700 mx-1"></div>

                <%-- NOTIFICATION BELL --%>
                <div class="relative" id="notifWrapper">
                    <button id="notifBtn" class="relative p-2 rounded-lg hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors text-slate-500">
                        <span class="material-symbols-outlined">notifications</span>
                        <span id="notifDot" class="absolute top-2 right-2 size-2 bg-red-500 rounded-full border-2 border-white dark:border-slate-900"></span>
                    </button>
                    <div id="notifPanel" class="hidden absolute right-0 top-12 w-80 bg-white dark:bg-slate-900 border border-slate-200 dark:border-border-dark rounded-xl shadow-xl overflow-hidden z-50">
                        <div class="flex items-center justify-between px-4 py-3 border-b border-slate-100 dark:border-border-dark">
                            <div class="flex items-center gap-2">
                                <span class="text-sm font-bold">Thông báo</span>
                                <span id="notifCount" class="bg-primary/10 text-primary text-[10px] font-bold px-1.5 py-0.5 rounded-full">3</span>
                            </div>
                            <button id="markAllRead" class="text-[11px] text-primary font-semibold hover:underline">Đánh dấu đã đọc</button>
                        </div>
                        <ul id="notifList" class="max-h-80 overflow-y-auto divide-y divide-slate-100 dark:divide-border-dark">
                            <li class="notif-item unread flex items-start gap-3 px-4 py-3 hover:bg-slate-50 dark:hover:bg-slate-800/60 cursor-pointer transition-colors" data-id="c_notif_1" onclick="markRead(this)">
                                <div class="size-8 rounded-full bg-blue-100 dark:bg-blue-900/40 text-blue-600 flex items-center justify-center shrink-0 mt-0.5 text-xs font-bold">TW</div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-xs font-semibold text-slate-800 dark:text-white">Tech Writer vừa bình luận</p>
                                    <p class="text-[11px] text-slate-500 mt-0.5 truncate">"Bài viết mang tính giáo dục cao, nên chia sẻ..."</p>
                                    <p class="text-[10px] text-slate-400 mt-1">2 phút trước</p>
                                </div>
                                <span class="unread-dot size-2 bg-primary rounded-full shrink-0 mt-2"></span>
                            </li>
                            <li class="notif-item unread flex items-start gap-3 px-4 py-3 hover:bg-slate-50 dark:hover:bg-slate-800/60 cursor-pointer transition-colors" data-id="c_notif_2" onclick="markRead(this)">
                                <div class="size-8 rounded-full bg-emerald-100 dark:bg-emerald-900/40 text-emerald-600 flex items-center justify-center shrink-0 mt-0.5 text-xs font-bold">HE</div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-xs font-semibold text-slate-800 dark:text-white">Health Expert đã phản hồi</p>
                                    <p class="text-[11px] text-slate-500 mt-0.5 truncate">"Cảm ơn bạn đã chia sẻ thông tin hữu ích..."</p>
                                    <p class="text-[10px] text-slate-400 mt-1">15 phút trước</p>
                                </div>
                                <span class="unread-dot size-2 bg-primary rounded-full shrink-0 mt-2"></span>
                            </li>
                            <li class="notif-item unread flex items-start gap-3 px-4 py-3 hover:bg-slate-50 dark:hover:bg-slate-800/60 cursor-pointer transition-colors" data-id="c_notif_3" onclick="markRead(this)">
                                <div class="size-8 rounded-full bg-violet-100 dark:bg-violet-900/40 text-violet-600 flex items-center justify-center shrink-0 mt-0.5 text-xs font-bold">AS</div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-xs font-semibold text-slate-800 dark:text-white">asdfghjkl bình luận mới</p>
                                    <p class="text-[11px] text-slate-500 mt-0.5 truncate">"Mong chờ kết quả từ hội nghị này..."</p>
                                    <p class="text-[10px] text-slate-400 mt-1">1 giờ trước</p>
                                </div>
                                <span class="unread-dot size-2 bg-primary rounded-full shrink-0 mt-2"></span>
                            </li>
                            <li class="notif-item flex items-start gap-3 px-4 py-3 hover:bg-slate-50 dark:hover:bg-slate-800/60 cursor-pointer transition-colors" data-id="c_notif_4" onclick="markRead(this)">
                                <div class="size-8 rounded-full bg-amber-100 dark:bg-amber-900/40 text-amber-600 flex items-center justify-center shrink-0 mt-0.5">
                                    <span class="material-symbols-outlined text-sm">block</span>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-xs font-semibold text-slate-800 dark:text-white">1 bình luận bị đánh dấu Spam</p>
                                    <p class="text-[11px] text-slate-500 mt-0.5">Hệ thống tự động phát hiện</p>
                                    <p class="text-[10px] text-slate-400 mt-1">3 giờ trước</p>
                                </div>
                            </li>
                            <li class="notif-item flex items-start gap-3 px-4 py-3 hover:bg-slate-50 dark:hover:bg-slate-800/60 cursor-pointer transition-colors" data-id="c_notif_5" onclick="markRead(this)">
                                <div class="size-8 rounded-full bg-slate-100 dark:bg-slate-800 text-slate-500 flex items-center justify-center shrink-0 mt-0.5">
                                    <span class="material-symbols-outlined text-sm">article</span>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-xs font-semibold text-slate-800 dark:text-white">Bài viết được xuất bản</p>
                                    <p class="text-[11px] text-slate-500 mt-0.5 truncate">"Khám phá đột phá mới trong công nghệ y tế..."</p>
                                    <p class="text-[10px] text-slate-400 mt-1">1 ngày trước</p>
                                </div>
                            </li>
                        </ul>

                    </div>
                </div>

                <button onclick="document.documentElement.classList.toggle('dark')"
                        class="p-2 rounded-lg hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors text-slate-500">
                    <span class="material-symbols-outlined">light_mode</span>
                </button>
            </div>
        </header>

        <!-- ══════════════════ CONTENT ══════════════════ -->
        <div class="flex-1 overflow-y-auto">
            <div class="p-8 max-w-5xl mx-auto space-y-6">

                <%-- Toolbar --%>
                <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-2">
                    <div>
                        <h3 class="text-xl font-bold">
                            <%= hasKeyword ? "Kết quả tìm kiếm" : "Nguồn Cấp dữ liệu Hoạt động" %>
                        </h3>
                        <p class="text-slate-500 dark:text-slate-400 text-xs mt-1">
                            <% if (hasKeyword) { %>
                                Tìm thấy <strong class="text-slate-700 dark:text-slate-200"><%= totalComments %></strong>
                                bình luận cho từ khoá "<span class="text-primary font-semibold"><%= keyword %></span>"
                                &nbsp;·&nbsp;
                                <a href="<%= contextPath %>/journalist/comments?sort=<%= sort %>"
                                   class="text-primary hover:underline font-medium">Xem tất cả</a>
                            <% } else { %>
                                Đang xem xét <strong class="text-slate-700 dark:text-slate-200"><%= totalComments %></strong> bình luận từ độc giả của bạn
                            <% } %>
                        </p>
                    </div>
                    <div class="flex items-center gap-2">
                        <%-- Sort — giữ keyword khi đổi sort --%>
                        <div class="relative">
                            <select id="sortSelect"
                                    class="appearance-none bg-white dark:bg-slate-800 border border-slate-200
                                           dark:border-border-dark rounded-lg px-3 py-2 pr-8 text-xs font-semibold
                                           shadow-sm cursor-pointer focus:outline-none focus:ring-2 focus:ring-primary">
                                <option value="latest" <%= "latest".equals(sort) ? "selected" : "" %>>⬇ Mới nhất</option>
                                <option value="oldest" <%= "oldest".equals(sort) ? "selected" : "" %>>⬆ Cũ nhất</option>
                            </select>
                            <span class="material-symbols-outlined absolute right-2 top-1/2 -translate-y-1/2
                                         text-slate-400 text-sm pointer-events-none">expand_more</span>
                        </div>
                        <button class="flex items-center gap-2 px-4 py-2 bg-primary hover:bg-primary/90
                                       text-white rounded-lg text-xs font-semibold transition-all shadow-sm">
                            <span class="material-symbols-outlined text-sm">download</span>
                            Xuất Dữ liệu
                        </button>
                    </div>
                </div>

                <%-- Banner search đang active --%>
                <% if (hasKeyword) { %>
                <div class="flex items-center gap-3 px-4 py-3 bg-primary/5 dark:bg-primary/10
                            border border-primary/20 rounded-xl text-xs">
                    <span class="material-symbols-outlined text-primary text-lg">manage_search</span>
                    <span class="text-slate-600 dark:text-slate-300">
                        Đang lọc theo từ khoá: <strong class="text-primary">"<%= keyword %>"</strong>
                    </span>
                    <a href="<%= contextPath %>/journalist/comments?sort=<%= sort %>"
                       class="ml-auto flex items-center gap-1 px-3 py-1.5 bg-white dark:bg-slate-800
                              border border-slate-200 dark:border-slate-700 rounded-lg font-semibold
                              text-slate-600 dark:text-slate-300 hover:border-primary hover:text-primary transition-all">
                        <span class="material-symbols-outlined text-sm">close</span>
                        Xoá bộ lọc
                    </a>
                </div>
                <% } %>

                <!-- ══════════════════ COMMENT LIST ══════════════════ -->
                <div class="grid gap-4">
                <% if (comments.isEmpty()) { %>
                    <div class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200
                                dark:border-border-dark p-16 text-center">
                        <span class="material-symbols-outlined text-5xl text-slate-300 dark:text-slate-600">
                            <%= hasKeyword ? "search_off" : "chat_bubble_outline" %>
                        </span>
                        <p class="mt-4 text-slate-500 dark:text-slate-400 text-sm font-medium">
                            <% if (hasKeyword) { %>
                                Không tìm thấy bình luận nào khớp với "<%= keyword %>".
                            <% } else { %>
                                Chưa có bình luận nào cho bài viết của bạn.
                            <% } %>
                        </p>
                        <% if (hasKeyword) { %>
                        <a href="<%= contextPath %>/journalist/comments?sort=<%= sort %>"
                           class="inline-flex items-center gap-2 mt-4 px-4 py-2 bg-primary/10 text-primary
                                  rounded-lg text-xs font-semibold hover:bg-primary/20 transition-colors">
                            <span class="material-symbols-outlined text-sm">arrow_back</span>
                            Xem tất cả bình luận
                        </a>
                        <% } %>
                    </div>

                <% } else {
                    for (Comment c : comments) {
                        boolean isSpam   = "SPAM".equals(c.getStatus());
                        boolean isHidden = "HIDDEN".equals(c.getStatus());
                        String cardClass = (isSpam || isHidden)
                            ? "bg-slate-50/80 dark:bg-slate-900/40 rounded-xl border border-dashed border-red-200 dark:border-red-900/30 overflow-hidden opacity-90"
                            : "bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm hover:shadow-md transition-shadow overflow-hidden";
                %>
                    <div class="<%= cardClass %>">
                        <div class="p-5">

                            <%-- Avatar + Info + Badge --%>
                            <div class="flex justify-between items-start gap-4 mb-4">
                                <div class="flex items-start gap-3">
                                    <div class="size-10 rounded-full <%= c.getUserAvatarBgClass() %>
                                                flex items-center justify-center font-bold shrink-0 text-sm">
                                        <%= c.getUserAvatar() %>
                                    </div>
                                    <div class="min-w-0">
                                        <div class="flex items-center flex-wrap gap-x-2">
                                            <h5 class="text-sm font-bold text-slate-900 dark:text-white"><%= c.getUserName() %></h5>
                                            <span class="text-[11px] text-slate-400 font-medium"><%= c.getFormattedTime() %></span>
                                        </div>
                                        <a href="<%= contextPath %>/user/article?id=<%= c.getArticleId() %>"
                                           class="flex items-center gap-1.5 text-xs text-primary font-semibold mt-0.5 truncate hover:underline">
                                            <span class="material-symbols-outlined text-[14px]">article</span>
                                            <%= c.getArticleTitle() %>
                                        </a>
                                    </div>
                                </div>
                                <div class="badge-base <%= c.getStatusBadgeClass() %> ring-1 ring-inset shrink-0">
                                    <span class="size-1.5 rounded-full <%= c.getStatusDotClass() %>"></span>
                                    <%= c.getStatusLabel() %>
                                </div>
                            </div>

                            <%-- Nội dung bình luận --%>
                            <p class="comment-content text-slate-600 dark:text-slate-300 text-sm
                                      leading-relaxed mb-4 pl-[52px]
                                      <%= (isSpam || isHidden) ? "italic text-slate-400 dark:text-slate-500" : "" %>">
                                <%= c.getContent() %>
                            </p>

                            <%-- Replies --%>
                            <% if (c.getReplies() != null && !c.getReplies().isEmpty()) { %>
                            <div class="pl-[52px] space-y-2 mb-4">
                                <% for (Comment r : c.getReplies()) { %>
                                <div class="flex items-start gap-2 bg-slate-50 dark:bg-slate-800/60 rounded-lg p-3">
                                    <div class="size-7 rounded-full <%= r.getUserAvatarBgClass() %>
                                                flex items-center justify-center font-bold shrink-0 text-xs">
                                        <%= r.getUserAvatar() %>
                                    </div>
                                    <div>
                                        <div class="flex items-center gap-2">
                                            <span class="text-xs font-bold text-slate-900 dark:text-white"><%= r.getUserName() %></span>
                                            <span class="text-[10px] text-slate-400"><%= r.getFormattedTime() %></span>
                                        </div>
                                        <p class="text-xs text-slate-600 dark:text-slate-300 mt-0.5"><%= r.getContent() %></p>
                                    </div>
                                </div>
                                <% } %>
                            </div>
                            <% } %>

                            <%-- Actions --%>
                            <div class="flex items-center justify-between pt-4 border-t border-slate-100
                                        dark:border-border-dark pl-[52px]">
                                <div class="flex items-center gap-4">

                                <% if (isSpam || isHidden) { %>
                                    <%-- Xoá vĩnh viễn --%>
                                    <form method="post" action="<%= contextPath %>/journalist/comments" style="display:inline">
                                        <input type="hidden" name="action"    value="delete"/>
                                        <input type="hidden" name="commentId" value="<%= c.getId() %>"/>
                                        <input type="hidden" name="page"      value="<%= currentPage %>"/>
                                        <input type="hidden" name="sort"      value="<%= sort %>"/>
                                        <% if (hasKeyword) { %><input type="hidden" name="keyword" value="<%= keyword %>"/><% } %>
                                        <button type="submit"
                                                onclick="return confirm('Xoá vĩnh viễn bình luận này?')"
                                                class="flex items-center gap-1.5 text-red-500 hover:text-red-600
                                                       text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">delete_forever</span> Xóa
                                        </button>
                                    </form>
                                    <%-- Khôi phục --%>
                                    <form method="post" action="<%= contextPath %>/journalist/comments" style="display:inline">
                                        <input type="hidden" name="action"    value="restore"/>
                                        <input type="hidden" name="commentId" value="<%= c.getId() %>"/>
                                        <input type="hidden" name="page"      value="<%= currentPage %>"/>
                                        <input type="hidden" name="sort"      value="<%= sort %>"/>
                                        <% if (hasKeyword) { %><input type="hidden" name="keyword" value="<%= keyword %>"/><% } %>
                                        <button type="submit"
                                                class="flex items-center gap-1.5 text-slate-500 hover:text-slate-900
                                                       dark:hover:text-white text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">undo</span> Khôi phục
                                        </button>
                                    </form>
                                <% } else { %>
                                    <%-- Phản hồi --%>
                                    <button onclick="toggleReply('reply-<%= c.getId() %>')"
                                            class="flex items-center gap-1.5 text-slate-500 hover:text-primary
                                                   transition-colors text-[11px] font-bold uppercase tracking-wider">
                                        <span class="material-symbols-outlined text-lg">reply</span> Phản hồi
                                    </button>
                                    <%-- Spam --%>
                                    <form method="post" action="<%= contextPath %>/journalist/comments" style="display:inline">
                                        <input type="hidden" name="action"    value="spam"/>
                                        <input type="hidden" name="commentId" value="<%= c.getId() %>"/>
                                        <input type="hidden" name="page"      value="<%= currentPage %>"/>
                                        <input type="hidden" name="sort"      value="<%= sort %>"/>
                                        <% if (hasKeyword) { %><input type="hidden" name="keyword" value="<%= keyword %>"/><% } %>
                                        <button type="submit"
                                                class="flex items-center gap-1.5 text-slate-500 hover:text-orange-500
                                                       transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">block</span> Spam
                                        </button>
                                    </form>
                                    <%-- Ẩn --%>
                                    <form method="post" action="<%= contextPath %>/journalist/comments" style="display:inline">
                                        <input type="hidden" name="action"    value="hide"/>
                                        <input type="hidden" name="commentId" value="<%= c.getId() %>"/>
                                        <input type="hidden" name="page"      value="<%= currentPage %>"/>
                                        <input type="hidden" name="sort"      value="<%= sort %>"/>
                                        <% if (hasKeyword) { %><input type="hidden" name="keyword" value="<%= keyword %>"/><% } %>
                                        <button type="submit"
                                                class="flex items-center gap-1.5 text-slate-500 hover:text-slate-900
                                                       dark:hover:text-white transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">visibility_off</span> Ẩn
                                        </button>
                                    </form>
                                <% } %>
                                </div>
                                <button class="text-slate-400 hover:text-slate-600 dark:hover:text-slate-300">
                                    <span class="material-symbols-outlined">more_horiz</span>
                                </button>
                            </div>

                            <%-- Reply form --%>
                            <% if (!isSpam && !isHidden) { %>
                            <div id="reply-<%= c.getId() %>" class="hidden pl-[52px] mt-3">
                                <form method="post" action="<%= contextPath %>/journalist/comments" class="flex gap-2">
                                    <input type="hidden" name="action"      value="reply"/>
                                    <input type="hidden" name="commentId"   value="<%= c.getId() %>"/>
                                    <input type="hidden" name="articleId"   value="<%= c.getArticleId() %>"/>
                                    <input type="hidden" name="page"        value="<%= currentPage %>"/>
                                    <input type="hidden" name="sort"        value="<%= sort %>"/>
                                    <% if (hasKeyword) { %><input type="hidden" name="keyword" value="<%= keyword %>"/><% } %>
                                    <input type="text" name="replyContent" required
                                           placeholder="Nhập phản hồi của bạn..."
                                           class="flex-1 bg-slate-100 dark:bg-slate-800 border border-slate-200
                                                  dark:border-border-dark rounded-lg px-3 py-2 text-xs
                                                  focus:outline-none focus:ring-2 focus:ring-primary"/>
                                    <button type="submit"
                                            class="px-4 py-2 bg-primary hover:bg-primary/90 text-white
                                                   rounded-lg text-xs font-semibold transition-all">Gửi</button>
                                    <button type="button" onclick="toggleReply('reply-<%= c.getId() %>')"
                                            class="px-3 py-2 bg-slate-100 dark:bg-slate-800 hover:bg-slate-200
                                                   dark:hover:bg-slate-700 rounded-lg text-xs font-semibold transition-all">Hủy</button>
                                </form>
                            </div>
                            <% } %>

                        </div>
                    </div>
                <% } } %>
                </div>

                <!-- ══════════════════ PAGINATION ══════════════════ -->
                <% if (totalPages > 1) { %>
                <div class="flex items-center justify-between py-6 border-t border-slate-200 dark:border-border-dark">
                    <p class="text-xs font-medium text-slate-500 dark:text-slate-400">
                        Hiển thị
                        <span class="text-slate-900 dark:text-white"><%= Math.min((currentPage - 1) * 10 + comments.size(), totalComments) %></span>
                        /
                        <span class="text-slate-900 dark:text-white"><%= totalComments %></span>
                        bình luận
                    </p>
                    <div class="flex items-center gap-1.5">
                        <% if (currentPage > 1) { %>
                        <a href="<%= baseUrl %>&page=<%= currentPage - 1 %>"
                           class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark
                                  hover:bg-slate-50 dark:hover:bg-slate-800 text-xs font-semibold transition-colors">Trước</a>
                        <% } else { %>
                        <button disabled class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark opacity-40 text-xs font-semibold">Trước</button>
                        <% } %>

                        <% for (int i = 1; i <= totalPages; i++) { %>
                        <a href="<%= baseUrl %>&page=<%= i %>"
                           class="px-3 py-1.5 rounded-md text-xs font-bold transition-colors
                                  <%= i == currentPage ? "bg-primary/10 text-primary border border-primary/30" : "border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800" %>">
                            <%= i %>
                        </a>
                        <% } %>

                        <% if (currentPage < totalPages) { %>
                        <a href="<%= baseUrl %>&page=<%= currentPage + 1 %>"
                           class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark
                                  hover:bg-slate-50 dark:hover:bg-slate-800 text-xs font-semibold transition-colors">Tiếp</a>
                        <% } else { %>
                        <button disabled class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark opacity-40 text-xs font-semibold">Tiếp</button>
                        <% } %>
                    </div>
                </div>
                <% } %>

            </div>
        </div>
    </main>
</div>

<!-- ══════════════════════════════════════════════
     SCRIPTS
══════════════════════════════════════════════ -->
<script>
// ── Biến từ server ───────────────────────────────────────────────────────────
var CONTEXT = '<%= contextPath %>';
var SORT    = '<%= sort %>';
var KEYWORD = '<%= keyword.replace("'", "\\'") %>';
var DEBOUNCE_MS = 400;
var _debounceTimer = null;

// ── Toggle reply box ─────────────────────────────────────────────────────────
function toggleReply(id) {
    var el = document.getElementById(id);
    if (!el) return;
    el.classList.toggle('hidden');
    if (!el.classList.contains('hidden')) {
        var inp = el.querySelector('input[name="replyContent"]');
        if (inp) inp.focus();
    }
}

// ── Sort dropdown — giữ keyword ──────────────────────────────────────────────
document.getElementById('sortSelect').addEventListener('change', function() {
    var url = CONTEXT + '/journalist/comments?sort=' + this.value + '&page=1';
    if (KEYWORD) url += '&keyword=' + encodeURIComponent(KEYWORD);
    window.location.href = url;
});

// ── Search: debounce khi gõ + submit khi Enter ───────────────────────────────
var searchInput = document.getElementById('searchInput');
var clearBtn    = document.getElementById('clearSearch');
var searchForm  = document.getElementById('searchForm');

function doSearch() {
    var val = searchInput.value.trim();
    var url = CONTEXT + '/journalist/comments?sort=' + SORT + '&page=1';
    if (val) url += '&keyword=' + encodeURIComponent(val);
    window.location.href = url;
}

if (searchInput) {
    // Cập nhật nút X khi gõ
    searchInput.addEventListener('input', function() {
        if (this.value.length > 0) { clearBtn.classList.remove('invisible'); }
        else { clearBtn.classList.add('invisible'); }

        // Debounce: lưu vị trí cursor để khôi phục sau khi reload
        clearTimeout(_debounceTimer);
        _debounceTimer = setTimeout(function() {
            var val = searchInput.value.trim();
            var cursorPos = searchInput.selectionStart;
            // Lưu keyword + cursor vào sessionStorage để khôi phục
            sessionStorage.setItem('searchKw', val);
            sessionStorage.setItem('searchCursor', cursorPos);
            var url = CONTEXT + '/journalist/comments?sort=' + SORT + '&page=1';
            if (val) url += '&keyword=' + encodeURIComponent(val);
            window.location.href = url;
        }, DEBOUNCE_MS);
    });

    // Enter: submit ngay, không debounce
    searchInput.addEventListener('keydown', function(e) {
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

    // Khôi phục focus + cursor sau khi debounce reload trang
    (function restoreFocus() {
        var savedKw     = sessionStorage.getItem('searchKw');
        var savedCursor = sessionStorage.getItem('searchCursor');
        // Chỉ khôi phục nếu keyword trên URL khớp với keyword đã lưu
        if (savedKw !== null && searchInput.value === savedKw) {
            sessionStorage.removeItem('searchKw');
            sessionStorage.removeItem('searchCursor');
            var pos = savedCursor !== null ? parseInt(savedCursor) : searchInput.value.length;
            searchInput.focus();
            try { searchInput.setSelectionRange(pos, pos); } catch(e) {}
        }
    })();
}

// Nút X xoá
if (clearBtn) {
    clearBtn.addEventListener('click', function() {
        clearTimeout(_debounceTimer);
        searchInput.value = '';
        clearBtn.classList.add('invisible');
        doSearch();
    });
}

// ── Notification panel ───────────────────────────────────────────────────────
var notifBtn   = document.getElementById('notifBtn');
var notifPanel = document.getElementById('notifPanel');
var notifDot   = document.getElementById('notifDot');
var notifCount = document.getElementById('notifCount');
var NOTIF_KEY  = 'comments_read_notifs';

// Lấy danh sách id đã đọc từ localStorage
function getReadSet() {
    try { return JSON.parse(localStorage.getItem(NOTIF_KEY) || '[]'); } catch(e) { return []; }
}
function saveReadSet(arr) {
    try { localStorage.setItem(NOTIF_KEY, JSON.stringify(arr)); } catch(e) {}
}

// Áp dụng trạng thái đã đọc khi load trang
(function applyReadState() {
    var readIds = getReadSet();
    document.querySelectorAll('.notif-item[data-id]').forEach(function(el) {
        if (readIds.indexOf(el.dataset.id) !== -1) {
            el.classList.remove('unread');
            var dot = el.querySelector('.unread-dot');
            if (dot) dot.remove();
        }
    });
    updateNotifBadge();
})();

function updateNotifBadge() {
    var count = document.querySelectorAll('.notif-item.unread').length;
    if (count > 0) {
        notifDot.classList.remove('hidden');
        notifCount.textContent = count;
        notifCount.classList.remove('hidden');
    } else {
        notifDot.classList.add('hidden');
        notifCount.classList.add('hidden');
    }
}

notifBtn.addEventListener('click', function(e) {
    e.stopPropagation();
    notifPanel.classList.toggle('hidden');
});

document.addEventListener('click', function(e) {
    if (!document.getElementById('notifWrapper').contains(e.target)) {
        notifPanel.classList.add('hidden');
    }
});

function markRead(el) {
    if (el.classList.contains('unread')) {
        el.classList.remove('unread');
        var dot = el.querySelector('.unread-dot');
        if (dot) dot.remove();
        // Lưu vào localStorage
        var readIds = getReadSet();
        if (el.dataset.id && readIds.indexOf(el.dataset.id) === -1) {
            readIds.push(el.dataset.id);
            saveReadSet(readIds);
        }
        updateNotifBadge();
    }
}

document.getElementById('markAllRead').addEventListener('click', function() {
    document.querySelectorAll('.notif-item.unread').forEach(function(item) {
        markRead(item);
    });
});

// ── Highlight keyword ────────────────────────────────────────────────────────
(function() {
    if (!KEYWORD.trim()) return;
    var escaped = KEYWORD.replace(/[-.*+?^{}()|[\]\\]/g, function(c){ return '\\' + c; });
    var regex = new RegExp('(' + escaped + ')', 'gi');
    document.querySelectorAll('.comment-content').forEach(function(el) {
        el.innerHTML = el.textContent.replace(regex, '<mark class="hl">$1</mark>');
    });
})();
</script>
</body>
</html>
