/**
 * NeuralNews Global Utilities
 * Contains reusable functions for UI, AJAX, and DOM manipulation.
 */

const App = {
    /**
     * Toast Notifications
     */
    toast: {
        containerId: 'global-toast-container',
        _getContainer: function() {
            let c = document.getElementById(this.containerId);
            if (!c) {
                c = document.createElement('div');
                c.id = this.containerId;
                c.className = 'fixed top-5 right-5 z-[200] flex flex-col gap-3 pointer-events-none';
                document.body.appendChild(c);
            }
            return c;
        },
        show: function(msg, type = 'success') {
            if (!msg) return;
            const container = this._getContainer();
            const toast = document.createElement('div');
            
            // Minimalist styling
            const bgColor = type === 'success' ? 'bg-emerald-600' : 'bg-slate-800';
            const icon = type === 'success' ? 'check_circle' : 'info';
            
            toast.className = `toast-item pointer-events-auto flex items-center gap-3 px-4 py-3 rounded-xl shadow-lg min-w-[280px] ${bgColor} text-white animate-in slide-in-from-right-5 duration-300`;
            
            toast.innerHTML = `
                <span class="material-icons text-[20px] opacity-90">${icon}</span>
                <p class="text-sm font-medium flex-1">${msg}</p>
                <button onclick="this.parentElement.remove()" class="ml-2 hover:opacity-70 transition-opacity">
                    <span class="material-icons text-[18px]">close</span>
                </button>
            `;
            
            container.appendChild(toast);
            setTimeout(() => {
                toast.classList.add('hiding');
                setTimeout(() => toast.remove(), 400);
            }, 5000);
        },
        success: function(m) { this.show(m, 'success'); },
        error: function(m) { this.show(m, 'error'); }
    },

    /**
     * Premium Confirmation Modal
     */
    confirm: function(options) {
        const settings = Object.assign({
            title: 'Xác nhận',
            message: 'Bạn có chắc chắn muốn thực hiện thao tác này?',
            confirmText: 'Đồng ý',
            cancelText: 'Hủy bỏ',
            type: 'primary'
        }, options);

        return new Promise((resolve) => {
            const modalId = 'app-confirm-modal-wrapper';
            const modal = document.createElement('div');
            modal.id = modalId;
            
            // Thiết lập style trực tiếp để đảm bảo hoạt động trên mọi trình duyệt (cả Edge đời cũ)
            Object.assign(modal.style, {
                position: 'fixed',
                top: '0', left: '0', right: '0', bottom: '0',
                zIndex: '9999',
                display: 'flex',
                alignItems: 'center',
                justifyContent: 'center',
                padding: '20px',
                backgroundColor: 'rgba(15, 23, 42, 0.7)',
                backdropFilter: 'blur(8px)',
                webkitBackdropFilter: 'blur(8px)',
                opacity: '0',
                transition: 'opacity 0.2s ease-out',
                pointerEvents: 'auto'
            });

            const accentColor = settings.type === 'danger' ? 'text-rose-500' : (settings.type === 'warning' ? 'text-amber-500' : 'text-indigo-600');
            const btnColor = settings.type === 'danger' ? 'bg-rose-500' : (settings.type === 'warning' ? 'bg-amber-500' : 'bg-indigo-600');

            modal.innerHTML = `
                <div id="${modalId}-card" class="bg-white dark:bg-slate-900 w-full max-w-[340px] rounded-2xl shadow-2xl relative overflow-hidden flex flex-col border border-slate-100 dark:border-slate-800 transition-transform duration-200 transform scale-95">
                    <div class="p-6">
                        <h3 class="text-lg font-bold text-slate-900 dark:text-white mb-2 flex items-center gap-2">
                             <span class="material-icons ${accentColor} text-[24px]">info_outline</span>
                             ${settings.title}
                        </h3>
                        <p class="text-sm text-slate-500 dark:text-slate-400 leading-relaxed font-medium">${settings.message}</p>
                    </div>
                    <div class="px-6 pb-6 flex gap-3">
                        <button id="${modalId}-cancel" class="flex-1 py-2.5 text-sm font-bold text-slate-400 hover:text-slate-600 dark:hover:text-slate-200 transition-all">
                            ${settings.cancelText}
                        </button>
                        <button id="${modalId}-confirm" class="flex-1 py-2.5 text-sm font-bold text-white ${btnColor} rounded-xl shadow-md hover:brightness-110 active:scale-95 transition-all">
                            ${settings.confirmText}
                        </button>
                    </div>
                </div>
            `;

            document.body.appendChild(modal);
            
            // Animation vào mượt mà
            requestAnimationFrame(() => {
                modal.style.opacity = '1';
                const card = document.getElementById(`${modalId}-card`);
                if(card) card.style.transform = 'scale(1)';
            });

            const close = (result) => {
                modal.style.opacity = '0';
                const card = document.getElementById(`${modalId}-card`);
                if(card) card.style.transform = 'scale(0.9)';
                setTimeout(() => {
                    modal.remove();
                    resolve(result);
                }, 200);
            };

            // Đóng khi click ngoài
            modal.onclick = (e) => { if (e.target === modal) close(false); };
            document.getElementById(`${modalId}-cancel`).onclick = () => close(false);
            document.getElementById(`${modalId}-confirm`).onclick = () => close(true);
        });
    },

    /**
     * AJAX Utilities
     */
    ajax: {
        // Tải một đoạn HTML từ URL và chèn vào container
        fetchPartial: function(url, containerId, fragmentId) {
            const container = document.getElementById(containerId);
            if (container) container.style.opacity = '0.5';

            return fetch(url, { headers: { 'X-Requested-With': 'XMLHttpRequest' } })
                .then(r => r.text())
                .then(html => {
                    if (container) {
                        const bundle = new DOMParser().parseFromString(html, 'text/html').getElementById(fragmentId);
                        container.innerHTML = bundle ? bundle.outerHTML : html;
                        container.style.opacity = '1';
                    }
                    return true;
                })
                .catch(err => {
                    if (container) container.style.opacity = '1';
                    App.toast.error('Lỗi tải dữ liệu');
                    throw err;
                });
        },

        // Gửi POST yêu cầu (dùng cho các action như xóa, duyệt...)
        post: function(url, body) {
            return fetch(url, {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: body
            }).then(r => r.json());
        }
    },

    /**
     * DOM Utilities
     */
    dom: {
        // Tích chọn tất cả checkbox trong một phạm vi
        toggleAll: function(source, targetSelector) {
            document.querySelectorAll(targetSelector).forEach(el => {
                el.checked = source.checked;
            });
        }
    }
};

// Aliases for shorter calls
const Toast = App.toast;
