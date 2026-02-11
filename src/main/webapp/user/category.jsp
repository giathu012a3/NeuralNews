<!DOCTYPE html>
<html class="dark" lang="en">

<head>
    <title>Technology - NexusAI News</title>
    <jsp:include page="components/head.jsp" />
    <style type="text/tailwindcss">
        @layer utilities {
            .active-nav {
                @apply text-primary border-b-2 border-primary;
            }
        }
    </style>
</head>

<body
    class="bg-background-light dark:bg-background-dark text-text-main dark:text-white font-display antialiased overflow-x-hidden transition-colors duration-200">
    <div class="flex min-h-screen w-full flex-col">
        <jsp:include page="components/header.jsp" />

        <div class="w-full bg-surface-light dark:bg-slate-900/50 border-b border-border-light dark:border-border-dark">
            <div class="max-w-[1440px] mx-auto px-4 lg:px-8 py-10">
                <nav class="flex items-center gap-2 text-xs font-medium text-slate-400 uppercase tracking-widest mb-4">
                    <a class="hover:text-primary" href="${pageContext.request.contextPath}/user/home.jsp">Home</a>
                    <span class="material-symbols-outlined text-xs">chevron_right</span>
                    <span class="text-slate-600 dark:text-slate-300">Technology</span>
                </nav>
                <h1 class="text-4xl md:text-5xl font-black text-slate-900 dark:text-white mb-6">Technology</h1>
                <div class="flex flex-wrap gap-2">
                    <button
                        class="px-4 py-1.5 rounded-full bg-primary text-white text-xs font-bold uppercase tracking-wider">All
                        Tech</button>
                    <button
                        class="px-4 py-1.5 rounded-full bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark text-slate-600 dark:text-slate-300 text-xs font-bold uppercase tracking-wider hover:border-primary transition-colors">AI</button>
                    <button
                        class="px-4 py-1.5 rounded-full bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark text-slate-600 dark:text-slate-300 text-xs font-bold uppercase tracking-wider hover:border-primary transition-colors">Mobile</button>
                    <button
                        class="px-4 py-1.5 rounded-full bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark text-slate-600 dark:text-slate-300 text-xs font-bold uppercase tracking-wider hover:border-primary transition-colors">Laptop</button>
                    <button
                        class="px-4 py-1.5 rounded-full bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark text-slate-600 dark:text-slate-300 text-xs font-bold uppercase tracking-wider hover:border-primary transition-colors">Software</button>
                </div>
            </div>
        </div>

        <main class="flex-1 w-full max-w-[1440px] mx-auto p-4 lg:p-8 grid grid-cols-1 lg:grid-cols-12 gap-8">
            <div class="lg:col-span-8 flex flex-col gap-6">
                <div
                    class="flex flex-col sm:flex-row sm:items-center justify-between gap-4 py-4 border-b border-slate-200 dark:border-border-dark">
                    <div class="flex items-center gap-6">
                        <button class="text-sm font-bold text-primary border-b-2 border-primary pb-1">Latest</button>
                        <button
                            class="text-sm font-medium text-slate-500 hover:text-primary pb-1 transition-colors">Oldest</button>
                        <button
                            class="text-sm font-medium text-slate-500 hover:text-primary pb-1 transition-colors">Most
                            Viewed</button>
                        <button
                            class="text-sm font-medium text-slate-500 hover:text-primary pb-1 transition-colors">Most
                            Commented</button>
                    </div>
                    <button
                        class="flex items-center gap-2 text-xs font-bold text-slate-600 dark:text-slate-400 bg-slate-100 dark:bg-surface-dark px-3 py-1.5 rounded border border-transparent hover:border-slate-300 transition-all">
                        <span class="material-symbols-outlined text-sm">filter_list</span>
                        Advanced Filters
                    </button>
                </div>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- Content Articles would go here, for now using static HTML from template -->
                    <article onclick="window.location.href='${pageContext.request.contextPath}/user/article.jsp'"
                        class="md:col-span-2 flex flex-col md:flex-row gap-6 bg-white dark:bg-surface-dark p-4 rounded-xl border border-slate-100 dark:border-border-dark hover:shadow-lg transition-all group cursor-pointer">
                        <div class="md:w-1/2 h-64 shrink-0 rounded-lg overflow-hidden">
                            <div class="w-full h-full bg-cover bg-center transition-transform duration-700 group-hover:scale-105"
                                style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuAJYXTTOH-j3MgaNT2onqeIEXdT2yZnwu0uY83A9u6SXAwhdNe0mIGM1L0eh3j5wGCVrRHfKSbV2NhX2YL1tqdHhnvL4S3raWE13J3n_CcoRUW1_cAw5OhcC2OgvV3JXF63Z_pRn7iEl1OeuAYmSlghfJXddKECmxVUZI5XCsBY4BfQsSArn3on1In-WLU3B7YZtRuPFofa9W5LArXz-UR8XDxzXKPQ6IWyOYZkGxgwksAZqztiXXLawxLkRB6Aq8Ivn1bo8KOFL8pu');">
                            </div>
                        </div>
                        <div class="flex flex-col justify-between py-2">
                            <div>
                                <span
                                    class="inline-block px-2 py-0.5 rounded bg-blue-100 dark:bg-blue-900/30 text-primary dark:text-blue-400 text-[10px] font-bold uppercase tracking-wider mb-3">AI
                                    &amp; Robotics</span>
                                <h2
                                    class="text-2xl font-bold text-slate-900 dark:text-white mb-3 group-hover:text-primary transition-colors leading-tight">
                                    Neural Linkage: The Future of Human-Computer Interaction in 2024</h2>
                                <p class="text-slate-600 dark:text-slate-400 text-sm line-clamp-3">New breakthrough
                                    research from top labs shows that non-invasive neural interfaces are reaching
                                    performance levels once thought only possible with implants.</p>
                            </div>
                            <div class="flex items-center gap-4 text-xs text-slate-400 mt-4">
                                <span class="flex items-center gap-1"><span
                                        class="material-symbols-outlined text-sm">schedule</span> 45 mins ago</span>
                                <span class="flex items-center gap-1"><span
                                        class="material-symbols-outlined text-sm">forum</span> 128 Comments</span>
                            </div>
                        </div>
                    </article>
                    <article onclick="window.location.href='${pageContext.request.contextPath}/user/article.jsp'"
                        class="bg-white dark:bg-surface-dark rounded-xl border border-slate-100 dark:border-border-dark overflow-hidden hover:shadow-md transition-all group cursor-pointer">
                        <div class="h-48 overflow-hidden relative">
                            <div class="absolute top-3 left-3 z-10">
                                <span
                                    class="px-2 py-1 rounded bg-black/60 backdrop-blur-md text-white text-[10px] font-bold uppercase tracking-wider">Mobile</span>
                            </div>
                            <div class="w-full h-full bg-cover bg-center transition-transform duration-500 group-hover:scale-105"
                                style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDK__sk7UjLv8i1C_8OHskL_--6IxKe9kO8HlawaMoDvWPXzVAQWnbThQjVa0NVKFWNMCwOHhF4khSP0E_iZOi7RX0wNJGAhrrV9IBkrII3avkUkJqYRdYoqMN4vZtX7Hr92xkiHXYOiJcnUs5PwQTBaVtE8oC_BeGZZjLA9164Wl-nvsV7-_Gjkad5oNqMnIjkDMH5-Y5alDP_q1TM4Ci9fQeYtLaHDUKNaSMNTGU2zTN4IErbtptamGaFY02xGy2BLfE6iQY91cts');">
                            </div>
                        </div>
                        <div class="p-4">
                            <h3
                                class="text-base font-bold text-slate-900 dark:text-white mb-2 line-clamp-2 group-hover:text-primary transition-colors">
                                The Foldable Revolution: Why 2024 is the Year of the Flip Phone</h3>
                            <p class="text-slate-500 dark:text-slate-400 text-xs line-clamp-2 mb-4">Manufacturers have
                                finally solved the crease problem, leading to record-breaking pre-orders globally.</p>
                            <div
                                class="flex items-center justify-between text-[10px] text-slate-400 font-bold uppercase tracking-widest pt-3 border-t border-slate-50 dark:border-slate-800">
                                <span>2 hours ago</span>
                                <button class="text-slate-400 hover:text-primary"><span
                                        class="material-symbols-outlined text-lg">bookmark</span></button>
                            </div>
                        </div>
                    </article>
                    <article onclick="window.location.href='${pageContext.request.contextPath}/user/article.jsp'"
                        class="bg-white dark:bg-surface-dark rounded-xl border border-slate-100 dark:border-border-dark overflow-hidden hover:shadow-md transition-all group cursor-pointer">
                        <div class="h-48 overflow-hidden relative">
                            <div class="absolute top-3 left-3 z-10">
                                <span
                                    class="px-2 py-1 rounded bg-black/60 backdrop-blur-md text-white text-[10px] font-bold uppercase tracking-wider">Software</span>
                            </div>
                            <div class="w-full h-full bg-cover bg-center transition-transform duration-500 group-hover:scale-105"
                                style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCrc_7XThJ5bAFGC03h2RGUpg2i4LGEanIMHmTjsApYkKda1tlYEyQlB0qYKhYImQ4lOhybrDjFu3zamKplFgbncnCxd7y4Y3S_EefRhQgK224OagGlzOIC6sFI_CafUwt_kXS-8vLmfW8iH5e8gXhSt0pmZBRpwc2Gd0DK1BeTFHNVeEWi8Kvc2fffea280_KCVJI5lZOJoH3D1IVjtPQgvmXXQ51k0UBribsipHUPoK0RCeTAOuNoBnmbyDqQIfikd98VZOU0GsaT');">
                            </div>
                        </div>
                        <div class="p-4">
                            <h3
                                class="text-base font-bold text-slate-900 dark:text-white mb-2 line-clamp-2 group-hover:text-primary transition-colors">
                                Open Source Models Now Rivaling Proprietary Giants</h3>
                            <p class="text-slate-500 dark:text-slate-400 text-xs line-clamp-2 mb-4">A new study confirms
                                that Llama-derived models are closing the gap with GPT-4 in coding tasks.</p>
                            <div
                                class="flex items-center justify-between text-[10px] text-slate-400 font-bold uppercase tracking-widest pt-3 border-t border-slate-50 dark:border-slate-800">
                                <span>5 hours ago</span>
                                <button class="text-slate-400 hover:text-primary"><span
                                        class="material-symbols-outlined text-lg">bookmark</span></button>
                            </div>
                        </div>
                    </article>
                    <article onclick="window.location.href='${pageContext.request.contextPath}/user/article.jsp'"
                        class="bg-white dark:bg-surface-dark rounded-xl border border-slate-100 dark:border-border-dark overflow-hidden hover:shadow-md transition-all group cursor-pointer">
                        <div class="h-48 overflow-hidden relative">
                            <div class="absolute top-3 left-3 z-10">
                                <span
                                    class="px-2 py-1 rounded bg-black/60 backdrop-blur-md text-white text-[10px] font-bold uppercase tracking-wider">Hardware</span>
                            </div>
                            <div class="w-full h-full bg-cover bg-center transition-transform duration-500 group-hover:scale-105"
                                style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDjfrR0s1j9yaictFquQ1vY_YE1u56tiWzBQ1LqmWRlgixs9IPvIsK3E7dGf8FscFvnq2072Uz9jW2aP6A2x66gpkP3cKgu2YMmsC-re9FDsqOzul02RsRchF-xKxG5PCjjy6JhuAPBtMUmQd-RUAF46PPsEzQjHQnBLbl46Fkv2MgEW1TvPkm5He6Z_bLXIlNHUk2QMXmDcBqDZASnyqwAjWyaywA5RofmCZ_ZCvc1D9k1OONtsjCRJkTyChUSTjM4bgN2_CBMpbT0');">
                            </div>
                        </div>
                        <div class="p-4">
                            <h3
                                class="text-base font-bold text-slate-900 dark:text-white mb-2 line-clamp-2 group-hover:text-primary transition-colors">
                                Next-Gen GPU Architecture Promises 3x Efficiency</h3>
                            <p class="text-slate-500 dark:text-slate-400 text-xs line-clamp-2 mb-4">Leaked benchmarks
                                show surprising power-to-performance ratios for upcoming silicon.</p>
                            <div
                                class="flex items-center justify-between text-[10px] text-slate-400 font-bold uppercase tracking-widest pt-3 border-t border-slate-50 dark:border-slate-800">
                                <span>Yesterday</span>
                                <button class="text-slate-400 hover:text-primary"><span
                                        class="material-symbols-outlined text-lg">bookmark</span></button>
                            </div>
                        </div>
                    </article>
                    <article onclick="window.location.href='${pageContext.request.contextPath}/user/article.jsp'"
                        class="bg-white dark:bg-surface-dark rounded-xl border border-slate-100 dark:border-border-dark overflow-hidden hover:shadow-md transition-all group cursor-pointer">
                        <div class="h-48 overflow-hidden relative">
                            <div class="absolute top-3 left-3 z-10">
                                <span
                                    class="px-2 py-1 rounded bg-black/60 backdrop-blur-md text-white text-[10px] font-bold uppercase tracking-wider">Security</span>
                            </div>
                            <div class="w-full h-full bg-cover bg-center transition-transform duration-500 group-hover:scale-105"
                                style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDK__sk7UjLv8i1C_8OHskL_--6IxKe9kO8HlawaMoDvWPXzVAQWnbThQjVa0NVKFWNMCwOHhF4khSP0E_iZOi7RX0wNJGAhrrV9IBkrII3avkUkJqYRdYoqMN4vZtX7Hr92xkiHXYOiJcnUs5PwQTBaVtE8oC_BeGZZjLA9164Wl-nvsV7-_Gjkad5oNqMnIjkDMH5-Y5alDP_q1TM4Ci9fQeYtLaHDUKNaSMNTGU2zTN4IErbtptamGaFY02xGy2BLfE6iQY91cts');">
                            </div>
                        </div>
                        <div class="p-4">
                            <h3
                                class="text-base font-bold text-slate-900 dark:text-white mb-2 line-clamp-2 group-hover:text-primary transition-colors">
                                Zero-Day Vulnerability Found in Popular Browser Engine</h3>
                            <p class="text-slate-500 dark:text-slate-400 text-xs line-clamp-2 mb-4">Security researchers
                                urge users to update immediately to patch the critical exploit.</p>
                            <div
                                class="flex items-center justify-between text-[10px] text-slate-400 font-bold uppercase tracking-widest pt-3 border-t border-slate-50 dark:border-slate-800">
                                <span>2 days ago</span>
                                <button class="text-slate-400 hover:text-primary"><span
                                        class="material-symbols-outlined text-lg">bookmark</span></button>
                            </div>
                        </div>
                    </article>
                </div>
                <button
                    class="w-full py-4 mt-4 text-sm font-bold text-primary border border-primary/20 rounded-xl hover:bg-primary/5 transition-all flex items-center justify-center gap-2">
                    Load More Tech Articles
                    <span class="material-symbols-outlined text-lg">expand_more</span>
                </button>
            </div>
            <aside class="lg:col-span-4 flex flex-col gap-8">
                <div class="bg-primary rounded-xl p-6 text-white shadow-lg">
                    <h3 class="text-lg font-bold mb-2">Tech Insider Weekly</h3>
                    <p class="text-blue-100 text-sm mb-4">Get the most important tech news delivered to your inbox every
                        Friday morning.</p>
                    <div class="flex flex-col gap-2">
                        <input
                            class="w-full h-10 px-4 rounded bg-white/10 border-white/20 placeholder:text-blue-200 text-sm focus:ring-0 focus:border-white"
                            placeholder="email@example.com" type="email" />
                        <button
                            class="w-full h-10 bg-white text-primary font-bold rounded text-sm hover:bg-blue-50 transition-colors">Subscribe
                            Now</button>
                    </div>
                </div>
                <div
                    class="bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-xl p-5">
                    <h3 class="text-lg font-bold text-slate-900 dark:text-white mb-4 flex items-center gap-2">
                        <span class="material-symbols-outlined text-primary">bolt</span>
                        Trending in Tech
                    </h3>
                    <div class="flex flex-col gap-5">
                        <a class="group flex gap-3 items-start" href="#">
                            <div class="size-16 shrink-0 rounded bg-slate-100 overflow-hidden">
                                <div class="size-full bg-cover bg-center"
                                    style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDK__sk7UjLv8i1C_8OHskL_--6IxKe9kO8HlawaMoDvWPXzVAQWnbThQjVa0NVKFWNMCwOHhF4khSP0E_iZOi7RX0wNJGAhrrV9IBkrII3avkUkJqYRdYoqMN4vZtX7Hr92xkiHXYOiJcnUs5PwQTBaVtE8oC_BeGZZjLA9164Wl-nvsV7-_Gjkad5oNqMnIjkDMH5-Y5alDP_q1TM4Ci9fQeYtLaHDUKNaSMNTGU2zTN4IErbtptamGaFY02xGy2BLfE6iQY91cts');">
                                </div>
                            </div>
                            <div>
                                <h4
                                    class="text-sm font-bold text-slate-800 dark:text-slate-200 leading-tight group-hover:text-primary transition-colors line-clamp-2">
                                    New Security Protocols for Quantum Computing Era
                                </h4>
                                <span class="text-[10px] text-slate-500 font-bold uppercase mt-1 block">4,200
                                    views</span>
                            </div>
                        </a>
                        <a class="group flex gap-3 items-start" href="#">
                            <div class="size-16 shrink-0 rounded bg-slate-100 overflow-hidden">
                                <div class="size-full bg-cover bg-center"
                                    style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCrc_7XThJ5bAFGC03h2RGUpg2i4LGEanIMHmTjsApYkKda1tlYEyQlB0qYKhYImQ4lOhybrDjFu3zamKplFgbncnCxd7y4Y3S_EefRhQgK224OagGlzOIC6sFI_CafUwt_kXS-8vLmfW8iH5e8gXhSt0pmZBRpwc2Gd0DK1BeTFHNVeEWi8Kvc2fffea280_KCVJI5lZOJoH3D1IVjtPQgvmXXQ51k0UBribsipHUPoK0RCeTAOuNoBnmbyDqQIfikd98VZOU0GsaT');">
                                </div>
                            </div>
                            <div>
                                <h4
                                    class="text-sm font-bold text-slate-800 dark:text-slate-200 leading-tight group-hover:text-primary transition-colors line-clamp-2">
                                    Python 4.0: What Developers Need to Know
                                </h4>
                                <span class="text-[10px] text-slate-500 font-bold uppercase mt-1 block">3,850
                                    views</span>
                            </div>
                        </a>
                        <a class="group flex gap-3 items-start" href="#">
                            <div class="size-16 shrink-0 rounded bg-slate-100 overflow-hidden">
                                <div class="size-full bg-cover bg-center"
                                    style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuDobs8RjnWif8UQ50Z-fZfKRUVaMxulVKyLJdFLEkjgEgdaSwAwySOmh-X4NXt6Z2EbuQkjyJKhAzNOg1h9iYcrccPrjPrIifqBxE-4KvC_pF7Legf3GjHjeRwugZMYsc2FLVCs5rm4MknfVKmOfFUDY8yM6gV7kSjA5JUZAAcRP6dT2BhOfWs_avYZVJyfqlMMUG2gdgv7BBGrbdKqdKD5U4WLCsDMajC0Q5TVJK3OtfMFNb3ejHCdFOdOm2FtjsuJ2Mk5HWKu91Ms');">
                                </div>
                            </div>
                            <div>
                                <h4
                                    class="text-sm font-bold text-slate-800 dark:text-slate-200 leading-tight group-hover:text-primary transition-colors line-clamp-2">
                                    Robotics in Elder Care: A Human Touch?
                                </h4>
                                <span class="text-[10px] text-slate-500 font-bold uppercase mt-1 block">2,900
                                    views</span>
                            </div>
                        </a>
                    </div>
                </div>
                <div
                    class="h-[450px] w-full bg-slate-100 dark:bg-surface-dark border border-dashed border-slate-300 dark:border-slate-700 rounded-xl flex flex-col items-center justify-center p-6 text-center relative overflow-hidden group">
                    <div class="absolute inset-0 bg-slate-200 dark:bg-slate-800/40 opacity-50"></div>
                    <div class="relative z-10">
                        <span
                            class="text-[10px] font-black text-slate-400 uppercase tracking-widest mb-4 block">Sponsored
                            Content</span>
                        <div class="size-20 bg-primary/10 rounded-full flex items-center justify-center mx-auto mb-4">
                            <span class="material-symbols-outlined text-4xl text-primary">cloud_done</span>
                        </div>
                        <h4 class="text-xl font-black text-slate-900 dark:text-white mb-2 leading-tight">Scale Your AI
                            Infrastructure</h4>
                        <p class="text-sm text-slate-500 dark:text-slate-400 mb-6">Enterprise-grade machine learning
                            solutions for modern teams.</p>
                        <button
                            class="px-6 py-2.5 bg-primary text-white text-xs font-bold rounded-lg shadow-lg hover:bg-primary-dark transition-all uppercase tracking-wider">Try
                            For Free</button>
                    </div>
                </div>
            </aside>
        </main>
        <jsp:include page="components/footer.jsp" />
    </div>
</body>

</html>