<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <jsp:include page="components/head.jsp" />
        <title>Permissions & Roles | NexusAI Admin</title>
    </head>

    <body class="bg-[#F4F7FE] dark:bg-background-dark font-sans text-slate-800 dark:text-slate-100 overflow-hidden">
        <div class="flex h-screen overflow-hidden">
            <jsp:include page="components/sidebar.jsp">
                <jsp:param name="activePage" value="permissions" />
            </jsp:include>

            <main class="flex-1 ml-64 h-full flex flex-col overflow-y-auto custom-scrollbar">
                <header
                    class="sticky top-0 z-40 bg-[#F4F7FE]/90 dark:bg-background-dark/90 backdrop-blur-md px-8 py-6 border-b border-slate-200/50 dark:border-slate-800/50">
                    <div class="flex items-center justify-between">
                        <div>
                            <h2 class="text-2xl font-bold text-slate-900 dark:text-white">Role & Permissions</h2>
                            <p class="text-sm text-slate-500 mt-1">Manage system access levels and role-based
                                capabilities.</p>
                        </div>
                        <div class="flex items-center gap-4">
                            <jsp:include page="components/header_profile.jsp" />
                        </div>
                    </div>
                </header>

                <div class="p-8 max-w-6xl">
                    <div
                        class="bg-white dark:bg-slate-800 rounded-2xl shadow-sm border border-slate-200 dark:border-slate-700 overflow-hidden">
                        <div
                            class="p-6 border-b border-slate-100 dark:border-slate-700 flex flex-col md:flex-row md:items-center justify-between gap-4">
                            <div>
                                <h3 class="text-lg font-bold text-slate-900 dark:text-white">Permission Matrix</h3>
                                <p class="text-sm text-slate-500">Define what each role can do within the system.</p>
                            </div>
                            <div class="flex gap-3">
                                <button
                                    class="px-4 py-2 text-sm font-bold text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg transition-colors">
                                    Reset Defaults
                                </button>
                                <button
                                    class="px-5 py-2 text-sm font-bold bg-primary text-white rounded-lg hover:bg-primary/90 shadow-lg shadow-primary/20 transition-all flex items-center gap-2">
                                    <span class="material-icons text-sm">save</span>
                                    Save Changes
                                </button>
                            </div>
                        </div>

                        <div class="overflow-x-auto">
                            <table class="w-full text-left border-collapse">
                                <thead>
                                    <tr
                                        class="bg-slate-50 dark:bg-slate-900/50 border-b border-slate-100 dark:border-slate-700">
                                        <th
                                            class="px-6 py-4 text-xs font-bold text-slate-400 uppercase tracking-wider min-w-[200px]">
                                            Permission</th>
                                        <th class="px-6 py-4 text-center min-w-[120px]">
                                            <div class="flex flex-col items-center gap-1">
                                                <span
                                                    class="text-sm font-bold text-slate-800 dark:text-white">Admin</span>
                                                <span class="text-[10px] text-slate-400 font-normal">Full Access</span>
                                            </div>
                                        </th>
                                        <th class="px-6 py-4 text-center min-w-[120px]">
                                            <div class="flex flex-col items-center gap-1">
                                                <span
                                                    class="text-sm font-bold text-slate-800 dark:text-white">Journalist</span>
                                                <span class="text-[10px] text-slate-400 font-normal">Content
                                                    Creator</span>
                                            </div>
                                        </th>
                                        <th class="px-6 py-4 text-center min-w-[120px]">
                                            <div class="flex flex-col items-center gap-1">
                                                <span
                                                    class="text-sm font-bold text-slate-800 dark:text-white">Moderator</span>
                                                <span class="text-[10px] text-slate-400 font-normal">Content
                                                    Safety</span>
                                            </div>
                                        </th>
                                        <th class="px-6 py-4 text-center min-w-[120px]">
                                            <div class="flex flex-col items-center gap-1">
                                                <span
                                                    class="text-sm font-bold text-slate-800 dark:text-white">User</span>
                                                <span class="text-[10px] text-slate-400 font-normal">Standard
                                                    Member</span>
                                            </div>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody class="divide-y divide-slate-100 dark:divide-slate-700">
                                    <!-- Content Management Section -->
                                    <tr class="bg-slate-50/50 dark:bg-slate-800/50">
                                        <td colspan="5"
                                            class="px-6 py-3 text-xs font-bold text-primary uppercase tracking-widest bg-primary/5 dark:bg-primary/10">
                                            Content Management
                                        </td>
                                    </tr>
                                    <tr class="hover:bg-slate-50 dark:hover:bg-slate-700/30 transition-colors">
                                        <td class="px-6 py-4">
                                            <p class="text-sm font-medium text-slate-700 dark:text-slate-200">View
                                                Content</p>
                                            <p class="text-xs text-slate-400">Can view published articles and comments
                                            </p>
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox" checked disabled
                                                class="w-5 h-5 rounded border-slate-300 text-primary cursor-not-allowed opacity-50">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox" checked disabled
                                                class="w-5 h-5 rounded border-slate-300 text-primary cursor-not-allowed opacity-50">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox" checked disabled
                                                class="w-5 h-5 rounded border-slate-300 text-primary cursor-not-allowed opacity-50">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox" checked disabled
                                                class="w-5 h-5 rounded border-slate-300 text-primary cursor-not-allowed opacity-50">
                                        </td>
                                    </tr>
                                    <tr class="hover:bg-slate-50 dark:hover:bg-slate-700/30 transition-colors">
                                        <td class="px-6 py-4">
                                            <p class="text-sm font-medium text-slate-700 dark:text-slate-200">Create
                                                Articles</p>
                                            <p class="text-xs text-slate-400">Can write and submit new articles</p>
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox" checked
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox" checked
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox"
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox"
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                    </tr>
                                    <tr class="hover:bg-slate-50 dark:hover:bg-slate-700/30 transition-colors">
                                        <td class="px-6 py-4">
                                            <p class="text-sm font-medium text-slate-700 dark:text-slate-200">Publish
                                                Content</p>
                                            <p class="text-xs text-slate-400">Can publish articles without approval</p>
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox" checked
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox"
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox"
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox"
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                    </tr>
                                    <tr class="hover:bg-slate-50 dark:hover:bg-slate-700/30 transition-colors">
                                        <td class="px-6 py-4">
                                            <p class="text-sm font-medium text-slate-700 dark:text-slate-200">Delete
                                                Content</p>
                                            <p class="text-xs text-slate-400">Can remove articles and comments</p>
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox" checked
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox"
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox" checked
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox"
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                    </tr>

                                    <!-- User Management Section -->
                                    <tr class="bg-slate-50/50 dark:bg-slate-800/50">
                                        <td colspan="5"
                                            class="px-6 py-3 text-xs font-bold text-amber-500 uppercase tracking-widest bg-amber-50 dark:bg-amber-900/10">
                                            User Management
                                        </td>
                                    </tr>
                                    <tr class="hover:bg-slate-50 dark:hover:bg-slate-700/30 transition-colors">
                                        <td class="px-6 py-4">
                                            <p class="text-sm font-medium text-slate-700 dark:text-slate-200">View Users
                                            </p>
                                            <p class="text-xs text-slate-400">Can view user profiles and list</p>
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox" checked disabled
                                                class="w-5 h-5 rounded border-slate-300 text-primary cursor-not-allowed opacity-50">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox"
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox" checked
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox"
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                    </tr>
                                    <tr class="hover:bg-slate-50 dark:hover:bg-slate-700/30 transition-colors">
                                        <td class="px-6 py-4">
                                            <p class="text-sm font-medium text-slate-700 dark:text-slate-200">Ban Users
                                            </p>
                                            <p class="text-xs text-slate-400">Can ban or suspend user accounts</p>
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox" checked
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox"
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox" checked
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox"
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                    </tr>
                                    <tr class="hover:bg-slate-50 dark:hover:bg-slate-700/30 transition-colors">
                                        <td class="px-6 py-4">
                                            <p class="text-sm font-medium text-slate-700 dark:text-slate-200">Manage
                                                Roles</p>
                                            <p class="text-xs text-slate-400">Can change user roles (e.g. promote to
                                                Journalist)</p>
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox" checked
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox"
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox"
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox"
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                    </tr>

                                    <!-- System Administration -->
                                    <tr class="bg-slate-50/50 dark:bg-slate-800/50">
                                        <td colspan="5"
                                            class="px-6 py-3 text-xs font-bold text-purple-500 uppercase tracking-widest bg-purple-50 dark:bg-purple-900/10">
                                            System Administration
                                        </td>
                                    </tr>
                                    <tr class="hover:bg-slate-50 dark:hover:bg-slate-700/30 transition-colors">
                                        <td class="px-6 py-4">
                                            <p class="text-sm font-medium text-slate-700 dark:text-slate-200">System
                                                Logs</p>
                                            <p class="text-xs text-slate-400">View detailed system activity logs</p>
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox" checked
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox"
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox"
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox"
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                    </tr>
                                    <tr class="hover:bg-slate-50 dark:hover:bg-slate-700/30 transition-colors">
                                        <td class="px-6 py-4">
                                            <p class="text-sm font-medium text-slate-700 dark:text-slate-200">Global
                                                Settings</p>
                                            <p class="text-xs text-slate-400">Configure site-wide settings (AI, Layout)
                                            </p>
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox" checked
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox"
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox"
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
                                        </td>
                                        <td class="px-6 py-4 text-center"><input type="checkbox"
                                                class="w-5 h-5 rounded border-slate-300 text-primary focus:ring-primary">
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