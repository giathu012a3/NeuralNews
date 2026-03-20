/**
 * NexusAI - Article Detail Page
 * Handles: AI Summary, View Counter, Reactions, Bookmark, Report, Comments
 * Requires: ARTICLE_CONFIG = { ctx, id, uReaction }
 */

document.addEventListener('DOMContentLoaded', function () {
    initAiPanel();
    initViewCounter();
    initReactionButtons();
    loadComments();
});

// ═══════════════════════════════════════════════════
// 1. AI PANEL TOGGLE
// ═══════════════════════════════════════════════════
function initAiPanel() {
    const aiPanel = document.getElementById('aiAssistantPanel');
    const toggleBtn = document.getElementById('toggleAiPanel');
    const closeBtn = document.getElementById('closeAiPanel');
    if (!aiPanel || !toggleBtn) return;

    toggleBtn.addEventListener('click', () => {
        aiPanel.classList.toggle('hidden');
        aiPanel.classList.toggle('flex');
    });
    if (closeBtn) {
        closeBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            aiPanel.classList.add('hidden');
            aiPanel.classList.remove('flex');
        });
    }
}

// ═══════════════════════════════════════════════════
// 2. VIEW COUNTER (30s delay)
// ═══════════════════════════════════════════════════
function initViewCounter() {
    const artId = ARTICLE_CONFIG.id;
    if (!artId) return;
    setTimeout(() => {
        const params = new URLSearchParams();
        params.append('articleId', artId);
        params.append('action', 'view');
        fetch(`${ARTICLE_CONFIG.ctx}/handle-reaction`, { method: 'POST', body: params })
            .catch(() => {});
    }, 30000);
}

// ═══════════════════════════════════════════════════
// 3. REACTIONS (Like / Dislike)
// ═══════════════════════════════════════════════════
function initReactionButtons() {
    const reaction = ARTICLE_CONFIG.uReaction;
    const btnLike    = document.getElementById('btnLike');
    const btnDislike = document.getElementById('btnDislike');
    if (!btnLike || !btnDislike) return;

    if (reaction === 'LIKE') {
        btnLike.classList.add('text-primary');
        btnLike.querySelector('span').classList.add('fill-icon');
    } else if (reaction === 'DISLIKE') {
        btnDislike.classList.add('text-red-500');
        btnDislike.querySelector('span').classList.add('fill-icon');
    }
}

function sendReaction(type) {
    const params = new URLSearchParams();
    params.append('articleId', ARTICLE_CONFIG.id);
    params.append('type', type);

    fetch(`${ARTICLE_CONFIG.ctx}/handle-reaction`, { method: 'POST', body: params })
        .then(res => res.json())
        .then(data => {
            if (data.status === 'UNAUTHORIZED') {
                alert('Bạn cần đăng nhập để thực hiện tính năng này.');
                return;
            }
            updateReactionUI(data.status, data.newLikes, data.newDislikes);
        })
        .catch(err => console.error('Reaction error:', err));
}

function updateReactionUI(status, likes, dislikes) {
    const btnLike    = document.getElementById('btnLike');
    const btnDislike = document.getElementById('btnDislike');
    const lCount     = document.getElementById('likeCount');
    const dCount     = document.getElementById('dislikeCount');
    if (!btnLike || !btnDislike) return;

    // Reset
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

    if (lCount) lCount.innerText = likes ?? 0;
    if (dCount) dCount.innerText = dislikes ?? 0;
}

// ═══════════════════════════════════════════════════
// 4. BOOKMARK
// ═══════════════════════════════════════════════════
function toggleBookmark() {
    const params = new URLSearchParams();
    params.append('articleId', ARTICLE_CONFIG.id);
    params.append('action', 'bookmark');

    fetch(`${ARTICLE_CONFIG.ctx}/handle-reaction`, { method: 'POST', body: params })
        .then(res => res.json())
        .then(data => {
            if (data.status === 'UNAUTHORIZED') {
                alert('Bạn cần đăng nhập để lưu bài viết.');
                return;
            }
            if (data.status === 'SUCCESS') {
                const btn  = document.getElementById('btnBookmark');
                const text = document.getElementById('bookmarkText');
                const icon = btn ? btn.querySelector('.material-symbols-outlined') : null;
                if (btn && icon) {
                    if (data.isBookmarked) {
                        btn.classList.add('text-primary', 'border-primary', 'bg-primary/5');
                        icon.classList.add('fill-icon');
                        if (text) text.innerText = 'Đã lưu';
                    } else {
                        btn.classList.remove('text-primary', 'border-primary', 'bg-primary/5');
                        icon.classList.remove('fill-icon');
                        if (text) text.innerText = 'Lưu';
                    }
                }
            }
        });
}

// ═══════════════════════════════════════════════════
// 5. REPORT MODAL
// ═══════════════════════════════════════════════════
function openReportModal() {
    const m = document.getElementById('reportModal');
    if (m) m.classList.remove('hidden');
}
function closeReportModal() {
    const m = document.getElementById('reportModal');
    if (m) m.classList.add('hidden');
}
function submitReport(e) {
    e.preventDefault();
    const form = e.target;
    const params = new URLSearchParams();
    params.append('articleId', ARTICLE_CONFIG.id);
    params.append('action', 'report');
    params.append('reason', form.reason.value);
    params.append('details', form.details.value);

    fetch(`${ARTICLE_CONFIG.ctx}/handle-reaction`, { method: 'POST', body: params })
        .then(res => res.json())
        .then(data => {
            if (data.status === 'UNAUTHORIZED') {
                alert('Bạn cần đăng nhập để báo cáo.'); return;
            }
            if (data.status === 'SUCCESS') {
                alert('Cảm ơn! Báo cáo của bạn đã được ghi nhận.');
                closeReportModal();
            } else {
                alert('Có lỗi xảy ra, vui lòng thử lại.');
            }
        });
}

// ═══════════════════════════════════════════════════
// 6. REPORT COMMENT MODAL
// ═══════════════════════════════════════════════════
let currentReportCommentId = null;

function openCommentReportModal(commentId) {
    currentReportCommentId = commentId;
    const m = document.getElementById('reportCommentModal');
    if (m) m.classList.remove('hidden');
}

function closeCommentReportModal() {
    currentReportCommentId = null;
    const m = document.getElementById('reportCommentModal');
    if (m) m.classList.add('hidden');
}

function submitCommentReport(e) {
    e.preventDefault();
    if (!currentReportCommentId) return;
    const form = e.target;
    const params = new URLSearchParams();
    params.append('action', 'report');
    params.append('commentId', currentReportCommentId);
    params.append('reason', form.reason.value);
    params.append('details', form.details.value);

    fetch(`${ARTICLE_CONFIG.ctx}/comments`, { method: 'POST', body: params })
        .then(res => res.json())
        .then(data => {
            if (data.status === 'UNAUTHORIZED') {
                alert('Bạn cần đăng nhập để báo cáo bình luận.'); 
                return;
            }
            if (data.status === 'SUCCESS') {
                alert('Cảm ơn! Báo cáo bình luận của bạn đã được ghi nhận.');
                closeCommentReportModal();
                form.reset();
            } else {
                alert('Có lỗi xảy ra, vui lòng thử lại.');
            }
        })
        .catch(err => console.error('Report comment error:', err));
}

// ═══════════════════════════════════════════════════
// 7. AI SUMMARY
// ═══════════════════════════════════════════════════
function generateAiSummary() {
    const container = document.getElementById('aiSummaryContent');
    const body      = document.getElementById('aiSummaryBody');
    const btn       = document.getElementById('btnAiSummary');
    if (!container || !body) return;

    container.classList.remove('hidden');
    body.innerHTML = `
        <div class="flex flex-col gap-2">
            <div class="h-4 bg-slate-200 dark:bg-slate-700 rounded animate-pulse w-3/4"></div>
            <div class="h-4 bg-slate-200 dark:bg-slate-700 rounded animate-pulse w-full"></div>
            <div class="h-4 bg-slate-200 dark:bg-slate-700 rounded animate-pulse w-5/6"></div>
        </div>`;
    if (btn) { btn.disabled = true; btn.style.opacity = '0.5'; }

    fetch(`${ARTICLE_CONFIG.ctx}/ai-summary?articleId=${ARTICLE_CONFIG.id}`)
        .then(res => res.json())
        .then(data => {
            if (data.error) {
                body.innerHTML = `<span class="text-red-500">${data.error}</span>`;
            } else {
                body.innerHTML = data.summary.replace(/- /g, '<br>• ').replace(/^<br>/, '');
            }
        })
        .catch(() => {
            body.innerHTML = '<span class="text-red-500">Không thể kết nối với dịch vụ AI.</span>';
        })
        .finally(() => {
            if (btn) { btn.disabled = false; btn.style.opacity = '1'; }
        });
}

// ═══════════════════════════════════════════════════
// 7. COMMENTS
// ═══════════════════════════════════════════════════

function loadComments() {
    const articleId = ARTICLE_CONFIG.id;
    if (!articleId) return;

    fetch(`${ARTICLE_CONFIG.ctx}/comments?articleId=${articleId}`)
        .then(res => res.json())
        .then(data => {
            const container = document.getElementById('commentsContainer');
            const header    = document.getElementById('commentCountHeader');
            if (!container) return;

            if (!Array.isArray(data) || data.length === 0) {
                container.innerHTML = '<p class="text-center text-slate-500 text-sm py-10">Chưa có bình luận nào. Hãy là người đầu tiên thảo luận!</p>';
                if (header) header.innerText = 'Thảo luận (0)';
                return;
            }

            let total = 0;
            let html  = '';
            data.forEach(c => {
                total++;
                if (c.replies) total += c.replies.length;
                html += renderComment(c, false);
            });

            container.innerHTML = html;
            if (header) header.innerText = `Thảo luận (${total})`;
        })
        .catch(err => {
            console.error('Load comments error:', err);
            const container = document.getElementById('commentsContainer');
            if (container) container.innerHTML = '<p class="text-center text-slate-500 text-sm py-10">Lỗi tải bình luận, vui lòng thử lại.</p>';
        });
}

function renderComment(c, isReply) {
    const ctx      = ARTICLE_CONFIG.ctx;
    const avatarUrl = c.userAvatar
        ? (c.userAvatar.startsWith('http') ? c.userAvatar : ctx + c.userAvatar)
        : null;
    const timeStr   = formatTimeAgo(new Date(c.createdAt));
    const likes     = c.likesCount || 0;

    const avatarHtml = avatarUrl
        ? `<img src="${avatarUrl}" class="size-full object-cover" alt="avatar">`
        : `<div class="size-full flex items-center justify-center bg-primary/10 text-primary"><span class="material-symbols-outlined">person</span></div>`;

    const repliesHtml = (c.replies && c.replies.length > 0)
        ? c.replies.map(r => renderComment(r, true)).join('')
        : '';

    const btnClass = c.isLikedByUser ? "text-primary flex items-center gap-1 hover:text-primary transition-colors" : "flex items-center gap-1 hover:text-primary transition-colors";
    const iconClass = c.isLikedByUser ? "material-symbols-outlined text-[16px] fill-icon" : "material-symbols-outlined text-[16px]";

    return `
    <div class="${isReply ? 'ml-14 mt-5' : 'mb-8'}">
        <div class="flex gap-3">
            <div class="size-10 rounded-full bg-slate-200 overflow-hidden shrink-0 border border-slate-100 dark:border-slate-800">
                ${avatarHtml}
            </div>
            <div class="flex-1 min-w-0">
                <div class="flex items-center gap-2 mb-1">
                    <span class="font-bold text-sm text-slate-900 dark:text-white">${escapeHtml(c.userName)}</span>
                    <span class="text-[11px] text-slate-400">${timeStr}</span>
                </div>
                <p class="text-sm text-slate-700 dark:text-slate-300 leading-relaxed mb-3">${escapeHtml(c.content)}</p>
                <div class="flex items-center gap-5 text-[12px] font-semibold text-slate-500 w-full">
                    <button onclick="likeComment(${c.id})" class="${btnClass}" title="Thích">
                        <span class="${iconClass}">thumb_up</span>
                        <span id="like-count-${c.id}">${likes}</span>
                    </button>
                    <button onclick="toggleReplyForm(${c.id})" class="flex items-center gap-1 hover:text-primary transition-colors">
                        <span class="material-symbols-outlined text-[16px]">reply</span>
                        Trả lời
                    </button>
                    <button onclick="openCommentReportModal(${c.id})" class="flex items-center gap-1 hover:text-red-500 transition-colors ml-auto" title="Báo cáo bình luận">
                        <span class="material-symbols-outlined text-[16px]">report</span>
                    </button>
                </div>

                <!-- Reply form -->
                <div id="replyWrapper-${c.id}" class="hidden mt-4">
                    <div class="flex gap-3">
                        <div class="flex-1">
                            <textarea id="replyText-${c.id}"
                                class="w-full p-3 rounded-xl bg-slate-100 dark:bg-slate-800 border border-slate-200 dark:border-slate-700 focus:ring-1 focus:ring-primary text-sm transition-all"
                                placeholder="Viết phản hồi..." rows="2"></textarea>
                            <div class="mt-2 flex justify-end gap-2">
                                <button onclick="toggleReplyForm(${c.id})" class="px-4 py-1.5 text-xs font-bold text-slate-500 hover:text-slate-700 transition-colors">Hủy</button>
                                <button onclick="postComment(${c.id})" class="px-4 py-1.5 bg-primary text-white text-xs font-bold rounded-full hover:bg-primary-dark transition-colors">Gửi</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        ${repliesHtml}
    </div>`;
}

function formatTimeAgo(date) {
    const diff = Math.floor((Date.now() - date) / 1000);
    if (diff < 60)      return 'Vừa xong';
    if (diff < 3600)    return Math.floor(diff / 60) + ' phút trước';
    if (diff < 86400)   return Math.floor(diff / 3600) + ' giờ trước';
    if (diff < 2592000) return Math.floor(diff / 86400) + ' ngày trước';
    return date.toLocaleDateString('vi-VN');
}

function escapeHtml(str) {
    if (!str) return '';
    return str.replace(/&/g, '&amp;')
              .replace(/</g, '&lt;')
              .replace(/>/g, '&gt;')
              .replace(/"/g, '&quot;');
}

function toggleReplyForm(commentId) {
    const wrapper = document.getElementById(`replyWrapper-${commentId}`);
    if (!wrapper) return;
    wrapper.classList.toggle('hidden');
    if (!wrapper.classList.contains('hidden')) {
        const input = document.getElementById(`replyText-${commentId}`);
        if (input) input.focus();
    }
}

function postComment(parentId = null) {
    const articleId = ARTICLE_CONFIG.id;
    const content   = parentId
        ? document.getElementById(`replyText-${parentId}`)?.value
        : document.getElementById('mainCommentText')?.value;

    if (!content || !content.trim()) return;

    const params = new URLSearchParams();
    params.append('articleId', articleId);
    params.append('content', content.trim());
    if (parentId) params.append('parentId', parentId);

    fetch(`${ARTICLE_CONFIG.ctx}/comments`, { method: 'POST', body: params })
        .then(res => res.json())
        .then(data => {
            if (data.status === 'UNAUTHORIZED') {
                alert('Bạn cần đăng nhập để bình luận.');
                return;
            }
            if (data.status === 'SUCCESS') {
                if (parentId) {
                    const textEl    = document.getElementById(`replyText-${parentId}`);
                    const wrapperEl = document.getElementById(`replyWrapper-${parentId}`);
                    if (textEl) textEl.value = '';
                    if (wrapperEl) wrapperEl.classList.add('hidden');
                } else {
                    const mainInput = document.getElementById('mainCommentText');
                    if (mainInput) mainInput.value = '';
                }
                loadComments(); // Reload danh sách
            } else {
                alert('Lỗi: ' + (data.message || 'Không rõ'));
            }
        })
        .catch(err => console.error('Post comment error:', err));
}

function likeComment(commentId) {
    const params = new URLSearchParams();
    params.append('action', 'like');
    params.append('commentId', commentId);
    params.append('articleId', ARTICLE_CONFIG.id);

    fetch(`${ARTICLE_CONFIG.ctx}/comments`, { method: 'POST', body: params })
        .then(res => res.json())
        .then(data => {
            if (data.status === 'UNAUTHORIZED') {
                alert('Bạn cần đăng nhập để thích bình luận.');
                return;
            }
            if (data.status === 'SUCCESS') {
                const countEl = document.getElementById(`like-count-${commentId}`);
                const btnEl = countEl.closest('button');
                const prev = parseInt(countEl.innerText || '0');
                if (data.toggleResult === 'LIKED') {
                    countEl.innerText = prev + 1;
                    btnEl.classList.add('text-primary');
                    btnEl.querySelector('span').classList.add('fill-icon');
                } else if (data.toggleResult === 'UNLIKED') {
                    countEl.innerText = Math.max(prev - 1, 0);
                    btnEl.classList.remove('text-primary');
                    btnEl.querySelector('span').classList.remove('fill-icon');
                }
            }
        })
        .catch(err => console.error('Like comment error:', err));
}
