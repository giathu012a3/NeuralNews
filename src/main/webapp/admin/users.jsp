<!DOCTYPE html>
<html lang="en">

<head>
    <jsp:include page="components/head.jsp" />
    <title>User Management | NexusAI Admin</title>
</head>

<body class="bg-[#F4F7FE] dark:bg-background-dark font-sans text-slate-800 dark:text-slate-100 overflow-hidden">
    <div class="flex min-h-screen">
        <jsp:include page="components/sidebar.jsp">
            <jsp:param name="activePage" value="users" />
        </jsp:include>
        <main class="flex-1 ml-64 min-h-screen pb-12">
            <header
                class="sticky top-0 z-40 bg-[#F4F7FE]/90 dark:bg-background-dark/90 backdrop-blur-md px-8 py-6 border-b border-slate-200/50 dark:border-slate-800/50">
                <div class="flex items-center justify-between">
                    <div>
                        <h2 class="text-2xl font-bold text-slate-900 dark:text-white">User Management</h2>
                        <p class="text-sm text-slate-500 mt-1">Manage global users, journalists and administrative
                            permissions.</p>
                    </div>
                    <div class="flex items-center gap-4">
                        <div class="relative flex items-center group">
                            <span
                                class="material-icons absolute left-3 text-slate-400 group-focus-within:text-primary transition-colors">search</span>
                            <input
                                class="pl-10 pr-4 py-2.5 bg-white dark:bg-slate-800 border-slate-200 dark:border-slate-700 rounded-xl text-sm focus:ring-2 focus:ring-primary w-64 lg:w-80 shadow-sm transition-all"
                                placeholder="Search by name or email..." type="text" />
                        </div>
                        <button onclick="openAddUserModal()"
                            class="bg-primary hover:bg-primary/90 text-white px-5 py-2.5 rounded-xl text-sm font-semibold flex items-center gap-2 shadow-lg shadow-primary/20 transition-all">
                            <span class="material-icons text-sm">add</span>
                            Add Member
                        </button>
                        <jsp:include page="components/header_profile.jsp" />
                    </div>
                </div>
                <div class="mt-6 flex flex-wrap items-center gap-8">
                    <div class="flex items-center gap-3">
                        <span class="text-xs font-bold text-slate-400 uppercase tracking-wider">Roles:</span>
                        <div class="bg-slate-200/50 dark:bg-slate-800 p-1 rounded-lg flex">
                            <div
                                class="px-4 py-2 text-sm font-medium transition-all cursor-pointer bg-white dark:bg-slate-700 text-primary shadow-sm rounded-md">
                                All</div>
                            <div class="px-4 py-2 text-sm font-medium transition-all cursor-pointer">Admin</div>
                            <div class="px-4 py-2 text-sm font-medium transition-all cursor-pointer">Journalist</div>
                            <div class="px-4 py-2 text-sm font-medium transition-all cursor-pointer">Member</div>
                        </div>
                    </div>
                    <div class="flex items-center gap-3">
                        <span class="text-xs font-bold text-slate-400 uppercase tracking-wider">Status:</span>
                        <div class="bg-slate-200/50 dark:bg-slate-800 p-1 rounded-lg flex">
                            <div
                                class="px-4 py-2 text-sm font-medium transition-all cursor-pointer bg-white dark:bg-slate-700 text-primary shadow-sm rounded-md">
                                All</div>
                            <div class="px-4 py-2 text-sm font-medium transition-all cursor-pointer">Active</div>
                            <div class="px-4 py-2 text-sm font-medium transition-all cursor-pointer">Banned</div>
                            <div class="px-4 py-2 text-sm font-medium transition-all cursor-pointer">Pending</div>
                        </div>
                    </div>
                </div>
            </header>
            <div class="p-8 space-y-8">
                <!-- Pending Applications Section -->
                <div
                    class="bg-indigo-50 dark:bg-indigo-900/10 rounded-2xl p-6 border border-indigo-100 dark:border-indigo-500/20">
                    <div class="flex items-center justify-between mb-6">
                        <div class="flex items-center gap-3">
                            <div class="p-2 bg-indigo-100 dark:bg-indigo-500/20 rounded-lg">
                                <span class="material-icons text-indigo-600 dark:text-indigo-400">how_to_reg</span>
                            </div>
                            <div>
                                <h3 class="text-lg font-bold text-slate-900 dark:text-white">Pending Journalist
                                    Applications</h3>
                                <p class="text-xs text-slate-500">Review and approve new journalist requests.</p>
                            </div>
                        </div>
                        <span
                            class="bg-white dark:bg-slate-800 text-indigo-600 dark:text-indigo-400 text-xs font-bold px-3 py-1.5 rounded-lg shadow-sm border border-indigo-100 dark:border-slate-700">1
                            Pending Request</span>
                    </div>

                    <div class="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
                        <!-- Applicant Card -->
                        <div
                            class="bg-white dark:bg-slate-800 p-5 rounded-xl shadow-sm border border-slate-100 dark:border-slate-700 hover:shadow-md transition-shadow relative overflow-hidden group">
                            <div
                                class="absolute top-0 right-0 p-3 opacity-0 group-hover:opacity-100 transition-opacity">
                                <button class="text-slate-300 hover:text-slate-500"><span
                                        class="material-icons text-sm">more_horiz</span></button>
                            </div>
                            <div class="flex items-start gap-4">
                                <div class="relative">
                                    <img alt="Avatar"
                                        class="w-12 h-12 rounded-full object-cover ring-2 ring-white dark:ring-slate-700 shadow-sm"
                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuC55r-FPmuWNCA53-kd_rt_KLAl5nu4DaqBh0RTF-cYgZxEV2NQeHrabEkBjRzvbBM1edkuSUHwGCS1yceEeNznZZOq85sva-ol4CGokb4XcEx53GR-20x9tDzWWnWePKd5R6HzkUDzU05zc61reG6O6XMxAy7XAZRvYwgDwl-aEnI8DhDUkThHah3waU1liIDvUr2VmJAZhG4HAlgUO7WdaHRn1LjPLYBdd6LMy_dI-6NG2r2FJHbW_vUttZg4hiMUiM68JCyPGg4u" />
                                    <span
                                        class="absolute -bottom-1 -right-1 w-4 h-4 bg-amber-500 border-2 border-white dark:border-slate-800 rounded-full flex items-center justify-center">
                                        <span class="material-icons text-[8px] text-white">priority_high</span>
                                    </span>
                                </div>
                                <div class="flex-1 min-w-0">
                                    <h4 class="text-sm font-bold text-slate-900 dark:text-white truncate">New Journalist
                                        Applicant</h4>
                                    <p class="text-xs text-slate-500 truncate mb-1">applicant@example.com</p>
                                    <span
                                        class="text-[10px] font-medium px-2 py-0.5 bg-slate-100 dark:bg-slate-700 text-slate-500 rounded-md">Applied:
                                        Just now</span>
                                </div>
                            </div>
                            <div class="mt-4 flex items-center gap-2">
                                <button onclick="openModal()"
                                    class="flex-1 bg-primary hover:bg-primary/90 text-white text-xs font-bold py-2 rounded-lg transition-all shadow-lg shadow-primary/20">
                                    Review Application
                                </button>
                                <button
                                    class="px-3 py-2 bg-slate-50 dark:bg-slate-700 hover:bg-rose-50 dark:hover:bg-rose-900/20 text-slate-400 hover:text-rose-500 rounded-lg transition-colors border border-slate-200 dark:border-slate-600">
                                    <span class="material-icons text-[18px]">close</span>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div
                    class="bg-white dark:bg-slate-800 rounded-2xl shadow-sm border border-slate-200 dark:border-slate-700 overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="w-full text-left">
                            <thead>
                                <tr
                                    class="bg-slate-50 dark:bg-slate-900/50 border-b border-slate-100 dark:border-slate-700">
                                    <th class="px-8 py-5 text-xs font-bold text-slate-400 uppercase tracking-wider">User
                                    </th>
                                    <th class="px-6 py-5 text-xs font-bold text-slate-400 uppercase tracking-wider">
                                        Email</th>
                                    <th class="px-6 py-5 text-xs font-bold text-slate-400 uppercase tracking-wider">Role
                                    </th>
                                    <th class="px-6 py-5 text-xs font-bold text-slate-400 uppercase tracking-wider">Join
                                        Date</th>
                                    <th class="px-6 py-5 text-xs font-bold text-slate-400 uppercase tracking-wider">
                                        Status</th>
                                    <th
                                        class="px-8 py-5 text-xs font-bold text-slate-400 uppercase tracking-wider text-right">
                                        Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-100 dark:divide-slate-700">
                                <tr class="hover:bg-slate-50 dark:hover:bg-slate-700/30 transition-colors group">
                                    <td class="px-8 py-4">
                                        <div class="flex items-center gap-3">
                                            <img alt="Avatar" class="w-9 h-9 rounded-full"
                                                src="https://lh3.googleusercontent.com/aida-public/AB6AXuAIMiwkUSgzeJwQjnImgm-EtQUStgnx77XaVyk6IYHPqOp0dm7MArK8Jw7O-5W5Y19FcGoIA35dJr6Z0kgbTzlrkQL26UKyUpgHTZNnj8dl2ETxJ_1kcN7J2W0NIK_hu7G22AQDyN34HN0IMEwJyd7WQmpyztp_lt1fqhP6ffdVebb8WfanKR-hDbqiPh-zJtUObWkzP5AtG5DrFUGvU00pu70F-Dtofq_yRSlVbueBpI-6AXsHeMEf3vGQwmO1-ERURjqhpCusHl6e" />
                                            <p class="text-sm font-semibold text-slate-900 dark:text-white">Admin Stark
                                            </p>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 text-sm text-slate-500 dark:text-slate-400">
                                        stark@nexusai.global</td>
                                    <td class="px-6 py-4">
                                        <span
                                            class="px-3 py-1 text-[11px] font-bold rounded-full bg-indigo-500/10 text-indigo-500 uppercase tracking-tight">Admin</span>
                                    </td>
                                    <td class="px-6 py-4 text-sm text-slate-500">Oct 12, 2023</td>
                                    <td class="px-6 py-4">
                                        <span class="flex items-center gap-1.5 text-sm font-medium text-blue-500">
                                            <span class="w-1.5 h-1.5 rounded-full bg-blue-500"></span>
                                            Active
                                        </span>
                                    </td>
                                    <td class="px-8 py-4 text-right">
                                        <div
                                            class="flex justify-end gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
                                            <button
                                                class="p-2 text-slate-400 hover:text-primary hover:bg-primary/10 rounded-lg transition-all"
                                                title="Edit">
                                                <span class="material-symbols-outlined text-[18px]">edit</span>
                                            </button>
                                            <button
                                                class="p-2 text-slate-400 hover:text-amber-500 hover:bg-amber-50 rounded-lg transition-all"
                                                title="Ban">
                                                <span class="material-symbols-outlined text-[18px]">lock</span>
                                            </button>
                                            <button
                                                class="p-2 text-slate-400 hover:text-red-500 hover:bg-red-50 rounded-lg transition-all"
                                                title="Delete">
                                                <span class="material-symbols-outlined text-[18px]">delete</span>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="hover:bg-slate-50 dark:hover:bg-slate-700/30 transition-colors group">
                                    <td class="px-8 py-4">
                                        <div class="flex items-center gap-3">
                                            <img alt="Avatar" class="w-9 h-9 rounded-full"
                                                src="https://lh3.googleusercontent.com/aida-public/AB6AXuBg4Auvl_Av2vlLpUiIuU3DAXdNhP_qBaw7mwI2I4nI_-NFZUJMq4w3hVdfWxAFlYA_9gaEwZsI5r2of9VhHiEz6RHtPWn28CQZgtD4itnzML9OjDPTmOJ8XZw_bEwlfkE_JSyBheBbWO4Rhz8Ewqb9bYtxhMAwn9oK4_qQVL38z3ZoA3nHB5WoQqnRoMv942YqihVPWPdlre7IFRxV9wHOu2ljEl9aukMNBomaGNewCmMDiMIOy-GrqBDAUEmqd3iSXpVdF3hfP5lz" />
                                            <p class="text-sm font-semibold text-slate-900 dark:text-white">Elena
                                                Rodriguez</p>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 text-sm text-slate-500 dark:text-slate-400">
                                        elena.r@nexusai.global</td>
                                    <td class="px-6 py-4">
                                        <span
                                            class="px-3 py-1 text-[11px] font-bold rounded-full bg-emerald-500/10 text-emerald-500 uppercase tracking-tight">Journalist</span>
                                    </td>
                                    <td class="px-6 py-4 text-sm text-slate-500">Jan 04, 2024</td>
                                    <td class="px-6 py-4">
                                        <span class="flex items-center gap-1.5 text-sm font-medium text-blue-500">
                                            <span class="w-1.5 h-1.5 rounded-full bg-blue-500"></span>
                                            Active
                                        </span>
                                    </td>
                                    <td class="px-8 py-4 text-right">
                                        <div
                                            class="flex justify-end gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
                                            <button
                                                class="p-2 text-slate-400 hover:text-primary hover:bg-primary/10 rounded-lg transition-all">
                                                <span class="material-symbols-outlined text-[18px]">edit</span>
                                            </button>
                                            <button
                                                class="p-2 text-slate-400 hover:text-amber-500 hover:bg-amber-50 rounded-lg transition-all"
                                                title="Ban">
                                                <span class="material-symbols-outlined text-[18px]">lock</span>
                                            </button>
                                            <button
                                                class="p-2 text-slate-400 hover:text-red-500 hover:bg-red-50 rounded-lg transition-all"
                                                title="Delete">
                                                <span class="material-symbols-outlined text-[18px]">delete</span>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                                <tr class="hover:bg-slate-50 dark:hover:bg-slate-700/30 transition-colors group">
                                    <td class="px-8 py-4">
                                        <div class="flex items-center gap-3">
                                            <img alt="Avatar" class="w-9 h-9 rounded-full"
                                                src="https://lh3.googleusercontent.com/aida-public/AB6AXuC55r-FPmuWNCA53-kd_rt_KLAl5nu4DaqBh0RTF-cYgZxEV2NQeHrabEkBjRzvbBM1edkuSUHwGCS1yceEeNznZZOq85sva-ol4CGokb4XcEx53GR-20x9tDzWWnWePKd5R6HzkUDzU05zc61reG6O6XMxAy7XAZRvYwgDwl-aEnI8DhDUkThHah3waU1liIDvUr2VmJAZhG4HAlgUO7WdaHRn1LjPLYBdd6LMy_dI-6NG2r2FJHbW_vUttZg4hiMUiM68JCyPGg4u" />
                                            <p class="text-sm font-semibold text-slate-900 dark:text-white">Sam Wilson
                                            </p>
                                        </div>
                                    </td>
                                    <td class="px-6 py-4 text-sm text-slate-500 dark:text-slate-400">
                                        wilson.sam@outlook.com</td>
                                    <td class="px-6 py-4">
                                        <span
                                            class="px-3 py-1 text-[11px] font-bold rounded-full bg-slate-500/10 text-slate-500 uppercase tracking-tight">Member</span>
                                    </td>
                                    <td class="px-6 py-4 text-sm text-slate-500">Feb 18, 2024</td>
                                    <td class="px-6 py-4">
                                        <span class="flex items-center gap-1.5 text-sm font-medium text-red-500">
                                            <span class="w-1.5 h-1.5 rounded-full bg-red-500"></span>
                                            Banned
                                        </span>
                                    </td>
                                    <td class="px-8 py-4 text-right">
                                        <div
                                            class="flex justify-end gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
                                            <button
                                                class="p-2 text-slate-400 hover:text-primary hover:bg-primary/10 rounded-lg transition-all">
                                                <span class="material-symbols-outlined text-[18px]">edit</span>
                                            </button>
                                            <button class="p-2 text-blue-500 hover:bg-blue-50 rounded-lg transition-all"
                                                title="Unban">
                                                <span class="material-symbols-outlined text-[18px]">lock_open</span>
                                            </button>
                                            <button
                                                class="p-2 text-slate-400 hover:text-red-500 hover:bg-red-50 rounded-lg transition-all"
                                                title="Delete">
                                                <span class="material-symbols-outlined text-[18px]">delete</span>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div
                        class="px-8 py-5 border-t border-slate-100 dark:border-slate-700 flex items-center justify-between">
                        <p class="text-sm text-slate-500">Showing <span
                                class="font-semibold text-slate-900 dark:text-white">1</span> to <span
                                class="font-semibold text-slate-900 dark:text-white">10</span> of <span
                                class="font-semibold text-slate-900 dark:text-white">1,240</span> users</p>
                        <div class="flex items-center gap-2">
                            <button
                                class="p-2 rounded-lg border border-slate-200 dark:border-slate-700 hover:bg-slate-50 dark:hover:bg-slate-700 disabled:opacity-50 transition-all"
                                disabled="">
                                <span class="material-icons text-sm">chevron_left</span>
                            </button>
                            <button
                                class="w-9 h-9 flex items-center justify-center rounded-lg bg-primary text-white text-sm font-bold shadow-md shadow-primary/20">1</button>
                            <button
                                class="w-9 h-9 flex items-center justify-center rounded-lg hover:bg-slate-50 dark:hover:bg-slate-700 text-sm font-medium">2</button>
                            <button
                                class="w-9 h-9 flex items-center justify-center rounded-lg hover:bg-slate-50 dark:hover:bg-slate-700 text-sm font-medium">3</button>
                            <span class="text-slate-400 mx-1">...</span>
                            <button
                                class="w-9 h-9 flex items-center justify-center rounded-lg hover:bg-slate-50 dark:hover:bg-slate-700 text-sm font-medium">124</button>
                            <button
                                class="p-2 rounded-lg border border-slate-200 dark:border-slate-700 hover:bg-slate-50 dark:hover:bg-slate-700 transition-all">
                                <span class="material-icons text-sm">chevron_right</span>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <!-- Modal -->
    <div id="userModal" class="fixed inset-0 z-[100] modal-overlay flex items-center justify-center p-4 hidden">
        <div class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm transition-opacity" onclick="closeModal()"></div>
        <div
            class="bg-white dark:bg-slate-900 w-full max-w-2xl rounded-2xl shadow-2xl relative overflow-hidden flex flex-col max-h-[90vh] z-10">
            <div
                class="px-8 py-6 border-b border-slate-100 dark:border-slate-800 flex items-center justify-between sticky top-0 bg-white dark:bg-slate-900 z-10">
                <h2 class="text-xl font-bold text-slate-900 dark:text-white leading-none">Journalist Application Details
                </h2>
                <button onclick="closeModal()"
                    class="text-slate-400 hover:text-slate-600 dark:hover:text-slate-200 transition-colors">
                    <span class="material-icons">close</span>
                </button>
            </div>
            <div class="px-8 py-8 overflow-y-auto">
                <div class="flex flex-col md:flex-row gap-8">
                    <div class="flex flex-col items-center text-center space-y-4 md:w-1/3">
                        <div class="relative">
                            <img alt="Julian Casablancas" class="w-32 h-32 rounded-2xl object-cover shadow-lg"
                                src="https://lh3.googleusercontent.com/aida-public/AB6AXuAIMiwkUSgzeJwQjnImgm-EtQUStgnx77XaVyk6IYHPqOp0dm7MArK8Jw7O-5W5Y19FcGoIA35dJr6Z0kgbTzlrkQL26UKyUpgHTZNnj8dl2ETxJ_1kcN7J2W0NIK_hu7G22AQDyN34HN0IMEwJyd7WQmpyztp_lt1fqhP6ffdVebb8WfanKR-hDbqiPh-zJtUObWkzP5AtG5DrFUGvU00pu70F-Dtofq_yRSlVbueBpI-6AXsHeMEf3vGQwmO1-ERURjqhpCusHl6e" />
                            <div
                                class="absolute -bottom-2 -right-2 bg-emerald-500 text-white p-1.5 rounded-lg border-4 border-white dark:border-slate-900">
                                <span class="material-icons text-sm">verified</span>
                            </div>
                        </div>
                        <div>
                            <h3 class="text-xl font-bold text-slate-900 dark:text-white">Julian Casablancas</h3>
                            <p class="text-sm text-slate-500 font-medium">Senior Investigative Reporter</p>
                        </div>
                        <a class="flex items-center gap-2 text-primary font-semibold text-sm hover:underline" href="#">
                            <span class="material-icons text-[18px]">download</span>
                            Download CV
                        </a>
                    </div>
                    <div class="flex-1 space-y-6">
                        <div>
                            <h4 class="text-xs font-bold text-slate-400 uppercase tracking-widest mb-2">Professional Bio
                            </h4>
                            <p class="text-sm text-slate-600 dark:text-slate-300 leading-relaxed">
                                Experienced journalist with over 8 years in the field, specializing in tech culture and
                                emerging AI trends. Previously contributed to several major digital publications and
                                focused on how technology reshapes urban environments.
                            </p>
                        </div>
                        <div class="grid grid-cols-2 gap-6">
                            <div>
                                <h4 class="text-xs font-bold text-slate-400 uppercase tracking-widest mb-2">Experience
                                </h4>
                                <p class="text-sm font-semibold text-slate-900 dark:text-white">8+ Years</p>
                            </div>
                            <div>
                                <h4 class="text-xs font-bold text-slate-400 uppercase tracking-widest mb-2">Expertise
                                </h4>
                                <div class="flex flex-wrap gap-2">
                                    <span
                                        class="px-2 py-1 bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-300 text-[10px] font-bold rounded uppercase">Tech</span>
                                    <span
                                        class="px-2 py-1 bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-300 text-[10px] font-bold rounded uppercase">Politics</span>
                                </div>
                            </div>
                        </div>
                        <div>
                            <h4 class="text-xs font-bold text-slate-400 uppercase tracking-widest mb-3">Recent Writing
                                Samples</h4>
                            <div class="space-y-2">
                                <a class="flex items-center justify-between p-3 bg-slate-50 dark:bg-slate-800/50 rounded-xl hover:bg-slate-100 dark:hover:bg-slate-800 transition-all border border-slate-100 dark:border-slate-700"
                                    href="#">
                                    <span class="text-sm font-medium text-slate-700 dark:text-slate-200">The Future of
                                        Generative AI in Newsrooms</span>
                                    <span class="material-icons text-slate-400 text-sm">open_in_new</span>
                                </a>
                                <a class="flex items-center justify-between p-3 bg-slate-50 dark:bg-slate-800/50 rounded-xl hover:bg-slate-100 dark:hover:bg-slate-800 transition-all border border-slate-100 dark:border-slate-700"
                                    href="#">
                                    <span class="text-sm font-medium text-slate-700 dark:text-slate-200">How Algorithm
                                        Bias Affects Public Opinion</span>
                                    <span class="material-icons text-slate-400 text-sm">open_in_new</span>
                                </a>
                                <a class="flex items-center justify-between p-3 bg-slate-50 dark:bg-slate-800/50 rounded-xl hover:bg-slate-100 dark:hover:bg-slate-800 transition-all border border-slate-100 dark:border-slate-700"
                                    href="#">
                                    <span class="text-sm font-medium text-slate-700 dark:text-slate-200">Decentralized
                                        Media: A New Era?</span>
                                    <span class="material-icons text-slate-400 text-sm">open_in_new</span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div
                class="px-8 py-6 border-t border-slate-100 dark:border-slate-800 bg-slate-50 dark:bg-slate-900/50 flex gap-4 sticky bottom-0">
                <button onclick="approveUser()"
                    class="flex-1 bg-green-500 hover:bg-green-600 text-white font-bold py-3 rounded-xl shadow-lg shadow-green-500/20 transition-all flex items-center justify-center gap-2">
                    <span class="material-icons">check_circle</span>
                    Approve Journalist
                </button>
                <button onclick="closeModal()"
                    class="flex-1 bg-red-500 hover:bg-red-600 text-white font-bold py-3 rounded-xl shadow-lg shadow-red-500/20 transition-all flex items-center justify-center gap-2">
                    <span class="material-icons">cancel</span>
                    Reject Application
                </button>
            </div>
        </div>
    </div>

    <!-- Add User Modal -->
    <div id="addUserModal" class="fixed inset-0 z-[100] modal-overlay flex items-center justify-center p-4 hidden">
        <div class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm transition-opacity" onclick="closeAddUserModal()">
        </div>
        <div
            class="bg-white dark:bg-slate-900 w-full max-w-md rounded-2xl shadow-2xl relative overflow-hidden flex flex-col z-10 transition-all transform scale-100">
            <div
                class="px-6 py-4 border-b border-slate-100 dark:border-slate-800 flex items-center justify-between bg-white dark:bg-slate-900 z-10">
                <h2 class="text-lg font-bold text-slate-900 dark:text-white">Add New Member</h2>
                <button onclick="closeAddUserModal()"
                    class="text-slate-400 hover:text-slate-600 dark:hover:text-slate-200 transition-colors">
                    <span class="material-icons">close</span>
                </button>
            </div>

            <div class="p-6 space-y-4">
                <div class="space-y-1.5">
                    <label
                        class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider ml-1">Full
                        Name</label>
                    <input type="text"
                        class="w-full bg-slate-50 dark:bg-slate-900/50 border border-slate-200 dark:border-slate-700 rounded-xl px-4 py-2.5 text-sm focus:ring-primary focus:border-primary transition-all outline-none"
                        placeholder="e.g. John Doe">
                </div>

                <div class="space-y-1.5">
                    <label
                        class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider ml-1">Email
                        Address</label>
                    <input type="email"
                        class="w-full bg-slate-50 dark:bg-slate-900/50 border border-slate-200 dark:border-slate-700 rounded-xl px-4 py-2.5 text-sm focus:ring-primary focus:border-primary transition-all outline-none"
                        placeholder="john@example.com">
                </div>

                <div class="space-y-1.5">
                    <label
                        class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider ml-1">Password</label>
                    <input type="password"
                        class="w-full bg-slate-50 dark:bg-slate-900/50 border border-slate-200 dark:border-slate-700 rounded-xl px-4 py-2.5 text-sm focus:ring-primary focus:border-primary transition-all outline-none"
                        placeholder="••••••••">
                </div>

                <div class="space-y-1.5">
                    <label
                        class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider ml-1">Role</label>
                    <select
                        class="w-full bg-slate-50 dark:bg-slate-900/50 border border-slate-200 dark:border-slate-700 rounded-xl px-4 py-2.5 text-sm focus:ring-primary focus:border-primary transition-all outline-none appearance-none">
                        <option value="user">User (Standard)</option>
                        <option value="journalist">Journalist</option>
                        <option value="admin">Administrator</option>
                    </select>
                </div>
            </div>

            <div
                class="px-6 py-4 border-t border-slate-100 dark:border-slate-800 bg-slate-50 dark:bg-slate-900/50 flex gap-3">
                <button onclick="closeAddUserModal()"
                    class="flex-1 px-4 py-2.5 text-sm font-bold text-slate-600 dark:text-slate-400 hover:bg-slate-200 dark:hover:bg-slate-800 rounded-xl transition-colors">
                    Cancel
                </button>
                <button onclick="createNewUser()"
                    class="flex-1 px-4 py-2.5 text-sm font-bold bg-primary text-white hover:bg-primary/90 rounded-xl shadow-lg shadow-primary/20 transition-all flex items-center justify-center gap-2">
                    <span class="material-icons text-sm">person_add</span>
                    Create Account
                </button>
            </div>
        </div>
    </div>

    <script>
        // Existing modal functions
        function openModal() {
            document.getElementById('userModal').classList.remove('hidden');
        }

        function closeModal() {
            document.getElementById('userModal').classList.add('hidden');
        }

        function approveUser() {
            alert('Journalist Approved! Access granted to the publishing dashboard.');
            closeModal();
        }

        // New Add User functions
        function openAddUserModal() {
            document.getElementById('addUserModal').classList.remove('hidden');
        }

        function closeAddUserModal() {
            document.getElementById('addUserModal').classList.add('hidden');
        }

        function createNewUser() {
            // Here you would typically gather form data and send it to the backend via AJAX/Fetch
            // For now, we simulate success
            const role = document.querySelector('#addUserModal select').value;
            alert(`New ${role.charAt(0).toUpperCase() + role.slice(1)} account created successfully!`);
            closeAddUserModal();
        }
    </script>
</body>

</html>