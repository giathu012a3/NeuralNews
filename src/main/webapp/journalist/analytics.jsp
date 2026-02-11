<!DOCTYPE html>
<html class="dark" lang="en">

<head>
    <jsp:include page="components/head.jsp" />
    <title>Advanced Analytics Data Center</title>
</head>

<body class="min-h-screen overflow-hidden">
    <div class="flex h-screen">
        <jsp:include page="components/sidebar.jsp">
            <jsp:param name="activePage" value="analytics" />
        </jsp:include>
        <main class="flex-1 flex flex-col min-w-0">
            <header
                class="h-16 bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-border-dark flex items-center justify-between px-8 shrink-0 z-20">
                <div class="flex items-center gap-6">
                    <h2 class="text-lg font-bold tracking-tight">Advanced Analytics Data Center</h2>
                    <div class="hidden md:flex items-center gap-2 text-xs text-slate-500 font-medium">
                        <span>Journalist Portal</span>
                        <span class="material-symbols-outlined text-sm">chevron_right</span>
                        <span class="text-slate-900 dark:text-slate-200">Data Center</span>
                    </div>
                </div>
                <div class="flex items-center gap-3">
                    <div class="relative group">
                        <span
                            class="material-symbols-outlined absolute left-3 top-1/2 -translate-y-1/2 text-slate-400 text-lg">search</span>
                        <input
                            class="bg-slate-100 dark:bg-slate-800 border-none rounded-lg py-1.5 pl-10 pr-4 w-64 focus:ring-2 focus:ring-primary text-xs transition-all"
                            placeholder="Search report metrics..." type="text" />
                    </div>
                    <div class="h-6 w-px bg-slate-200 dark:bg-slate-700 mx-1"></div>
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
            <div class="flex-1 overflow-y-auto bg-slate-50 dark:bg-background-dark/50">
                <div class="p-8 space-y-8 max-w-[1400px] mx-auto">
                    <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
                        <div
                            class="bg-white dark:bg-slate-900 p-5 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm">
                            <p class="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1">Total Page
                                Views</p>
                            <div class="flex items-end justify-between">
                                <h3 class="text-2xl font-bold">1,284,592</h3>
                                <span class="text-emerald-500 text-xs font-bold flex items-center mb-1">
                                    <span class="material-symbols-outlined text-sm">trending_up</span> +12.5%
                                </span>
                            </div>
                        </div>
                        <div
                            class="bg-white dark:bg-slate-900 p-5 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm">
                            <p class="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1">Avg. Read Time
                            </p>
                            <div class="flex items-end justify-between">
                                <h3 class="text-2xl font-bold">4m 32s</h3>
                                <span class="text-emerald-500 text-xs font-bold flex items-center mb-1">
                                    <span class="material-symbols-outlined text-sm">trending_up</span> +4%
                                </span>
                            </div>
                        </div>
                        <div
                            class="bg-white dark:bg-slate-900 p-5 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm">
                            <p class="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1">Engaged
                                Sessions</p>
                            <div class="flex items-end justify-between">
                                <h3 class="text-2xl font-bold">842,109</h3>
                                <span class="text-red-500 text-xs font-bold flex items-center mb-1">
                                    <span class="material-symbols-outlined text-sm">trending_down</span> -2.1%
                                </span>
                            </div>
                        </div>
                        <div
                            class="bg-white dark:bg-slate-900 p-5 rounded-xl border border-slate-200 dark:border-border-dark shadow-sm">
                            <p class="text-xs font-semibold text-slate-500 uppercase tracking-wider mb-1">Sentiment
                                Score</p>
                            <div class="flex items-end justify-between">
                                <h3 class="text-2xl font-bold">88/100</h3>
                                <span class="text-emerald-500 text-xs font-bold flex items-center mb-1">
                                    <span class="material-symbols-outlined text-sm">trending_up</span> +5.4%
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="grid grid-cols-1 lg:grid-cols-12 gap-6">
                        <div
                            class="lg:col-span-8 bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark p-6 shadow-sm">
                            <div class="flex items-center justify-between mb-8">
                                <div>
                                    <h4 class="font-bold text-slate-900 dark:text-white">Sentiment Analysis Over Time
                                    </h4>
                                    <p class="text-xs text-slate-500 mt-0.5">Distribution of reader sentiment across all
                                        articles</p>
                                </div>
                                <div class="flex gap-4">
                                    <div class="flex items-center gap-1.5">
                                        <span class="size-2 rounded-full bg-chart-teal"></span>
                                        <span class="text-[10px] font-bold text-slate-500 uppercase">Positive</span>
                                    </div>
                                    <div class="flex items-center gap-1.5">
                                        <span class="size-2 rounded-full bg-chart-amber"></span>
                                        <span class="text-[10px] font-bold text-slate-500 uppercase">Neutral</span>
                                    </div>
                                    <div class="flex items-center gap-1.5">
                                        <span class="size-2 rounded-full bg-chart-rose"></span>
                                        <span class="text-[10px] font-bold text-slate-500 uppercase">Critical</span>
                                    </div>
                                </div>
                            </div>
                            <div class="h-64 flex items-end gap-3 px-2">
                                <div class="flex-1 flex flex-col gap-0.5 group relative">
                                    <div
                                        class="w-full bg-chart-teal/80 rounded-t-sm h-[40%] transition-all group-hover:bg-chart-teal">
                                    </div>
                                    <div
                                        class="w-full bg-chart-amber/80 h-[30%] transition-all group-hover:bg-chart-amber">
                                    </div>
                                    <div
                                        class="w-full bg-chart-rose/80 rounded-b-sm h-[20%] transition-all group-hover:bg-chart-rose">
                                    </div>
                                    <span
                                        class="absolute -bottom-6 left-1/2 -translate-x-1/2 text-[10px] font-medium text-slate-400">Mon</span>
                                </div>
                                <div class="flex-1 flex flex-col gap-0.5 group relative">
                                    <div
                                        class="w-full bg-chart-teal/80 rounded-t-sm h-[55%] transition-all group-hover:bg-chart-teal">
                                    </div>
                                    <div
                                        class="w-full bg-chart-amber/80 h-[25%] transition-all group-hover:bg-chart-amber">
                                    </div>
                                    <div
                                        class="w-full bg-chart-rose/80 rounded-b-sm h-[10%] transition-all group-hover:bg-chart-rose">
                                    </div>
                                    <span
                                        class="absolute -bottom-6 left-1/2 -translate-x-1/2 text-[10px] font-medium text-slate-400">Tue</span>
                                </div>
                                <div class="flex-1 flex flex-col gap-0.5 group relative">
                                    <div
                                        class="w-full bg-chart-teal/80 rounded-t-sm h-[30%] transition-all group-hover:bg-chart-teal">
                                    </div>
                                    <div
                                        class="w-full bg-chart-amber/80 h-[45%] transition-all group-hover:bg-chart-amber">
                                    </div>
                                    <div
                                        class="w-full bg-chart-rose/80 rounded-b-sm h-[15%] transition-all group-hover:bg-chart-rose">
                                    </div>
                                    <span
                                        class="absolute -bottom-6 left-1/2 -translate-x-1/2 text-[10px] font-medium text-slate-400">Wed</span>
                                </div>
                                <div class="flex-1 flex flex-col gap-0.5 group relative">
                                    <div
                                        class="w-full bg-chart-teal/80 rounded-t-sm h-[60%] transition-all group-hover:bg-chart-teal">
                                    </div>
                                    <div
                                        class="w-full bg-chart-amber/80 h-[20%] transition-all group-hover:bg-chart-amber">
                                    </div>
                                    <div
                                        class="w-full bg-chart-rose/80 rounded-b-sm h-[10%] transition-all group-hover:bg-chart-rose">
                                    </div>
                                    <span
                                        class="absolute -bottom-6 left-1/2 -translate-x-1/2 text-[10px] font-medium text-slate-400">Thu</span>
                                </div>
                                <div class="flex-1 flex flex-col gap-0.5 group relative">
                                    <div
                                        class="w-full bg-chart-teal/80 rounded-t-sm h-[45%] transition-all group-hover:bg-chart-teal">
                                    </div>
                                    <div
                                        class="w-full bg-chart-amber/80 h-[35%] transition-all group-hover:bg-chart-amber">
                                    </div>
                                    <div
                                        class="w-full bg-chart-rose/80 rounded-b-sm h-[12%] transition-all group-hover:bg-chart-rose">
                                    </div>
                                    <span
                                        class="absolute -bottom-6 left-1/2 -translate-x-1/2 text-[10px] font-medium text-slate-400">Fri</span>
                                </div>
                                <div class="flex-1 flex flex-col gap-0.5 group relative">
                                    <div
                                        class="w-full bg-chart-teal/80 rounded-t-sm h-[20%] transition-all group-hover:bg-chart-teal">
                                    </div>
                                    <div
                                        class="w-full bg-chart-amber/80 h-[30%] transition-all group-hover:bg-chart-amber">
                                    </div>
                                    <div
                                        class="w-full bg-chart-rose/80 rounded-b-sm h-[40%] transition-all group-hover:bg-chart-rose">
                                    </div>
                                    <span
                                        class="absolute -bottom-6 left-1/2 -translate-x-1/2 text-[10px] font-medium text-slate-400">Sat</span>
                                </div>
                                <div class="flex-1 flex flex-col gap-0.5 group relative">
                                    <div
                                        class="w-full bg-chart-teal/80 rounded-t-sm h-[50%] transition-all group-hover:bg-chart-teal">
                                    </div>
                                    <div
                                        class="w-full bg-chart-amber/80 h-[25%] transition-all group-hover:bg-chart-amber">
                                    </div>
                                    <div
                                        class="w-full bg-chart-rose/80 rounded-b-sm h-[15%] transition-all group-hover:bg-chart-rose">
                                    </div>
                                    <span
                                        class="absolute -bottom-6 left-1/2 -translate-x-1/2 text-[10px] font-medium text-slate-400">Sun</span>
                                </div>
                            </div>
                        </div>
                        <div
                            class="lg:col-span-4 bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark p-6 shadow-sm">
                            <h4 class="font-bold text-slate-900 dark:text-white mb-6">Traffic Sources</h4>
                            <div class="relative flex justify-center mb-8">
                                <div
                                    class="size-48 rounded-full border-[18px] border-chart-blue border-r-chart-teal border-b-chart-amber border-l-chart-rose/40 flex items-center justify-center">
                                    <div class="text-center">
                                        <p class="text-[10px] font-bold text-slate-400 uppercase leading-none">Total</p>
                                        <p class="text-xl font-bold">1.2M</p>
                                    </div>
                                </div>
                            </div>
                            <div class="space-y-3">
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center gap-3">
                                        <span class="size-2.5 rounded-sm bg-chart-blue"></span>
                                        <span class="text-xs font-medium text-slate-600 dark:text-slate-400">Direct
                                            Search</span>
                                    </div>
                                    <span class="text-xs font-bold">42%</span>
                                </div>
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center gap-3">
                                        <span class="size-2.5 rounded-sm bg-chart-teal"></span>
                                        <span class="text-xs font-medium text-slate-600 dark:text-slate-400">Social
                                            Media</span>
                                    </div>
                                    <span class="text-xs font-bold">28%</span>
                                </div>
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center gap-3">
                                        <span class="size-2.5 rounded-sm bg-chart-amber"></span>
                                        <span
                                            class="text-xs font-medium text-slate-600 dark:text-slate-400">Newsletters</span>
                                    </div>
                                    <span class="text-xs font-bold">18%</span>
                                </div>
                                <div class="flex items-center justify-between">
                                    <div class="flex items-center gap-3">
                                        <span class="size-2.5 rounded-sm bg-chart-rose/40"></span>
                                        <span
                                            class="text-xs font-medium text-slate-600 dark:text-slate-400">Referrals</span>
                                    </div>
                                    <span class="text-xs font-bold">12%</span>
                                </div>
                            </div>
                        </div>
                        <div
                            class="lg:col-span-12 bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark p-6 shadow-sm overflow-hidden">
                            <div class="flex items-center justify-between mb-8">
                                <div>
                                    <h4 class="font-bold text-slate-900 dark:text-white">Global Readership Demographics
                                    </h4>
                                    <p class="text-xs text-slate-500 mt-0.5">Heatmap of audience concentration by region
                                    </p>
                                </div>
                                <button class="text-xs font-bold text-primary hover:underline flex items-center gap-1">
                                    View Full Report <span class="material-symbols-outlined text-sm">open_in_new</span>
                                </button>
                            </div>
                            <div
                                class="relative bg-slate-50 dark:bg-slate-800/50 rounded-lg h-80 flex items-center justify-center border border-slate-100 dark:border-slate-800">
                                <div
                                    class="absolute inset-0 opacity-10 flex flex-wrap gap-4 p-8 overflow-hidden pointer-events-none">
                                    <span class="material-symbols-outlined text-9xl">public</span>
                                </div>
                                <div class="z-10 w-full px-12 grid grid-cols-2 md:grid-cols-4 gap-8">
                                    <div class="text-center">
                                        <p class="text-3xl font-bold text-primary">42%</p>
                                        <p class="text-xs font-bold text-slate-500 uppercase mt-1">North America</p>
                                        <div
                                            class="w-24 h-1.5 bg-slate-200 dark:bg-slate-700 rounded-full mx-auto mt-3 overflow-hidden">
                                            <div class="h-full bg-primary w-[42%]"></div>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <p class="text-3xl font-bold text-chart-teal">31%</p>
                                        <p class="text-xs font-bold text-slate-500 uppercase mt-1">Europe</p>
                                        <div
                                            class="w-24 h-1.5 bg-slate-200 dark:bg-slate-700 rounded-full mx-auto mt-3 overflow-hidden">
                                            <div class="h-full bg-chart-teal w-[31%]"></div>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <p class="text-3xl font-bold text-chart-amber">18%</p>
                                        <p class="text-xs font-bold text-slate-500 uppercase mt-1">Asia Pacific</p>
                                        <div
                                            class="w-24 h-1.5 bg-slate-200 dark:bg-slate-700 rounded-full mx-auto mt-3 overflow-hidden">
                                            <div class="h-full bg-chart-amber w-[18%]"></div>
                                        </div>
                                    </div>
                                    <div class="text-center">
                                        <p class="text-3xl font-bold text-chart-rose">9%</p>
                                        <p class="text-xs font-bold text-slate-500 uppercase mt-1">Other Regions</p>
                                        <div
                                            class="w-24 h-1.5 bg-slate-200 dark:bg-slate-700 rounded-full mx-auto mt-3 overflow-hidden">
                                            <div class="h-full bg-chart-rose w-[9%]"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="absolute top-1/4 left-1/3 size-4 bg-primary/40 rounded-full animate-pulse">
                                </div>
                                <div class="absolute top-1/3 left-1/4 size-2 bg-primary/60 rounded-full"></div>
                                <div class="absolute top-1/2 left-1/2 size-3 bg-chart-teal/50 rounded-full"></div>
                                <div class="absolute bottom-1/3 right-1/4 size-5 bg-chart-amber/30 rounded-full"></div>
                            </div>
                        </div>
                    </div>
                    <div
                        class="bg-white dark:bg-slate-900 rounded-xl border border-slate-200 dark:border-border-dark overflow-hidden shadow-sm">
                        <div
                            class="px-6 py-4 border-b border-slate-200 dark:border-border-dark flex items-center justify-between">
                            <h4 class="font-bold">Content Performance Leaderboard</h4>
                            <div class="flex gap-2">
                                <button
                                    class="p-1.5 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-md transition-colors">
                                    <span class="material-symbols-outlined text-xl">filter_list</span>
                                </button>
                                <button
                                    class="p-1.5 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-md transition-colors">
                                    <span class="material-symbols-outlined text-xl">file_download</span>
                                </button>
                            </div>
                        </div>
                        <table class="w-full text-left text-sm">
                            <thead>
                                <tr
                                    class="bg-slate-50 dark:bg-slate-800/50 text-[11px] font-bold text-slate-500 uppercase tracking-wider">
                                    <th class="px-6 py-3">Article Title</th>
                                    <th class="px-6 py-3">Views</th>
                                    <th class="px-6 py-3">Engagement</th>
                                    <th class="px-6 py-3">AI Sentiment</th>
                                    <th class="px-6 py-3 text-right">Trend</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-100 dark:divide-slate-800">
                                <tr>
                                    <td class="px-6 py-4 font-semibold">The Future of AI in Modern News Reporting</td>
                                    <td class="px-6 py-4">42,891</td>
                                    <td class="px-6 py-4">84%</td>
                                    <td class="px-6 py-4">
                                        <span
                                            class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full bg-emerald-100 text-emerald-700 dark:bg-emerald-500/10 dark:text-emerald-400 text-[10px] font-bold uppercase ring-1 ring-inset ring-emerald-500/20">
                                            <span class="size-1.5 rounded-full bg-emerald-500"></span> Positive
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <span
                                            class="text-emerald-500 material-symbols-outlined text-lg">trending_up</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="px-6 py-4 font-semibold">Cybersecurity in the Age of Quantum...</td>
                                    <td class="px-6 py-4">28,502</td>
                                    <td class="px-6 py-4">62%</td>
                                    <td class="px-6 py-4">
                                        <span
                                            class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full bg-amber-100 text-amber-700 dark:bg-amber-500/10 dark:text-amber-400 text-[10px] font-bold uppercase ring-1 ring-inset ring-amber-500/20">
                                            <span class="size-1.5 rounded-full bg-amber-500"></span> Critical
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <span
                                            class="text-amber-500 material-symbols-outlined text-lg">trending_flat</span>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="px-6 py-4 font-semibold">Global Supply Chain Crisis Explained</td>
                                    <td class="px-6 py-4">19,420</td>
                                    <td class="px-6 py-4">45%</td>
                                    <td class="px-6 py-4">
                                        <span
                                            class="inline-flex items-center gap-1.5 px-2.5 py-1 rounded-full bg-slate-100 text-slate-700 dark:bg-slate-500/10 dark:text-slate-400 text-[10px] font-bold uppercase ring-1 ring-inset ring-slate-500/20">
                                            <span class="size-1.5 rounded-full bg-slate-400"></span> Neutral
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 text-right">
                                        <span
                                            class="text-red-500 material-symbols-outlined text-lg">trending_down</span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </main>
    </div>

</body>

</html>