<meta charset="utf-8" />
<meta content="width=device-width, initial-scale=1.0" name="viewport" />
<script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&amp;display=swap"
    rel="stylesheet" />
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
    rel="stylesheet" />
<script id="tailwind-config">
    tailwind.config = {
        darkMode: "class",
        theme: {
            extend: {
                colors: {
                    "primary": "#0d7ff2",
                    "background-light": "#f8fafc",
                    "background-dark": "#0f172a",
                    "surface-dark": "#1e293b",
                    "border-dark": "#334155",
                    "chart-blue": "#0d7ff2",
                    "chart-teal": "#14b8a6",
                    "chart-amber": "#f59e0b",
                    "chart-rose": "#f43f5e",
                },
                fontFamily: {
                    "sans": ["Inter", "sans-serif"]
                },
                borderRadius: { "DEFAULT": "0.375rem", "lg": "0.5rem", "xl": "0.75rem", "full": "9999px" },
            },
        },
    }
</script>
<style type="text/tailwindcss">
    @layer base {
        body { @apply font-sans antialiased bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100; }
    }
    .material-symbols-outlined {
        font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24;
    }
    .sidebar-item-active {
        @apply bg-primary/10 text-primary border-r-2 border-primary;
    }
    .card-stat {
        @apply bg-white dark:bg-slate-900 border border-slate-200 dark:border-border-dark p-6 rounded-xl shadow-sm;
    }
    .badge-base {
        @apply flex items-center gap-1.5 px-2.5 py-1 rounded-full text-[11px] font-semibold uppercase tracking-tight;
    }
    .table-header {
        @apply px-4 py-3 text-left text-[11px] font-bold text-slate-500 uppercase tracking-wider border-b border-slate-200 dark:border-border-dark;
    }
    .table-cell {
        @apply px-4 py-4 text-sm border-b border-slate-100 dark:border-border-dark/50;
    }
</style>