<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <aside class="w-full lg:w-64 shrink-0 flex flex-col gap-6">
        <div
            class="bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-xl p-6 text-center">
            <div class="relative inline-block mb-4">
                <div
                    class="size-20 rounded-full bg-slate-200 overflow-hidden border-4 border-white dark:border-slate-800 shadow-lg mx-auto">
                    <div class="size-full bg-cover bg-center"
                        style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCqHJoDOZXEs2I-dWg4cNlhnZWUAg-oBJGZBmq-PpFoJ50SV0NIa98rHAwe3bxy50vyDTw8NHXXjoiNAgpWnLDQFnXhwjbF1AjVEqM11aGgAOtWj5SSP8yDkoQK1AtowhO1u68BOZOlFIT9MNofGpAlZ3JqZTUDZnPnJXrW2cjFXP9ywq1Un_lnbETpHo9rOZaGlocLFlhstxpM83Zzw8q542F04tYAv4jhfi5wKUicr1qd6_Lz2OKuF66ucETPy-Se0VxXmBa0LSQo');">
                    </div>
                </div>
                <button
                    class="absolute bottom-0 right-0 size-7 bg-primary text-white rounded-full flex items-center justify-center border-2 border-white dark:border-surface-dark">
                    <span class="material-symbols-outlined text-sm">edit</span>
                </button>
            </div>
            <h2 class="text-lg font-bold text-slate-900 dark:text-white">Alex Johnson</h2>
            <p class="text-sm text-slate-500 dark:text-slate-400">Thành viên Độc giả</p>
        </div>
        <nav class="flex flex-col gap-1" id="sidebar-nav">
            <!-- Links will be styled by JS -->
            <a class="flex items-center gap-3 px-4 py-3 rounded-lg transition-colors sidebar-link"
                href="${pageContext.request.contextPath}/user/profile.jsp" data-page="profile.jsp">
                <span class="material-symbols-outlined">dashboard</span>
                Tổng quan hồ sơ
            </a>
            <a class="flex items-center gap-3 px-4 py-3 rounded-lg transition-colors sidebar-link"
                href="${pageContext.request.contextPath}/user/settings.jsp" data-page="settings.jsp">
                <span class="material-symbols-outlined">settings</span>
                Cài đặt tài khoản
            </a>
            <a class="flex items-center gap-3 px-4 py-3 rounded-lg transition-colors sidebar-link"
                href="${pageContext.request.contextPath}/user/security.jsp" data-page="security.jsp">
                <span class="material-symbols-outlined">shield</span>
                Bảo mật
            </a>
            <hr class="my-2 border-slate-200 dark:border-border-dark" />
            <a class="flex items-center gap-3 px-4 py-3 text-red-500 hover:bg-red-50/50 dark:hover:bg-red-500/5 rounded-lg transition-colors"
                href="${pageContext.request.contextPath}/auth/logout.jsp">
                <span class="material-symbols-outlined">logout</span>
                Đăng xuất
            </a>
        </nav>
    </aside>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const currentPath = window.location.pathname;
            const links = document.querySelectorAll('.sidebar-link');

            links.forEach(link => {
                const page = link.getAttribute('data-page');

                // Default style
                let active = false;

                if (currentPath.endsWith(page)) {
                    active = true;
                }

                if (active) {
                    link.classList.add('bg-primary', 'text-white', 'font-bold', 'shadow-lg', 'shadow-primary/20');
                    link.classList.remove('text-slate-600', 'dark:text-slate-400', 'hover:bg-slate-100', 'dark:hover:bg-surface-dark');
                } else {
                    link.classList.add('text-slate-600', 'dark:text-slate-400', 'hover:bg-slate-100', 'dark:hover:bg-surface-dark');
                    link.classList.remove('bg-primary', 'text-white', 'font-bold', 'shadow-lg', 'shadow-primary/20');
                }
            });
        });
    </script>