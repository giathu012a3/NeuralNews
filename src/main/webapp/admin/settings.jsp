<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <jsp:include page="components/head.jsp" />
        <title>Account Settings | NexusAI Admin</title>
    </head>

    <body class="bg-[#F4F7FE] dark:bg-background-dark font-sans text-slate-800 dark:text-slate-100 overflow-hidden">
        <div class="flex min-h-screen">
            <jsp:include page="components/sidebar.jsp">
                <jsp:param name="activePage" value="settings" />
            </jsp:include>

            <main class="flex-1 ml-64 min-h-screen flex flex-col overflow-y-auto">
                <header
                    class="sticky top-0 z-40 bg-[#F4F7FE]/90 dark:bg-background-dark/90 backdrop-blur-md px-8 py-6 border-b border-slate-200/50 dark:border-slate-800/50">
                    <div class="flex items-center justify-between">
                        <div>
                            <h2 class="text-2xl font-bold text-slate-900 dark:text-white">Account Settings</h2>
                            <p class="text-sm text-slate-500 mt-1">Manage your administrator profile and security
                                preferences.</p>
                        </div>
                        <div class="flex items-center gap-4">
                            <jsp:include page="components/header_profile.jsp" />
                        </div>
                    </div>
                </header>

                <div class="p-8 max-w-5xl">
                    <div class="flex items-center justify-end gap-3 mb-8">
                        <button
                            class="px-4 py-2 text-sm font-bold text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg transition-colors">Cancel</button>
                        <button
                            class="px-6 py-2 text-sm font-bold bg-primary text-white rounded-lg hover:bg-primary/90 shadow-lg shadow-primary/20 transition-all">Save
                            Changes</button>
                    </div>

                    <div class="space-y-6">
                        <!-- Profile Section -->
                        <section
                            class="bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-2xl p-6 md:p-8 shadow-sm">
                            <div class="flex items-center gap-2 mb-8">
                                <span class="material-icons text-primary">person</span>
                                <h3 class="font-bold text-lg text-slate-900 dark:text-white">Profile Information</h3>
                            </div>
                            <div class="flex flex-col md:flex-row gap-8 items-start">
                                <div class="flex flex-col items-center gap-4">
                                    <div class="relative group">
                                        <div
                                            class="w-32 h-32 rounded-2xl bg-slate-200 overflow-hidden border-4 border-slate-50 dark:border-slate-700 shadow-md">
                                            <div class="w-full h-full bg-cover bg-center"
                                                style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuC4v1Xj-x5c0-BNWvuQMWrNKnYpUqHJu2FzBC2ANgMo6855wzRgUZD-tyPVU_iWy9HANXuBFUBSMxHPeds14WCinCTTRCtzwz4MqbtS_WsSwg5Gy0dENGvERGxaw9BORVzow9HavpimbV7bIQ6_ZH8VevoPeGWPT5YBZAurWMoIevRvkLkGWt1gp_7QPG9XNSgbrNUujAcFewuJkhw1rocmmASWGj67hq21d4jI11-j3ZZxxaxhgSjEO9Fx64PNgntutDDQHHdl5Ubo');">
                                            </div>
                                        </div>
                                        <button
                                            class="absolute -bottom-2 -right-2 p-2 bg-primary text-white rounded-xl shadow-lg border-4 border-white dark:border-slate-800 hover:scale-110 transition-transform">
                                            <span class="material-icons text-sm">photo_camera</span>
                                        </button>
                                    </div>
                                    <p class="text-xs text-slate-500 dark:text-slate-400 font-medium">Change Avatar</p>
                                </div>
                                <div class="flex-1 grid grid-cols-1 md:grid-cols-2 gap-6 w-full">
                                    <div class="space-y-2">
                                        <label
                                            class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider ml-1">Full
                                            Name</label>
                                        <input
                                            class="w-full bg-slate-50 dark:bg-slate-900/50 border border-slate-200 dark:border-slate-700 rounded-xl px-4 py-3 text-sm focus:ring-primary focus:border-primary transition-all outline-none"
                                            type="text" value="Admin User" />
                                    </div>
                                    <div class="space-y-2">
                                        <label
                                            class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider ml-1">Email
                                            Address</label>
                                        <input
                                            class="w-full bg-slate-50 dark:bg-slate-900/50 border border-slate-200 dark:border-slate-700 rounded-xl px-4 py-3 text-sm focus:ring-primary focus:border-primary transition-all outline-none"
                                            type="email" value="admin@nexusai.global" />
                                    </div>
                                    <div class="space-y-2">
                                        <label
                                            class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider ml-1">Role</label>
                                        <input
                                            class="w-full bg-slate-100 dark:bg-slate-800/50 border border-slate-200 dark:border-slate-700 rounded-xl px-4 py-3 text-sm text-slate-500 cursor-not-allowed outline-none"
                                            type="text" value="System Administrator" disabled />
                                    </div>
                                    <div class="space-y-2">
                                        <label
                                            class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider ml-1">Department</label>
                                        <input
                                            class="w-full bg-slate-50 dark:bg-slate-900/50 border border-slate-200 dark:border-slate-700 rounded-xl px-4 py-3 text-sm focus:ring-primary focus:border-primary transition-all outline-none"
                                            type="text" value="IT & Operations" />
                                    </div>
                                </div>
                            </div>
                        </section>

                        <!-- Security Section -->
                        <section
                            class="bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-2xl p-6 md:p-8 shadow-sm">
                            <div class="flex items-center gap-2 mb-8">
                                <span class="material-icons text-primary">security</span>
                                <h3 class="font-bold text-lg text-slate-900 dark:text-white">Security & Password</h3>
                            </div>
                            <div class="max-w-2xl space-y-6">
                                <div class="space-y-2">
                                    <label
                                        class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider ml-1">Current
                                        Password</label>
                                    <input
                                        class="w-full bg-slate-50 dark:bg-slate-900/50 border border-slate-200 dark:border-slate-700 rounded-xl px-4 py-3 text-sm focus:ring-primary focus:border-primary transition-all outline-none"
                                        type="password" placeholder="Enter current password" />
                                </div>
                                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                                    <div class="space-y-2">
                                        <label
                                            class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider ml-1">New
                                            Password</label>
                                        <input
                                            class="w-full bg-slate-50 dark:bg-slate-900/50 border border-slate-200 dark:border-slate-700 rounded-xl px-4 py-3 text-sm focus:ring-primary focus:border-primary transition-all outline-none"
                                            type="password" placeholder="Enter new password" />
                                    </div>
                                    <div class="space-y-2">
                                        <label
                                            class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider ml-1">Confirm
                                            New Password</label>
                                        <input
                                            class="w-full bg-slate-50 dark:bg-slate-900/50 border border-slate-200 dark:border-slate-700 rounded-xl px-4 py-3 text-sm focus:ring-primary focus:border-primary transition-all outline-none"
                                            type="password" placeholder="Confirm new password" />
                                    </div>
                                </div>
                                <div class="pt-4 border-t border-slate-100 dark:border-slate-700">
                                    <button
                                        class="text-primary text-sm font-bold hover:underline flex items-center gap-1">
                                        <span class="material-icons text-sm">lock_reset</span>
                                        Enable Two-Factor Authentication
                                    </button>
                                </div>
                            </div>
                        </section>

                        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                            <!-- Notifications -->
                            <section
                                class="bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-2xl p-6 shadow-sm">
                                <div class="flex items-center gap-2 mb-6">
                                    <span class="material-icons text-primary">notifications</span>
                                    <h3 class="font-bold text-lg text-slate-900 dark:text-white">Notifications</h3>
                                </div>
                                <div class="space-y-4">
                                    <label
                                        class="flex items-center justify-between p-3 rounded-xl hover:bg-slate-50 dark:hover:bg-slate-700/50 transition-colors cursor-pointer border border-transparent hover:border-slate-100 dark:hover:border-slate-700">
                                        <div class="flex flex-col">
                                            <span class="text-sm font-bold text-slate-800 dark:text-slate-200">System
                                                Alerts</span>
                                            <span class="text-xs text-slate-500">Critical system updates and
                                                errors.</span>
                                        </div>
                                        <input checked=""
                                            class="rounded text-primary focus:ring-primary w-5 h-5 border-slate-300"
                                            type="checkbox" />
                                    </label>
                                    <label
                                        class="flex items-center justify-between p-3 rounded-xl hover:bg-slate-50 dark:hover:bg-slate-700/50 transition-colors cursor-pointer border border-transparent hover:border-slate-100 dark:hover:border-slate-700">
                                        <div class="flex flex-col">
                                            <span class="text-sm font-bold text-slate-800 dark:text-slate-200">User
                                                Reports</span>
                                            <span class="text-xs text-slate-500">New violation reports requiring
                                                attention.</span>
                                        </div>
                                        <input checked=""
                                            class="rounded text-primary focus:ring-primary w-5 h-5 border-slate-300"
                                            type="checkbox" />
                                    </label>
                                    <label
                                        class="flex items-center justify-between p-3 rounded-xl hover:bg-slate-50 dark:hover:bg-slate-700/50 transition-colors cursor-pointer border border-transparent hover:border-slate-100 dark:hover:border-slate-700">
                                        <div class="flex flex-col">
                                            <span
                                                class="text-sm font-bold text-slate-800 dark:text-slate-200">Journalist
                                                Applications</span>
                                            <span class="text-xs text-slate-500">New requests to join as
                                                contributor.</span>
                                        </div>
                                        <input class="rounded text-primary focus:ring-primary w-5 h-5 border-slate-300"
                                            type="checkbox" />
                                    </label>
                                </div>
                            </section>

                            <!-- Display Settings -->
                            <section
                                class="bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-2xl p-6 shadow-sm">
                                <div class="flex items-center gap-2 mb-6">
                                    <span class="material-icons text-primary">settings_display</span>
                                    <h3 class="font-bold text-lg text-slate-900 dark:text-white">Display Preferences
                                    </h3>
                                </div>
                                <div class="space-y-4">
                                    <div class="space-y-2">
                                        <label
                                            class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Theme</label>
                                        <select
                                            class="w-full bg-slate-50 dark:bg-slate-900/50 border border-slate-200 dark:border-slate-700 rounded-xl px-4 py-3 text-sm focus:ring-primary focus:border-primary transition-all outline-none">
                                            <option selected>System Default</option>
                                            <option>Light Mode</option>
                                            <option>Dark Mode</option>
                                        </select>
                                    </div>
                                    <div class="space-y-2">
                                        <label
                                            class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Dashboard
                                            Density</label>
                                        <select
                                            class="w-full bg-slate-50 dark:bg-slate-900/50 border border-slate-200 dark:border-slate-700 rounded-xl px-4 py-3 text-sm focus:ring-primary focus:border-primary transition-all outline-none">
                                            <option selected>Comfortable</option>
                                            <option>Compact</option>
                                        </select>
                                    </div>
                                </div>
                            </section>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </body>

    </html>