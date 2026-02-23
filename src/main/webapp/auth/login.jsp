<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

    <html class="light" lang="en">

    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>Đăng nhập - NeuralNews</title>
        <!-- Fonts -->
        <link href="https://fonts.googleapis.com" rel="preconnect" />
        <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect" />
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@300;400;500;600;700&display=swap"
            rel="stylesheet" />
        <!-- Material Symbols -->
        <link
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
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
                    <h1 class="text-white text-2xl font-bold tracking-tight">NeuralNews</h1>
                </div>
            </div>
            <div class="relative z-10 max-w-lg">
                <h2 class="text-white text-4xl font-bold leading-tight mb-4">Nâng tầm Báo chí với Thông tin Trí tuệ
                </h2>
                <p class="text-white/90 text-lg font-light">Tham gia cùng hàng ngàn nhà báo và độc giả sử dụng nền tảng
                    tích hợp AI của chúng tôi để khám phá sự thật nhanh hơn.</p>
            </div>
            <div class="relative z-10 flex gap-2">
                <div class="w-12 h-1 bg-white rounded-full"></div>
                <div class="w-2 h-1 bg-white/40 rounded-full"></div>
                <div class="w-2 h-1 bg-white/40 rounded-full"></div>
            </div>
        </div>
        <!-- Right Pane: Sign In Form -->
        <div class="w-full lg:w-1/2 flex flex-col h-full overflow-y-auto bg-white dark:bg-[#15202b]">
            <div class="flex-1 flex flex-col justify-center px-8 sm:px-12 md:px-24 py-12">
                <!-- Mobile Logo -->
                <div class="lg:hidden flex items-center gap-2 mb-8 text-primary">
                    <span class="material-symbols-outlined text-[32px]">newsmode</span>
                    <span class="text-xl font-bold text-[#111418] dark:text-white">NeuralNews</span>
                </div>
                <div class="max-w-[480px] w-full mx-auto space-y-8">
                    <!-- Header -->
                    <div class="space-y-2">
                        <h1 class="text-[#111418] dark:text-white text-3xl font-bold tracking-tight">Chào mừng trở lại
                        </h1>
                        <p class="text-[#60758a] dark:text-[#9aa0a6] text-base">Nhập thông tin đăng nhập để truy cập
                            bảng điều khiển.</p>
                    </div>

                    <%-- Thông báo lỗi / thành công --%>
                        <% String error=request.getParameter("error"); String success=request.getParameter("success");
                            %>
                            <% if ("invalid".equals(error) || "empty" .equals(error)) { %>
                                <div
                                    class="flex items-center gap-3 p-4 rounded-lg bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-700 dark:text-red-400">
                                    <span class="material-symbols-outlined text-[20px] flex-shrink-0">error</span>
                                    <p class="text-sm font-medium">Email hoặc mật khẩu không đúng. Vui lòng thử lại.</p>
                                </div>
                                <% } else if ("banned".equals(error) || "pending" .equals(error)) { %>
                                    <div
                                        class="flex items-center gap-3 p-4 rounded-lg bg-orange-50 dark:bg-orange-900/20 border border-orange-200 dark:border-orange-800 text-orange-700 dark:text-orange-400">
                                        <span class="material-symbols-outlined text-[20px] flex-shrink-0">block</span>
                                        <p class="text-sm font-medium">Tài khoản của bạn đã bị khóa hoặc đang chờ duyệt.
                                            Vui lòng liên hệ quản trị viên.</p>
                                    </div>
                                    <% } else if ("registered".equals(success)) { %>
                                        <div
                                            class="flex items-center gap-3 p-4 rounded-lg bg-green-50 dark:bg-green-900/20 border border-green-200 dark:border-green-800 text-green-700 dark:text-green-400">
                                            <span
                                                class="material-symbols-outlined text-[20px] flex-shrink-0">check_circle</span>
                                            <p class="text-sm font-medium">Đăng ký thành công! Hãy đăng nhập để tiếp
                                                tục.</p>
                                        </div>
                                        <% } %>

                                            <!-- Form -->
                                            <form class="space-y-5"
                                                action="${pageContext.request.contextPath}/LoginController"
                                                method="post">
                                                <!-- Email Input -->
                                                <div class="space-y-2">
                                                    <label class="text-[#111418] dark:text-white text-sm font-medium"
                                                        for="email">Email</label>
                                                    <div class="relative">
                                                        <input
                                                            class="form-input block w-full rounded-lg border border-[#dbe0e6] dark:border-[#3e4c59] bg-white dark:bg-[#101922] h-12 px-4 text-[#111418] dark:text-white placeholder:text-[#60758a] focus:border-primary focus:ring-1 focus:ring-primary transition-colors"
                                                            id="email" name="email" placeholder="name@example.com"
                                                            type="email" required />
                                                    </div>
                                                </div>
                                                <!-- Password Input -->
                                                <div class="space-y-2">
                                                    <label class="text-[#111418] dark:text-white text-sm font-medium"
                                                        for="password">Mật khẩu</label>
                                                    <div class="relative group">
                                                        <input
                                                            class="form-input block w-full rounded-lg border border-[#dbe0e6] dark:border-[#3e4c59] bg-white dark:bg-[#101922] h-12 px-4 text-[#111418] dark:text-white placeholder:text-[#60758a] focus:border-primary focus:ring-1 focus:ring-primary transition-colors pr-10"
                                                            id="password" name="password"
                                                            placeholder="Nhập mật khẩu của bạn" type="password"
                                                            required />
                                                        <button
                                                            class="absolute right-3 top-3 text-[#60758a] hover:text-[#111418] dark:hover:text-white focus:outline-none transition-colors"
                                                            type="button" onclick="togglePassword('password', this)">
                                                            <span
                                                                class="material-symbols-outlined text-[20px]">visibility</span>
                                                        </button>
                                                    </div>
                                                </div>
                                                <!-- Options Row -->
                                                <div class="flex items-center justify-between">
                                                    <label class="flex items-center gap-2 cursor-pointer">
                                                        <input
                                                            class="checkbox-primary form-checkbox rounded text-primary focus:ring-primary border-[#dbe0e6] dark:border-[#3e4c59] bg-white dark:bg-[#101922] w-4 h-4"
                                                            type="checkbox" />
                                                        <span
                                                            class="text-sm text-[#60758a] dark:text-[#9aa0a6] font-medium select-none">Ghi
                                                            nhớ đăng nhập</span>
                                                    </label>
                                                    <a class="text-sm font-semibold text-primary hover:text-primary/80 transition-colors"
                                                        href="#">Quên mật khẩu?</a>
                                                </div>
                                                <!-- Main Action -->
                                                <button
                                                    class="w-full h-12 bg-primary hover:bg-primary/90 text-white font-semibold rounded-lg transition-all shadow-sm flex items-center justify-center gap-2"
                                                    type="submit">
                                                    Đăng nhập
                                                    <span
                                                        class="material-symbols-outlined text-[20px]">arrow_forward</span>
                                                </button>
                                            </form>
                                            <!-- Footer Link -->
                                            <p class="text-center text-[#60758a] dark:text-[#9aa0a6] text-sm">
                                                Chưa có tài khoản?
                                                <a class="text-primary font-semibold hover:underline"
                                                    href="${pageContext.request.contextPath}/auth/register.jsp">Đăng
                                                    ký</a>
                                            </p>
                </div>
            </div>
            <!-- Footer -->
            <div class="py-6 text-center text-xs text-[#60758a] dark:text-[#9aa0a6]">
                © 2025 NeuralNews Media. Mọi quyền được bảo lưu.
            </div>
        </div>

        <script>
            function togglePassword(fieldId, btn) {
                const input = document.getElementById(fieldId);
                const icon = btn.querySelector('.material-symbols-outlined');
                if (input.type === 'password') {
                    input.type = 'text';
                    icon.textContent = 'visibility_off';
                } else {
                    input.type = 'password';
                    icon.textContent = 'visibility';
                }
            }
        </script>
    </body>

    </html>