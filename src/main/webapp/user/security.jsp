<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html class="dark" lang="en">

    <head>
        <title>Cài đặt Bảo mật &amp; Quyền riêng tư - NexusAI</title>
        <jsp:include page="components/head.jsp" />
        <style>
            .scrollbar-hide::-webkit-scrollbar {
                display: none;
            }

            .scrollbar-hide {
                -ms-overflow-style: none;
                scrollbar-width: none;
            }
        </style>
    </head>

    <body
        class="bg-background-light dark:bg-background-dark text-text-main dark:text-white font-display antialiased overflow-x-hidden transition-colors duration-200">
        <div class="flex min-h-screen w-full flex-col">
            <jsp:include page="components/header.jsp" />

            <main class="flex-1 w-full max-w-[1440px] mx-auto p-4 lg:p-8 flex flex-col lg:flex-row gap-8">
                <jsp:include page="components/sidebar.jsp" />

                <div class="flex-1 flex flex-col gap-8">
                    <div class="flex flex-col gap-2">
                        <h2 class="text-2xl font-black text-slate-900 dark:text-white tracking-tight">Cài đặt Bảo mật
                            &amp; Quyền riêng tư</h2>
                        <p class="text-slate-500 dark:text-slate-400 text-sm">Quản lý bảo mật tài khoản, phiên đăng nhập
                            và
                            quyền riêng tư dữ liệu của bạn.</p>
                    </div>
                    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
                        <div
                            class="bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-xl p-6 space-y-6">
                            <div class="flex items-center gap-2 mb-2">
                                <span class="material-symbols-outlined text-primary">lock_reset</span>
                                <h3 class="font-bold text-slate-900 dark:text-white">Quản lý Mật khẩu</h3>
                            </div>
                            <form class="space-y-4">
                                <div class="space-y-1">
                                    <label
                                        class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Mật
                                        khẩu
                                        Hiện tại</label>
                                    <input
                                        class="w-full px-4 py-2.5 bg-slate-50 dark:bg-background-dark/50 border border-slate-200 dark:border-border-dark rounded-lg text-sm focus:ring-1 focus:ring-primary focus:border-primary transition-all outline-none"
                                        placeholder="••••••••" type="password" />
                                </div>
                                <div class="space-y-1">
                                    <label
                                        class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Mật
                                        khẩu
                                        Mới</label>
                                    <input
                                        class="w-full px-4 py-2.5 bg-slate-50 dark:bg-background-dark/50 border border-slate-200 dark:border-border-dark rounded-lg text-sm focus:ring-1 focus:ring-primary focus:border-primary transition-all outline-none"
                                        placeholder="••••••••" type="password" />
                                </div>
                                <div class="space-y-1">
                                    <label
                                        class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Xác
                                        nhận
                                        Mật khẩu Mới</label>
                                    <input
                                        class="w-full px-4 py-2.5 bg-slate-50 dark:bg-background-dark/50 border border-slate-200 dark:border-border-dark rounded-lg text-sm focus:ring-1 focus:ring-primary focus:border-primary transition-all outline-none"
                                        placeholder="••••••••" type="password" />
                                </div>
                                <button
                                    class="w-full py-2.5 bg-primary hover:bg-primary-dark text-white font-bold rounded-lg transition-colors text-sm shadow-md">
                                    Cập nhật Mật khẩu
                                </button>
                            </form>
                        </div>
                        <div
                            class="bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-xl p-6 space-y-6">
                            <div class="flex items-center justify-between">
                                <div class="flex items-center gap-2">
                                    <span class="material-symbols-outlined text-primary">verified_user</span>
                                    <h3 class="font-bold text-slate-900 dark:text-white">Xác thực Hai yếu tố</h3>
                                </div>
                                <label class="relative inline-flex items-center cursor-pointer">
                                    <input checked="" class="sr-only peer" type="checkbox" />
                                    <div
                                        class="w-11 h-6 bg-slate-200 dark:bg-slate-700 peer-focus:outline-none rounded-full peer peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-[2px] after:start-[2px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-5 after:w-5 after:transition-all peer-checked:bg-primary">
                                    </div>
                                </label>
                            </div>
                            <div
                                class="p-4 bg-blue-50/50 dark:bg-primary/5 border border-blue-100 dark:border-primary/20 rounded-lg">
                                <p class="text-sm font-semibold text-slate-900 dark:text-white mb-2">2FA hiện đang Hoạt
                                    động
                                </p>
                                <p class="text-xs text-slate-600 dark:text-slate-400 leading-relaxed">
                                    Xác thực hai yếu tố thêm một lớp bảo mật bổ sung cho tài khoản của bạn bằng cách yêu
                                    cầu
                                    nhiều hơn chỉ một mật khẩu để đăng nhập.
                                </p>
                            </div>
                            <div class="space-y-3">
                                <p
                                    class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">
                                    Hướng dẫn Cài đặt</p>
                                <ol class="text-xs text-slate-600 dark:text-slate-400 space-y-2 list-decimal ml-4">
                                    <li>Cài đặt ứng dụng xác thực (ví dụ: Google Authenticator)</li>
                                    <li>Quét mã QR được cung cấp trong cài đặt</li>
                                    <li>Nhập mã xác minh 6 chữ số để xác nhận</li>
                                </ol>
                            </div>
                            <button
                                class="w-full py-2.5 border border-slate-200 dark:border-border-dark text-slate-700 dark:text-slate-200 font-bold rounded-lg hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors text-sm">
                                Tạo lại Mã Dự phòng
                            </button>
                        </div>
                    </div>
                    <div
                        class="bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-xl overflow-hidden">
                        <div
                            class="p-6 border-b border-slate-200 dark:border-border-dark flex items-center justify-between">
                            <div class="flex items-center gap-2">
                                <span class="material-symbols-outlined text-primary">devices</span>
                                <h3 class="font-bold text-slate-900 dark:text-white">Phiên Hoạt động</h3>
                            </div>
                            <button class="text-xs font-bold text-red-500 hover:underline">Đăng xuất khỏi tất cả thiết
                                bị khác</button>
                        </div>
                        <div class="divide-y divide-slate-100 dark:divide-border-dark">
                            <div class="p-6 flex items-center justify-between">
                                <div class="flex items-center gap-4">
                                    <div
                                        class="size-10 bg-slate-100 dark:bg-background-dark/50 rounded-lg flex items-center justify-center text-slate-500">
                                        <span class="material-symbols-outlined">laptop_mac</span>
                                    </div>
                                    <div>
                                        <div class="flex items-center gap-2">
                                            <p class="text-sm font-bold text-slate-900 dark:text-white">MacBook Pro -
                                                Chrome
                                            </p>
                                            <span
                                                class="px-2 py-0.5 bg-green-500/10 text-green-500 text-[10px] font-bold rounded uppercase">Phiên
                                                Hiện tại</span>
                                        </div>
                                        <p class="text-xs text-slate-500">San Francisco, USA • 192.168.1.1</p>
                                    </div>
                                </div>
                                <span class="text-xs text-slate-400">Đang hoạt động</span>
                            </div>
                            <div class="p-6 flex items-center justify-between">
                                <div class="flex items-center gap-4">
                                    <div
                                        class="size-10 bg-slate-100 dark:bg-background-dark/50 rounded-lg flex items-center justify-center text-slate-500">
                                        <span class="material-symbols-outlined">smartphone</span>
                                    </div>
                                    <div>
                                        <p class="text-sm font-bold text-slate-900 dark:text-white">iPhone 15 - Mobile
                                            App
                                        </p>
                                        <p class="text-xs text-slate-500">London, UK • 84.21.102.3</p>
                                    </div>
                                </div>
                                <button class="p-2 text-slate-400 hover:text-red-500 transition-colors">
                                    <span class="material-symbols-outlined text-[20px]">logout</span>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div
                        class="bg-gradient-to-r from-slate-900 to-primary-dark border border-white/10 rounded-2xl p-8 relative overflow-hidden group">
                        <div
                            class="absolute top-0 right-0 p-12 opacity-10 pointer-events-none group-hover:scale-110 transition-transform duration-700">
                            <span class="material-symbols-outlined text-[160px]">edit_note</span>
                        </div>
                        <div class="relative z-10">
                            <div class="flex flex-col md:flex-row md:items-center justify-between gap-8">
                                <div class="max-w-xl">
                                    <span
                                        class="inline-flex items-center gap-1.5 px-3 py-1 bg-primary/20 backdrop-blur-md text-blue-400 text-[10px] font-bold uppercase tracking-widest rounded-full mb-4 border border-primary/30">
                                        <span class="material-symbols-outlined text-[14px]">stars</span>
                                        Chương trình Người sáng tạo Nexus
                                    </span>
                                    <h2 class="text-3xl md:text-4xl font-black text-white mb-4 tracking-tight">Trở thành
                                        Nhà báo Nexus</h2>
                                    <p class="text-lg text-blue-100/90 mb-2 font-medium">Tiếp cận hàng triệu độc giả với
                                        nền
                                        tảng tin tức thế hệ mới của chúng tôi.</p>
                                </div>
                                <div class="shrink-0 flex flex-col items-center gap-4">
                                    <button
                                        class="w-full md:w-auto px-10 py-4 bg-white text-primary-dark font-black text-lg rounded-xl shadow-xl shadow-black/20 hover:bg-cyan-500 hover:text-white hover:shadow-[0_0_20px_rgba(6,182,212,0.5)] hover:scale-105 active:scale-95 transition-all duration-300">
                                        Đăng ký ngay
                                    </button>
                                    <p class="text-xs text-blue-200/60 font-medium">Nộp đơn mất &lt; 5 phút</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="bg-red-500/5 border border-red-500/20 rounded-xl p-6">
                        <div class="flex flex-col md:flex-row md:items-center justify-between gap-6">
                            <div>
                                <h3 class="font-bold text-red-500 flex items-center gap-2 mb-1">
                                    <span class="material-symbols-outlined text-[20px]">warning</span>
                                    Hủy kích hoạt Tài khoản
                                </h3>
                                <p class="text-sm text-slate-600 dark:text-slate-400">Xóa vĩnh viễn tài khoản của bạn và
                                    tất cả dữ liệu liên quan. Hành động này không thể hoàn tác.</p>
                            </div>
                            <button
                                class="px-6 py-2.5 bg-red-500 hover:bg-red-600 text-white font-bold rounded-lg text-sm transition-colors shadow-lg shadow-red-500/20">
                                Hủy kích hoạt Tài khoản
                            </button>
                        </div>
                    </div>
                </div>
            </main>
            <jsp:include page="components/footer.jsp" />
        </div>

    </body>

    </html>