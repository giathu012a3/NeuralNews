<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="neuralnews.model.Article" %>
            <% List<Article> articles = (List<Article>) request.getAttribute("articles");
                    if (articles == null) {
                    request.getRequestDispatcher("/admin/content").forward(request, response);
                    return;
                    }
                    Integer currentPage = (Integer) request.getAttribute("currentPage");
                    Integer totalPages = (Integer) request.getAttribute("totalPages");
                    Integer totalArticles = (Integer) request.getAttribute("totalArticles");
                    Integer limit = (Integer) request.getAttribute("limit");

                    if (currentPage == null) currentPage = 1;
                    if (totalPages == null) totalPages = 1;
                    if (totalArticles == null) totalArticles = 0;
                    if (limit == null) limit = 10;

                    int startItem = (currentPage - 1) * limit + 1;
                    int endItem = Math.min(startItem + limit - 1, totalArticles);
                    if (totalArticles == 0) {
                    startItem = 0;
                    endItem = 0;
                    }
                    %>
                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <jsp:include page="components/head.jsp" />
                        <title>AI Content Management System</title>
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
                            <main class="flex-1 ml-64 bg-dashboard-bg dark:bg-background-dark/95 min-h-screen">
                                <header
                                    class="sticky top-0 z-40 bg-dashboard-bg/80 dark:bg-background-dark/80 backdrop-blur-md px-8 py-4 flex items-center justify-between border-b border-slate-200 dark:border-slate-800">
                                    <div>
                                        <p
                                            class="text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-widest">
                                            Hệ thống</p>
                                        <h2 class="text-2xl font-bold text-slate-800 dark:text-white">Quản lý nội dung
                                        </h2>
                                    </div>
                                    <div class="flex items-center gap-4">
                                        <div class="relative flex items-center"> <span
                                                class="material-icons absolute left-3 text-slate-400 text-[18px]">search</span>
                                            <input
                                                class="pl-10 pr-4 py-2 bg-white dark:bg-slate-800 border-none rounded-lg text-sm focus:ring-2 focus:ring-primary w-64 shadow-sm"
                                                placeholder="Tìm kiếm..." type="text" />
                                        </div> <a href="${pageContext.request.contextPath}/admin/create_article.jsp"
                                            class="bg-primary hover:bg-primary/90 text-white px-4 py-2 rounded-lg text-sm font-bold flex items-center gap-2 shadow-lg shadow-primary/20 transition-all">
                                            <span class="material-icons text-sm">add</span> Viết bài mới </a>
                                        <jsp:include page="components/header_profile.jsp" />
                                    </div>
                                </header>
                                <div class="p-8 space-y-6">
                                    <div
                                        class="bg-white dark:bg-slate-800 p-4 rounded-xl shadow-sm border border-slate-100 dark:border-slate-700 flex flex-wrap items-center gap-4">
                                        <div class="flex-1 min-w-[200px]"> <label
                                                class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Tìm
                                                kiếm
                                                nhanh</label>
                                            <input
                                                class="w-full text-sm border-slate-200 dark:border-slate-600 dark:bg-slate-900 rounded-lg focus:ring-primary"
                                                placeholder="Tiêu đề, Tác giả, hoặc ID..." type="text" />
                                        </div>
                                        <div> <label
                                                class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Danh
                                                mục</label>
                                            <select
                                                class="text-sm border-slate-200 dark:border-slate-600 dark:bg-slate-900 rounded-lg focus:ring-primary">
                                                <option>Tất cả danh mục</option>
                                                <option>Công nghệ</option>
                                                <option>Chính trị</option>
                                                <option>Sức khỏe</option>
                                            </select>
                                        </div>
                                        <div> <label
                                                class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Trạng
                                                thái</label>
                                            <select
                                                class="text-sm border-slate-200 dark:border-slate-600 dark:bg-slate-900 rounded-lg focus:ring-primary">
                                                <option>Tất cả trạng thái</option>
                                                <option>Đã xuất bản</option>
                                                <option>Đang chờ duyệt</option>
                                                <option>Bản nháp</option>
                                                <option>Bị gỡ/Từ chối</option>
                                            </select>
                                        </div>
                                        <div class="flex items-end h-full pt-4"> <button
                                                class="bg-slate-100 dark:bg-slate-700 text-slate-600 dark:text-slate-300 px-4 py-2 rounded-lg text-sm font-medium hover:bg-slate-200 transition-colors">
                                                Xóa bộ lọc </button> </div>
                                    </div>
                                    <div class="flex items-center justify-between">
                                        <div class="flex items-center gap-3"> <input
                                                class="rounded border-slate-300 text-primary focus:ring-primary"
                                                type="checkbox" />
                                            <span class="text-sm font-medium text-slate-600 dark:text-slate-400">Chọn
                                                tất cả</span>
                                            <button onclick="handleBulkApprove(event)"
                                                class="ml-4 px-3 py-1.5 bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 rounded-md text-xs font-bold hover:bg-green-200 transition-colors">
                                                Duyệt hàng loạt </button>
                                        </div>
                                        <div class="text-sm text-slate-500"> Đang hiển thị từ <%= startItem %>-<%=
                                                    endItem %> trên tổng số
                                                    <%= totalArticles %> bài viết </div>
                                    </div>
                                    <div
                                        class="bg-white dark:bg-slate-800 rounded-xl shadow-sm border border-slate-100 dark:border-slate-700 overflow-hidden">
                                        <table class="w-full text-left table-auto">
                                            <thead>
                                                <tr
                                                    class="bg-slate-50 dark:bg-slate-900/50 border-b border-slate-100 dark:border-slate-700">
                                                    <th class="px-6 py-4 w-12"></th>
                                                    <th
                                                        class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider">
                                                        Bài viết</th>
                                                    <th
                                                        class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider">
                                                        Danh mục</th>
                                                    <th
                                                        class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider">
                                                        Tác giả</th>
                                                    <th
                                                        class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider text-center">
                                                        Trạng thái</th>
                                                    <th
                                                        class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider text-center">
                                                        Thống kê</th>
                                                    <th
                                                        class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider">
                                                        Chất lượng AI</th>
                                                    <th
                                                        class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider text-right">
                                                        Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody class="divide-y divide-slate-100 dark:divide-slate-700">
                                                <% if (articles.isEmpty()) { %>
                                                    <tr>
                                                        <td colspan="8" class="text-center text-slate-400 py-12">
                                                            Chưa có bài viết nào.
                                                        </td>
                                                    </tr>
                                                    <% } else { %>
                                                        <% for (Article a : articles) { String
                                                            rowClass="hover:bg-slate-50 dark:hover:bg-slate-700/20 transition-colors cursor-pointer group "
                                                            ; if ("PENDING".equals(a.getStatus())) { rowClass
                                                            +="bg-amber-50/30 dark:bg-amber-900/10" ; } %>
                                                            <tr class="<%= rowClass %>">
                                                                <td class="px-6 py-4"> <input
                                                                        class="rounded border-slate-300 text-primary focus:ring-primary article-checkbox"
                                                                        type="checkbox" value="<%= a.getId() %>" />
                                                                </td>
                                                                <td class="px-6 py-4">
                                                                    <div class="flex items-center gap-4">
                                                                        <% String imgUrl=a.getImageUrl() !=null ?
                                                                            a.getImageUrl()
                                                                            : "https://via.placeholder.com/150" ; %>
                                                                            <img alt="Article Thumbnail"
                                                                                class="w-12 h-12 rounded object-cover"
                                                                                src="<%= imgUrl %>" />
                                                                            <div>
                                                                                <h4
                                                                                    class="text-sm font-semibold text-slate-800 dark:text-white group-hover:text-primary transition-colors">
                                                                                    <%= a.getTitle() %>
                                                                                </h4>
                                                                                <p
                                                                                    class="text-[11px] text-slate-500 mt-0.5">
                                                                                    <% if (a.getCreatedAt() !=null) {
                                                                                        java.text.SimpleDateFormat
                                                                                        sdf=new
                                                                                        java.text.SimpleDateFormat("dd/MM/yyyy/HH:mm");
                                                                                        out.print(sdf.format(a.getCreatedAt()));
                                                                                        } else { out.print("—"); } %>
                                                                                </p>
                                                                            </div>
                                                                    </div>
                                                                </td>
                                                                <td
                                                                    class="px-6 py-4 text-sm font-medium text-slate-500 dark:text-slate-400">
                                                                    <%= a.getCategoryName() !=null ? a.getCategoryName()
                                                                        : "N/A" %>
                                                                </td>
                                                                <td class="px-6 py-4"> <a
                                                                        class="text-sm text-primary hover:underline font-medium"
                                                                        href="#">
                                                                        <form
                                                                            action="${pageContext.request.contextPath}/admin/users.jsp">
                                                                            <%= a.getAuthorName() !=null ?
                                                                                a.getAuthorName() : "Khuyết danh" %>
                                                                        </form>
                                                                    </a> </td>
                                                                <td class="px-6 py-4 text-center"> <span
                                                                        class="px-2.5 py-1 text-[10px] font-bold rounded-full whitespace-nowrap <%= a.getStatusBadgeClass() %>">
                                                                        <%= a.getStatusLabel() %>
                                                                    </span>
                                                                </td>
                                                                <td class="px-6 py-4">
                                                                    <div
                                                                        class="flex items-center justify-center gap-4 text-slate-400">
                                                                        <span
                                                                            class="flex items-center gap-1 text-[11px]"><span
                                                                                class="material-icons text-sm">visibility</span>
                                                                            <%= a.getFormattedViews() %>
                                                                        </span>
                                                                    </div>
                                                                </td>
                                                                <td class="px-6 py-4">
                                                                    <div class="flex items-center gap-2">
                                                                        <div
                                                                            class="w-1.5 h-1.5 rounded-full bg-green-500">
                                                                        </div> <span
                                                                            class="text-sm font-bold text-slate-800 dark:text-white">92%</span>
                                                                    </div>
                                                                </td>
                                                                <td class="px-6 py-4 text-right">
                                                                    <div class="flex justify-end gap-1">
                                                                        <a href="${pageContext.request.contextPath}/user/article.jsp?id=<%= a.getId() %>"
                                                                            target="_blank"
                                                                            class="p-2 text-slate-400 hover:text-primary hover:bg-primary/10 rounded-lg transition-all"
                                                                            title="Xem bài viết">
                                                                            <span
                                                                                class="material-symbols-outlined text-[20px]">visibility</span>
                                                                        </a>
                                                                        <% if ("PENDING".equals(a.getStatus())) { %>
                                                                            <button type="button"
                                                                                onclick="handleModerationAction(event, <%= a.getId() %>, 'approve', this)"
                                                                                class="p-2 text-green-500 hover:bg-green-50 dark:hover:bg-green-900/20 rounded-lg transition-all"
                                                                                title="Đăng bài">
                                                                                <span
                                                                                    class="material-symbols-outlined text-[20px]">check_circle</span>
                                                                            </button>
                                                                            <button type="button"
                                                                                onclick="handleModerationAction(event, <%= a.getId() %>, 'reject', this)"
                                                                                class="p-2 text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-all"
                                                                                title="Từ chối">
                                                                                <span
                                                                                    class="material-symbols-outlined text-[20px]">cancel</span>
                                                                            </button>
                                                                            <% } else if
                                                                                ("PUBLISHED".equals(a.getStatus())) { %>
                                                                                <button type="button"
                                                                                    onclick="handleModerationAction(event, <%= a.getId() %>, 'archive', this)"
                                                                                    class="p-2 text-slate-500 hover:bg-slate-200 dark:hover:bg-slate-700 rounded-lg transition-all"
                                                                                    title="Lưu trữ bài">
                                                                                    <span
                                                                                        class="material-symbols-outlined text-[20px]">archive</span>
                                                                                </button>
                                                                                <% } else if
                                                                                    ("ARCHIVED".equals(a.getStatus())) {
                                                                                    %>
                                                                                    <button type="button"
                                                                                        onclick="handleModerationAction(event, <%= a.getId() %>, 'approve', this)"
                                                                                        class="p-2 text-green-500 hover:bg-green-50 dark:hover:bg-green-900/20 rounded-lg transition-all"
                                                                                        title="Khôi phục & Đăng bài">
                                                                                        <span
                                                                                            class="material-symbols-outlined text-[20px]">settings_backup_restore</span>
                                                                                    </button>
                                                                                    <% } %>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <% } %>
                                                                <% } %>
                                            </tbody>
                                        </table>

                                        <!-- Pagination Controls -->
                                        <div
                                            class="flex items-center justify-between p-4 border-t border-slate-100 dark:border-slate-700 bg-slate-50 dark:bg-slate-800/50">
                                            <p class="text-xs font-medium text-slate-500 dark:text-slate-400">
                                                Hiển thị <span class="text-slate-900 dark:text-white">
                                                    <%= articles.size() %>
                                                </span> bài viết
                                            </p>
                                            <div class="flex items-center gap-1.5">
                                                <% String
                                                    prevClass="px-3 py-1.5 rounded-md border border-slate-200 dark:border-slate-600 hover:bg-slate-100 dark:hover:bg-slate-700 transition-all text-xs font-semibold "
                                                    ; if(currentPage <=1) prevClass +="opacity-50 pointer-events-none" ;
                                                    %>
                                                    <a href="?page=<%= currentPage > 1 ? currentPage - 1 : 1 %>"
                                                        class="<%= prevClass %>">
                                                        Trước
                                                    </a>

                                                    <% for(int i=1; i<=totalPages; i++) { if(i==currentPage) { %>
                                                        <span
                                                            class="px-4 py-1.5 rounded-md bg-primary text-white text-xs font-bold shadow-md">
                                                            <%= i %>
                                                        </span>
                                                        <% } else if(i <=3 || i>= totalPages - 2 || (i >= currentPage -
                                                            1 &&
                                                            i <= currentPage + 1)) { %>
                                                                <a href="?page=<%= i %>"
                                                                    class="px-4 py-1.5 rounded-md border border-slate-200 dark:border-slate-600 hover:bg-slate-100 dark:hover:bg-slate-700 transition-all text-xs font-semibold text-slate-600 dark:text-slate-300">
                                                                    <%= i %>
                                                                </a>
                                                                <% } else if (i==4 && currentPage> 5) { %>
                                                                    <span class="px-2 text-slate-400">...</span>
                                                                    <% } else if (i==totalPages - 3 && currentPage <
                                                                        totalPages - 4) { %>
                                                                        <span class="px-2 text-slate-400">...</span>
                                                                        <% } } %>

                                                                            <% String
                                                                                nextClass="px-3 py-1.5 rounded-md border border-slate-200 dark:border-slate-600 hover:bg-slate-100 dark:hover:bg-slate-700 transition-all text-xs font-semibold "
                                                                                ; if(currentPage>= totalPages) nextClass
                                                                                += "opacity-50 pointer-events-none";
                                                                                %>
                                                                                <a href="?page=<%= currentPage < totalPages ? currentPage + 1 : totalPages %>"
                                                                                    class="<%= nextClass %>">
                                                                                    Tiếp
                                                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                        </div>
                        </main>
                        </div>
                        <script>
                            function handleBulkApprove(event) {
                                event.preventDefault();

                                const checkboxes = document.querySelectorAll('.article-checkbox:checked');
                                if (checkboxes.length === 0) {
                                    alert('Vui lòng chọn ít nhất một bài viết để duyệt!');
                                    return;
                                }

                                if (!confirm('Bạn có chắc chắn muốn duyệt ' + checkboxes.length + ' bài viết đã chọn?')) {
                                    return;
                                }

                                const formData = new URLSearchParams();
                                formData.append('action', 'bulk_approve');
                                checkboxes.forEach(cb => {
                                    formData.append('articleIds[]', cb.value);
                                });

                                fetch('${pageContext.request.contextPath}/admin/content', {
                                    method: 'POST',
                                    headers: {
                                        'Content-Type': 'application/x-www-form-urlencoded',
                                    },
                                    body: formData.toString()
                                })
                                    .then(response => response.json())
                                    .then(data => {
                                        if (data.success) {
                                            window.location.reload();
                                        } else {
                                            alert('Có lỗi xảy ra, vui lòng thử lại!');
                                        }
                                    })
                                    .catch(error => {
                                        console.error('Error:', error);
                                        alert('Đã xảy ra lỗi kết nối!');
                                    });
                            }

                            function handleModerationAction(event, articleId, action, btnElem) {
                                event.preventDefault();

                                let confirmMsg = '';
                                if (action === 'approve') {
                                    confirmMsg = btnElem.title.includes('Khôi phục') ?
                                        'Bạn có chắc chắn muốn khôi phục và đăng lại bài viết này?' :
                                        'Bạn có chắc chắn muốn đăng bài viết này?';
                                } else if (action === 'reject') {
                                    confirmMsg = 'Bạn có chắc chắn muốn từ chối bài viết này?';
                                } else if (action === 'archive') {
                                    confirmMsg = 'Bạn có chắc chắn muốn lưu trữ bài viết này?';
                                }

                                if (!confirm(confirmMsg)) {
                                    return;
                                }

                                fetch('${pageContext.request.contextPath}/admin/content', {
                                    method: 'POST',
                                    headers: {
                                        'Content-Type': 'application/x-www-form-urlencoded',
                                    },
                                    body: 'action=' + action + '&articleId=' + articleId
                                })
                                    .then(response => response.json())
                                    .then(data => {
                                        if (data.success) {
                                            const row = btnElem.closest('tr');
                                            const badgeSpan = row.querySelector('td:nth-child(5) span');

                                            const actionsContainer = btnElem.closest('.flex.justify-end.gap-1');

                                            if (action === 'approve') {
                                                badgeSpan.className = 'px-2.5 py-1 text-[10px] font-bold rounded-full whitespace-nowrap bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400';
                                                badgeSpan.textContent = 'ĐÃ ĐĂNG';

                                                actionsContainer.innerHTML = `
                                                <a href="${pageContext.request.contextPath}/user/article.jsp?id=` + articleId + `" target="_blank"
                                                    class="p-2 text-slate-400 hover:text-primary hover:bg-primary/10 rounded-lg transition-all"
                                                    title="Xem bài viết">
                                                    <span class="material-symbols-outlined text-[20px]">visibility</span>
                                                </a>
                                                <button type="button"
                                                    onclick="handleModerationAction(event, ` + articleId + `, 'archive', this)"
                                                    class="p-2 text-slate-500 hover:bg-slate-200 dark:hover:bg-slate-700 rounded-lg transition-all"
                                                    title="Lưu trữ bài" >
                                                    <span class="material-symbols-outlined text-[20px]">archive</span>
                                                </button>
                                            `;
                                            } else if (action === 'reject') {
                                                badgeSpan.className = 'px-2.5 py-1 text-[10px] font-bold rounded-full whitespace-nowrap bg-red-100 text-red-700 dark:bg-red-500/10 dark:text-red-400';
                                                badgeSpan.textContent = 'BỊ TỪ CHỐI';

                                                actionsContainer.innerHTML = `
                                                <a href="${pageContext.request.contextPath}/user/article.jsp?id=` + articleId + `" target="_blank"
                                                    class="p-2 text-slate-400 hover:text-primary hover:bg-primary/10 rounded-lg transition-all"
                                                    title="Xem bài viết">
                                                    <span class="material-symbols-outlined text-[20px]">visibility</span>
                                                </a>
                                                <button type="button"
                                                    onclick="handleModerationAction(event, ` + articleId + `, 'approve', this)"
                                                    class="p-2 text-green-500 hover:bg-green-50 dark:hover:bg-green-900/20 rounded-lg transition-all"
                                                    title="Khôi phục & Đăng bài">
                                                    <span class="material-symbols-outlined text-[20px]">settings_backup_restore</span>
                                                </button>
                                            `;
                                            } else if (action === 'archive') {
                                                badgeSpan.className = 'px-2.5 py-1 text-[10px] font-bold rounded-full whitespace-nowrap bg-slate-100 text-slate-600 dark:bg-slate-500/10 dark:text-slate-400';
                                                badgeSpan.textContent = 'ĐÃ LƯU TRỮ';

                                                actionsContainer.innerHTML = `
                                                <a href="${pageContext.request.contextPath}/user/article.jsp?id=` + articleId + `" target="_blank"
                                                    class="p-2 text-slate-400 hover:text-primary hover:bg-primary/10 rounded-lg transition-all"
                                                    title="Xem bài viết">
                                                    <span class="material-symbols-outlined text-[20px]">visibility</span>
                                                </a>
                                                <button type="button"
                                                    onclick="handleModerationAction(event, ` + articleId + `, 'approve', this)"
                                                    class="p-2 text-green-500 hover:bg-green-50 dark:hover:bg-green-900/20 rounded-lg transition-all"
                                                    title="Khôi phục & Đăng bài">
                                                    <span class="material-symbols-outlined text-[20px]">settings_backup_restore</span>
                                                </button>
                                            `;
                                            }
                                        } else {
                                            alert('Có lỗi xảy ra, vui lòng thử lại!');
                                        }
                                    })
                                    .catch(error => {
                                        console.error('Error:', error);
                                        alert('Có lỗi xảy ra, vui lòng thử lại!');
                                    });
                            }
                        </script>
                    </body>

                    </html>