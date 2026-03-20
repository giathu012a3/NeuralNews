<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:if test="${empty listCategory}">
    <% 
        neuralnews.dao.CategoryDao footerCatDao = new neuralnews.dao.CategoryDao();
        request.setAttribute("listCategory", footerCatDao.getAllCategory());
    %>
</c:if>

<footer class="mt-8 border-t border-slate-100 dark:border-slate-800 bg-white dark:bg-background-dark py-8 px-6">
    <div class="max-w-[1440px] mx-auto grid grid-cols-1 lg:grid-cols-12 gap-8 items-start">
        <!-- Logo & Giới thiệu -->
        <div class="lg:col-span-3">
            <a class="flex items-center gap-2 mb-4 group" href="${pageContext.request.contextPath}/home">
                <div class="size-8 rounded-lg bg-primary text-white flex items-center justify-center shadow-lg shadow-primary/20">
                    <span class="material-symbols-outlined text-lg">newsmode</span>
                </div>
                <span class="text-xl font-black dark:text-white tracking-tight">Nexus<span class="text-primary">AI</span></span>
            </a>
            <p class="text-[13px] text-slate-500 dark:text-slate-400 leading-relaxed max-w-[240px]">
                Kiến tạo tương lai báo chí số bằng sức mạnh của AI. Đưa tin tức trung thực và nhanh chóng đến mọi người.
            </p>
        </div>

        <!-- Chuyên mục -->
        <div class="lg:col-span-3">
            <h4 class="text-[11px] font-bold text-slate-400 dark:text-slate-500 uppercase tracking-widest mb-4 flex items-center gap-2">
                <span class="material-symbols-outlined text-sm">dashboard</span>
                Chuyên mục
            </h4>
            <div class="grid grid-cols-2 gap-x-4 gap-y-2">
                <c:forEach var="cat" items="${listCategory}">
                    <a class="text-[13px] text-slate-600 dark:text-slate-400 hover:text-primary transition-colors flex items-center gap-1.5 group" 
                       href="${pageContext.request.contextPath}/home?id=${cat.id}">
                        <div class="size-1 bg-slate-200 dark:bg-slate-700 rounded-full group-hover:bg-primary transition-all"></div>
                        ${cat.name}
                    </a>
                </c:forEach>
            </div>
        </div>

        <!-- Nhóm phát triển (Đẩy lên đây) -->
        <div class="lg:col-span-6">
            <h4 class="text-[11px] font-bold text-slate-400 dark:text-slate-500 uppercase tracking-widest mb-4 flex items-center gap-2">
                <span class="material-symbols-outlined text-sm">engineering</span>
                Nhóm phát triển hệ thống
            </h4>
            <div class="grid grid-cols-1 sm:grid-cols-2 gap-3">
                <!-- Member 1 -->
                <div class="flex items-center gap-3 p-2 rounded-xl bg-slate-50 dark:bg-slate-800/50 border border-slate-100 dark:border-slate-700/50">
                    <div class="size-8 rounded-lg bg-blue-500/10 text-blue-500 flex items-center justify-center font-bold text-xs">NT</div>
                    <div>
                        <p class="text-[13px] font-bold text-slate-900 dark:text-white leading-none">Nguyễn Mạnh Tiến</p>
                        <p class="text-[10px] text-slate-500 mt-1">ID: 25810043</p>
                    </div>
                </div>
                <!-- Member 2 -->
                <div class="flex items-center gap-3 p-2 rounded-xl bg-slate-50 dark:bg-slate-800/50 border border-slate-100 dark:border-slate-700/50">
                    <div class="size-8 rounded-lg bg-emerald-500/10 text-emerald-500 flex items-center justify-center font-bold text-xs">GT</div>
                    <div>
                        <p class="text-[13px] font-bold text-slate-900 dark:text-white leading-none">Nguyễn Gia Thụ</p>
                        <p class="text-[10px] text-slate-500 mt-1">ID: 25810041</p>
                    </div>
                </div>
                <!-- Member 3 -->
                <div class="flex items-center gap-3 p-2 rounded-xl bg-slate-50 dark:bg-slate-800/50 border border-slate-100 dark:border-slate-700/50">
                    <div class="size-8 rounded-lg bg-amber-500/10 text-amber-500 flex items-center justify-center font-bold text-xs">DT</div>
                    <div>
                        <p class="text-[13px] font-bold text-slate-900 dark:text-white leading-none">Đoàn Minh Thinh</p>
                        <p class="text-[10px] text-slate-500 mt-1">ID: 25810040</p>
                    </div>
                </div>
                <!-- Member 4 -->
                <div class="flex items-center gap-3 p-2 rounded-xl bg-slate-50 dark:bg-slate-800/50 border border-slate-100 dark:border-slate-700/50">
                    <div class="size-8 rounded-lg bg-rose-500/10 text-rose-500 flex items-center justify-center font-bold text-xs">MD</div>
                    <div>
                        <p class="text-[13px] font-bold text-slate-900 dark:text-white leading-none">Hồ Huỳnh Mỹ Duyên</p>
                        <p class="text-[10px] text-slate-500 mt-1">ID: 25610002</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bottom Bar -->
    <div class="max-w-[1440px] mx-auto mt-8 pt-6 border-t border-slate-100 dark:border-slate-800 flex flex-col md:flex-row justify-between items-center gap-4">
        <p class="text-[11px] text-slate-400">© 2024 - 2026 NexusAI. All rights reserved.</p>
        <div class="flex items-center gap-1 text-[11px] text-slate-400">
            <span>Made with</span>
            <span class="text-red-500 animate-pulse text-xs">❤️</span>
            <span>by Team Engineers</span>
        </div>
    </div>
</footer>

<script>
    document.querySelectorAll('.profile-dropdown-container').forEach(container => {
        const btn = container.querySelector('.size-10');
        const dropdown = container.querySelector('.profile-dropdown');
        btn.addEventListener('click', (e) => {
            e.stopPropagation();
            dropdown.classList.toggle('hidden');
        });
        document.addEventListener('click', (e) => {
            if (!container.contains(e.target)) dropdown.classList.add('hidden');
        });
    });
</script>