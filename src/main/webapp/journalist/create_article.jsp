<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="neuralnews.model.Article" %>
<%@ page import="neuralnews.model.User" %>
<%@ page import="neuralnews.model.Category" %>

<%
    // Nếu vào thẳng JSP mà chưa qua controller thì forward
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    if (categories == null) {
        request.getRequestDispatcher("/journalist/create-article").forward(request, response);
        return;
    }
    User currentUser = (User) request.getAttribute("currentUser");
    Article article  = (Article) request.getAttribute("article"); // null nếu tạo mới

    String savedMsg  = request.getParameter("saved");
    String errorMsg  = request.getParameter("error");

    // Helper: lấy giá trị an toàn
    String artTitle   = article != null && article.getTitle()    != null ? article.getTitle()    : "";
    String artContent = article != null && article.getContent()  != null ? article.getContent()  : "";
    String artSummary = article != null && article.getSummary()  != null ? article.getSummary()  : "";
    String artImage   = article != null && article.getImageUrl() != null ? article.getImageUrl() : "";
    int    artCatId   = article != null ? article.getCategoryId() : 0;
    long   artId      = article != null ? article.getId()         : 0;
%>

<!DOCTYPE html>
<html class="dark" lang="vi">
<head>
    <jsp:include page="components/head.jsp" />
    <title>Trình soạn thảo AI - <%= artId > 0 ? "Chỉnh sửa bài viết" : "Tạo bài viết mới" %></title>
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@300;400;500;600;700&display=swap" rel="stylesheet"/>
    <style>
        body { font-family: "Work Sans", sans-serif; }
        .editor-container::-webkit-scrollbar { width: 6px; }
        .editor-container::-webkit-scrollbar-thumb { background-color: rgba(156,163,175,0.2); border-radius:10px; }
        .ai-badge { font-size:10px; padding:2px 8px; border-radius:9999px; font-weight:700; text-transform:uppercase; letter-spacing:.05em; }
        #contentEditor { min-height: 400px; outline: none; }
        #contentEditor:empty:before { content: attr(data-placeholder); color: #4b5563; }
    </style>
</head>

<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen overflow-hidden">
<div class="flex h-screen">

    <%-- ── AI Sidebar ──────────────────────────────────────────────── --%>
    <aside class="w-72 bg-white dark:bg-surface-dark border-r border-slate-200 dark:border-border-dark flex flex-col shrink-0">
        <div class="p-5 border-b border-slate-200 dark:border-border-dark flex items-center justify-between">
            <div class="flex items-center gap-3">
                <div class="bg-primary size-8 rounded flex items-center justify-center text-white">
                    <span class="material-symbols-outlined text-xl">auto_fix_high</span>
                </div>
                <h2 class="text-sm font-bold tracking-tight">TRỢ LÝ AI</h2>
            </div>
            <button class="text-slate-400 hover:text-white transition-colors">
                <span class="material-symbols-outlined text-xl">keyboard_double_arrow_left</span>
            </button>
        </div>
        <div class="flex-1 overflow-y-auto py-6 px-4 space-y-8">

            <%-- Danh mục --%>
            <section>
                <h3 class="text-[11px] font-bold uppercase tracking-[0.1em] text-slate-500 mb-3">Danh mục</h3>
                <select id="categorySelect" name="categoryId"
                        class="w-full bg-slate-50 dark:bg-white/[0.03] border border-slate-200 dark:border-border-dark rounded-lg px-3 py-2 text-xs text-slate-800 dark:text-slate-200 focus:ring-2 focus:ring-primary outline-none">
                    <option value="">-- Chọn danh mục --</option>
                    <% for (Category cat : categories) { %>
                    <option value="<%= cat.getId() %>" <%= cat.getId() == artCatId ? "selected" : "" %>>
                        <%= cat.getName() %>
                    </option>
                    <% } %>
                </select>
            </section>

            <%-- Ảnh đại diện --%>
            <section>
                <h3 class="text-[11px] font-bold uppercase tracking-[0.1em] text-slate-500 mb-3">Ảnh đại diện</h3>
                <div class="space-y-3">
                    <%-- Preview --%>
                    <div id="imagePreview" 
                         class="w-full h-32 rounded-lg bg-slate-100 dark:bg-white/5 border border-dashed border-slate-300 dark:border-border-dark flex items-center justify-center overflow-hidden">
                        <% if (artImage != null && !artImage.isBlank()) { 
                            // Reuse Article display logic here
                            String displayUrl = artImage.startsWith("http") ? artImage : request.getContextPath() + "/" + artImage;
                        %>
                            <img src="<%= displayUrl %>" class="w-full h-full object-cover" />
                        <% } else { %>
                            <span class="material-symbols-outlined text-slate-400">image</span>
                        <% } %>
                    </div>
                    
                    <div class="flex gap-2">
                        <input id="imageUrlInput" type="text" placeholder="URL hoặc đường dẫn ảnh..."
                               value="<%= artImage %>"
                               class="flex-1 bg-slate-50 dark:bg-white/[0.03] border border-slate-200 dark:border-border-dark rounded-lg px-3 py-2 text-[10px] text-slate-800 dark:text-slate-200 focus:ring-2 focus:ring-primary outline-none" />
                        <button type="button" onclick="document.getElementById('fileInput').click()"
                                class="bg-primary/20 text-primary hover:bg-primary/30 p-2 rounded-lg transition-colors">
                            <span class="material-symbols-outlined text-sm">upload</span>
                        </button>
                    </div>
                    <input type="file" id="fileInput" accept="image/*" class="hidden" onchange="uploadImage(this)" />
                    <p class="text-[10px] text-slate-500 italic">* Tải ảnh lên hoặc dán link Unsplash</p>
                </div>
            </section>

            <%-- Tóm tắt --%>
            <section>
                <h3 class="text-[11px] font-bold uppercase tracking-[0.1em] text-slate-500 mb-3">Tóm tắt bài viết</h3>
                <textarea id="summaryInput" rows="4" placeholder="Nhập tóm tắt ngắn gọn..."
                          class="w-full bg-slate-50 dark:bg-white/[0.03] border border-slate-200 dark:border-border-dark rounded-lg px-3 py-2 text-xs text-slate-800 dark:text-slate-200 resize-none focus:ring-2 focus:ring-primary outline-none"><%= artSummary %></textarea>
            </section>

            <%-- SEO --%>
            <section>
                <div class="flex items-center justify-between mb-4 px-1">
                    <h3 class="text-[11px] font-bold uppercase tracking-[0.1em] text-slate-500">Trình tối ưu SEO</h3>
                    <span class="ai-badge bg-emerald-500/10 text-emerald-500">Điểm: 84</span>
                </div>
                <div class="space-y-4 px-1">
                    <div>
                        <div class="flex items-center justify-between text-[11px] mb-2">
                            <span class="text-slate-400">Mật độ Từ khóa</span>
                            <span class="text-emerald-500 font-bold uppercase">Tối ưu</span>
                        </div>
                        <div class="w-full bg-slate-200 dark:bg-slate-800 h-1 rounded-full">
                            <div class="bg-emerald-500 h-1 rounded-full w-[84%]"></div>
                        </div>
                    </div>
                </div>
            </section>

            <%-- Phân tích giọng văn --%>
            <section>
                <div class="flex items-center justify-between mb-4 px-1">
                    <h3 class="text-[11px] font-bold uppercase tracking-[0.1em] text-slate-500">Phân tích Giọng văn</h3>
                    <span class="ai-badge bg-primary/10 text-primary">Cân bằng</span>
                </div>
                <div class="grid grid-cols-2 gap-3">
                    <div class="p-3 bg-slate-50 dark:bg-white/[0.03] border border-slate-200 dark:border-border-dark rounded-lg flex flex-col items-center text-center">
                        <span class="text-primary text-lg font-bold">72%</span>
                        <span class="text-[9px] text-slate-500 uppercase font-bold tracking-tighter">Chuyên nghiệp</span>
                    </div>
                    <div class="p-3 bg-slate-50 dark:bg-white/[0.03] border border-slate-200 dark:border-border-dark rounded-lg flex flex-col items-center text-center">
                        <span class="text-amber-500 text-lg font-bold">18%</span>
                        <span class="text-[9px] text-slate-500 uppercase font-bold tracking-tighter">Khẩn cấp</span>
                    </div>
                </div>
            </section>
        </div>
        <div class="p-4 border-t border-slate-200 dark:border-border-dark">
            <button class="w-full flex items-center justify-center gap-2 py-2 text-xs font-bold text-slate-500 hover:text-primary transition-colors uppercase tracking-widest">
                <span class="material-symbols-outlined text-lg">settings_suggest</span>
                Cấu hình Trợ lý
            </button>
        </div>
    </aside>

    <%-- ── Main Editor ─────────────────────────────────────────────── --%>
    <main class="flex-1 flex flex-col relative bg-white dark:bg-[#0a0f14]">

        <%-- Header --%>
        <header class="h-16 bg-white dark:bg-surface-dark border-b border-slate-200 dark:border-border-dark flex items-center justify-between px-6 shrink-0 z-30">
            <div class="flex items-center gap-6">
                <a class="flex items-center gap-2 text-slate-400 hover:text-white transition-colors group"
                   href="${pageContext.request.contextPath}/journalist/articles">
                    <span class="material-symbols-outlined text-xl transition-transform group-hover:-translate-x-1">arrow_back</span>
                    <span class="text-sm font-semibold uppercase tracking-wider">Quay lại Bảng điều khiển</span>
                </a>
                <div class="h-6 w-px bg-slate-200 dark:bg-border-dark"></div>
                <div class="flex items-center gap-2">
                    <% if ("true".equals(savedMsg)) { %>
                    <span class="size-2 bg-emerald-500 rounded-full"></span>
                    <span class="text-[11px] font-medium text-emerald-500 uppercase tracking-widest">Đã lưu bản nháp!</span>
                    <% } else if (errorMsg != null) { %>
                    <span class="size-2 bg-red-500 rounded-full"></span>
                    <span class="text-[11px] font-medium text-red-500 uppercase tracking-widest">Lỗi: <%= errorMsg %></span>
                    <% } else { %>
                    <span class="size-2 bg-emerald-500 rounded-full animate-pulse"></span>
                    <span class="text-[11px] font-medium text-slate-500 uppercase tracking-widest">
                        <%= artId > 0 ? "Chỉnh sửa bài viết" : "Bài viết mới" %>
                    </span>
                    <% } %>
                </div>
            </div>
            <div class="flex items-center gap-3">
                <%-- Nút Lưu nháp --%>
                <button type="button" onclick="submitForm('draft')"
                        class="px-4 py-2 text-xs font-bold text-slate-600 dark:text-slate-300 border border-transparent hover:border-slate-700 rounded transition-all uppercase tracking-widest">
                    Lưu Bản nháp
                </button>
                <%-- Nút Xem trước --%>
                <% if (artId > 0) { %>
                <a href="${pageContext.request.contextPath}/user/article.jsp?id=<%= artId %>"
                   target="_blank"
                   class="px-4 py-2 text-xs font-bold text-slate-600 dark:text-slate-300 border border-slate-200 dark:border-border-dark hover:bg-slate-100 dark:hover:bg-slate-800 rounded transition-all flex items-center gap-2 uppercase tracking-widest">
                    <span class="material-symbols-outlined text-lg">visibility</span>
                    Xem trước
                </a>
                <% } %>
                <%-- Nút Xuất bản --%>
                <button type="button" onclick="submitForm('submit')"
                        class="px-6 py-2 bg-primary hover:bg-blue-600 text-white text-xs font-bold rounded transition-all uppercase tracking-widest shadow-lg shadow-primary/20">
                    Gửi để Đánh giá
                </button>
            </div>
        </header>

        <%-- Hidden form gửi lên controller --%>
        <form id="articleForm" method="post" action="${pageContext.request.contextPath}/journalist/create-article" style="display:none">
            <input type="hidden" name="articleId"  id="f_articleId"  value="<%= artId > 0 ? artId : "" %>" />
            <input type="hidden" name="title"       id="f_title" />
            <input type="hidden" name="content"     id="f_content" />
            <input type="hidden" name="summary"     id="f_summary" />
            <input type="hidden" name="imageUrl"    id="f_imageUrl" />
            <input type="hidden" name="categoryId"  id="f_categoryId" />
            <input type="hidden" name="action"      id="f_action" />
        </form>

        <%-- Editor content --%>
        <div class="flex-1 overflow-y-auto editor-container p-8 lg:p-16">
            <div class="max-w-4xl mx-auto space-y-10">

                <%-- Tiêu đề --%>
                <input id="titleInput"
                       class="w-full bg-transparent border-none focus:ring-0 text-5xl font-bold placeholder-slate-700 dark:text-white leading-tight outline-none"
                       placeholder="Nhập tiêu đề bài viết..."
                       type="text"
                       value="<%= artTitle %>" />

                <%-- Meta --%>
                <div class="flex items-center gap-6 py-4 border-y border-slate-200 dark:border-border-dark">
                    <div class="flex items-center gap-3">
                        <div class="size-8 rounded-full bg-primary/20 flex items-center justify-center text-primary font-bold text-sm">
                            <%= currentUser != null ? currentUser.getFullName().substring(0,1).toUpperCase() : "?" %>
                        </div>
                        <div class="flex flex-col">
                            <span class="text-xs font-bold text-slate-300"><%= currentUser != null ? currentUser.getFullName() : "" %></span>
                            <span class="text-[10px] text-slate-500 uppercase tracking-tighter">Biên tập viên</span>
                        </div>
                    </div>
                </div>

                <%-- Content editable --%>
                <div id="contentEditor"
                     contenteditable="true"
                     data-placeholder="Bắt đầu viết bài của bạn ở đây..."
                     class="prose prose-slate dark:prose-invert max-w-none text-xl leading-[1.8] text-slate-600 dark:text-slate-300 font-light focus:outline-none min-h-[400px]"><%=
                    artContent.isBlank() ? "" : artContent
                %></div>

            </div>
        </div>

        <%-- Floating toolbar --%>
        <div class="absolute bottom-10 left-1/2 -translate-x-1/2 flex items-center gap-1.5 p-2.5 bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-xl shadow-[0_20px_50px_rgba(0,0,0,0.5)] backdrop-blur-xl z-40">
            <div class="flex items-center gap-0.5 border-r border-slate-200 dark:border-border-dark pr-2">
                <button type="button" onclick="document.execCommand('bold')"
                        class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-600 dark:text-slate-300 transition-colors">
                    <span class="material-symbols-outlined text-xl">format_bold</span>
                </button>
                <button type="button" onclick="document.execCommand('italic')"
                        class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-600 dark:text-slate-300 transition-colors">
                    <span class="material-symbols-outlined text-xl">format_italic</span>
                </button>
                <button type="button" onclick="document.execCommand('underline')"
                        class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-600 dark:text-slate-300 transition-colors">
                    <span class="material-symbols-outlined text-xl">format_underlined</span>
                </button>
            </div>
            <div class="flex items-center gap-0.5 border-r border-slate-200 dark:border-border-dark pr-2">
                <button type="button" onclick="document.execCommand('insertUnorderedList')"
                        class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-600 dark:text-slate-300 transition-colors">
                    <span class="material-symbols-outlined text-xl">format_list_bulleted</span>
                </button>
                <button type="button" onclick="insertLink()"
                        class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-600 dark:text-slate-300 transition-colors">
                    <span class="material-symbols-outlined text-xl">link</span>
                </button>
                <button type="button" onclick="insertImage()"
                        class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-600 dark:text-slate-300 transition-colors">
                    <span class="material-symbols-outlined text-xl">image</span>
                </button>
            </div>
            <button type="button"
                    class="flex items-center gap-3 px-5 py-2.5 bg-primary hover:bg-blue-600 text-white rounded-lg font-bold transition-all text-[11px] uppercase tracking-widest group ml-2">
                <span class="material-symbols-outlined text-lg group-hover:rotate-12 transition-transform">bolt</span>
                Hỏi Trợ lý
            </button>
        </div>

        <%-- Floating buttons --%>
        <div class="absolute top-24 right-8 flex flex-col gap-4">
            <button class="size-12 bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-full shadow-xl flex items-center justify-center hover:border-primary transition-colors group" title="Chế độ Không phân tâm">
                <span class="material-symbols-outlined text-slate-500 group-hover:text-primary">fullscreen</span>
            </button>
            <button class="size-12 bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-full shadow-xl flex items-center justify-center hover:border-primary transition-colors group" title="Chuyển đổi Giao diện">
                <span class="material-symbols-outlined text-slate-500 group-hover:text-primary">contrast</span>
            </button>
        </div>

    </main>
</div>

<script>
    function submitForm(action) {
        const title = document.getElementById('titleInput').value.trim();
        if (!title) {
            alert('Vui lòng nhập tiêu đề bài viết!');
            document.getElementById('titleInput').focus();
            return;
        }
        document.getElementById('f_title').value      = title;
        document.getElementById('f_content').value    = document.getElementById('contentEditor').innerHTML;
        document.getElementById('f_summary').value    = document.getElementById('summaryInput').value;
        document.getElementById('f_imageUrl').value   = document.getElementById('imageUrlInput').value;
        document.getElementById('f_categoryId').value = document.getElementById('categorySelect').value;
        document.getElementById('f_action').value     = action;
        document.getElementById('articleForm').submit();
    }

    function insertLink() {
        const url = prompt('Nhập URL:');
        if (url) document.execCommand('createLink', false, url);
    }

    function insertImage() {
        const url = prompt('Nhập URL ảnh:');
        if (url) document.execCommand('insertImage', false, url);
    }
    function uploadImage(input) {
        if (!input.files || !input.files[0]) return;
        
        const formData = new FormData();
        formData.append('image', input.files[0]);
        
        const preview = document.getElementById('imagePreview');
        const urlInput = document.getElementById('imageUrlInput');
        
        // Show loading
        preview.innerHTML = '<div class="animate-spin rounded-full h-8 w-8 border-b-2 border-primary"></div>';
        
        fetch('${pageContext.request.contextPath}/api/upload', {
            method: 'POST',
            body: formData
        })
        .then(res => res.json())
        .then(data => {
            if (data.success) {
                urlInput.value = data.url;
                preview.innerHTML = `<img src="${pageContext.request.contextPath}/${data.url}" class="w-full h-full object-cover" />`;
            } else {
                alert('Tải ảnh thất bại: ' + data.message);
                preview.innerHTML = '<span class="material-symbols-outlined text-red-500">error</span>';
            }
        })
        .catch(err => {
            console.error(err);
            alert('Lỗi hệ thống khi tải ảnh!');
            preview.innerHTML = '<span class="material-symbols-outlined text-red-500">error</span>';
        });
    }

    // Cập nhật preview khi nhập link thủ công
    document.getElementById('imageUrlInput').addEventListener('change', function() {
        const url = this.value;
        const preview = document.getElementById('imagePreview');
        if (url) {
            const displayUrl = url.startsWith('http') ? url : '${pageContext.request.contextPath}/' + url;
            preview.innerHTML = `<img src="${displayUrl}" class="w-full h-full object-cover" />`;
        } else {
            preview.innerHTML = '<span class="material-symbols-outlined text-slate-400">image</span>';
        }
    });
</script>
</body>
</html>
