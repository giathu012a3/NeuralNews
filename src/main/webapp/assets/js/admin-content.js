/**
 * Admin Content Management - Ultra Slim Version
 */
const AdminContent = {
    config: { contextPath: '', currentSearchPage: 1, searchTimeout: null },

    init: function(conf) {
        this.config = { ...this.config, ...conf };
        ['searchInput', 'categoryFilter', 'statusFilter'].forEach(id => {
            const el = document.getElementById(id);
            if(el) el.addEventListener(id === 'searchInput' ? 'input' : 'change', () => {
                clearTimeout(this.config.searchTimeout);
                this.config.searchTimeout = setTimeout(() => this.fetchArticles(1), 500);
            });
        });
    },

    fetchArticles: function(page = 1) {
        this.config.currentSearchPage = page;
        const query = `keyword=${encodeURIComponent(document.getElementById('searchInput').value)}&categoryId=${document.getElementById('categoryFilter').value}&status=${document.getElementById('statusFilter').value}&page=${page}`;
        const url = `${this.config.contextPath}/admin/content?${query}`;
        
        App.ajax.fetchPartial(url, 'article-table-container', 'article-ajax-bundle')
           .then(() => {
               const sa = document.getElementById('selectAll');
               if(sa) sa.checked = false;
           });
    },

    _doAction: function(body) {
        App.ajax.post(`${this.config.contextPath}/admin/content`, body)
           .then(d => {
               if (d.success) { 
                   this.fetchArticles(this.config.currentSearchPage); 
                   Toast.success(d.message); 
               } else Toast.error(d.message);
           });
    },

    handleModerationAction: function(e, id, action) {
        e.preventDefault();
        this._doAction(`action=${action}&articleId=${id}`);
    },

    handleBulkApprove: function(e) {
        e.preventDefault();
        const ids = [...document.querySelectorAll('.article-checkbox:checked')].filter(cb => cb.dataset.status === 'PENDING').map(cb => cb.value);
        if (!ids.length) return Toast.error('Chọn ít nhất một bài viết "Chờ duyệt"!');
        if (confirm(`Duyệt ${ids.length} bài đã chọn?`)) 
            this._doAction('action=bulk_approve&' + ids.map(id => `articleIds[]=${id}`).join('&'));
    },

    resetFilters: function() {
        ['searchInput', 'categoryFilter', 'statusFilter'].forEach(id => document.getElementById(id).value = (id === 'searchInput' ? '' : 'ALL'));
        this.fetchArticles(1);
        Toast.success('Đã xóa bộ lọc');
    },

    toggleAll: (cb) => App.dom.toggleAll(cb, '.article-checkbox')
};
