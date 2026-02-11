<!DOCTYPE html>
<html lang="en">

<head>
    <jsp:include page="components/head.jsp" />
    <title>NexusAI Global Admin Dashboard</title>
</head>

<body class="bg-background-light dark:bg-background-dark font-display text-slate-800 dark:text-slate-100">
    <div class="flex min-h-screen">
        <!-- Sidebar -->
        <jsp:include page="components/sidebar.jsp">
            <jsp:param name="activePage" value="dashboard" />
        </jsp:include>

        <!-- Main Content -->
        <main class="flex-1 ml-64 bg-[#F4F7FE] dark:bg-background-dark/95 min-h-screen">
            <!-- Header -->
            <header
                class="sticky top-0 z-40 bg-[#F4F7FE]/80 dark:bg-background-dark/80 backdrop-blur-md px-8 py-4 flex items-center justify-between">
                <div>
                    <p class="text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-widest">Pages
                        / Dashboard</p>
                    <h2 class="text-2xl font-bold text-slate-800 dark:text-white">System Dashboard</h2>
                </div>
                <div
                    class="flex items-center gap-4 bg-white dark:bg-slate-800 p-2 rounded-full shadow-sm border border-slate-100 dark:border-slate-700">
                    <div class="relative flex items-center ml-2">
                        <span class="material-icons absolute left-3 text-slate-400 text-[18px]">search</span>
                        <input
                            class="pl-10 pr-4 py-2 bg-[#F4F7FE] dark:bg-slate-900 border-none rounded-full text-sm focus:ring-2 focus:ring-primary w-48 lg:w-64 transition-all"
                            placeholder="Search..." type="text" />
                    </div>
                    <button class="p-2 text-slate-500 hover:text-primary transition-colors">
                        <span class="material-icons">notifications</span>
                    </button>
                    <button class="p-2 text-slate-500 hover:text-primary transition-colors">
                        <span class="material-icons">settings</span>
                    </button>
                    <div class="h-8 w-8 rounded-full overflow-hidden bg-primary/20 border-2 border-primary/20">
                        <img class="w-full h-full object-cover" data-alt="Admin user profile avatar"
                            src="https://lh3.googleusercontent.com/aida-public/AB6AXuC4v1Xj-x5c0-BNWvuQMWrNKnYpUqHJu2FzBC2ANgMo6855wzRgUZD-tyPVU_iWy9HANXuBFUBSMxHPeds14WCinCTTRCtzwz4MqbtS_WsSwg5Gy0dENGvERGxaw9BORVzow9HavpimbV7bIQ6_ZH8VevoPeGWPT5YBZAurWMoIevRvkLkGWt1gp_7QPG9XNSgbrNUujAcFewuJkhw1rocmmASWGj67hq21d4jI11-j3ZZxxaxhgSjEO9Fx64PNgntutDDQHHdl5Ubo" />
                    </div>
                </div>
            </header>
            <div class="p-8 space-y-8">
                <!-- Row 1: KPI Cards -->
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
                    <!-- Card 1 -->
                    <div
                        class="bg-white dark:bg-slate-800 p-6 rounded-xl shadow-sm flex items-center gap-4 border border-slate-50 dark:border-slate-700">
                        <div class="w-12 h-12 bg-primary/10 rounded-full flex items-center justify-center">
                            <span class="material-icons text-primary">groups</span>
                        </div>
                        <div>
                            <p class="text-sm font-medium text-slate-500 dark:text-slate-400">Real-time Users</p>
                            <h3 class="text-2xl font-bold text-slate-800 dark:text-white">12,842</h3>
                        </div>
                    </div>
                    <!-- Card 2 -->
                    <div
                        class="bg-white dark:bg-slate-800 p-6 rounded-xl shadow-sm flex items-center gap-4 border border-slate-50 dark:border-slate-700">
                        <div
                            class="w-12 h-12 bg-green-100 dark:bg-green-900/30 rounded-full flex items-center justify-center">
                            <span class="material-icons text-green-500">article</span>
                        </div>
                        <div>
                            <p class="text-sm font-medium text-slate-500 dark:text-slate-400">New Articles Today</p>
                            <h3 class="text-2xl font-bold text-slate-800 dark:text-white">1,452</h3>
                        </div>
                    </div>
                    <!-- Card 3 -->
                    <div
                        class="bg-white dark:bg-slate-800 p-6 rounded-xl shadow-sm flex items-center gap-4 border border-slate-50 dark:border-slate-700">
                        <div
                            class="w-12 h-12 bg-amber-100 dark:bg-amber-900/30 rounded-full flex items-center justify-center">
                            <span class="material-icons text-amber-500">person_add</span>
                        </div>
                        <div>
                            <p class="text-sm font-medium text-slate-500 dark:text-slate-400">Journalist Requests</p>
                            <h3 class="text-2xl font-bold text-slate-800 dark:text-white">84</h3>
                        </div>
                    </div>
                    <!-- Card 4 -->
                    <div
                        class="bg-white dark:bg-slate-800 p-6 rounded-xl shadow-sm flex items-center gap-4 border border-slate-50 dark:border-slate-700">
                        <div
                            class="w-12 h-12 bg-red-100 dark:bg-red-900/30 rounded-full flex items-center justify-center">
                            <span class="material-icons text-red-500">report_problem</span>
                        </div>
                        <div>
                            <p class="text-sm font-medium text-slate-500 dark:text-slate-400">Pending Violations</p>
                            <h3 class="text-2xl font-bold text-slate-800 dark:text-white">12</h3>
                        </div>
                    </div>
                </div>
                <!-- Row 2: Traffic and AI Insights -->
                <div class="grid grid-cols-1 lg:grid-cols-10 gap-6">
                    <!-- Traffic Chart Mockup -->
                    <div
                        class="lg:col-span-7 bg-white dark:bg-slate-800 p-6 rounded-xl shadow-sm border border-slate-50 dark:border-slate-700">
                        <div class="flex items-center justify-between mb-8">
                            <div>
                                <h3 class="text-lg font-bold text-slate-800 dark:text-white">24h Traffic Overview</h3>
                                <p class="text-sm text-slate-500 dark:text-slate-400">Comparison between Today vs
                                    Yesterday</p>
                            </div>
                            <div class="flex gap-2">
                                <span
                                    class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-primary/10 text-primary">Today</span>
                                <span
                                    class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-slate-100 dark:bg-slate-700 text-slate-500">Yesterday</span>
                            </div>
                        </div>
                        <!-- Simple SVG Chart Representation -->
                        <div class="h-64 w-full relative">
                            <svg class="w-full h-full" preserveaspectratio="none" viewbox="0 0 1000 200">
                                <defs>
                                    <lineargradient id="chartGradient" x1="0" x2="0" y1="0" y2="1">
                                        <stop offset="0%" stop-color="#0d7ff2" stop-opacity="0.2"></stop>
                                        <stop offset="100%" stop-color="#0d7ff2" stop-opacity="0"></stop>
                                    </lineargradient>
                                </defs>
                                <path d="M0,150 Q100,120 200,160 T400,100 T600,140 T800,80 T1000,110 L1000,200 L0,200 Z"
                                    fill="url(#chartGradient)"></path>
                                <path d="M0,150 Q100,120 200,160 T400,100 T600,140 T800,80 T1000,110" fill="none"
                                    stroke="#0d7ff2" stroke-width="3"></path>
                            </svg>
                            <!-- Grid lines mockup -->
                            <div
                                class="absolute inset-0 flex flex-col justify-between pointer-events-none border-b border-slate-100 dark:border-slate-700 pb-2">
                                <div class="border-t border-slate-100 dark:border-slate-700/50 w-full"></div>
                                <div class="border-t border-slate-100 dark:border-slate-700/50 w-full"></div>
                                <div class="border-t border-slate-100 dark:border-slate-700/50 w-full"></div>
                            </div>
                        </div>
                        <div class="flex justify-between mt-4 text-xs text-slate-400 font-medium">
                            <span>00:00</span><span>04:00</span><span>08:00</span><span>12:00</span><span>16:00</span><span>20:00</span><span>23:59</span>
                        </div>
                    </div>
                    <!-- AI Smart Insights Widget -->
                    <div
                        class="lg:col-span-3 ai-gradient-border rounded-xl shadow-lg p-6 flex flex-col overflow-hidden dark:bg-slate-800">
                        <div class="flex items-center gap-2 mb-6">
                            <span class="material-icons text-primary">auto_awesome</span>
                            <h3 class="font-bold text-slate-800 dark:text-white">AI Smart Insights</h3>
                        </div>
                        <div class="space-y-6">
                            <div>
                                <p class="text-xs font-bold text-slate-400 uppercase tracking-widest mb-3">Trending Now
                                </p>
                                <div class="flex flex-wrap gap-2">
                                    <span
                                        class="px-3 py-1 bg-slate-100 dark:bg-slate-700 rounded-full text-xs font-medium text-slate-600 dark:text-slate-300">#Election2024</span>
                                    <span
                                        class="px-3 py-1 bg-slate-100 dark:bg-slate-700 rounded-full text-xs font-medium text-slate-600 dark:text-slate-300">#AIRevolution</span>
                                    <span
                                        class="px-3 py-1 bg-slate-100 dark:bg-slate-700 rounded-full text-xs font-medium text-slate-600 dark:text-slate-300">#ClimateTech</span>
                                    <span
                                        class="px-3 py-1 bg-slate-100 dark:bg-slate-700 rounded-full text-xs font-medium text-slate-600 dark:text-slate-300">#GlobalTrade</span>
                                </div>
                            </div>
                            <div class="border-t border-slate-100 dark:border-slate-700 pt-6">
                                <div class="flex items-center justify-between mb-3">
                                    <p class="text-xs font-bold text-slate-400 uppercase tracking-widest">Spam Alerts
                                    </p>
                                    <span
                                        class="text-[10px] bg-red-100 text-red-600 px-2 py-0.5 rounded-full font-bold">HIGH
                                        RISK</span>
                                </div>
                                <ul class="space-y-3">
                                    <li class="flex items-start gap-3">
                                        <div class="mt-1 w-2 h-2 rounded-full bg-red-500"></div>
                                        <div>
                                            <p class="text-xs font-semibold text-slate-700 dark:text-slate-200">Bot
                                                pattern detected</p>
                                            <p class="text-[10px] text-slate-500">Origin: 192.168.1.42 (Russia)</p>
                                        </div>
                                    </li>
                                    <li class="flex items-start gap-3">
                                        <div class="mt-1 w-2 h-2 rounded-full bg-amber-500"></div>
                                        <div>
                                            <p class="text-xs font-semibold text-slate-700 dark:text-slate-200">Content
                                                plagiarism match</p>
                                            <p class="text-[10px] text-slate-500">84% similarity with AP News</p>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <button
                                class="mt-4 w-full py-3 bg-primary text-white rounded-lg text-sm font-bold shadow-md shadow-primary/30 hover:bg-primary/90 transition-all flex items-center justify-center gap-2">
                                <span class="material-icons text-[18px]">bolt</span>
                                Run Deep Analysis
                            </button>
                        </div>
                    </div>
                </div>
                <!-- Row 3: Quick Action Table -->
                <div
                    class="bg-white dark:bg-slate-800 rounded-xl shadow-sm border border-slate-50 dark:border-slate-700 overflow-hidden">
                    <div class="p-6 border-b border-slate-50 dark:border-slate-700 flex items-center justify-between">
                        <h3 class="text-lg font-bold text-slate-800 dark:text-white">Quick Action: Top Violations</h3>
                        <button class="text-primary text-sm font-semibold hover:underline">View All Violations</button>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full text-left">
                            <thead class="bg-slate-50 dark:bg-slate-700/50">
                                <tr>
                                    <th class="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider">
                                        Subject</th>
                                    <th class="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider">
                                        Reason</th>
                                    <th class="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider">
                                        Severity</th>
                                    <th class="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider">
                                        Timestamp</th>
                                    <th
                                        class="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider text-right">
                                        Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-50 dark:divide-slate-700">
                                <tr class="hover:bg-slate-50/50 dark:hover:bg-slate-700/30 transition-colors">
                                    <td class="px-6 py-4">
                                        <div class="flex items-center gap-3">
                                            <div class="w-8 h-8 rounded bg-slate-200 dark:bg-slate-700 flex-shrink-0">
                                                <img class="w-full h-full object-cover rounded"
                                                    data-alt="User avatar thumbnail"
                                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuAIMiwkUSgzeJwQjnImgm-EtQUStgnx77XaVyk6IYHPqOp0dm7MArK8Jw7O-5W5Y19FcGoIA35dJr6Z0kgbTzlrkQL26UKyUpgHTZNnj8dl2ETxJ_1kcN7J2W0NIK_hu7G22AQDyN34HN0IMEwJyd7WQmpyztp_lt1fqhP6ffdVebb8WfanKR-hDbqiPh-zJtUObWkzP5AtG5DrFUGvU00pu70F-Dtofq_yRSlVbueBpI-6AXsHeMEf3vGQwmO1-ERURjqhpCusHl6e" />
                                            </div>
                                            <div>
                                                <p class="text-sm font-semibold text-slate-800 dark:text-white">Marcus
                                                    Thorne</p>
                                                <p class="text-[10px] text-slate-500">ID: #USR-8821</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4">
                                        <p class="text-sm text-slate-600 dark:text-slate-300">Spreading Misinformation
                                        </p>
                                    </td>
                                    <td class="px-6 py-4">
                                        <span
                                            class="px-2 py-1 text-[10px] font-bold rounded-full bg-red-100 text-red-600">CRITICAL</span>
                                    </td>
                                    <td class="px-6 py-4 text-sm text-slate-500">2 mins ago</td>
                                    <td class="px-6 py-4 text-right">
                                        <div class="flex justify-end gap-2">
                                            <button
                                                class="p-2 bg-primary/10 text-primary hover:bg-primary hover:text-white rounded-lg transition-all">
                                                <span class="material-icons text-[18px]">visibility</span>
                                            </button>
                                            <button
                                                class="p-2 bg-slate-100 dark:bg-slate-700 text-slate-400 hover:text-red-500 rounded-lg transition-all">
                                                <span class="material-icons text-[18px]">delete</span>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="hover:bg-slate-50/50 dark:hover:bg-slate-700/30 transition-colors">
                                    <td class="px-6 py-4">
                                        <div class="flex items-center gap-3">
                                            <div class="w-8 h-8 rounded bg-slate-200 dark:bg-slate-700 flex-shrink-0">
                                                <img class="w-full h-full object-cover rounded"
                                                    data-alt="Journalist avatar thumbnail"
                                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuC55r-FPmuWNCA53-kd_rt_KLAl5nu4DaqBh0RTF-cYgZxEV2NQeHrabEkBjRzvbBM1edkuSUHwGCS1yceEeNznZZOq85sva-ol4CGokb4XcEx53GR-20x9tDzWWnWePKd5R6HzkUDzU05zc61reG6O6XMxAy7XAZRvYwgDwl-aEnI8DhDUkThHah3waU1liIDvUr2VmJAZhG4HAlgUO7WdaHRn1LjPLYBdd6LMy_dI-6NG2r2FJHbW_vUttZg4hiMUiM68JCyPGg4u" />
                                            </div>
                                            <div>
                                                <p class="text-sm font-semibold text-slate-800 dark:text-white">Elena
                                                    Rodriguez</p>
                                                <p class="text-[10px] text-slate-500">ID: #JRN-4412</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4">
                                        <p class="text-sm text-slate-600 dark:text-slate-300">Unverified Source Usage
                                        </p>
                                    </td>
                                    <td class="px-6 py-4">
                                        <span
                                            class="px-2 py-1 text-[10px] font-bold rounded-full bg-amber-100 text-amber-600">MEDIUM</span>
                                    </td>
                                    <td class="px-6 py-4 text-sm text-slate-500">14 mins ago</td>
                                    <td class="px-6 py-4 text-right">
                                        <div class="flex justify-end gap-2">
                                            <button
                                                class="p-2 bg-primary/10 text-primary hover:bg-primary hover:text-white rounded-lg transition-all">
                                                <span class="material-icons text-[18px]">visibility</span>
                                            </button>
                                            <button
                                                class="p-2 bg-slate-100 dark:bg-slate-700 text-slate-400 hover:text-red-500 rounded-lg transition-all">
                                                <span class="material-icons text-[18px]">delete</span>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="hover:bg-slate-50/50 dark:hover:bg-slate-700/30 transition-colors">
                                    <td class="px-6 py-4">
                                        <div class="flex items-center gap-3">
                                            <div class="w-8 h-8 rounded bg-slate-200 dark:bg-slate-700 flex-shrink-0">
                                                <img class="w-full h-full object-cover rounded"
                                                    data-alt="User avatar thumbnail"
                                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuBg4Auvl_Av2vlLpUiIuU3DAXdNhP_qBaw7mwI2I4nI_-NFZUJMq4w3hVdfWxAFlYA_9gaEwZsI5r2of9VhHiEz6RHtPWn28CQZgtD4itnzML9OjDPTmOJ8XZw_bEwlfkE_JSyBheBbWO4Rhz8Ewqb9bYtxhMAwn9oK4_qQVL38z3ZoA3nHB5WoQqnRoMv942YqihVPWPdlre7IFRxV9wHOu2ljEl9aukMNBomaGNewCmMDiMIOy-GrqBDAUEmqd3iSXpVdF3hfP5lz" />
                                            </div>
                                            <div>
                                                <p class="text-sm font-semibold text-slate-800 dark:text-white">Sam
                                                    Wilson</p>
                                                <p class="text-[10px] text-slate-500">ID: #USR-9901</p>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4">
                                        <p class="text-sm text-slate-600 dark:text-slate-300">Harassment Flag</p>
                                    </td>
                                    <td class="px-6 py-4">
                                        <span
                                            class="px-2 py-1 text-[10px] font-bold rounded-full bg-red-100 text-red-600">HIGH</span>
                                    </td>
                                    <td class="px-6 py-4 text-sm text-slate-500">42 mins ago</td>
                                    <td class="px-6 py-4 text-right">
                                        <div class="flex justify-end gap-2">
                                            <button
                                                class="p-2 bg-primary/10 text-primary hover:bg-primary hover:text-white rounded-lg transition-all">
                                                <span class="material-icons text-[18px]">visibility</span>
                                            </button>
                                            <button
                                                class="p-2 bg-slate-100 dark:bg-slate-700 text-slate-400 hover:text-red-500 rounded-lg transition-all">
                                                <span class="material-icons text-[18px]">delete</span>
                                            </button>
                                        </div>
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