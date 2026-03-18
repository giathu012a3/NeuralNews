<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <jsp:include page="components/head.jsp" />
    <title>User Management | NexusAI Admin</title>
    <script src="${pageContext.request.contextPath}/assets/js/app-utils.js?v=2.0"></script>
    <script src="${pageContext.request.contextPath}/assets/js/admin-user.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            AdminUser.init('${pageContext.request.contextPath}');
        });
    </script>
</head>

<body class="bg-[#F4F7FE] dark:bg-background-dark font-sans text-slate-800 dark:text-slate-100 overflow-hidden">
    <div class="flex min-h-screen">
        <jsp:include page="components/sidebar.jsp">
            <jsp:param name="activePage" value="users" />
        </jsp:include>
        
        <main class="flex-1 ml-64 min-h-screen pb-12">
            <header class="sticky top-0 z-40 bg-[#F4F7FE]/90 dark:bg-background-dark/90 backdrop-blur-md px-8 py-6 border-b border-slate-200/50 dark:border-slate-800/50">
                <div class="flex items-center justify-between">
                    <div>
                        <h2 class="text-2xl font-bold text-slate-900 dark:text-white">Quản lý Người dùng</h2>
                        <p class="text-sm text-slate-500 mt-1">Quản lý người dùng hệ thống, nhà báo và phân quyền quản trị nội bộ.</p>
                    </div>
                    <div class="flex items-center gap-4">
                        <button onclick="openAddUserModal()"
                            class="bg-primary hover:bg-primary/90 text-white px-5 py-2.5 rounded-xl text-sm font-semibold flex items-center gap-2 shadow-lg shadow-primary/20 transition-all">
                            <span class="material-icons text-sm">add</span>
                            Thêm thành viên
                        </button>
                        <jsp:include page="components/header_profile.jsp" />
                    </div>
                </div>
                
                <div class="mt-6 bg-white dark:bg-slate-800 p-4 rounded-xl shadow-sm border border-slate-100 dark:border-slate-700 flex flex-wrap items-end gap-6">
                    <div class="flex-1 min-w-[300px]">
                        <label class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Tìm kiếm người dùng</label>
                        <div class="relative flex items-center group">
                            <span class="material-icons absolute left-3 text-slate-400 group-focus-within:text-primary transition-colors">search</span>
                            <input id="searchUser" oninput="AdminUser.handleSearch()" value="${filterKeyword}"
                                class="w-full pl-10 pr-4 py-2 bg-slate-50 dark:bg-slate-900 border-slate-200 dark:border-slate-700 rounded-lg text-sm focus:ring-2 focus:ring-primary shadow-inner transition-all"
                                placeholder="Tên hoặc email..." type="text" />
                        </div>
                    </div>
                    <div class="w-44">
                        <label class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Quyền hạn</label>
                        <select id="roleSelect" onchange="AdminUser.filterUsers(1)" class="w-full text-sm border-slate-200 dark:border-slate-600 dark:bg-slate-900 rounded-lg focus:ring-primary">
                            <option value="ALL" ${empty filterRole || filterRole == 'ALL' ? 'selected' : ''}>Tất cả</option>
                            <option value="ADMIN" ${filterRole == 'ADMIN' ? 'selected' : ''}>Admin</option>
                            <option value="JOURNALIST" ${filterRole == 'JOURNALIST' ? 'selected' : ''}>Journalist</option>
                            <option value="USER" ${filterRole == 'USER' ? 'selected' : ''}>Member</option>
                        </select>
                    </div>
                    <div class="w-48">
                        <label class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Trạng thái</label>
                        <select id="statusSelect" onchange="AdminUser.filterUsers(1)" class="w-full text-sm border-slate-200 dark:border-slate-600 dark:bg-slate-900 rounded-lg focus:ring-primary">
                            <option value="ALL" ${empty filterStatus || filterStatus == 'ALL' ? 'selected' : ''}>Tất cả</option>
                            <option value="ACTIVE" ${filterStatus == 'ACTIVE' ? 'selected' : ''}>Active</option>
                            <option value="BANNED" ${filterStatus == 'BANNED' ? 'selected' : ''}>Banned</option>
                            <option value="PENDING" ${filterStatus == 'PENDING' ? 'selected' : ''}>Pending</option>
                        </select>
                    </div>
                    <button onclick="AdminUser.resetFilters()" class="px-5 py-2 border border-slate-200 dark:border-slate-600 rounded-lg text-sm font-medium hover:bg-slate-50 dark:hover:bg-slate-700 transition-colors">Xóa bộ lọc</button>
                </div>
            </header>

            <div id="user-table-container" class="p-8 space-y-8 overflow-y-auto max-h-[calc(100vh-200px)]">
                <div id="user-list-wrapper">
                    <%-- Khu vực duyệt nhanh Nhà báo --%>
                <c:if test="${not empty pendingUsers}">
                    <section class="mb-8">
                        <div class="flex items-center justify-between mb-4">
                            <h3 class="text-lg font-bold text-slate-800 dark:text-white flex items-center gap-2">
                                <span class="w-2 h-6 bg-amber-500 rounded-full"></span>
                                Đơn đăng ký Nhà báo chờ duyệt
                            </h3>
                            <span class="px-2.5 py-1 bg-amber-100 text-amber-700 text-xs font-bold rounded-full">${pendingUsers.size()} đơn mới</span>
                        </div>
                        
                        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                            <c:forEach items="${pendingUsers}" var="pu">
                                <div class="bg-white dark:bg-slate-800 p-5 rounded-2xl border border-amber-100 dark:border-amber-900/30 shadow-sm hover:shadow-md transition-all group">
                                    <div class="flex items-start justify-between mb-4">
                                        <div class="flex items-center gap-3">
                                            <div class="relative">
                                                <img src="${not empty pu.avatarUrl ? pu.avatarUrl : 'https://ui-avatars.com/api/?name='.concat(pu.fullName)}" 
                                                     class="w-12 h-12 rounded-full object-cover border-2 border-white shadow-sm" alt="Avatar">
                                                <div class="absolute -bottom-1 -right-1 w-4 h-4 bg-amber-500 border-2 border-white rounded-full"></div>
                                            </div>
                                            <div>
                                                <h4 class="text-sm font-bold text-slate-900 dark:text-white">${pu.fullName}</h4>
                                                <p class="text-[11px] text-slate-500 truncate max-w-[120px]">${pu.email}</p>
                                            </div>
                                        </div>
                                        <button onclick="AdminUser.viewCV(this)" 
                                            data-name="${pu.fullName}" data-email="${pu.email}" data-role="${pu.role.name}"
                                            data-date="<fmt:formatDate value="${pu.createdAt}" pattern="dd/MM/yyyy" />"
                                            data-bio="${pu.bio}" data-exp="${pu.experienceYears}"
                                            class="p-2 text-slate-400 hover:text-primary hover:bg-slate-50 rounded-lg transition-colors" title="Xem CV">
                                            <span class="material-icons text-[20px]">description</span>
                                        </button>
                                    </div>
                                    
                                    <div class="bg-slate-50 dark:bg-slate-900/50 rounded-xl p-3 mb-4">
                                        <div class="flex items-center justify-between text-[11px] mb-1">
                                            <span class="text-slate-500">Kinh nghiệm:</span>
                                            <span class="font-bold text-slate-900 dark:text-white">${pu.experienceYears} năm</span>
                                        </div>
                                        <p class="text-[11px] text-slate-600 dark:text-slate-400 line-clamp-2 italic">
                                            "${not empty pu.bio ? pu.bio : 'Không có giới thiệu...'}"
                                        </p>
                                    </div>
                                    
                                    <div class="flex gap-2">
                                        <button onclick="AdminUser.approveUser(${pu.id}, 'approve')" 
                                            class="flex-1 py-2 bg-emerald-500 hover:bg-emerald-600 text-white text-[11px] font-bold rounded-xl transition-all shadow-lg shadow-emerald-500/20">
                                            Duyệt ngay
                                        </button>
                                        <button onclick="AdminUser.approveUser(${pu.id}, 'reject')" 
                                            class="px-4 py-2 border border-slate-200 dark:border-slate-700 text-slate-400 hover:text-red-500 hover:bg-red-50 rounded-xl transition-all">
                                            <span class="material-icons text-sm">close</span>
                                        </button>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </section>
                </c:if>

                <div id="user-ajax-bundle" class="bg-white dark:bg-slate-800 rounded-2xl shadow-sm border border-slate-200 dark:border-slate-700 overflow-hidden">
                    <div class="overflow-x-auto">
                        <table class="w-full text-left">
                            <thead>
                                <tr class="bg-slate-50 dark:bg-slate-900/50 border-b border-slate-100 dark:border-slate-700">
                                    <th class="px-8 py-5 text-xs font-bold text-slate-400 uppercase tracking-wider">User</th>
                                    <th class="px-6 py-5 text-xs font-bold text-slate-400 uppercase tracking-wider">Email</th>
                                    <th class="px-6 py-5 text-xs font-bold text-slate-400 uppercase tracking-wider">Role</th>
                                    <th class="px-6 py-5 text-xs font-bold text-slate-400 uppercase tracking-wider">Join Date</th>
                                    <th class="px-6 py-5 text-xs font-bold text-slate-400 uppercase tracking-wider">Status</th>
                                    <th class="px-8 py-5 text-xs font-bold text-slate-400 uppercase tracking-wider text-right">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-100 dark:divide-slate-700">
                                <c:forEach items="${users}" var="user">
                                    <tr class="hover:bg-slate-50 dark:hover:bg-slate-700/30 transition-colors group">
                                        <td class="px-8 py-4">
                                            <div class="flex items-center gap-3">
                                                <img alt="Avatar" class="w-9 h-9 rounded-full object-cover"
                                                    src="${not empty user.avatarUrl ? (user.avatarUrl.startsWith('http') ? user.avatarUrl : pageContext.request.contextPath.concat('/').concat(user.avatarUrl)) : 'https://ui-avatars.com/api/?name='.concat(user.fullName)}" />
                                                <p class="text-sm font-semibold text-slate-900 dark:text-white">${user.fullName}</p>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 text-sm text-slate-500 dark:text-slate-400">${user.email}</td>
                                        <td class="px-6 py-4">
                                            <c:choose>
                                                <c:when test="${user.role.name == 'ADMIN'}">
                                                    <span class="px-3 py-1 text-[11px] font-bold rounded-full bg-indigo-500/10 text-indigo-500 uppercase tracking-tight">Admin</span>
                                                </c:when>
                                                <c:when test="${user.role.name == 'JOURNALIST'}">
                                                    <span class="px-3 py-1 text-[11px] font-bold rounded-full bg-emerald-500/10 text-emerald-500 uppercase tracking-tight">Journalist</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-3 py-1 text-[11px] font-bold rounded-full bg-slate-500/10 text-slate-500 uppercase tracking-tight">Member</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-6 py-4 text-sm text-slate-500">
                                            <fmt:formatDate value="${user.createdAt}" pattern="MMM dd, yyyy" />
                                        </td>
                                        <td class="px-6 py-4">
                                            <span class="flex items-center gap-1.5 text-sm font-medium ${user.status == 'ACTIVE' ? 'text-blue-500' : (user.status == 'BANNED' ? 'text-red-500' : 'text-amber-500')}">
                                                <span class="w-1.5 h-1.5 rounded-full ${user.status == 'ACTIVE' ? 'bg-blue-500' : (user.status == 'BANNED' ? 'bg-red-500' : 'bg-amber-500')}"></span>
                                                ${user.status}
                                            </span>
                                        </td>
                                        <td class="px-8 py-4 text-right">
                                            <div class="flex justify-end gap-1 opacity-0 group-hover:opacity-100 transition-opacity">
                                                <button onclick="AdminUser.viewCV(this)" 
                                                    data-name="${user.fullName}"
                                                    data-email="${user.email}"
                                                    data-role="${user.role.name}"
                                                    data-date="<fmt:formatDate value="${user.createdAt}" pattern="dd/MM/yyyy" />"
                                                    data-bio="${user.bio}"
                                                    data-exp="${user.experienceYears}"
                                                    class="p-2 text-slate-400 hover:text-indigo-500 hover:bg-indigo-50 rounded-lg transition-all" title="Xem CV">
                                                    <span class="material-icons text-[18px]">visibility</span>
                                                </button>
                                                
                                                <c:if test="${user.status == 'PENDING'}">
                                                    <button onclick="AdminUser.approveUser(${user.id}, 'approve')" class="p-2 text-emerald-500 hover:bg-emerald-50 rounded-lg transition-all" title="Phê duyệt">
                                                        <span class="material-icons text-[18px]">check_circle</span>
                                                    </button>
                                                    <button onclick="AdminUser.approveUser(${user.id}, 'reject')" class="p-2 text-red-500 hover:bg-red-50 rounded-lg transition-all" title="Từ chối">
                                                        <span class="material-icons text-[18px]">cancel</span>
                                                    </button>
                                                </c:if>

                                                <c:if test="${user.status != 'PENDING'}">
                                                    <button class="p-2 text-slate-400 hover:text-primary hover:bg-primary/10 rounded-lg transition-all" title="Edit">
                                                        <span class="material-icons text-[18px]">edit</span>
                                                    </button>
                                                    <c:if test="${user.status != 'BANNED'}">
                                                        <button class="p-2 text-slate-400 hover:text-amber-500 hover:bg-amber-50 rounded-lg transition-all" title="Ban">
                                                            <span class="material-icons text-[18px]">lock</span>
                                                        </button>
                                                    </c:if>
                                                    <c:if test="${user.status == 'BANNED'}">
                                                        <button class="p-2 text-blue-500 hover:bg-blue-50 rounded-lg transition-all" title="Unban">
                                                            <span class="material-icons text-[18px]">lock_open</span>
                                                        </button>
                                                    </c:if>
                                                    <button onclick="AdminUser.approveUser(${user.id}, 'delete')" class="p-2 text-slate-400 hover:text-red-500 hover:bg-red-50 rounded-lg transition-all" title="Delete">
                                                        <span class="material-icons text-[18px]">delete</span>
                                                    </button>
                                                </c:if>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty users}">
                                    <tr>
                                        <td colspan="6" class="px-8 py-12 text-center text-slate-500">No users found matching your criteria.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                    
                    <!-- Pagination -->
                    <div class="px-8 py-5 border-t border-slate-100 dark:border-slate-700 flex items-center justify-between">
                        <p class="text-sm text-slate-500">
                            Showing <span class="font-semibold text-slate-900 dark:text-white">${(currentPage - 1) * 10 + 1}</span> 
                            to <span class="font-semibold text-slate-900 dark:text-white">${(currentPage * 10) > totalUsers ? totalUsers : (currentPage * 10)}</span> 
                            of <span class="font-semibold text-slate-900 dark:text-white">${totalUsers}</span> users
                        </p>
                        <div class="flex items-center gap-2">
                            <button onclick="AdminUser.filterUsers(${currentPage - 1})" ${currentPage == 1 ? 'disabled' : ''}
                                class="p-2 rounded-lg border border-slate-200 dark:border-slate-700 hover:bg-slate-50 dark:hover:bg-slate-700 disabled:opacity-50 transition-all">
                                <span class="material-icons text-sm">chevron_left</span>
                            </button>
                            
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <button onclick="AdminUser.filterUsers(${i})"
                                    class="w-9 h-9 flex items-center justify-center rounded-lg ${currentPage == i ? 'bg-primary text-white shadow-md shadow-primary/20' : 'hover:bg-slate-50 dark:hover:bg-slate-700 text-sm font-medium'}">
                                    ${i}
                                </button>
                            </c:forEach>

                            <button onclick="AdminUser.filterUsers(${currentPage + 1})" ${currentPage == totalPages ? 'disabled' : ''}
                                class="p-2 rounded-lg border border-slate-200 dark:border-slate-700 hover:bg-slate-50 dark:hover:bg-slate-700 disabled:opacity-50 transition-all">
                                <span class="material-icons text-sm">chevron_right</span>
                            </button>
                        </div>
                    </div>
                </div> <%-- Hết user-list-wrapper --%>
            </div>
        </main>
    </div>

    <!-- Modals (Add User, etc) -->
    <div id="addUserModal" class="fixed inset-0 z-[100] modal-overlay flex items-center justify-center p-4 hidden">
         <div class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm transition-opacity" onclick="closeAddUserModal()"></div>
         <div class="bg-white dark:bg-slate-900 w-full max-w-md rounded-2xl shadow-2xl relative overflow-hidden flex flex-col z-10 transition-all transform scale-100">
             <div class="px-6 py-4 border-b border-slate-100 dark:border-slate-800 flex items-center justify-between bg-white dark:bg-slate-900 z-10">
                 <h2 class="text-lg font-bold text-slate-900 dark:text-white">Add New Member</h2>
                 <button onclick="closeAddUserModal()" class="text-slate-400 hover:text-slate-600 dark:hover:text-slate-200 transition-colors">
                     <span class="material-icons">close</span>
                 </button>
             </div>
             <!-- ... Add User Form Content (Simplified for now) ... -->
             <div class="p-6">
                 <p class="text-sm text-slate-600">Form functionality can be added here.</p>
             </div>
             <div class="px-6 py-4 border-t border-slate-100 dark:border-slate-800 bg-slate-50 dark:bg-slate-900/50 flex gap-3">
                 <button onclick="closeAddUserModal()" class="flex-1 px-4 py-2.5 text-sm font-bold text-slate-600 dark:text-slate-400 hover:bg-slate-200 dark:hover:bg-slate-800 rounded-xl transition-colors">Cancel</button>
                 <button class="flex-1 px-4 py-2.5 text-sm font-bold bg-primary text-white hover:bg-primary/90 rounded-xl shadow-lg shadow-primary/20 transition-all">Create Account</button>
             </div>
         </div>
    </div>

    <script>
        function openAddUserModal() { document.getElementById('addUserModal').classList.remove('hidden'); }
        function closeAddUserModal() { document.getElementById('addUserModal').classList.add('hidden'); }
    </script>

    <!-- CV Modal -->
    <div id="cvModal" class="fixed inset-0 z-[101] flex items-center justify-center p-4 hidden">
        <div class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm" onclick="AdminUser.closeCV()"></div>
        <div class="bg-white dark:bg-slate-900 w-full max-w-lg rounded-2xl shadow-2xl relative overflow-hidden z-10 animate-in fade-in zoom-in duration-200">
            <div class="bg-gradient-to-r from-indigo-600 to-primary p-6 text-white">
                <div class="flex justify-between items-start">
                    <div>
                        <h2 id="cvName" class="text-2xl font-bold">Tên Người Dùng</h2>
                        <p id="cvEmail" class="text-indigo-100 text-sm">email@example.com</p>
                    </div>
                    <button onclick="AdminUser.closeCV()" class="text-white/80 hover:text-white"><span class="material-icons">close</span></button>
                </div>
                <div class="mt-4 flex gap-3">
                    <span class="px-2 py-0.5 bg-white/20 rounded text-[10px] font-bold uppercase" id="cvRole">JOURNALIST</span>
                    <span class="px-2 py-0.5 bg-white/20 rounded text-[10px] font-bold uppercase" id="cvDate">12/03/2026</span>
                </div>
            </div>
            <div class="p-6 space-y-6">
                <div>
                    <h3 class="text-xs font-bold text-slate-400 uppercase tracking-wider mb-2">Kinh nghiệm làm việc</h3>
                    <div class="bg-slate-50 dark:bg-slate-800 p-4 rounded-xl border border-slate-100 dark:border-slate-700">
                        <p id="cvExp" class="text-lg font-bold text-primary">5 năm</p>
                    </div>
                </div>
                <div>
                    <h3 class="text-xs font-bold text-slate-400 uppercase tracking-wider mb-2">Giới thiệu bản thân</h3>
                    <div class="bg-slate-50 dark:bg-slate-800 p-4 rounded-xl border border-slate-100 dark:border-slate-700 min-h-[100px]">
                        <p id="cvBio" class="text-sm text-slate-600 dark:text-slate-300 leading-relaxed italic"></p>
                    </div>
                </div>
            </div>
            <div class="px-6 py-4 border-t border-slate-100 dark:border-slate-800 flex justify-end">
                <button onclick="AdminUser.closeCV()" class="px-6 py-2 bg-slate-100 dark:bg-slate-800 text-slate-600 dark:text-slate-300 rounded-lg font-bold hover:bg-slate-200">Đóng</button>
            </div>
        </div>
    </div>
</body>
</html>
