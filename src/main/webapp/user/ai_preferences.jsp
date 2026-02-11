<!DOCTYPE html>
<html class="dark" lang="en">

<head>
    <title>AI Preferences - NexusAI Dashboard</title>
    <jsp:include page="components/head.jsp" />
    <style>
        .scrollbar-hide::-webkit-scrollbar {
            display: none;
        }

        .scrollbar-hide {
            -ms-overflow-style: none;
            scrollbar-width: none;
        }
    </style>
</head>

<body
    class="bg-background-light dark:bg-background-dark text-text-main dark:text-white font-display antialiased overflow-x-hidden transition-colors duration-200">
    <div class="flex min-h-screen w-full flex-col">
        <jsp:include page="components/header.jsp" />

        <main class="flex-1 w-full max-w-[1440px] mx-auto p-4 lg:p-8 flex flex-col lg:flex-row gap-8">
            <jsp:include page="components/sidebar.jsp" />

            <div class="flex-1 flex flex-col gap-6">
                <div
                    class="bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-xl overflow-hidden shadow-sm">
                    <div class="flex border-b border-slate-200 dark:border-border-dark overflow-x-auto scrollbar-hide">
                        <button onclick="window.location.href='${pageContext.request.contextPath}/user/profile.jsp'"
                            class="px-6 py-4 text-sm font-bold text-slate-500 dark:text-slate-400 border-b-2 border-transparent hover:text-primary transition-colors whitespace-nowrap">
                            Overview
                        </button>
                        <button
                            onclick="window.location.href='${pageContext.request.contextPath}/user/saved_articles.jsp'"
                            class="px-6 py-4 text-sm font-bold text-slate-500 dark:text-slate-400 border-b-2 border-transparent hover:text-primary transition-colors whitespace-nowrap">
                            Saved Articles
                        </button>
                        <button
                            onclick="window.location.href='${pageContext.request.contextPath}/user/reading_history.jsp'"
                            class="px-6 py-4 text-sm font-bold text-slate-500 dark:text-slate-400 border-b-2 border-transparent hover:text-primary transition-colors whitespace-nowrap">
                            Reading History
                        </button>
                        <button
                            onclick="window.location.href='${pageContext.request.contextPath}/user/ai_preferences.jsp'"
                            class="px-6 py-4 text-sm font-bold text-primary border-b-2 border-primary whitespace-nowrap bg-primary/5">
                            AI Preferences
                        </button>
                    </div>
                    <div class="p-6 md:p-8">
                        <div class="max-w-3xl space-y-10">
                            <section>
                                <div class="mb-4">
                                    <h3
                                        class="text-lg font-bold text-slate-900 dark:text-white flex items-center gap-2">
                                        <span class="material-symbols-outlined text-primary">interests</span>
                                        Content Interests
                                    </h3>
                                    <p class="text-sm text-slate-500 dark:text-slate-400">Select the topics you want
                                        our AI to prioritize in your feed.</p>
                                </div>
                                <div class="flex flex-wrap gap-2">
                                    <button
                                        class="px-4 py-1.5 rounded-full border border-primary bg-primary/10 text-primary text-sm font-medium flex items-center gap-2">
                                        Technology <span class="material-symbols-outlined text-xs">close</span>
                                    </button>
                                    <button
                                        class="px-4 py-1.5 rounded-full border border-primary bg-primary/10 text-primary text-sm font-medium flex items-center gap-2">
                                        Science <span class="material-symbols-outlined text-xs">close</span>
                                    </button>
                                    <button
                                        class="px-4 py-1.5 rounded-full border border-slate-200 dark:border-slate-700 bg-transparent text-slate-600 dark:text-slate-400 text-sm font-medium hover:border-primary hover:text-primary transition-colors">
                                        Sports
                                    </button>
                                    <button
                                        class="px-4 py-1.5 rounded-full border border-primary bg-primary/10 text-primary text-sm font-medium flex items-center gap-2">
                                        Artificial Intelligence <span
                                            class="material-symbols-outlined text-xs">close</span>
                                    </button>
                                    <button
                                        class="px-4 py-1.5 rounded-full border border-slate-200 dark:border-slate-700 bg-transparent text-slate-600 dark:text-slate-400 text-sm font-medium hover:border-primary hover:text-primary transition-colors">
                                        Politics
                                    </button>
                                    <button
                                        class="px-4 py-1.5 rounded-full border border-slate-200 dark:border-slate-700 bg-transparent text-slate-600 dark:text-slate-400 text-sm font-medium hover:border-primary hover:text-primary transition-colors">
                                        Economics
                                    </button>
                                    <button
                                        class="px-4 py-1.5 rounded-full border border-primary bg-primary/10 text-primary text-sm font-medium flex items-center gap-2">
                                        Space <span class="material-symbols-outlined text-xs">close</span>
                                    </button>
                                    <button
                                        class="px-4 py-1.5 rounded-full border border-slate-200 dark:border-slate-700 bg-transparent text-slate-600 dark:text-slate-400 text-sm font-medium hover:border-primary hover:text-primary transition-colors">
                                        Health
                                    </button>
                                    <button
                                        class="px-4 py-1.5 rounded-full border border-dashed border-slate-300 dark:border-slate-600 text-slate-400 text-sm font-medium hover:text-primary hover:border-primary transition-all">
                                        + Add More
                                    </button>
                                </div>
                            </section>
                            <section>
                                <div class="mb-4">
                                    <h3
                                        class="text-lg font-bold text-slate-900 dark:text-white flex items-center gap-2">
                                        <span class="material-symbols-outlined text-primary">short_text</span>
                                        AI Summary Preference
                                    </h3>
                                    <p class="text-sm text-slate-500 dark:text-slate-400">Choose the depth of
                                        automated article summaries.</p>
                                </div>
                                <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                                    <label class="relative cursor-pointer">
                                        <input class="sr-only peer" name="summary_length" type="radio" value="short" />
                                        <div
                                            class="p-4 rounded-xl border-2 border-slate-100 dark:border-slate-800 bg-slate-50 dark:bg-slate-900/50 peer-checked:border-primary peer-checked:bg-primary/5 transition-all">
                                            <div class="flex justify-between items-center mb-1">
                                                <span class="font-bold text-slate-900 dark:text-white">Short</span>
                                                <span
                                                    class="material-symbols-outlined text-primary hidden peer-checked:block text-xl">check_circle</span>
                                            </div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Quick 2-3 bullet
                                                points for rapid scanning.</p>
                                        </div>
                                    </label>
                                    <label class="relative cursor-pointer">
                                        <input checked="" class="sr-only peer" name="summary_length" type="radio"
                                            value="medium" />
                                        <div
                                            class="p-4 rounded-xl border-2 border-slate-100 dark:border-slate-800 bg-slate-50 dark:bg-slate-900/50 peer-checked:border-primary peer-checked:bg-primary/5 transition-all">
                                            <div class="flex justify-between items-center mb-1">
                                                <span class="font-bold text-slate-900 dark:text-white">Medium</span>
                                                <span
                                                    class="material-symbols-outlined text-primary hidden peer-checked:block text-xl">check_circle</span>
                                            </div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Standard summary
                                                covering all key facts.</p>
                                        </div>
                                    </label>
                                    <label class="relative cursor-pointer">
                                        <input class="sr-only peer" name="summary_length" type="radio" value="long" />
                                        <div
                                            class="p-4 rounded-xl border-2 border-slate-100 dark:border-slate-800 bg-slate-50 dark:bg-slate-900/50 peer-checked:border-primary peer-checked:bg-primary/5 transition-all">
                                            <div class="flex justify-between items-center mb-1">
                                                <span class="font-bold text-slate-900 dark:text-white">Deep
                                                    Dive</span>
                                                <span
                                                    class="material-symbols-outlined text-primary hidden peer-checked:block text-xl">check_circle</span>
                                            </div>
                                            <p class="text-xs text-slate-500 dark:text-slate-400">Detailed breakdown
                                                including context and analysis.</p>
                                        </div>
                                    </label>
                                </div>
                            </section>
                            <section
                                class="p-6 bg-slate-50 dark:bg-slate-900/50 border border-slate-200 dark:border-slate-800 rounded-2xl flex items-center justify-between gap-6">
                                <div class="flex gap-4">
                                    <div
                                        class="size-12 bg-primary/10 text-primary rounded-xl flex items-center justify-center shrink-0">
                                        <span class="material-symbols-outlined">auto_graph</span>
                                    </div>
                                    <div>
                                        <h4 class="font-bold text-slate-900 dark:text-white">Personalized News Feed
                                        </h4>
                                        <p class="text-sm text-slate-500 dark:text-slate-400">Allow our AI to learn
                                            from your reading habits to curate a unique front page just for you.</p>
                                    </div>
                                </div>
                                <label class="relative inline-flex items-center cursor-pointer">
                                    <input checked="" class="sr-only peer" type="checkbox" />
                                    <div
                                        class="w-14 h-7 bg-slate-300 peer-focus:outline-none dark:bg-slate-700 peer-checked:after:translate-x-full rtl:peer-checked:after:-translate-x-full peer-checked:after:border-white after:content-[''] after:absolute after:top-0.5 after:start-[4px] after:bg-white after:border-gray-300 after:border after:rounded-full after:h-6 after:w-6 after:transition-all dark:border-gray-600 peer-checked:bg-primary">
                                    </div>
                                </label>
                            </section>
                            <div
                                class="flex items-center justify-end gap-4 pt-6 border-t border-slate-100 dark:border-slate-800">
                                <button
                                    class="px-6 py-2.5 text-sm font-bold text-slate-600 dark:text-slate-400 hover:text-slate-900 dark:hover:text-white transition-colors">
                                    Reset to Default
                                </button>
                                <button
                                    class="px-8 py-2.5 bg-primary text-white rounded-lg text-sm font-bold hover:bg-primary-dark shadow-lg shadow-primary/20 transition-all">
                                    Save Preferences
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div
                    class="bg-gradient-to-r from-slate-900 to-primary-dark border border-white/10 rounded-2xl p-8 relative overflow-hidden group">
                    <div
                        class="absolute top-0 right-0 p-12 opacity-10 pointer-events-none group-hover:scale-110 transition-transform duration-700">
                        <span class="material-symbols-outlined text-[160px]">edit_note</span>
                    </div>
                    <div class="relative z-10">
                        <div class="flex flex-col md:flex-row md:items-center justify-between gap-6">
                            <div class="max-w-xl">
                                <span
                                    class="inline-flex items-center gap-1.5 px-3 py-1 bg-amber-500/20 backdrop-blur-md text-amber-400 text-[10px] font-bold uppercase tracking-widest rounded-full mb-4 border border-amber-500/30">
                                    <span class="material-symbols-outlined text-[14px]">info</span>
                                    Application Under Review
                                </span>
                                <h2 class="text-3xl font-extrabold text-white mb-3">Become a Nexus Journalist</h2>
                                <p class="text-blue-100/80">Your profile is currently being reviewed. Once approved,
                                    you'll gain access to our AI-powered editorial suite to publish stories
                                    worldwide.</p>
                            </div>
                            <div class="shrink-0">
                                <div
                                    class="bg-white/10 backdrop-blur-md border border-white/20 p-4 rounded-xl text-center">
                                    <p class="text-xs text-blue-200 font-bold uppercase mb-1">Estimated Approval</p>
                                    <p class="text-xl font-black text-white">24 Hours</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
        <jsp:include page="components/footer.jsp" />
    </div>

</body>

</html>