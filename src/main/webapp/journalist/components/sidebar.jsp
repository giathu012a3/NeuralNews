<aside class="w-64 bg-white dark:bg-slate-900 border-r border-slate-200 dark:border-border-dark flex flex-col shrink-0">
    <div class="p-6">
        <div class="flex items-center gap-3 mb-8">
            <a href="${pageContext.request.contextPath}/user/home.jsp" class="flex items-center gap-3 group">
                <div
                    class="bg-primary size-9 rounded-lg flex items-center justify-center text-white group-hover:bg-blue-600 transition-colors">
                    <span class="material-symbols-outlined text-xl">auto_stories</span>
                </div>
                <div>
                    <h1 class="text-sm font-bold leading-tight uppercase tracking-wider text-slate-900 dark:text-white">
                        Newsroom</h1>
                    <p class="text-slate-500 dark:text-slate-400 text-[10px] font-medium uppercase">AI Portal</p>
                </div>
            </a>
        </div>
        <nav class="space-y-1">
            <a class="${param.activePage == 'dashboard' ? 'sidebar-item-active' : 'text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors'} flex items-center gap-3 px-3 py-2.5 rounded-md text-sm font-medium"
                href="${pageContext.request.contextPath}/journalist/home.jsp">
                <span class="material-symbols-outlined text-xl">dashboard</span>
                <span>Dashboard</span>
            </a>
            <a class="${param.activePage == 'articles' ? 'sidebar-item-active' : 'text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors'} flex items-center gap-3 px-3 py-2.5 rounded-md text-sm font-medium"
                href="${pageContext.request.contextPath}/journalist/articles.jsp">
                <span class="material-symbols-outlined text-xl">description</span>
                <span>Articles</span>
            </a>
            <a class="${param.activePage == 'comments' ? 'sidebar-item-active' : 'text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors'} flex items-center gap-3 px-3 py-2.5 rounded-md text-sm font-medium"
                href="${pageContext.request.contextPath}/journalist/comments.jsp">
                <span class="material-symbols-outlined text-xl">chat_bubble</span>
                <span>Comments</span>
            </a>
            <a class="${param.activePage == 'analytics' ? 'sidebar-item-active' : 'text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors'} flex items-center gap-3 px-3 py-2.5 rounded-md text-sm font-medium"
                href="${pageContext.request.contextPath}/journalist/analytics.jsp">
                <span class="material-symbols-outlined text-xl">analytics</span>
                <span>Analytics</span>
            </a>
        </nav>

        <!-- Optional Filters Section passed as body content or handled per page if generic filters exist -->
        <!-- For now, simplifying to just nav, or include a placeholder if pages insert their own filters below nav -->

    </div>
    <div class="mt-auto p-4 border-t border-slate-200 dark:border-border-dark bg-slate-50/50 dark:bg-slate-900/50">
        <div class="flex items-center gap-3">
            <img alt="Alex Morgan" class="size-9 rounded-full object-cover ring-2 ring-slate-200 dark:ring-slate-700"
                src="https://lh3.googleusercontent.com/aida-public/AB6AXuCu5P-oe2o3J0xfxWv88PBTR1uz19l6jglgnhh6GRzByG4ylsxMB1GVFma_iBV1yYWlch0aHRuplqgZ8W30qvu0sVpaDffNqMxkvE6pNxjgwaDrYXAyHCEkhZVxm-22e_nBbywshWhPmiwUhpOU0xU7WAPajc8_byjVWY7seMDsynKUCM5RqSMaueCmACC31lVHHqTUUUOkdmdc4OZlliCDh07RRlq3Koas1uJdQrC26A5ikSDYEkHJNhG82L3yS3dPfUymldQLmYoJ" />
            <div class="flex-1 min-w-0">
                <p class="text-xs font-bold truncate">Alex Morgan</p>
                <p class="text-[10px] text-slate-500 truncate">Senior Editor</p>
            </div>
            <a href="${pageContext.request.contextPath}/user/settings.jsp"
                class="text-slate-400 hover:text-primary transition-colors">
                <span class="material-symbols-outlined text-xl">settings</span>
            </a>
            <a href="${pageContext.request.contextPath}/auth/logout.jsp"
                class="text-slate-400 hover:text-red-500 transition-colors ml-1" title="Sign Out">
                <span class="material-symbols-outlined text-xl">logout</span>
            </a>
        </div>
    </div>
</aside>