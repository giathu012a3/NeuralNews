<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:if test="${empty currentUser}">
    <c:redirect url="/auth/login.jsp" />
</c:if>
    <!DOCTYPE html>
    <html class="dark" lang="en">

    <head>
        <title>Cài đặt Tài khoản - NexusAI</title>
        <jsp:include page="components/head.jsp" />
    </head>

    <body
        class="bg-background-light dark:bg-background-dark text-text-main dark:text-white font-display antialiased overflow-x-hidden transition-colors duration-200">
        <div class="flex min-h-screen w-full flex-col">
            <jsp:include page="components/header.jsp">
                <jsp:param name="hideSearch" value="true" />
            </jsp:include>
            
            <!-- Notifications (Top-Right) -->
            <c:if test="${not empty param.success}">
                <div id="toast-success" class="fixed top-5 right-5 z-[110] pointer-events-none">
                    <div class="bg-emerald-500 text-white px-6 py-4 rounded-2xl shadow-2xl flex items-center gap-3 pointer-events-auto transition-all duration-300">
                        <span class="material-symbols-outlined text-2xl">check_circle</span>
                        <div>
                            <p class="font-black tracking-tight text-sm">Thành công!</p>
                            <p class="text-xs opacity-90">
                                <c:choose>
                                    <c:when test="${param.success == 'updated'}">Hồ sơ của bạn đã được cập nhật.</c:when>
                                    <c:when test="${param.success == 'password_updated'}">Mật khẩu đã được thay đổi.</c:when>
                                    <c:otherwise>Thao tác của bạn đã hoàn tất.</c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>
                </div>
            </c:if>
            <c:if test="${not empty param.error}">
                <div id="toast-error" class="fixed top-5 right-5 z-[110] pointer-events-none">
                    <div class="bg-red-500 text-white px-6 py-4 rounded-2xl shadow-2xl flex items-center gap-3 pointer-events-auto transition-all duration-300">
                        <span class="material-symbols-outlined text-2xl">error</span>
                        <div>
                            <p class="font-black tracking-tight text-sm">Đã có lỗi xảy ra!</p>
                            <p class="text-xs opacity-90">
                                <c:choose>
                                    <c:when test="${param.error == 'wrong_password'}">Mật khẩu hiện tại không chính xác.</c:when>
                                    <c:when test="${param.error == 'password_mismatch'}">Mật khẩu mới không khớp nhau.</c:when>
                                    <c:when test="${param.error == 'missing_fields'}">Vui lòng điền đầy đủ các thông tin.</c:when>
                                    <c:otherwise>Chúng tôi không thể thực hiện yêu cầu này. Thử lại sau.</c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Custom Delete Confirmation Modal -->
            <div id="deleteModal" class="fixed inset-0 z-[120] hidden overflow-y-auto">
                <!-- Backdrop -->
                <div class="fixed inset-0 bg-slate-900/60 backdrop-blur-sm transition-opacity" onclick="closeDeleteModal()"></div>
                
                <!-- Center modal box -->
                <div class="flex min-h-full items-center justify-center p-4">
                    <div class="relative overflow-hidden rounded-3xl bg-white dark:bg-surface-dark text-left shadow-2xl sm:w-full sm:max-w-lg transition-all duration-300 border border-slate-200 dark:border-border-dark">
                        <div class="px-6 pt-6 pb-4">
                            <div class="flex items-center gap-4 mb-4">
                                <div class="size-12 rounded-2xl bg-red-100 dark:bg-red-500/10 flex items-center justify-center text-red-600">
                                    <span class="material-symbols-outlined text-2xl">warning</span>
                                </div>
                                <h3 class="text-xl font-black text-slate-900 dark:text-white tracking-tight">Xác nhận xóa tài khoản?</h3>
                            </div>
                            <div class="p-4 bg-red-50 dark:bg-red-500/5 rounded-2xl border border-red-100 dark:border-red-500/10">
                                <p class="text-sm text-red-600 dark:text-red-400 font-medium leading-relaxed">
                                    Hành động này sẽ xóa vĩnh viễn toàn bộ dữ liệu, bài viết đã lưu và lịch sử đọc của bạn. Không thể hoàn tác sau khi xác nhận.
                                </p>
                            </div>
                        </div>
                        <div class="px-6 py-4 bg-slate-50 dark:bg-background-dark/50 flex flex-col-reverse sm:flex-row sm:justify-end gap-3">
                            <button type="button" onclick="closeDeleteModal()" class="w-full sm:w-auto px-6 py-2.5 text-sm font-bold text-slate-600 dark:text-slate-400 hover:bg-slate-200/50 dark:hover:bg-slate-800 rounded-xl transition-colors">Hủy bỏ</button>
                            <button type="button" onclick="confirmIdentityBeforeDelete()" class="w-full sm:w-auto px-8 py-2.5 text-sm font-bold bg-red-500 text-white rounded-xl hover:bg-red-600 shadow-lg shadow-red-500/20 transition-all">Tôi xác nhận xóa</button>
                        </div>
                    </div>
                </div>
            </div>

            <main class="flex-1 w-full max-w-[1440px] mx-auto p-4 lg:p-8 flex flex-col lg:flex-row gap-8 items-start">
                <div class="w-full lg:w-72 shrink-0 sticky top-24">
                    <jsp:include page="components/sidebar.jsp" />
                </div>

                <div class="flex-1 flex flex-col gap-8">
                    <form action="${pageContext.request.contextPath}/SettingsController" method="post" id="settingsForm" enctype="multipart/form-data">
                        <div class="flex items-center justify-between mb-8">
                            <div>
                                <h1 class="text-2xl font-black text-slate-900 dark:text-white tracking-tight">Cài đặt Tài khoản</h1>
                                <p class="text-sm text-slate-500 dark:text-slate-400">Quản lý hồ sơ, bảo mật và tùy chọn tài khoản của bạn.</p>
                            </div>
                            <button type="submit" name="action" value="updateProfile" class="px-6 py-2.5 text-sm font-bold bg-primary text-white rounded-xl hover:bg-primary-dark shadow-lg shadow-primary/20 transition-all">Lưu Thay đổi</button>
                        </div>
                        
                        <div class="space-y-8">
                            <!-- Section 1: Profile Information -->
                            <section class="bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-2xl p-6 md:p-8">
                                <div class="flex flex-col md:flex-row gap-8 items-start">
                                    <div class="flex flex-col items-center gap-4 shrink-0">
                                        <div class="relative group">
                                            <div class="size-32 rounded-2xl bg-slate-200 overflow-hidden border-4 border-slate-50 dark:border-slate-800 shadow-md">
                                                <div id="avatarPreview" class="size-full bg-cover bg-center"
                                                    style="background-image: url('${not empty currentUser.avatarUrl ? (currentUser.avatarUrl.startsWith('http') ? currentUser.avatarUrl : pageContext.request.contextPath.concat('/').concat(currentUser.avatarUrl)) : 'https://ui-avatars.com/api/?name='.concat(currentUser.fullName)}');">
                                                </div>
                                            </div>
                                            <input type="hidden" name="avatarUrl" id="avatarUrlInput" value="${currentUser.avatarUrl}">
                                            <input type="file" name="avatarFile" id="avatarFileInput" class="hidden" accept="image/*" onchange="previewAvatar(this)">
                                            <button type="button" onclick="document.getElementById('avatarFileInput').click()"
                                                class="absolute -bottom-2 -right-2 p-2 bg-primary text-white rounded-xl shadow-lg border-4 border-white dark:border-slate-800 hover:scale-110 transition-transform" title="Chọn ảnh từ máy tính">
                                                <span class="material-symbols-outlined text-sm">photo_camera</span>
                                            </button>
                                        </div>
                                        <p class="text-[10px] text-slate-500 font-bold uppercase tracking-widest">Ảnh đại diện</p>
                                    </div>
                                    <div class="flex-1 grid grid-cols-1 md:grid-cols-2 gap-6 w-full">
                                        <div class="space-y-2">
                                            <label class="text-xs font-bold text-slate-500 uppercase tracking-wider ml-1">Họ và Tên</label>
                                            <input name="fullName" required
                                                class="w-full bg-slate-50 dark:bg-background-dark/50 border border-slate-200 dark:border-border-dark rounded-xl px-4 py-3 text-sm focus:ring-1 focus:ring-primary outline-none transition-all"
                                                type="text" value="${currentUser.fullName}" />
                                        </div>
                                        <div class="space-y-2">
                                            <label class="text-xs font-bold text-slate-500 uppercase tracking-wider ml-1">Địa chỉ Email</label>
                                            <input readonly
                                                class="w-full bg-slate-50 dark:bg-background-dark/50 border border-slate-200 dark:border-border-dark rounded-xl px-4 py-3 text-sm opacity-60 cursor-not-allowed"
                                                type="email" value="${currentUser.email}"/>
                                        </div>
                                        <div class="space-y-2">
                                            <label class="text-xs font-bold text-slate-500 uppercase tracking-wider ml-1">Quyền hạn / Trạng thái</label>
                                            <div class="w-full bg-slate-50 dark:bg-background-dark/50 border border-slate-200 dark:border-border-dark rounded-xl px-4 py-3 text-sm flex items-center justify-between opacity-80 select-none">
                                                <span class="font-bold text-primary">${userRole}</span>
                                                <span class="text-[10px] font-bold px-2 py-0.5 rounded uppercase ${userStatus == 'ACTIVE' ? 'bg-green-500/10 text-green-500' : 'bg-amber-500/10 text-amber-500'}">${userStatus}</span>
                                            </div>
                                        </div>
                                        <div class="space-y-2">
                                            <label class="text-xs font-bold text-slate-500 uppercase tracking-wider ml-1">Giới thiệu bản thân</label>
                                            <textarea name="bio"
                                                class="w-full bg-slate-50 dark:bg-background-dark/50 border border-slate-200 dark:border-border-dark rounded-xl px-4 py-3 text-sm focus:ring-1 focus:ring-primary outline-none transition-all"
                                                rows="2" placeholder="Chia sẻ đôi chút về bạn...">${currentUser.bio}</textarea>
                                        </div>
                                    </div>
                                </section>

                            <!-- Section 3: Security & Privacy -->
                            <div class="pt-8 border-t border-slate-200 dark:border-border-dark space-y-6">
                                <div class="flex items-center gap-2">
                                    <span class="material-symbols-outlined text-primary-dark dark:text-primary text-2xl font-bold">verified_user</span>
                                    <h2 class="text-xl font-black text-slate-900 dark:text-white tracking-tight" id="security_section">Bảo mật & Quyền riêng tư</h2>
                                </div>
                                <div class="space-y-6">
                                    <!-- Password -->
                                    <div class="bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-2xl p-6">
                                        <h4 class="font-bold text-slate-900 dark:text-white mb-4 flex items-center gap-2 text-sm">
                                            <span class="material-symbols-outlined text-primary text-lg">lock_reset</span>
                                            Đổi mật khẩu
                                        </h4>
                                        <div class="space-y-4">
                                            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                                <input name="currentPassword" class="w-full px-4 py-2.5 bg-slate-50 dark:bg-background-dark/50 border border-slate-200 dark:border-border-dark rounded-xl text-sm focus:ring-1 focus:ring-primary outline-none" placeholder="Mật khẩu hiện tại" type="password">
                                                <input name="newPassword" class="w-full px-4 py-2.5 bg-slate-50 dark:bg-background-dark/50 border border-slate-200 dark:border-border-dark rounded-xl text-sm focus:ring-1 focus:ring-primary outline-none" placeholder="Mật khẩu mới" type="password">
                                                <input name="confirmPassword" class="w-full px-4 py-2.5 bg-slate-50 dark:bg-background-dark/50 border border-slate-200 dark:border-border-dark rounded-xl text-sm focus:ring-1 focus:ring-primary outline-none" placeholder="Xác nhận mật khẩu mới" type="password">
                                            </div>
                                            <button type="submit" name="action" value="updatePassword" class="px-8 py-2.5 bg-slate-900 dark:bg-slate-700 text-white font-bold rounded-xl text-sm hover:bg-black dark:hover:bg-slate-600 transition-colors w-full md:w-auto">Cập nhật mật khẩu</button>
                                        </div>
                                    </div>

                                    <!-- Deactivation -->
                                    <div class="bg-red-500/5 border border-red-500/10 rounded-2xl p-6 flex flex-col md:flex-row items-center justify-between gap-6">
                                        <div>
                                            <h4 class="font-bold text-red-500 flex items-center gap-2 text-sm mb-1">
                                                <span class="material-symbols-outlined text-[20px]">warning</span>
                                                Hủy kích hoạt tài khoản
                                            </h4>
                                            <p class="text-xs text-slate-500">Toàn bộ dữ liệu của bạn sẽ bị xóa vĩnh viễn và không thể khôi phục.</p>
                                        </div>
                                        <button type="button" onclick="openDeleteModal()"
                                            class="px-6 py-2.5 bg-red-500 text-white font-bold rounded-xl text-sm hover:bg-red-600 transition-colors whitespace-nowrap">Xóa tài khoản</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>

                    <!-- Journalist Banner (Outside Form) -->
                    <div class="bg-gradient-to-r from-slate-900 to-primary-dark border border-white/10 rounded-2xl p-8 relative overflow-hidden group">
                        <div class="absolute top-0 right-0 p-12 opacity-10 pointer-events-none group-hover:scale-110 transition-transform duration-700">
                            <span class="material-symbols-outlined text-[160px]">edit_note</span>
                        </div>
                        <div class="relative z-10 flex flex-col md:flex-row md:items-center justify-between gap-8">
                            <div class="max-w-xl">
                                <span class="inline-flex items-center gap-1.5 px-3 py-1 bg-primary/20 backdrop-blur-md text-blue-400 text-[10px] font-bold uppercase tracking-widest rounded-full mb-4 border border-primary/30">
                                    <span class="material-symbols-outlined text-[14px]">stars</span>
                                    Chương trình Người sáng tạo Nexus
                                </span>
                                <h2 class="text-3xl md:text-4xl font-black text-white mb-4 tracking-tight">Trở thành Nhà báo Nexus</h2>
                                <p class="text-lg text-blue-100/90 mb-2 font-medium">Tiếp cận hàng triệu độc giả với nền tảng tin tức thế hệ mới của chúng tôi.</p>
                            </div>
                            <div class="shrink-0 flex flex-col items-center gap-4">
                                <c:choose>
                                    <c:when test="${userStatus == 'PENDING'}">
                                        <div class="px-8 py-4 bg-amber-500/20 border border-amber-500/30 text-amber-400 font-bold rounded-xl backdrop-blur-md">Đang chờ phê duyệt...</div>
                                    </c:when>
                                    <c:when test="${userRole == 'JOURNALIST' || userRole == 'ADMIN'}">
                                        <div class="px-8 py-4 bg-emerald-500/20 border border-emerald-500/30 text-emerald-400 font-bold rounded-xl backdrop-blur-md">Bạn đã là Nhà báo</div>
                                    </c:when>
                                    <c:otherwise>
                                        <button onclick="document.getElementById('upgradeModal').classList.remove('hidden')"
                                            class="w-full md:w-auto px-10 py-4 bg-white text-primary-dark font-black text-lg rounded-xl shadow-xl shadow-black/20 hover:bg-cyan-50 hover:text-primary hover:shadow-cyan-400/20 hover:scale-105 active:scale-95 transition-all duration-300">Đăng ký ngay</button>
                                        <p class="text-xs text-blue-200/60 font-medium">Nộp đơn mất &lt; 5 phút</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
            <jsp:include page="components/footer.jsp" />
        </div>

        <div id="upgradeModal" class="fixed inset-0 z-[100] flex items-center justify-center p-4 hidden">
            <div class="fixed inset-0 bg-slate-900/80 backdrop-blur-sm shadow-2xl" onclick="this.parentElement.classList.add('hidden')"></div>
            <div class="bg-white dark:bg-slate-900 w-full max-w-lg rounded-2xl shadow-2xl relative overflow-hidden z-10 animate-in fade-in zoom-in duration-300">
                <div class="bg-gradient-to-r from-slate-900 to-primary p-6 text-white text-center">
                    <h2 class="text-2xl font-black">Đăng ký Cộng tác viên</h2>
                    <p class="text-blue-100/70 text-sm mt-1">Cung cấp thông tin để chúng tôi xem xét hồ sơ của bạn</p>
                </div>
                <form action="${pageContext.request.contextPath}/JournalistUpgradeController" method="post" class="p-6 space-y-5">
                    <div class="space-y-1.5">
                        <label class="text-xs font-bold text-slate-400 uppercase tracking-widest">Kinh nghiệm viết lách (năm)</label>
                        <input type="number" name="experience" min="0" required class="w-full h-12 px-4 bg-slate-50 dark:bg-slate-800 border-slate-200 dark:border-slate-700 rounded-xl focus:ring-2 focus:ring-primary transition-all text-slate-900 dark:text-white" placeholder="Ví dụ: 3">
                    </div>
                    <div class="space-y-1.5">
                        <label class="text-xs font-bold text-slate-400 uppercase tracking-widest">Giới thiệu ngắn / Link Portfolio</label>
                        <textarea name="bio" required rows="4" class="w-full p-4 bg-slate-50 dark:bg-slate-800 border-slate-200 dark:border-slate-700 rounded-xl focus:ring-2 focus:ring-primary transition-all text-slate-900 dark:text-white resize-none" placeholder="Mô tả các lĩnh vực bạn am hiểu hoặc dán link bài viết tiêu biểu..."></textarea>
                    </div>
                    <div class="flex gap-4 pt-2">
                        <button type="button" onclick="document.getElementById('upgradeModal').classList.add('hidden')" class="flex-1 h-12 text-sm font-bold text-slate-500 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-xl transition-colors">Hủy</button>
                        <button type="submit" class="flex-1 h-12 bg-primary text-white font-bold rounded-xl shadow-lg shadow-primary/20 hover:bg-primary-dark transition-all">Gửi yêu cầu</button>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function previewAvatar(input) {
                if (input.files && input.files[0]) {
                    const reader = new FileReader();
                    reader.onload = function(e) {
                        document.getElementById('avatarPreview').style.backgroundImage = `url('${e.target.result}')`;
                    }
                    reader.readAsDataURL(input.files[0]);
                    // Clear the URL input so file takes priority
                    document.getElementById('avatarUrlInput').value = "";
                }
            }

            function updateAvatarViaURL() {
                const current = document.getElementById('avatarUrlInput').value;
                const newUrl = prompt("Nhập URL ảnh đại diện mới:", current);
                if (newUrl !== null && newUrl.trim() !== "") {
                    document.getElementById('avatarUrlInput').value = newUrl.trim();
                    document.getElementById('avatarPreview').style.backgroundImage = `url('${newUrl.trim()}')`;
                    // Clear the file input
                    document.getElementById('avatarFileInput').value = "";
                }
            }

            function openDeleteModal() {
                document.getElementById('deleteModal').classList.remove('hidden');
                document.body.classList.add('overflow-hidden');
            }

            function closeDeleteModal() {
                document.getElementById('deleteModal').classList.add('hidden');
                document.body.classList.remove('overflow-hidden');
            }

            function confirmIdentityBeforeDelete() {
                const form = document.getElementById('settingsForm');
                const actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'deleteAccount';
                form.appendChild(actionInput);
                form.submit();
            }

            // Hide notifications after 5 seconds
            setTimeout(() => {
                const toasts = document.querySelectorAll('[id^="toast-"], .animate-in');
                toasts.forEach(toast => {
                    toast.classList.add('opacity-0', 'translate-y-10', 'transition-all', 'duration-500');
                    setTimeout(() => toast.remove(), 500);
                });
            }, 5000);
        </script>
    </body>

    </html>