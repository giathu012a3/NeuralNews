<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <footer
        class="mt-12 border-t border-border-light dark:border-border-dark bg-surface-light dark:bg-background-dark py-12 px-6">
        <div class="max-w-[1440px] mx-auto grid grid-cols-2 md:grid-cols-4 lg:grid-cols-5 gap-8">
            <div class="col-span-2 lg:col-span-2">
                <a class="flex items-center gap-2 mb-4 group" href="${pageContext.request.contextPath}/user/home.jsp">
                    <div class="flex items-center justify-center size-8 rounded bg-primary text-white">
                        <span class="material-symbols-outlined text-[20px]">newsmode</span>
                    </div>
                    <span class="text-slate-900 dark:text-white text-xl font-bold">NexusAI</span>
                </a>
                <p class="text-slate-500 dark:text-slate-400 text-sm max-w-xs mb-6">
                    Kết nối báo chí nhân loại và trí tuệ nhân tạo. Tin tức đáng tin cậy cho kỷ nguyên số.
                </p>
                <div class="flex gap-4">
                    <a class="size-9 flex items-center justify-center rounded-full bg-white dark:bg-surface-dark border border-slate-200 dark:border-slate-700 text-slate-600 dark:text-slate-400 hover:text-primary hover:border-primary transition-colors shadow-sm"
                        href="#">
                        <span class="font-bold text-xs text-center">Tw</span>
                    </a>
                    <a class="size-9 flex items-center justify-center rounded-full bg-white dark:bg-surface-dark border border-slate-200 dark:border-slate-700 text-slate-600 dark:text-slate-400 hover:text-primary hover:border-primary transition-colors shadow-sm"
                        href="#">
                        <span class="font-bold text-xs text-center">Li</span>
                    </a>
                    <a class="size-9 flex items-center justify-center rounded-full bg-white dark:bg-surface-dark border border-slate-200 dark:border-slate-700 text-slate-600 dark:text-slate-400 hover:text-primary hover:border-primary transition-colors shadow-sm"
                        href="#">
                        <span class="font-bold text-xs text-center">Fb</span>
                    </a>
                </div>
            </div>
            <div>
                <h4 class="font-bold text-slate-900 dark:text-white mb-4">Chuyên mục</h4>
                <ul class="flex flex-col gap-2 text-sm text-slate-600 dark:text-slate-400">
                    <li><a class="hover:text-primary transition-colors" href="#">Chính trị</a></li>
                    <li><a class="hover:text-primary transition-colors" href="#">Đời sống &amp; Văn hóa</a></li>
                    <li><a class="hover:text-primary transition-colors" href="#">Công nghệ</a></li>
                    <li><a class="hover:text-primary transition-colors" href="#">Thể thao</a></li>
                </ul>
            </div>
            <div>
                <h4 class="font-bold text-slate-900 dark:text-white mb-4">Công ty</h4>
                <ul class="flex flex-col gap-2 text-sm text-slate-600 dark:text-slate-400">
                    <li><a class="hover:text-primary transition-colors" href="#">Về NexusAI</a></li>
                    <li><a class="hover:text-primary transition-colors" href="#">Tuyển dụng</a></li>
                    <li><a class="hover:text-primary transition-colors" href="#">Đội ngũ biên tập</a></li>
                    <li><a class="hover:text-primary transition-colors" href="#">Liên hệ</a></li>
                </ul>
            </div>
            <div>
                <h4 class="font-bold text-slate-900 dark:text-white mb-4">Hỗ trợ</h4>
                <ul class="flex flex-col gap-2 text-sm text-slate-600 dark:text-slate-400">
                    <li><a class="hover:text-primary transition-colors" href="#">Trung tâm trợ giúp</a></li>
                    <li><a class="hover:text-primary transition-colors" href="#">Chính sách bảo mật</a></li>
                    <li><a class="hover:text-primary transition-colors" href="#">Điều khoản dịch vụ</a></li>
                    <li><a class="hover:text-primary transition-colors" href="#">Sơ đồ trang web</a></li>
                </ul>
            </div>
        </div>
        <div
            class="max-w-[1440px] mx-auto mt-12 pt-8 border-t border-slate-200 dark:border-slate-800 flex flex-col md:flex-row justify-between items-center text-xs text-slate-400">
            <p>© 2024 NexusAI News. Mọi quyền được bảo lưu.</p>
            <div class="flex gap-4 mt-2 md:mt-0">
                <a class="hover:text-slate-600 dark:hover:text-slate-200" href="#">Bảo mật</a>
                <a class="hover:text-slate-600 dark:hover:text-slate-200" href="#">Điều khoản</a>
                <a class="hover:text-slate-600 dark:hover:text-slate-200" href="#">Cookies</a>
            </div>
        </div>
    </footer>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const dropdownContainers = document.querySelectorAll('.profile-dropdown-container');
            dropdownContainers.forEach(container => {
                container.addEventListener('click', (e) => {
                    e.stopPropagation();
                    const dropdown = container.querySelector('.profile-dropdown');
                    dropdown.classList.toggle('hidden');
                });
            });

            document.addEventListener('click', () => {
                document.querySelectorAll('.profile-dropdown').forEach(d => d.classList.add('hidden'));
            });
        });
    </script>