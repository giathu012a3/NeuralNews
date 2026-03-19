/**
 * NeuralNews Admin: User Management Module
 */
const AdminUser = {
    config: {
        contextPath: '',
        currentSearchPage: 1,
        searchTimeout: null,
        currentSortBy: 'created_at',
        currentSortDir: 'DESC'
    },

    init: function(contextPath) {
        this.config.contextPath = contextPath;
        const self = this;
        
        const setupListeners = () => {
            // Search with debounce
            const searchInput = document.getElementById('searchUser');
            if (searchInput) {
                searchInput.addEventListener('input', () => {
                    clearTimeout(self.config.searchTimeout);
                    self.config.searchTimeout = setTimeout(() => self.filterUsers(1), 500);
                });
            }

            // Select filters
            ['roleSelect', 'statusSelect', 'sortBySelect', 'sortDirSelect'].forEach(id => {
                const el = document.getElementById(id);
                if (el) el.addEventListener('change', () => self.filterUsers(1));
            });
        };

        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', setupListeners);
        } else {
            setupListeners();
        }
    },

    /**
     * Get current filter parameters
     */
    _params: function(page = 1) {
        const v = id => document.getElementById(id)?.value || '';
        return new URLSearchParams({
            keyword: v('searchUser'),
            role:    v('roleSelect')   || 'ALL',
            status:  v('statusSelect') || 'ALL',
            sortBy:  v('sortBySelect') || 'created_at',
            sortDir: v('sortDirSelect')|| 'DESC',
            page: page
        }).toString();
    },

    filterUsers: function(page = 1) {
        this.config.currentSearchPage = page;
        const url = `${this.config.contextPath}/admin/users?${this._params(page)}`;
        App.ajax.fetchPartial(url, 'user-table-container', 'user-ajax-bundle')
            .then(() => {
                const sa = document.getElementById('selectAll');
                if (sa) sa.checked = false;
            });
    },

    resetFilters: function() {
        ['searchUser'].forEach(id => { const el = document.getElementById(id); if (el) el.value = ''; });
        ['roleSelect', 'statusSelect'].forEach(id => { const el = document.getElementById(id); if (el) el.value = 'ALL'; });
        const sb = document.getElementById('sortBySelect'); if (sb) sb.value = 'created_at';
        const sd = document.getElementById('sortDirSelect'); if (sd) sd.value = 'DESC';
        this.filterUsers(1);
        Toast.success('Đã tải lại danh sách');
    },

    quickFilter: function(status) {
        const sf = document.getElementById('statusSelect');
        if (sf) sf.value = status || 'ALL';
        this.filterUsers(1);
    },

    _doAction: function(body) {
        return App.ajax.post(`${this.config.contextPath}/admin/users`, body)
            .then(res => {
                if (res.success) {
                    Toast.success(res.message);
                    this.filterUsers(this.config.currentSearchPage);
                } else {
                    Toast.error(res.message);
                }
                return res;
            });
    },

    approveUser: function(userId, action) {
        const isApprove = action === 'approve';
        const isDelete = action === 'delete';
        App.confirm({
            title: isApprove ? 'Phê duyệt Nhà báo' : (isDelete ? 'Xóa tài khoản' : 'Từ chối đơn'),
            message: isApprove 
                ? 'Bạn có chắc chắn muốn cấp quyền Nhà báo cho người dùng này?' 
                : (isDelete ? 'Tài khoản sẽ bị vô hiệu hóa. Bạn có thể khôi phục sau này.' : 'Từ chối đơn đăng ký nhà báo?'),
            confirmText: isApprove ? 'Xác nhận' : (isDelete ? 'Xóa' : 'Từ chối'),
            type: isApprove ? 'primary' : 'danger'
        }).then(ok => {
            if (ok) this._doAction(`action=${action}&userId=${userId}`);
        });
    },

    banUser: function(userId, status) {
        const isBan = status === 'ban';
        const isRestore = status === 'restore';
        
        App.confirm({
            title: isRestore ? 'Khôi phục tài khoản' : (isBan ? 'Khóa tài khoản' : 'Mở khóa'),
            message: isRestore ? 'Cho phép người dùng này đăng nhập trở lại?' : (isBan ? 'Người dùng sẽ bị chặn truy cập. Bạn có chắc chắn?' : 'Mở khóa cho người dùng này?'),
            confirmText: isRestore ? 'Khôi phục' : (isBan ? 'Duyệt khóa' : 'Mở khóa'),
            type: isBan ? 'danger' : 'primary'
        }).then(ok => {
            if (ok) this._doAction(`action=${status}&userId=${userId}`);
        });
    },

    handleBulk: function(action) {
        const checked = [...document.querySelectorAll('.user-checkbox:checked')].map(cb => cb.value);
        if (!checked.length) return Toast.error('Vui lòng chọn ít nhất một người dùng!');
        
        let msg = `Thực hiện hành động trên ${checked.length} người dùng đã chọn?`;
        App.confirm({
            title: 'Hành động hàng loạt',
            message: msg,
            type: action.includes('ban') || action.includes('delete') ? 'danger' : 'primary'
        }).then(ok => {
            if (ok) {
                const body = `action=${action}&` + checked.map(id => `ids[]=${id}`).join('&');
                this._doAction(body);
            }
        });
    },
    
    changeRole: function(userId, currentRoleId, userName) {
        const modal = document.getElementById('editRoleModal');
        if (!modal) return;
        document.getElementById('editRoleId_userId').value = userId;
        document.getElementById('editRoleId_userName').innerText = userName;
        document.getElementById('editRoleId_select').value = currentRoleId;
        modal.classList.remove('hidden');
    },

    submitChangeRole: function() {
        const userId = document.getElementById('editRoleId_userId').value;
        const newRole = document.getElementById('editRoleId_select').value;
        this._doAction(`action=changeRole&userId=${userId}&roleId=${newRole}`).then(res => {
            if (res && res.success && typeof closeEditRoleModal === 'function') closeEditRoleModal();
        });
    },

    resetPassword: function(userId, userName) {
        const modal = document.getElementById('resetPasswordModal');
        if (!modal) return;
        document.getElementById('resetPwd_userId').value = userId;
        document.getElementById('resetPwd_userName').innerText = userName;
        document.getElementById('resetPwd_input').value = '';
        modal.classList.remove('hidden');
    },

    submitResetPassword: function() {
        const userId = document.getElementById('resetPwd_userId').value;
        const newPassword = document.getElementById('resetPwd_input').value;
        if (!newPassword || newPassword.trim().length < 6) {
            return App.toast('Mật khẩu tối thiểu 6 ký tự', 'error');
        }
        this._doAction(`action=resetPassword&userId=${userId}&newPassword=${encodeURIComponent(newPassword)}`).then(res => {
            if (res && res.success && typeof closeResetPwdModal === 'function') closeResetPwdModal();
        });
    },

    exportCsv: function() {
        const url = `${this.config.contextPath}/admin/users?${this._params(1)}&export=csv`;
        window.location.href = url;
    },

    viewCV: function(button) {
        const d = button.dataset;
        const set = (id, val) => { const el = document.getElementById(id); if (el) el.innerText = val || '—'; };
        set('cvName', d.name);
        set('cvEmail', d.email);
        set('cvRole', d.role);
        set('cvDate', d.date);
        set('cvBio', d.bio || 'Không có giới thiệu');
        set('cvExp', (d.exp || '0') + ' năm');
        document.getElementById('cvModal')?.classList.remove('hidden');
    },

    closeCV: function() { document.getElementById('cvModal')?.classList.add('hidden'); },

    toggleAll: (source) => {
        document.querySelectorAll('.user-checkbox').forEach(cb => cb.checked = source.checked);
    },

    addUser: function() {
        const form = document.getElementById('addUserForm');
        const fullName = form.querySelector('input[type="text"]').value;
        const email = form.querySelector('input[type="email"]').value;
        const roleId = form.querySelector('select').value;

        if (!fullName || !email) return Toast.error('Vui lòng điền đủ thông tin');

        const body = `action=add&fullName=${encodeURIComponent(fullName)}&email=${encodeURIComponent(email)}&roleId=${roleId}`;
        this._doAction(body).then(res => {
            if (res.success) {
                form.reset();
                if (typeof closeAddUserModal === 'function') closeAddUserModal();
            }
        });
    }
};
