<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:set var="art" value="${articleDetail}" />
<c:set var="uReaction" value="${userReaction != null ? userReaction : 'NONE'}" />
    <!DOCTYPE html>
    <html class="dark" lang="en">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <head>
        <title>NexusAI - Trải nghiệm Đọc Bài viết</title>
        <jsp:include page="components/head.jsp" />
        <style>
            .line-clamp-2 {
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            .article-content p {
                margin-bottom: 1.5rem;
                line-height: 1.8;
                font-size: 1.125rem;
                color: #334155;
            }

            .dark .article-content p {
                color: #cbd5e1;
            }
            
                .fill-icon { font-variation-settings: 'FILL' 1; }
    .text-primary { color: #3b82f6; } /* Màu xanh */
    .text-red-500 { color: #ef4444; } /* Màu đỏ */
        </style>
    </head>

    <body
        class="bg-background-light dark:bg-background-dark text-text-main dark:text-white font-display antialiased overflow-x-hidden transition-colors duration-200">
        <div class="flex min-h-screen w-full flex-col">
            <jsp:include page="components/header.jsp" />

            <main class="flex-1 w-full max-w-[1000px] mx-auto p-4 lg:p-12">
                <article class="relative">
                    <div class="flex items-center gap-2 mb-4">
                        <span
                            class="inline-block px-3 py-1 rounded bg-primary/10 text-primary text-[11px] font-bold uppercase tracking-wider">
                            <c:out value="${not empty art.categoryName ? art.categoryName : 'Tin tức'}" />
                        </span>
                    </div>
                    <h1
                        class="text-4xl md:text-5xl lg:text-6xl font-black text-slate-900 dark:text-white leading-[1.1] mb-8">
                        <c:out value="${not empty art ? art.title : 'Không tìm thấy bài viết'}" />
                    </h1>
                    <div
                        class="flex flex-wrap items-center justify-between gap-4 pb-8 border-b border-slate-200 dark:border-slate-800">
                        <div class="flex items-center gap-4">
                            <div class="size-10 rounded-full bg-slate-200 overflow-hidden">
                                <div class="size-full bg-cover bg-center"
                                    style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCqHJoDOZXEs2I-dWg4cNlhnZWUAg-oBJGZBmq-PpFoJ50SV0NIa98rHAwe3bxy50vyDTw8NHXXjoiNAgpWnLDQFnXhwjbF1AjVEqM11aGgAOtWj5SSP8yDkoQK1AtowhO1u68BOZOlFIT9MNofGpAlZ3JqZTUDZnPnJXrW2cjFXP9ywq1Un_lnbETpHo9rOZaGlocLFlhstxpM83Zzw8q542F04tYAv4jhfi5wKUicr1qd6_Lz2OKuF66ucETPy-Se0VxXmBa0LSQo');">
                                </div>
                            </div>
                            <div>
                                <p class="text-sm font-bold text-slate-900 dark:text-white">
                                    <c:out value="${not empty art.authorName ? art.authorName : 'Tác giả'}" />
                                </p>
                                <p class="text-xs text-slate-500">
                                    <fmt:formatDate value="${art.publishedAt}" pattern="dd 'Tháng' MM, yyyy" /> • 
                                    <c:out value="${not empty art.readingTime ? art.readingTime : 'Đọc ... phút'}" />
                                </p>
                            </div>
                        </div>
                        <div class="flex items-center gap-3">
                            <button id="btnBookmark" onclick="toggleBookmark()"
                                class="flex items-center gap-2 px-4 py-2 rounded-full border border-slate-200 dark:border-slate-700 text-sm font-medium hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors ${isBookmarked ? 'text-primary border-primary bg-primary/5' : ''}">
                                <span class="material-symbols-outlined text-xl ${isBookmarked ? 'fill-icon' : ''}">bookmark</span>
                                <span id="bookmarkText">${isBookmarked ? 'Đã lưu' : 'Lưu'}</span>
                            </button>
                            <button onclick="openReportModal()" class="p-2 rounded-full hover:bg-slate-100 dark:hover:bg-slate-800 text-slate-500 hover:text-red-500 transition-colors" title="Báo cáo vi phạm">
                                <span class="material-symbols-outlined text-xl">report</span>
                            </button>
                            <button class="p-2 rounded-full hover:bg-slate-100 dark:hover:bg-slate-800">
                                <span class="material-symbols-outlined text-xl">share</span>
                            </button>
                        </div>
                    </div>
                    <div class="my-8">
                        <button id="btnAiSummary" onclick="generateAiSummary()"
                            class="w-full flex items-center justify-between p-4 rounded-xl bg-slate-50 dark:bg-surface-dark border border-slate-200 dark:border-slate-700 hover:border-primary/50 transition-all group">
                            <div class="flex items-center gap-3">
                                <div
                                    class="size-8 rounded-lg bg-primary/10 text-primary flex items-center justify-center">
                                    <span class="material-symbols-outlined text-xl">auto_awesome</span>
                                </div>
                                <span class="font-bold text-slate-900 dark:text-white">Tạo Tóm tắt AI</span>
                            </div>
                            <span class="material-symbols-outlined text-slate-400 group-hover:text-primary">expand_more</span>
                        </button>
                        <div id="aiSummaryContent" class="hidden mt-4 p-6 bg-blue-50/50 dark:bg-primary/5 rounded-xl border border-primary/10">
                            <h4 class="text-xs font-bold text-primary uppercase tracking-widest mb-4">Nổi bật nhanh (AI Tạo)</h4>
                            <div id="aiSummaryBody" class="text-slate-700 dark:text-slate-300 text-sm leading-relaxed">
                                Đang chuẩn bị tóm tắt...
                            </div>
                        </div>
                    </div>
                    
                    <c:if test="${not empty art and not empty art.imageUrl and not art.imageUrl.isBlank()}">
                    <div class="my-8 rounded-2xl overflow-hidden shadow-2xl">
                        <img src="${art.getDisplayImageUrl(pageContext.request.contextPath)}" 
                             alt="${art.title}" 
                             class="w-full h-auto object-cover max-h-[500px]" />
                    </div>
                    </c:if>

                    <div class="article-content prose prose-slate dark:prose-invert max-w-none">
                        <c:out value="${not empty art ? art.getContentProcessed(pageContext.request.contextPath) : 'Nội dung đang được cập nhật...'}" escapeXml="false" />
                    </div>
                    
                    <div class="mt-16 pt-12 border-t border-slate-200 dark:border-slate-800">
                    

                    
                    <div
                        class="flex flex-wrap items-center justify-between gap-4 pb-8 border-b border-slate-200 dark:border-slate-800">
                        <div class="flex items-center gap-4">
								<h3 class="text-2xl font-bold text-slate-900 dark:text-white mb-8 ">Thảo luận (128)</h3>
							</div>

<div class="flex items-center gap-3">
    <button id="btnLike" onclick="sendReaction('LIKE')" 
            class="p-2 flex items-center gap-1 transition-all hover:text-primary ${uReaction == 'LIKE' ? 'text-primary' : ''}">
        <span class="material-symbols-outlined text-2xl ${uReaction == 'LIKE' ? 'fill-icon' : ''}">thumb_up</span>
        <span id="likeCount">${not empty art ? art.likesCount : 0}</span>
    </button>
    
    <button id="btnDislike" onclick="sendReaction('DISLIKE')" 
            class="p-2 flex items-center gap-1 transition-all hover:text-red-500 ${uReaction == 'DISLIKE' ? 'text-red-500' : ''}">
        <span class="material-symbols-outlined text-2xl ${uReaction == 'DISLIKE' ? 'fill-icon' : ''}">thumb_down</span>
        <span id="dislikeCount">${not empty art ? art.dislikesCount : 0}</span>
    </button>
</div>
                    </div>
                    
                    
                        <div class="flex gap-4 mb-10">
                            <div class="size-10 rounded-full bg-slate-200 overflow-hidden shrink-0">
                                <div class="size-full bg-cover bg-center"
                                    style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCqHJoDOZXEs2I-dWg4cNlhnZWUAg-oBJGZBmq-PpFoJ50SV0NIa98rHAwe3bxy50vyDTw8NHXXjoiNAgpWnLDQFnXhwjbF1AjVEqM11aGgAOtWj5SSP8yDkoQK1AtowhO1u68BOZOlFIT9MNofGpAlZ3JqZTUDZnPnJXrW2cjFXP9ywq1Un_lnbETpHo9rOZaGlocLFlhstxpM83Zzw8q542F04tYAv4jhfi5wKUicr1qd6_Lz2OKuF66ucETPy-Se0VxXmBa0LSQo');">
                                </div>
                            </div>
                            <div class="flex-1">
                                <textarea
                                    class="w-full p-4 rounded-xl bg-slate-50 dark:bg-surface-dark border-slate-200 dark:border-slate-700 focus:ring-primary focus:border-primary text-sm transition-all"
                                    placeholder="Tham gia cuộc trò chuyện..." rows="3"></textarea>
                                <div class="mt-2 flex justify-end">
                                    <button
                                        class="px-6 py-2 bg-primary text-white text-sm font-bold rounded-full hover:bg-primary-dark transition-colors">Đăng
                                        bình luận</button>
                                </div>
                            </div>
                        </div>
                        <div class="space-y-8">
                            <div class="flex gap-4">
                                <div class="size-10 rounded-full bg-slate-300 shrink-0"></div>
                                <div class="flex-1">
                                    <div class="flex items-center gap-2 mb-1">
                                        <span class="font-bold text-sm text-slate-900 dark:text-white">Sarah
                                            Jenkins</span>
                                        <span class="text-xs text-slate-500">2 giờ trước</span>
                                    </div>
                                    <p class="text-sm text-slate-700 dark:text-slate-300 mb-3">
                                        Điều này thực sự hấp dẫn. Tôi tự hỏi điều này ảnh hưởng thế nào đến phí bảo hiểm
                                        ở
                                        các khu vực có nguy cơ cao nếu độ chính xác vẫn cao như thế này.
                                    </p>
                                    <div class="flex items-center gap-4 text-xs font-bold text-slate-500">
                                        <button class="flex items-center gap-1 hover:text-primary"><span
                                                class="material-symbols-outlined text-sm">thumb_up</span> 24</button>
                                        <button class="hover:text-primary">Trả lời</button>
                                    </div>
                                </div>
                            </div>
                            <div class="flex gap-4">
                                <div class="size-10 rounded-full bg-slate-300 shrink-0"></div>
                                <div class="flex-1">
                                    <div class="flex items-center gap-2 mb-1">
                                        <span class="font-bold text-sm text-slate-900 dark:text-white">Michael
                                            Chen</span>
                                        <span class="text-xs text-slate-500">5 giờ trước</span>
                                    </div>
                                    <p class="text-sm text-slate-700 dark:text-slate-300 mb-3">
                                        Mô hình này có tính đến sự biến động của biến đổi khí hậu hay nó chỉ dựa trên
                                        mức trung bình trong lịch sử?
                                    </p>
                                    <div class="flex items-center gap-4 text-xs font-bold text-slate-500">
                                        <button class="flex items-center gap-1 hover:text-primary"><span
                                                class="material-symbols-outlined text-sm">thumb_up</span> 12</button>
                                        <button class="hover:text-primary">Trả lời</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </article>
            </main>

            <jsp:include page="components/footer.jsp" />

            </div>

            <!-- Report Modal -->
            <div id="reportModal" class="hidden fixed inset-0 z-[100] flex items-center justify-center p-4">
                <div class="absolute inset-0 bg-slate-900/60 backdrop-blur-sm" onclick="closeReportModal()"></div>
                <div class="relative w-full max-w-md bg-white dark:bg-surface-dark rounded-2xl shadow-2xl overflow-hidden animate-in zoom-in duration-200">
                    <div class="p-6 border-b border-slate-100 dark:border-slate-800 flex items-center justify-between">
                        <h3 class="text-xl font-bold text-slate-900 dark:text-white">Báo cáo bài viết</h3>
                        <button onclick="closeReportModal()" class="text-slate-400 hover:text-slate-600 dark:hover:text-slate-200">
                            <span class="material-symbols-outlined">close</span>
                        </button>
                    </div>
                    <form id="reportForm" onsubmit="submitReport(event)" class="p-6 space-y-4">
                        <div>
                            <label class="block text-sm font-bold text-slate-700 dark:text-slate-300 mb-2">Lý do báo cáo</label>
                            <select name="reason" required class="w-full p-3 rounded-xl bg-slate-50 dark:bg-slate-800 border-slate-200 dark:border-slate-700 text-sm">
                                <option value="">Chọn một lý do...</option>
                                <option value="Nội dung sai sự thật">Nội dung sai sự thật</option>
                                <option value="Ngôn từ thù ghét">Ngôn từ thù ghét</option>
                                <option value="Vi phạm bản quyền">Vi phạm bản quyền</option>
                                <option value="Nội dung nhạy cảm">Nội dung nhạy cảm</option>
                                <option value="Khác">Lý do khác</option>
                            </select>
                        </div>
                        <div>
                            <label class="block text-sm font-bold text-slate-700 dark:text-slate-300 mb-2">Chi tiết (Tùy chọn)</label>
                            <textarea name="details" rows="4" class="w-full p-3 rounded-xl bg-slate-50 dark:bg-slate-800 border-slate-200 dark:border-slate-700 text-sm" placeholder="Mô tả thêm về vi phạm..."></textarea>
                        </div>
                        <div class="flex gap-3 pt-2">
                            <button type="button" onclick="closeReportModal()" class="flex-1 px-4 py-2 rounded-full border border-slate-200 dark:border-slate-700 text-sm font-bold hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors">Hủy</button>
                            <button type="submit" class="flex-1 px-4 py-2 bg-red-500 text-white text-sm font-bold rounded-full hover:bg-red-600 transition-colors">Gửi báo cáo</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const aiPanel = document.getElementById('aiAssistantPanel');
                const toggleBtn = document.getElementById('toggleAiPanel');
                const closeBtn = document.getElementById('closeAiPanel');

                function toggleAi() {
                    if (aiPanel.classList.contains('hidden')) {
                        aiPanel.classList.remove('hidden');
                        aiPanel.classList.add('flex');
                    } else {
                        aiPanel.classList.add('hidden');
                        aiPanel.classList.remove('flex');
                    }
                }

                toggleBtn.addEventListener('click', toggleAi);
                closeBtn.addEventListener('click', function(e) {
                    e.stopPropagation();
                    aiPanel.classList.add('hidden');
                    aiPanel.classList.remove('flex');
                });
            });
            
//---------------------------------------------------------------------------------------------------------------------------
            
			    setTimeout(() => {
			        const artId = "${not empty art ? art.id : ''}";
                    if (!artId) return;
			        console.log("--- Đã đủ 30 giây! Đang chuẩn bị gửi request tăng view cho ID: " + artId + " ---");

			        const params = new URLSearchParams();
			        params.append('articleId', artId);
			        params.append('action', 'view');

			        fetch('${pageContext.request.contextPath}/handle-reaction', {
			            method: 'POST',
			            body: params
			        }).then(res => {
			            console.log("--- Server đã phản hồi! Status: " + res.status + " ---");
			            if(res.ok) console.log("--- Tăng view thành công trên giao diện ---");
			        }).catch(err => {
			            console.error("--- Lỗi Fetch: ", err);
			        });
			    }, 30000);
			    
			    function sendReaction(type) {
			        // Cách 1: Lấy ID từ đối tượng art (phải đảm bảo art không null)
			        const articleId = "${not empty art ? art.id : ''}";
			        
			        // Kiểm tra nếu articleId rỗng thì không gửi request nữa
			        if (!articleId || articleId === "") {
			            console.error("Lỗi: Không tìm thấy ID bài viết trong JSP!");
			            return;
			        }

			        const params = new URLSearchParams();
			        params.append('articleId', articleId);
			        params.append('type', type);

			        fetch('${pageContext.request.contextPath}/handle-reaction', {
			            method: 'POST',
			            body: params
			        })
			        .then(res => {
			            if (!res.ok) throw new Error('Server 500');
			            return res.json();
			        })
			        .then(data => {
				        if (data.status === 'UNAUTHORIZED') {
				            const goToLogin = confirm("Bạn cần đăng nhập để thực hiện tính năng này.");
				            return;
				        }
				        updateUI(data.status, data.newLikes, data.newDislikes);
				    })
			    }

			    function updateUI(status, likes, dislikes) {
			        const btnLike = document.getElementById('btnLike');
			        const btnDislike = document.getElementById('btnDislike');
			        const lCount = document.getElementById('likeCount');
			        const dCount = document.getElementById('dislikeCount');

			        // 1. Reset trạng thái cũ
			        btnLike.classList.remove('text-primary');
			        btnLike.querySelector('span').classList.remove('fill-icon');
			        btnDislike.classList.remove('text-red-500');
			        btnDislike.querySelector('span').classList.remove('fill-icon');

			        // 2. Cập nhật màu sắc dựa trên status mới
			        if (status === 'LIKE') {
			            btnLike.classList.add('text-primary');
			            btnLike.querySelector('span').classList.add('fill-icon');
			        } else if (status === 'DISLIKE') {
			            btnDislike.classList.add('text-red-500');
			            btnDislike.querySelector('span').classList.add('fill-icon');
			        }

			        // 3. Cập nhật con số (Dùng || 0 để tránh hiện chữ 'undefined')
			        lCount.innerText = likes || 0;
			        dCount.innerText = dislikes || 0;
			        
			        console.log("Cập nhật UI xong - Trạng thái hiện tại:", status);
			    }

                // 3. Toggles
                function toggleBookmark() {
                    const articleId = "${not empty art ? art.id : ''}";
                    if (!articleId) return;

                    const params = new URLSearchParams();
                    params.append('articleId', articleId);
                    params.append('action', 'bookmark');

                    fetch('${pageContext.request.contextPath}/handle-reaction', {
                        method: 'POST',
                        body: params
                    })
                    .then(res => res.json())
                    .then(data => {
                        if (data.status === 'UNAUTHORIZED') {
                            alert("Bạn cần đăng nhập để lưu bài viết.");
                            return;
                        }
                        if (data.status === 'SUCCESS') {
                            const btn = document.getElementById('btnBookmark');
                            const text = document.getElementById('bookmarkText');
                            const icon = btn.querySelector('.material-symbols-outlined');
                            
                            if (data.isBookmarked) {
                                btn.classList.add('text-primary', 'border-primary', 'bg-primary/5');
                                icon.classList.add('fill-icon');
                                text.innerText = 'Đã lưu';
                            } else {
                                btn.classList.remove('text-primary', 'border-primary', 'bg-primary/5');
                                icon.classList.remove('fill-icon');
                                text.innerText = 'Lưu';
                            }
                        }
                    });
                }

                function openReportModal() {
                    document.getElementById('reportModal').classList.remove('hidden');
                }
                function closeReportModal() {
                    document.getElementById('reportModal').classList.add('hidden');
                }
                function submitReport(e) {
                    e.preventDefault();
                    const articleId = "${not empty art ? art.id : ''}";
                    const formData = new FormData(e.target);
                    
                    const params = new URLSearchParams();
                    params.append('articleId', articleId);
                    params.append('action', 'report');
                    params.append('reason', formData.get('reason'));
                    params.append('details', formData.get('details'));

                    fetch('${pageContext.request.contextPath}/handle-reaction', {
                        method: 'POST',
                        body: params
                    })
                    .then(res => res.json())
                    .then(data => {
                        if (data.status === 'UNAUTHORIZED') {
                            alert("Bạn cần đăng nhập để báo cáo.");
                            return;
                        }
                        if (data.status === 'SUCCESS') {
                            alert("Cảm ơn bạn đã báo cáo. Chúng tôi sẽ xem xét sớm nhất có thể.");
                            closeReportModal();
                        } else {
                            alert("Có lỗi xảy ra, vui lòng thử lại sau.");
                        }
                    });
                }

                function generateAiSummary() {
                    const articleId = "${not empty art ? art.id : ''}";
                    const container = document.getElementById('aiSummaryContent');
                    const body = document.getElementById('aiSummaryBody');
                    const btn = document.getElementById('btnAiSummary');
                    
                    if (!articleId) return;

                    // Hiện container và thông báo đang tải
                    container.classList.remove('hidden');
                    body.innerHTML = `
                        <div class="flex flex-col gap-2">
                            <div class="h-4 bg-slate-200 dark:bg-slate-700 rounded animate-pulse w-3/4"></div>
                            <div class="h-4 bg-slate-200 dark:bg-slate-700 rounded animate-pulse w-full"></div>
                            <div class="h-4 bg-slate-200 dark:bg-slate-700 rounded animate-pulse w-5/6"></div>
                        </div>
                    `;
                    
                    // Vô hiệu hóa nút trong khi chờ
                    btn.disabled = true;
                    btn.style.opacity = '0.5';

                    fetch('${pageContext.request.contextPath}/ai-summary?articleId=' + articleId)
                    .then(res => res.json())
                    .then(data => {
                        if (data.error) {
                            body.innerHTML = '<span class="text-red-500">' + data.error + '</span>';
                        } else {
                            // Convert newline/br to better list format
                            const formatted = data.summary.replace(/- /g, '<br/>• ').replace(/^<br\/>/, '');
                            body.innerHTML = formatted;
                        }
                    })
                    .catch(err => {
                        body.innerHTML = '<span class="text-red-500">Không thể kết nối với dịch vụ AI.</span>';
                    })
                    .finally(() => {
                        btn.disabled = false;
                        btn.style.opacity = '1';
                    });
                }
        </script>
    </body>

    </html>
    