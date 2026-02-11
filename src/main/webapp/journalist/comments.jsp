<!DOCTYPE html>
<html class="dark" lang="en">

<head>
    <jsp:include page="components/head.jsp" />
    <title>Journalist Comment Management UI</title>
</head>

<body class="bg-background-light dark:bg-background-dark text-slate-900 dark:text-slate-100 min-h-screen">
    <div class="flex h-screen overflow-hidden">
        <jsp:include page="components/sidebar.jsp">
            <jsp:param name="activePage" value="comments" />
        </jsp:include>
        <main class="flex-1 flex flex-col min-w-0 bg-background-light dark:bg-background-dark">
            <header
                class="h-16 bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-border-dark flex items-center justify-between px-8 shrink-0 z-20">
                <div class="flex items-center gap-6">
                    <h2 class="text-lg font-bold tracking-tight">Comment Management</h2>
                    <div class="hidden md:flex items-center gap-2 text-xs text-slate-500 font-medium">
                        <span>Journalist Portal</span>
                        <span class="material-symbols-outlined text-sm">chevron_right</span>
                        <span class="text-slate-900 dark:text-slate-200">Moderation</span>
                    </div>
                </div>
                <div class="flex items-center gap-3">
                    <div class="relative group">
                        <span
                            class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-lg">search</span>
                        <input
                            class="bg-slate-100 dark:bg-slate-800 border-none rounded-lg py-1.5 pl-10 pr-4 w-64 focus:ring-2 focus:ring-primary text-xs transition-all"
                            placeholder="Search comments by keyword..." type="text" />
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
                <div class="p-8 max-w-5xl mx-auto space-y-6">
                    <div class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 pb-2">
                        <div>
                            <h3 class="text-xl font-bold">Activity Feed</h3>
                            <p class="text-slate-500 dark:text-slate-400 text-xs mt-1">Reviewing 482 total comments from
                                your readers</p>
                        </div>
                        <div class="flex items-center gap-2">
                            <button
                                class="flex items-center gap-2 px-3 py-2 bg-white dark:bg-slate-800 border border-slate-200 dark:border-border-dark hover:border-primary/50 rounded-lg text-xs font-semibold transition-all shadow-sm">
                                <span class="material-symbols-outlined text-sm">filter_list</span>
                                Sort: Newest
                            </button>
                            <button
                                class="flex items-center gap-2 px-4 py-2 bg-primary hover:bg-primary/90 text-white rounded-lg text-xs font-semibold transition-all shadow-sm">
                                <span class="material-symbols-outlined text-sm">download</span>
                                Export Data
                            </button>
                        </div>
                    </div>
                    <div class="grid gap-4">
                        <div
                            class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm hover:shadow-md transition-shadow overflow-hidden">
                            <div class="p-5">
                                <div class="flex justify-between items-start gap-4 mb-4">
                                    <div class="flex items-start gap-3">
                                        <div
                                            class="size-10 rounded-full bg-blue-100 dark:bg-blue-900/40 flex items-center justify-center text-blue-600 dark:text-blue-400 font-bold shrink-0">
                                            JS
                                        </div>
                                        <div class="min-w-0">
                                            <div class="flex items-center flex-wrap gap-x-2">
                                                <h5 class="text-sm font-bold text-slate-900 dark:text-white">Julian
                                                    Sterling</h5>
                                                <span class="text-[11px] text-slate-400 font-medium tracking-tight">2
                                                    hours ago</span>
                                            </div>
                                            <div
                                                class="flex items-center gap-1.5 text-xs text-primary font-semibold mt-0.5 truncate">
                                                <span class="material-symbols-outlined text-[14px]">article</span>
                                                The Future of AI in Modern News Reporting
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        class="badge-base bg-emerald-100 text-emerald-700 dark:bg-emerald-500/10 dark:text-emerald-400 ring-1 ring-inset ring-emerald-500/20">
                                        <span class="size-1.5 rounded-full bg-emerald-500"></span>
                                        Positive
                                    </div>
                                </div>
                                <p class="text-slate-600 dark:text-slate-300 text-sm leading-relaxed mb-5 pl-[52px]">
                                    This is a brilliant breakdown of how LLMs are augmenting journalist workflows rather
                                    than replacing them. The section on "automated fact-checking" was particularly
                                    insightful. Great work, Alex!
                                </p>
                                <div
                                    class="flex items-center justify-between pt-4 border-t border-slate-100 dark:border-border-dark pl-[52px]">
                                    <div class="flex items-center gap-4">
                                        <button
                                            class="flex items-center gap-1.5 text-slate-500 hover:text-primary transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">reply</span> Reply
                                        </button>
                                        <button
                                            class="flex items-center gap-1.5 text-slate-500 hover:text-orange-500 transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">block</span> Spam
                                        </button>
                                        <button
                                            class="flex items-center gap-1.5 text-slate-500 hover:text-slate-900 dark:hover:text-white transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">visibility_off</span> Hide
                                        </button>
                                    </div>
                                    <button class="text-slate-400 hover:text-slate-600 dark:hover:text-slate-300">
                                        <span class="material-symbols-outlined">more_horiz</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div
                            class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm hover:shadow-md transition-shadow overflow-hidden">
                            <div class="p-5">
                                <div class="flex justify-between items-start gap-4 mb-4">
                                    <div class="flex items-start gap-3">
                                        <div
                                            class="size-10 rounded-full bg-orange-100 dark:bg-orange-900/40 flex items-center justify-center text-orange-600 dark:text-orange-400 font-bold shrink-0">
                                            MK
                                        </div>
                                        <div class="min-w-0">
                                            <div class="flex items-center flex-wrap gap-x-2">
                                                <h5 class="text-sm font-bold text-slate-900 dark:text-white">Marcus Kane
                                                </h5>
                                                <span class="text-[11px] text-slate-400 font-medium tracking-tight">5
                                                    hours ago</span>
                                            </div>
                                            <div
                                                class="flex items-center gap-1.5 text-xs text-primary font-semibold mt-0.5 truncate">
                                                <span class="material-symbols-outlined text-[14px]">article</span>
                                                Cybersecurity in the Age of Quantum Computing
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        class="badge-base bg-amber-100 text-amber-700 dark:bg-amber-500/10 dark:text-amber-400 ring-1 ring-inset ring-amber-500/20">
                                        <span class="size-1.5 rounded-full bg-amber-500"></span>
                                        Critical
                                    </div>
                                </div>
                                <p class="text-slate-600 dark:text-slate-300 text-sm leading-relaxed mb-5 pl-[52px]">
                                    I think you're overestimating the timeline for Shors algorithm becoming commercially
                                    viable. Most experts suggest we are still 10-15 years away, but you're implying it's
                                    an immediate threat to current RSA.
                                </p>
                                <div
                                    class="flex items-center justify-between pt-4 border-t border-slate-100 dark:border-border-dark pl-[52px]">
                                    <div class="flex items-center gap-4">
                                        <button
                                            class="flex items-center gap-1.5 text-slate-500 hover:text-primary transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">reply</span> Reply
                                        </button>
                                        <button
                                            class="flex items-center gap-1.5 text-slate-500 hover:text-orange-500 transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">block</span> Spam
                                        </button>
                                        <button
                                            class="flex items-center gap-1.5 text-slate-500 hover:text-slate-900 dark:hover:text-white transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">visibility_off</span> Hide
                                        </button>
                                    </div>
                                    <button class="text-slate-400 hover:text-slate-600 dark:hover:text-slate-300">
                                        <span class="material-symbols-outlined">more_horiz</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div
                            class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm hover:shadow-md transition-shadow overflow-hidden">
                            <div class="p-5">
                                <div class="flex justify-between items-start gap-4 mb-4">
                                    <div class="flex items-start gap-3">
                                        <div
                                            class="size-10 rounded-full bg-slate-100 dark:bg-slate-800 flex items-center justify-center text-slate-600 dark:text-slate-400 font-bold shrink-0">
                                            EL
                                        </div>
                                        <div class="min-w-0">
                                            <div class="flex items-center flex-wrap gap-x-2">
                                                <h5 class="text-sm font-bold text-slate-900 dark:text-white">Elena Lopez
                                                </h5>
                                                <span class="text-[11px] text-slate-400 font-medium tracking-tight">1
                                                    day ago</span>
                                            </div>
                                            <div
                                                class="flex items-center gap-1.5 text-xs text-primary font-semibold mt-0.5 truncate">
                                                <span class="material-symbols-outlined text-[14px]">article</span>
                                                The Future of AI in Modern News Reporting
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        class="badge-base bg-slate-100 text-slate-600 dark:bg-slate-500/10 dark:text-slate-400 ring-1 ring-inset ring-slate-500/20">
                                        <span class="size-1.5 rounded-full bg-slate-400"></span>
                                        Neutral
                                    </div>
                                </div>
                                <p class="text-slate-600 dark:text-slate-300 text-sm leading-relaxed mb-5 pl-[52px]">
                                    Will there be a follow-up article focusing specifically on local newsrooms? They
                                    have much smaller budgets for these types of tools.
                                </p>
                                <div
                                    class="flex items-center justify-between pt-4 border-t border-slate-100 dark:border-border-dark pl-[52px]">
                                    <div class="flex items-center gap-4">
                                        <button
                                            class="flex items-center gap-1.5 text-slate-500 hover:text-primary transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">reply</span> Reply
                                        </button>
                                        <button
                                            class="flex items-center gap-1.5 text-slate-500 hover:text-orange-500 transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">block</span> Spam
                                        </button>
                                        <button
                                            class="flex items-center gap-1.5 text-slate-500 hover:text-slate-900 dark:hover:text-white transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">visibility_off</span> Hide
                                        </button>
                                    </div>
                                    <button class="text-slate-400 hover:text-slate-600 dark:hover:text-slate-300">
                                        <span class="material-symbols-outlined">more_horiz</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div
                            class="bg-slate-50/80 dark:bg-slate-900/40 rounded-xl border border-dashed border-red-200 dark:border-red-900/30 shadow-none transition-shadow overflow-hidden opacity-90">
                            <div class="p-5">
                                <div class="flex justify-between items-start gap-4 mb-4">
                                    <div class="flex items-start gap-3">
                                        <div
                                            class="size-10 rounded-full bg-red-100 dark:bg-red-900/40 flex items-center justify-center text-red-600 dark:text-red-400 font-bold shrink-0">
                                            B9
                                        </div>
                                        <div class="min-w-0">
                                            <div class="flex items-center flex-wrap gap-x-2">
                                                <h5 class="text-sm font-bold text-slate-900 dark:text-white">
                                                    Bot_Account_99</h5>
                                                <span class="text-[11px] text-slate-400 font-medium tracking-tight">2
                                                    days ago</span>
                                            </div>
                                            <div
                                                class="flex items-center gap-1.5 text-xs text-primary/70 font-semibold mt-0.5 truncate italic">
                                                <span class="material-symbols-outlined text-[14px]">article</span>
                                                The Rise of Low-Code Platforms
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        class="badge-base bg-red-100 text-red-700 dark:bg-red-500/10 dark:text-red-400 ring-1 ring-inset ring-red-500/20">
                                        <span class="size-1.5 rounded-full bg-red-500"></span>
                                        Spam
                                    </div>
                                </div>
                                <p
                                    class="text-slate-500 dark:text-slate-400 text-sm leading-relaxed mb-5 pl-[52px] italic">
                                    "Check out our new crypto token to earn money while reading news! Click here:
                                    http://bit.ly/spam-link-example"
                                </p>
                                <div
                                    class="flex items-center justify-between pt-4 border-t border-slate-100 dark:border-border-dark pl-[52px]">
                                    <div class="flex items-center gap-4">
                                        <button
                                            class="flex items-center gap-1.5 text-red-500 hover:text-red-600 transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">delete_forever</span> Delete
                                        </button>
                                        <button
                                            class="flex items-center gap-1.5 text-slate-500 hover:text-slate-900 dark:hover:text-white transition-colors text-[11px] font-bold uppercase tracking-wider">
                                            <span class="material-symbols-outlined text-lg">undo</span> Restore
                                        </button>
                                    </div>
                                    <button class="text-slate-400 hover:text-slate-600 dark:hover:text-slate-300">
                                        <span class="material-symbols-outlined">more_horiz</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div
                        class="flex items-center justify-between py-6 border-t border-slate-200 dark:border-border-dark">
                        <p class="text-xs font-medium text-slate-500 dark:text-slate-400">
                            Displaying <span class="text-slate-900 dark:text-white">1-10</span> of 482 comments
                        </p>
                        <div class="flex items-center gap-1.5">
                            <button
                                class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800 disabled:opacity-40 transition-all text-xs font-semibold"
                                disabled="">
                                Previous
                            </button>
                            <button
                                class="px-3 py-1.5 rounded-md border border-slate-200 dark:border-border-dark hover:bg-slate-50 dark:hover:bg-slate-800 transition-all text-xs font-semibold">
                                Next
                            </button>
                        </div>
                    </div>
                </div>
        </main>
    </div>

</body>

</html>