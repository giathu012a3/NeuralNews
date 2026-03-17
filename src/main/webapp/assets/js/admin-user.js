/**
 * NeuralNews Admin User Management Logic
 */
const AdminUser = {
    config: {
        contextPath: '' // Sẽ được init từ JSP
    },

    init: function(contextPath) {
        this.config.contextPath = contextPath;
    },

    filterUsers: function(page = 1) {
        const keyword = document.getElementById('searchUser').value;
        const role = document.getElementById('roleSelect').value;
        const status = document.getElementById('statusSelect').value;
        
        const url = this.config.contextPath + "/admin/users?keyword=" + encodeURIComponent(keyword) + "&role=" + role + "&status=" + status + "&page=" + page;
        
        // Cập nhật cả khu vực Duyệt nhanh và Bảng chính cùng lúc
        App.ajax.fetchPartial(url, 'user-table-container', 'user-list-wrapper');
    },

    resetFilters: function() {
        const searchInput = document.getElementById('searchUser');
        const roleSelect = document.getElementById('roleSelect');
        const statusSelect = document.getElementById('statusSelect');

        if (searchInput) searchInput.value = '';
        if (roleSelect) roleSelect.value = 'ALL';
        if (statusSelect) statusSelect.value = 'ALL';

        this.filterUsers(1);
        Toast.success('Đã xóa bộ lọc');
    },

    handleSearch: function() {
        clearTimeout(this.searchTimeout);
        this.searchTimeout = setTimeout(() => this.filterUsers(1), 500);
    },

    approveUser: function(userId, action) {
        const isApprove = action === 'approve';
        App.confirm({
            title: isApprove ? 'Phê duyệt Nhà báo' : 'Từ chối ứng viên',
            message: isApprove 
                ? 'Bạn có chắc chắn muốn cấp quyền Nhà báo cho người dùng này?' 
                : 'Bạn có chắc chắn muốn từ chối đơn đăng ký làm Nhà báo của người này?',
            confirmText: isApprove ? 'Duyệt ngay' : 'Từ chối',
            cancelText: 'Xem lại',
            type: isApprove ? 'primary' : 'danger'
        }).then(confirm => {
            if (!confirm) return;
            App.ajax.post(this.config.contextPath + "/admin/users", "action=" + action + "&userId=" + userId)
               .then(res => {
                   if (res.success) {
                       Toast.success(res.message);
                       this.filterUsers();
                   } else Toast.error(res.message);
               });
        });
    },

    viewCV: function(button) {
        const name = button.dataset.name;
        const email = button.dataset.email;
        const role = button.dataset.role;
        const date = button.dataset.date;
        const bio = button.dataset.bio;
        const exp = button.dataset.exp;

        const setVal = (id, val) => {
            const el = document.getElementById(id);
            if (el) el.innerText = val;
        };

        setVal('cvName', name);
        setVal('cvEmail', email);
        setVal('cvRole', role);
        setVal('cvDate', date);
        setVal('cvBio', bio || 'Chưa cung cấp.');
        setVal('cvExp', exp + ' năm');
        
        const modal = document.getElementById('cvModal');
        if (modal) modal.classList.remove('hidden');
    },

    closeCV: function() {
        const modal = document.getElementById('cvModal');
        if (modal) modal.classList.add('hidden');
    }
};
