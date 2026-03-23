<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<div id="user-ajax-bundle" class="space-y-6">
    <!-- PENDING Journalist Applications -->
    <c:if test="${(empty filterKeyword) and (empty filterRole or filterRole == 'ALL') and (empty filterStatus or filterStatus == 'ALL') and (not empty pendingUsers) and (currentPage == 1)}">
        <section class="animate-in fade-in slide-in-from-top-4 duration-500">
            <div class="flex items-center justify-between mb-4">
                <h3 class="text-sm font-bold text-slate-800 dark:text-white flex items-center gap-2">
                    <span class="w-1.5 h-1.5 bg-amber-500 rounded-full animate-pulse"></span>
                    Đơn đăng ký Nhà báo mới
                </h3>
            </div>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
                <c:forEach items="${pendingUsers}" var="pu">
                    <div class="bg-white dark:bg-slate-800 p-4 rounded-2xl border border-amber-100 dark:border-amber-900/30 shadow-sm hover:shadow-md transition-all">
                        <div class="flex items-start justify-between mb-4">
                            <div class="flex items-center gap-3">
                                <img src="${not empty pu.avatarUrl ? pu.avatarUrl : 'https://ui-avatars.com/api/?name='.concat(pu.fullName)}" 
                                     class="w-10 h-10 rounded-full object-cover grayscale group-hover:grayscale-0 transition-all" alt="Avatar">
                                <div>
                                    <h4 class="text-sm font-bold text-slate-800 dark:text-white leading-tight">${pu.fullName}</h4>
                                    <p class="text-[10px] text-slate-400 font-medium">${pu.email}</p>
                                </div>
                            </div>
                            <button onclick="AdminUser.viewCV(this)" 
                                data-name="${pu.fullName}" data-email="${pu.email}" data-role="JOURNALIST"
                                data-date="<fmt:formatDate value="${pu.createdAt}" pattern="dd/MM/yyyy" />"
                                data-bio="${pu.bio}" data-exp="${pu.experienceYears}"
                                class="w-8 h-8 flex items-center justify-center text-slate-400 hover:text-primary hover:bg-primary/5 rounded-lg transition-colors">
                                <span class="material-icons text-[18px]">contact_page</span>
                            </button>
                        </div>
                        <div class="flex gap-2">
                            <button onclick="AdminUser.approveUser(${pu.id}, 'approve')" class="flex-1 py-1.5 bg-emerald-500 text-white text-[10px] font-bold rounded-lg hover:bg-emerald-600 transition-all shadow-lg shadow-emerald-500/10">Phê duyệt</button>
                            <button onclick="AdminUser.approveUser(${pu.id}, 'reject')" class="px-3 py-1.5 border border-amber-200 text-amber-600 hover:bg-amber-50 rounded-lg transition-all" title="Từ chối đơn"><span class="material-icons text-sm">cancel</span></button>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>
    </c:if>

    <!-- Main User List Table -->
    <div class="bg-white dark:bg-slate-800 rounded-2xl shadow-sm border border-slate-100 dark:border-slate-700 overflow-hidden">
        <!-- Table Toolbar -->
        <div class="px-6 py-4 bg-slate-50/50 dark:bg-slate-900/20 border-b border-slate-100 dark:border-slate-700 flex items-center justify-between">
            <div class="flex items-center gap-3">
                <input type="checkbox" id="selectAll" onclick="AdminUser.toggleAll(this)" class="rounded border-slate-200 text-primary w-4 h-4" />
                <span class="text-xs font-bold text-slate-500 uppercase tracking-wider">Hành động:</span>
                <button onclick="AdminUser.handleBulk('bulk_approve')" class="px-3 py-1 text-[10px] font-bold bg-white dark:bg-slate-700 text-emerald-600 border border-emerald-200 dark:border-emerald-900/30 rounded-full hover:bg-emerald-50 transition-all tracking-tight">Duyệt nhanh</button>
                <button onclick="AdminUser.handleBulk('bulk_ban')" class="px-3 py-1 text-[10px] font-bold bg-white dark:bg-slate-700 text-amber-600 border border-amber-200 dark:border-amber-900/30 rounded-full hover:bg-amber-50 transition-all tracking-tight">Khóa</button>
                <button onclick="AdminUser.handleBulk('bulk_restore')" class="px-3 py-1 text-[10px] font-bold bg-white dark:bg-slate-700 text-emerald-600 border border-emerald-200 dark:border-emerald-900/30 rounded-full hover:bg-emerald-50 transition-all tracking-tight">Khôi phục</button>
                <button onclick="AdminUser.handleBulk('bulk_delete')" class="px-3 py-1 text-[10px] font-bold bg-white dark:bg-slate-700 text-rose-600 border border-rose-200 dark:border-rose-900/30 rounded-full hover:bg-rose-50 transition-all tracking-tight">Xóa (Ẩn)</button>
            </div>
            <p class="text-xs text-slate-400">Đang hiển thị <span class="font-bold text-slate-800 dark:text-white">${users.size()}</span> bản ghi</p>
        </div>

        <div class="overflow-x-auto">
            <table class="w-full text-left">
                <thead>
                    <tr class="text-[10px] font-bold text-slate-400 uppercase tracking-widest border-b border-slate-100 dark:border-slate-700">
                        <th class="px-6 py-4 w-10"></th>
                        <th class="px-6 py-4">Tài khoản</th>
                        <th class="px-6 py-4">Vai trò</th>
                        <th class="px-6 py-4">Ngày tham gia</th>
                        <th class="px-6 py-4">Trạng thái</th>
                        <th class="px-8 py-4 text-right">Quản lý</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-slate-50 dark:divide-slate-700">
                    <c:forEach items="${users}" var="u">
                        <tr class="hover:bg-slate-50/50 dark:hover:bg-slate-700/20 transition-colors group">
                            <td class="px-6 py-4">
                                <input type="checkbox" value="${u.id}" class="user-checkbox rounded border-slate-200 text-primary w-4 h-4" />
                            </td>
                            <td class="px-6 py-4">
                                <div class="flex items-center gap-3">
                                    <img class="w-9 h-9 rounded-full object-cover border-2 border-white dark:border-slate-800 shadow-sm"
                                         src="${not empty u.avatarUrl ? u.avatarUrl : 'https://ui-avatars.com/api/?name='.concat(u.fullName)}" />
                                    <div>
                                        <h5 class="text-sm font-bold text-slate-800 dark:text-white leading-tight">${u.fullName}</h5>
                                        <p class="text-xs text-slate-400">${u.email}</p>
                                    </div>
                                </div>
                            </td>
                            <td class="px-6 py-4">
                                <div class="flex items-center gap-2">
                                    <c:choose>
                                        <c:when test="${u.role.name == 'ADMIN'}"><span class="px-2 py-0.5 bg-indigo-50 dark:bg-indigo-900/30 text-indigo-600 text-[10px] font-bold rounded-md">ADMIN</span></c:when>
                                        <c:when test="${u.role.name == 'JOURNALIST'}"><span class="px-2 py-0.5 bg-emerald-50 dark:bg-emerald-900/30 text-emerald-600 text-[10px] font-bold rounded-md">JOURNALIST</span></c:when>
                                        <c:otherwise><span class="px-2 py-0.5 bg-slate-100 dark:bg-slate-700 text-slate-500 text-[10px] font-bold rounded-md">MEMBER</span></c:otherwise>
                                    </c:choose>
                                </div>
                            </td>
                            <td class="px-6 py-4 text-xs text-slate-500 tracking-tight">
                                <fmt:formatDate value="${u.createdAt}" pattern="dd/MM/yyyy" />
                            </td>
                            <td class="px-6 py-4">
                                <span class="flex items-center gap-2 text-xs font-semibold 
                                    ${u.status == 'ACTIVE' ? 'text-emerald-500' : 
                                      (u.status == 'BANNED' ? 'text-rose-500' : 
                                      (u.status == 'DELETED' ? 'text-slate-400' : 'text-amber-500'))}">
                                    <span class="w-1.5 h-1.5 rounded-full 
                                        ${u.status == 'ACTIVE' ? 'bg-emerald-500' : 
                                          (u.status == 'BANNED' ? 'bg-rose-500' : 
                                          (u.status == 'DELETED' ? 'bg-slate-300' : 'bg-amber-500'))}"></span>
                                    ${u.status}
                                </span>
                            </td>
                            <td class="px-8 py-4 text-right">
                                <div class="flex justify-end gap-1">
                                    <button onclick="AdminUser.viewCV(this)" 
                                        data-name="${u.fullName}" data-email="${u.email}" data-role="${u.role.name}"
                                        data-date="<fmt:formatDate value="${u.createdAt}" pattern="dd/MM/yyyy" />"
                                        data-bio="${u.bio}" data-exp="${u.experienceYears}"
                                        class="p-2 text-slate-400 hover:text-primary transition-colors" title="Chi tiết">
                                        <span class="material-icons text-[18px]">info_outline</span>
                                    </button>
                                            <c:if test="${u.role.name != 'ADMIN'}">
                                        <c:choose>
                                            <c:when test="${u.status == 'DELETED'}">
                                                <button onclick="AdminUser.banUser(${u.id}, 'restore')" class="p-2 text-emerald-500 hover:bg-emerald-50 rounded-lg transition-colors" title="Khôi phục tài khoản">
                                                    <span class="material-icons text-[18px]">settings_backup_restore</span>
                                                </button>
                                            </c:when>
                                            <c:when test="${u.status == 'PENDING'}">
                                                <button onclick="AdminUser.approveUser(${u.id}, 'approve')" class="p-2 text-emerald-500 hover:bg-emerald-50 rounded-lg transition-colors" title="Duyệt nâng cấp">
                                                    <span class="material-icons text-[18px]">check_circle</span>
                                                </button>
                                                <button onclick="AdminUser.approveUser(${u.id}, 'reject')" class="p-2 text-amber-500 hover:bg-amber-50 rounded-lg transition-colors" title="Từ chối đơn">
                                                    <span class="material-icons text-[18px]">cancel</span>
                                                </button>
                                            </c:when>
                                            <c:when test="${u.status == 'BANNED'}">
                                                <button onclick="AdminUser.banUser(${u.id}, 'unban')" class="p-2 text-emerald-500 hover:bg-emerald-50 rounded-lg transition-all" title="Mở khóa tài khoản">
                                                    <span class="material-icons text-[18px]">lock_open</span>
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <button onclick="AdminUser.banUser(${u.id}, 'ban')" class="p-2 text-red-500 hover:bg-red-50 rounded-lg transition-all" title="Khóa tài khoản">
                                                    <span class="material-icons text-[18px]">block</span>
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                        
                                        <c:if test="${u.status != 'DELETED'}">
                                        <button onclick="AdminUser.changeRole(${u.id}, ${u.role.id}, '${u.fullName}')" class="p-2 text-slate-400 hover:text-indigo-500 transition-colors" title="Phân quyền"><span class="material-icons text-[18px]">manage_accounts</span></button>
                                        <button onclick="AdminUser.resetPassword(${u.id}, '${u.fullName}')" class="p-2 text-slate-400 hover:text-amber-500 transition-colors" title="Đổi mật khẩu">
                                            <span class="material-icons text-[18px]">vpn_key</span>
                                        </button>
                                        <button onclick="AdminUser.approveUser(${u.id}, 'delete')" class="p-2 text-slate-400 hover:text-rose-500 transition-colors" title="Xóa tài khoản">
                                            <span class="material-icons text-[18px]">delete_outline</span>
                                        </button>
                                        </c:if>
                                    </c:if>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <div class="px-6 py-4 bg-slate-50/50 dark:bg-slate-900/20 border-t border-slate-100 dark:border-slate-700 flex items-center justify-between">
            <p class="text-[11px] text-slate-400 font-medium">Trang <span class="font-bold text-slate-800 dark:text-white">${currentPage}</span> / ${totalPages}</p>
            <div class="flex items-center gap-1.5">
                <c:if test="${currentPage > 1}">
                    <button onclick="AdminUser.filterUsers(${currentPage - 1})" class="w-8 h-8 flex items-center justify-center rounded-lg border border-slate-200 dark:border-slate-700 hover:bg-white transition-all"><span class="material-icons text-[16px]">chevron_left</span></button>
                </c:if>
                <c:forEach begin="1" end="${totalPages}" var="i">
                    <button onclick="AdminUser.filterUsers(${i})" class="w-8 h-8 flex items-center justify-center rounded-lg text-[11px] font-bold transition-all ${currentPage == i ? 'bg-primary text-white shadow-lg shadow-primary/20' : 'bg-white dark:bg-slate-700 border border-slate-200 dark:border-slate-700 text-slate-500'}">${i}</button>
                </c:forEach>
                <c:if test="${currentPage < totalPages}">
                    <button onclick="AdminUser.filterUsers(${currentPage + 1})" class="w-8 h-8 flex items-center justify-center rounded-lg border border-slate-200 dark:border-slate-700 hover:bg-white transition-all"><span class="material-icons text-[16px]">chevron_right</span></button>
                </c:if>
            </div>
        </div>
    </div>
</div>
