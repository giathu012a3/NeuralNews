<!DOCTYPE html>
<html class="dark" lang="en">

<head>
    <title>NexusAI - Article Reading Experience</title>
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
                        class="inline-block px-3 py-1 rounded bg-primary/10 text-primary text-[11px] font-bold uppercase tracking-wider">Technology</span>
                    <div
                        class="flex items-center gap-1.5 px-2 py-1 bg-green-500/10 text-green-500 rounded text-xs font-medium">
                        <span class="material-symbols-outlined text-sm">sentiment_satisfied</span>
                        <span>Positive Sentiment</span>
                    </div>
                </div>
                <h1
                    class="text-4xl md:text-5xl lg:text-6xl font-black text-slate-900 dark:text-white leading-[1.1] mb-8">
                    AI Models Predict Weather Patterns with 99% Accuracy
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
                            <p class="text-xs text-slate-500">October 24, 2023 • 8 min read</p>
                        </div>
                    </div>
                    <div class="flex items-center gap-3">
                        <button
                            class="flex items-center gap-2 px-4 py-2 rounded-full border border-slate-200 dark:border-slate-700 text-sm font-medium hover:bg-slate-50 dark:hover:bg-slate-800 transition-colors">
                            <span class="material-symbols-outlined text-xl">bookmark</span>
                            Save
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
                            <div class="size-8 rounded-lg bg-primary/10 text-primary flex items-center justify-center">
                                <span class="material-symbols-outlined text-xl">auto_awesome</span>
                            </div>
                            <span class="font-bold text-slate-900 dark:text-white">Generate AI Summary</span>
                        </div>
                        <span
                            class="material-symbols-outlined text-slate-400 group-hover:text-primary">expand_more</span>
                    </button>
                    <div class="mt-4 p-6 bg-blue-50/50 dark:bg-primary/5 rounded-xl border border-primary/10">
                        <h4 class="text-xs font-bold text-primary uppercase tracking-widest mb-4">Quick Highlights</h4>
                        <ul class="space-y-3">
                            <li class="flex items-start gap-3 text-slate-700 dark:text-slate-300 text-sm">
                                <span class="size-1.5 rounded-full bg-primary shrink-0 mt-1.5"></span>
                                New transformer-based AI models demonstrate unprecedented accuracy in predicting severe
                                weather shifts.
                            </li>
                            <li class="flex items-start gap-3 text-slate-700 dark:text-slate-300 text-sm">
                                <span class="size-1.5 rounded-full bg-primary shrink-0 mt-1.5"></span>
                                The system utilizes global meteorological datasets spanning over 40 years of climate
                                history.
                            </li>
                            <li class="flex items-start gap-3 text-slate-700 dark:text-slate-300 text-sm">
                                <span class="size-1.5 rounded-full bg-primary shrink-0 mt-1.5"></span>
                                Integration with existing infrastructure could save billions in annual disaster
                                preparation costs.
                            </li>
                            <li class="flex items-start gap-3 text-slate-700 dark:text-slate-300 text-sm">
                                <span class="size-1.5 rounded-full bg-primary shrink-0 mt-1.5"></span>
                                Peer-reviewed results show the AI outperforms traditional supercomputer models by 15%.
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="article-content mt-10">
                    <img alt="AI Visualization" class="w-full h-[500px] object-cover rounded-2xl mb-12 shadow-xl"
                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuAJYXTTOH-j3MgaNT2onqeIEXdT2yZnwu0uY83A9u6SXAwhdNe0mIGM1L0eh3j5wGCVrRHfKSbV2NhX2YL1tqdHhnvL4S3raWE13J3n_CcoRUW1_cAw5OhcC2OgvV3JXF63Z_pRn7iEl1OeuAYmSlghfJXddKECmxVUZI5XCsBY4BfQsSArn3on1In-WLU3B7YZtRuPFofa9W5LArXz-UR8XDxzXKPQ6IWyOYZkGxgwksAZqztiXXLawxLkRB6Aq8Ivn1bo8KOFL8pu" />
                    <p>
                        A breakthrough in meteorological data processing allows new transformer models to foresee
                        climate shifts weeks in advance. For decades, weather prediction has relied on massive
                        supercomputers running complex physics-based simulations that often struggled with long-range
                        accuracy.
                    </p>
                    <p>
                        However, the emergence of generative AI and specialized neural networks is changing the game. By
                        analyzing patterns rather than just calculating fluid dynamics, these systems can identify
                        "pre-signals" of major storm fronts that were previously invisible to traditional monitoring
                        equipment.
                    </p>
                    <blockquote
                        class="my-10 pl-6 border-l-4 border-primary italic text-2xl font-medium text-slate-800 dark:text-slate-200">
                        "We are entering an era where the unpredictability of nature is finally being mapped by the
                        intelligence of machines."
                    </blockquote>
                    <p>
                        The implications for agriculture, maritime logistics, and emergency management are profound. In
                        trial runs across the Pacific, the NexusAI forecasting engine correctly identified three
                        separate cyclone formations six days before satellite reconnaissance confirmed their
                        development.
                    </p>
                </div>
                <div class="mt-16 pt-12 border-t border-slate-200 dark:border-slate-800">
                    <h3 class="text-2xl font-bold text-slate-900 dark:text-white mb-8">Discussion (128)</h3>
                    <div class="flex gap-4 mb-10">
                        <div class="size-10 rounded-full bg-slate-200 overflow-hidden shrink-0">
                            <div class="size-full bg-cover bg-center"
                                style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCqHJoDOZXEs2I-dWg4cNlhnZWUAg-oBJGZBmq-PpFoJ50SV0NIa98rHAwe3bxy50vyDTw8NHXXjoiNAgpWnLDQFnXhwjbF1AjVEqM11aGgAOtWj5SSP8yDkoQK1AtowhO1u68BOZOlFIT9MNofGpAlZ3JqZTUDZnPnJXrW2cjFXP9ywq1Un_lnbETpHo9rOZaGlocLFlhstxpM83Zzw8q542F04tYAv4jhfi5wKUicr1qd6_Lz2OKuF66ucETPy-Se0VxXmBa0LSQo');">
                            </div>
                        </div>
                        <div class="flex-1">
                            <textarea
                                class="w-full p-4 rounded-xl bg-slate-50 dark:bg-surface-dark border-slate-200 dark:border-slate-700 focus:ring-primary focus:border-primary text-sm transition-all"
                                placeholder="Join the conversation..." rows="3"></textarea>
                            <div class="mt-2 flex justify-end">
                                <button
                                    class="px-6 py-2 bg-primary text-white text-sm font-bold rounded-full hover:bg-primary-dark transition-colors">Post
                                    Comment</button>
                            </div>
                        </div>
                    </div>
                    <div class="space-y-8">
                        <div class="flex gap-4">
                            <div class="size-10 rounded-full bg-slate-300 shrink-0"></div>
                            <div class="flex-1">
                                <div class="flex items-center gap-2 mb-1">
                                    <span class="font-bold text-sm text-slate-900 dark:text-white">Sarah Jenkins</span>
                                    <span class="text-xs text-slate-500">2h ago</span>
                                </div>
                                <p class="text-sm text-slate-700 dark:text-slate-300 mb-3">
                                    This is absolutely fascinating. I wonder how this impacts insurance premiums in
                                    high-risk zones if the accuracy remains this high.
                                </p>
                                <div class="flex items-center gap-4 text-xs font-bold text-slate-500">
                                    <button class="flex items-center gap-1 hover:text-primary"><span
                                            class="material-symbols-outlined text-sm">thumb_up</span> 24</button>
                                    <button class="hover:text-primary">Reply</button>
                                </div>
                            </div>
                        </div>
                        <div class="flex gap-4">
                            <div class="size-10 rounded-full bg-slate-300 shrink-0"></div>
                            <div class="flex-1">
                                <div class="flex items-center gap-2 mb-1">
                                    <span class="font-bold text-sm text-slate-900 dark:text-white">Michael Chen</span>
                                    <span class="text-xs text-slate-500">5h ago</span>
                                </div>
                                <p class="text-sm text-slate-700 dark:text-slate-300 mb-3">
                                    Does the model account for climate change volatility, or is it based solely on
                                    historical averages?
                                </p>
                                <div class="flex items-center gap-4 text-xs font-bold text-slate-500">
                                    <button class="flex items-center gap-1 hover:text-primary"><span
                                            class="material-symbols-outlined text-sm">thumb_up</span> 12</button>
                                    <button class="hover:text-primary">Reply</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </article>
        </main>

        <jsp:include page="components/footer.jsp" />

        <div class="fixed bottom-6 right-6 z-50 flex flex-col items-end gap-4">
            <div
                class="hidden md:flex w-80 bg-white dark:bg-surface-dark border border-slate-200 dark:border-slate-700 rounded-2xl shadow-2xl flex-col overflow-hidden animate-in slide-in-from-bottom-4 duration-300">
                <div class="p-4 bg-primary text-white flex items-center justify-between">
                    <div class="flex items-center gap-2">
                        <span class="material-symbols-outlined text-xl">smart_toy</span>
                        <span class="font-bold text-sm">NexusAI Assistant</span>
                    </div>
                    <button class="text-white/80 hover:text-white"><span
                            class="material-symbols-outlined text-sm">close</span></button>
                </div>
                <div class="p-4 h-64 overflow-y-auto space-y-4">
                    <div
                        class="bg-slate-100 dark:bg-slate-800 p-3 rounded-lg text-xs text-slate-700 dark:text-slate-300">
                        Hello! I've read this article. How can I help you today?
                    </div>
                    <div class="flex flex-col gap-2">
                        <button
                            class="text-left p-2 rounded-lg bg-slate-50 dark:bg-slate-800/50 border border-slate-200 dark:border-slate-700 text-[11px] hover:bg-primary/10 transition-colors text-slate-600 dark:text-slate-400">
                            "Explain more about AI weather models"
                        </button>
                        <button
                            class="text-left p-2 rounded-lg bg-slate-50 dark:bg-slate-800/50 border border-slate-200 dark:border-slate-700 text-[11px] hover:bg-primary/10 transition-colors text-slate-600 dark:text-slate-400">
                            "Summarize the technical section"
                        </button>
                        <button
                            class="text-left p-2 rounded-lg bg-slate-50 dark:bg-slate-800/50 border border-slate-200 dark:border-slate-700 text-[11px] hover:bg-primary/10 transition-colors text-slate-600 dark:text-slate-400">
                            "Is this data peer-reviewed?"
                        </button>
                    </div>
                </div>
                <div class="p-3 border-t border-slate-100 dark:border-slate-800">
                    <div class="flex items-center gap-2 bg-slate-100 dark:bg-slate-800 rounded-lg px-3 py-2">
                        <input
                            class="bg-transparent border-none text-xs focus:ring-0 flex-1 text-slate-900 dark:text-white"
                            placeholder="Ask AI..." type="text" />
                        <button class="text-primary"><span
                                class="material-symbols-outlined text-sm">send</span></button>
                    </div>
                </div>
            </div>
            <button
                class="size-14 rounded-full bg-primary text-white shadow-xl flex items-center justify-center hover:scale-110 transition-transform ring-4 ring-white dark:ring-background-dark">
                <span class="material-symbols-outlined text-3xl">smart_toy</span>
            </button>
        </div>
    </div>

</body>

</html>