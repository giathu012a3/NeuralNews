<!DOCTYPE html>
<html class="light" lang="en">

<head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />
    <title>Sign Up - AI News</title>
    <link href="https://fonts.googleapis.com" rel="preconnect" />
    <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect" />
    <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@300;400;500;600;700&amp;display=swap"
        rel="stylesheet" />
    <link
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&amp;display=swap"
        rel="stylesheet" />
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
        .checkbox-primary:checked {
            background-color: #0d7ff2;
            border-color: #0d7ff2;
        }
    </style>
</head>

<body
    class="font-display bg-background-light dark:bg-background-dark text-[#111418] dark:text-white h-screen overflow-hidden flex">
    <div class="hidden lg:flex lg:w-1/2 relative flex-col justify-between p-12 bg-cover bg-center"
        data-alt="Modern newsroom office with computers and journalists working"
        style='background-image: url("https://lh3.googleusercontent.com/aida-public/AB6AXuAMDbroOsEPO0xNWm9AVOtP20zaijGBtYRcLxm8Fp2rs8boX0r5x6WrNy_UPg_Zm3e6Gl39muCSfJ88X1-gnEUNQa3GSoAYmnKv1bGV2ONJmsnWBCTRnMiuFr0RbUzqKaI9QZ7wdifQgLD0h65BV2S6kukjuQuymOGube1ZG1tPw7VdR-hdbjYwyBZOM10zWqZoNkOOn_2ls1PPeafObFf87EjdPJ5qaER-LIcfYJoB_72ZD_XT310I03b_u2US47HJ6nZUeFI_-8ur");'>
        <div class="absolute inset-0 bg-primary/80 mix-blend-multiply z-0"></div>
        <div class="absolute inset-0 bg-black/20 z-0"></div>
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
            <div class="w-12 h-1 bg-white rounded-full"></div>
            <div class="w-2 h-1 bg-white/40 rounded-full"></div>
            <div class="w-2 h-1 bg-white/40 rounded-full"></div>
        </div>
    </div>
    <div class="w-full lg:w-1/2 flex flex-col h-full overflow-y-auto bg-white dark:bg-[#15202b]">
        <div class="flex-1 flex flex-col justify-center px-8 sm:px-12 md:px-24 py-12">
            <div class="lg:hidden flex items-center gap-2 mb-8 text-primary">
                <span class="material-symbols-outlined text-[32px]">newsmode</span>
                <span class="text-xl font-bold text-[#111418] dark:text-white">AI News</span>
            </div>
            <div class="max-w-[480px] w-full mx-auto space-y-8">
                <div class="space-y-2">
                    <h1 class="text-[#111418] dark:text-white text-3xl font-bold tracking-tight">Create an Account</h1>
                    <p class="text-[#60758a] dark:text-[#9aa0a6] text-base">Get started with your free AI-powered news
                        dashboard.</p>
                </div>
                <form class="space-y-5" action="${pageContext.request.contextPath}/LoginController" method="post">
                    <div class="space-y-2">
                        <label class="text-[#111418] dark:text-white text-sm font-medium" for="fullname">Full
                            Name</label>
                        <input
                            class="form-input block w-full rounded-lg border border-[#dbe0e6] dark:border-[#3e4c59] bg-white dark:bg-[#101922] h-12 px-4 text-[#111418] dark:text-white placeholder:text-[#60758a] focus:border-primary focus:ring-1 focus:ring-primary transition-colors"
                            id="fullname" placeholder="e.g. Sarah Jenkins" type="text" />
                    </div>
                    <div class="space-y-2">
                        <div class="flex justify-between items-center">
                            <label class="text-[#111418] dark:text-white text-sm font-medium" for="email">Email
                                Address</label>
                            <div class="flex items-center gap-1 text-xs text-[#60758a] dark:text-[#9aa0a6]">
                                <span class="material-symbols-outlined text-[14px] animate-spin">sync</span>
                                Checking availability...
                            </div>
                        </div>
                        <div class="relative">
                            <input
                                class="form-input block w-full rounded-lg border border-[#dbe0e6] dark:border-[#3e4c59] bg-white dark:bg-[#101922] h-12 px-4 text-[#111418] dark:text-white placeholder:text-[#60758a] focus:border-primary focus:ring-1 focus:ring-primary transition-colors"
                                id="email" name="email" placeholder="name@example.com" type="email" />
                        </div>
                    </div>
                    <div class="space-y-2">
                        <label class="text-[#111418] dark:text-white text-sm font-medium"
                            for="password">Password</label>
                        <div class="relative group">
                            <input
                                class="form-input block w-full rounded-lg border border-[#dbe0e6] dark:border-[#3e4c59] bg-white dark:bg-[#101922] h-12 px-4 text-[#111418] dark:text-white placeholder:text-[#60758a] focus:border-primary focus:ring-1 focus:ring-primary transition-colors pr-10"
                                id="password" name="password" placeholder="Create a strong password" type="password" />
                            <button
                                class="absolute right-3 top-3 text-[#60758a] hover:text-[#111418] dark:hover:text-white focus:outline-none transition-colors"
                                type="button">
                                <span class="material-symbols-outlined text-[20px]">visibility</span>
                            </button>
                        </div>
                        <div class="flex gap-1 h-1 pt-1">
                            <div class="flex-1 bg-green-500 rounded-full h-full"></div>
                            <div class="flex-1 bg-green-500 rounded-full h-full"></div>
                            <div class="flex-1 bg-[#dbe0e6] dark:bg-[#3e4c59] rounded-full h-full"></div>
                            <div class="flex-1 bg-[#dbe0e6] dark:bg-[#3e4c59] rounded-full h-full"></div>
                        </div>
                        <p class="text-xs text-[#60758a] dark:text-[#9aa0a6]">Strength: <span
                                class="text-green-500 font-medium">Medium</span></p>
                    </div>
                    <div class="space-y-2">
                        <label class="text-[#111418] dark:text-white text-sm font-medium" for="confirm-password">Confirm
                            Password</label>
                        <input
                            class="form-input block w-full rounded-lg border border-[#dbe0e6] dark:border-[#3e4c59] bg-white dark:bg-[#101922] h-12 px-4 text-[#111418] dark:text-white placeholder:text-[#60758a] focus:border-primary focus:ring-1 focus:ring-primary transition-colors"
                            id="confirm-password" placeholder="Confirm your password" type="password" />
                    </div>
                    <div class="flex items-start gap-3">
                        <div class="flex items-center h-5">
                            <input
                                class="checkbox-primary form-checkbox rounded text-primary focus:ring-primary border-[#dbe0e6] dark:border-[#3e4c59] bg-white dark:bg-[#101922] w-4 h-4 mt-0.5"
                                id="terms" type="checkbox" />
                        </div>
                        <label class="text-sm text-[#60758a] dark:text-[#9aa0a6] select-none leading-5" for="terms">
                            I agree to the <a class="text-primary hover:text-primary/80" href="#">Terms of Service</a>
                            and <a class="text-primary hover:text-primary/80" href="#">Privacy Policy</a>.
                        </label>
                    </div>
                    <button
                        class="w-full h-12 bg-primary hover:bg-primary/90 text-white font-semibold rounded-lg transition-all shadow-sm flex items-center justify-center gap-2 mt-2">
                        Create Account
                        <span class="material-symbols-outlined text-[20px]">arrow_forward</span>
                    </button>
                </form>
                <p class="text-center text-[#60758a] dark:text-[#9aa0a6] text-sm">
                    Already have an account?
                    <a class="text-primary font-semibold hover:underline"
                        href="${pageContext.request.contextPath}/auth/login.jsp">Sign In</a>
                </p>
            </div>
        </div>
        <div class="py-6 text-center text-xs text-[#60758a] dark:text-[#9aa0a6]">
            © 2024 AI News Media. All rights reserved.
        </div>
    </div>

</body>

</html>