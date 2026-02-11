<!DOCTYPE html>
<html class="dark" lang="en">

<head>
    <title>Saved Articles - NexusAI User Dashboard</title>
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
                            class="px-6 py-4 text-sm font-bold text-primary border-b-2 border-primary whitespace-nowrap bg-primary/5">
                            Saved Articles
                        </button>
                        <button
                            onclick="window.location.href='${pageContext.request.contextPath}/user/reading_history.jsp'"
                            class="px-6 py-4 text-sm font-bold text-slate-500 dark:text-slate-400 border-b-2 border-transparent hover:text-primary transition-colors whitespace-nowrap">
                            Reading History
                        </button>
                        <button
                            onclick="window.location.href='${pageContext.request.contextPath}/user/ai_preferences.jsp'"
                            class="px-6 py-4 text-sm font-bold text-slate-500 dark:text-slate-400 border-b-2 border-transparent hover:text-primary transition-colors whitespace-nowrap">
                            AI Preferences
                        </button>
                    </div>
                    <div class="p-6 md:p-8">
                        <div class="flex flex-col md:flex-row md:items-center justify-between gap-4 mb-8">
                            <div>
                                <h2 class="text-2xl font-bold text-slate-900 dark:text-white">Your Saved Articles
                                </h2>
                                <p class="text-slate-500 dark:text-slate-400 text-sm mt-1">Keep track of the stories
                                    you want to read later.</p>
                            </div>
                            <div class="flex items-center gap-2">
                                <button
                                    class="flex items-center justify-center size-10 rounded-lg bg-slate-100 dark:bg-background-dark/50 text-slate-600 dark:text-white hover:bg-primary hover:text-white transition-all">
                                    <span class="material-symbols-outlined">grid_view</span>
                                </button>
                                <button
                                    class="flex items-center justify-center size-10 rounded-lg bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark text-slate-400 hover:text-primary transition-all">
                                    <span class="material-symbols-outlined">view_list</span>
                                </button>
                            </div>
                        </div>
                        <div class="grid grid-cols-1 md:grid-cols-2 xl:grid-cols-3 gap-6">
                            <div
                                class="group bg-white dark:bg-background-dark/30 border border-slate-200 dark:border-border-dark rounded-xl overflow-hidden hover:shadow-xl hover:shadow-primary/5 transition-all duration-300">
                                <div class="relative aspect-video overflow-hidden">
                                    <div class="size-full bg-cover bg-center transition-transform duration-500 group-hover:scale-105"
                                        style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuAZ5jVKMrAhnOgWc57TUU01Y5BvukaRJskVcVMt7jMoWE0sMesDXsy2W8pRO5MaQQjdPGLZBxVphEh29E17yL2sqOycHccZ8WzP6Wjj2u70Y25OQC_eSAayWNrUO_IFBLW0vXw_DPcMVzoSkHj3Ak2uGEwWoTIIROiYngPDJaVJZUk2XgES7kxOFx47iVJ9qAOqX0ToKfYbmwkFQKY-yzWvr45dAtZkJgusj9rkd-GfiSfeA9g8yL3MteBhX7Q2KlYR0IgZ_TpD4c7e');">
                                    </div>
                                    <div class="absolute top-3 right-3">
                                        <button
                                            class="size-8 rounded-full bg-white/90 dark:bg-surface-dark/90 backdrop-blur-md flex items-center justify-center text-primary shadow-sm hover:text-red-500 transition-colors"
                                            title="Unsave">
                                            <span class="material-symbols-outlined text-[20px] fill-1">bookmark</span>
                                        </button>
                                    </div>
                                    <div class="absolute bottom-3 left-3">
                                        <span
                                            class="px-2.5 py-1 bg-primary text-white text-[10px] font-bold uppercase tracking-wider rounded-md">Technology</span>
                                    </div>
                                </div>
                                <div class="p-4 space-y-3">
                                    <div
                                        class="flex items-center gap-2 text-[11px] font-bold text-slate-400 dark:text-slate-500 uppercase tracking-widest">
                                        <span class="material-symbols-outlined text-[14px]">calendar_today</span>
                                        <span>Oct 24, 2024</span>
                                    </div>
                                    <h3
                                        class="text-base font-bold text-slate-900 dark:text-white leading-tight line-clamp-2 group-hover:text-primary transition-colors">
                                        AI-Powered Journalism: The New Frontier in News Production
                                    </h3>
                                    <p class="text-sm text-slate-500 dark:text-slate-400 line-clamp-2">
                                        Discover how generative models are assisting reporters in uncovering
                                        data-driven insights faster than ever before.
                                    </p>
                                    <div class="pt-2 flex items-center justify-between">
                                        <a class="text-xs font-bold text-primary flex items-center gap-1 hover:gap-2 transition-all"
                                            href="#">
                                            Read Article
                                            <span class="material-symbols-outlined text-[16px]">arrow_forward</span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div
                                class="group bg-white dark:bg-background-dark/30 border border-slate-200 dark:border-border-dark rounded-xl overflow-hidden hover:shadow-xl hover:shadow-primary/5 transition-all duration-300">
                                <div class="relative aspect-video overflow-hidden">
                                    <div class="size-full bg-cover bg-center transition-transform duration-500 group-hover:scale-105"
                                        style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCqHJoDOZXEs2I-dWg4cNlhnZWUAg-oBJGZBmq-PpFoJ50SV0NIa98rHAwe3bxy50vyDTw8NHXXjoiNAgpWnLDQFnXhwjbF1AjVEqM11aGgAOtWj5SSP8yDkoQK1AtowhO1u68BOZOlFIT9MNofGpAlZ3JqZTUDZnPnJXrW2cjFXP9ywq1Un_lnbETpHo9rOZaGlocLFlhstxpM83Zzw8q542F04tYAv4jhfi5wKUicr1qd6_Lz2OKuF66ucETPy-Se0VxXmBa0LSQo');">
                                    </div>
                                    <div class="absolute top-3 right-3">
                                        <button
                                            class="size-8 rounded-full bg-white/90 dark:bg-surface-dark/90 backdrop-blur-md flex items-center justify-center text-primary shadow-sm hover:text-red-500 transition-colors"
                                            title="Unsave">
                                            <span class="material-symbols-outlined text-[20px] fill-1">bookmark</span>
                                        </button>
                                    </div>
                                    <div class="absolute bottom-3 left-3">
                                        <span
                                            class="px-2.5 py-1 bg-amber-500 text-white text-[10px] font-bold uppercase tracking-wider rounded-md">Science</span>
                                    </div>
                                </div>
                                <div class="p-4 space-y-3">
                                    <div
                                        class="flex items-center gap-2 text-[11px] font-bold text-slate-400 dark:text-slate-500 uppercase tracking-widest">
                                        <span class="material-symbols-outlined text-[14px]">calendar_today</span>
                                        <span>Oct 22, 2024</span>
                                    </div>
                                    <h3
                                        class="text-base font-bold text-slate-900 dark:text-white leading-tight line-clamp-2 group-hover:text-primary transition-colors">
                                        Quantum Supremacy: Google's Latest Milestone Explained
                                    </h3>
                                    <p class="text-sm text-slate-500 dark:text-slate-400 line-clamp-2">
                                        Understanding the implications of the newest quantum processor on global
                                        cryptography and data security.
                                    </p>
                                    <div class="pt-2 flex items-center justify-between">
                                        <a class="text-xs font-bold text-primary flex items-center gap-1 hover:gap-2 transition-all"
                                            href="#">
                                            Read Article
                                            <span class="material-symbols-outlined text-[16px]">arrow_forward</span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div
                                class="group bg-white dark:bg-background-dark/30 border border-slate-200 dark:border-border-dark rounded-xl overflow-hidden hover:shadow-xl hover:shadow-primary/5 transition-all duration-300">
                                <div class="relative aspect-video overflow-hidden">
                                    <div class="size-full bg-cover bg-center transition-transform duration-500 group-hover:scale-105"
                                        style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuBYUAfELR5xYqrYhRtYV8UZ6NpbZULmoMhuvMaNZBDD7ABhN_v2W0DhJzo4cv4c8NJYUjhBjAvzelY8jhGK1sRkgXV6iNEMnHMisZ_xyPjiZDoBul_JxLL7ArPEERA8H9zQhw1_HyQVIDwn1Ho7FskMZMDW-kP962pWgJz957kuYSkJPf9kZ97EufeQ396VYwq15eVpgqfVwGaGvA34F_mo8Rf78VChrc7Qdz5lzFrDvHeLmtTAKUS9l8Q4nZVHzB48vPCy20cTlGVx');">
                                    </div>
                                    <div class="absolute top-3 right-3">
                                        <button
                                            class="size-8 rounded-full bg-white/90 dark:bg-surface-dark/90 backdrop-blur-md flex items-center justify-center text-primary shadow-sm hover:text-red-500 transition-colors"
                                            title="Unsave">
                                            <span class="material-symbols-outlined text-[20px] fill-1">bookmark</span>
                                        </button>
                                    </div>
                                    <div class="absolute bottom-3 left-3">
                                        <span
                                            class="px-2.5 py-1 bg-green-500 text-white text-[10px] font-bold uppercase tracking-wider rounded-md">Finance</span>
                                    </div>
                                </div>
                                <div class="p-4 space-y-3">
                                    <div
                                        class="flex items-center gap-2 text-[11px] font-bold text-slate-400 dark:text-slate-500 uppercase tracking-widest">
                                        <span class="material-symbols-outlined text-[14px]">calendar_today</span>
                                        <span>Oct 21, 2024</span>
                                    </div>
                                    <h3
                                        class="text-base font-bold text-slate-900 dark:text-white leading-tight line-clamp-2 group-hover:text-primary transition-colors">
                                        The Shift Towards Decentralized Economies
                                    </h3>
                                    <p class="text-sm text-slate-500 dark:text-slate-400 line-clamp-2">
                                        How blockchain technology is reshaping traditional banking systems and
                                        empowering individual investors.
                                    </p>
                                    <div class="pt-2 flex items-center justify-between">
                                        <a class="text-xs font-bold text-primary flex items-center gap-1 hover:gap-2 transition-all"
                                            href="#">
                                            Read Article
                                            <span class="material-symbols-outlined text-[16px]">arrow_forward</span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                            <div
                                class="group bg-white dark:bg-background-dark/30 border border-slate-200 dark:border-border-dark rounded-xl overflow-hidden hover:shadow-xl hover:shadow-primary/5 transition-all duration-300">
                                <div class="relative aspect-video overflow-hidden">
                                    <div class="size-full bg-cover bg-center transition-transform duration-500 group-hover:scale-105"
                                        style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCqHJoDOZXEs2I-dWg4cNlhnZWUAg-oBJGZBmq-PpFoJ50SV0NIa98rHAwe3bxy50vyDTw8NHXXjoiNAgpWnLDQFnXhwjbF1AjVEqM11aGgAOtWj5SSP8yDkoQK1AtowhO1u68BOZOlFIT9MNofGpAlZ3JqZTUDZnPnJXrW2cjFXP9ywq1Un_lnbETpHo9rOZaGlocLFlhstxpM83Zzw8q542F04tYAv4jhfi5wKUicr1qd6_Lz2OKuF66ucETPy-Se0VxXmBa0LSQo');">
                                    </div>
                                    <div class="absolute top-3 right-3">
                                        <button
                                            class="size-8 rounded-full bg-white/90 dark:bg-surface-dark/90 backdrop-blur-md flex items-center justify-center text-primary shadow-sm hover:text-red-500 transition-colors"
                                            title="Unsave">
                                            <span class="material-symbols-outlined text-[20px] fill-1">bookmark</span>
                                        </button>
                                    </div>
                                    <div class="absolute bottom-3 left-3">
                                        <span
                                            class="px-2.5 py-1 bg-purple-500 text-white text-[10px] font-bold uppercase tracking-wider rounded-md">Health</span>
                                    </div>
                                </div>
                                <div class="p-4 space-y-3">
                                    <div
                                        class="flex items-center gap-2 text-[11px] font-bold text-slate-400 dark:text-slate-500 uppercase tracking-widest">
                                        <span class="material-symbols-outlined text-[14px]">calendar_today</span>
                                        <span>Oct 19, 2024</span>
                                    </div>
                                    <h3
                                        class="text-base font-bold text-slate-900 dark:text-white leading-tight line-clamp-2 group-hover:text-primary transition-colors">
                                        Future of Telemedicine: AI Diagnostics at Home
                                    </h3>
                                    <p class="text-sm text-slate-500 dark:text-slate-400 line-clamp-2">
                                        Wearable devices and AI algorithms are making preventative healthcare more
                                        accessible than ever.
                                    </p>
                                    <div class="pt-2 flex items-center justify-between">
                                        <a class="text-xs font-bold text-primary flex items-center gap-1 hover:gap-2 transition-all"
                                            href="#">
                                            Read Article
                                            <span class="material-symbols-outlined text-[16px]">arrow_forward</span>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="mt-10 flex justify-center">
                            <button
                                class="px-8 py-3 bg-slate-100 dark:bg-background-dark/50 hover:bg-primary hover:text-white text-slate-600 dark:text-slate-300 font-bold rounded-xl transition-all border border-slate-200 dark:border-border-dark flex items-center gap-2">
                                Load More Articles
                                <span class="material-symbols-outlined text-[18px]">expand_more</span>
                            </button>
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
                                    you'll gain access to our AI-powered editorial suite.</p>
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