<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <html class="light" lang="en">

    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>Sign Up - NeuralNews</title>
        <link href="https://fonts.googleapis.com" rel="preconnect" />
        <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect" />
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@300;400;500;600;700&display=swap"
            rel="stylesheet" />
        <link
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap"
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
                    <h1 class="text-white text-2xl font-bold tracking-tight">NeuralNews</h1>
                </div>
            </div>
            <div class="relative z-10 max-w-lg">
                <h2 class="text-white text-4xl font-bold leading-tight mb-4">Empowering Journalism with Intelligent
                    Insights
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
                    <span class="text-xl font-bold text-[#111418] dark:text-white">NeuralNews</span>
                </div>
                <div class="max-w-[480px] w-full mx-auto space-y-6">
                    <div class="space-y-2">
                        <h1 class="text-[#111418] dark:text-white text-3xl font-bold tracking-tight">Create an Account
                        </h1>
                        <p class="text-[#60758a] dark:text-[#9aa0a6] text-base">Get started with your free AI-powered
                            news
                            dashboard.</p>
                    </div>

                    <%-- Thông báo lỗi --%>
                        <% String error=request.getParameter("error"); String errorMsg=null; if ("exists".equals(error))
                            { errorMsg="Email này đã được sử dụng. Vui lòng dùng email khác." ; } else if
                            ("mismatch".equals(error)) { errorMsg="Mật khẩu xác nhận không khớp. Vui lòng kiểm tra lại."
                            ; } else if ("weakpassword".equals(error)) { errorMsg="Mật khẩu phải có ít nhất 6 ký tự." ;
                            } else if ("empty".equals(error)) { errorMsg="Vui lòng điền đầy đủ thông tin." ; } else if
                            ("servererror".equals(error)) { errorMsg="Có lỗi xảy ra. Vui lòng thử lại sau." ; } %>
                            <% if (errorMsg !=null) { %>
                                <div
                                    class="flex items-center gap-3 p-4 rounded-lg bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-700 dark:text-red-400">
                                    <span class="material-symbols-outlined text-[20px] flex-shrink-0">error</span>
                                    <p class="text-sm font-medium">
                                        <%= errorMsg %>
                                    </p>
                                </div>
                                <% } %>

                                    <form class="space-y-5"
                                        action="${pageContext.request.contextPath}/RegisterController" method="post"
                                        id="registerForm" onsubmit="return validateForm()">
                                        <!-- Full Name -->
                                        <div class="space-y-2">
                                            <label class="text-[#111418] dark:text-white text-sm font-medium"
                                                for="fullname">Full
                                                Name</label>
                                            <input
                                                class="form-input block w-full rounded-lg border border-[#dbe0e6] dark:border-[#3e4c59] bg-white dark:bg-[#101922] h-12 px-4 text-[#111418] dark:text-white placeholder:text-[#60758a] focus:border-primary focus:ring-1 focus:ring-primary transition-colors"
                                                id="fullname" name="fullname" placeholder="e.g. Nguyễn Văn A"
                                                type="text" required />
                                        </div>
                                        <!-- Email -->
                                        <div class="space-y-2">
                                            <label class="text-[#111418] dark:text-white text-sm font-medium"
                                                for="email">Email
                                                Address</label>
                                            <div class="relative">
                                                <input
                                                    class="form-input block w-full rounded-lg border border-[#dbe0e6] dark:border-[#3e4c59] bg-white dark:bg-[#101922] h-12 px-4 text-[#111418] dark:text-white placeholder:text-[#60758a] focus:border-primary focus:ring-1 focus:ring-primary transition-colors"
                                                    id="email" name="email" placeholder="name@example.com" type="email"
                                                    required />
                                            </div>
                                        </div>
                                        <!-- Password -->
                                        <div class="space-y-2">
                                            <label class="text-[#111418] dark:text-white text-sm font-medium"
                                                for="password">Password</label>
                                            <div class="relative group">
                                                <input
                                                    class="form-input block w-full rounded-lg border border-[#dbe0e6] dark:border-[#3e4c59] bg-white dark:bg-[#101922] h-12 px-4 text-[#111418] dark:text-white placeholder:text-[#60758a] focus:border-primary focus:ring-1 focus:ring-primary transition-colors pr-10"
                                                    id="password" name="password" placeholder="Tối thiểu 6 ký tự"
                                                    type="password" required oninput="updateStrength()" />
                                                <button
                                                    class="absolute right-3 top-3 text-[#60758a] hover:text-[#111418] dark:hover:text-white focus:outline-none transition-colors"
                                                    type="button" onclick="togglePassword('password', this)">
                                                    <span
                                                        class="material-symbols-outlined text-[20px]">visibility</span>
                                                </button>
                                            </div>
                                            <!-- Password strength bar -->
                                            <div class="flex gap-1 h-1 pt-1">
                                                <div id="bar1"
                                                    class="flex-1 bg-[#dbe0e6] dark:bg-[#3e4c59] rounded-full h-full transition-colors">
                                                </div>
                                                <div id="bar2"
                                                    class="flex-1 bg-[#dbe0e6] dark:bg-[#3e4c59] rounded-full h-full transition-colors">
                                                </div>
                                                <div id="bar3"
                                                    class="flex-1 bg-[#dbe0e6] dark:bg-[#3e4c59] rounded-full h-full transition-colors">
                                                </div>
                                                <div id="bar4"
                                                    class="flex-1 bg-[#dbe0e6] dark:bg-[#3e4c59] rounded-full h-full transition-colors">
                                                </div>
                                            </div>
                                            <p class="text-xs text-[#60758a] dark:text-[#9aa0a6]">Strength: <span
                                                    id="strengthLabel" class="font-medium">—</span></p>
                                        </div>
                                        <!-- Confirm Password -->
                                        <div class="space-y-2">
                                            <label class="text-[#111418] dark:text-white text-sm font-medium"
                                                for="confirmPassword">Confirm
                                                Password</label>
                                            <input
                                                class="form-input block w-full rounded-lg border border-[#dbe0e6] dark:border-[#3e4c59] bg-white dark:bg-[#101922] h-12 px-4 text-[#111418] dark:text-white placeholder:text-[#60758a] focus:border-primary focus:ring-1 focus:ring-primary transition-colors"
                                                id="confirmPassword" name="confirmPassword"
                                                placeholder="Nhập lại mật khẩu" type="password" required />
                                        </div>
                                        <!-- Terms -->
                                        <div class="flex items-start gap-3">
                                            <div class="flex items-center h-5">
                                                <input
                                                    class="checkbox-primary form-checkbox rounded text-primary focus:ring-primary border-[#dbe0e6] dark:border-[#3e4c59] bg-white dark:bg-[#101922] w-4 h-4 mt-0.5"
                                                    id="terms" type="checkbox" required />
                                            </div>
                                            <label
                                                class="text-sm text-[#60758a] dark:text-[#9aa0a6] select-none leading-5"
                                                for="terms">
                                                I agree to the <a class="text-primary hover:text-primary/80"
                                                    href="#">Terms of Service</a>
                                                and <a class="text-primary hover:text-primary/80" href="#">Privacy
                                                    Policy</a>.
                                            </label>
                                        </div>
                                        <button
                                            class="w-full h-12 bg-primary hover:bg-primary/90 text-white font-semibold rounded-lg transition-all shadow-sm flex items-center justify-center gap-2 mt-2"
                                            type="submit">
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
                © 2025 NeuralNews Media. All rights reserved.
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

            function updateStrength() {
                const pw = document.getElementById('password').value;
                const bars = [document.getElementById('bar1'), document.getElementById('bar2'),
                document.getElementById('bar3'), document.getElementById('bar4')];
                const label = document.getElementById('strengthLabel');

                let score = 0;
                if (pw.length >= 6) score++;
                if (pw.length >= 10) score++;
                if (/[A-Z]/.test(pw) && /[0-9]/.test(pw)) score++;
                if (/[^A-Za-z0-9]/.test(pw)) score++;

                const colors = ['bg-red-400', 'bg-orange-400', 'bg-yellow-400', 'bg-green-500'];
                const labels = ['', 'Yếu', 'Trung bình', 'Khá', 'Mạnh'];
                const labelColors = ['', 'text-red-500', 'text-orange-500', 'text-yellow-500', 'text-green-500'];

                bars.forEach((bar, i) => {
                    bar.className = 'flex-1 rounded-full h-full transition-colors ' +
                        (i < score ? colors[score - 1] : 'bg-[#dbe0e6] dark:bg-[#3e4c59]');
                });
                label.textContent = labels[score] || '—';
                label.className = 'font-medium ' + (labelColors[score] || '');
            }

            function validateForm() {
                const pw = document.getElementById('password').value;
                const cpw = document.getElementById('confirmPassword').value;
                if (pw !== cpw) {
                    alert('Mật khẩu xác nhận không khớp!');
                    return false;
                }
                if (pw.length < 6) {
                    alert('Mật khẩu phải có ít nhất 6 ký tự!');
                    return false;
                }
                return true;
            }
        </script>
    </body>

    </html>