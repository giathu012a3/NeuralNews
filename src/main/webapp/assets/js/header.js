/**
 * Header Logic for NeuralNews
 * Handles Notifications and AJAX Search
 */

function updateBadge() {
    var count = document.querySelectorAll('.notif-item.unread').length;
    var dot = document.getElementById('notifDot');
    var badge = document.getElementById('notifCount');
    if (count > 0) {
        if (dot) dot.style.display = 'block';
        if (badge) { 
            badge.textContent = count; 
            badge.style.display = 'inline-flex'; 
        }
    } else {
        if (dot) dot.style.display = 'none';
        if (badge) badge.style.display = 'none';
    }
}

function markRead(el) {
    const nurl = el.getAttribute('data-url');
    let finalUrl = null;
    if (nurl && nurl !== 'null' && nurl.trim() !== '') {
        finalUrl = nurl;
        if (!nurl.startsWith('http')) {
           finalUrl = (window.contextPath || '') + (nurl.startsWith('/') ? nurl : '/' + nurl);
        }
    }

    if (el.classList.contains('unread')) {
        el.classList.remove('unread');
        el.style.borderLeftColor = 'transparent';
        el.querySelector('.unread-dot')?.remove();
        
        const nid = el.getAttribute('data-id');
        if (nid) {
            fetch((window.contextPath || '') + '/notification-ajax', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'action=markRead&id=' + encodeURIComponent(nid)
            }).then(() => {
                if(finalUrl) window.location.href = finalUrl;
            }).catch(e => {
                console.error(e);
                if(finalUrl) window.location.href = finalUrl;
            });
        } else {
            if(finalUrl) window.location.href = finalUrl;
        }
        updateBadge();
    } else {
        if(finalUrl) window.location.href = finalUrl;
    }
}

function toggleNotifPanel(e) {
    if (e) {
        e.stopPropagation();
        e.preventDefault();
    }
    const panel = document.getElementById('notifPanel');
    if (panel) {
        panel.classList.toggle('hidden');
    }
}

// Close notifications when clicking outside
document.addEventListener('click', (e) => {
    const panel = document.getElementById('notifPanel');
    const wrapper = document.getElementById('notifWrapper');
    if (panel && !panel.classList.contains('hidden')) {
        if (wrapper && !wrapper.contains(e.target)) {
            panel.classList.add('hidden');
        }
    }
});

function markAllRead() {
    document.querySelectorAll('.notif-item.unread').forEach(el => {
        el.classList.remove('unread');
        el.style.borderLeftColor = 'transparent';
        el.querySelector('.unread-dot')?.remove();
    });
    updateBadge();
    
    fetch((window.contextPath || '') + '/notification-ajax', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'action=markAllRead'
    }).catch(e => console.error(e));
}

// Initializer for Header
function initHeader(contextPath) {
    window.contextPath = contextPath;
    // 1. Notifications Logic
    updateBadge();

    // 2. Search AJAX Logic
    const input = document.getElementById('ajaxSearchInput');
    const resultsBox = document.getElementById('ajaxSearchResults');
    const resultsList = document.getElementById('searchResultsList');
    const loading = document.getElementById('searchLoading');
    const noResults = document.getElementById('searchNoResults');
    const clearBtn = document.getElementById('searchClearBtn');
    let debounceTimer;

    if (!input) return;

    input.addEventListener('input', function() {
        const query = input.value.trim();
        
        if (query.length > 0) {
            clearBtn.classList.remove('hidden');
        } else {
            clearBtn.classList.add('hidden');
            resultsBox.classList.add('hidden');
            return;
        }

        clearTimeout(debounceTimer);
        debounceTimer = setTimeout(() => {
            performSearch(query);
        }, 300);
    });

    // Handle Enter key for full search page
    input.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            const query = input.value.trim();
            if (query.length > 0) {
                window.location.href = `${contextPath}/user/search?keyword=${encodeURIComponent(query)}`;
            }
        }
    });

    if (clearBtn) {
        clearBtn.addEventListener('click', () => {
            input.value = '';
            clearBtn.classList.add('hidden');
            resultsBox.classList.add('hidden');
            input.focus();
        });
    }

    document.addEventListener('click', (e) => {
        if (!e.target.closest('.search-container')) {
            resultsBox.classList.add('hidden');
        }
    });

    async function performSearch(keyword) {
        loading.classList.remove('hidden');
        resultsList.innerHTML = '';
        noResults.classList.add('hidden');
        resultsBox.classList.remove('hidden');

        try {
            // Using the global ajaxUtils if available
            let data;
            if (window.ajaxUtils) {
                data = await ajaxUtils.get(`${contextPath}/search-ajax?keyword=${encodeURIComponent(keyword)}`);
            } else {
                const response = await fetch(`${contextPath}/search-ajax?keyword=${encodeURIComponent(keyword)}`);
                data = await response.json();
            }
            
            loading.classList.add('hidden');

            if (!data || data.length === 0) {
                noResults.classList.remove('hidden');
            } else {
                data.forEach(item => {
                    const div = document.createElement('div');
                    div.className = 'p-3 hover:bg-slate-50 dark:hover:bg-slate-800/40 cursor-pointer flex gap-3 items-center transition-colors';
                    
                    let imgUrl = item.imageUrl || 'assets/images/placeholder.jpg';
                    if (!imgUrl.startsWith('http')) imgUrl = contextPath + '/' + imgUrl;
                    
                    div.innerHTML = `
                        <img src="${imgUrl}" class="size-12 rounded object-cover shrink-0 bg-slate-100">
                        <div class="flex-1 min-w-0">
                            <p class="text-xs font-bold text-primary uppercase mb-0.5">${item.categoryName || 'Tin tức'}</p>
                            <h4 class="text-sm font-bold text-slate-900 dark:text-white truncate">${item.title}</h4>
                            <p class="text-[11px] text-slate-500 line-clamp-1 mt-0.5">${item.summary || ''}</p>
                        </div>
                    `;
                    div.onclick = () => {
                        window.location.href = `${contextPath}/user/article?id=${item.id}`;
                    };
                    resultsList.appendChild(div);
                });
            }
        } catch (err) {
            console.error('Search error:', err);
            loading.classList.add('hidden');
            noResults.classList.remove('hidden');
        }
    }
}
