<meta charset="utf-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<link href="https://fonts.googleapis.com" rel="preconnect" />
<link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect" />
<link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@400;500;600;700;900&amp;display=swap"
    rel="stylesheet" />
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
    rel="stylesheet" />
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<script id="tailwind-config">
    tailwind.config = {
        darkMode: "class",
        theme: {
            extend: {
                colors: {
                    "primary": "#0056b3",
                    "primary-dark": "#004494",
                    "secondary": "#f0f4f8",
                    "accent": "#e63946",
                    "background-light": "#ffffff",
                    "background-dark": "#0f172a",
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
<style type="text/tailwindcss">
    @layer utilities {
            .line-clamp-2 {
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }
        }.dropdown-arrow::before {
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
        }.profile-dropdown-container:focus-within .profile-dropdown {
            display: block;
        }
    </style>
<script src="${pageContext.request.contextPath}/assets/js/utils.js"></script>