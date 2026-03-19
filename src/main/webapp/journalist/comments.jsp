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
%>

<!DOCTYPE html>
<html class="dark" lang="vi">
<head>
    <jsp:include page="components/head.jsp" />
    <title>Quản lý Bình luận</title>
</head>

<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen">
<div class="flex h-screen overflow-hidden">

    <jsp:include page="components/sidebar.jsp">
        <jsp:param name="activePage" value="comments" />
    </jsp:include>

    <main class="flex-1 flex flex-col min-w-0 bg-background-light dark:bg-background-dark">

        <header class="h-16 bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-border-dark flex items-center justify-between px-8 shrink-0 z-20">
            <div class="flex items-center gap-6">
                <h2 class="text-lg font-bold tracking-tight">Quản lý Bình luận</h2>
                <div class="hidden md:flex items-center gap-2 text-xs text-slate-500 font-medium">
                    <span>Cổng thông tin Nhà báo</span>
                    <span class="material-symbols-outlined text-sm">chevron_right</span>
                    <span class="text-slate-900 dark:text-slate-200">Kiểm duyệt</span>
                </div>
            </div>
            <div class="flex items-center gap-3">
                <div class="relative">
                    <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-lg">search</span>
                    <input class="bg-slate-100 dark:bg-slate-800 border-none rounded-lg py-1.5 pl-10 pr-4 w-64 focus:ring-2 focus:ring-primary text-xs transition-all"
                           placeholder="Tìm kiếm bình luận..." type="text" />
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
            <div class="p-8 max-w-5xl mx-auto space-y-6">

                <%-- Toolbar --%>
                <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-2">
                    <div>
                        <h3 class="text-xl font-bold">Nguồn Cấp dữ liệu Hoạt động</h3>
                        <p class="text-slate-500 dark:text-slate-400 text-xs mt-1">
                            Đang xem xét <span class="font-semibold text-slate-700 dark:text-slate-200"><%= totalComments %></span> bình luận từ độc giả của bạn
                        </p>
                    </div>
                    <div class="flex items-center gap-2">
                        <div class="relative">
                            <select onchange="window.location.href='${pageContext.request.contextPath}/journalist/comments?sort='+this.value+'&page=1'"
                                    class="appearance-none bg-white dark:bg-slate-800 border border-slate-200 dark:border-border-dark rounded-lg px-3 py-2 pr-8 text-xs font-semibold shadow-sm cursor-pointer focus:outline-none focus:ring-2 focus:ring-primary">
                                <option value="latest" <%= "latest".equals(sort) ? "selected" : "" %>>⬇ Mới nhất</option>
                                <option value="oldest" <%= "oldest".equals(sort) ? "selected" : "" %>>⬆ Cũ nhất</option>
                            </select>
                            <span class="material-symbols-outlined absolute right-2 top-1/2 -translate-y-1/2 text-slate-400 text-sm pointer-events-none">expand_more</span>
                        </div>
                        <button class="flex items-center gap-2 px-4 py-2 bg-primary hover:bg-primary/90 text-white rounded-lg text-xs font-semibold transition-all shadow-sm">
                            <span class="material-symbols-outlined text-sm">download</span>
                            Xuất Dữ liệu
                        </button>
                    </div>
                </div>

                <%-- Danh sách comment --%>
                <div class="grid gap-4">
                <% if (comments.isEmpty()) { %>
                    <div class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark p-12 text-center">
                        <span class="material-symbols-outlined text-4xl text-slate-300 dark:text-slate-600">chat_bubble_outline</span>
                        <p class="mt-3 text-slate-500 dark:text-slate-400 text-sm">Chưa có bình luận nào cho bài viết của bạn.</p>
                    </div>
                <% } else { for (Comment c : comments) {
                    boolean isSpam   = "SPAM".equals(c.getStatus());
                    boolean isHidden = "HIDDEN".equals(c.getStatus());
                    String cardClass = (isSpam || isHidden)
                        ? "bg-slate-50/80 dark:bg-slate-900/40 rounded-xl border border-dashed border-red-200 dark:border-red-900/30 overflow-hidden opacity-90"
                        : "bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm hover:shadow-md transition-shadow overflow-hidden";
                %>
                    <div class="<%= cardClass %>">
                        <div class="p-5">
                            <div class="flex justify-between items-start gap-4 mb-4">
                                <div class="flex items-start gap-3">
                                    <div class="size-10 rounded-full <%= c.getUserAvatarBgClass() %> flex items-center justify-center font-bold shrink-0 text-sm">
                                        <%= c.getUserAvatar() %>
                                    </div>
                                    <div class="min-w-0">
                                        <div class="flex items-center flex-wrap gap-x-2">
                                            <h5 class="text-sm font-bold text-slate-900 dark:text-white"><%= c.getUserName() %></h5>
                                            <span class="text-[11px] text-slate-400 font-medium"><%= c.getFormattedTime() %></span>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/user/article.jsp?id=<%= c.getArticleId() %>"
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

                            <p class="text-slate-600 dark:text-slate-300 text-sm leading-relaxed mb-4 pl-[52px] <%= (isSpam || isHidden) ? "italic text-slate-400 dark:text-slate-500" : "" %>">
                                <%= c.getContent() %>
                            </p>

                            <%-- Replies --%>
                            <% if (c.getReplies() != null && !c.getReplies().isEmpty()) { %>
                            <div class="pl-[52px] space-y-2 mb-4">
                                <% for (Comment r : c.getReplies()) { %>
                                <div class="flex items-start gap-2 bg-slate-50 dark:bg-slate-800/60 rounded-lg p-3">
                                    <div class="size-7 rounded-full <%= r.getUserAvatarBgClass() %> flex items-center justify-center font-bold shrink-0 text-xs">
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
                            <div class="flex items-center justify-between pt-4 border-t border-slate-100 dark:border-border-dark pl-[52px]">
                                <div class="flex items-center gap-4">
                                <% if (isSpam || isHidden) { %>
                                    <form method="post" action="${pageContext.request.contextPath}/journalist/comments" style="display:inline">
                                        <input type="hidden" name="action" value="delete"/>
                                        <input type="hidden" name="commentId" value="<%= c.getId() %>"/>
                                        <input type="hidden" name="page" value="<%= currentPage %>"/>
                                        <input type="hidden" name="sort" value="<%= sort %>"/>
                                        <button type="submit" class="flex items-center gap-1.5 text-red-500 hover:text-red-600 text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">delete_forever</span> Xóa
                                        </button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/journalist/comments" style="display:inline">
                                        <input type="hidden" name="action" value="restore"/>
                                        <input type="hidden" name="commentId" value="<%= c.getId() %>"/>
                                        <input type="hidden" name="page" value="<%= currentPage %>"/>
                                        <input type="hidden" name="sort" value="<%= sort %>"/>
                                        <button type="submit" class="flex items-center gap-1.5 text-slate-500 hover:text-slate-900 dark:hover:text-white text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">undo</span> Khôi phục
                                        </button>
                                    </form>
                                <% } else { %>
                                    <button onclick="toggleReply('reply-<%= c.getId() %>')"
                                            class="flex items-center gap-1.5 text-slate-500 hover:text-primary transition-colors text-[11px] font-bold uppercase tracking-wider">
                                        <span class="material-symbols-outlined text-lg">reply</span> Phản hồi
                                    </button>
                                    <form method="post" action="${pageContext.request.contextPath}/journalist/comments" style="display:inline">
                                        <input type="hidden" name="action" value="spam"/>
                                        <input type="hidden" name="commentId" value="<%= c.getId() %>"/>
                                        <input type="hidden" name="page" value="<%= currentPage %>"/>
                                        <input type="hidden" name="sort" value="<%= sort %>"/>
                                        <button type="submit" class="flex items-center gap-1.5 text-slate-500 hover:text-orange-500 transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">block</span> Spam
                                        </button>
                                    </form>
                                    <form method="post" action="${pageContext.request.contextPath}/journalist/comments" style="display:inline">
                                        <input type="hidden" name="action" value="hide"/>
                                        <input type="hidden" name="commentId" value="<%= c.getId() %>"/>
                                        <input type="hidden" name="page" value="<%= currentPage %>"/>
                                        <input type="hidden" name="sort" value="<%= sort %>"/>
                                        <button type="submit" class="flex items-center gap-1.5 text-slate-500 hover:text-slate-900 dark:hover:text-white transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">visibility_off</span> Ẩn
                                        </button>
                                    </form>
                                <% } %>
                                </div>
                                <button class="text-slate-400 hover:text-slate-600 dark:hover:text-slate-300">
                                    <span class="material-symbols-outlined">more_horiz</span>
                                </button>
                            </div>

                            <%-- Form reply (ẩn mặc định) --%>
                            <% if (!isSpam && !isHidden) { %>
                            <div id="reply-<%= c.getId() %>" class="hidden pl-[52px] mt-3">
                                <form method="post" action="${pageContext.request.contextPath}/journalist/comments" class="flex gap-2">
                                    <input type="hidden" name="action"      value="reply"/>
                                    <input type="hidden" name="commentId"   value="<%= c.getId() %>"/>
                                    <input type="hidden" name="articleId"   value="<%= c.getArticleId() %>"/>
                                    <input type="hidden" name="page"        value="<%= currentPage %>"/>
                                    <input type="hidden" name="sort"        value="<%= sort %>"/>
                                    <input type="text"   name="replyContent" required
                                           placeholder="Nhập phản hồi của bạn..."
                                           class="flex-1 bg-slate-100 dark:bg-slate-800 border border-slate-200 dark:border-border-dark rounded-lg px-3 py-2 text-xs focus:outline-none focus:ring-2 focus:ring-primary"/>
                                    <button type="submit" class="px-4 py-2 bg-primary hover:bg-primary/90 text-white rounded-lg text-xs font-semibold transition-all">
                                        Gửi
                                    </button>
                                    <button type="button" onclick="toggleReply('reply-<%= c.getId() %>')"
                                            class="px-3 py-2 bg-slate-100 dark:bg-slate-800 hover:bg-slate-200 rounded-lg text-xs font-semibold transition-all">
                                        Hủy
                                    </button>
                                </form>
                            </div>
                            <% } %>
                        </div>
                    </div>
                <% } } %>
                </div>

                <%-- Phân trang --%>
                <div class="flex items-center justify-between py-6 border-t border-slate-200 dark:border-border-dark">
                    <p class="text-xs font-medium text-slate-500 dark:text-slate-400">
                        Hiển thị <span class="text-slate-900 dark:text-white"><%= Math.min((currentPage-1)*10 + comments.size(), totalComments) %></span>
                        / <span class="text-slate-900 dark:text-white"><%= totalComments %></span> bình luận
                    </p>
                    <div class="flex items-center gap-1.5">
                        <% if (currentPage > 1) { %>
                        <a href="${pageContext.request.contextPath}/journalist/comments?sort=<%= sort %>&page=<%= currentPage-1 %>"
                           class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800 text-xs font-semibold">Trước</a>
                        <% } else { %>
                        <button disabled class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark opacity-40 text-xs font-semibold">Trước</button>
                        <% } %>

                        <% for (int i = 1; i <= totalPages; i++) { %>
                        <a href="${pageContext.request.contextPath}/journalist/comments?sort=<%= sort %>&page=<%= i %>"
                           class="px-3 py-1.5 rounded-md text-xs font-bold <%= i == currentPage ? "bg-primary/10 text-primary border border-primary/30" : "border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800" %>">
                            <%= i %>
                        </a>
                        <% } %>

                        <% if (currentPage < totalPages) { %>
                        <a href="${pageContext.request.contextPath}/journalist/comments?sort=<%= sort %>&page=<%= currentPage+1 %>"
                           class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800 text-xs font-semibold">Tiếp</a>
                        <% } else { %>
                        <button disabled class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark opacity-40 text-xs font-semibold">Tiếp</button>
                        <% } %>
                    </div>
                </div>

            </div>
        </div>
    </main>
</div>

<script>
function toggleReply(id) {
    const el = document.getElementById(id);
    if (el) {
        el.classList.toggle('hidden');
        if (!el.classList.contains('hidden'))
            el.querySelector('input[name="replyContent"]').focus();
    }
}
</script>
</body>
</html>
