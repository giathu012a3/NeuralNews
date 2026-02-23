<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <header
        class="sticky top-0 z-50 w-full border-b border-border-light dark:border-border-dark bg-white/95 dark:bg-background-dark/95 backdrop-blur-md">
        <div class="max-w-[1440px] mx-auto px-4 lg:px-8 h-16 flex items-center justify-between gap-4">
            <a class="flex items-center gap-2 group" href="${pageContext.request.contextPath}/user/home.jsp">
                <div
                    class="flex items-center justify-center size-9 rounded bg-primary text-white group-hover:bg-primary-dark transition-colors">
                    <span class="material-symbols-outlined text-[22px]">newsmode</span>
                </div>
                <h1 class="text-xl font-extrabold tracking-tight text-slate-900 dark:text-white">Nexus<span
                        class="text-primary">AI</span></h1>
            </a>
            <nav class="hidden lg:flex items-center gap-8">
                <a class="text-sm font-semibold text-slate-600 dark:text-slate-300 hover:text-primary dark:hover:text-primary transition-colors uppercase tracking-wide"
                    href="${pageContext.request.contextPath}/user/category.jsp">Chính trị</a>
                <a class="text-sm font-semibold text-slate-600 dark:text-slate-300 hover:text-primary dark:hover:text-primary transition-colors uppercase tracking-wide"
                    href="${pageContext.request.contextPath}/user/category.jsp">Đời sống</a>
                <a class="text-sm font-semibold text-slate-600 dark:text-slate-300 hover:text-primary dark:hover:text-primary transition-colors uppercase tracking-wide"
                    href="${pageContext.request.contextPath}/user/category.jsp">Công nghệ</a>
                <a class="text-sm font-semibold text-slate-600 dark:text-slate-300 hover:text-primary dark:hover:text-primary transition-colors uppercase tracking-wide"
                    href="${pageContext.request.contextPath}/user/category.jsp">Thể thao</a>
            </nav>
            <div class="flex items-center gap-4 flex-1 lg:flex-none justify-end">
                <div class="relative hidden md:flex items-center w-full max-w-xs group">
                    <span
                        class="absolute left-3 text-slate-400 material-symbols-outlined text-[20px] group-focus-within:text-primary">search</span>
                    <input
                        class="w-full h-10 pl-10 pr-10 bg-slate-100 dark:bg-surface-dark border-transparent focus:border-primary focus:bg-white dark:focus:bg-surface-dark focus:ring-0 rounded-full text-sm transition-all"
                        placeholder="Tìm kiếm tin tức bằng AI..." type="text" />
                    <span class="absolute right-3 text-primary material-symbols-outlined text-[18px]"
                        title="AI Enhanced">auto_awesome</span>
                </div>
                <div class="flex items-center gap-3 border-l border-slate-200 dark:border-slate-700 pl-4">
                    <button
                        class="relative p-1.5 text-slate-500 hover:bg-slate-100 dark:hover:bg-surface-dark rounded-full transition-colors group"
                        title="Toggle theme">
                        <span
                            class="material-symbols-outlined text-[22px] group-hover:text-orange-500 hidden dark:block">light_mode</span>
                        <span
                            class="material-symbols-outlined text-[22px] group-hover:text-primary block dark:hidden">dark_mode</span>
                    </button>
                    <button
                        class="relative p-1.5 text-slate-500 hover:bg-slate-100 dark:hover:bg-surface-dark rounded-full transition-colors">
                        <span class="material-symbols-outlined text-[22px]">notifications</span>
                        <span
                            class="absolute top-1 right-1 size-2 bg-red-500 rounded-full border border-white dark:border-background-dark"></span>
                    </button>
                    <% if (session.getAttribute("userName") !=null) { %>
                        <div class="profile-dropdown-container relative flex items-center outline-none" tabindex="0">
                            <div
                                class="size-10 rounded-full p-0.5 hover:bg-slate-100 dark:hover:bg-surface-dark active:bg-slate-200 dark:active:bg-slate-800 transition-colors cursor-pointer flex items-center justify-center">
                                <div
                                    class="size-full rounded-full bg-slate-200 overflow-hidden border-2 border-white dark:border-slate-700 shadow-sm">
                                    <% String userAvatarUrl=(String) session.getAttribute("avatarUrl"); String
                                        userDisplayName=(String) session.getAttribute("userName"); if
                                        (userDisplayName==null) userDisplayName="User" ; if (userAvatarUrl==null ||
                                        userAvatarUrl.isEmpty()) { userAvatarUrl="https://ui-avatars.com/api/?name=" +
                                        java.net.URLEncoder.encode(userDisplayName, "UTF-8" )
                                        + "&background=0D8ABC&color=fff" ; } %>
                                        <img alt="<%= userDisplayName %>" src="<%= userAvatarUrl %>"
                                            class="size-full object-cover">
                                </div>
                            </div>
                            <div
                                class="profile-dropdown hidden absolute right-0 top-full mt-2 w-64 bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-xl shadow-xl overflow-visible z-50 text-slate-200 dropdown-arrow border-slate-200 dark:border-slate-700">
                                <div class="p-4 border-b border-slate-100 dark:border-slate-700">
                                    <% String userName=(String) session.getAttribute("userName"); String
                                        userRole=(String) session.getAttribute("userRole"); if (userName==null)
                                        userName="Khách" ; if (userRole==null) userRole="Khách vãng lai" ; %>
                                        <p class="text-sm font-bold text-slate-900 dark:text-white">
                                            <%= userName %>
                                        </p>
                                        <p class="text-xs text-slate-500 dark:text-slate-400 capitalize">
                                            <%= userRole.toLowerCase() %>
                                        </p>
                                </div>
                                <div class="py-2">
                                    <a class="flex items-center gap-3 px-4 py-2.5 text-sm text-slate-700 dark:text-slate-200 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors"
                                        href="${pageContext.request.contextPath}/user/profile.jsp">
                                        <span class="material-symbols-outlined text-xl text-slate-400">person</span>
                                        Hồ sơ của tôi
                                    </a>
                                    <% if ("ADMIN".equals(userRole)) { %>
                                        <a class="flex items-center justify-between px-4 py-2.5 text-sm text-slate-700 dark:text-slate-200 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors"
                                            href="${pageContext.request.contextPath}/admin/home.jsp">
                                            <div class="flex items-center gap-3">
                                                <span
                                                    class="material-symbols-outlined text-xl text-slate-400">shield_person</span>
                                                Bảng điều khiển Admin
                                            </div>
                                            <span
                                                class="bg-red-500/10 text-red-500 text-[10px] font-bold px-1.5 py-0.5 rounded border border-red-500/20 uppercase">Admin</span>
                                        </a>
                                        <% } else if ("JOURNALIST".equals(userRole)) { %>
                                            <a class="flex items-center justify-between px-4 py-2.5 text-sm text-slate-700 dark:text-slate-200 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors"
                                                href="${pageContext.request.contextPath}/journalist/home.jsp">
                                                <div class="flex items-center gap-3">
                                                    <span
                                                        class="material-symbols-outlined text-xl text-slate-400">dashboard_customize</span>
                                                    Bảng điều khiển Nhà báo
                                                </div>
                                                <span
                                                    class="bg-primary/10 text-primary text-[10px] font-bold px-1.5 py-0.5 rounded border border-primary/20 uppercase">Pro</span>
                                            </a>
                                            <% } %>
                                                <a class="flex items-center gap-3 px-4 py-2.5 text-sm text-slate-700 dark:text-slate-200 hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors"
                                                    href="${pageContext.request.contextPath}/user/settings.jsp">
                                                    <span
                                                        class="material-symbols-outlined text-xl text-slate-400">settings</span>
                                                    Cài đặt tài khoản
                                                </a>
                                </div>
                                <div class="border-t border-slate-100 dark:border-slate-700 py-2">
                                    <a class="flex items-center gap-3 px-4 py-2.5 text-sm text-red-500 hover:bg-red-50 dark:hover:bg-red-950/30 transition-colors"
                                        href="${pageContext.request.contextPath}/auth/logout.jsp">
                                        <span class="material-symbols-outlined text-xl">logout</span>
                                        Đăng xuất
                                    </a>
                                </div>
                            </div>
                        </div>
                        <% } else { %>
                            <div class="flex items-center gap-2">
                                <a href="${pageContext.request.contextPath}/auth/login.jsp"
                                    class="px-4 py-2 text-sm font-semibold text-slate-600 dark:text-slate-300 hover:text-primary dark:hover:text-primary transition-colors">
                                    Đăng nhập
                                </a>
                                <a href="${pageContext.request.contextPath}/auth/register.jsp"
                                    class="px-4 py-2 text-sm font-semibold text-white bg-primary hover:bg-primary-dark rounded-full transition-colors shadow-sm shadow-primary/30">
                                    Đăng ký
                                </a>
                            </div>
                            <% } %>
                </div>
            </div>
        </div>
    </header>