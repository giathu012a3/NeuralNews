<!DOCTYPE html>
<html lang="en">

<head>
    <jsp:include page="components/head.jsp" />
    <title>AI Content Management System</title>
    <style>
        .ai-gauge {
            background: conic-gradient(#ef4444 0% 40%, #fbbf24 40% 60%, #22c55e 60% 100%);
            border-radius: 50% 50% 0 0;
            width: 100px;
            height: 50px;
        }
    </style>
</head>

<body class="bg-dashboard-bg dark:bg-background-dark">
    <div class="flex min-h-screen">
        <jsp:include page="components/sidebar.jsp">
            <jsp:param name="activePage" value="content" />
        </jsp:include>
        <main class="flex-1 ml-64 mr-80 bg-dashboard-bg dark:bg-background-dark/95 min-h-screen">
            <header
                class="sticky top-0 z-40 bg-dashboard-bg/80 dark:bg-background-dark/80 backdrop-blur-md px-8 py-4 flex items-center justify-between border-b border-slate-200 dark:border-slate-800">
                <div>
                    <p class="text-xs font-semibold text-slate-500 dark:text-slate-400 uppercase tracking-widest">
                        Management</p>
                    <h2 class="text-2xl font-bold text-slate-800 dark:text-white">Content Management</h2>
                </div>
                <div class="flex items-center gap-4">
                    <div class="relative flex items-center">
                        <span class="material-icons absolute left-3 text-slate-400 text-[18px]">search</span>
                        <input
                            class="pl-10 pr-4 py-2 bg-white dark:bg-slate-800 border-none rounded-lg text-sm focus:ring-2 focus:ring-primary w-64 shadow-sm"
                            placeholder="Search..." type="text" />
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/create_article.jsp"
                        class="bg-primary hover:bg-primary/90 text-white px-4 py-2 rounded-lg text-sm font-bold flex items-center gap-2 shadow-lg shadow-primary/20 transition-all">
                        <span class="material-icons text-sm">add</span> Create Article
                    </a>
                    <jsp:include page="components/header_profile.jsp" />
                </div>
            </header>
            <div class="p-8 space-y-6">
                <div
                    class="bg-white dark:bg-slate-800 p-4 rounded-xl shadow-sm border border-slate-100 dark:border-slate-700 flex flex-wrap items-center gap-4">
                    <div class="flex-1 min-w-[200px]">
                        <label class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Quick Search</label>
                        <input
                            class="w-full text-sm border-slate-200 dark:border-slate-600 dark:bg-slate-900 rounded-lg focus:ring-primary"
                            placeholder="Title, Author, or ID..." type="text" />
                    </div>
                    <div>
                        <label class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Category</label>
                        <select
                            class="text-sm border-slate-200 dark:border-slate-600 dark:bg-slate-900 rounded-lg focus:ring-primary">
                            <option>All Categories</option>
                            <option>Technology</option>
                            <option>Politics</option>
                            <option>Health</option>
                        </select>
                    </div>
                    <div>
                        <label class="text-[10px] font-bold text-slate-400 uppercase mb-1 block">Status</label>
                        <select
                            class="text-sm border-slate-200 dark:border-slate-600 dark:bg-slate-900 rounded-lg focus:ring-primary">
                            <option>All Status</option>
                            <option>Published</option>
                            <option>Pending</option>
                            <option>Draft</option>
                            <option>Removed</option>
                        </select>
                    </div>
                    <div class="flex items-end h-full pt-4">
                        <button
                            class="bg-slate-100 dark:bg-slate-700 text-slate-600 dark:text-slate-300 px-4 py-2 rounded-lg text-sm font-medium hover:bg-slate-200 transition-colors">
                            Clear Filters
                        </button>
                    </div>
                </div>
                <div class="flex items-center justify-between">
                    <div class="flex items-center gap-3">
                        <input class="rounded border-slate-300 text-primary focus:ring-primary" type="checkbox" />
                        <span class="text-sm font-medium text-slate-600 dark:text-slate-400">Select All</span>
                        <button
                            class="ml-4 px-3 py-1.5 bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400 rounded-md text-xs font-bold hover:bg-green-200 transition-colors">
                            Bulk Approve
                        </button>
                    </div>
                    <div class="text-sm text-slate-500">
                        Showing 1-15 of 2,410 articles
                    </div>
                </div>
                <div
                    class="bg-white dark:bg-slate-800 rounded-xl shadow-sm border border-slate-100 dark:border-slate-700 overflow-hidden">
                    <table class="w-full text-left table-auto">
                        <thead>
                            <tr
                                class="bg-slate-50 dark:bg-slate-900/50 border-b border-slate-100 dark:border-slate-700">
                                <th class="px-6 py-4 w-12"></th>
                                <th class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider">
                                    Article</th>
                                <th class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider">
                                    Author</th>
                                <th
                                    class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider text-center">
                                    Status</th>
                                <th
                                    class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider text-center">
                                    Stats</th>
                                <th class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider">
                                    AI Quality</th>
                                <th
                                    class="px-6 py-4 text-[11px] font-bold text-slate-400 uppercase tracking-wider text-right">
                                    Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-100 dark:divide-slate-700">
                            <tr
                                class="hover:bg-slate-50 dark:hover:bg-slate-700/20 transition-colors cursor-pointer group">
                                <td class="px-6 py-4">
                                    <input class="rounded border-slate-300 text-primary focus:ring-primary"
                                        type="checkbox" />
                                </td>
                                <td class="px-6 py-4">
                                    <div class="flex items-center gap-4">
                                        <img alt="Article Thumbnail" class="w-12 h-12 rounded object-cover"
                                            src="https://lh3.googleusercontent.com/aida-public/AB6AXuDz40Aqs-DHc1lfKyG1WT2IFy37f_KeRTBmCYRD7ZjXZ5loCHXasbE4NeApvI0q9udIUU9LY1JGhssn43JyOogfQVn-n3cBk_MDFEFz4eRstdokw81zmiDQKvFw5oyLEV4bM5R_t72C9yeMGj0X66Wf415cZePYKVqETdyJVbAIjQGLb2D04WlAawHlmBfAdUbKn8f2ay_VkV1LByZ44IGBP9k4sW0WZRdnIENKSmuUz6oUKLTGa4qxIUfWkOJnoE8264THxrVmVgdo" />
                                        <div>
                                            <h4
                                                class="text-sm font-semibold text-slate-800 dark:text-white group-hover:text-primary transition-colors">
                                                The Future of AI in Modern Newsrooms</h4>
                                            <p class="text-[11px] text-slate-500 mt-0.5">Category: Technology • 2h ago
                                            </p>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4">
                                    <a class="text-sm text-primary hover:underline font-medium" href="#">Elena
                                        Rodriguez</a>
                                </td>
                                <td class="px-6 py-4 text-center">
                                    <span
                                        class="px-2.5 py-1 text-[10px] font-bold rounded-full bg-green-100 text-green-700 dark:bg-green-900/30 dark:text-green-400">PUBLISHED</span>
                                </td>
                                <td class="px-6 py-4">
                                    <div class="flex items-center justify-center gap-4 text-slate-400">
                                        <span class="flex items-center gap-1 text-[11px]"><span
                                                class="material-icons text-sm">visibility</span> 1.2k</span>
                                    </div>
                                </td>
                                <td class="px-6 py-4">
                                    <div class="flex items-center gap-2">
                                        <div class="w-1.5 h-1.5 rounded-full bg-green-500"></div>
                                        <span class="text-sm font-bold text-slate-800 dark:text-white">88%</span>
                                    </div>
                                </td>
                                <td class="px-6 py-4 text-right">
                                    <div class="flex justify-end gap-1">
                                        <button
                                            class="p-2 text-slate-400 hover:text-primary hover:bg-primary/10 rounded-lg transition-all"
                                            title="View"><span
                                                class="material-symbols-outlined text-[20px]">visibility</span></button>
                                        <button
                                            class="p-2 text-slate-400 hover:text-primary hover:bg-primary/10 rounded-lg transition-all"
                                            title="Edit"><span
                                                class="material-symbols-outlined text-[20px]">edit</span></button>
                                        <button
                                            class="p-2 text-slate-400 hover:text-red-500 hover:bg-red-50 rounded-lg transition-all"
                                            title="Remove"><span
                                                class="material-symbols-outlined text-[20px]">delete</span></button>
                                    </div>
                                </td>
                            </tr>
                            <!-- Pending Article Row -->
                            <tr
                                class="hover:bg-slate-50 dark:hover:bg-slate-700/20 transition-colors cursor-pointer group bg-amber-50/30 dark:bg-amber-900/10">
                                <td class="px-6 py-4">
                                    <input class="rounded border-slate-300 text-primary focus:ring-primary"
                                        type="checkbox" />
                                </td>
                                <td class="px-6 py-4">
                                    <div class="flex items-center gap-4">
                                        <img alt="Article Thumbnail" class="w-12 h-12 rounded object-cover"
                                            src="https://lh3.googleusercontent.com/aida-public/AB6AXuDZyQLnwBRhjASQWdLdlIa3KqvMYaVCg6tJ68Kw_l3GhOwHd9ahyeLSXXbw-gYdoDCG1c4IFFxcxvPK-Ty6vHdXdFNF-8ZnwuxKmdPg-_g3oshQ-9y9VswYUmIEjD1_r5mM8dXKyS8-XIDBmd4XYs2alvpvQVoB3ymp2m7lvS6UoXO9eC5J6nWvPNRwRRpDFwFjiYgiRacNWKHRc8x0d_TTHsBz5-FzA4T1IE0LCbZsUJaLIFSRVo9q2xn17n3H6Tz0d1YKRlhtp2cH" />
                                        <div>
                                            <h4
                                                class="text-sm font-semibold text-slate-800 dark:text-white group-hover:text-primary transition-colors">
                                                Climate Accord: New Global Policy Signed</h4>
                                            <p class="text-[11px] text-slate-500 mt-0.5">Category: World • 45m ago
                                            </p>
                                        </div>
                                    </div>
                                </td>
                                <td class="px-6 py-4">
                                    <a class="text-sm text-primary hover:underline font-medium" href="#">Marcus
                                        Thorne</a>
                                </td>
                                <td class="px-6 py-4 text-center">
                                    <span
                                        class="px-2.5 py-1 text-[10px] font-bold rounded-full bg-amber-100 text-amber-700 dark:bg-amber-900/30 dark:text-amber-400">PENDING</span>
                                </td>
                                <td class="px-6 py-4">
                                    <div class="flex items-center justify-center gap-4 text-slate-400">
                                        <span class="flex items-center gap-1 text-[11px]"><span
                                                class="material-icons text-sm">visibility</span> 0</span>
                                    </div>
                                </td>
                                <td class="px-6 py-4">
                                    <div class="flex items-center gap-2">
                                        <div class="w-1.5 h-1.5 rounded-full bg-green-500"></div>
                                        <span class="text-sm font-bold text-slate-800 dark:text-white">92%</span>
                                    </div>
                                </td>
                                <td class="px-6 py-4 text-right">
                                    <div class="flex justify-end gap-1">
                                        <button
                                            class="p-2 text-slate-400 hover:text-primary hover:bg-primary/10 rounded-lg transition-all"
                                            title="View Details"
                                            onclick="openReviewModal('Climate Accord: New Global Policy Signed')">
                                            <span class="material-symbols-outlined text-[20px]">visibility</span>
                                        </button>
                                        <button
                                            class="p-2 text-green-500 hover:bg-green-50 dark:hover:bg-green-900/20 rounded-lg transition-all"
                                            title="Quick Approve" onclick="confirm('Quick Approve this article?')"><span
                                                class="material-symbols-outlined text-[20px]">check_circle</span></button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
        <aside
            class="w-80 bg-white dark:bg-slate-800 border-l border-slate-200 dark:border-slate-700 fixed right-0 h-full overflow-y-auto z-40">
            <div class="p-6 border-b border-slate-100 dark:border-slate-700">
                <h3 class="flex items-center gap-2 font-bold text-slate-800 dark:text-white">
                    <span class="material-icons text-primary text-[20px]">auto_awesome</span>
                    AI Content Analysis
                </h3>
            </div>
            <div class="p-6 space-y-8">
                <div>
                    <p class="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-4">Sentiment Analysis
                    </p>
                    <div class="flex flex-col items-center">
                        <div class="relative">
                            <div class="ai-gauge"></div>
                            <div
                                class="absolute bottom-0 left-1/2 -translate-x-1/2 w-4 h-4 bg-slate-800 dark:bg-white rounded-full border-2 border-white dark:border-slate-800">
                            </div>
                            <div
                                class="absolute bottom-1 left-1/2 -translate-x-1/2 w-1 h-12 bg-slate-800 dark:bg-white origin-bottom rotate-[45deg] rounded-full">
                            </div>
                        </div>
                        <div class="flex justify-between w-full mt-2 px-6">
                            <span class="text-[10px] font-medium text-red-500">Negative</span>
                            <span class="text-[10px] font-medium text-green-500">Positive</span>
                        </div>
                        <p class="mt-4 text-lg font-bold text-slate-800 dark:text-white">72% Positive</p>
                        <p class="text-xs text-slate-500 text-center px-4">The article maintains an optimistic tone
                            towards technological advancement.</p>
                    </div>
                </div>

                <div>
                    <div class="flex justify-between items-center mb-2">
                        <p class="text-[10px] font-bold text-slate-400 uppercase tracking-widest">Originality Score</p>
                        <span class="text-xs font-bold text-green-600">94% Unique</span>
                    </div>
                    <div class="w-full h-2.5 bg-slate-100 dark:bg-slate-700 rounded-full overflow-hidden">
                        <div class="bg-green-500 h-full w-[94%]"></div>
                    </div>
                    <div class="mt-2 flex items-center gap-2">
                        <span class="material-icons text-amber-500 text-xs">warning</span>
                        <p class="text-[10px] text-slate-500">6% Match found in 2 archived sources.</p>
                    </div>
                </div>

                <div>
                    <p class="text-[10px] font-bold text-slate-400 uppercase tracking-widest mb-3">AI Suggested Tags</p>
                    <div class="flex flex-wrap gap-2">
                        <span
                            class="px-2 py-1 bg-primary/10 text-primary rounded-md text-[11px] font-semibold flex items-center gap-1 border border-primary/20 cursor-pointer">
                            #ArtificialIntelligence <span class="material-icons text-[12px]">add</span>
                        </span>
                        <span
                            class="px-2 py-1 bg-primary/10 text-primary rounded-md text-[11px] font-semibold flex items-center gap-1 border border-primary/20 cursor-pointer">
                            #Journalism <span class="material-icons text-[12px]">add</span>
                        </span>
                        <span
                            class="px-2 py-1 bg-primary/10 text-primary rounded-md text-[11px] font-semibold flex items-center gap-1 border border-primary/20 cursor-pointer">
                            #Automation <span class="material-icons text-[12px]">add</span>
                        </span>
                        <span
                            class="px-2 py-1 bg-slate-100 dark:bg-slate-700 text-slate-500 rounded-md text-[11px] font-semibold flex items-center gap-1 border border-slate-200 dark:border-slate-600 cursor-pointer">
                            #FutureTech <span class="material-icons text-[12px]">add</span>
                        </span>
                    </div>
                </div>

                <div class="pt-6 border-t border-slate-100 dark:border-slate-700">
                    <div class="relative group">
                        <button
                            class="w-full bg-slate-800 dark:bg-slate-100 text-white dark:text-slate-800 py-3 rounded-xl font-bold text-sm flex items-center justify-center gap-2 shadow-lg transition-all hover:bg-slate-700">
                            <span class="material-icons text-[18px]">home</span>
                            Push to Home
                            <span class="material-icons text-[18px]">expand_more</span>
                        </button>
                        <div
                            class="absolute bottom-full left-0 w-full mb-2 bg-white dark:bg-slate-900 border border-slate-200 dark:border-slate-700 rounded-xl shadow-2xl opacity-0 group-hover:opacity-100 invisible group-hover:visible transition-all p-2 z-50">
                            <p
                                class="text-[10px] font-bold text-slate-400 uppercase p-2 border-b border-slate-100 dark:border-slate-700 mb-1">
                                Select Position</p>
                            <button
                                class="w-full text-left px-3 py-2 text-xs font-medium text-slate-700 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-slate-800 rounded-lg">Top
                                Featured (Hero)</button>
                            <button
                                class="w-full text-left px-3 py-2 text-xs font-medium text-slate-700 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-slate-800 rounded-lg">Sidebar
                                Trending</button>
                            <button
                                class="w-full text-left px-3 py-2 text-xs font-medium text-slate-700 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-slate-800 rounded-lg">Category
                                Top Spot</button>
                            <button
                                class="w-full text-left px-3 py-2 text-xs font-medium text-slate-700 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-slate-800 rounded-lg">Recommended
                                Feed</button>
                        </div>
                    </div>
                </div>
            </div>
        </aside>
    </div>

    <!-- Review Modal (Integrated from Content Approval) -->
    <div id="reviewModal"
        class="fixed inset-0 z-[60] bg-slate-900/60 backdrop-blur-sm flex items-center justify-center p-8 hidden">
        <div
            class="bg-white dark:bg-slate-900 w-[90%] h-full max-h-[90vh] rounded-2xl shadow-2xl flex flex-col overflow-hidden animate-in fade-in zoom-in duration-300 relative">

            <!-- Header -->
            <div
                class="px-8 py-4 border-b border-slate-100 dark:border-slate-700 flex items-center justify-between bg-white dark:bg-slate-900 sticky top-0 z-10">
                <div class="flex items-center gap-4">
                    <button onclick="closeReviewModal()"
                        class="p-2 hover:bg-slate-100 dark:hover:bg-slate-800 rounded-full transition-colors text-slate-500">
                        <span class="material-icons">close</span>
                    </button>
                    <div>
                        <h3 class="font-bold text-slate-800 dark:text-white" id="modalArticleTitle">Reviewing:
                            Neural Networks...</h3>
                        <p class="text-xs text-slate-500">By Marcus Thorne • Submitted 45m ago</p>
                    </div>
                </div>
            </div>

            <div class="flex flex-1 overflow-hidden">
                <!-- Left: Content Editor -->
                <div
                    class="flex-1 overflow-y-auto p-12 border-r border-slate-100 dark:border-slate-700 custom-scrollbar bg-white dark:bg-slate-900">
                    <div class="max-w-3xl mx-auto space-y-8">
                        <div class="space-y-2">
                            <label class="text-[10px] font-bold text-slate-400 uppercase tracking-widest">Main
                                Title</label>
                            <input
                                class="w-full text-3xl font-bold text-slate-900 dark:text-white bg-transparent border-none p-0 focus:ring-0 placeholder:text-slate-300"
                                type="text" value="Climate Accord: New Global Policy Signed" />
                        </div>
                        <div class="space-y-4">
                            <label class="text-[10px] font-bold text-slate-400 uppercase tracking-widest block">Article
                                Content</label>
                            <div class="prose prose-slate dark:prose-invert max-w-none">
                                <textarea
                                    class="w-full text-slate-600 dark:text-slate-300 leading-relaxed bg-transparent border-none p-0 focus:ring-0 resize-none h-[500px]"
                                    rows="20">In a historic turn of events, representatives from over 190 nations gathered in Geneva today to sign the most comprehensive climate policy accord in decades. The agreement, dubbed the "Geneva Protocol for Sustainable Future," aims to reduce global carbon emissions by 45% by 2030.

The summit was marked by intense negotiations, particularly between developing nations and industrial powerhouses. However, a last-minute breakthrough regarding technology transfer mechanisms paved the way for unanimous approval.

"This is not just a document; it's a lifeline for our planet," stated the UN Secretary-General during the closing ceremony. The accord includes binding targets for renewable energy adoption and strict penalties for non-compliance.</textarea>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Right: AI Report -->
                <div class="w-80 bg-slate-50 dark:bg-slate-800 overflow-y-auto p-6 space-y-8 custom-scrollbar">
                    <div>
                        <h4
                            class="flex items-center gap-2 text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-widest mb-4">
                            <span class="material-icons text-primary text-lg">auto_awesome</span>
                            AI Intelligence Report
                        </h4>

                        <!-- Plagiarism -->
                        <div class="mb-6">
                            <div class="flex justify-between items-center mb-1">
                                <span class="text-xs font-semibold text-slate-600 dark:text-slate-300">Plagiarism
                                    Check</span>
                                <span class="text-xs font-bold text-green-600 dark:text-green-400">0%
                                    Match</span>
                            </div>
                            <div class="w-full h-1.5 bg-slate-200 dark:bg-slate-700 rounded-full overflow-hidden">
                                <div class="bg-green-500 h-full w-[100%]"></div>
                            </div>
                        </div>

                        <!-- Sentiment -->
                        <div class="mb-6">
                            <span class="text-xs font-semibold text-slate-600 dark:text-slate-300 block mb-3">Sentiment
                                Analysis</span>
                            <div class="flex items-center gap-2">
                                <div
                                    class="flex-1 h-2 bg-gradient-to-r from-red-400 via-slate-300 to-green-400 rounded-full relative">
                                    <div
                                        class="absolute top-1/2 -translate-y-1/2 left-[60%] w-3 h-3 bg-white border-2 border-slate-800 rounded-full shadow-sm">
                                    </div>
                                </div>
                                <span class="text-[10px] font-bold text-slate-700 dark:text-slate-300">60%
                                    NEUTRAL</span>
                            </div>
                        </div>

                        <!-- Quality Score Card -->
                        <div
                            class="p-4 bg-white dark:bg-slate-700/50 rounded-xl border border-slate-200 dark:border-slate-600 shadow-sm">
                            <div class="flex items-center justify-between mb-2">
                                <span class="text-xs font-bold text-slate-400 uppercase">Quality Score</span>
                                <span class="text-lg font-bold text-primary">92/100</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Footer Actions -->
            <div
                class="p-6 border-t border-slate-100 dark:border-slate-700 bg-white dark:bg-slate-900 flex items-center justify-between gap-4">
                <div class="flex-1 flex gap-3">
                    <button onclick="closeReviewModal(); alert('Published!')"
                        class="flex-1 bg-green-500 hover:bg-green-600 text-white font-bold py-4 rounded-xl shadow-lg shadow-green-200 dark:shadow-none transition-all flex items-center justify-center gap-2">
                        <span class="material-icons">publish</span> Approve & Publish
                    </button>
                    <button onclick="toggleRevisionForm()"
                        class="flex-1 bg-amber-400 hover:bg-amber-500 text-white font-bold py-4 rounded-xl transition-all flex items-center justify-center gap-2">
                        <span class="material-icons">draw</span> Request Revision
                    </button>
                </div>
                <button
                    class="bg-red-50 dark:bg-red-900/20 text-red-500 hover:bg-red-500 hover:text-white font-bold px-8 py-4 rounded-xl transition-all flex items-center gap-2">
                    <span class="material-icons">delete_forever</span> Reject
                </button>
            </div>

            <!-- Revision Form Overlay -->
            <div id="revisionForm"
                class="absolute inset-0 z-[70] bg-slate-900/40 flex items-center justify-center p-6 hidden">
                <div
                    class="bg-white dark:bg-slate-800 w-full max-w-xl rounded-2xl shadow-2xl flex flex-col overflow-hidden animate-in fade-in zoom-in duration-200">
                    <div
                        class="px-6 py-4 border-b border-slate-100 dark:border-slate-700 flex items-center justify-between">
                        <h4 class="font-bold text-slate-800 dark:text-white">Request Revision</h4>
                        <button onclick="toggleRevisionForm()"
                            class="text-slate-400 hover:text-slate-600 dark:hover:text-slate-200">
                            <span class="material-icons">close</span>
                        </button>
                    </div>
                    <div class="p-6 space-y-6">
                        <div class="space-y-2">
                            <label
                                class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Input
                                Feedback for Journalist</label>
                            <textarea
                                class="w-full border-slate-200 dark:border-slate-600 dark:bg-slate-900 dark:text-white rounded-xl text-sm focus:ring-amber-400 focus:border-amber-400 min-h-[120px]"
                                placeholder="Type your detailed feedback here..."></textarea>
                        </div>
                        <div class="space-y-3">
                            <label
                                class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">AI
                                Suggested Quick Notes</label>
                            <div class="flex flex-wrap gap-2">
                                <button
                                    class="px-3 py-1.5 bg-slate-100 dark:bg-slate-700 hover:bg-slate-200 dark:hover:bg-slate-600 text-slate-700 dark:text-slate-200 text-xs font-medium rounded-full transition-colors flex items-center gap-1.5">
                                    <span class="material-icons text-sm">auto_awesome</span> Fix headline tone
                                </button>
                                <button
                                    class="px-3 py-1.5 bg-slate-100 dark:bg-slate-700 hover:bg-slate-200 dark:hover:bg-slate-600 text-slate-700 dark:text-slate-200 text-xs font-medium rounded-full transition-colors flex items-center gap-1.5">
                                    <span class="material-icons text-sm">auto_awesome</span> Verify statistics
                                </button>
                                <button
                                    class="px-3 py-1.5 bg-slate-100 dark:bg-slate-700 hover:bg-slate-200 dark:hover:bg-slate-600 text-slate-700 dark:text-slate-200 text-xs font-medium rounded-full transition-colors flex items-center gap-1.5">
                                    <span class="material-icons text-sm">auto_awesome</span> Add more quotes
                                </button>
                            </div>
                        </div>
                        <div class="flex items-center gap-3 py-2">
                            <input class="w-4 h-4 text-amber-400 border-slate-300 rounded focus:ring-amber-400"
                                id="notifyEmail" type="checkbox" />
                            <label class="text-sm font-medium text-slate-600 dark:text-slate-300 cursor-pointer"
                                for="notifyEmail">Notify journalist via email</label>
                        </div>
                    </div>
                    <div class="px-6 py-4 bg-slate-50 dark:bg-slate-900 flex items-center justify-end gap-3">
                        <button onclick="toggleRevisionForm()"
                            class="px-5 py-2.5 text-sm font-bold text-slate-500 hover:text-slate-700 dark:text-slate-400 dark:hover:text-slate-200 transition-colors">Cancel</button>
                        <button onclick="toggleRevisionForm(); alert('Revision request sent!')"
                            class="px-6 py-2.5 bg-amber-400 hover:bg-amber-500 text-white text-sm font-bold rounded-lg shadow-lg shadow-amber-200/50 transition-all flex items-center gap-2">
                            <span class="material-icons text-lg">send</span> Send Revision Request
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function openReviewModal(title) {
            document.getElementById('modalArticleTitle').textContent = 'Reviewing: ' + title;
            document.getElementById('reviewModal').classList.remove('hidden');
        }

        function closeReviewModal() {
            document.getElementById('reviewModal').classList.add('hidden');
            document.getElementById('revisionForm').classList.add('hidden');
        }

        function toggleRevisionForm() {
            const form = document.getElementById('revisionForm');
            form.classList.toggle('hidden');
        }
    </script>

</body>

</html>