/**
 * Admin Violation Handling JS
 * Handles loading reports, animations, and moderation actions.
 */

const AdminViolation = {
    currentTargetType: new URLSearchParams(window.location.search).get('targetType') || 'ARTICLE',

    init() {
        console.log("Violation Admin Initialized");
    },

    async loadReportDetails(reportId) {
        // Highlighting active row
        document.querySelectorAll('.report-row').forEach(row => {
            row.classList.remove('border-primary', 'bg-primary/5', 'shadow-lg');
        });
        const activeRow = document.querySelector(`.report-row[data-id="${reportId}"]`);
        if (activeRow) activeRow.classList.add('border-primary', 'bg-primary/5', 'shadow-lg');

        try {
            const res = await fetch(`${window.location.pathname}?action=getDetails&reportId=${reportId}`);
            const data = await res.json();
            
            if (data.success) {
                this.updateSidebar(data.report);
                
                // Show Sidebar and Overlay
                const sidebar = document.getElementById('reportDetailsSidebar');
                const overlay = document.getElementById('reportSidebarOverlay');
                
                sidebar.classList.remove('hidden');
                overlay.classList.remove('hidden');
                
                setTimeout(() => {
                    sidebar.classList.remove('translate-x-full');
                    overlay.classList.remove('opacity-0');
                    overlay.classList.add('opacity-100');
                }, 10);
            }
        } catch (err) {
            console.error(err);
            showToast('Lỗi tải dữ liệu', 'error');
        }
    },

    updateSidebar(r) {
        document.getElementById('currentReportId').value = r.id;
        document.getElementById('displayReportId').textContent = `#REP-${String(r.id).padStart(3, '0')}`;
        
        const isArticle = r.targetType === 'ARTICLE';
        document.getElementById('sidebarBreadcrumb').textContent = isArticle ? 'Kiểm duyệt Bài viết' : 'Kiểm duyệt Bình luận';
        document.getElementById('targetIcon').textContent = isArticle ? 'description' : 'forum';
        
        document.getElementById('displayTargetInfo').textContent = `ID: ${r.targetId} • ${isArticle ? 'BÀI VIẾT' : 'BÌNH LUẬN'}`;
        document.getElementById('displayAuthorName').textContent = r.authorName || 'Ẩn danh';
        
        const avatar = document.getElementById('authorAvatar');
        avatar.textContent = (r.authorName || 'U').split(' ').map(n => n[0]).join('').toUpperCase().substring(0, 2);
        
        const snippetElem = document.getElementById('displaySnippet');
        if (r.problematicSnippet) {
            snippetElem.textContent = r.problematicSnippet;
            snippetElem.closest('section').classList.remove('hidden');
        } else {
            snippetElem.closest('section').classList.add('hidden');
        }
        
        const detailsSection = document.getElementById('detailsSection');
        if (r.details) {
            const detailItems = r.details.split('|||')
                .filter(d => d && d.trim().length > 0)
                .map(d => `<div class="mb-3 pb-3 border-b border-amber-200/50 dark:border-amber-800/30 last:border-0 last:mb-0 last:pb-0 flex gap-2 items-start"><span class="material-symbols-outlined text-[14px] text-amber-500 mt-0.5">chat</span><span>${d.trim()}</span></div>`)
                .join('');
                
            if (detailItems) {
                document.getElementById('displayDetails').innerHTML = detailItems;
                detailsSection.classList.remove('hidden');
            } else {
                detailsSection.classList.add('hidden');
            }
        } else {
            detailsSection.classList.add('hidden');
        }
        
        const reasonsContainer = document.getElementById('displayReasons');
        reasonsContainer.innerHTML = '';
        if (r.reason) {
            r.reason.split(', ').forEach(rsn => {
                const span = document.createElement('span');
                span.className = 'px-3 py-1.5 bg-slate-100 dark:bg-slate-800 text-[10px] font-black text-slate-500 dark:text-slate-400 rounded-lg border border-slate-200 dark:border-slate-700 uppercase tracking-tight';
                span.textContent = rsn;
                reasonsContainer.appendChild(span);
            });
        }

        const viewBtn = document.getElementById('viewArticleBtn');
        if (isArticle) {
            viewBtn.href = `${window.location.origin}${window.location.pathname.replace('admin/violation', 'user/article')}?id=${r.targetId}`;
            viewBtn.classList.remove('hidden');
        } else {
            viewBtn.classList.add('hidden');
        }
    },

    closeSidebar() {
        const sidebar = document.getElementById('reportDetailsSidebar');
        const overlay = document.getElementById('reportSidebarOverlay');
        
        sidebar.classList.add('translate-x-full');
        overlay.classList.remove('opacity-100');
        overlay.classList.add('opacity-0');
        
        setTimeout(() => {
            sidebar.classList.add('hidden');
            overlay.classList.add('hidden');
        }, 500);
    },

    async handleAction(actionType) {
        const reportId = document.getElementById('currentReportId').value;
        if (!reportId) return;

        let confirmMsg = 'Bạn có chắc chắn muốn thực hiện hành động này?';
        if (actionType === 'dismiss') confirmMsg = 'Bác bỏ báo cáo này?';
        else if (actionType === 'take_down') confirmMsg = `Gỡ bỏ ${this.currentTargetType === 'ARTICLE' ? 'bài viết' : 'bình luận'} này?`;
        else if (actionType === 'suspend') confirmMsg = 'KHÓA TÀI KHOẢN tác giả vĩnh viễn?';

        if (!confirm(confirmMsg)) return;

        try {
            const res = await fetch(`${window.location.pathname}`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: `action=${actionType}&reportId=${reportId}`
            });

            const data = await res.json();
            if (data.success) {
                showToast(data.message || 'Thành công!', 'success');
                location.reload();
            } else {
                showToast(data.message || 'Lỗi xử lý', 'error');
            }
        } catch (err) {
            console.error(err);
            showToast('Lỗi kết nối server', 'error');
        }
    }
};

// Global Utility Functions
function showToast(message, type = 'success') {
    const toast = document.createElement('div');
    toast.className = `fixed bottom-8 right-8 px-6 py-4 rounded-2xl shadow-2xl z-[100] transform transition-all duration-500 translate-y-20 opacity-0 flex items-center gap-3 border font-bold text-sm ${
        type === 'success' ? 'bg-white dark:bg-slate-900 border-green-500/20 text-green-600' : 'bg-white dark:bg-slate-900 border-red-500/20 text-red-600'
    }`;
    
    const icon = type === 'success' ? 'check_circle' : 'error';
    toast.innerHTML = `<span class="material-symbols-outlined">${icon}</span> ${message}`;
    
    document.body.appendChild(toast);
    setTimeout(() => {
        toast.classList.remove('translate-y-20', 'opacity-0');
    }, 100);

    setTimeout(() => {
        toast.classList.add('translate-y-10', 'opacity-0');
        setTimeout(() => toast.remove(), 500);
    }, 3000);
}

// Global functions for onclick attributes in JSP
function handleViolationAction(action) {
    AdminViolation.handleAction(action);
}

function loadReportDetails(reportId) {
    AdminViolation.loadReportDetails(reportId);
}

function closeReportSidebar() {
    AdminViolation.closeSidebar();
}

document.addEventListener('DOMContentLoaded', () => AdminViolation.init());
