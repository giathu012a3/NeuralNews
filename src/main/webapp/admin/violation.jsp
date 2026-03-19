<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
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

            <body class="bg-[#F8FAFC] dark:bg-[#0B1117] font-sans text-slate-900 dark:text-slate-100 overflow-hidden">
                <div class="flex h-screen overflow-hidden">
                    <jsp:include page="components/sidebar.jsp">
                        <jsp:param name="activePage" value="violation" />
                    </jsp:include>
                    
                    <main class="flex-1 ml-64 flex flex-col min-w-0 bg-[#F8FAFC] dark:bg-[#0B1117] transition-all duration-300 relative">
                        <!-- Header Cải tiến -->
                        <header class="bg-white/80 dark:bg-slate-900/80 backdrop-blur-md sticky top-0 z-10 px-8 py-5 flex items-center justify-between border-b border-slate-200/60 dark:border-slate-800/60">
                            <div>
                                <h2 class="text-2xl font-black text-slate-800 dark:text-white tracking-tight flex items-center gap-2">
                                    Xử lý Vi phạm
                                    <span class="material-symbols-outlined text-primary text-xl">gavel</span>
                                </h2>
                                <p class="text-[10px] font-bold text-slate-400 uppercase tracking-widest mt-1">Quản lý nội dung báo cáo vi phạm</p>
                            </div>
                            <div class="flex items-center gap-4">
                                <div class="hidden md:flex flex-col items-end mr-2">
                                    <div class="flex items-center gap-1.5">
                                        <div class="w-1.5 h-1.5 rounded-full bg-green-500 animate-pulse"></div>
                                        <span class="text-[10px] font-black text-slate-500 uppercase">Hàng đợi: ${reports.size()} yêu cầu</span>
                                    </div>
                                </div>
                                <jsp:include page="components/header_profile.jsp" />
                            </div>
                        </header>

                        <!-- Điều hướng Tab và Lọc -->
                        <div class="px-8 bg-white dark:bg-slate-900 border-b border-slate-200 dark:border-slate-800 flex items-end justify-between shrink-0">
                            <div class="flex items-end">
                                <a href="${pageContext.request.contextPath}/admin/violation?targetType=ARTICLE&status=${currentStatus}" 
                                   class="group relative py-4 px-6 text-sm font-bold transition-all ${currentTargetType == 'ARTICLE' ? 'text-primary' : 'text-slate-400 hover:text-slate-600 dark:hover:text-slate-200'}">
                                    <span class="relative z-10 flex items-center gap-2">
                                        <span class="material-symbols-outlined text-[18px]">article</span>
                                        Bài viết
                                    </span>
                                    <c:if test="${currentTargetType == 'ARTICLE'}">
                                        <div class="absolute bottom-0 left-0 right-0 h-1 bg-primary rounded-t-full shadow-[0_-2px_10px_rgba(13,127,242,0.4)]"></div>
                                    </c:if>
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/violation?targetType=COMMENT&status=${currentStatus}"
                                   class="group relative py-4 px-6 text-sm font-bold transition-all ${currentTargetType == 'COMMENT' ? 'text-primary' : 'text-slate-400 hover:text-slate-600 dark:hover:text-slate-200'}">
                                    <span class="relative z-10 flex items-center gap-2">
                                        <span class="material-symbols-outlined text-[18px]">forum</span>
                                        Bình luận
                                    </span>
                                    <c:if test="${currentTargetType == 'COMMENT'}">
                                        <div class="absolute bottom-0 left-0 right-0 h-1 bg-primary rounded-t-full shadow-[0_-2px_10px_rgba(13,127,242,0.4)]"></div>
                                    </c:if>
                                </a>
                            </div>
                            
                            <!-- Bảng điều khiển Lọc Trạng Thái -->
                            <form action="${pageContext.request.contextPath}/admin/violation" method="GET" class="mb-3 flex items-center gap-3">
                                <input type="hidden" name="targetType" value="${currentTargetType}">
                                <label for="statusFilter" class="text-xs font-black text-slate-500 dark:text-slate-400 uppercase tracking-wider">Trạng thái:</label>
                                <select id="statusFilter" name="status" onchange="this.form.submit()"
                                        class="bg-slate-50 dark:bg-[#0F172A] border border-slate-200 dark:border-slate-700 text-slate-700 dark:text-slate-300 text-xs rounded-xl focus:ring-2 focus:ring-primary/20 focus:border-primary block py-2 px-3 font-bold outline-none cursor-pointer transition-all shadow-sm">
                                    <option value="PENDING" ${currentStatus == 'PENDING' ? 'selected' : ''}>Chờ xử lý</option>
                                    <option value="RESOLVED" ${currentStatus == 'RESOLVED' ? 'selected' : ''}>Đã gỡ / Cấm</option>
                                    <option value="DISMISSED" ${currentStatus == 'DISMISSED' ? 'selected' : ''}>Đã giữ lại (Hợp lệ)</option>
                                </select>
                            </form>
                        </div>

                        <!-- Danh sách báo cáo Full-width -->
                        <div class="flex-1 overflow-y-auto bg-slate-50/50 dark:bg-black/20 custom-scrollbar p-8">
                            <div class="max-w-7xl mx-auto space-y-4" id="reportsListContainer">
                                <c:forEach var="r" items="${reports}">
                                    <div class="report-row group bg-white dark:bg-slate-900 rounded-2xl border border-slate-200 dark:border-slate-800 p-6 shadow-sm hover:shadow-xl hover:border-primary/30 transition-all duration-300 cursor-pointer flex items-center gap-6"
                                         onclick="loadReportDetails(${r.id})" data-id="${r.id}">
                                        
                                        <!-- Loại vi phạm Icon -->
                                        <div class="w-14 h-14 rounded-2xl bg-slate-50 dark:bg-slate-800 border border-slate-100 dark:border-slate-700 flex items-center justify-center text-slate-400 group-hover:text-primary group-hover:bg-primary/5 transition-all">
                                            <span class="material-symbols-outlined text-2xl">
                                                ${currentTargetType == 'ARTICLE' ? 'article' : 'forum'}
                                            </span>
                                        </div>

                                        <div class="flex-1 min-w-0">
                                            <div class="flex items-center gap-3 mb-1">
                                                <h3 class="text-base font-bold text-slate-800 dark:text-white truncate tracking-tight">
                                                    ${r.targetTitle}
                                                </h3>
                                                <c:if test="${r.reportCount > 1}">
                                                    <span class="bg-red-500 text-white text-[9px] font-black px-2 py-0.5 rounded-full uppercase">
                                                        ${r.reportCount} BÁO CÁO
                                                    </span>
                                                </c:if>
                                            </div>
                                            
                                            <div class="flex flex-wrap items-center gap-x-6 gap-y-1">
                                                <span class="text-[11px] font-bold text-slate-400 uppercase flex items-center gap-1.5">
                                                    <span class="material-symbols-outlined text-[14px]">person</span>
                                                    Tác giả: <span class="text-slate-700 dark:text-slate-200">${r.authorName}</span>
                                                </span>
                                                <span class="text-[11px] font-bold text-slate-400 uppercase flex items-center gap-1.5">
                                                    <span class="material-symbols-outlined text-[14px]">category</span>
                                                    ${r.section}
                                                </span>
                                                <span class="text-[11px] font-bold text-slate-400 uppercase flex items-center gap-1.5">
                                                    <span class="material-symbols-outlined text-[14px]">schedule</span>
                                                    ${r.createdAt}
                                                </span>
                                            </div>
                                        </div>

                                        <!-- Preview lý do -->
                                        <div class="hidden lg:flex flex-wrap gap-1.5 max-w-[300px] justify-end">
                                            <c:forEach var="rsn" items="${r.reason.split(', ')}" varStatus="vs">
                                                <c:if test="${vs.index < 2}">
                                                    <span class="px-2.5 py-1 bg-slate-100 dark:bg-slate-800 text-[10px] font-bold text-slate-500 rounded-lg border border-slate-200 dark:border-slate-700 uppercase">
                                                        ${rsn}
                                                    </span>
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${r.reason.split(', ').length > 2}">
                                                <span class="px-2.5 py-1 bg-primary/5 text-[10px] font-bold text-primary rounded-lg border border-primary/20">
                                                    +${r.reason.split(', ').length - 2}
                                                </span>
                                            </c:if>
                                        </div>

                                        <div class="shrink-0">
                                            <span class="material-symbols-outlined text-slate-300 group-hover:text-primary group-hover:translate-x-1 transition-all">chevron_right</span>
                                        </div>
                                    </div>
                                </c:forEach>

                                <c:if test="${empty reports}">
                                    <div class="py-32 text-center">
                                        <div class="w-24 h-24 bg-white dark:bg-slate-800 rounded-[2.5rem] shadow-xl flex items-center justify-center border border-slate-100 dark:border-slate-700 mx-auto mb-6">
                                            <span class="material-symbols-outlined text-5xl text-slate-200">check_circle</span>
                                        </div>
                                        <h3 class="text-xl font-black text-slate-800 dark:text-white mb-2 italic">Hàng chờ sạch bóng!</h3>
                                        <p class="text-slate-400 text-sm">Hiện không có báo cáo nào cần xử lý.</p>
                                    </div>
                                </c:if>
                            </div>
                        </div>

                        <!-- Sidebar Chi tiết (Overlay Drawer) -->
                        <div id="reportSidebarOverlay" onclick="closeReportSidebar()" class="fixed inset-0 bg-slate-900/40 backdrop-blur-sm z-40 hidden transition-opacity duration-300 opacity-0"></div>
                        
                        <aside id="reportDetailsSidebar"
                            class="fixed top-0 right-0 bottom-0 w-[500px] bg-white dark:bg-[#0F172A] z-50 flex flex-col shadow-[-20px_0_60px_rgba(0,0,0,0.15)] transition-transform duration-500 transform translate-x-full overflow-hidden">
                            <!-- Sidebar Header -->
                            <div class="p-8 border-b border-slate-100 dark:border-slate-800 bg-white/50 dark:bg-white/[0.02] backdrop-blur-sm sticky top-0 z-10">
                                <div class="flex items-start justify-between mb-6">
                                    <div>
                                        <p class="text-[10px] font-black text-primary uppercase tracking-[0.2em] mb-1" id="sidebarBreadcrumb">Kiểm duyệt</p>
                                        <h3 class="text-2xl font-black text-slate-800 dark:text-white tracking-tight" id="displayReportId">#REP-001</h3>
                                    </div>
                                    <button onclick="closeReportSidebar()"
                                            class="w-10 h-10 flex items-center justify-center hover:bg-slate-100 dark:hover:bg-slate-800 rounded-full transition-all text-slate-400">
                                        <span class="material-symbols-outlined font-bold">close</span>
                                    </button>
                                </div>
                                
                                <div class="flex items-center justify-between p-5 bg-slate-50 dark:bg-black/40 rounded-2xl border border-slate-100 dark:border-slate-800">
                                    <div class="flex items-center gap-4">
                                        <div class="w-12 h-12 rounded-xl bg-primary/10 flex items-center justify-center text-primary">
                                            <span class="material-symbols-outlined text-2xl" id="targetIcon">description</span>
                                        </div>
                                        <div class="min-w-0">
                                            <p class="text-[10px] font-bold text-slate-400 uppercase leading-none mb-1.5">Thông tin Đối tượng</p>
                                            <p id="displayTargetInfo" class="text-sm font-black text-slate-800 dark:text-slate-100 truncate">ID: 102 • Bài viết</p>
                                        </div>
                                    </div>
                                    <a id="viewArticleBtn" href="#" target="_blank"
                                       class="flex items-center gap-2 px-4 py-2 bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-xl text-xs font-bold shadow-sm hover:scale-105 active:scale-95 transition-all text-primary">
                                        Xem <span class="material-symbols-outlined text-[16px]">open_in_new</span>
                                    </a>
                                </div>
                            </div>

                            <div class="flex-1 overflow-y-auto p-8 space-y-8 custom-scrollbar">
                                <!-- Thông tin tác giả -->
                                <section>
                                    <h4 class="text-[10px] font-black text-slate-400 uppercase tracking-widest mb-4">Thông tin Tác giả</h4>
                                    <div class="flex items-center gap-4 bg-slate-50 dark:bg-black/20 p-5 rounded-2xl border border-slate-100 dark:border-slate-800">
                                        <div class="w-14 h-14 rounded-full bg-primary/10 flex items-center justify-center font-black text-primary text-lg" id="authorAvatar">JD</div>
                                        <div>
                                            <p id="displayAuthorName" class="text-base font-black text-slate-800 dark:text-white leading-none mb-1.5">John Doe</p>
                                            <p class="text-[10px] text-slate-500 font-bold uppercase tracking-tighter flex items-center gap-1">
                                                <span class="w-1.5 h-1.5 rounded-full bg-green-500"></span>
                                                Thành viên Hệ thống
                                            </p>
                                        </div>
                                    </div>
                                </section>

                                <!-- Lý do vi phạm -->
                                <section>
                                    <h4 class="text-[10px] font-black text-slate-400 uppercase tracking-widest mb-4">Lý do bị báo cáo</h4>
                                    <div id="displayReasons" class="flex flex-wrap gap-2">
                                        <!-- Will be populated by JS -->
                                    </div>
                                </section>

                                <!-- Đoạn trích vi phạm -->
                                <section>
                                    <h4 class="text-[10px] font-black text-slate-400 uppercase tracking-widest mb-4">Nội dung / Bằng chứng</h4>
                                    <div class="relative bg-slate-50 dark:bg-black/20 p-6 rounded-2xl border border-slate-100 dark:border-slate-800">
                                        <span class="material-icons absolute -top-3 left-4 text-primary bg-white dark:bg-slate-900 rounded-full p-1 shadow-sm text-lg">format_quote</span>
                                        <p id="displaySnippet" class="text-sm text-slate-600 dark:text-slate-300 leading-relaxed italic pr-4">
                                            <!-- Will be populated by JS -->
                                        </p>
                                    </div>
                                </section>

                                <!-- Lời nhắn từ người báo cáo -->
                                <section id="detailsSection">
                                    <h4 class="text-[10px] font-black text-slate-400 uppercase tracking-widest mb-4">Mô tả vi phạm từ người dùng</h4>
                                    <div class="relative bg-amber-50 dark:bg-amber-900/10 p-6 rounded-2xl border border-amber-200 dark:border-amber-800/30">
                                        <span class="material-symbols-outlined absolute -top-3 right-4 text-amber-500 bg-white dark:bg-slate-900 rounded-full p-1 shadow-sm text-lg">campaign</span>
                                        <p id="displayDetails" class="text-sm text-slate-700 dark:text-slate-300 leading-relaxed font-medium">
                                            <!-- Will be populated by JS -->
                                        </p>
                                    </div>
                                </section>
                            </div>

                            <!-- Footer Actions -->
                            <input type="hidden" id="currentReportId" value="">
                            <c:if test="${currentStatus == 'PENDING'}">
                                <div class="mt-auto p-8 bg-slate-50 dark:bg-slate-800/50 border-t border-slate-100 dark:border-slate-800">
                                    <div class="grid grid-cols-2 gap-4 mb-4">
                                        <button onclick="handleAction('dismiss')"
                                                class="flex flex-col items-center justify-center gap-2 px-4 py-4 bg-white dark:bg-slate-900 border border-slate-300 dark:border-slate-700 hover:border-slate-400 dark:hover:border-slate-500 rounded-2xl text-slate-700 dark:text-slate-300 font-black shadow-sm hover:shadow active:scale-95 transition-all outline-none focus:ring-2 focus:ring-slate-200">
                                            <span class="material-symbols-outlined font-bold">verified</span>
                                            <span>Giữ lại (Hợp lệ)</span>
                                        </button>
                                        <button onclick="handleAction('take_down')"
                                                class="flex flex-col items-center justify-center gap-2 px-4 py-4 bg-[#F59E0B] hover:bg-[#D97706] rounded-2xl text-white font-black shadow-lg shadow-amber-500/20 active:scale-95 transition-all outline-none focus:ring-2 focus:ring-amber-500/50">
                                            <span class="material-symbols-outlined font-bold">delete</span>
                                            <span>Gỡ bỏ nội dung</span>
                                        </button>
                                    </div>
                                    <button onclick="handleAction('suspend')"
                                            class="w-full flex items-center justify-center gap-2 px-6 py-4 bg-[#DC2626] hover:bg-[#B91C1C] rounded-2xl text-white font-black uppercase tracking-wide shadow-lg shadow-red-500/20 active:scale-95 transition-all outline-none focus:ring-2 focus:ring-red-500/50">
                                        <span class="material-symbols-outlined font-bold">person_off</span>
                                        <span>Khóa tài khoản người dùng</span>
                                    </button>
                                </div>
                            </c:if>
                            <c:if test="${currentStatus != 'PENDING'}">
                                <div class="mt-auto p-8 bg-slate-50 dark:bg-slate-800/50 border-t border-slate-100 dark:border-slate-800 flex flex-col items-center justify-center text-slate-500">
                                    <span class="material-symbols-outlined text-4xl mb-2 opacity-50">done_all</span>
                                    <p class="font-bold text-sm">Báo cáo này đã được xử lý</p>
                                    <p class="text-xs text-slate-400 mt-1 uppercase">Vui lòng dùng tính năng quản lý bài viết/users để phục hồi</p>
                                </div>
                            </c:if>
                        </aside>
                    </main>
                </div>

                <script src="${pageContext.request.contextPath}/assets/js/admin-violation.js"></script>
            </body>
        </html>