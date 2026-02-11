<!DOCTYPE html>
<html class="dark" lang="en">

<head>
    <jsp:include page="components/head.jsp" />
    <title>My Articles Management Library - Newsroom</title>
</head>

<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen">
    <div class="flex h-screen overflow-hidden">
        <jsp:include page="components/sidebar.jsp">
            <jsp:param name="activePage" value="articles" />
        </jsp:include>
        <main class="flex-1 flex flex-col min-w-0 bg-background-light dark:bg-background-dark">
            <header
                class="h-16 bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-border-dark flex items-center justify-between px-8 shrink-0 z-20">
                <div class="flex items-center gap-6">
                    <h2 class="text-lg font-bold tracking-tight">Articles Library</h2>
                    <div class="hidden md:flex items-center gap-2 text-xs text-slate-500 font-medium">
                        <span>Journalist Portal</span>
                        <span class="material-symbols-outlined text-sm">chevron_right</span>
                        <span class="text-slate-900 dark:text-slate-200">Management</span>
                    </div>
                </div>
                <div class="flex items-center gap-3">
                    <div class="relative group">
                        <span
                            class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-lg">search</span>
                        <input
                            class="bg-slate-100 dark:bg-slate-800 border-none rounded-lg py-1.5 pl-10 pr-4 w-64 focus:ring-2 focus:ring-primary text-xs transition-all"
                            placeholder="Search articles by title or tag..." type="text" />
                    </div>
                    <div class="h-6 w-px bg-slate-200 dark:border-border-dark mx-1"></div>
                    <button
                        class="relative p-2 rounded-lg hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors text-slate-500">
                        <span class="material-symbols-outlined">notifications</span>
                        <span
                            class="absolute top-2.5 right-2.5 size-2 bg-red-500 rounded-full border-2 border-white dark:border-slate-900"></span>
                    </button>
                    <button
                        class="p-2 rounded-lg hover:bg-slate-100 dark:hover:bg-slate-800 transition-colors text-slate-500">
                        <span class="material-symbols-outlined">light_mode</span>
                    </button>
                </div>
            </header>
            <div class="flex-1 overflow-y-auto">
                <div class="p-8 max-w-[1200px] mx-auto space-y-6">
                    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-2">
                        <div>
                            <h3 class="text-xl font-bold">My Articles</h3>
                            <p class="text-slate-500 dark:text-slate-400 text-xs mt-1">Managing 124 articles written for
                                the Nexus Portal</p>
                        </div>
                        <div class="flex items-center gap-3">
                            <button
                                class="flex items-center gap-2 px-3 py-2 bg-white dark:bg-slate-800 border border-slate-200 dark:border-border-dark hover:border-primary/50 rounded-lg text-xs font-semibold transition-all shadow-sm">
                                <span class="material-symbols-outlined text-sm">tune</span>
                                Advanced Filters
                            </button>
                            <a href="${pageContext.request.contextPath}/journalist/create_article.jsp"
                                class="flex items-center gap-2 px-4 py-2 bg-primary hover:bg-primary/90 text-white rounded-lg text-xs font-semibold transition-all shadow-sm">
                                <span class="material-symbols-outlined text-sm">add</span>
                                Create New Article
                            </a>
                        </div>
                    </div>
                    <div
                        class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm overflow-hidden">
                        <div class="overflow-x-auto">
                            <table class="w-full border-collapse">
                                <thead>
                                    <tr>
                                        <th class="table-header w-1/2">Article Title</th>
                                        <th class="table-header">Status</th>
                                        <th class="table-header">Views</th>
                                        <th class="table-header">Date</th>
                                        <th class="table-header text-right">Actions</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-slate-100 dark:divide-border-dark/30">
                                    <tr class="hover:bg-slate-50/50 dark:hover:bg-slate-800/30 transition-colors">
                                        <td class="table-cell">
                                            <div class="flex items-center gap-3">
                                                <div
                                                    class="size-12 rounded-lg bg-slate-200 dark:bg-slate-800 overflow-hidden shrink-0">
                                                    <img alt="Article Thumbnail"
                                                        class="size-full object-cover opacity-80"
                                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuDv7_zQY6hKHubY11GE7c-fH7AS3uz4TZ2UXutFm2jUlWhMuU9Nfgv6lmsIUOVUKbh7XVNI699T3klTof_V7hhKc5jxEokzdtqULxXjLBe3kfluz7_YChleKF9ZVL7KfsjI0_jXy0-mhpXmMZVZnQXzdq8kLeDjUEW0nmDNyLsFcilcON0w4gKtXuktZqIadYUzNtUJc_qmDWG3zMD49_88JsqFjKN25D08cu_6wk4HS6eVRSFKhrSI8rteOrmqlfpwOwM-ssWjZItt" />
                                                </div>
                                                <div class="min-w-0">
                                                    <p class="font-bold text-slate-900 dark:text-white truncate">The
                                                        Future of AI in Modern News Reporting</p>
                                                    <p class="text-[11px] text-slate-400 font-medium">Technology • 8 min
                                                        read</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="table-cell">
                                            <div
                                                class="badge-base bg-emerald-100 text-emerald-700 dark:bg-emerald-500/10 dark:text-emerald-400 ring-1 ring-inset ring-emerald-500/20 w-fit">
                                                <span class="size-1.5 rounded-full bg-emerald-500"></span>
                                                Published
                                            </div>
                                        </td>
                                        <td class="table-cell font-medium">12.4k</td>
                                        <td class="table-cell text-slate-500 text-xs">Oct 24, 2023</td>
                                        <td class="table-cell">
                                            <div class="flex items-center justify-end gap-1">
                                                <button
                                                    class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-400 hover:text-primary transition-colors"
                                                    title="Edit">
                                                    <span class="material-symbols-outlined text-xl">edit</span>
                                                </button>
                                                <button
                                                    class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-400 hover:text-slate-200 transition-colors"
                                                    title="Preview">
                                                    <span class="material-symbols-outlined text-xl">visibility</span>
                                                </button>
                                                <button
                                                    class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-400 hover:text-emerald-500 transition-colors"
                                                    title="Analytics">
                                                    <span class="material-symbols-outlined text-xl">insights</span>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="hover:bg-slate-50/50 dark:hover:bg-slate-800/30 transition-colors">
                                        <td class="table-cell">
                                            <div class="flex items-center gap-3">
                                                <div
                                                    class="size-12 rounded-lg bg-slate-200 dark:bg-slate-800 overflow-hidden shrink-0">
                                                    <img alt="Article Thumbnail"
                                                        class="size-full object-cover opacity-80"
                                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuBo0Bl0KenohhaR4NsYJIt71E5Ggta9gVPwCXFouR4FylO5MsS_BQV4RjZHmnn4Y2Bt_y-HPaNo2jLi2KPqLxyRUb-nl4Ki69-AJmlbIN3xjoCj7ZfymYhSiL-BihGvUnhJioCJFz9VYATCDTyT3wReFX_Qho8oDSb5xV-lMhiDd9kjbCfJaCletbsqWgEbidOFQckQvXdFTfeuX8vh_JNnS1Gt3R4uNr83uqPdcT9XQVHsM45RXjVHfdZB2O7rW35Bh7PVUZk78PEm" />
                                                </div>
                                                <div class="min-w-0">
                                                    <p class="font-bold text-slate-900 dark:text-white truncate">
                                                        Cybersecurity in the Age of Quantum Computing</p>
                                                    <p class="text-[11px] text-slate-400 font-medium">Security • 12 min
                                                        read</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="table-cell">
                                            <div
                                                class="badge-base bg-amber-100 text-amber-700 dark:bg-amber-500/10 dark:text-amber-400 ring-1 ring-inset ring-amber-500/20 w-fit">
                                                <span class="size-1.5 rounded-full bg-amber-500"></span>
                                                Pending
                                            </div>
                                        </td>
                                        <td class="table-cell font-medium">--</td>
                                        <td class="table-cell text-slate-500 text-xs">Oct 26, 2023</td>
                                        <td class="table-cell">
                                            <div class="flex items-center justify-end gap-1">
                                                <button
                                                    class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-400 hover:text-primary transition-colors"
                                                    title="Edit">
                                                    <span class="material-symbols-outlined text-xl">edit</span>
                                                </button>
                                                <button
                                                    class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-400 hover:text-slate-200 transition-colors"
                                                    title="Preview">
                                                    <span class="material-symbols-outlined text-xl">visibility</span>
                                                </button>
                                                <button
                                                    class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-400 hover:text-emerald-500 transition-colors"
                                                    title="Analytics">
                                                    <span class="material-symbols-outlined text-xl">insights</span>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="hover:bg-slate-50/50 dark:hover:bg-slate-800/30 transition-colors">
                                        <td class="table-cell">
                                            <div class="flex items-center gap-3">
                                                <div
                                                    class="size-12 rounded-lg bg-slate-200 dark:bg-slate-800 overflow-hidden shrink-0">
                                                    <img alt="Article Thumbnail"
                                                        class="size-full object-cover opacity-80"
                                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuDYnlCUCW-2kzU0THl_Yk3-7tb-1hzdGPHiuZVcwKTIfHAuC1A9oBU-L-bm7O56lj1QHclFjaa8-LKPSLrNlbIldu0OHo_bbnUFg-hGc4zBBX-j5qMcHmPsYDW8sRFzJ4n7UFo9sLjd5ByhQ-v02sy1IVUbqqUPzLSVV0FEzOEhhefAV14zu4NEJDY3Dxrsx4ocDbrhS8hooNjUX_zvJ9Hb0oLHozNhOslnCI1JCTtK78KCpksRwM-DrGauoXbOo9BYGVxOWJRfjWkN" />
                                                </div>
                                                <div class="min-w-0">
                                                    <p class="font-bold text-slate-900 dark:text-white truncate">The
                                                        Rise of Low-Code Platforms for Enterprise</p>
                                                    <p class="text-[11px] text-slate-400 font-medium">DevOps • 6 min
                                                        read</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="table-cell">
                                            <div
                                                class="badge-base bg-slate-100 text-slate-600 dark:bg-slate-500/10 dark:text-slate-400 ring-1 ring-inset ring-slate-500/20 w-fit">
                                                <span class="size-1.5 rounded-full bg-slate-400"></span>
                                                Draft
                                            </div>
                                        </td>
                                        <td class="table-cell font-medium">--</td>
                                        <td class="table-cell text-slate-500 text-xs">Oct 27, 2023</td>
                                        <td class="table-cell">
                                            <div class="flex items-center justify-end gap-1">
                                                <button
                                                    class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-400 hover:text-primary transition-colors"
                                                    title="Edit">
                                                    <span class="material-symbols-outlined text-xl">edit</span>
                                                </button>
                                                <button
                                                    class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-400 hover:text-slate-200 transition-colors"
                                                    title="Preview">
                                                    <span class="material-symbols-outlined text-xl">visibility</span>
                                                </button>
                                                <button
                                                    class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-400 hover:text-emerald-500 transition-colors"
                                                    title="Analytics">
                                                    <span class="material-symbols-outlined text-xl">insights</span>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr class="hover:bg-slate-50/50 dark:hover:bg-slate-800/30 transition-colors">
                                        <td class="table-cell">
                                            <div class="flex items-center gap-3">
                                                <div
                                                    class="size-12 rounded-lg bg-slate-200 dark:bg-slate-800 overflow-hidden shrink-0">
                                                    <img alt="Article Thumbnail"
                                                        class="size-full object-cover opacity-80"
                                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuC4iOlCLsgfGkQc6UuSJ6yqP-PZfMwb3CZBplPDPSLR18G0r6OKia49VvnMG_Xa0wWtrxkIdT8B_wp-sDVLM2Qy1r88-3yH1VicBYxLmOJkdLFMT5arxCu-2PfvuBAam4fJQK7uN9sCbRgIOVxPYUoiWLPU2lknwVOpxSkhUO79_VXzfhGen3zJLEQL7Uq_Sv_AS370uaIsuhAo5hFToNqzba3OEcxzKkByAst5vH4_N1HSClacTxlf_c79iwhYTXnIYEvFCtlo_2U8" />
                                                </div>
                                                <div class="min-w-0">
                                                    <p class="font-bold text-slate-900 dark:text-white truncate">Ethics
                                                        in AI: Where to Draw the Line</p>
                                                    <p class="text-[11px] text-slate-400 font-medium">Ethics • 15 min
                                                        read</p>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="table-cell">
                                            <div
                                                class="badge-base bg-emerald-100 text-emerald-700 dark:bg-emerald-500/10 dark:text-emerald-400 ring-1 ring-inset ring-emerald-500/20 w-fit">
                                                <span class="size-1.5 rounded-full bg-emerald-500"></span>
                                                Published
                                            </div>
                                        </td>
                                        <td class="table-cell font-medium">8.2k</td>
                                        <td class="table-cell text-slate-500 text-xs">Oct 20, 2023</td>
                                        <td class="table-cell">
                                            <div class="flex items-center justify-end gap-1">
                                                <button
                                                    class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-400 hover:text-primary transition-colors"
                                                    title="Edit">
                                                    <span class="material-symbols-outlined text-xl">edit</span>
                                                </button>
                                                <button
                                                    class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-400 hover:text-slate-200 transition-colors"
                                                    title="Preview">
                                                    <span class="material-symbols-outlined text-xl">visibility</span>
                                                </button>
                                                <button
                                                    class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg text-slate-400 hover:text-emerald-500 transition-colors"
                                                    title="Analytics">
                                                    <span class="material-symbols-outlined text-xl">insights</span>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div
                        class="flex items-center justify-between py-6 border-t border-slate-200 dark:border-border-dark">
                        <p class="text-xs font-medium text-slate-500 dark:text-slate-400">
                            Displaying <span class="text-slate-900 dark:text-white">1-10</span> of 124 articles
                        </p>
                        <div class="flex items-center gap-1.5">
                            <button
                                class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800 disabled:opacity-40 transition-all text-xs font-semibold"
                                disabled="">
                                Previous
                            </button>
                            <button
                                class="px-4 py-1.5 rounded-md bg-primary/10 text-primary text-xs font-bold">1</button>
                            <button
                                class="px-4 py-1.5 rounded-md hover:bg-slate-100 dark:hover:bg-slate-800 text-xs font-medium">2</button>
                            <button
                                class="px-4 py-1.5 rounded-md hover:bg-slate-100 dark:hover:bg-slate-800 text-xs font-medium">3</button>
                            <button
                                class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800 transition-all text-xs font-semibold">
                                Next
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

</body>

</html>