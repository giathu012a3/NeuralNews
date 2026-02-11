<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <jsp:include page="components/head.jsp" />
        <title>Violation Handling | NexusAI Admin</title>
        <style>
            .tab-active {
                border-bottom: 2px solid #0d7ff2;
                color: #0d7ff2;
                font-weight: 700 !important;
            }
        </style>
    </head>

    <body class="bg-dashboard-bg dark:bg-background-dark font-sans text-slate-800 dark:text-slate-100 overflow-hidden">
        <div class="flex h-screen overflow-hidden">
            <jsp:include page="components/sidebar.jsp">
                <jsp:param name="activePage" value="violation" />
            </jsp:include>

            <main class="flex-1 ml-64 flex flex-col min-w-0 bg-dashboard-bg dark:bg-slate-900 overflow-hidden">
                <header
                    class="bg-white dark:bg-slate-800 px-8 py-4 flex items-center justify-between border-b border-slate-200 dark:border-slate-700">
                    <div>
                        <p class="text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-widest">
                            Compliance / Moderation</p>
                        <h2 class="text-2xl font-bold text-slate-800 dark:text-white">Violation Handling</h2>
                    </div>
                    <div class="flex items-center gap-4">
                        <button
                            class="bg-primary text-white px-5 py-2.5 rounded-lg flex items-center gap-2 font-semibold shadow-md shadow-primary/20 hover:bg-primary/90 transition-all">
                            <span class="material-symbols-outlined text-[20px]">auto_fix_high</span>
                            AI Auto-Clean
                        </button>
                        <jsp:include page="components/header_profile.jsp" />
                    </div>
                </header>
                <div class="px-8 bg-white dark:bg-slate-800 border-b border-slate-200 dark:border-slate-700 flex gap-8">
                    <button class="py-4 text-sm font-bold tab-active text-primary transition-all">Article
                        Reports</button>
                    <a href="${pageContext.request.contextPath}/admin/violation_comments.jsp"
                        class="py-4 text-sm font-bold text-slate-400 hover:text-slate-600 dark:hover:text-slate-300 transition-all flex items-center gap-2">
                        Comment Reports
                        <span
                            class="bg-slate-100 dark:bg-slate-700 text-slate-500 px-2 py-0.5 rounded-full text-xs">15</span>
                    </a>
                </div>
                <div class="flex-1 flex overflow-hidden">
                    <div class="flex-1 overflow-y-auto p-8">
                        <div
                            class="bg-white dark:bg-slate-800 rounded-xl shadow-sm border border-slate-200 dark:border-slate-700 overflow-hidden">
                            <table class="w-full text-left border-collapse">
                                <thead
                                    class="bg-slate-50 dark:bg-slate-700/50 sticky top-0 z-10 border-b border-slate-200 dark:border-slate-700">
                                    <tr>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider">
                                            Article Title</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider">
                                            Violation Reason</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider">
                                            Reporter Info</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider">
                                            AI
                                            Assessment</th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-slate-100 dark:divide-slate-700">
                                    <tr
                                        class="bg-primary/5 hover:bg-primary/10 transition-colors cursor-pointer border-l-4 border-l-primary">
                                        <td class="px-6 py-5">
                                            <div>
                                                <p
                                                    class="text-sm font-semibold text-slate-800 dark:text-white line-clamp-1 uppercase">
                                                    The Silent Energy Crisis of 2024</p>
                                                <p class="text-[10px] text-slate-400 mt-1 uppercase font-medium">Author:
                                                    Julian Vane • Politics Section</p>
                                            </div>
                                        </td>
                                        <td class="px-6 py-5">
                                            <div class="flex items-center gap-2">
                                                <span
                                                    class="material-symbols-outlined text-risk-high text-lg">error</span>
                                                <span class="text-sm text-slate-600 dark:text-slate-300">Fake
                                                    News</span>
                                            </div>
                                        </td>
                                        <td class="px-6 py-5">
                                            <div>
                                                <p class="text-sm font-medium text-slate-800 dark:text-white">Sarah
                                                    Jenkins
                                                </p>
                                                <p class="text-[10px] text-green-500 font-bold">Trust: 98%</p>
                                            </div>
                                        </td>
                                        <td class="px-6 py-5">
                                            <span
                                                class="px-3 py-1 text-[10px] font-bold rounded-full bg-red-100 text-red-600 border border-red-200 uppercase">High
                                                Risk</span>
                                        </td>
                                    </tr>
                                    <tr
                                        class="hover:bg-slate-50 dark:hover:bg-slate-700/50 transition-colors cursor-pointer">
                                        <td class="px-6 py-5">
                                            <div>
                                                <p
                                                    class="text-sm font-medium text-slate-600 dark:text-slate-400 line-clamp-1 uppercase">
                                                    AI Revolution in Modern Healthcare</p>
                                                <p class="text-[10px] text-slate-400 mt-1 uppercase">Author: Tech
                                                    Insights
                                                    Bot • Technology</p>
                                            </div>
                                        </td>
                                        <td class="px-6 py-5">
                                            <div class="flex items-center gap-2">
                                                <span
                                                    class="material-symbols-outlined text-risk-medium text-lg">content_copy</span>
                                                <span
                                                    class="text-sm text-slate-600 dark:text-slate-300">Plagiarism</span>
                                            </div>
                                        </td>
                                        <td class="px-6 py-5">
                                            <div>
                                                <p class="text-sm font-medium text-slate-800 dark:text-white">Admin
                                                    Monitor
                                                </p>
                                                <p class="text-[10px] text-green-500 font-bold">System Internal</p>
                                            </div>
                                        </td>
                                        <td class="px-6 py-5">
                                            <span
                                                class="px-3 py-1 text-[10px] font-bold rounded-full bg-amber-100 text-amber-600 border border-amber-200 uppercase">Manual
                                                Review</span>
                                        </td>
                                    </tr>
                                    <tr
                                        class="hover:bg-slate-50 dark:hover:bg-slate-700/50 transition-colors cursor-pointer">
                                        <td class="px-6 py-5">
                                            <div>
                                                <p
                                                    class="text-sm font-medium text-slate-600 dark:text-slate-400 line-clamp-1 uppercase">
                                                    Global Markets Collapse Tonight!</p>
                                                <p class="text-[10px] text-slate-400 mt-1 uppercase">Author: Marcus
                                                    Thorne •
                                                    Finance</p>
                                            </div>
                                        </td>
                                        <td class="px-6 py-5">
                                            <div class="flex items-center gap-2">
                                                <span
                                                    class="material-symbols-outlined text-risk-high text-lg">campaign</span>
                                                <span
                                                    class="text-sm text-slate-600 dark:text-slate-300">Sensationalism</span>
                                            </div>
                                        </td>
                                        <td class="px-6 py-5">
                                            <div>
                                                <p class="text-sm font-medium text-slate-800 dark:text-white">Mark
                                                    Peterson
                                                </p>
                                                <p class="text-[10px] text-green-500 font-bold">Trust: 89%</p>
                                            </div>
                                        </td>
                                        <td class="px-6 py-5">
                                            <span
                                                class="px-3 py-1 text-[10px] font-bold rounded-full bg-red-100 text-red-600 border border-red-200 uppercase">High
                                                Risk</span>
                                        </td>
                                    </tr>
                                    <tr
                                        class="hover:bg-slate-50 dark:hover:bg-slate-700/50 transition-colors cursor-pointer">
                                        <td class="px-6 py-5">
                                            <div>
                                                <p
                                                    class="text-sm font-medium text-slate-600 dark:text-slate-400 line-clamp-1 uppercase">
                                                    New Climate Report: Stable Outlook</p>
                                                <p class="text-[10px] text-slate-400 mt-1 uppercase">Author: Elena
                                                    Rodriguez
                                                    • Science</p>
                                            </div>
                                        </td>
                                        <td class="px-6 py-5">
                                            <div class="flex items-center gap-2">
                                                <span
                                                    class="material-symbols-outlined text-slate-400 text-lg">help_outline</span>
                                                <span class="text-sm text-slate-600 dark:text-slate-300">Biased
                                                    Reporting</span>
                                            </div>
                                        </td>
                                        <td class="px-6 py-5">
                                            <div>
                                                <p class="text-sm font-medium text-slate-800 dark:text-white">Jessica L.
                                                </p>
                                                <p class="text-[10px] text-green-500 font-bold">Trust: 95%</p>
                                            </div>
                                        </td>
                                        <td class="px-6 py-5">
                                            <span
                                                class="px-3 py-1 text-[10px] font-bold rounded-full bg-green-100 text-green-600 border border-green-200 uppercase">Safe</span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <aside
                        class="w-96 bg-white dark:bg-slate-800 border-l border-slate-200 dark:border-slate-700 flex flex-col overflow-y-auto">
                        <div class="p-6 border-b border-slate-100 dark:border-slate-700">
                            <div class="flex items-center justify-between mb-2">
                                <h3 class="font-bold text-slate-800 dark:text-white">Article Audit</h3>
                                <span
                                    class="text-[10px] font-bold text-primary bg-primary/10 px-2 py-1 rounded">#ART-291-V</span>
                            </div>
                            <div class="flex items-center justify-between">
                                <p class="text-xs text-slate-500">Publication ID: 88204 • Posted 2h ago</p>
                                <a class="flex items-center gap-1.5 px-3 py-1.5 border border-slate-200 dark:border-slate-600 rounded-lg text-[10px] font-bold text-slate-600 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-slate-700 transition-all uppercase"
                                    href="#" target="_blank">
                                    View Full Article
                                    <span class="material-symbols-outlined text-[14px]">open_in_new</span>
                                </a>
                            </div>
                        </div>
                        <div class="p-6 space-y-8 flex-1">
                            <section>
                                <h4 class="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-4">Metadata
                                </h4>
                                <div class="grid grid-cols-2 gap-4">
                                    <div class="bg-slate-50 dark:bg-slate-900/50 p-3 rounded-lg">
                                        <p class="text-[10px] text-slate-500 uppercase mb-1">Author</p>
                                        <p class="text-xs font-bold text-slate-800 dark:text-white">Julian Vane</p>
                                    </div>
                                    <div class="bg-slate-50 dark:bg-slate-900/50 p-3 rounded-lg">
                                        <p class="text-[10px] text-slate-500 uppercase mb-1">Source Score</p>
                                        <p class="text-xs font-bold text-amber-500">42/100</p>
                                    </div>
                                </div>
                            </section>
                            <section>
                                <h4 class="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-4">
                                    Problematic
                                    Content Snippet</h4>
                                <div
                                    class="bg-slate-50 dark:bg-slate-900/50 p-4 rounded-xl border border-slate-100 dark:border-slate-700 relative">
                                    <span
                                        class="material-icons absolute -top-2 -left-2 text-risk-high bg-white dark:bg-slate-800 rounded-full text-lg">format_quote</span>
                                    <p
                                        class="text-sm text-slate-600 dark:text-slate-300 leading-relaxed italic border-l-2 border-risk-high pl-3">
                                        "...unconfirmed reports from secret government insiders suggest that the
                                        upcoming
                                        energy bill is actually a front for a mass surveillance initiative. No official
                                        data
                                        supports this, but our sources claim it is 100% verified by independent
                                        watchers..."
                                    </p>
                                </div>
                            </section>
                            <section>
                                <h4 class="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-4">AI Trust
                                    Assessment</h4>
                                <div class="space-y-4">
                                    <div class="flex items-center justify-between text-xs">
                                        <span class="text-slate-600 dark:text-slate-400">Factual Accuracy Score</span>
                                        <span class="font-bold text-red-500">12%</span>
                                    </div>
                                    <div class="w-full bg-slate-100 dark:bg-slate-700 h-2 rounded-full overflow-hidden">
                                        <div class="bg-red-500 h-full w-[12%]"></div>
                                    </div>
                                    <div class="grid grid-cols-2 gap-4 mt-6">
                                        <div
                                            class="bg-slate-50 dark:bg-slate-900/50 p-3 rounded-lg text-center border border-slate-100 dark:border-slate-700">
                                            <p class="text-[10px] text-slate-500 uppercase">Sensationalism</p>
                                            <p class="text-lg font-bold text-red-500">88%</p>
                                        </div>
                                        <div
                                            class="bg-slate-50 dark:bg-slate-900/50 p-3 rounded-lg text-center border border-slate-100 dark:border-slate-700">
                                            <p class="text-[10px] text-slate-500 uppercase">AI Trust Score</p>
                                            <p class="text-lg font-bold text-risk-high">15/100</p>
                                        </div>
                                    </div>
                                </div>
                            </section>
                        </div>
                        <div
                            class="p-6 bg-slate-50 dark:bg-slate-900/50 border-t border-slate-200 dark:border-slate-700 space-y-3">
                            <button
                                class="w-full py-2.5 bg-slate-200 dark:bg-slate-700 text-slate-700 dark:text-slate-200 rounded-lg text-sm font-bold hover:bg-slate-300 dark:hover:bg-slate-600 transition-all">
                                Dismiss Report
                            </button>
                            <div class="grid grid-cols-2 gap-3">
                                <button
                                    class="py-2.5 bg-amber-500 text-white rounded-lg text-sm font-bold shadow-md shadow-amber-500/20 hover:bg-amber-600 transition-all flex items-center justify-center gap-1">
                                    <span class="material-icons text-sm">visibility_off</span>
                                    Take Down
                                </button>
                                <button
                                    class="py-2.5 bg-red-600 text-white rounded-lg text-sm font-bold shadow-md shadow-red-600/20 hover:bg-red-700 transition-all flex items-center justify-center gap-1">
                                    <span class="material-icons text-sm">person_off</span>
                                    Suspend
                                </button>
                            </div>
                        </div>
                    </aside>
                </div>
            </main>
        </div>
    </body>

    </html>