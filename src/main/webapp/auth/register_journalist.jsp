<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html class="light" lang="en">

    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1.0" name="viewport" />
        <title>Đăng ký Nhà báo - NeuralNews</title>
        <link href="https://fonts.googleapis.com" rel="preconnect" />
        <link crossorigin="" href="https://fonts.gstatic.com" rel="preconnect" />
        <link href="https://fonts.googleapis.com/css2?family=Work+Sans:wght@300;400;500;600;700&display=swap"
            rel="stylesheet" />
        <link
            href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200&display=swap"
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

            /* Custom scrollbar for better UX */
            ::-webkit-scrollbar {
                width: 6px;
            }

            ::-webkit-scrollbar-track {
                background: transparent;
            }

            ::-webkit-scrollbar-thumb {
                background: #dbe0e6;
                border-radius: 10px;
            }

            .dark ::-webkit-scrollbar-thumb {
                background: #3e4c59;
            }
        </style>
    </head>

    <body
        class="font-display bg-background-light dark:bg-background-dark text-[#111418] dark:text-white h-screen overflow-hidden flex">
        <div class="hidden lg:flex lg:w-1/2 relative flex-col justify-between p-12 bg-cover bg-center"
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
                <h2 class="text-white text-4xl font-bold leading-tight mb-4">Trở thành Nhà báo tại NeuralNews</h2>
                <p class="text-white/90 text-lg font-light">Chia sẻ góc nhìn của bạn với hàng ngàn độc giả. Chúng tôi
                    cung cấp các công cụ AI mạnh mẽ để hỗ trợ quá trình sáng tạo nội dung của bạn.</p>
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

                <div class="max-w-[520px] w-full mx-auto space-y-6">
                    <div class="space-y-2 text-center lg:text-left">
                        <h1 class="text-[#111418] dark:text-white text-3xl font-bold tracking-tight">Đăng ký cộng tác
                        </h1>
                        <p class="text-[#60758a] dark:text-[#9aa0a6] text-base">Vui lòng cung cấp thông tin chuyên môn
                            để chúng tôi xem xét.</p>
                    </div>

                    <%-- Thông báo lỗi --%>
                        <% String error=request.getParameter("error"); String errorMsg=null; if ("exists".equals(error))
                            { errorMsg="Email này đã được sử dụng." ; } else if ("mismatch".equals(error)) {
                            errorMsg="Mật khẩu xác nhận không khớp." ; } else if ("weakpassword".equals(error)) {
                            errorMsg="Mật khẩu phải có ít nhất 6 ký tự." ; } else if ("empty".equals(error)) {
                            errorMsg="Vui lòng điền đầy đủ các thông tin bắt buộc." ; } else if
                            ("servererror".equals(error)) { errorMsg="Có lỗi xảy ra từ máy chủ, vui lòng thử lại." ; }
                            %>
                            <% if (errorMsg !=null) { %>
                                <div
                                    class="flex items-center gap-3 p-4 rounded-lg bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 text-red-700 dark:text-red-400">
                                    <span class="material-symbols-outlined text-[20px] flex-shrink-0">error</span>
                                    <p class="text-sm font-medium">
                                        <%= errorMsg %>
                                    </p>
                                </div>
                                <% } %>

                                    <form class="space-y-4"
                                        action="${pageContext.request.contextPath}/JournalistRegisterController"
                                        method="post" id="registerForm" onsubmit="return validateForm()">
                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                            <!-- Full Name -->
                                            <div class="space-y-1.5">
                                                <label class="text-[#111418] dark:text-white text-sm font-medium"
                                                    for="fullname">Họ và tên *</label>
                                                <input
                                                    class="form-input block w-full rounded-lg border border-[#dbe0e6] dark:border-[#3e4c59] bg-white dark:bg-[#101922] h-11 px-4 text-[#111418] dark:text-white placeholder:text-[#60758a] focus:border-primary focus:ring-1 focus:ring-primary transition-all shadow-sm"
                                                    id="fullname" name="fullname" placeholder="Nguyễn Văn A" type="text"
                                                    required />
                                            </div>
                                            <!-- Email -->
                                            <div class="space-y-1.5">
                                                <label class="text-[#111418] dark:text-white text-sm font-medium"
                                                    for="email">Email *</label>
                                                <input
                                                    class="form-input block w-full rounded-lg border border-[#dbe0e6] dark:border-[#3e4c59] bg-white dark:bg-[#101922] h-11 px-4 text-[#111418] dark:text-white placeholder:text-[#60758a] focus:border-primary focus:ring-1 focus:ring-primary transition-all shadow-sm"
                                                    id="email" name="email" placeholder="name@example.com" type="email"
                                                    required />
                                            </div>
                                        </div>

                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                            <!-- Password -->
                                            <div class="space-y-1.5">
                                                <label class="text-[#111418] dark:text-white text-sm font-medium"
                                                    for="password">Mật khẩu *</label>
                                                <div class="relative group">
                                                    <input
                                                        class="form-input block w-full rounded-lg border border-[#dbe0e6] dark:border-[#3e4c59] bg-white dark:bg-[#101922] h-11 px-4 text-[#111418] dark:text-white placeholder:text-[#60758a] focus:border-primary focus:ring-1 focus:ring-primary transition-all shadow-sm pr-10"
                                                        id="password" name="password" placeholder="6+ ký tự"
                                                        type="password" required oninput="updateStrength()" />
                                                    <button
                                                        class="absolute right-3 top-2.5 text-[#60758a] hover:text-[#111418] dark:hover:text-white focus:outline-none"
                                                        type="button" onclick="togglePassword('password', this)">
                                                        <span
                                                            class="material-symbols-outlined text-[18px]">visibility</span>
                                                    </button>
                                                </div>
                                            </div>
                                            <!-- Confirm Password -->
                                            <div class="space-y-1.5">
                                                <label class="text-[#111418] dark:text-white text-sm font-medium"
                                                    for="confirmPassword">Xác nhận *</label>
                                                <input
                                                    class="form-input block w-full rounded-lg border border-[#dbe0e6] dark:border-[#3e4c59] bg-white dark:bg-[#101922] h-11 px-4 text-[#111418] dark:text-white placeholder:text-[#60758a] focus:border-primary focus:ring-1 focus:ring-primary transition-all shadow-sm"
                                                    id="confirmPassword" name="confirmPassword" placeholder="Nhập lại"
                                                    type="password" required />
                                            </div>
                                        </div>

                                        <!-- Experience -->
                                        <div class="space-y-1.5">
                                            <label class="text-[#111418] dark:text-white text-sm font-medium"
                                                for="experience">Số năm kinh nghiệm *</label>
                                            <div class="relative">
                                                <input
                                                    class="form-input block w-full rounded-lg border border-[#dbe0e6] dark:border-[#3e4c59] bg-white dark:bg-[#101922] h-11 px-4 text-[#111418] dark:text-white placeholder:text-[#60758a] focus:border-primary focus:ring-1 focus:ring-primary transition-all shadow-sm"
                                                    id="experience" name="experience" placeholder="Ví dụ: 3"
                                                    type="number" min="0" required />
                                                <span class="absolute right-4 top-2.5 text-sm text-[#60758a]">năm</span>
                                            </div>
                                        </div>

                                        <!-- Bio -->
                                        <div class="space-y-1.5">
                                            <label class="text-[#111418] dark:text-white text-sm font-medium"
                                                for="bio">Giới thiệu ngắn gọn / CV URL *</label>
                                            <textarea
                                                class="form-input block w-full rounded-lg border border-[#dbe0e6] dark:border-[#3e4c59] bg-white dark:bg-[#101922] min-h-[100px] p-4 text-[#111418] dark:text-white placeholder:text-[#60758a] focus:border-primary focus:ring-1 focus:ring-primary transition-all shadow-sm resize-none"
                                                id="bio" name="bio"
                                                placeholder="Mô tả kỹ năng, lĩnh vực thế mạnh hoặc dán link Portfolio/CV của bạn..."
                                                required></textarea>
                                        </div>

                                        <!-- Terms -->
                                        <div class="flex items-start gap-3 py-2">
                                            <div class="flex items-center h-5">
                                                <input
                                                    class="checkbox-primary form-checkbox rounded text-primary focus:ring-primary border-[#dbe0e6] dark:border-[#3e4c59] bg-white dark:bg-[#101922] w-4 h-4 mt-0.5"
                                                    id="terms" type="checkbox" required />
                                            </div>
                                            <label
                                                class="text-sm text-[#60758a] dark:text-[#9aa0a6] select-none leading-5"
                                                for="terms">
                                                Tôi cam kết thông tin trên là chính xác và đồng ý với <a
                                                    class="text-primary hover:text-primary/80" href="#">Quy định cộng
                                                    tác</a> của tòa soạn.
                                            </label>
                                        </div>

                                        <button
                                            class="w-full h-12 bg-primary hover:bg-primary/90 text-white font-semibold rounded-lg transition-all shadow-md flex items-center justify-center gap-2 mt-2 group"
                                            type="submit">
                                            Gửi đơn đăng ký
                                            <span
                                                class="material-symbols-outlined text-[20px] group-hover:translate-x-1 transition-transform">send</span>
                                        </button>
                                    </form>

                                    <div class="pt-4 border-t border-[#dbe0e6] dark:border-[#3e4c59]">
                                        <p class="text-center text-[#60758a] dark:text-[#9aa0a6] text-sm">
                                            Hoặc bạn đã có tài khoản?
                                            <a class="text-primary font-semibold hover:underline"
                                                href="${pageContext.request.contextPath}/auth/login.jsp">Đăng nhập</a>
                                        </p>
                                    </div>
                </div>
            </div>
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

            function updateStrength() {
                const pw = document.getElementById('password').value;
                const bars = [document.getElementById('bar1'), document.getElementById('bar2'),
                document.getElementById('bar3'), document.getElementById('bar4')];
                // Reuse score logic if needed, but simplified here for brevirty
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