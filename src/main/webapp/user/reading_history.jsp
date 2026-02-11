<!DOCTYPE html>
<html class="dark" lang="en">

<head>
    <title>Reading History - NexusAI Dashboard</title>
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
                    class="bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-xl overflow-hidden">
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
                            class="px-6 py-4 text-sm font-bold text-primary border-b-2 border-primary whitespace-nowrap bg-primary/5">
                            Reading History
                        </button>
                        <button
                            onclick="window.location.href='${pageContext.request.contextPath}/user/ai_preferences.jsp'"
                            class="px-6 py-4 text-sm font-bold text-slate-500 dark:text-slate-400 border-b-2 border-transparent hover:text-primary transition-colors whitespace-nowrap">
                            AI Preferences
                        </button>
                    </div>
                    <div class="p-6 md:p-8 space-y-8">
                        <div class="flex flex-col md:flex-row md:items-center justify-between gap-4">
                            <div>
                                <h2 class="text-xl font-bold text-slate-900 dark:text-white">Reading History</h2>
                                <p class="text-sm text-slate-500 dark:text-slate-400">Keep track of your
                                    intellectual journey across NexusAI.</p>
                            </div>
                            <div class="flex items-center gap-2">
                                <button
                                    class="flex items-center gap-2 px-4 py-2 text-sm font-semibold border border-slate-200 dark:border-slate-700 rounded-lg hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors">
                                    <span class="material-symbols-outlined text-sm">download</span>
                                    Export
                                </button>
                                <button
                                    class="flex items-center gap-2 px-4 py-2 text-sm font-semibold border border-red-200 dark:border-red-900/30 text-red-500 rounded-lg hover:bg-red-50 dark:hover:bg-red-500/5 transition-colors">
                                    <span class="material-symbols-outlined text-sm">delete</span>
                                    Clear History
                                </button>
                            </div>
                        </div>
                        <div class="space-y-10">
                            <section>
                                <h3
                                    class="flex items-center gap-2 text-xs font-black uppercase tracking-[0.2em] text-slate-400 dark:text-slate-500 mb-4 px-1">
                                    <span class="size-1.5 bg-primary rounded-full"></span>
                                    Today
                                </h3>
                                <div class="space-y-1">
                                    <div
                                        class="group flex flex-col md:flex-row md:items-center gap-4 p-4 hover:bg-slate-50 dark:hover:bg-slate-800/50 rounded-xl transition-all border border-transparent hover:border-slate-100 dark:hover:border-slate-700">
                                        <div class="size-16 rounded-lg bg-slate-200 shrink-0 overflow-hidden">
                                            <div class="size-full bg-cover bg-center"
                                                style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCbyFNKCj0Ekc3B-IsR8SnAevW__ytlPRSaOMRdicoI76v5KHPjBTK5Tu-XX5AeaTc8P4pw3FS1wySMFfLNlxRfj_ppcXqLWzzQOvc-Nh0cD1IsXwkOGgoP-tqpjlO-P-H8l6wHPLgFKozre89umMvRQpVA2d03xFCQheN-xYhUzPeO_Qiisl_f2jEr0rSXleBdSa7i5cxiwFgvcsqBn1-6Qqb6Vbjk8XAQ1ARVVgZ1zg9uXlRcxx-cqc-xjEiQGj22e4S_w32S1E6c');">
                                            </div>
                                        </div>
                                        <div class="flex-1 min-w-0">
                                            <div class="flex items-center gap-2 mb-1">
                                                <span
                                                    class="px-2 py-0.5 bg-blue-500/10 text-blue-500 text-[10px] font-bold uppercase rounded">Tech</span>
                                                <span class="text-xs text-slate-400">• 10:24 AM</span>
                                            </div>
                                            <h4 class="text-base font-bold text-slate-900 dark:text-white truncate">
                                                The Singularity Paradox: AI's Final Frontier in 2024</h4>
                                            <div class="flex items-center gap-4 mt-1 text-xs text-slate-500">
                                                <span class="flex items-center gap-1"><span
                                                        class="material-symbols-outlined text-sm">schedule</span> 8
                                                    min read</span>
                                                <span class="flex items-center gap-1"><span
                                                        class="material-symbols-outlined text-sm">trending_up</span>
                                                    92% completion</span>
                                            </div>
                                        </div>
                                        <div class="flex items-center gap-2 self-end md:self-center">
                                            <button class="p-2 text-slate-400 hover:text-primary transition-colors">
                                                <span class="material-symbols-outlined">bookmark</span>
                                            </button>
                                            <button
                                                class="px-4 py-1.5 bg-primary text-white text-xs font-bold rounded-full hover:bg-primary-dark transition-colors shadow-lg shadow-primary/20">
                                                Re-read
                                            </button>
                                        </div>
                                    </div>
                                    <div
                                        class="group flex flex-col md:flex-row md:items-center gap-4 p-4 hover:bg-slate-50 dark:hover:bg-slate-800/50 rounded-xl transition-all border border-transparent hover:border-slate-100 dark:hover:border-slate-700">
                                        <div class="size-16 rounded-lg bg-slate-200 shrink-0 overflow-hidden">
                                            <div class="size-full bg-cover bg-center"
                                                style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuB2Xx93B7WTzU8F580MD34Z501gLdnj6HjmHqJmxAVZDsj2pStRtQ3vGWCvroXf7B-7KqiURuX3BLYUAOzSfl1APdgGgGtt3iE90TyxtbQtyCsmrCQro7goNetovjUXgQaDz2oilGljgiDIx_Xbbh_kXIop7mH1-KPtCdcO3z-8LJFVq-YEq2T3qY20QTuVq2-yJba44LvU8gAhSImdTwV46zzPtxCqV_PFM3uYQtox2gXD8jU8C_lGb_9VpnlpNTCIs9j9Qto6Cg8f');">
                                            </div>
                                        </div>
                                        <div class="flex-1 min-w-0">
                                            <div class="flex items-center gap-2 mb-1">
                                                <span
                                                    class="px-2 py-0.5 bg-purple-500/10 text-purple-500 text-[10px] font-bold uppercase rounded">Science</span>
                                                <span class="text-xs text-slate-400">• 08:15 AM</span>
                                            </div>
                                            <h4 class="text-base font-bold text-slate-900 dark:text-white truncate">
                                                Quantum Supremacy Achieved: What it Means for Encryption</h4>
                                            <div class="flex items-center gap-4 mt-1 text-xs text-slate-500">
                                                <span class="flex items-center gap-1"><span
                                                        class="material-symbols-outlined text-sm">schedule</span> 12
                                                    min read</span>
                                                <span class="flex items-center gap-1"><span
                                                        class="material-symbols-outlined text-sm">trending_up</span>
                                                    100% completion</span>
                                            </div>
                                        </div>
                                        <div class="flex items-center gap-2 self-end md:self-center">
                                            <button class="p-2 text-slate-400 hover:text-primary transition-colors">
                                                <span class="material-symbols-outlined">bookmark</span>
                                            </button>
                                            <button
                                                class="px-4 py-1.5 bg-primary text-white text-xs font-bold rounded-full hover:bg-primary-dark transition-colors shadow-lg shadow-primary/20">
                                                Re-read
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </section>
                            <section>
                                <h3
                                    class="flex items-center gap-2 text-xs font-black uppercase tracking-[0.2em] text-slate-400 dark:text-slate-500 mb-4 px-1">
                                    <span class="size-1.5 bg-slate-400 rounded-full"></span>
                                    Yesterday
                                </h3>
                                <div class="space-y-1">
                                    <div
                                        class="group flex flex-col md:flex-row md:items-center gap-4 p-4 hover:bg-slate-50 dark:hover:bg-slate-800/50 rounded-xl transition-all border border-transparent hover:border-slate-100 dark:hover:border-slate-700 opacity-80 hover:opacity-100">
                                        <div class="size-16 rounded-lg bg-slate-200 shrink-0 overflow-hidden">
                                            <div class="size-full bg-cover bg-center"
                                                style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDwI9fKd5hpoQk4NKiXMGhQ9NmWhFF6HCr5GQB4Zw0Rb0GREEG1vzgwU9zfv6MzqaS8VN7AwhOn86CPLOPCLJVU0l0Qk7EMxwQp63w3-4FIYHUccPu8iXymmi69MfFJk-HIt0zL66GMVlZX1v6fPNJQsuPeVuZzwI47gC1DgX4tZsv8CRjumhF3MMTHlS01yN9hcaM5ETD8cl78QecbCdrKtZCDCBeqnV8_YJD1TAo0JV-YKmwQNitrM4Ey0ruG2ZPIkT2Bx8sIQyVV');">
                                            </div>
                                        </div>
                                        <div class="flex-1 min-w-0">
                                            <div class="flex items-center gap-2 mb-1">
                                                <span
                                                    class="px-2 py-0.5 bg-green-500/10 text-green-500 text-[10px] font-bold uppercase rounded">Finance</span>
                                                <span class="text-xs text-slate-400">• 06:42 PM</span>
                                            </div>
                                            <h4 class="text-base font-bold text-slate-900 dark:text-white truncate">
                                                Global Markets React to Autonomous Trade Regulation</h4>
                                            <div class="flex items-center gap-4 mt-1 text-xs text-slate-500">
                                                <span class="flex items-center gap-1"><span
                                                        class="material-symbols-outlined text-sm">schedule</span> 5
                                                    min read</span>
                                                <span class="flex items-center gap-1"><span
                                                        class="material-symbols-outlined text-sm">trending_up</span>
                                                    100% completion</span>
                                            </div>
                                        </div>
                                        <div class="flex items-center gap-2 self-end md:self-center">
                                            <button class="p-2 text-slate-400 hover:text-primary transition-colors">
                                                <span class="material-symbols-outlined">bookmark</span>
                                            </button>
                                            <button
                                                class="px-4 py-1.5 bg-primary text-white text-xs font-bold rounded-full hover:bg-primary-dark transition-colors shadow-lg shadow-primary/20">
                                                Re-read
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </section>
                            <section>
                                <h3
                                    class="flex items-center gap-2 text-xs font-black uppercase tracking-[0.2em] text-slate-400 dark:text-slate-500 mb-4 px-1">
                                    <span class="size-1.5 bg-slate-400 rounded-full"></span>
                                    Last Week
                                </h3>
                                <div class="space-y-1">
                                    <div
                                        class="group flex flex-col md:flex-row md:items-center gap-4 p-4 hover:bg-slate-50 dark:hover:bg-slate-800/50 rounded-xl transition-all border border-transparent hover:border-slate-100 dark:hover:border-slate-700 opacity-60 hover:opacity-100">
                                        <div class="size-16 rounded-lg bg-slate-200 shrink-0 overflow-hidden">
                                            <div class="size-full bg-cover bg-center"
                                                style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDSForuVYROGxQIAWlyeeOtjV-k21pojvYLGl_ANJ6Ojys0VVYLvLNV0yyFEJECg1HpOYH0QfFEOxLzJlWdVcggQcF6DNTszGrD0udQ6UUwrEWxUiK4bb758XjRT-Jr7oiqojcg5OPczN1kDD3dqHZyJZvPsnmquG5m1tqnQF81WtCfZHcqTVOgRjoIkHH2u3PjTipzCkKPyhFu0fRTgF9Po6T2xghgc80cZaUeUC2gHJYtc7-V2a3EtZT0xfVSNOJTzysDMiutm8a1');">
                                            </div>
                                        </div>
                                        <div class="flex-1 min-w-0">
                                            <div class="flex items-center gap-2 mb-1">
                                                <span
                                                    class="px-2 py-0.5 bg-orange-500/10 text-orange-500 text-[10px] font-bold uppercase rounded">Environment</span>
                                                <span class="text-xs text-slate-400">• Oct 20</span>
                                            </div>
                                            <h4 class="text-base font-bold text-slate-900 dark:text-white truncate">
                                                Sustainable Cities: The AI Blueprint for Carbon Neutrality</h4>
                                            <div class="flex items-center gap-4 mt-1 text-xs text-slate-500">
                                                <span class="flex items-center gap-1"><span
                                                        class="material-symbols-outlined text-sm">schedule</span> 15
                                                    min read</span>
                                                <span class="flex items-center gap-1"><span
                                                        class="material-symbols-outlined text-sm">trending_up</span>
                                                    40% completion</span>
                                            </div>
                                        </div>
                                        <div class="flex items-center gap-2 self-end md:self-center">
                                            <button class="p-2 text-slate-400 hover:text-primary transition-colors">
                                                <span class="material-symbols-outlined">bookmark</span>
                                            </button>
                                            <button
                                                class="px-4 py-1.5 bg-primary text-white text-xs font-bold rounded-full hover:bg-primary-dark transition-colors shadow-lg shadow-primary/20">
                                                Re-read
                                            </button>
                                        </div>
                                    </div>
                                    <div
                                        class="group flex flex-col md:flex-row md:items-center gap-4 p-4 hover:bg-slate-50 dark:hover:bg-slate-800/50 rounded-xl transition-all border border-transparent hover:border-slate-100 dark:hover:border-slate-700 opacity-60 hover:opacity-100">
                                        <div class="size-16 rounded-lg bg-slate-200 shrink-0 overflow-hidden">
                                            <div class="size-full bg-cover bg-center"
                                                style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuBeyA1qXLs0fglqYFEYph68bTvHEuYr74poylGb4FVJP0oNxJZPFNdNFceHVIvLO6cjqUbDc7ocT_xLOKKzgLsD1WcdtkZPVrlMHKphB3q2Pi5nmRwsm9f87dv8pEseZ0jt3Vt-wS5mNbKNXsH7umBabMvle_aYie2ybc5YkypK9OC5sesUS0uqUWF8fpH9oeup3ZvAk9j9VUBxdRbKkDtYXupjDp1lEqZECkw_ajHK9qIRE6FDPkb3DHNqnOpUj_pZe7yJa6D_y6Gg');">
                                            </div>
                                        </div>
                                        <div class="flex-1 min-w-0">
                                            <div class="flex items-center gap-2 mb-1">
                                                <span
                                                    class="px-2 py-0.5 bg-blue-500/10 text-blue-500 text-[10px] font-bold uppercase rounded">Tech</span>
                                                <span class="text-xs text-slate-400">• Oct 18</span>
                                            </div>
                                            <h4 class="text-base font-bold text-slate-900 dark:text-white truncate">
                                                Decentralized AI: Empowering the Individual</h4>
                                            <div class="flex items-center gap-4 mt-1 text-xs text-slate-500">
                                                <span class="flex items-center gap-1"><span
                                                        class="material-symbols-outlined text-sm">schedule</span> 7
                                                    min read</span>
                                                <span class="flex items-center gap-1"><span
                                                        class="material-symbols-outlined text-sm">trending_up</span>
                                                    100% completion</span>
                                            </div>
                                        </div>
                                        <div class="flex items-center gap-2 self-end md:self-center">
                                            <button class="p-2 text-slate-400 hover:text-primary transition-colors">
                                                <span class="material-symbols-outlined">bookmark</span>
                                            </button>
                                            <button
                                                class="px-4 py-1.5 bg-primary text-white text-xs font-bold rounded-full hover:bg-primary-dark transition-colors shadow-lg shadow-primary/20">
                                                Re-read
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </section>
                        </div>
                    </div>
                </div>
                <div
                    class="bg-gradient-to-r from-slate-900 to-primary-dark border border-white/10 rounded-2xl p-8 relative overflow-hidden group mt-6">
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