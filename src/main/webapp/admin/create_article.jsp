<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <jsp:include page="components/head.jsp" />
        <title>Create Article | NexusAI Admin</title>
        <style>
            .editor-container::-webkit-scrollbar {
                width: 6px;
            }

            .editor-container::-webkit-scrollbar-thumb {
                background-color: rgba(156, 163, 175, 0.2);
                border-radius: 10px;
            }

            .ai-badge {
                font-size: 10px;
                padding: 2px 8px;
                border-radius: 9999px;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 0.05em;
            }
        </style>
    </head>

    <body class="bg-dashboard-bg dark:bg-background-dark font-sans text-slate-800 dark:text-slate-100 overflow-hidden">
        <div class="flex h-screen overflow-hidden">
            <jsp:include page="components/sidebar.jsp">
                <jsp:param name="activePage" value="content" />
            </jsp:include>

            <!-- Main Editor Area -->
            <main
                class="flex-1 ml-64 mr-80 h-full bg-white dark:bg-slate-900 border-r border-slate-200 dark:border-slate-700 flex flex-col relative overflow-hidden">
                <header
                    class="h-16 bg-white dark:bg-slate-800 border-b border-slate-200 dark:border-slate-700 flex items-center justify-between px-6 shrink-0 z-30">
                    <div class="flex items-center gap-6">
                        <a class="flex items-center gap-2 text-slate-400 hover:text-primary transition-colors group"
                            href="${pageContext.request.contextPath}/admin/content.jsp">
                            <span
                                class="material-icons text-xl transition-transform group-hover:-translate-x-1">arrow_back</span>
                            <span class="text-sm font-semibold uppercase tracking-wider">Back to Content</span>
                        </a>
                        <div class="h-6 w-px bg-slate-200 dark:bg-slate-700"></div>
                        <div class="flex items-center gap-2">
                            <span class="w-2 h-2 bg-emerald-500 rounded-full animate-pulse"></span>
                            <span class="text-[11px] font-medium text-slate-500 uppercase tracking-widest">Draft saved:
                                10:45 AM</span>
                        </div>
                    </div>
                    <div class="flex items-center gap-3">
                        <button
                            class="px-4 py-2 text-xs font-bold text-slate-600 dark:text-slate-300 border border-transparent hover:border-slate-300 rounded transition-all uppercase tracking-widest">
                            Save Draft
                        </button>
                        <button
                            class="px-4 py-2 text-xs font-bold text-slate-600 dark:text-slate-300 border border-slate-200 dark:border-slate-700 hover:bg-slate-50 dark:hover:bg-slate-800 rounded transition-all flex items-center gap-2 uppercase tracking-widest">
                            <span class="material-icons text-[18px]">visibility</span>
                            Preview
                        </button>
                        <button
                            class="px-6 py-2 bg-primary hover:bg-primary/90 text-white text-xs font-bold rounded transition-all uppercase tracking-widest shadow-lg shadow-primary/20">
                            Publish Now
                        </button>
                    </div>
                </header>

                <div class="flex-1 overflow-y-auto editor-container p-8 lg:p-12">
                    <div class="max-w-4xl mx-auto space-y-10">
                        <div class="space-y-6">
                            <input
                                class="w-full bg-transparent border-none focus:ring-0 text-5xl font-bold placeholder-slate-300 dark:placeholder-slate-600 text-slate-900 dark:text-white leading-tight outline-none"
                                placeholder="Enter article title..." type="text"
                                value="The Future of AI in Modern News Reporting" />
                            <div class="flex items-center gap-6 py-4 border-y border-slate-100 dark:border-slate-700">
                                <div class="flex items-center gap-3">
                                    <img alt="Admin User" class="w-8 h-8 rounded-full ring-2 ring-primary/20"
                                        src="https://lh3.googleusercontent.com/aida-public/AB6AXuC4v1Xj-x5c0-BNWvuQMWrNKnYpUqHJu2FzBC2ANgMo6855wzRgUZD-tyPVU_iWy9HANXuBFUBSMxHPeds14WCinCTTRCtzwz4MqbtS_WsSwg5Gy0dENGvERGxaw9BORVzow9HavpimbV7bIQ6_ZH8VevoPeGWPT5YBZAurWMoIevRvkLkGWt1gp_7QPG9XNSgbrNUujAcFewuJkhw1rocmmASWGj67hq21d4jI11-j3ZZxxaxhgSjEO9Fx64PNgntutDDQHHdl5Ubo" />
                                    <div class="flex flex-col">
                                        <span class="text-xs font-bold text-slate-700 dark:text-slate-300">Admin
                                            Console</span>
                                        <span class="text-[10px] text-slate-500 uppercase tracking-tighter">System
                                            Administrator</span>
                                    </div>
                                </div>
                                <div class="flex items-center gap-4">
                                    <span
                                        class="ai-badge bg-primary/10 text-primary border border-primary/20">Technology</span>
                                    <div class="flex items-center gap-1.5 text-slate-500">
                                        <span class="material-icons text-sm">schedule</span>
                                        <span class="text-[11px] font-medium">5 MIN READ</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Content Area Made Editable -->
                        <div class="prose prose-slate dark:prose-invert max-w-none focus:outline-none min-h-[500px]"
                            contenteditable="true">
                            <p class="text-xl leading-[1.8] text-slate-600 dark:text-slate-300 font-light">
                                The integration of artificial intelligence into the newsroom is no longer a distant
                                possibility—it is an active reality that is reshaping how stories are discovered,
                                verified,
                                and delivered to audiences worldwide. From automated data analysis to real-time
                                translation
                                and transcription, AI is providing journalists with powerful tools to enhance their
                                reporting.
                            </p>
                            <div class="my-10 group relative rounded-2xl overflow-hidden border border-slate-200 dark:border-slate-700"
                                contenteditable="false">
                                <img alt="AI Technology Visualization"
                                    class="w-full h-auto object-cover opacity-90 group-hover:opacity-100 transition-opacity"
                                    src="https://lh3.googleusercontent.com/aida-public/AB6AXuCe5f1aMHa30MbTUOV9kgjgWzQFwT9vKW1FwcE_WURKBUf6wSU-k5MZcXGZ_fD_u2WuHzABVSmlPPfLES6UYkxJhp6m2MAezTBDY_k2jZHc1y2-ODdQu-OLx5Jk-8rzx1p6VFXl7GkYLeXjqIPdwje2k7iPSzyKpAbtexSQjtWEeasA-BjDhDEAYLFLXzrKe7Q8a1FWwNwrSpeVleYSvrb_T4JrYiGXWCNR0hP4-OSrs6QLLFPIbJh2qAiuARLjKx1-CUk66vuLGKy1" />
                                <div
                                    class="absolute inset-0 bg-gradient-to-t from-slate-900/60 to-transparent pointer-events-none">
                                </div>
                                <div class="absolute bottom-4 left-6 pointer-events-none">
                                    <p class="text-xs text-white/80 italic">Figure 1: Neural processing visualization
                                        for semantic analysis.</p>
                                </div>
                            </div>
                            <p class="text-xl leading-[1.8] text-slate-600 dark:text-slate-300 font-light">
                                However, as we embrace these advancements, the industry faces critical questions
                                regarding
                                ethics, bias, and the essential human element of storytelling. How do we ensure that AI
                                remains a tool for augmentation rather than a replacement for investigative rigor and
                                journalistic integrity?
                            </p>
                            <div class="mt-12 p-6 border-l-4 border-primary/40 bg-primary/5 rounded-r-xl"
                                contenteditable="false">
                                <p class="text-xl leading-relaxed text-slate-400 italic">
                                    Start writing your next paragraph here or use the 'Ask Copilot' tool for a
                                    breakthrough...
                                </p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Floating Toolbar -->
                <div
                    class="absolute bottom-10 left-1/2 -translate-x-1/2 flex items-center gap-1.5 p-2.5 bg-white dark:bg-slate-800 border border-slate-200 dark:border-slate-700 rounded-xl shadow-2xl z-40 transition-all hover:scale-105">
                    <div class="flex items-center gap-0.5 border-r border-slate-200 dark:border-slate-700 pr-2">
                        <button
                            class="p-2 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-600 dark:text-slate-300 transition-colors"
                            onclick="document.execCommand('bold')">
                            <span class="material-icons text-[20px]">format_bold</span>
                        </button>
                        <button
                            class="p-2 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-600 dark:text-slate-300 transition-colors"
                            onclick="document.execCommand('italic')">
                            <span class="material-icons text-[20px]">format_italic</span>
                        </button>
                        <button
                            class="p-2 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-600 dark:text-slate-300 transition-colors"
                            onclick="document.execCommand('underline')">
                            <span class="material-icons text-[20px]">format_underlined</span>
                        </button>
                    </div>
                    <div class="flex items-center gap-0.5 border-r border-slate-200 dark:border-slate-700 pr-2">
                        <button
                            class="p-2 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-600 dark:text-slate-300 transition-colors"
                            onclick="document.execCommand('insertUnorderedList')">
                            <span class="material-icons text-[20px]">format_list_bulleted</span>
                        </button>
                        <button
                            class="p-2 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-600 dark:text-slate-300 transition-colors">
                            <span class="material-icons text-[20px]">link</span>
                        </button>
                        <button
                            class="p-2 hover:bg-slate-100 dark:hover:bg-slate-700 rounded-lg text-slate-600 dark:text-slate-300 transition-colors">
                            <span class="material-icons text-[20px]">image</span>
                        </button>
                    </div>
                    <button
                        class="flex items-center gap-2 px-4 py-2 bg-primary hover:bg-primary/90 text-white rounded-lg font-bold transition-all text-[11px] uppercase tracking-widest group ml-1">
                        <span class="material-icons text-[18px]">auto_awesome</span>
                        Ask Copilot
                    </button>
                </div>
            </main>

            <!-- Right Sidebar - AI Tools -->
            <aside
                class="w-80 bg-white dark:bg-slate-800 border-l border-slate-200 dark:border-slate-700 fixed right-0 h-full overflow-y-auto z-40 hidden xl:block">
                <div class="p-5 border-b border-slate-200 dark:border-slate-700 flex items-center justify-between">
                    <div class="flex items-center gap-2">
                        <span class="material-icons text-primary text-[20px]">auto_fix_high</span>
                        <h2 class="text-sm font-bold tracking-tight text-slate-800 dark:text-white">AI COPILOT</h2>
                    </div>
                    <button class="text-slate-400 hover:text-slate-600 transition-colors">
                        <span class="material-icons text-[20px]">close</span>
                    </button>
                </div>
                <div class="flex-1 py-6 px-4 space-y-8">
                    <section>
                        <div class="flex items-center justify-between mb-4 px-1">
                            <h3 class="text-[11px] font-bold uppercase tracking-[0.1em] text-slate-500">Spellcheck &amp;
                                Grammar</h3>
                            <span class="ai-badge bg-rose-500/10 text-rose-500">3 Issues</span>
                        </div>
                        <div class="space-y-3">
                            <div
                                class="p-3 bg-slate-50 dark:bg-slate-900 border border-slate-200 dark:border-slate-700 rounded-lg">
                                <p class="text-[11px] text-slate-500 mb-1">Potential misspelling</p>
                                <p class="text-xs font-medium mb-3 text-slate-800 dark:text-slate-200">"...future of
                                    <span class="border-b border-rose-500 text-rose-500">tecnology</span>..."</p>
                                <div class="flex gap-2">
                                    <button
                                        class="text-[10px] bg-primary text-white px-3 py-1 rounded font-semibold uppercase tracking-wide">technology</button>
                                    <button
                                        class="text-[10px] text-slate-400 hover:text-slate-600 px-2 py-1 transition-colors">IGNORE</button>
                                </div>
                            </div>
                        </div>
                    </section>
                    <section>
                        <div class="flex items-center justify-between mb-4 px-1">
                            <h3 class="text-[11px] font-bold uppercase tracking-[0.1em] text-slate-500">SEO Optimizer
                            </h3>
                            <span class="ai-badge bg-emerald-500/10 text-emerald-500">Score: 84</span>
                        </div>
                        <div class="space-y-4 px-1">
                            <div>
                                <div class="flex items-center justify-between text-[11px] mb-2">
                                    <span class="text-slate-400">Keyword Density</span>
                                    <span class="text-emerald-500 font-bold uppercase">Optimal</span>
                                </div>
                                <div class="w-full bg-slate-100 dark:bg-slate-700 h-1.5 rounded-full overflow-hidden">
                                    <div class="bg-emerald-500 h-full w-[84%]"></div>
                                </div>
                            </div>
                            <div
                                class="p-3 bg-slate-50 dark:bg-slate-900 border border-slate-200 dark:border-slate-700 rounded-lg">
                                <div class="flex items-center gap-2 mb-1">
                                    <span class="material-icons text-primary text-[16px]">lightbulb</span>
                                    <p class="text-[11px] text-slate-400">Recommendation</p>
                                </div>
                                <p class="text-xs leading-relaxed text-slate-600 dark:text-slate-300">Add "Artificial
                                    Intelligence" to the first 100 words for better ranking.</p>
                            </div>
                        </div>
                    </section>
                    <section>
                        <div class="flex items-center justify-between mb-4 px-1">
                            <h3 class="text-[11px] font-bold uppercase tracking-[0.1em] text-slate-500">Tone Analyzer
                            </h3>
                            <span class="ai-badge bg-primary/10 text-primary">Balanced</span>
                        </div>
                        <div class="grid grid-cols-2 gap-3">
                            <div
                                class="p-3 bg-slate-50 dark:bg-slate-900 border border-slate-200 dark:border-slate-700 rounded-lg flex flex-col items-center justify-center text-center">
                                <span class="text-primary text-lg font-bold">72%</span>
                                <span
                                    class="text-[9px] text-slate-500 uppercase font-bold tracking-tighter">Professional</span>
                            </div>
                            <div
                                class="p-3 bg-slate-50 dark:bg-slate-900 border border-slate-200 dark:border-slate-700 rounded-lg flex flex-col items-center justify-center text-center">
                                <span class="text-amber-500 text-lg font-bold">18%</span>
                                <span
                                    class="text-[9px] text-slate-500 uppercase font-bold tracking-tighter">Urgent</span>
                            </div>
                        </div>
                    </section>
                </div>
                <div class="p-4 border-t border-slate-200 dark:border-slate-700 mt-auto">
                    <button
                        class="w-full flex items-center justify-center gap-2 py-2 text-xs font-bold text-slate-500 hover:text-primary transition-colors uppercase tracking-widest">
                        <span class="material-icons text-[18px]">settings_suggest</span>
                        Copilot Config
                    </button>
                </div>
            </aside>
        </div>
    </body>

    </html>