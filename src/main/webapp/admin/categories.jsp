<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="components/head.jsp" />
    <title>Quản lý Danh mục | NexusAI Admin</title>
</head>

<body class="bg-[#F4F7FE] dark:bg-background-dark font-sans text-slate-800 dark:text-slate-100 overflow-hidden">
<div class="flex min-h-screen">
    <jsp:include page="components/sidebar.jsp">
        <jsp:param name="activePage" value="categories" />
    </jsp:include>

    <main class="flex-1 ml-64 min-h-screen pb-12">
        <!-- Header -->
        <header class="sticky top-0 z-40 bg-[#F4F7FE]/90 dark:bg-background-dark/90 backdrop-blur-md px-8 py-6 border-b border-slate-200/50 dark:border-slate-800/50">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-xs font-semibold text-slate-400 uppercase tracking-widest">Trang / Danh mục</p>
                    <h2 class="text-2xl font-bold text-slate-900 dark:text-white">Quản lý Danh mục</h2>
                    <p class="text-sm text-slate-500 mt-1">Phân loại bài viết theo chủ đề. Xóa danh mục sẽ không ảnh hưởng các bài viết (chúng sẽ trở thành chưa phân loại).</p>
                </div>
                <div class="flex items-center gap-4">
                    <button onclick="CategoryMgr.openCreate()"
                            class="bg-primary hover:bg-primary/90 text-white px-5 py-2.5 rounded-xl text-sm font-semibold flex items-center gap-2 shadow-lg shadow-primary/20 transition-all">
                        <span class="material-icons text-sm">add</span>
                        Thêm danh mục
                    </button>
                    <jsp:include page="components/header_profile.jsp" />
                </div>
            </div>
        </header>

        <div class="p-8">
            <!-- Stats row -->
            <div class="grid grid-cols-3 gap-6 mb-8">
                <div class="bg-white dark:bg-slate-800 p-6 rounded-2xl shadow-sm border border-slate-100 dark:border-slate-700 flex items-center gap-4">
                    <div class="w-12 h-12 bg-primary/10 rounded-xl flex items-center justify-center">
                        <span class="material-icons text-primary">category</span>
                    </div>
                    <div>
                        <p class="text-xs text-slate-500 font-medium uppercase tracking-wider">Tổng danh mục</p>
                        <p class="text-2xl font-bold text-slate-900 dark:text-white">${categories.size()}</p>
                    </div>
                </div>
                <div class="bg-white dark:bg-slate-800 p-6 rounded-2xl shadow-sm border border-slate-100 dark:border-slate-700 flex items-center gap-4">
                    <div class="w-12 h-12 bg-emerald-100 dark:bg-emerald-900/30 rounded-xl flex items-center justify-center">
                        <span class="material-icons text-emerald-500">article</span>
                    </div>
                    <div>
                        <p class="text-xs text-slate-500 font-medium uppercase tracking-wider">Bài viết đã xuất bản</p>
                        <p class="text-2xl font-bold text-slate-900 dark:text-white">
                            <c:set var="totalArticles" value="0" />
                            <c:forEach items="${categories}" var="cat">
                                <c:set var="totalArticles" value="${totalArticles + cat.articleCount}" />
                            </c:forEach>
                            ${totalArticles}
                        </p>
                    </div>
                </div>
                <div class="bg-white dark:bg-slate-800 p-6 rounded-2xl shadow-sm border border-slate-100 dark:border-slate-700 flex items-center gap-4">
                    <div class="w-12 h-12 bg-amber-100 dark:bg-amber-900/30 rounded-xl flex items-center justify-center">
                        <span class="material-icons text-amber-500">star</span>
                    </div>
                    <div>
                        <p class="text-xs text-slate-500 font-medium uppercase tracking-wider">Danh mục hot nhất</p>
                        <p class="text-sm font-bold text-slate-900 dark:text-white truncate max-w-[140px]">
                            <c:set var="hotCat" value="" />
                            <c:set var="hotCount" value="0" />
                            <c:forEach items="${categories}" var="cat">
                                <c:if test="${cat.articleCount > hotCount}">
                                    <c:set var="hotCat" value="${cat.name}" />
                                    <c:set var="hotCount" value="${cat.articleCount}" />
                                </c:if>
                            </c:forEach>
                            ${empty hotCat ? 'N/A' : hotCat}
                        </p>
                    </div>
                </div>
            </div>

            <!-- Category grid -->
            <div id="category-grid" class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-5">
                <c:forEach items="${categories}" var="cat">
                    <div id="cat-card-${cat.id}" class="bg-white dark:bg-slate-800 rounded-2xl shadow-sm border border-slate-100 dark:border-slate-700 p-6 flex flex-col gap-3 hover:shadow-md transition-all group">
                        <div class="flex items-start justify-between">
                            <div class="flex items-center gap-3">
                                <div class="w-10 h-10 bg-primary/10 rounded-xl flex items-center justify-center flex-shrink-0">
                                    <span class="material-icons text-primary text-[20px]">label</span>
                                </div>
                                <div>
                                    <h3 class="font-bold text-slate-900 dark:text-white text-base leading-tight">${cat.name}</h3>
                                    <span class="px-2 py-0.5 bg-slate-100 dark:bg-slate-700 text-slate-500 dark:text-slate-400 text-[10px] font-bold rounded-full uppercase">ID: ${cat.id}</span>
                                </div>
                            </div>
                            <div class="flex gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
                                <button onclick="CategoryMgr.openEdit(${cat.id}, '${cat.name}', `${cat.description}`)"
                                        class="p-2 text-slate-400 hover:text-primary hover:bg-primary/10 rounded-lg transition-all" title="Sửa">
                                    <span class="material-icons text-[18px]">edit</span>
                                </button>
                                <button onclick="CategoryMgr.confirmDelete(${cat.id}, '${cat.name}')"
                                        class="p-2 text-slate-400 hover:text-red-500 hover:bg-red-50 rounded-lg transition-all" title="Xóa">
                                    <span class="material-icons text-[18px]">delete</span>
                                </button>
                            </div>
                        </div>
                        <p class="text-sm text-slate-500 dark:text-slate-400 flex-1 leading-relaxed min-h-[40px]">
                            ${empty cat.description ? 'Chưa có mô tả.' : cat.description}
                        </p>
                        <div class="flex items-center justify-between pt-3 border-t border-slate-100 dark:border-slate-700">
                            <div class="flex items-center gap-1.5 text-sm font-semibold text-emerald-600 dark:text-emerald-400">
                                <span class="material-icons text-[16px]">article</span>
                                ${cat.articleCount} bài đã xuất bản
                            </div>
                            <button onclick="CategoryMgr.openEdit(${cat.id}, '${cat.name}', `${cat.description}`)"
                                    class="text-xs text-primary font-semibold hover:underline">Chỉnh sửa →</button>
                        </div>
                    </div>
                </c:forEach>

                <c:if test="${empty categories}">
                    <div class="col-span-3 text-center py-20 text-slate-400">
                        <span class="material-icons text-5xl mb-3 block">category</span>
                        <p class="font-semibold">Chưa có danh mục nào. Hãy tạo danh mục đầu tiên!</p>
                    </div>
                </c:if>
            </div>
        </div>
    </main>
</div>

<!-- Toast notification -->
<div id="toast" class="fixed bottom-6 right-6 z-[200] hidden transition-all">
    <div id="toast-inner" class="flex items-center gap-3 px-5 py-3.5 rounded-xl shadow-2xl text-white text-sm font-semibold min-w-[280px]">
        <span id="toast-icon" class="material-icons text-[20px]">check_circle</span>
        <span id="toast-msg">Thông báo</span>
    </div>
</div>

<!-- Create / Edit Modal -->
<div id="catModal" class="fixed inset-0 z-[100] flex items-center justify-center p-4 hidden">
    <div class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm" onclick="CategoryMgr.closeModal()"></div>
    <div class="bg-white dark:bg-slate-900 w-full max-w-md rounded-2xl shadow-2xl relative overflow-hidden z-10">
        <div class="px-6 py-5 border-b border-slate-100 dark:border-slate-800 flex items-center justify-between">
            <h3 id="modal-title" class="text-lg font-bold text-slate-900 dark:text-white">Thêm danh mục</h3>
            <button onclick="CategoryMgr.closeModal()" class="text-slate-400 hover:text-slate-600 dark:hover:text-slate-200 transition-colors">
                <span class="material-icons">close</span>
            </button>
        </div>
        <div class="p-6 space-y-4">
            <input type="hidden" id="modal-cat-id" value="" />
            <div>
                <label class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider block mb-1.5">Tên danh mục <span class="text-red-500">*</span></label>
                <input id="modal-cat-name" type="text" maxlength="100"
                       class="w-full bg-slate-50 dark:bg-slate-900/50 border border-slate-200 dark:border-slate-700 rounded-xl px-4 py-3 text-sm focus:ring-2 focus:ring-primary focus:border-transparent outline-none transition-all"
                       placeholder="Ví dụ: Technology" />
            </div>
            <div>
                <label class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider block mb-1.5">Mô tả</label>
                <textarea id="modal-cat-desc" rows="3" maxlength="255"
                          class="w-full bg-slate-50 dark:bg-slate-900/50 border border-slate-200 dark:border-slate-700 rounded-xl px-4 py-3 text-sm focus:ring-2 focus:ring-primary focus:border-transparent outline-none transition-all resize-none"
                          placeholder="Mô tả ngắn về danh mục..."></textarea>
            </div>
        </div>
        <div class="px-6 py-4 border-t border-slate-100 dark:border-slate-800 bg-slate-50 dark:bg-slate-900/50 flex gap-3">
            <button onclick="CategoryMgr.closeModal()"
                    class="flex-1 px-4 py-2.5 text-sm font-bold text-slate-600 dark:text-slate-400 hover:bg-slate-200 dark:hover:bg-slate-800 rounded-xl transition-colors">Hủy</button>
            <button id="modal-save-btn" onclick="CategoryMgr.save()"
                    class="flex-1 px-4 py-2.5 text-sm font-bold bg-primary text-white hover:bg-primary/90 rounded-xl shadow-lg shadow-primary/20 transition-all flex items-center justify-center gap-2">
                <span class="material-icons text-sm">save</span>
                Lưu
            </button>
        </div>
    </div>
</div>

<!-- Delete Confirm Modal -->
<div id="deleteModal" class="fixed inset-0 z-[101] flex items-center justify-center p-4 hidden">
    <div class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm" onclick="CategoryMgr.closeDelete()"></div>
    <div class="bg-white dark:bg-slate-900 w-full max-w-sm rounded-2xl shadow-2xl relative z-10 overflow-hidden">
        <div class="p-6 text-center">
            <div class="w-16 h-16 bg-red-100 dark:bg-red-900/30 rounded-full flex items-center justify-center mx-auto mb-4">
                <span class="material-icons text-red-500 text-3xl">warning</span>
            </div>
            <h3 class="text-lg font-bold text-slate-900 dark:text-white mb-2">Xác nhận xóa</h3>
            <p class="text-sm text-slate-500 mb-1">Bạn có chắc muốn xóa danh mục:</p>
            <p id="del-cat-name" class="font-bold text-slate-800 dark:text-white mb-3">--</p>
            <p class="text-xs text-amber-600 dark:text-amber-400 bg-amber-50 dark:bg-amber-900/20 p-3 rounded-lg border border-amber-200 dark:border-amber-700">
                <span class="material-icons text-sm align-middle mr-1">info</span>
                Các bài viết trong danh mục này sẽ trở thành <strong>chưa phân loại</strong>.
            </p>
        </div>
        <div class="px-6 pb-6 flex gap-3">
            <button onclick="CategoryMgr.closeDelete()"
                    class="flex-1 px-4 py-2.5 text-sm font-bold text-slate-600 border border-slate-200 dark:border-slate-700 hover:bg-slate-50 dark:hover:bg-slate-800 rounded-xl transition-colors">Hủy</button>
            <button id="del-confirm-btn" onclick="CategoryMgr.doDelete()"
                    class="flex-1 px-4 py-2.5 text-sm font-bold bg-red-500 text-white hover:bg-red-600 rounded-xl shadow-lg shadow-red-500/20 transition-all">
                Xóa ngay
            </button>
        </div>
    </div>
</div>

<script>
    const CategoryMgr = {
        contextPath: '${pageContext.request.contextPath}',
        deleteId: null,

        openCreate() {
            document.getElementById('modal-title').textContent = 'Thêm danh mục mới';
            document.getElementById('modal-cat-id').value = '';
            document.getElementById('modal-cat-name').value = '';
            document.getElementById('modal-cat-desc').value = '';
            document.getElementById('catModal').classList.remove('hidden');
            setTimeout(() => document.getElementById('modal-cat-name').focus(), 100);
        },

        openEdit(id, name, desc) {
            document.getElementById('modal-title').textContent = 'Chỉnh sửa danh mục';
            document.getElementById('modal-cat-id').value = id;
            document.getElementById('modal-cat-name').value = name;
            document.getElementById('modal-cat-desc').value = desc;
            document.getElementById('catModal').classList.remove('hidden');
            setTimeout(() => document.getElementById('modal-cat-name').focus(), 100);
        },

        closeModal() {
            document.getElementById('catModal').classList.add('hidden');
        },

        async save() {
            const id = document.getElementById('modal-cat-id').value;
            const name = document.getElementById('modal-cat-name').value.trim();
            const desc = document.getElementById('modal-cat-desc').value.trim();
            const btn = document.getElementById('modal-save-btn');

            if (!name) {
                CategoryMgr.toast('Tên danh mục không được để trống!', 'error');
                return;
            }

            btn.disabled = true;
            btn.innerHTML = '<span class="material-icons text-sm animate-spin">refresh</span> Đang lưu...';

            const action = id ? 'update' : 'create';
            const body = new URLSearchParams({ action, name, description: desc });
            if (id) body.append('id', id);

            try {
                const res = await fetch(this.contextPath + '/admin/categories', { method: 'POST', body });
                const data = await res.json();
                if (data.success) {
                    CategoryMgr.toast(data.message, 'success');
                    CategoryMgr.closeModal();
                    setTimeout(() => location.reload(), 900);
                } else {
                    CategoryMgr.toast(data.message, 'error');
                }
            } catch (e) {
                CategoryMgr.toast('Lỗi kết nối server.', 'error');
            } finally {
                btn.disabled = false;
                btn.innerHTML = '<span class="material-icons text-sm">save</span> Lưu';
            }
        },

        confirmDelete(id, name) {
            this.deleteId = id;
            document.getElementById('del-cat-name').textContent = name;
            document.getElementById('deleteModal').classList.remove('hidden');
        },

        closeDelete() {
            document.getElementById('deleteModal').classList.add('hidden');
            this.deleteId = null;
        },

        async doDelete() {
            const btn = document.getElementById('del-confirm-btn');
            btn.disabled = true;
            btn.textContent = 'Đang xóa...';

            try {
                const body = new URLSearchParams({ action: 'delete', id: this.deleteId });
                const res = await fetch(this.contextPath + '/admin/categories', { method: 'POST', body });
                const data = await res.json();
                if (data.success) {
                    CategoryMgr.toast(data.message, 'success');
                    CategoryMgr.closeDelete();
                    const card = document.getElementById('cat-card-' + this.deleteId);
                    if (card) { card.style.opacity = '0'; card.style.transform = 'scale(0.9)'; card.style.transition = 'all 0.3s'; }
                    setTimeout(() => location.reload(), 1000);
                } else {
                    CategoryMgr.toast(data.message, 'error');
                }
            } catch (e) {
                CategoryMgr.toast('Lỗi kết nối server.', 'error');
            } finally {
                btn.disabled = false;
                btn.textContent = 'Xóa ngay';
            }
        },

        toast(msg, type = 'success') {
            const el = document.getElementById('toast');
            const inner = document.getElementById('toast-inner');
            const icon = document.getElementById('toast-icon');
            document.getElementById('toast-msg').textContent = msg;

            if (type === 'success') {
                inner.className = 'flex items-center gap-3 px-5 py-3.5 rounded-xl shadow-2xl text-white text-sm font-semibold min-w-[280px] bg-emerald-500';
                icon.textContent = 'check_circle';
            } else {
                inner.className = 'flex items-center gap-3 px-5 py-3.5 rounded-xl shadow-2xl text-white text-sm font-semibold min-w-[280px] bg-red-500';
                icon.textContent = 'error';
            }

            el.classList.remove('hidden');
            clearTimeout(this._toastTimer);
            this._toastTimer = setTimeout(() => el.classList.add('hidden'), 3500);
        }
    };

    // Allow Enter key to save
    document.getElementById('modal-cat-name').addEventListener('keydown', e => {
        if (e.key === 'Enter') CategoryMgr.save();
    });
</script>
</body>
</html>
