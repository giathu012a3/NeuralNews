<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="components/head.jsp" />
    <title>Quản lý nội dung | NeuralNews Admin</title>
</head>
<body class="bg-dashboard-bg dark:bg-background-dark">
<div class="flex min-h-screen">
    <jsp:include page="components/sidebar.jsp"><jsp:param name="activePage" value="content" /></jsp:include>
    <main class="flex-1 ml-64 min-h-screen">

        <%-- Header --%>
        <header class="sticky top-0 z-40 bg-dashboard-bg/80 dark:bg-background-dark/80 backdrop-blur-md px-8 py-4 flex items-center justify-between border-b border-slate-200 dark:border-slate-800">
            <div>
                <p class="text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-widest">Hệ thống</p>
                <h2 class="text-2xl font-bold text-slate-800 dark:text-white">Quản lý nội dung</h2>
            </div>
            <div class="flex items-center gap-3">
                <button onclick="AdminContent.exportCsv()"
                    class="flex items-center gap-2 px-4 py-2 text-sm font-semibold border border-slate-200 dark:border-slate-600 rounded-xl hover:bg-slate-50 dark:hover:bg-slate-800 text-slate-600 dark:text-slate-300 transition-all">
                    <span class="material-icons text-[18px]">download</span> Xuất CSV
                </button>
                <jsp:include page="components/header_profile.jsp" />
            </div>
        </header>

        <div class="p-8 space-y-5">

            <%-- Stats Bar --%>
            <div class="grid grid-cols-2 sm:grid-cols-5 gap-4">
                <button onclick="AdminContent.quickFilter('')" class="stat-card group bg-white dark:bg-slate-800 p-4 rounded-xl shadow-sm border border-slate-100 dark:border-slate-700 flex items-center gap-3 hover:border-primary hover:shadow-md transition-all text-left w-full">
                    <div class="w-10 h-10 bg-slate-100 dark:bg-slate-700 rounded-xl flex items-center justify-center flex-shrink-0 group-hover:bg-primary/10">
                        <span class="material-icons text-slate-500 group-hover:text-primary text-[20px]">article</span>
                    </div>
                    <div><p class="text-[10px] font-bold text-slate-400 uppercase tracking-wider">Tổng</p>
                    <p class="text-2xl font-bold text-slate-900 dark:text-white">${statTotal}</p></div>
                </button>
                <button onclick="AdminContent.quickFilter('PENDING')" class="stat-card group bg-white dark:bg-slate-800 p-4 rounded-xl shadow-sm border border-slate-100 dark:border-slate-700 flex items-center gap-3 hover:border-amber-400 hover:shadow-md transition-all text-left w-full">
                    <div class="w-10 h-10 bg-amber-50 dark:bg-amber-900/20 rounded-xl flex items-center justify-center flex-shrink-0">
                        <span class="material-icons text-amber-500 text-[20px]">pending</span>
                    </div>
                    <div><p class="text-[10px] font-bold text-amber-400 uppercase tracking-wider">Chờ duyệt</p>
                    <p class="text-2xl font-bold text-slate-900 dark:text-white">${statPending}</p></div>
                </button>
                <button onclick="AdminContent.quickFilter('PUBLISHED')" class="stat-card group bg-white dark:bg-slate-800 p-4 rounded-xl shadow-sm border border-slate-100 dark:border-slate-700 flex items-center gap-3 hover:border-green-400 hover:shadow-md transition-all text-left w-full">
                    <div class="w-10 h-10 bg-green-50 dark:bg-green-900/20 rounded-xl flex items-center justify-center flex-shrink-0">
                        <span class="material-icons text-green-500 text-[20px]">check_circle</span>
                    </div>
                    <div><p class="text-[10px] font-bold text-green-500 uppercase tracking-wider">Đã đăng</p>
                    <p class="text-2xl font-bold text-slate-900 dark:text-white">${statPublished}</p></div>
                </button>
                <button onclick="AdminContent.quickFilter('REJECTED')" class="stat-card group bg-white dark:bg-slate-800 p-4 rounded-xl shadow-sm border border-slate-100 dark:border-slate-700 flex items-center gap-3 hover:border-red-400 hover:shadow-md transition-all text-left w-full">
                    <div class="w-10 h-10 bg-red-50 dark:bg-red-900/20 rounded-xl flex items-center justify-center flex-shrink-0">
                        <span class="material-icons text-red-500 text-[20px]">cancel</span>
                    </div>
                    <div><p class="text-[10px] font-bold text-red-400 uppercase tracking-wider">Từ chối</p>
                    <p class="text-2xl font-bold text-slate-900 dark:text-white">${statRejected}</p></div>
                </button>
                <button onclick="AdminContent.quickFilter('ARCHIVED')" class="stat-card group bg-white dark:bg-slate-800 p-4 rounded-xl shadow-sm border border-slate-100 dark:border-slate-700 flex items-center gap-3 hover:border-slate-400 hover:shadow-md transition-all text-left w-full">
                    <div class="w-10 h-10 bg-slate-100 dark:bg-slate-700 rounded-xl flex items-center justify-center flex-shrink-0">
                        <span class="material-icons text-slate-500 text-[20px]">archive</span>
                    </div>
                    <div><p class="text-[10px] font-bold text-slate-400 uppercase tracking-wider">Lưu trữ</p>
                    <p class="text-2xl font-bold text-slate-900 dark:text-white">${statArchived}</p></div>
                </button>
            </div>

            <%-- Filter Bar --%>
            <div class="bg-white dark:bg-slate-800 p-4 rounded-xl shadow-sm border border-slate-100 dark:border-slate-700 flex flex-wrap items-end gap-3">
                <%-- Search --%>
                <div class="flex-1 min-w-[180px]">
                    <label class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Tìm kiếm</label>
                    <div class="relative flex items-center group">
                        <span class="material-icons absolute left-3 text-slate-400 group-focus-within:text-primary transition-colors text-[20px]">search</span>
                        <input id="searchInput" class="w-full pl-10 pr-4 py-2 bg-slate-50 dark:bg-slate-900 border border-slate-200 dark:border-slate-600 rounded-lg text-sm focus:ring-2 focus:ring-primary outline-none"
                            placeholder="Tiêu đề hoặc ID..." type="text" />
                    </div>
                </div>
                <%-- Author --%>
                <div class="min-w-[160px]">
                    <label class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Tác giả</label>
                    <div class="relative flex items-center group">
                        <span class="material-icons absolute left-3 text-slate-400 text-[20px]">person</span>
                        <input id="authorFilter" class="w-full pl-10 pr-4 py-2 bg-slate-50 dark:bg-slate-900 border border-slate-200 dark:border-slate-600 rounded-lg text-sm focus:ring-2 focus:ring-primary outline-none"
                            placeholder="Tên tác giả..." type="text" />
                    </div>
                </div>
                <%-- Category --%>
                <div class="min-w-[150px]">
                    <label class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Danh mục</label>
                    <select id="categoryFilter" class="w-full py-2 px-3 bg-slate-50 dark:bg-slate-900 border border-slate-200 dark:border-slate-600 rounded-lg text-sm focus:ring-2 focus:ring-primary outline-none">
                        <option value="ALL">Tất cả</option>
                        <c:forEach items="${categories}" var="c"><option value="${c.id}">${c.name}</option></c:forEach>
                    </select>
                </div>
                <%-- Status --%>
                <div class="min-w-[150px]">
                    <label class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Trạng thái</label>
                    <select id="statusFilter" class="w-full py-2 px-3 bg-slate-50 dark:bg-slate-900 border border-slate-200 dark:border-slate-600 rounded-lg text-sm focus:ring-2 focus:ring-primary outline-none">
                        <option value="ALL">Tất cả</option>
                        <option value="PUBLISHED">Đã xuất bản</option>
                        <option value="PENDING">Chờ duyệt</option>
                        <option value="REJECTED">Từ chối</option>
                        <option value="ARCHIVED">Lưu trữ</option>
                    </select>
                </div>
                <%-- Sort --%>
                <div class="min-w-[140px]">
                    <label class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Sắp xếp</label>
                    <select id="sortByFilter" class="w-full py-2 px-3 bg-slate-50 dark:bg-slate-900 border border-slate-200 dark:border-slate-600 rounded-lg text-sm focus:ring-2 focus:ring-primary outline-none">
                        <option value="date">Ngày tạo</option>
                        <option value="views">Lượt xem</option>
                        <option value="title">Tiêu đề</option>
                    </select>
                </div>
                <div class="min-w-[100px]">
                    <label class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Thứ tự</label>
                    <select id="sortDirFilter" class="w-full py-2 px-3 bg-slate-50 dark:bg-slate-900 border border-slate-200 dark:border-slate-600 rounded-lg text-sm focus:ring-2 focus:ring-primary outline-none">
                        <option value="DESC">Mới nhất</option>
                        <option value="ASC">Cũ nhất</option>
                    </select>
                </div>
                <button onclick="AdminContent.resetFilters()"
                    class="px-4 py-2 border border-slate-200 dark:border-slate-600 rounded-lg text-sm font-medium hover:bg-slate-50 dark:hover:bg-slate-700 transition-colors">
                    Xóa bộ lọc
                </button>
            </div>

            <%-- Table Container --%>
            <div id="article-table-container" class="bg-white dark:bg-slate-800 rounded-xl shadow-sm border border-slate-100 dark:border-slate-700 overflow-hidden min-h-[400px]">
                <jsp:include page="components/article_table_partial.jsp" />
            </div>
        </div>
    </main>
</div>

<%-- ── Reject with Reason Modal ───────────────────────────────────────────── --%>
<div id="rejectModal" class="fixed inset-0 z-[100] flex items-center justify-center p-4 hidden">
    <div class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm" onclick="AdminContent.closeRejectModal()"></div>
    <div class="bg-white dark:bg-slate-900 w-full max-w-md rounded-2xl shadow-2xl relative z-10 overflow-hidden">
        <div class="px-6 py-5 border-b border-slate-100 dark:border-slate-800 flex items-center justify-between">
            <div class="flex items-center gap-2">
                <div class="w-8 h-8 bg-red-100 dark:bg-red-900/30 rounded-lg flex items-center justify-center">
                    <span class="material-icons text-red-500 text-[18px]">cancel</span>
                </div>
                <h3 class="text-lg font-bold text-slate-900 dark:text-white">Từ chối bài viết</h3>
            </div>
            <button onclick="AdminContent.closeRejectModal()" class="text-slate-400 hover:text-slate-600"><span class="material-icons">close</span></button>
        </div>
        <div class="p-6 space-y-3">
            <input type="hidden" id="rejectArticleId" />
            <label class="text-xs font-bold text-slate-500 uppercase tracking-wider block">Lý do từ chối <span class="text-red-500">*</span></label>
            <div class="flex flex-wrap gap-2">
                <button onclick="AdminContent.setRejectReason(this)" data-reason="Nội dung vi phạm chính sách" class="reject-preset px-3 py-1.5 text-xs font-semibold bg-slate-100 dark:bg-slate-700 text-slate-600 dark:text-slate-300 rounded-lg hover:bg-red-100 hover:text-red-600 transition-colors">Vi phạm chính sách</button>
                <button onclick="AdminContent.setRejectReason(this)" data-reason="Thông tin sai lệch hoặc chưa được xác minh" class="reject-preset px-3 py-1.5 text-xs font-semibold bg-slate-100 dark:bg-slate-700 text-slate-600 dark:text-slate-300 rounded-lg hover:bg-red-100 hover:text-red-600 transition-colors">Thông tin sai lệch</button>
                <button onclick="AdminContent.setRejectReason(this)" data-reason="Chất lượng nội dung chưa đạt yêu cầu" class="reject-preset px-3 py-1.5 text-xs font-semibold bg-slate-100 dark:bg-slate-700 text-slate-600 dark:text-slate-300 rounded-lg hover:bg-red-100 hover:text-red-600 transition-colors">Chất lượng chưa đạt</button>
                <button onclick="AdminContent.setRejectReason(this)" data-reason="Nội dung trùng lặp với bài đã đăng" class="reject-preset px-3 py-1.5 text-xs font-semibold bg-slate-100 dark:bg-slate-700 text-slate-600 dark:text-slate-300 rounded-lg hover:bg-red-100 hover:text-red-600 transition-colors">Nội dung trùng lặp</button>
            </div>
            <textarea id="rejectReason" rows="3" maxlength="500" class="w-full bg-slate-50 dark:bg-slate-900/50 border border-slate-200 dark:border-slate-700 rounded-xl px-4 py-3 text-sm focus:ring-2 focus:ring-red-400 outline-none resize-none" placeholder="Nhập lý do từ chối..."></textarea>
        </div>
        <div class="px-6 py-4 border-t border-slate-100 dark:border-slate-800 bg-slate-50 dark:bg-slate-900/50 flex gap-3">
            <button onclick="AdminContent.closeRejectModal()" class="flex-1 px-4 py-2.5 text-sm font-bold text-slate-600 hover:bg-slate-200 dark:hover:bg-slate-800 rounded-xl">Hủy</button>
            <button onclick="AdminContent.doRejectWithReason()" class="flex-1 px-4 py-2.5 text-sm font-bold bg-red-500 text-white hover:bg-red-600 rounded-xl flex items-center justify-center gap-2">
                <span class="material-icons text-sm">cancel</span>Xác nhận từ chối
            </button>
        </div>
    </div>
</div>

<%-- ── Preview Modal ──────────────────────────────────────────────────────── --%>
<div id="previewModal" class="fixed inset-0 z-[100] flex items-center justify-center p-4 hidden">
    <div class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm" onclick="AdminContent.closePreview()"></div>
    <div class="bg-white dark:bg-slate-900 w-full max-w-2xl rounded-2xl shadow-2xl relative z-10 overflow-hidden max-h-[85vh] flex flex-col">
        <div class="px-6 py-4 border-b border-slate-100 dark:border-slate-800 flex items-center justify-between flex-shrink-0">
            <div class="flex items-center gap-2">
                <span class="material-icons text-primary">preview</span>
                <h3 class="text-base font-bold text-slate-900 dark:text-white">Xem trước bài viết</h3>
            </div>
            <button onclick="AdminContent.closePreview()" class="text-slate-400 hover:text-slate-600"><span class="material-icons">close</span></button>
        </div>
        <div id="previewContent" class="p-6 overflow-y-auto flex-1">
            <div class="animate-pulse space-y-3">
                <div class="h-6 bg-slate-200 dark:bg-slate-700 rounded w-3/4"></div>
                <div class="h-4 bg-slate-100 dark:bg-slate-800 rounded w-1/2"></div>
                <div class="h-40 bg-slate-100 dark:bg-slate-800 rounded"></div>
            </div>
        </div>
        <div id="previewActions" class="px-6 py-4 border-t border-slate-100 dark:border-slate-800 bg-slate-50 dark:bg-slate-900/50 flex gap-3 flex-shrink-0"></div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/js/app-utils.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/admin-content.js"></script>
<script>
    AdminContent.init({
        contextPath: '${pageContext.request.contextPath}',
        currentSearchPage: ${not empty currentPage ? currentPage : 1}
    });
    function changePage(p) { AdminContent.fetchArticles(p); }
    function toggleAll(cb) { AdminContent.toggleAll(cb); }
    function handleModerationAction(e, id, ac) { AdminContent.handleModerationAction(e, id, ac); }
    function handleBulkApprove(e) { AdminContent.handleBulkApprove(e); }
    function handleBulkDelete(e) { AdminContent.handleBulkDelete(e); }
    function openPreview(id, title, author, cat, status, summary, img) {
        AdminContent.openPreview(id, title, author, cat, status, summary, img);
    }
</script>
</body>
</html>