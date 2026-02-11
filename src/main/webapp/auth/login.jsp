<!DOCTYPE html>

<html class="light" lang="en">

<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Sign In - AI News</title>
    <!-- Fonts -->
    <link href="https://fonts.googleapis.com" rel="preconnect" />
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect" />
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@300;400;500;600;700&amp;display=swap"
        rel="stylesheet" />
    <!-- Material Symbols -->
    <link
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
        rel="stylesheet" />
    <link
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
        rel="stylesheet" />
    <!-- Tailwind Configuration -->
    <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
    <script id="tailwind-config">
        tailwind.config = {
            darkMode: "class",
            theme: {
                extend: {
                    colors: {
                        "primary": "#0d7ff2",
                        "background-light": "#f5f7f8",
                        "background-dark": "#101922",
                    },
                    fontFamily: {
                        "display": ["Work Sans", "sans-serif"]
                    },
                    borderRadius: { "DEFAULT": "0.25rem", "lg": "0.5rem", "xl": "0.75rem", "full": "9999px" },
                },
            },
        }
    </script>
    <style>
        /* Custom styles for checkbox to match primary color more easily than default forms plugin sometimes allows */
        .checkbox-primary:checked {
            background-color: #0d7ff2;
            border-color: #0d7ff2;
        }
    </style>
</head>

<body
    class="font-display bg-background-light dark:bg-background-dark text-[#111418] dark:text-white h-screen overflow-hidden flex">
    <!-- Left Pane: Editorial Image & Branding -->
    <div class="hidden lg:flex lg:w-1/2 relative flex-col justify-between p-12 bg-cover bg-center"
        data-alt="Modern newsroom office with computers and journalists working"
        style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuAMDbroOsEPO0xNWm9AVOtP20zaijGBtYRcLxm8Fp2rs8boX0r5x6WrNy_UPg_Zm3e6Gl39muCSfJ88X1-gnEUNQa3GSoAYmnKv1bGV2ONJmsnWBCTRnMiuFr0RbUzqKaI9QZ7wdifQgLD0h65BV2S6kukjuQuymOGube1ZG1tPw7VdR-hdbjYwyBZOM10zWqZoNkOOn_2ls1PPeafObFf87EjdPJ5qaER-LIcfYJoB_72ZD_XT310I03b_u2US47HJ6nZUeFI_-8ur");'>
        <!-- Overlay -->
        <div class="absolute inset-0 bg-primary/80 mix-blend-multiply z-0"></div>
        <div class="absolute inset-0 bg-black/20 z-0"></div>
        <!-- Content on top of overlay -->
        <div class="relative z-10">
            <div class="flex items-center gap-3">
                <div
                    class="flex items-center justify-center w-10 h-10 rounded-lg bg-white/20 backdrop-blur-sm text-white">
                    <span class="material-symbols-outlined text-[24px]">newsmode</span>
                </div>
                <h1 class="text-white text-2xl font-bold tracking-tight">AI News</h1>
            </div>
        </div>
        <div class="relative z-10 max-w-lg">
            <h2 class="text-white text-4xl font-bold leading-tight mb-4">Empowering Journalism with Intelligent Insights
            </h2>
            <p class="text-white/90 text-lg font-light">Join thousands of journalists and readers using our
                AI-integrated platform to uncover truth faster.</p>
        </div>
        <div class="relative z-10 flex gap-2">
            <!-- Decorative indicators -->
            <div class="w-12 h-1 bg-white rounded-full"></div>
            <div class="w-2 h-1 bg-white/40 rounded-full"></div>
            <div class="w-2 h-1 bg-white/40 rounded-full"></div>
        </div>
    </div>
    <!-- Right Pane: Sign In Form -->
    <div class="w-full lg:w-1/2 flex flex-col h-full overflow-y-auto bg-white dark:bg-[#15202b]">
        <div class="flex-1 flex flex-col justify-center px-8 sm:px-12 md:px-24 py-12">
            <!-- Mobile Logo (visible only on small screens) -->
            <div class="lg:hidden flex items-center gap-2 mb-8 text-primary">
                <span class="material-symbols-outlined text-[32px]">newsmode</span>
                <span class="text-xl font-bold text-[#111418] dark:text-white">AI News</span>
            </div>
            <div class="max-w-[480px] w-full mx-auto space-y-8">
                <!-- Header -->
                <div class="space-y-2">
                    <h1 class="text-[#111418] dark:text-white text-3xl font-bold tracking-tight">Welcome Back</h1>
                    <p class="text-[#60758a] dark:text-[#9aa0a6] text-base">Enter your credentials to access your
                        dashboard.</p>
                </div>
                <!-- Form -->
                <form class="space-y-5" action="${pageContext.request.contextPath}/LoginController" method="post">
                    <!-- Email Input -->
                    <div class="space-y-2">
                        <label class="text-[#111418] dark:text-white text-sm font-medium" for="email">Email</label>
                        <div class="relative">
                            <input
                                class="form-input block w-full rounded-lg border border-[#dbe0e6] dark:border-[#3e4c59] bg-white dark:bg-[#101922] h-12 px-4 text-[#111418] dark:text-white placeholder:text-[#60758a] focus:border-primary focus:ring-1 focus:ring-primary transition-colors"
                                id="email" name="email" placeholder="name@example.com" type="email" />
                            <!-- Validation Icon (Success state example) -->
                            <!-- <div class="absolute right-3 top-3 hidden text-green-500">
<span class="material-symbols-outlined text-[20px]">check_circle</span>
</div> -->
                        </div>
                    </div>
                    <!-- Password Input -->
                    <div class="space-y-2">
                        <label class="text-[#111418] dark:text-white text-sm font-medium"
                            for="password">Password</label>
                        <div class="relative group">
                            <input
                                class="form-input block w-full rounded-lg border border-[#dbe0e6] dark:border-[#3e4c59] bg-white dark:bg-[#101922] h-12 px-4 text-[#111418] dark:text-white placeholder:text-[#60758a] focus:border-primary focus:ring-1 focus:ring-primary transition-colors pr-10"
                                id="password" name="password" placeholder="Enter your password" type="password" />
                            <button
                                class="absolute right-3 top-3 text-[#60758a] hover:text-[#111418] dark:hover:text-white focus:outline-none transition-colors"
                                type="button">
                                <span class="material-symbols-outlined text-[20px]">visibility</span>
                            </button>
                        </div>
                    </div>
                    <!-- Options Row -->
                    <div class="flex items-center justify-between">
                        <label class="flex items-center gap-2 cursor-pointer">
                            <input
                                class="checkbox-primary form-checkbox rounded text-primary focus:ring-primary border-[#dbe0e6] dark:border-[#3e4c59] bg-white dark:bg-[#101922] w-4 h-4"
                                type="checkbox" />
                            <span class="text-sm text-[#60758a] dark:text-[#9aa0a6] font-medium select-none">Remember
                                me</span>
                        </label>
                        <a class="text-sm font-semibold text-primary hover:text-primary/80 transition-colors"
                            href="#">Forgot Password?</a>
                    </div>
                    <!-- Main Action -->
                    <button
                        class="w-full h-12 bg-primary hover:bg-primary/90 text-white font-semibold rounded-lg transition-all shadow-sm flex items-center justify-center gap-2">
                        Sign In
                        <span class="material-symbols-outlined text-[20px]">arrow_forward</span>
                    </button>
                </form>
                <!-- Divider -->
                <div class="relative">
                    <div class="absolute inset-0 flex items-center">
                        <div class="w-full border-t border-[#dbe0e6] dark:border-[#3e4c59]"></div>
                    </div>
                    <div class="relative flex justify-center text-sm">
                        <span class="bg-white dark:bg-[#15202b] px-4 text-[#60758a] dark:text-[#9aa0a6]">Or continue
                            with</span>
                    </div>
                </div>
                <!-- Social Auth -->
                <div class="grid grid-cols-2 gap-4">
                    <button
                        class="flex items-center justify-center gap-3 h-12 border border-[#dbe0e6] dark:border-[#3e4c59] rounded-lg hover:bg-[#f5f7f8] dark:hover:bg-[#1e2a36] transition-colors bg-white dark:bg-[#101922] text-[#111418] dark:text-white font-medium">
                        <!-- Google Logo placeholder -->
                        <svg class="w-5 h-5" viewbox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                            <path
                                d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"
                                fill="#4285F4"></path>
                            <path
                                d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"
                                fill="#34A853"></path>
                            <path
                                d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"
                                fill="#FBBC05"></path>
                            <path
                                d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"
                                fill="#EA4335"></path>
                        </svg>
                        Google
                    </button>
                    <button
                        class="flex items-center justify-center gap-3 h-12 border border-[#dbe0e6] dark:border-[#3e4c59] rounded-lg hover:bg-[#f5f7f8] dark:hover:bg-[#1e2a36] transition-colors bg-white dark:bg-[#101922] text-[#111418] dark:text-white font-medium">
                        <!-- Facebook Logo placeholder -->
                        <svg class="w-5 h-5 text-[#1877F2]" fill="currentColor" viewbox="0 0 24 24"
                            xmlns="http://www.w3.org/2000/svg">
                            <path
                                d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z">
                            </path>
                        </svg>
                        Facebook
                    </button>
                </div>
                <!-- Footer Link -->
                <p class="text-center text-[#60758a] dark:text-[#9aa0a6] text-sm">
                    Don't have an account?
                    <a class="text-primary font-semibold hover:underline"
                        href="${pageContext.request.contextPath}/auth/register.jsp">Sign up</a>
                </p>
            </div>
        </div>
        <!-- Optional Footer info (Rights reserved) -->
        <div class="py-6 text-center text-xs text-[#60758a] dark:text-[#9aa0a6]">
            © 2024 AI News Media. All rights reserved.
        </div>
    </div>
</body>

</html>