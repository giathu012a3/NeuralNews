<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<meta charset="utf-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<link href="https://fonts.googleapis.com" rel="preconnect" />
<link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect" />
<link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@300;400;500;600;700;900&amp;display=swap" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" rel="stylesheet" />
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<script id="tailwind-config">
    tailwind.config = {
        darkMode: "class",
        theme: {
            extend: {
                colors: {
                    "primary": "#0d7ff2",
                    "primary-dark": "#0b6ed0",
                    "secondary": "#f0f4f8",
                    "accent": "#e63946",
                    "background-light": "#f5f7f8",
                    "background-dark": "#101922",
                    "surface-light": "#f8fafc",
                    "surface-dark": "#1e293b",
                    "text-main": "#1e293b",
                    "text-light": "#64748b",
                    "border-light": "#e2e8f0",
                    "border-dark": "#334155",
                },
                fontFamily: {
                    "display": ["Work Sans", "sans-serif"],
                    "body": ["Work Sans", "sans-serif"],
                },
                borderRadius: {
                    "DEFAULT": "0.25rem",
                    "lg": "0.5rem",
                    "xl": "0.75rem",
                    "2xl": "1rem",
                    "full": "9999px"
                },
            },
        },
    }
</script>
<%-- Theme management script --%>
<script>
    (function () {
        const KEY_PRIMARY = 'theme';
        const KEY_LEGACY  = 'editor_theme';

        function getTheme() {
            try { return localStorage.getItem(KEY_PRIMARY) || localStorage.getItem(KEY_LEGACY) || 'dark'; } catch(e) { return 'dark'; }
        }

        function persistTheme(v) {
            try {
                localStorage.setItem(KEY_PRIMARY, v);
                localStorage.setItem(KEY_LEGACY, v);
            } catch (e) {}
        }

        function applyTheme(v) {
            if (v === 'dark') {
                document.documentElement.classList.add('dark');
            } else {
                document.documentElement.classList.remove('dark');
            }
        }

        // Apply immediately
        applyTheme(getTheme());

        window.toggleTheme = function () {
            const current = document.documentElement.classList.contains('dark') ? 'dark' : 'light';
            const next = current === 'dark' ? 'light' : 'dark';
            persistTheme(next);
            applyTheme(next);
        };

        // Sync across tabs/frames
        window.addEventListener('storage', (e) => {
            if (e.key === KEY_PRIMARY || e.key === KEY_LEGACY) {
                applyTheme(getTheme());
            }
        });
    })();
</script>
<style type="text/tailwindcss">
    @layer utilities {
        .custom-scrollbar::-webkit-scrollbar {
            width: 5px;
        }
        .custom-scrollbar::-webkit-scrollbar-track {
            background: transparent;
        }
        .custom-scrollbar::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 10px;
        }
        .dark .custom-scrollbar::-webkit-scrollbar-thumb {
            background: #475569;
        }
        .custom-scrollbar::-webkit-scrollbar-thumb:hover {
            background: #94a3b8;
        }
        .line-clamp-2 {
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }
    }
    .dropdown-arrow::before {
        content: '';
        position: absolute;
        top: -6px;
        right: 14px;
        width: 12px;
        height: 12px;
        background-color: inherit;
        border-left: 1px solid currentColor;
        border-top: 1px solid currentColor;
        transform: rotate(45deg);
        z-index: -1;
    }
    .profile-dropdown-container:focus-within .profile-dropdown {
        display: block;
    }
</style>
<script src="${pageContext.request.contextPath}/assets/js/utils.js"></script>
