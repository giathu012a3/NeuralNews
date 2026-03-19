/**
 * Admin Content Management
 * Features: filter, sort, preview, reject-with-reason, hide/show, bulk ops, CSV export
 */
const AdminContent = {
    config: { contextPath: '', currentSearchPage: 1, searchTimeout: null,
              currentSortBy: 'date', currentSortDir: 'DESC' },

    init(conf) {
        this.config = { ...this.config, ...conf };
        const debounce = () => {
            clearTimeout(this.config.searchTimeout);
            this.config.searchTimeout = setTimeout(() => this.fetchArticles(1), 500);
        };
        ['searchInput', 'authorFilter'].forEach(id => {
            const el = document.getElementById(id);
            if (el) el.addEventListener('input', debounce);
        });
        ['categoryFilter', 'statusFilter', 'sortByFilter', 'sortDirFilter'].forEach(id => {
            const el = document.getElementById(id);
            if (el) el.addEventListener('change', () => this.fetchArticles(1));
        });
    },

    _params(page = 1) {
        const v = id => document.getElementById(id)?.value || '';
        return new URLSearchParams({
            keyword:    v('searchInput'),
            authorName: v('authorFilter'),
            categoryId: v('categoryFilter') || 'ALL',
            status:     v('statusFilter')   || 'ALL',
            sortBy:     v('sortByFilter')   || 'date',
            sortDir:    v('sortDirFilter')  || 'DESC',
            page
        }).toString();
    },

    fetchArticles(page = 1) {
        this.config.currentSearchPage = page;
        const url = `${this.config.contextPath}/admin/content?${this._params(page)}`;
        console.log('[AdminContent] Fetching Articles:', url);
        App.ajax.fetchPartial(url, 'article-table-container', 'article-ajax-bundle')
            .then(() => { const sa = document.getElementById('selectAll'); if (sa) sa.checked = false; });
    },

    // Nhấn card stats → set status filter, reset other filters
    quickFilter(status) {
        const sf = document.getElementById('statusFilter');
        if (sf) sf.value = status || 'ALL';
        this.fetchArticles(1);
    },

    // Click header cột → toggle sort
    toggleSort(col) {
        const sb = document.getElementById('sortByFilter');
        const sd = document.getElementById('sortDirFilter');
        if (!sb || !sd) return;
        if (sb.value === col) {
            sd.value = sd.value === 'DESC' ? 'ASC' : 'DESC';
        } else {
            sb.value = col;
            sd.value = 'DESC';
        }
        this.fetchArticles(1);
    },

    _doAction(body) {
        return App.ajax.post(`${this.config.contextPath}/admin/content`, body)
            .then(d => {
                if (d.success) {
                    this.fetchArticles(this.config.currentSearchPage);
                    Toast.success(d.message);
                } else {
                    Toast.error(d.message);
                }
                return d;
            });
    },

    handleModerationAction(e, id, action) {
        e.preventDefault();
        if (action === 'hide') {
            App.confirm({
                title: 'Ẩn bài viết',
                message: 'Bài viết sẽ được ẩn khỏi trang và chuyển vào kho lưu trữ. Bạn vẫn có thể khôi phục sau.',
                confirmText: 'Ẩn bài', cancelText: 'Hủy', type: 'danger'
            }).then(ok => { if (ok) this._doAction(`action=hide&articleId=${id}`); });
        } else {
            this._doAction(`action=${action}&articleId=${id}`);
        }
    },

    // ── Reject with reason modal ─────────────────────────────────────────────
    openRejectModal(articleId) {
        document.getElementById('rejectArticleId').value = articleId;
        document.getElementById('rejectReason').value = '';
        document.querySelectorAll('.reject-preset').forEach(b =>
            b.classList.remove('ring-2', 'ring-red-400', 'bg-red-100', 'text-red-600'));
        document.getElementById('rejectModal').classList.remove('hidden');
        setTimeout(() => document.getElementById('rejectReason').focus(), 100);
    },
    closeRejectModal() { document.getElementById('rejectModal').classList.add('hidden'); },
    setRejectReason(btn) {
        document.getElementById('rejectReason').value = btn.dataset.reason;
        document.querySelectorAll('.reject-preset').forEach(b =>
            b.classList.remove('ring-2', 'ring-red-400', 'bg-red-100', 'text-red-600'));
        btn.classList.add('ring-2', 'ring-red-400', 'bg-red-100', 'text-red-600');
    },
    doRejectWithReason() {
        const id = document.getElementById('rejectArticleId').value;
        const reason = document.getElementById('rejectReason').value.trim();
        if (!reason) return Toast.error('Vui lòng nhập lý do từ chối!');
        this._doAction(`action=reject_with_reason&articleId=${id}&reason=${encodeURIComponent(reason)}`)
            .then(d => { if (d.success) this.closeRejectModal(); });
    },

    // ── Preview modal ────────────────────────────────────────────────────────
    openPreview(id, title, author, cat, status, summary, img) {
        const modal = document.getElementById('previewModal');
        const content = document.getElementById('previewContent');
        const actions = document.getElementById('previewActions');
        modal.classList.remove('hidden');

        const statusMap = {
            'PUBLISHED': ['bg-green-100 text-green-700', 'ĐÃ ĐĂNG'],
            'PENDING':   ['bg-amber-100 text-amber-700', 'CHỜ DUYỆT'],
            'REJECTED':  ['bg-red-100 text-red-600',     'TỪ CHỐI'],
            'ARCHIVED':  ['bg-slate-100 text-slate-600', 'LƯU TRỮ'],
        };
        const [badgeCls, label] = statusMap[status] || ['bg-slate-100 text-slate-500', status];

        content.innerHTML = `
            <div class="space-y-4">
                ${img ? `<img src="${img}" alt="${title}" class="w-full h-48 object-cover rounded-xl"/>` : ''}
                <div class="flex items-start justify-between gap-3">
                    <h2 class="text-lg font-bold text-slate-900 dark:text-white leading-tight">${title || '—'}</h2>
                    <span class="px-2.5 py-1 text-[10px] font-bold rounded-full flex-shrink-0 ${badgeCls}">${label}</span>
                </div>
                <div class="flex items-center gap-4 text-sm text-slate-500">
                    <span class="flex items-center gap-1"><span class="material-icons text-[16px]">person</span>${author || 'Khuyết danh'}</span>
                    <span class="flex items-center gap-1"><span class="material-icons text-[16px]">category</span>${cat || 'N/A'}</span>
                </div>
                ${summary ? `<p class="text-sm text-slate-600 dark:text-slate-300 leading-relaxed border-l-4 border-primary/30 pl-4 italic">${summary}</p>` : '<p class="text-sm text-slate-400 italic">Không có tóm tắt.</p>'}
            </div>`;

        actions.innerHTML = `
            <a href="${this.config.contextPath}/user/article?id=${id}" target="_blank"
                class="flex-1 flex items-center justify-center gap-2 px-4 py-2.5 border border-slate-200 dark:border-slate-700 rounded-xl text-sm font-semibold text-slate-600 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors">
                <span class="material-icons text-[18px]">open_in_new</span>Xem trang
            </a>
            <a href="${this.config.contextPath}/staff/edit-article?id=${id}&adminMode=true"
                class="flex-1 flex items-center justify-center gap-2 px-4 py-2.5 bg-primary text-white rounded-xl text-sm font-bold hover:bg-primary/90 shadow transition-all">
                <span class="material-icons text-[18px]">edit</span>Chỉnh sửa
            </a>`;
    },
    closePreview() { document.getElementById('previewModal').classList.add('hidden'); },

    // ── Bulk ops ─────────────────────────────────────────────────────────────
    handleBulkApprove(e) {
        e.preventDefault();
        const ids = [...document.querySelectorAll('.article-checkbox:checked')]
            .filter(cb => cb.dataset.status === 'PENDING').map(cb => cb.value);
        if (!ids.length) return Toast.error('Chọn ít nhất một bài viết "Chờ duyệt"!');
        App.confirm({ title: 'Duyệt hàng loạt', message: `Duyệt ${ids.length} bài viết?`, confirmText: 'Duyệt', cancelText: 'Hủy', type: 'primary' })
            .then(ok => { if (ok) this._doAction('action=bulk_approve&' + ids.map(id => `articleIds[]=${id}`).join('&')); });
    },
    handleBulkDelete(e) {
        e.preventDefault();
        const ids = [...document.querySelectorAll('.article-checkbox:checked')].map(cb => cb.value);
        if (!ids.length) return Toast.error('Chọn ít nhất một bài viết để ẩn!');
        App.confirm({ title: 'Ẩn hàng loạt', message: `Ẩn ${ids.length} bài viết đã chọn? Có thể khôi phục sau.`, confirmText: `Ẩn ${ids.length} bài`, cancelText: 'Hủy', type: 'danger' })
            .then(ok => { if (ok) this._doAction('action=bulk_hide&' + ids.map(id => `articleIds[]=${id}`).join('&')); });
    },

    // ── Export CSV ───────────────────────────────────────────────────────────
    exportCsv() {
        const url = `${this.config.contextPath}/admin/content?${this._params(1)}&export=csv`;
        window.location.href = url;
        Toast.success('Đang tải file CSV...');
    },

    resetFilters() {
        ['searchInput', 'authorFilter'].forEach(id => { const el = document.getElementById(id); if (el) el.value = ''; });
        ['categoryFilter', 'statusFilter'].forEach(id => { const el = document.getElementById(id); if (el) el.value = 'ALL'; });
        const sb = document.getElementById('sortByFilter'); if (sb) sb.value = 'date';
        const sd = document.getElementById('sortDirFilter'); if (sd) sd.value = 'DESC';
        this.fetchArticles(1);
        Toast.success('Đã xóa bộ lọc');
    },

    toggleAll: (cb) => App.dom.toggleAll(cb, '.article-checkbox')
};
