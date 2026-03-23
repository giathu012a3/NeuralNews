<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <jsp:include page="components/head.jsp" />
    <title>Cấu hình AI | NexusAI Admin</title>
</head>
<body class="bg-[#F4F7FE] dark:bg-background-dark font-sans text-slate-800 dark:text-slate-100 overflow-hidden">
    <div class="flex min-h-screen">
        <jsp:include page="components/sidebar.jsp">
            <jsp:param name="activePage" value="ai" />
        </jsp:include>

        <main class="flex-1 ml-64 min-h-screen flex flex-col overflow-y-auto">
            <header class="sticky top-0 z-40 bg-[#F4F7FE]/90 dark:bg-background-dark/90 backdrop-blur-md px-8 py-6 border-b border-slate-200/50 dark:border-slate-800/50">
                <div class="flex items-center justify-between">
                    <div>
                        <h2 class="text-2xl font-bold text-slate-900 dark:text-white">Cấu hình Trí tuệ Nhân tạo</h2>
                        <p class="text-sm text-slate-500 mt-1">Quản lý các kết nối API và mô hình AI cho hệ thống.</p>
                    </div>
                    <div class="flex items-center gap-4">
                        <jsp:include page="components/header_profile.jsp" />
                    </div>
                </div>
            </header>

            <div class="p-8 max-w-4xl">
                <c:if test="${not empty successMsg}">
                    <div class="mb-6 p-4 bg-emerald-50 border border-emerald-200 text-emerald-700 rounded-xl flex items-center gap-3">
                        <span class="material-icons">check_circle</span>
                        <p class="text-sm font-medium">${successMsg}</p>
                    </div>
                </c:if>
                <c:if test="${not empty errorMsg}">
                    <div class="mb-6 p-4 bg-rose-50 border border-rose-200 text-rose-700 rounded-xl flex items-center gap-3">
                        <span class="material-icons">error</span>
                        <p class="text-sm font-medium">${errorMsg}</p>
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin/ai-settings" method="POST" class="space-y-6">
                    <section class="bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-2xl p-6 md:p-8 shadow-sm">
                        <div class="flex items-center gap-2 mb-8">
                            <span class="material-icons text-primary">psychology</span>
                            <h3 class="font-bold text-lg text-slate-900 dark:text-white">Google Gemini API</h3>
                        </div>
                        
                        <div class="space-y-6">
                            <div class="space-y-2">
                                <label class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider ml-1">API Key</label>
                                <div class="relative">
                                    <input name="gemini_api_key" id="apiKeyInput"
                                        class="w-full bg-slate-50 dark:bg-slate-900/50 border border-slate-200 dark:border-slate-700 rounded-xl px-4 py-3 text-sm focus:ring-primary focus:border-primary transition-all outline-none font-mono"
                                        type="password" value="${settings.stream().filter(s -> s.settingKey == 'gemini_api_key').findFirst().get().settingValue}" />
                                    <button type="button" onclick="togglePassword()" class="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600">
                                        <span class="material-icons text-xl" id="toggleIcon">visibility_off</span>
                                    </button>
                                </div>
                                <p class="text-[10px] text-slate-400 mt-2 italic px-1">Lưu ý: API Key này được dùng để tóm tắt bài viết bằng AI.</p>
                            </div>

                            <div class="space-y-2 opacity-50 cursor-not-allowed">
                                <label class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider ml-1">Model Name</label>
                                <input class="w-full bg-slate-100 dark:bg-slate-800/50 border border-slate-200 dark:border-slate-700 rounded-xl px-4 py-3 text-sm text-slate-500 cursor-not-allowed outline-none"
                                    type="text" value="gemini-1.5-flash" disabled />
                            </div>
                        </div>
                    </section>

                    <div class="flex items-center justify-end gap-3 pt-4">
                        <button type="reset" class="px-4 py-2 text-sm font-bold text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-lg transition-colors">Hủy bỏ</button>
                        <button type="submit" class="px-8 py-2 text-sm font-bold bg-primary text-white rounded-lg hover:bg-primary/90 shadow-lg shadow-primary/20 transition-all flex items-center gap-2">
                            <span class="material-icons text-sm">save</span>
                            Lưu cấu hình
                        </button>
                    </div>
                </form>
            </div>
        </main>
    </div>

    <script>
        function togglePassword() {
            const input = document.getElementById('apiKeyInput');
            const icon = document.getElementById('toggleIcon');
            if (input.type === 'password') {
                input.type = 'text';
                icon.innerText = 'visibility';
            } else {
                input.type = 'password';
                icon.innerText = 'visibility_off';
            }
        }
    </script>
</body>
</html>
