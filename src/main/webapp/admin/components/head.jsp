<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@300;400;500;600;700&amp;display=swap"
        rel="stylesheet" />
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet" />
    <link
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
        rel="stylesheet" />
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#0d7ff2",
                        "background-light": "#f5f7f8",
                        "background-dark": "#101922",
                        "dashboard-bg": "#F4F7FE",
                        "risk-high": "#ef4444",
                        "risk-medium": "#f59e0b",
                        "risk-low": "#10b981",
                    },
                    fontFamily: {
                        "display": ["Work Sans"]
                    },
                    borderRadius: {
                        "DEFAULT": "0.25rem",
                        "lg": "0.5rem",
                        "xl": "0.75rem",
                        "full": "9999px"
                    },
                },
            },
        }
    </script>
    <style>
        body {
            font-family: 'Work Sans', sans-serif;
        }

        .sidebar-active {
            background-color: rgba(13, 127, 242, 0.15);
            border-right: 4px solid #0d7ff2;
            color: #0d7ff2;
        }

        .ai-gradient-border {
            position: relative;
            background: #fff;
            border: 2px solid transparent;
            background-clip: padding-box;
        }

        .ai-gradient-border::before {
            content: '';
            position: absolute;
            top: -2px;
            bottom: -2px;
            left: -2px;
            right: -2px;
            z-index: -1;
            border-radius: inherit;
            background: linear-gradient(to right, #0d7ff2, #a5b4fc);
        }
    </style>