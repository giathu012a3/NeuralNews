<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="art" value="${articleDetail}" />
<c:set var="uReaction" value="${userReaction != null ? userReaction : 'NONE'}" />
    <!DOCTYPE html>
    <html class="dark" lang="en">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="${pageContext.request.contextPath}/assets/js/utils.js"></script>

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
								<h3 class="text-2xl font-bold text-slate-900 dark:text-white mb-8 ">
								Thảo luận (${not empty commentCount ? commentCount : 0})
								</h3>
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
				        <c:set var="u" value="${sessionScope.currentUser}" />
				<c:set var="userAvt" value="${not empty u.avatarUrl ? u.avatarUrl : 'https://ui-avatars.com/api/?name=' += u.fullName += '&background=0D8ABC&color=fff'}" />
				<c:if test="${not fn:contains(userAvt, 'http')}">
				    <c:set var="userAvt" value="${pageContext.request.contextPath}/${userAvt}" />
				</c:if>
        <img src="${userAvt}" class="size-full object-cover" onerror="this.src='https://www.transparentpng.com/download/user/gray-user-profile-icon-png-f8ywop.png'">
    </div>
    <div class="flex-1">
        <form id="commentForm" action="${pageContext.request.contextPath}/add-comment" method="POST">
            <input type="hidden" name="articleId" value="${art.id}">
            <textarea id="commentContent" name="content" required
                class="w-full p-4 rounded-xl bg-slate-50 dark:bg-surface-dark border-slate-200 dark:border-slate-700 focus:ring-primary focus:border-primary text-sm transition-all text-slate-900 dark:text-white"
                placeholder="Tham gia cuộc trò chuyện..." rows="3"></textarea>
            <div class="mt-2 flex justify-end">
                <button type="button" onclick="checkLoginAndPost()"
                    class="px-6 py-2 bg-primary text-white text-sm font-bold rounded-full hover:bg-primary-dark transition-colors">
                    Đăng bình luận
                </button>
            </div>
        </form>
    </div>
</div>

<div class="space-y-8">
    <c:forEach items="${listComments}" var="cmt">
        <c:if test="${empty cmt.parentId || cmt.parentId == 0}">
            <div class="group">
                <div class="flex gap-4">
                    <div class="size-10 rounded-full bg-slate-300 shrink-0 overflow-hidden">
                        <c:set var="cmtAvt" value="${not empty cmt.userAvatar ? cmt.userAvatar : 'https://ui-avatars.com/api/?name=' += cmt.userName += '&background=0D8ABC&color=fff'}" />
                        <c:if test="${not fn:contains(cmtAvt, 'http')}">
                            <c:set var="cmtAvt" value="${pageContext.request.contextPath}/${cmtAvt}" />
                        </c:if>
                        <img src="${cmtAvt}" class="size-full object-cover">
                    </div>
                    
                    <div class="flex-1">
                        <div class="flex items-center gap-2 mb-1">
                            <span class="font-bold text-sm text-slate-900 dark:text-white">${cmt.userName}</span>
                            <span class="text-xs text-slate-500">
                                <fmt:formatDate value="${cmt.createdAt}" pattern="dd/MM/yyyy HH:mm" />
                            </span>
                        </div>
                        <p class="text-sm text-slate-700 dark:text-slate-300 mb-3">${cmt.content}</p>
                        
                        <div class="flex items-center gap-4 text-xs font-bold text-slate-500 mb-4">
					    <button onclick="likeComment(${cmt.id})" 
						        class="flex items-center gap-1 hover:text-primary transition-all ${cmt.likedByUser ? 'text-primary' : ''}">
						    <span class="material-symbols-outlined text-sm">thumb_up</span> 
						    <span id="like-count-${cmt.id}">${cmt.likesCount}</span>
						</button>
					    <button onclick="showReplyForm(${cmt.id})" class="hover:text-primary transition-all">Trả lời</button>
					    <button class="flex items-center gap-1 hover:text-red-500 transition-all group" title="Báo cáo vi phạm">
					        <span class="material-symbols-outlined text-sm text-slate-400 group-hover:text-red-500">report</span>
					    </button>
					    <c:if test="${not empty sessionScope.currentUser and sessionScope.currentUser.id == cmt.userId}">
    <button onclick="confirmDelete(${cmt.id})" class="flex items-center gap-1 hover:text-red-500 transition-all text-slate-400">
        <span class="material-symbols-outlined text-sm">delete</span>
        <span>Xóa</span>
    </button>
</c:if>
					</div>

                        <div id="replyForm-${cmt.id}" class="hidden mt-6 mb-10 animate-in fade-in slide-in-from-top-2">
                             <div class="flex gap-4">
                                <div class="size-10 rounded-full bg-slate-200 overflow-hidden shrink-0 mt-1">
                                    <c:set var="u" value="${sessionScope.currentUser}" />
                                    <c:set var="userAvt" value="${not empty u.avatarUrl ? u.avatarUrl : 'https://ui-avatars.com/api/?name=' += u.fullName += '&background=0D8ABC&color=fff'}" />
                                    <c:if test="${not fn:contains(userAvt, 'http')}">
                                        <c:set var="userAvt" value="${pageContext.request.contextPath}/${userAvt}" />
                                    </c:if>
                                    <img src="${userAvt}" class="size-full object-cover" onerror="this.src='https://www.transparentpng.com/download/user/gray-user-profile-icon-png-f8ywop.png'">
                                </div>
                                <div class="flex-1">
                                    <textarea id="replyContent-${cmt.id}" required
                                        class="w-full p-4 rounded-xl bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 focus:ring-1 focus:ring-primary focus:border-primary text-sm transition-all text-slate-900 dark:text-white"
                                        placeholder="Viết phản hồi công khai..." rows="3"></textarea>
                                    <div class="mt-3 flex justify-end gap-3 items-center">
                                        <button class="px-5 py-2 text-sm font-bold text-slate-500 hover:text-slate-700 dark:hover:text-white transition-colors" 
                                                onclick="hideReplyForm(${cmt.id})">Hủy</button>
                                        <button class="px-7 py-2 bg-primary text-white text-sm font-bold rounded-full hover:bg-primary-dark transition-colors shadow-md" 
                                                onclick="sendReply(${cmt.id}, ${cmt.id})">Gửi</button>
                                    </div>
                                </div>
                            </div>
                        </div>

							<div class="mt-4 space-y-6 ml-12 border-l-2 border-slate-100 dark:border-slate-800 pl-4">
							    <c:forEach items="${listComments}" var="reply">
							        <c:if test="${reply.parentId == cmt.id}">
							            <div class="flex gap-3 group/reply">
							                <div class="size-8 rounded-full bg-slate-400 shrink-0 overflow-hidden">
							                    <c:set var="replyAvt" value="${not empty reply.userAvatar ? reply.userAvatar : 'https://ui-avatars.com/api/?name=' += reply.userName += '&background=0D8ABC&color=fff'}" />
							                    <c:if test="${not fn:contains(replyAvt, 'http')}">
							                        <c:set var="replyAvt" value="${pageContext.request.contextPath}/${replyAvt}" />
							                    </c:if>
							                    <img src="${replyAvt}" class="size-full object-cover">
							                </div>
							                
							                <div class="flex-1">
							                    <div class="flex items-center gap-2 mb-1">
							                        <span class="font-bold text-[13px] text-slate-900 dark:text-white">${reply.userName}</span>
							                        <span class="text-[10px] text-slate-500">
							                            <fmt:formatDate value="${reply.createdAt}" pattern="dd/MM/yyyy HH:mm" />
							                        </span>
							                    </div>
							                    <p class="text-[13px] text-slate-700 dark:text-slate-300 mb-2">${reply.content}</p>
							                    
							                    <div class="flex items-center gap-4 text-[11px] font-bold text-slate-500 mb-4">
							                        <button onclick="likeComment(${reply.id})" 
							                                class="flex items-center gap-1 hover:text-primary transition-all ${reply.likedByUser ? 'text-primary' : ''}">
							                            <span class="material-symbols-outlined text-[14px]">thumb_up</span> 
							                            <span id="like-count-${reply.id}">${reply.likesCount}</span>
							                        </button>
							                        <button onclick="showReplyForm(${reply.id})" class="hover:text-primary transition-all">Trả lời</button>
							                        <button class="flex items-center gap-1 hover:text-red-500 transition-all group" title="Báo cáo vi phạm">
												        <span class="material-symbols-outlined text-sm text-slate-400 group-hover:text-red-500">report</span>
												    </button>
												    <c:if test="${not empty sessionScope.currentUser and sessionScope.currentUser.id == cmt.userId}">
    <button onclick="confirmDelete(${cmt.id})" class="flex items-center gap-1 hover:text-red-500 transition-all text-slate-400">
        <span class="material-symbols-outlined text-sm">delete</span>
        <span>Xóa</span>
    </button>
</c:if>
							                    </div>
							
							                    <div id="replyForm-${reply.id}" class="hidden mt-6 mb-10 animate-in fade-in slide-in-from-top-2">
							                        <div class="flex gap-4">
							                            <div class="size-10 rounded-full bg-slate-200 overflow-hidden shrink-0 mt-1">
							                                <c:set var="u" value="${sessionScope.currentUser}" />
							                                <c:set var="userAvt" value="${not empty u.avatarUrl ? u.avatarUrl : 'https://ui-avatars.com/api/?name=' += u.fullName += '&background=0D8ABC&color=fff'}" />
							                                <c:if test="${not fn:contains(userAvt, 'http')}">
							                                    <c:set var="userAvt" value="${pageContext.request.contextPath}/${userAvt}" />
							                                </c:if>
							                                <img src="${userAvt}" class="size-full object-cover" onerror="this.src='https://www.transparentpng.com/download/user/gray-user-profile-icon-png-f8ywop.png'">
							                            </div>
							                            <div class="flex-1">
							                                <textarea id="replyContent-${reply.id}" required
							                                    class="w-full p-4 rounded-xl bg-slate-50 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 focus:ring-1 focus:ring-primary focus:border-primary text-sm transition-all text-slate-900 dark:text-white"
							                                    placeholder="Viết phản hồi công khai..." rows="3"></textarea>
							                                <div class="mt-3 flex justify-end gap-3 items-center">
							                                    <button class="px-5 py-2 text-sm font-bold text-slate-500 hover:text-slate-700 dark:hover:text-white transition-colors" 
							                                            onclick="hideReplyForm(${reply.id})">Hủy</button>
							                                    <button class="px-7 py-2 bg-primary text-white text-sm font-bold rounded-full hover:bg-primary-dark transition-colors shadow-md" 
							                                            onclick="sendReply(${reply.id}, ${cmt.id})">Gửi</button>
						                                </div>
						                            </div>
						                        </div>
						                    </div>
						                </div>
						            </div>
						        </c:if>
						    </c:forEach>
						</div>
                    </div>
                </div>
            </div>
        </c:if>
    </c:forEach>
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
        	const isLoggedIn = ${not empty sessionScope.currentUser ? 'true' : 'false'};
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
			        const articleId = "${not empty art ? art.id : ''}";
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

			        btnLike.classList.remove('text-primary');
			        btnLike.querySelector('span').classList.remove('fill-icon');
			        btnDislike.classList.remove('text-red-500');
			        btnDislike.querySelector('span').classList.remove('fill-icon');

			        if (status === 'LIKE') {
			            btnLike.classList.add('text-primary');
			            btnLike.querySelector('span').classList.add('fill-icon');
			        } else if (status === 'DISLIKE') {
			            btnDislike.classList.add('text-red-500');
			            btnDislike.querySelector('span').classList.add('fill-icon');
			        }

			        lCount.innerText = likes || 0;
			        dCount.innerText = dislikes || 0;
			        
			        console.log("Cập nhật UI xong - Trạng thái hiện tại:", status);
			    }
			    
			    function checkLoginAndPost() {
			        const isLoggedIn = ${not empty sessionScope.currentUser ? 'true' : 'false'};
			        const content = document.getElementById('commentContent').value.trim();
			        const articleId = "${art.id}";

			        if (!isLoggedIn) {
			            if (confirm("Bạn cần đăng nhập để gửi bình luận.")) {
			            }
			            return;
			        }

			        if (content === "") {
			            alert("Vui lòng nhập nội dung!");
			            return;
			        }

			        const data = {
			            articleId: articleId,
			            content: content
			        };

			        ajaxUtils.post('${pageContext.request.contextPath}/add-comment', data)
			            .then(res => {
			                if (res.status === 'success') {
			                    document.getElementById('commentContent').value = '';
			                    location.reload(); 
			                } else {
			                    alert("Lỗi: " + res.message);
			                }
			            })
			            .catch(err => {
			                console.error(err);
			                alert("Không thể kết nối đến máy chủ!");
			            });
			    }
			    
			    function showReplyForm(id) {
			        document.querySelectorAll('[id^="replyForm-"]').forEach(el => el.classList.add('hidden'));
			        document.getElementById('replyForm-' + id).classList.remove('hidden');
			    }

			    function hideReplyForm(id) {
			        document.getElementById('replyForm-' + id).classList.add('hidden');
			    }

			    function sendReply(currentId, rootParentId) {
			        if (!isLoggedIn) {
			            alert("Bạn cần đăng nhập để thực hiện tính năng này.");
			            return;
			        }
			        
			        const content = document.getElementById('replyContent-' + currentId).value.trim();
			        const articleId = "${art.id}";

			        if (content === "") return;

			        const data = {
			            articleId: articleId,
			            content: content,
			            parentId: rootParentId 
			        };

			        ajaxUtils.post('${pageContext.request.contextPath}/add-comment', data)
			            .then(res => {
			                if (res.status === 'success') location.reload();
			            });
			    }
			    
			    function likeComment(commentId) {
			    	if (!isLoggedIn) {
			            alert("Bạn cần đăng nhập để thực hiện tính năng này.");
			            return;
			        }
			    	
			        ajaxUtils.post('${pageContext.request.contextPath}/handle-reaction', { commentId: commentId })
			            .then(res => {
			                const likeSpan = document.getElementById('like-count-' + commentId);
			                const btn = likeSpan.parentElement;
			                likeSpan.innerText = res.newLikes;
			                if (res.status === 'LIKED') {
			                    btn.classList.add('text-primary');
			                } else if (res.status === 'UNLIKED') {
			                    btn.classList.remove('text-primary');
			                }
			            })
			            .catch(err => console.error(err));
			    }
			    
			    function confirmDelete(id) {
			        if (confirm("Bạn có chắc chắn muốn xóa bình luận này không?")) {
			            const params = new URLSearchParams();
			            params.append('commentId', id);

			            fetch('${pageContext.request.contextPath}/delete-comment', {
			                method: 'POST',
			                body: params
			            }).then(res => res.json())
			              .then(data => {
			                  if (data.status === 'success') {
			                      location.reload(); // Xóa xong load lại trang là mất luôn (vì status=0)
			                  } else {
			                      alert("Không thể xóa bình luận này!");
			                  }
			              });
			        }
			    }
        </script>
    </body>

    </html>