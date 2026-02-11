<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <aside class="w-64 bg-background-dark text-white flex-shrink-0 flex flex-col fixed h-full z-50">
        <div class="p-6 flex items-center gap-3">
            <div class="w-10 h-10 bg-primary rounded-lg flex items-center justify-center">
                <span class="material-icons text-white">bolt</span>
            </div>
            <h1 class="text-xl font-bold tracking-tight">NexusAI</h1>
        </div>
        <nav class="flex-1 mt-6 px-4 space-y-2">
            <a class="${param.activePage == 'dashboard' ? 'sidebar-active' : 'text-slate-400 hover:text-white hover:bg-slate-800'} flex items-center gap-3 px-4 py-3 rounded-lg transition-all"
                href="${pageContext.request.contextPath}/admin/home.jsp">
                <span class="material-icons text-[20px]">dashboard</span>
                <span class="font-medium">Dashboard</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/users.jsp"
                class="${param.activePage == 'users' ? 'sidebar-active' : 'text-slate-400 hover:text-white hover:bg-slate-800'} flex items-center gap-3 px-4 py-3 rounded-lg transition-all">
                <span class="material-icons text-[20px]">people</span>
                <span class="font-medium">User Management</span>
            </a>
            <a href="${pageContext.request.contextPath}/admin/permissions.jsp"
                class="${param.activePage == 'permissions' ? 'sidebar-active' : 'text-slate-400 hover:text-white hover:bg-slate-800'} flex items-center gap-3 px-4 py-3 rounded-lg transition-all">
                <span class="material-icons text-[20px]">verified_user</span>
                <span class="font-medium">Permissions</span>
            </a>


            <a class="${param.activePage == 'content' ? 'sidebar-active' : 'text-slate-400 hover:text-white hover:bg-slate-800'} flex items-center gap-3 px-4 py-3 rounded-lg transition-all"
                href="${pageContext.request.contextPath}/admin/content.jsp">
                <span class="material-icons text-[20px]">article</span>
                <span class="font-medium">Content Management</span>
            </a>
            <a class="${param.activePage == 'violation' ? 'sidebar-active' : 'text-slate-400 hover:text-white hover:bg-slate-800'} flex items-center gap-3 px-4 py-3 rounded-lg transition-all"
                href="${pageContext.request.contextPath}/admin/violation.jsp">
                <span class="material-icons text-[20px]">gavel</span>
                <span class="font-medium">Violation Handling</span>
            </a>
            <a class="${param.activePage == 'layout' ? 'sidebar-active' : 'text-slate-400 hover:text-white hover:bg-slate-800'} flex items-center gap-3 px-4 py-3 rounded-lg transition-all"
                href="${pageContext.request.contextPath}/admin/layout.jsp">
                <span class="material-icons text-[20px]">palette</span>
                <span class="font-medium">Layout Customization</span>
            </a>
            <a class="${param.activePage == 'ai' ? 'sidebar-active' : 'text-slate-400 hover:text-white hover:bg-slate-800'} flex items-center gap-3 px-4 py-3 rounded-lg transition-all"
                href="#">
                <span class="material-icons text-[20px]">psychology</span>
                <span class="font-medium">AI Configuration</span>
            </a>
            <a class="flex items-center gap-3 px-4 py-3 rounded-lg hover:bg-slate-800 transition-all text-slate-400 hover:text-white"
                href="${pageContext.request.contextPath}/logout">
                <span class="material-icons text-[20px]">logout</span>
                <span class="font-medium">Logout</span>
            </a>
        </nav>
        <div class="p-4 mt-auto">
            <div class="bg-slate-800/50 p-4 rounded-xl">
                <p class="text-xs text-slate-400 uppercase font-bold tracking-wider mb-2">System Status</p>
                <div class="flex items-center gap-2">
                    <div class="w-2 h-2 rounded-full bg-green-500 animate-pulse"></div>
                    <span class="text-sm">Global Core Online</span>
                </div>
            </div>
        </div>
    </aside>