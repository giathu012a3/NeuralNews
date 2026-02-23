<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <div class="relative z-50">
        <button onclick="toggleAdminProfile()" id="adminProfileBtn"
            class="block h-10 w-10 rounded-full overflow-hidden border-2 border-slate-100 dark:border-slate-700 shadow-sm cursor-pointer hover:border-primary transition-all focus:ring-4 focus:ring-primary/20 outline-none">
            <% String avatarUrl=(String) session.getAttribute("avatarUrl"); String displayName=(String)
                session.getAttribute("userName"); if (displayName==null) displayName="Admin" ; if (avatarUrl==null ||
                avatarUrl.isEmpty()) { avatarUrl="https://ui-avatars.com/api/?name=" +
                java.net.URLEncoder.encode(displayName, "UTF-8" ) + "&background=0D8ABC&color=fff" ; } %>
                <img alt="<%= displayName %>" class="w-full h-full object-cover" src="<%= avatarUrl %>" />
        </button>

        <!-- Dropdown Menu -->
        <div id="adminProfileDropdown"
            class="hidden absolute right-0 top-full mt-2 w-64 bg-white dark:bg-slate-800 border border-slate-100 dark:border-slate-700 rounded-xl shadow-xl overflow-hidden animate-in fade-in slide-in-from-top-2 duration-200 origin-top-right transform transition-all">
            <div class="p-4 border-b border-slate-100 dark:border-slate-700 bg-slate-50/50 dark:bg-slate-900/50">
                <% String adminName=(String) session.getAttribute("userName"); String adminRole=(String)
                    session.getAttribute("userRole"); if (adminName==null) adminName="Admin User" ; if (adminRole==null)
                    adminRole="Administrator" ; %>
                    <p class="text-sm font-bold text-slate-800 dark:text-white">
                        <%= adminName %>
                    </p>
                    <p class="text-xs text-slate-500 dark:text-slate-400 capitalize">
                        <%= adminRole.toLowerCase() %>
                    </p>
            </div>
            <div class="p-2">
                <a href="${pageContext.request.contextPath}/admin/settings.jsp"
                    class="flex items-center gap-3 px-4 py-2.5 text-sm font-medium text-slate-600 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-slate-700/50 hover:text-primary dark:hover:text-primary rounded-lg transition-colors">
                    <span class="material-icons text-[20px]">manage_accounts</span>
                    Account Settings
                </a>
                <a href="#"
                    class="flex items-center gap-3 px-4 py-2.5 text-sm font-medium text-slate-600 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-slate-700/50 hover:text-primary dark:hover:text-primary rounded-lg transition-colors">
                    <span class="material-icons text-[20px]">notifications_active</span>
                    Notifications
                    <span
                        class="ml-auto bg-red-500 text-white text-[10px] grid place-items-center w-5 h-5 rounded-full">3</span>
                </a>
                <a href="#"
                    class="flex items-center gap-3 px-4 py-2.5 text-sm font-medium text-slate-600 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-slate-700/50 hover:text-primary dark:hover:text-primary rounded-lg transition-colors">
                    <span class="material-icons text-[20px]">help_outline</span>
                    Help & Support
                </a>
            </div>
            <div class="p-2 border-t border-slate-100 dark:border-slate-700">
                <a href="${pageContext.request.contextPath}/logout"
                    class="flex items-center gap-3 px-4 py-2.5 text-sm font-medium text-red-500 hover:bg-red-50 dark:hover:bg-red-900/20 rounded-lg transition-colors">
                    <span class="material-icons text-[20px]">logout</span>
                    Sign Out
                </a>
            </div>
        </div>
    </div>

    <script>
        function toggleAdminProfile() {
            const dropdown = document.getElementById('adminProfileDropdown');
            const btn = document.getElementById('adminProfileBtn');

            if (dropdown.classList.contains('hidden')) {
                dropdown.classList.remove('hidden');
                // Add ring to indicate active state
                btn.classList.add('ring-4', 'ring-primary/20', 'border-primary');
            } else {
                dropdown.classList.add('hidden');
                btn.classList.remove('ring-4', 'ring-primary/20', 'border-primary');
            }
        }

        // Close dropdown when clicking outside
        document.addEventListener('click', function (event) {
            const dropdown = document.getElementById('adminProfileDropdown');
            const btn = document.getElementById('adminProfileBtn');

            // Ensure elements exist before checking
            if (dropdown && btn) {
                if (!btn.contains(event.target) && !dropdown.contains(event.target)) {
                    dropdown.classList.add('hidden');
                    btn.classList.remove('ring-4', 'ring-primary/20', 'border-primary');
                }
            }
        });

        // Close on Escape key
        document.addEventListener('keydown', function (event) {
            if (event.key === 'Escape') {
                const dropdown = document.getElementById('adminProfileDropdown');
                const btn = document.getElementById('adminProfileBtn');
                if (dropdown && btn) {
                    dropdown.classList.add('hidden');
                    btn.classList.remove('ring-4', 'ring-primary/20', 'border-primary');
                }
            }
        });
    </script>