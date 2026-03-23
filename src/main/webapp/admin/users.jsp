<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
            <!DOCTYPE html>
            <html lang="vi">

            <head>
                <jsp:include page="components/head.jsp" />
                <title>Quản lý Người dùng | NeuralNews Admin</title>
            </head>

            <body class="bg-dashboard-bg dark:bg-background-dark overflow-x-hidden">
                <div class="flex min-h-screen">
                    <jsp:include page="components/sidebar.jsp">
                        <jsp:param name="activePage" value="users" />
                    </jsp:include>

                    <main class="flex-1 ml-64 min-h-screen">
                        <!-- Header Section -->
                        <header
                            class="sticky top-0 z-40 bg-dashboard-bg/80 dark:bg-background-dark/80 backdrop-blur-md px-8 py-5 flex items-center justify-between border-b border-slate-200 dark:border-slate-800">
                            <div>
                                <p class="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-1">Hệ thống
                                </p>
                                <h2 class="text-2xl font-bold text-slate-800 dark:text-white">Quản lý người dùng</h2>
                            </div>
                            <div class="flex items-center gap-3">
                                <button onclick="AdminUser.exportCsv()"
                                    class="px-4 py-2 border border-slate-200 dark:border-slate-700 rounded-xl text-sm font-semibold hover:bg-slate-50 dark:hover:bg-slate-800 text-slate-600 dark:text-slate-300 transition-all flex items-center gap-2">
                                    <span class="material-icons text-[18px]">download</span> Xuất CSV
                                </button>
                                <button onclick="openAddUserModal()"
                                    class="bg-primary hover:bg-primary/90 text-white px-4 py-2 rounded-xl text-sm font-bold flex items-center gap-2 shadow-lg shadow-primary/20 transition-all">
                                    <span class="material-icons text-sm">person_add</span> Thêm thành viên
                                </button>
                                <jsp:include page="components/header_profile.jsp" />
                            </div>
                        </header>

                        <div class="p-8 space-y-6">
                            <!-- Statistics Overview -->
                            <div class="grid grid-cols-2 md:grid-cols-5 gap-4">
                                <button onclick="AdminUser.quickFilter('')"
                                    class="bg-white dark:bg-slate-800 p-4 rounded-xl shadow-sm border border-slate-100 dark:border-slate-700 flex items-center gap-4 hover:border-primary hover:shadow-md transition-all text-left">
                                    <div
                                        class="w-12 h-12 bg-slate-100 dark:bg-slate-700 rounded-xl flex items-center justify-center text-slate-500">
                                        <span class="material-icons">people</span>
                                    </div>
                                    <div>
                                        <p class="text-[10px] uppercase font-bold text-slate-400">Tổng cộng</p>
                                        <p class="text-2xl font-bold text-slate-800 dark:text-white">${statTotal}</p>
                                    </div>
                                </button>
                                <button onclick="AdminUser.quickFilter('ACTIVE')"
                                    class="bg-white dark:bg-slate-800 p-4 rounded-xl shadow-sm border border-slate-100 dark:border-slate-700 flex items-center gap-4 hover:border-emerald-500 hover:shadow-md transition-all text-left">
                                    <div
                                        class="w-12 h-12 bg-emerald-50 dark:bg-emerald-900/20 rounded-xl flex items-center justify-center text-emerald-500">
                                        <span class="material-icons">verified_user</span>
                                    </div>
                                    <div>
                                        <p class="text-[10px] uppercase font-bold text-emerald-500">Đang hoạt động</p>
                                        <p class="text-2xl font-bold text-slate-800 dark:text-white">${statActive}</p>
                                    </div>
                                </button>
                                <button onclick="AdminUser.quickFilter('PENDING')"
                                    class="bg-white dark:bg-slate-800 p-4 rounded-xl shadow-sm border border-slate-100 dark:border-slate-700 flex items-center gap-4 hover:border-amber-500 hover:shadow-md transition-all text-left">
                                    <div
                                        class="w-12 h-12 bg-amber-50 dark:bg-amber-900/20 rounded-xl flex items-center justify-center text-amber-500">
                                        <span class="material-icons">pending</span>
                                    </div>
                                    <div>
                                        <p class="text-[10px] uppercase font-bold text-amber-500">Chờ duyệt</p>
                                        <p class="text-2xl font-bold text-slate-800 dark:text-white">${statPending}</p>
                                    </div>
                                </button>
                                <button onclick="AdminUser.quickFilter('REJECTED')"
                                    class="bg-white dark:bg-slate-800 p-4 rounded-xl shadow-sm border border-slate-100 dark:border-slate-700 flex items-center gap-4 hover:border-slate-500 hover:shadow-md transition-all text-left">
                                    <div
                                        class="w-12 h-12 bg-slate-50 dark:bg-slate-900/20 rounded-xl flex items-center justify-center text-slate-500">
                                        <span class="material-icons">person_off</span>
                                    </div>
                                    <div>
                                        <p class="text-[10px] uppercase font-bold text-slate-500">Bị từ chối</p>
                                        <p class="text-2xl font-bold text-slate-800 dark:text-white">${statRejected}</p>
                                    </div>
                                </button>
                                <button onclick="AdminUser.quickFilter('BANNED')"
                                    class="bg-white dark:bg-slate-800 p-4 rounded-xl shadow-sm border border-slate-100 dark:border-slate-700 flex items-center gap-4 hover:border-red-500 hover:shadow-md transition-all text-left">
                                    <div
                                        class="w-12 h-12 bg-red-50 dark:bg-red-900/20 rounded-xl flex items-center justify-center text-red-500">
                                        <span class="material-icons">block</span>
                                    </div>
                                    <div>
                                        <p class="text-[10px] uppercase font-bold text-red-500">Đã khóa</p>
                                        <p class="text-2xl font-bold text-slate-800 dark:text-white">${statBanned}</p>
                                    </div>
                                </button>
                            </div>

                            <!-- Filters -->
                            <div
                                class="bg-white dark:bg-slate-800 p-4 rounded-xl shadow-sm border border-slate-100 dark:border-slate-700 flex flex-wrap items-end gap-3">
                                <div class="flex-1 min-w-[200px]">
                                    <label class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Tìm người
                                        dùng</label>
                                    <div class="relative group">
                                        <span
                                            class="material-icons absolute left-3 top-2.5 text-slate-400 group-focus-within:text-primary text-[20px] transition-colors">search</span>
                                        <input id="searchUser" value="${filterKeyword}"
                                            oninput="AdminUser.filterUsers(1)"
                                            class="w-full pl-10 pr-4 py-2 bg-slate-50 dark:bg-slate-900 border border-slate-100 dark:border-slate-700 rounded-lg text-sm outline-none focus:ring-2 focus:ring-primary transition-all"
                                            placeholder="Tên hoặc email..." />
                                    </div>
                                </div>
                                <div class="w-32">
                                    <label class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Quyền
                                        hạn</label>
                                    <select id="roleSelect" onchange="AdminUser.filterUsers(1)"
                                        class="w-full py-2 px-3 bg-slate-50 dark:bg-slate-900 border border-slate-100 dark:border-slate-700 rounded-lg text-sm outline-none focus:ring-2 focus:ring-primary">
                                        <option value="ALL">Tất cả</option>
                                        <option value="ADMIN" ${filterRole=='ADMIN' ? 'selected' : '' }>Quản trị viên
                                        </option>
                                        <option value="JOURNALIST" ${filterRole=='JOURNALIST' ? 'selected' : '' }>Nhà
                                            báo</option>
                                        <option value="USER" ${filterRole=='USER' ? 'selected' : '' }>Độc giả</option>
                                    </select>
                                </div>
                                <div class="w-36">
                                    <label class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Trạng
                                        thái</label>
                                    <select id="statusSelect" onchange="AdminUser.filterUsers(1)"
                                        class="w-full py-2 px-3 bg-slate-50 dark:bg-slate-900 border border-slate-100 dark:border-slate-700 rounded-lg text-sm outline-none focus:ring-2 focus:ring-primary">
                                        <option value="ALL">Tất cả</option>
                                        <option value="ACTIVE" ${filterStatus=='ACTIVE' ? 'selected' : '' }>Hoạt động
                                        </option>
                                        <option value="BANNED" ${filterStatus=='BANNED' ? 'selected' : '' }>Đã khóa
                                        </option>
                                        <option value="PENDING" ${filterStatus=='PENDING' ? 'selected' : '' }>Chờ duyệt
                                        </option>
                                        <option value="REJECTED" ${filterStatus=='REJECTED' ? 'selected' : '' }>Bị từ
                                            chối</option>
                                        <option value="DELETED" ${filterStatus=='DELETED' ? 'selected' : '' }>Đã xóa
                                        </option>
                                    </select>
                                </div>
                                <div class="w-32">
                                    <label class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Sắp
                                        xếp</label>
                                    <select id="sortBySelect" onchange="AdminUser.filterUsers(1)"
                                        class="w-full py-2 px-3 bg-slate-50 dark:bg-slate-900 border border-slate-100 dark:border-slate-700 rounded-lg text-sm outline-none focus:ring-2 focus:ring-primary">
                                        <option value="created_at">Ngày tham gia</option>
                                        <option value="name">Tên</option>
                                        <option value="email">Email</option>
                                    </select>
                                </div>
                                <div class="w-32">
                                    <label class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Thứ
                                        tự</label>
                                    <select id="sortDirSelect" onchange="AdminUser.filterUsers(1)"
                                        class="w-full py-2 px-3 bg-slate-50 dark:bg-slate-900 border border-slate-100 dark:border-slate-700 rounded-lg text-sm outline-none focus:ring-2 focus:ring-primary">
                                        <option value="DESC">Mới nhất</option>
                                        <option value="ASC">Cũ nhất</option>
                                    </select>
                                </div>
                                <button onclick="AdminUser.resetFilters()"
                                    class="px-4 py-2 border border-slate-200 dark:border-slate-600 rounded-lg text-sm font-medium hover:bg-slate-50 dark:hover:bg-slate-700 transition-colors">Làm
                                    mới</button>
                            </div>

                            <!-- User Table Content -->
                            <div id="user-table-container" class="space-y-6">
                                <jsp:include page="components/user_table_partial.jsp" />
                            </div>
                        </div>
                    </main>
                </div>

                <%-- Modals --%>
                    <div id="addUserModal" class="fixed inset-0 z-[100] flex items-center justify-center p-4 hidden">
                        <div class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm" onclick="closeAddUserModal()"></div>
                        <div
                            class="bg-white dark:bg-slate-900 w-full max-w-md rounded-2xl shadow-2xl relative z-10 overflow-hidden">
                            <div
                                class="px-6 py-4 border-b border-slate-100 dark:border-slate-800 flex items-center justify-between">
                                <h2 class="text-lg font-bold text-slate-900 dark:text-white">Thêm thành viên mới</h2>
                                <button onclick="closeAddUserModal()" class="text-slate-400 hover:text-slate-600"><span
                                        class="material-icons">close</span></button>
                            </div>
                            <form id="addUserForm" class="p-6 space-y-4">
                                <div>
                                    <label class="text-xs font-bold text-slate-500 uppercase mb-1 block">Họ và
                                        tên</label>
                                    <input type="text" name="fullName"
                                        class="w-full px-4 py-2.5 bg-slate-50 dark:bg-slate-900/50 border border-slate-200 dark:border-slate-700 rounded-xl outline-none focus:ring-2 focus:ring-primary"
                                        placeholder="Nguyen Van A" />
                                </div>
                                <div>
                                    <label class="text-xs font-bold text-slate-500 uppercase mb-1 block">Email</label>
                                    <input type="email" name="email"
                                        class="w-full px-4 py-2.5 bg-slate-50 dark:bg-slate-900/50 border border-slate-200 dark:border-slate-700 rounded-xl outline-none focus:ring-2 focus:ring-primary"
                                        placeholder="example@news.com" />
                                </div>
                                <div>
                                    <label class="text-xs font-bold text-slate-500 uppercase mb-1 block">Vai trò</label>
                                    <select name="roleId"
                                        class="w-full px-4 py-2.5 bg-slate-50 dark:bg-slate-900/50 border border-slate-200 dark:border-slate-700 rounded-xl outline-none focus:ring-2 focus:ring-primary">
                                        <option value="1">Độc giả</option>
                                        <option value="2">Nhà báo</option>
                                        <option value="3">Quản trị viên</option>
                                    </select>
                                </div>
                            </form>
                            <div
                                class="px-6 py-4 border-t border-slate-100 dark:border-slate-800 bg-slate-50 dark:bg-slate-900/50 flex gap-3">
                                <button onclick="closeAddUserModal()"
                                    class="flex-1 px-4 py-2.5 text-sm font-bold text-slate-600 hover:bg-slate-200 rounded-xl">Hủy</button>
                                <button type="button" onclick="AdminUser.addUser()"
                                    class="flex-1 px-4 py-2.5 text-sm font-bold bg-primary text-white hover:bg-primary/90 rounded-xl shadow-lg shadow-primary/20 transition-all">Tạo
                                    tài khoản</button>
                            </div>
                        </div>
                    </div>

                    <%-- Edit Role Modal --%>
                        <div id="editRoleModal"
                            class="fixed inset-0 z-[100] flex items-center justify-center p-4 hidden">
                            <div class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm" onclick="closeEditRoleModal()">
                            </div>
                            <div
                                class="bg-white dark:bg-slate-900 w-full max-w-sm rounded-2xl shadow-2xl relative z-10 overflow-hidden animate-in zoom-in duration-200">
                                <div
                                    class="px-6 py-4 border-b border-slate-100 dark:border-slate-800 flex items-center justify-between">
                                    <h2 class="text-lg font-bold text-slate-900 dark:text-white">Cập nhật vai trò</h2>
                                    <button onclick="closeEditRoleModal()"
                                        class="text-slate-400 hover:text-slate-600"><span
                                            class="material-icons">close</span></button>
                                </div>
                                <div class="p-6 space-y-4">
                                    <input type="hidden" id="editRoleId_userId" />
                                    <div>
                                        <p class="text-sm text-slate-500 mb-4">Bạn đang thay đổi vai trò cho người dùng:
                                            <b id="editRoleId_userName" class="text-slate-900 dark:text-white">...</b>
                                        </p>
                                        <label class="text-xs font-bold text-slate-500 uppercase mb-1 block">Chọn vai
                                            trò mới</label>
                                        <select id="editRoleId_select"
                                            class="w-full px-4 py-2.5 bg-slate-50 dark:bg-slate-900/50 border border-slate-200 dark:border-slate-700 rounded-xl outline-none focus:ring-2 focus:ring-primary">
                                            <option value="1">Độc giả (MEMBER)</option>
                                            <option value="2">Nhà báo (JOURNALIST)</option>
                                            <option value="3">Quản trị viên (ADMIN)</option>
                                        </select>
                                    </div>
                                </div>
                                <div
                                    class="px-6 py-4 border-t border-slate-100 dark:border-slate-800 bg-slate-50 dark:bg-slate-900/50 flex gap-3">
                                    <button onclick="closeEditRoleModal()"
                                        class="flex-1 px-4 py-2 text-sm font-bold text-slate-600 hover:bg-slate-200 rounded-xl">Hủy</button>
                                    <button type="button" onclick="AdminUser.submitChangeRole()"
                                        class="flex-1 px-4 py-2 text-sm font-bold bg-primary text-white hover:bg-primary/90 rounded-xl shadow-lg transition-all">Lưu
                                        thay đổi</button>
                                </div>
                            </div>
                        </div>

                        <%-- Reset Password Modal --%>
                            <div id="resetPasswordModal"
                                class="fixed inset-0 z-[100] flex items-center justify-center p-4 hidden">
                                <div class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm"
                                    onclick="closeResetPwdModal()"></div>
                                <div
                                    class="bg-white dark:bg-slate-900 w-full max-w-sm rounded-2xl shadow-2xl relative z-10 overflow-hidden animate-in zoom-in duration-200">
                                    <div
                                        class="px-6 py-4 border-b border-slate-100 dark:border-slate-800 flex items-center justify-between">
                                        <h2 class="text-lg font-bold text-slate-900 dark:text-white">Đặt lại mật khẩu
                                        </h2>
                                        <button onclick="closeResetPwdModal()"
                                            class="text-slate-400 hover:text-slate-600"><span
                                                class="material-icons">close</span></button>
                                    </div>
                                    <div class="p-6 space-y-4">
                                        <input type="hidden" id="resetPwd_userId" />
                                        <div>
                                            <p class="text-sm text-slate-500 mb-4">Thay đổi mật khẩu cho: <b
                                                    id="resetPwd_userName"
                                                    class="text-slate-900 dark:text-white">...</b></p>
                                            <label class="text-xs font-bold text-slate-500 uppercase mb-1 block">Mật
                                                khẩu mới</label>
                                            <input type="password" id="resetPwd_input"
                                                class="w-full px-4 py-2.5 bg-slate-50 dark:bg-slate-900/50 border border-slate-200 dark:border-slate-700 rounded-xl outline-none focus:ring-2 focus:ring-primary"
                                                placeholder="Nhập mật khẩu mới" />
                                        </div>
                                    </div>
                                    <div
                                        class="px-6 py-4 border-t border-slate-100 dark:border-slate-800 bg-slate-50 dark:bg-slate-900/50 flex gap-3">
                                        <button onclick="closeResetPwdModal()"
                                            class="flex-1 px-4 py-2 text-sm font-bold text-slate-600 hover:bg-slate-200 rounded-xl">Hủy</button>
                                        <button type="button" onclick="AdminUser.submitResetPassword()"
                                            class="flex-1 px-4 py-2 text-sm font-bold bg-primary text-white hover:bg-primary/90 rounded-xl shadow-lg transition-all">Cập
                                            nhật nhanh</button>
                                    </div>
                                </div>
                            </div>

                            <%-- CV Modal --%>
                                <div id="cvModal"
                                    class="fixed inset-0 z-[101] flex items-center justify-center p-4 hidden">
                                    <div class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm"
                                        onclick="AdminUser.closeCV()"></div>
                                    <div
                                        class="bg-white dark:bg-slate-900 w-full max-w-lg rounded-2xl shadow-2xl relative z-10 overflow-hidden animate-in fade-in zoom-in duration-200">
                                        <div class="bg-gradient-to-r from-slate-800 to-slate-900 p-6 text-white">
                                            <div class="flex justify-between items-start">
                                                <div>
                                                    <h2 id="cvName" class="text-2xl font-bold">—</h2>
                                                    <p id="cvEmail" class="text-slate-400 text-sm">—</p>
                                                </div>
                                                <button onclick="AdminUser.closeCV()"
                                                    class="w-8 h-8 flex items-center justify-center rounded-lg hover:bg-white/10 transition-colors"><span
                                                        class="material-icons text-[18px]">close</span></button>
                                            </div>
                                            <div class="mt-4 flex gap-2">
                                                <span id="cvRole"
                                                    class="px-2 py-0.5 bg-primary/20 text-primary border border-primary/20 rounded text-[10px] font-bold uppercase tracking-wider">ROLE</span>
                                                <span id="cvDate"
                                                    class="px-2 py-0.5 bg-slate-700/50 text-slate-300 rounded text-[10px] font-medium tracking-tight">DATE</span>
                                            </div>
                                        </div>
                                        <div class="p-6 space-y-6">
                                            <div>
                                                <h3
                                                    class="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-2">
                                                    Thâm niên kinh nghiệm</h3>
                                                <p id="cvExp" class="text-xl font-bold text-slate-800 dark:text-white">0
                                                    năm</p>
                                            </div>
                                            <div>
                                                <h3
                                                    class="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-2">
                                                    Giới thiệu kỹ năng</h3>
                                                <div
                                                    class="bg-slate-50 dark:bg-slate-800/50 p-4 rounded-xl border border-slate-100 dark:border-slate-700 min-h-[100px]">
                                                    <p id="cvBio"
                                                        class="text-sm text-slate-600 dark:text-slate-300 leading-relaxed italic">
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                        <div
                                            class="px-6 py-4 border-t border-slate-100 dark:border-slate-800 bg-slate-50 dark:bg-slate-900/50 flex justify-end">
                                            <button onclick="AdminUser.closeCV()"
                                                class="px-6 py-2.5 bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 text-slate-600 dark:text-slate-300 rounded-xl text-sm font-bold hover:bg-slate-50 transition-colors">Đóng</button>
                                        </div>
                                    </div>
                                </div>

                                <script src="${pageContext.request.contextPath}/assets/js/app-utils.js"></script>
                                <script src="${pageContext.request.contextPath}/assets/js/admin-user.js?v=2"></script>
                                <script>
                                    AdminUser.init('${pageContext.request.contextPath}');
                                    function closeAddUserModal() { document.getElementById('addUserModal').classList.add('hidden'); }
                                    function openAddUserModal() { document.getElementById('addUserModal').classList.remove('hidden'); }
                                    function closeEditRoleModal() { document.getElementById('editRoleModal').classList.add('hidden'); }
                                    function closeResetPwdModal() { document.getElementById('resetPasswordModal').classList.add('hidden'); }
                                </script>
            </body>

            </html>