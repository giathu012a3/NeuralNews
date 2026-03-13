<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, neuralnews.model.Article" %>
<%
    List<Article> articles = (List<Article>) request.getAttribute("articles");
    Integer currentPage = (Integer) request.getAttribute("currentPage");
    Integer totalPages = (Integer) request.getAttribute("totalPages");
    Integer totalArticles = (Integer) request.getAttribute("totalArticles");
    Integer limit = (Integer) request.getAttribute("limit");

    if (currentPage == null) currentPage = 1;
    if (totalPages == null) totalPages = 1;
    if (totalArticles == null) totalArticles = 0;
    if (limit == null) limit = 10;
    
    int start = (currentPage - 1) * limit + 1;
    int end = Math.min(start + limit - 1, totalArticles);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="components/head.jsp" />
    <title>Quản lý Nội dung | NexusAI</title>
    <style>
        .ai-gauge {
            background: conic-gradient(#ef4444 0% 40%, #fbbf24 40% 60%, #22c55e 60% 100%);
            border-radius: 50% 50% 0 0;
            width: 100px;
            height: 50px;
        }
    </style>
</head>
<body class="bg-dashboard-bg dark:bg-background-dark">
    <div class="flex min-h-screen">
        <jsp:include page="components/sidebar.jsp">
            <jsp:param name="activePage" value="content" />
        </jsp:include>
        
        <main class="flex-1 ml-64 mr-80 bg-dashboard-bg dark:bg-background-dark/95 min-h-screen">
            <!-- Header -->
            <header class="sticky top-0 z-40 bg-dashboard-bg/80 dark:bg-background-dark/80 backdrop-blur-md px-8 py-4 flex items-center justify-between border-b border-slate-200 dark:border-slate-800">
                <div>
                    <p class="text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-widest">Hệ thống Quản lý</p>
                    <h2 class="text-2xl font-bold text-slate-800 dark:text-white">Quản lý Nội dung</h2>
                </div>
                <div class="flex items-center gap-4">
                    <div class="relative flex items-center">
                        <span class="material-icons absolute left-3 text-slate-400 text-[18px]">search</span>
                        <input class="pl-10 pr-4 py-2 bg-white dark:bg-slate-800 border-none rounded-lg text-sm focus:ring-2 focus:ring-primary w-64 shadow-sm" placeholder="Tìm kiếm bài viết..." type="text" />
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/create_article.jsp" class="bg-primary hover:bg-primary/90 text-white px-4 py-2 rounded-lg text-sm font-bold flex items-center gap-2 shadow-lg shadow-primary/20 transition-all">
                        <span class="material-icons text-sm">add</span> Đăng bài mới
                    </a>
                    <jsp:include page="components/header_profile.jsp" />
                </div>
            </header>

            <div class="p-8 space-y-6">
                <!-- Filters -->
                <div class="bg-white dark:bg-slate-800 p-4 rounded-xl shadow-sm border border-slate-100 dark:border-slate-700 flex flex-wrap items-center gap-4">
                    <div class="flex-1 min-w-[200px]">
                        <label class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Tìm nhanh</label>
                        <input class="w-full text-sm border-slate-200 dark:border-slate-600 dark:bg-slate-900 rounded-lg focus:ring-primary" placeholder="Tiêu đề, Tác giả, hoặc ID..." type="text" />
                    </div>
                    <div>
                        <label class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Danh mục</label>
                        <select class="text-sm border-slate-200 dark:border-slate-600 dark:bg-slate-900 rounded-lg focus:ring-primary">
                            <option>Tất cả danh mục</option>
                            <option>Technology</option>
                            <option>Politics</option>
                            <option>Health</option>
                        </select>
                    </div>
                    <div>
                        <label class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Trạng thái</label>
                        <select class="text-sm border-slate-200 dark:border-slate-600 dark:bg-slate-900 rounded-lg focus:ring-primary">
                            <option>Tất cả trạng thái</option>
                            <option>Đã đăng</option>
                            <option>Chờ duyệt</option>
                            <option>Bản nháp</option>
                            <option>Đã gỡ</option>
                        </select>
                    </div>
                    <div class="flex items-end h-full pt-4">
                        <button class="bg-slate-100 dark:bg-slate-700 text-slate-600 dark:text-slate-300 px-4 py-2 rounded-lg text-sm font-medium hover:bg-slate-200 transition-colors">
                            Xóa bộ lọc
                        </button>
                    </div>
                </div>

                <!-- Bulk Actions & Info -->
                <div class="flex items-center justify-between">
                    <div class="flex items-center gap-3">
                        <input id="selectAll" class="rounded border-slate-300 text-primary focus:ring-primary" type="checkbox" />
                        <span class="text-sm font-medium text-slate-600 dark:text-slate-400">Chọn tất cả</span>
                        <button id="bulkApproveBtn" class="ml-4 px-3 py-1.5 bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 rounded-md text-xs font-bold hover:bg-green-200 transition-colors">
                            Duyệt hàng loạt
                        </button>
                    </div>
                    <div class="text-sm text-slate-500">
                        Hiển thị <%= start %>-<%= end %> trong <%= totalArticles %> bài viết
                    </div>
                </div>

                <!-- Articles Table -->
                <div class="bg-white dark:bg-slate-800 rounded-xl shadow-sm border border-slate-100 dark:border-slate-700 overflow-hidden">
                    <table class="w-full text-left table-auto">
                        <thead>
                            <tr class="bg-slate-50 dark:bg-slate-900/50 border-b border-slate-100 dark:border-slate-700">
                                <th class="px-6 py-4 w-12"></th>
                                <th class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider">Bài viết</th>
                                <th class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider">Tác giả</th>
                                <th class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider text-center">Trạng thái</th>
                                <th class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider text-center">Thống kê</th>
                                <th class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider">Chất lượng AI</th>
                                <th class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider text-right">Hành động</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-100 dark:divide-slate-700">
                            <% if (articles != null && !articles.isEmpty()) { %>
                                <% for (Article article : articles) { %>
                                    <tr class="hover:bg-slate-50 dark:hover:bg-slate-700/20 transition-colors cursor-pointer group" data-id="<%= article.getId() %>">
                                        <td class="px-6 py-4">
                                            <input class="article-checkbox rounded border-slate-300 text-primary focus:ring-primary" type="checkbox" value="<%= article.getId() %>" />
                                        </td>
                                        <td class="px-6 py-4">
                                            <div class="flex items-center gap-4">
                                                <img alt="Thumbnail" class="w-12 h-12 rounded object-cover" src="<%= (article.getImageUrl() != null && !article.getImageUrl().isEmpty()) ? article.getImageUrl() : "https://via.placeholder.com/150" %>" />
                                                <div class="max-w-[300px]">
                                                    <h4 class="text-sm font-semibold text-slate-800 dark:text-white group-hover:text-primary transition-colors truncate">
                                                        <%= article.getTitle() %>
                                                    </h4>
                                                    <p class="text-[11px] text-slate-500 mt-0.5">
                                                        <%= article.getCategoryName() %> • <%= article.getCreatedAt() %>
                                                    </p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4">
                                            <a class="text-sm text-primary hover:underline font-medium" href="#">Tác giả #<%= article.getAuthorId() %></a>
                                        </td>
                                        <td class="px-6 py-4 text-center">
                                            <span class="px-2.5 py-1 text-[10px] font-bold rounded-full <%= article.getStatusBadgeClass() %>">
                                                <%= article.getStatusLabel() %>
                                            </span>
                                        </td>
                                        <td class="px-6 py-4">
                                            <div class="flex items-center justify-center gap-4 text-slate-400">
                                                <span class="flex items-center gap-1 text-[11px]">
                                                    <span class="material-icons text-sm">visibility</span> <%= article.getFormattedViews() %>
                                                </span>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4">
                                            <% 
                                                int score = (int)(article.getSourceScore() * 100);
                                                String scoreColor = score > 80 ? "bg-green-500" : (score > 50 ? "bg-amber-500" : "bg-red-500");
                                            %>
                                            <div class="flex items-center gap-2">
                                                <div class="w-1.5 h-1.5 rounded-full <%= scoreColor %>"></div>
                                                <span class="text-sm font-bold text-slate-800 dark:text-white"><%= score %>%</span>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 text-right">
                                            <div class="flex justify-end gap-1">
                                                <button onclick="handleAction('approve', <%= article.getId() %>)" class="p-2 text-green-500 hover:bg-green-50 dark:hover:bg-green-900/20 rounded-lg transition-all" title="Duyệt nhanh">
                                                    <span class="material-symbols-outlined text-[20px]">check_circle</span>
                                                </button>
                                                <button class="p-2 text-slate-400 hover:text-primary hover:bg-primary/10 rounded-lg transition-all" title="Xem chi tiết" onclick="openReviewModal('<%= article.getTitle().replace("'", "\\'") %>', <%= article.getId() %>)">
                                                    <span class="material-symbols-outlined text-[20px]">visibility</span>
                                                </button>
                                                <button onclick="handleAction('archive', <%= article.getId() %>)" class="p-2 text-slate-400 hover:text-amber-500 hover:bg-amber-50 rounded-lg transition-all" title="Lưu trữ">
                                                    <span class="material-symbols-outlined text-[20px]">archive</span>
                                                </button>
                                                <button onclick="handleAction('reject', <%= article.getId() %>)" class="p-2 text-slate-400 hover:text-red-500 hover:bg-red-50 rounded-lg transition-all" title="Từ chối">
                                                    <span class="material-symbols-outlined text-[20px]">block</span>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                <% } %>
                            <% } else { %>
                                <tr>
                                    <td colspan="7" class="px-6 py-20 text-center text-slate-400">
                                        <span class="material-symbols-outlined text-5xl mb-4">article</span>
                                        <p class="text-lg">Không có bài viết nào được tìm thấy</p>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <div class="flex items-center justify-between pt-4">
                    <p class="text-sm text-slate-500">
                        Trang <%= currentPage %> / <%= totalPages %>
                    </p>
                    <div class="flex gap-2">
                        <a href="?page=<%= Math.max(1, currentPage - 1) %>" class="px-4 py-2 bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-lg text-sm font-medium hover:bg-slate-50 transition-colors <%= currentPage == 1 ? "opacity-50 pointer-events-none" : "" %>">
                            Trang trước
                        </a>
                        <% for (int i = 1; i <= totalPages; i++) { %>
                            <a href="?page=<%= i %>" class="px-4 py-2 <%= i == currentPage ? "bg-primary text-white" : "bg-white dark:bg-slate-800 text-slate-600 dark:text-slate-300 border border-slate-200 dark:border-slate-700" %> rounded-lg text-sm font-bold hover:bg-slate-50 transition-colors">
                                <%= i %>
                            </a>
                        <% } %>
                        <a href="?page=<%= Math.min(totalPages, currentPage + 1) %>" class="px-4 py-2 bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-lg text-sm font-medium hover:bg-slate-50 transition-colors <%= currentPage >= totalPages ? "opacity-50 pointer-events-none" : "" %>">
                            Trang sau
                        </a>
                    </div>
                </div>
            </div>
        </main>

        <!-- Sidebar Content AI -->
        <aside class="w-80 bg-white dark:bg-slate-800 border-l border-slate-200 dark:border-slate-700 fixed right-0 h-full overflow-y-auto z-40">
            <div class="p-6 border-b border-slate-100 dark:border-slate-700">
                <h3 class="flex items-center gap-2 font-bold text-slate-800 dark:text-white">
                    <span class="material-icons text-primary text-[20px]">auto_awesome</span>
                    Phân tích AI
                </h3>
            </div>
            <div class="p-6 space-y-8">
                <div>
                    <p class="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-4">Phân tích Cảm xúc</p>
                    <div class="flex flex-col items-center">
                        <div class="relative">
                            <div class="ai-gauge"></div>
                            <div class="absolute bottom-0 left-1/2 -translate-x-1/2 w-4 h-4 bg-slate-800 dark:bg-white rounded-full border-2 border-white dark:border-slate-800"></div>
                            <div class="absolute bottom-1 left-1/2 -translate-x-1/2 w-1 h-12 bg-slate-800 dark:bg-white origin-bottom rotate-[25deg] rounded-full"></div>
                        </div>
                        <div class="flex justify-between w-full mt-2 px-6">
                            <span class="text-[10px] font-medium text-red-500">Tiêu cực</span>
                            <span class="text-[10px] font-medium text-green-500">Tích cực</span>
                        </div>
                        <p class="mt-4 text-lg font-bold text-slate-800 dark:text-white">65% Tích cực</p>
                        <p class="text-xs text-slate-500 text-center px-4 italic">Nội dung có xu hướng tích cực và khách quan.</p>
                    </div>
                </div>

                <div>
                    <div class="flex justify-between items-center mb-2">
                        <p class="text-[10px] font-bold text-slate-400 uppercase tracking-widest">Độ độc bản</p>
                        <span class="text-xs font-bold text-green-600">98% Độc nhất</span>
                    </div>
                    <div class="w-full h-2.5 bg-slate-100 dark:bg-slate-700 rounded-full overflow-hidden">
                        <div class="bg-green-500 h-full w-[98%]"></div>
                    </div>
                    <div class="mt-2 flex items-center gap-2">
                        <span class="material-icons text-green-500 text-xs">verified</span>
                        <p class="text-[10px] text-slate-500">Nội dung gốc, không phát hiện sao chép.</p>
                    </div>
                </div>

                <div>
                    <p class="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-3">Thẻ Gợi ý AI</p>
                    <div class="flex flex-wrap gap-2">
                        <span class="px-2 py-1 bg-primary/10 text-primary rounded-md text-[11px] font-semibold flex items-center gap-1 border border-primary/20">
                            #AI <span class="material-icons text-[12px]">add</span>
                        </span>
                        <span class="px-2 py-1 bg-primary/10 text-primary rounded-md text-[11px] font-semibold flex items-center gap-1 border border-primary/20">
                            #Tech <span class="material-icons text-[12px]">add</span>
                        </span>
                        <span class="px-2 py-1 bg-slate-100 dark:bg-slate-700 text-slate-500 rounded-md text-[11px] font-semibold flex items-center gap-1 border border-slate-200 dark:border-slate-600">
                            #Future <span class="material-icons text-[12px]">add</span>
                        </span>
                    </div>
                </div>
            </div>
        </aside>
    </div>

    <!-- Review Modal -->
    <div id="reviewModal" class="fixed inset-0 z-[60] bg-slate-900/60 backdrop-blur-sm flex items-center justify-center p-8 hidden">
        <div class="bg-white dark:bg-slate-900 w-[90%] h-full max-h-[90vh] rounded-2xl shadow-2xl flex flex-col overflow-hidden animate-in fade-in zoom-in duration-300 relative">
             <!-- Modal Header -->
            <div class="px-8 py-4 border-b border-slate-100 dark:border-slate-700 flex items-center justify-between bg-white dark:bg-slate-900 sticky top-0 z-10">
                <div class="flex items-center gap-4">
                    <button onclick="closeReviewModal()" class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-full transition-colors text-slate-500">
                        <span class="material-icons">close</span>
                    </button>
                    <div>
                        <h3 class="font-bold text-slate-800 dark:text-white" id="modalArticleTitle">Đang xem xét bài viết...</h3>
                        <p id="modalArticleMeta" class="text-xs text-slate-500">Thông tin tác giả...</p>
                    </div>
                </div>
                <div class="flex gap-2">
                    <button id="modalApproveBtn" class="px-4 py-2 bg-green-500 text-white rounded-lg font-bold text-sm flex items-center gap-2">
                        <span class="material-icons text-sm">check</span> Duyệt
                    </button>
                    <button id="modalRejectBtn" class="px-4 py-2 bg-red-500 text-white rounded-lg font-bold text-sm flex items-center gap-2">
                        <span class="material-icons text-sm">block</span> Từ chối
                    </button>
                </div>
            </div>

            <div class="flex flex-1 overflow-hidden">
                <div class="flex-1 overflow-y-auto p-12 custom-scrollbar bg-white dark:bg-slate-900">
                    <div class="max-w-3xl mx-auto space-y-8">
                        <div id="modalContent" class="prose prose-slate dark:prose-invert max-w-none text-slate-600 dark:text-slate-300">
                            Đang tải nội dung...
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/utils.js"></script>
    <script>
        function handleAction(action, articleId) {
            if(!confirm('Bạn có chắc chắn muốn thực hiện hành động này?')) return;
            
            ajaxUtils.post('${pageContext.request.contextPath}/admin/content', {
                action: action,
                articleId: articleId
            }).then(res => {
                if(res.success) {
                    location.reload();
                } else {
                    alert('Có lỗi xảy ra!');
                }
            }).catch(err => {
                console.error(err);
                alert('Lỗi kết nối server!');
            });
        }

        function openReviewModal(title, id) {
            document.getElementById('modalArticleTitle').textContent = title;
            document.getElementById('reviewModal').classList.remove('hidden');
            
            // Ở đây có thể gọi AJAX để lấy content đầy đủ nếu cần
            document.getElementById('modalContent').innerHTML = "<p>Nội dung chi tiết của bài viết sẽ được tải ở đây...</p>";
            
            document.getElementById('modalApproveBtn').onclick = () => handleAction('approve', id);
            document.getElementById('modalRejectBtn').onclick = () => handleAction('reject', id);
        }

        function closeReviewModal() {
            document.getElementById('reviewModal').classList.add('hidden');
        }

        // Bulk Actions
        const selectAll = document.getElementById('selectAll');
        const articleCheckboxes = document.querySelectorAll('.article-checkbox');
        
        selectAll.addEventListener('change', () => {
            articleCheckboxes.forEach(cb => cb.checked = selectAll.checked);
        });

        document.getElementById('bulkApproveBtn').addEventListener('click', () => {
            const selectedIds = Array.from(articleCheckboxes)
                .filter(cb => cb.checked)
                .map(cb => cb.value);
                
            if(selectedIds.length === 0) return alert('Vui lòng chọn ít nhất một bài viết!');
            
            if(!confirm(`Xác nhận duyệt ${selectedIds.length} bài viết đã chọn?`)) return;

            // Thực hiện bulk approve
            ajaxUtils.post('${pageContext.request.contextPath}/admin/content', {
                action: 'bulk_approve',
                'ids[]': selectedIds
            }).then(res => {
                if(res.success) location.reload();
                else alert('Lỗi khi duyệt hàng loạt');
            });
        });
    </script>
</body>
</html>
