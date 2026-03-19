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
        <jsp:include page="components/header.jsp">
            <jsp:param name="pageTitle" value="Kiểm duyệt Bình luận" />
        </jsp:include>

        <%-- ══════════════════ CONTENT ══════════════════ --%>
        <div class="flex-1 overflow-y-auto">
            <div class="p-8 max-w-5xl mx-auto space-y-6">

                <%-- Toolbar --%>
                <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-2">
                    <div class="flex items-center gap-4">
                        <div>
                            <h3 class="text-xl font-bold">
                                <%= hasKeyword ? "Kết quả tìm kiếm" : "Nguồn Cấp dữ liệu Hoạt động" %>
                            </h3>
                            <p class="text-slate-500 dark:text-slate-400 text-xs mt-1">
                                <% if (hasKeyword) { %>
                                    Tìm thấy <strong class="text-slate-700 dark:text-slate-200"><%= totalComments %></strong>
                                    bình luận cho từ khoá "<span class="text-primary font-semibold"><%= keyword %></span>"
                                <% } else { %>
                                    Đang xem xét <strong class="text-slate-700 dark:text-slate-200"><%= totalComments %></strong> bình luận từ độc giả
                                <% } %>
                            </p>
                        </div>
                        <div class="h-8 w-px bg-slate-200 dark:bg-border-dark hidden sm:block"></div>
                        <%-- SEARCH FORM: debounce + enter + clear --%>
                        <form id="searchForm" method="get" action="<%= contextPath %>/journalist/comments" class="relative group">
                            <span class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-lg pointer-events-none transition-colors group-focus-within:text-primary">search</span>
                            <input id="searchInput" name="keyword" value="<%= keyword %>" type="text" autocomplete="off"
                                   placeholder="Tìm kiếm bình luận..."
                                   class="bg-white dark:bg-slate-900 border border-slate-200 dark:border-border-dark rounded-xl py-2 pl-10 pr-8 w-72 focus:ring-2 focus:ring-primary/20 focus:border-primary text-xs transition-all shadow-sm" />
                            <input type="hidden" name="sort" value="<%= sort %>" />
                            <input type="hidden" name="page" value="1" />
                            <button type="button" id="clearSearch"
                                    class="absolute right-2.5 top-1/2 -translate-y-1/2 text-slate-400 hover:text-red-500 transition-colors <%= hasKeyword ? "" : "invisible" %>"
                                    title="Xoá">
                                <span class="material-symbols-outlined text-base leading-none">close</span>
                            </button>
                        </form>
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
                            ? "bg-slate-50/80 dark:bg-slate-900/40 rounded-xl border border-dashed border-red-200 dark:border-red-900/30 opacity-90"
                            : "bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm hover:shadow-md transition-shadow";
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
                                    <%-- Chỉ giữ Phản hồi, bỏ nút Spam / Ẩn vì đã có Báo cáo --%>
                                    <button onclick="toggleReply('reply-<%= c.getId() %>')"
                                            class="flex items-center gap-1.5 text-slate-500 hover:text-primary
                                                   transition-colors text-[11px] font-bold uppercase tracking-wider">
                                        <span class="material-symbols-outlined text-lg">reply</span> Phản hồi
                                    </button>
                                <% } %>
                                </div>
                                <div class="relative">
                                    <button type="button"
                                            onclick="toggleReportMenu('report-<%= c.getId() %>')"
                                            class="flex items-center gap-1.5 text-slate-400 hover:text-red-500 transition-colors text-[11px] font-semibold uppercase tracking-wider">
                                        <span class="material-symbols-outlined text-lg">flag</span>
                                        <span>Báo cáo</span>
                                    </button>
                                    <div id="report-<%= c.getId() %>"
                                         class="hidden absolute right-0 top-8 w-56 bg-white dark:bg-slate-900 border border-slate-200 dark:border-border-dark rounded-xl shadow-xl z-40">
                                        <div class="px-3 py-2 border-b border-slate-100 dark:border-border-dark">
                                            <p class="text-[11px] font-bold text-slate-500 uppercase tracking-wider">Báo cáo bình luận</p>
                                        </div>
                                        <div class="py-1">
                                            <form method="post" action="<%= contextPath %>/journalist/comments">
                                                <input type="hidden" name="action"    value="spam"/>
                                                <input type="hidden" name="commentId" value="<%= c.getId() %>"/>
                                                <input type="hidden" name="page"      value="<%= currentPage %>"/>
                                                <input type="hidden" name="sort"      value="<%= sort %>"/>
                                                <% if (hasKeyword) { %><input type="hidden" name="keyword" value="<%= keyword %>"/><% } %>
                                                <button type="submit"
                                                        name="reason" value="OFFENSIVE"
                                                        class="w-full text-left px-3 py-2 text-xs text-slate-600 dark:text-slate-200 hover:bg-slate-50 dark:hover:bg-slate-800">
                                                    Ngôn từ xúc phạm / công kích cá nhân
                                                </button>
                                            </form>
                                            <form method="post" action="<%= contextPath %>/journalist/comments">
                                                <input type="hidden" name="action"    value="spam"/>
                                                <input type="hidden" name="commentId" value="<%= c.getId() %>"/>
                                                <input type="hidden" name="page"      value="<%= currentPage %>"/>
                                                <input type="hidden" name="sort"      value="<%= sort %>"/>
                                                <% if (hasKeyword) { %><input type="hidden" name="keyword" value="<%= keyword %>"/><% } %>
                                                <button type="submit"
                                                        name="reason" value="ADS"
                                                        class="w-full text-left px-3 py-2 text-xs text-slate-600 dark:text-slate-200 hover:bg-slate-50 dark:hover:bg-slate-800">
                                                    Spam / Quảng cáo
                                                </button>
                                            </form>
                                            <form method="post" action="<%= contextPath %>/journalist/comments">
                                                <input type="hidden" name="action"    value="spam"/>
                                                <input type="hidden" name="commentId" value="<%= c.getId() %>"/>
                                                <input type="hidden" name="page"      value="<%= currentPage %>"/>
                                                <input type="hidden" name="sort"      value="<%= sort %>"/>
                                                <% if (hasKeyword) { %><input type="hidden" name="keyword" value="<%= keyword %>"/><% } %>
                                                <button type="submit"
                                                        name="reason" value="OFFTOPIC"
                                                        class="w-full text-left px-3 py-2 text-xs text-slate-600 dark:text-slate-200 hover:bg-slate-50 dark:hover:bg-slate-800">
                                                    Lạc chủ đề / Không liên quan bài viết
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
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

// ── Dark / Light mode ─────────────────────────────────────────────
const html      = document.documentElement;
const themeIcon = document.getElementById('themeIcon');

// ── Báo cáo bình luận: toggle menu ─────────────────────────────────────
function toggleReportMenu(id) {
    var el = document.getElementById(id);
    if (!el) return;
    var isHidden = el.classList.contains('hidden');
    document.querySelectorAll('[id^="report-"]').forEach(function(m) {
        if (m !== el) m.classList.add('hidden');
    });
    if (isHidden) el.classList.remove('hidden'); else el.classList.add('hidden');
}

document.addEventListener('click', function(e) {
    var inside = e.target.closest('[id^="report-"]') || e.target.closest('button[onclick^="toggleReportMenu"]');
    if (!inside) {
        document.querySelectorAll('[id^="report-"]').forEach(function(m) { m.classList.add('hidden'); });
    }
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
