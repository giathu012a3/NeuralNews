<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <jsp:include page="components/head.jsp" />
        <title>Comment Violation Handling | NexusAI Admin</title>
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
                    <a href="${pageContext.request.contextPath}/admin/violation.jsp"
                        class="py-4 text-sm font-bold text-slate-400 hover:text-slate-600 dark:hover:text-slate-300 transition-all">Article
                        Reports</a>
                    <button
                        class="py-4 text-sm font-bold tab-active flex items-center gap-2 text-primary transition-all">
                        Comment Reports
                        <span class="bg-primary/10 text-primary px-2 py-0.5 rounded-full text-xs">15</span>
                    </button>
                </div>
                <div class="flex-1 flex overflow-hidden">
                    <div class="flex-1 overflow-y-auto p-8">
                        <div
                            class="bg-white dark:bg-slate-800 rounded-xl shadow-sm border border-slate-200 dark:border-slate-700 overflow-hidden">
                            <table class="w-full text-left border-collapse">
                                <thead class="bg-slate-50 dark:bg-slate-700/50 sticky top-0 z-10">
                                    <tr>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider">
                                            Subject</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider">
                                            Reason</th>
                                        <th class="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider">
                                            Reporter</th>
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
                                                    class="text-sm font-semibold text-slate-800 dark:text-white line-clamp-1">
                                                    "This entire narrative is a total fabrication by the deep state..."
                                                </p>
                                                <p class="text-[10px] text-slate-400 mt-1 uppercase font-medium">Under
                                                    Article: Breaking News Coverage #291</p>
                                            </div>
                                        </td>
                                        <td class="px-6 py-5">
                                            <div class="flex items-center gap-2">
                                                <span
                                                    class="material-symbols-outlined text-risk-high text-lg">warning</span>
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
                                                    class="text-sm font-medium text-slate-600 dark:text-slate-400 line-clamp-1">
                                                    "You clearly don't understand the basic economics of this policy..."
                                                </p>
                                                <p class="text-[10px] text-slate-400 mt-1 uppercase">Under Article:
                                                    Economic
                                                    Forecast 2025</p>
                                            </div>
                                        </td>
                                        <td class="px-6 py-5">
                                            <div class="flex items-center gap-2">
                                                <span
                                                    class="material-symbols-outlined text-slate-400 text-lg">forum</span>
                                                <span
                                                    class="text-sm text-slate-600 dark:text-slate-300">Harassment</span>
                                            </div>
                                        </td>
                                        <td class="px-6 py-5">
                                            <div>
                                                <p class="text-sm font-medium text-slate-800 dark:text-white">Anonymous
                                                    #821</p>
                                                <p class="text-[10px] text-amber-500 font-bold">Trust: 45%</p>
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
                                                    class="text-sm font-medium text-slate-600 dark:text-slate-400 line-clamp-1">
                                                    "I disagree with this stance but respect the reporting."</p>
                                                <p class="text-[10px] text-slate-400 mt-1 uppercase">Under Article:
                                                    Editorial Opinion #12</p>
                                            </div>
                                        </td>
                                        <td class="px-6 py-5">
                                            <div class="flex items-center gap-2">
                                                <span
                                                    class="material-symbols-outlined text-slate-400 text-lg">info</span>
                                                <span class="text-sm text-slate-600 dark:text-slate-300">Spam</span>
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
                                                class="px-3 py-1 text-[10px] font-bold rounded-full bg-green-100 text-green-600 border border-green-200 uppercase">Safe</span>
                                        </td>
                                    </tr>
                                    <tr
                                        class="hover:bg-slate-50 dark:hover:bg-slate-700/50 transition-colors cursor-pointer">
                                        <td class="px-6 py-5">
                                            <div>
                                                <p
                                                    class="text-sm font-medium text-slate-600 dark:text-slate-400 line-clamp-1">
                                                    "Go back to where you came from, nobody wants this here."</p>
                                                <p class="text-[10px] text-slate-400 mt-1 uppercase">Under Article:
                                                    Immigration Reform Debate</p>
                                            </div>
                                        </td>
                                        <td class="px-6 py-5">
                                            <div class="flex items-center gap-2">
                                                <span
                                                    class="material-symbols-outlined text-risk-high text-lg">dangerous</span>
                                                <span class="text-sm text-slate-600 dark:text-slate-300">Hate
                                                    Speech</span>
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
                                                class="px-3 py-1 text-[10px] font-bold rounded-full bg-red-100 text-red-600 border border-red-200 uppercase">High
                                                Risk</span>
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
                                <h3 class="font-bold text-slate-800 dark:text-white">Report Details</h3>
                                <span
                                    class="text-[10px] font-bold text-primary bg-primary/10 px-2 py-1 rounded">#RPT-9942</span>
                            </div>
                            <p class="text-xs text-slate-500">Reported on Oct 24, 14:22 PM</p>
                        </div>
                        <div class="p-6 space-y-8 flex-1">
                            <section>
                                <h4 class="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-4">Context
                                </h4>
                                <div
                                    class="bg-slate-50 dark:bg-slate-900/50 p-4 rounded-xl border border-slate-100 dark:border-slate-700">
                                    <div class="flex items-center gap-2 mb-3">
                                        <img alt="User" class="w-6 h-6 rounded-full"
                                            src="https://lh3.googleusercontent.com/aida-public/AB6AXuAIMiwkUSgzeJwQjnImgm-EtQUStgnx77XaVyk6IYHPqOp0dm7MArK8Jw7O-5W5Y19FcGoIA35dJr6Z0kgbTzlrkQL26UKyUpgHTZNnj8dl2ETxJ_1kcN7J2W0NIK_hu7G22AQDyN34HN0IMEwJyd7WQmpyztp_lt1fqhP6ffdVebb8WfanKR-hDbqiPh-zJtUObWkzP5AtG5DrFUGvU00pu70F-Dtofq_yRSlVbueBpI-6AXsHeMEf3vGQwmO1-ERURjqhpCusHl6e" />
                                        <p class="text-xs font-bold text-slate-800 dark:text-white">Marcus Thorne</p>
                                        <span class="text-[10px] text-slate-400">• 2h ago</span>
                                    </div>
                                    <p
                                        class="text-sm text-slate-600 dark:text-slate-300 leading-relaxed italic border-l-2 border-slate-300 pl-3">
                                        "This entire narrative is a total fabrication by the deep state to distract from
                                        the
                                        real issues. They are lying about the data and anyone who believes this is a
                                        sheep.
                                        We need to wake up before they control us all."
                                    </p>
                                </div>
                            </section>
                            <section>
                                <h4 class="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-4">
                                    Violation
                                    History</h4>
                                <div class="space-y-3">
                                    <div class="flex items-center justify-between text-xs">
                                        <span class="text-slate-600 dark:text-slate-400">Previous Strikes</span>
                                        <span class="font-bold text-red-500">2 / 3</span>
                                    </div>
                                    <div
                                        class="w-full bg-slate-100 dark:bg-slate-700 h-1.5 rounded-full overflow-hidden">
                                        <div class="bg-red-500 h-full w-[66%]"></div>
                                    </div>
                                    <ul class="space-y-2 mt-4">
                                        <li class="flex gap-2 text-[11px] text-slate-500">
                                            <span class="material-icons text-[14px] text-amber-500">history</span>
                                            <span>Aug 12: Suspended for 24h (Spamming)</span>
                                        </li>
                                        <li class="flex gap-2 text-[11px] text-slate-500">
                                            <span class="material-icons text-[14px] text-red-500">history</span>
                                            <span>Sep 05: Warning (Hate Speech)</span>
                                        </li>
                                    </ul>
                                </div>
                            </section>
                            <section>
                                <h4 class="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-4">AI
                                    Sentiment
                                    Analysis</h4>
                                <div class="grid grid-cols-2 gap-4">
                                    <div class="bg-slate-50 dark:bg-slate-900/50 p-3 rounded-lg text-center">
                                        <p class="text-[10px] text-slate-500 uppercase">Aggression</p>
                                        <p class="text-lg font-bold text-red-500">92%</p>
                                    </div>
                                    <div class="bg-slate-50 dark:bg-slate-900/50 p-3 rounded-lg text-center">
                                        <p class="text-[10px] text-slate-500 uppercase">Sarcasm</p>
                                        <p class="text-lg font-bold text-amber-500">45%</p>
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
                                    class="py-2.5 bg-amber-500 text-white rounded-lg text-sm font-bold shadow-md shadow-amber-500/20 hover:bg-amber-600 transition-all">
                                    Delete Content
                                </button>
                                <button
                                    class="py-2.5 bg-red-600 text-white rounded-lg text-sm font-bold shadow-md shadow-red-600/20 hover:bg-red-700 transition-all">
                                    Ban User
                                </button>
                            </div>
                        </div>
                    </aside>
                </div>
            </main>
        </div>
    </body>

    </html>