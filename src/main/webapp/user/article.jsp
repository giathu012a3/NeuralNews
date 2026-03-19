<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="neuralnews.model.Article" %>
<%
    Article art = (Article) request.getAttribute("articleDetail");
%>
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
                            class="inline-block px-3 py-1 rounded bg-primary/10 text-primary text-[11px] font-bold uppercase tracking-wider">Công
                            nghệ</span>
                        <div
                            class="flex items-center gap-1.5 px-2 py-1 bg-green-500/10 text-green-500 rounded text-xs font-medium">
                            <span class="material-symbols-outlined text-sm">sentiment_satisfied</span>
                            <span>Tình cảm tích cực</span>
                        </div>
                    </div>
                    <h1
                        class="text-4xl md:text-5xl lg:text-6xl font-black text-slate-900 dark:text-white leading-[1.1] mb-8">
                        <%= (art != null) ? art.getTitle() : "Không tìm thấy bài viết" %>
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
                                <p class="text-sm font-bold text-slate-900 dark:text-white">Alex Rivera</p>
                                <p class="text-xs text-slate-500">24 Tháng 10, 2023 • Đọc 8 phút</p>
                            </div>
                        </div>
                        <div class="flex items-center gap-3">
                            <button
                                class="flex items-center gap-2 px-4 py-2 rounded-full border border-slate-200 dark:border-slate-700 text-sm font-medium hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors">
                                <span class="material-symbols-outlined text-xl">bookmark</span>
                                Lưu
                            </button>
                            <button class="p-2 rounded-full hover:bg-slate-100 dark:hover:bg-slate-800">
                                <span class="material-symbols-outlined text-xl">share</span>
                            </button>
                        </div>
                    </div>
                    <div class="my-8">
                        <button
                            class="w-full flex items-center justify-between p-4 rounded-xl bg-slate-50 dark:bg-surface-dark border border-slate-200 dark:border-slate-700 hover:border-primary/50 transition-all group">
                            <div class="flex items-center gap-3">
                                <div
                                    class="size-8 rounded-lg bg-primary/10 text-primary flex items-center justify-center">
                                    <span class="material-symbols-outlined text-xl">auto_awesome</span>
                                </div>
                                <span class="font-bold text-slate-900 dark:text-white">Tạo Tóm tắt AI</span>
                            </div>
                            <span
                                class="material-symbols-outlined text-slate-400 group-hover:text-primary">expand_more</span>
                        </button>
                        <div class="mt-4 p-6 bg-blue-50/50 dark:bg-primary/5 rounded-xl border border-primary/10">
                            <h4 class="text-xs font-bold text-primary uppercase tracking-widest mb-4">Nổi bật nhanh</h4>
                            <ul class="space-y-3">
                                <li class="flex items-start gap-3 text-slate-700 dark:text-slate-300 text-sm">
                                    <span class="size-1.5 rounded-full bg-primary shrink-0 mt-1.5"></span>
                                    Các mô hình AI dựa trên trung tâm xử lý dữ liệu mới thể hiện độ chính xác chưa từng
                                    có trong việc dự đoán các thay đổi thời tiết khắc nghiệt.
                                </li>
                                <li class="flex items-start gap-3 text-slate-700 dark:text-slate-300 text-sm">
                                    <span class="size-1.5 rounded-full bg-primary shrink-0 mt-1.5"></span>
                                    Hệ thống sử dụng bộ dữ liệu khí tượng toàn cầu trải dài hơn 40 năm lịch sử khí hậu.
                                </li>
                                <li class="flex items-start gap-3 text-slate-700 dark:text-slate-300 text-sm">
                                    <span class="size-1.5 rounded-full bg-primary shrink-0 mt-1.5"></span>
                                    Tích hợp với cơ sở hạ tầng hiện tại có thể tiết kiệm hàng tỷ đô la chi phí chuẩn bị
                                    phòng chống thiên tai hàng năm.
                                </li>
                                <li class="flex items-start gap-3 text-slate-700 dark:text-slate-300 text-sm">
                                    <span class="size-1.5 rounded-full bg-primary shrink-0 mt-1.5"></span>
                                    Kết quả được bình duyệt cho thấy AI vượt trội hơn các mô hình siêu máy tính truyền
                                    thống 15%.
                                </li>
                            </ul>
                        </div>
                    </div>
                    
                    <% if (art != null && art.getImageUrl() != null && !art.getImageUrl().isBlank()) { %>
                    <div class="my-8 rounded-2xl overflow-hidden shadow-2xl">
                        <img src="<%= art.getDisplayImageUrl(request.getContextPath()) %>" 
                             alt="<%= art.getTitle() %>" 
                             class="w-full h-auto object-cover max-h-[500px]" />
                    </div>
                    <% } %>

                    <div class="article-content prose prose-slate dark:prose-invert max-w-none">
                        <%= (art != null) ? art.getContentProcessed(request.getContextPath()) : "Nội dung đang được cập nhật..." %>
                    </div>
                    
                    <div class="mt-16 pt-12 border-t border-slate-200 dark:border-slate-800">
                    

                    
                    <div
                        class="flex flex-wrap items-center justify-between gap-4 pb-8 border-b border-slate-200 dark:border-slate-800">
                        <div class="flex items-center gap-4">
								<h3 class="text-2xl font-bold text-slate-900 dark:text-white mb-8 ">Thảo luận (128)</h3>
							</div>

<%    String uReaction = (String) request.getAttribute("userReaction");
    if(uReaction == null) uReaction = "NONE";
%>

<div class="flex items-center gap-3">
    <button id="btnLike" onclick="sendReaction('LIKE')" 
            class="p-2 flex items-center gap-1 transition-all hover:text-primary <%= uReaction.equals("LIKE") ? "text-primary" : "" %>">
        <span class="material-symbols-outlined text-2xl <%= uReaction.equals("LIKE") ? "fill-icon" : "" %>">thumb_up</span>
        <span id="likeCount"><%= (art != null) ? art.getLikesCount() : 0 %></span>
    </button>
    
    <button id="btnDislike" onclick="sendReaction('DISLIKE')" 
            class="p-2 flex items-center gap-1 transition-all hover:text-red-500 <%= uReaction.equals("DISLIKE") ? "text-red-500" : "" %>">
        <span class="material-symbols-outlined text-2xl <%= uReaction.equals("DISLIKE") ? "fill-icon" : "" %>">thumb_down</span>
        <span id="dislikeCount"><%= (art != null) ? art.getDislikesCount() : 0 %></span>
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

            <div class="fixed bottom-6 right-6 z-50 flex flex-col items-end gap-4">
                <div id="aiAssistantPanel"
                    class="hidden w-80 bg-white dark:bg-surface-dark border border-slate-200 dark:border-slate-700 rounded-2xl shadow-2xl flex-col overflow-hidden animate-in fade-in slide-in-from-bottom-4 duration-300">
                    <div class="p-4 bg-primary text-white flex items-center justify-between">
                        <div class="flex items-center gap-2">
                            <span class="material-symbols-outlined text-xl">smart_toy</span>
                            <span class="font-bold text-sm">Trợ lý NexusAI</span>
                        </div>
                        <button id="closeAiPanel" class="text-white/80 hover:text-white transition-colors">
                            <span class="material-symbols-outlined text-sm">close</span>
                        </button>
                    </div>
                    <div class="p-4 h-64 overflow-y-auto space-y-4">
                        <div
                            class="bg-slate-100 dark:bg-slate-800 p-3 rounded-lg text-xs text-slate-700 dark:text-slate-300">
                            Xin chào! Tôi đã đọc bài viết này. Tôi có thể giúp gì cho bạn hôm nay?
                        </div>
                        <div class="flex flex-col gap-2">
                            <button
                                class="text-left p-2 rounded-lg bg-slate-50 dark:bg-slate-800/50 border border-slate-200 dark:border-slate-700 text-[11px] hover:bg-primary/10 transition-colors text-slate-600 dark:text-slate-400">
                                "Giải thích thêm về mô hình thời tiết AI"
                            </button>
                            <button
                                class="text-left p-2 rounded-lg bg-slate-50 dark:bg-slate-800/50 border border-slate-200 dark:border-slate-700 text-[11px] hover:bg-primary/10 transition-colors text-slate-600 dark:text-slate-400">
                                "Tóm tắt phần kỹ thuật"
                            </button>
                            <button
                                class="text-left p-2 rounded-lg bg-slate-50 dark:bg-slate-800/50 border border-slate-200 dark:border-slate-700 text-[11px] hover:bg-primary/10 transition-colors text-slate-600 dark:text-slate-400">
                                "Dữ liệu này đã được bình duyệt chưa?"
                            </button>
                        </div>
                    </div>
                    <div class="p-3 border-t border-slate-100 dark:border-slate-800">
                        <div class="flex items-center gap-2 bg-slate-100 dark:bg-slate-800 rounded-lg px-3 py-2">
                            <input
                                class="bg-transparent border-none text-xs focus:ring-0 flex-1 text-slate-900 dark:text-white"
                                placeholder="Hỏi AI..." type="text" />
                            <button class="text-primary"><span
                                    class="material-symbols-outlined text-sm">send</span></button>
                        </div>
                    </div>
                </div>
                <button id="toggleAiPanel"
                    class="size-14 rounded-full bg-primary text-white shadow-xl flex items-center justify-center hover:scale-110 active:scale-95 transition-all ring-4 ring-white dark:ring-background-dark">
                    <span class="material-symbols-outlined text-3xl">smart_toy</span>
                </button>
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
            
            // Lấy categoryId từ object articleDetail mà Controller của bạn đã nạp
			    const catId = <%= ((neuralnews.model.Article)request.getAttribute("articleDetail")).getCategoryId() %>;
			    let scoredTime = false;
			    let scoredScroll = false;
			
			    // 1. Cộng 1 điểm ngay khi vừa mở bài báo
			    sendInteraction(1);
			
			    // 2. Sau 20 giây ở lại trang, cộng 3 điểm
			    setTimeout(() => {
			        if (!scoredTime) {
			            sendInteraction(3);
			            scoredTime = true;
			        }
			    }, 20000);
			
			    // 3. Lướt xuống gần cuối trang (còn 200px nữa là hết), cộng 5 điểm
			    window.addEventListener('scroll', function() {
    // Logic cộng điểm khi đọc hết bài
    if (!scoredScroll && (window.innerHeight + window.scrollY) >= document.body.offsetHeight - 200) {
        sendInteraction(5);
        scoredScroll = true;
    }
});
			
			    function sendInteraction(points) {
			        const params = new URLSearchParams();
			        params.append('categoryId', catId);
			        params.append('score', points);

			        // Dùng EL ${pageContext.request.contextPath} để chắc chắn đường dẫn luôn đúng
			        fetch('${pageContext.request.contextPath}/update-interest', {
			            method: 'POST',
			            body: params
			        }).then(res => {
			            if(res.ok) console.log("Đã cộng " + points + " điểm thành công!");
			        });
			    }
			    
			    setTimeout(() => {
			        const artId = "<%= (art != null) ? art.getId() : "" %>";
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
			    }, 3000);
			    
			    function sendReaction(type) {
			        // Cách 1: Lấy ID từ đối tượng art (phải đảm bảo art không null)
			        const articleId = "<%= (art != null) ? art.getId() : "" %>";
			        
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
        </script>
    </body>

    </html>
    