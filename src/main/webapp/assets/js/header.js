/**
 * Header Logic for NeuralNews
 * Handles Notifications and AJAX Search
 */

var NOTIF_KEY = 'neural_news_read_notifs';

function getReadSet() { 
    try { 
        return JSON.parse(localStorage.getItem(NOTIF_KEY) || '[]'); 
    } catch(e) { 
        return []; 
    } 
}

function saveReadSet(arr) { 
    try { 
        localStorage.setItem(NOTIF_KEY, JSON.stringify(arr)); 
    } catch(e) {} 
}

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
    if (el.classList.contains('unread')) {
        el.classList.remove('unread');
        el.style.borderLeftColor = 'transparent';
        el.querySelector('.unread-dot')?.remove();
        
        var readIds = getReadSet();
        const nid = el.getAttribute('data-id');
        if (nid && readIds.indexOf(nid) === -1) {
            readIds.push(nid);
            saveReadSet(readIds);
        }
        updateBadge();
    }
}

function markAllRead() {
    document.querySelectorAll('.notif-item.unread').forEach(markRead);
}

// Initializer for Header
function initHeader(contextPath) {
    // 1. Notifications Logic
    var readIds = getReadSet();
    document.querySelectorAll('.notif-item[data-id]').forEach(function(el) {
        if (readIds.indexOf(el.getAttribute('data-id')) !== -1) {
            el.classList.remove('unread');
            el.style.borderLeftColor = 'transparent';
            el.querySelector('.unread-dot')?.remove();
        }
    });
    updateBadge();

    window.addEventListener('storage', function(e) {
        if (e.key === NOTIF_KEY) {
            var readIds = getReadSet();
            document.querySelectorAll('.notif-item[data-id]').forEach(function(el) {
                if (readIds.indexOf(el.getAttribute('data-id')) !== -1 && el.classList.contains('unread')) {
                    el.classList.remove('unread');
                    el.style.borderLeftColor = 'transparent';
                    el.querySelector('.unread-dot')?.remove();
                }
            });
            updateBadge();
        }
    });

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
