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
                c.className = 'fixed bottom-5 right-5 z-[100] flex flex-col gap-3';
                document.body.appendChild(c);
            }
            return c;
        },
        show: function(msg, type = 'success') {
            if (!msg) return;
            const container = this._getContainer();
            const toast = document.createElement('div');
            const bg = type === 'success' ? '#10b981' : '#ef4444'; 
            const icon = type === 'success' ? 'check_circle' : 'error';
            
            toast.className = 'toast-item flex items-center gap-3 px-5 py-3 rounded-xl shadow-2xl min-w-[300px] mb-2';
            toast.style.backgroundColor = bg;
            toast.style.color = '#ffffff';
            toast.style.zIndex = '9999';
            toast.style.display = 'flex';
            toast.style.alignItems = 'center';
            
            toast.innerHTML = 
                `<span class="material-icons" style="font-size: 22px; color: #ffffff; flex-shrink: 0;">${icon}</span>` +
                `<p style="font-size: 14px; font-weight: 700; color: #ffffff; margin: 0; flex-grow: 1; line-height: 1.4;">${msg}</p>` +
                `<button onclick="this.parentElement.remove()" style="background: none; border: none; color: #ffffff; cursor: pointer; padding: 4px; display: flex; align-items: center; opacity: 0.8;">` +
                    `<span class="material-icons" style="font-size: 18px; color: #ffffff;">close</span>` +
                `</button>`;
            
            container.appendChild(toast);
            setTimeout(() => {
                toast.classList.add('hiding');
                setTimeout(() => toast.remove(), 300);
            }, 4000);
        },
        success: function(m) { this.show(m, 'success'); },
        error: function(m) { this.show(m, 'error'); }
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
