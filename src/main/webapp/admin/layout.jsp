<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <jsp:include page="components/head.jsp" />
        <title>Layout Customization | NexusAI Admin</title>
        <style>
            .canvas-drop-zone {
                background-image: url("data:image/svg+xml,%3csvg width='100%25' height='100%25' xmlns='http://www.w3.org/2000/svg'%3e%3crect width='100%25' height='100%25' fill='none' stroke='%23CBD5E1' stroke-width='2' stroke-dasharray='8%2c 8' stroke-dashoffset='0' stroke-linecap='square'/%3e%3c/svg%3e");
            }

            .wireframe-block {
                background: #ffffff;
                border: 1px solid #e2e8f0;
                box-shadow: 0 1px 3px rgba(0, 0, 0, 0.05);
            }

            .grab-handle {
                cursor: grab;
            }

            .grab-handle:active {
                cursor: grabbing;
            }
        </style>
    </head>

    <body
        class="bg-background-light dark:bg-background-dark font-sans text-slate-800 dark:text-slate-100 overflow-hidden">
        <div class="flex h-screen overflow-hidden">
            <jsp:include page="components/sidebar.jsp">
                <jsp:param name="activePage" value="layout" />
            </jsp:include>

            <main class="flex-1 ml-64 flex flex-col min-w-0 bg-dashboard-bg dark:bg-slate-900">
                <header
                    class="h-16 bg-white dark:bg-slate-800 border-b border-slate-200 dark:border-slate-700 px-6 flex items-center justify-between z-30">
                    <div class="flex items-center gap-4">
                        <h2 class="text-lg font-bold text-slate-800 dark:text-white">Homepage Layout</h2>
                        <div class="h-6 w-px bg-slate-200 dark:bg-slate-700"></div>
                        <div class="flex items-center gap-3">
                            <span class="text-sm font-medium text-slate-500">AI Smart Layout</span>
                            <button
                                class="relative inline-flex h-6 w-11 flex-shrink-0 cursor-pointer rounded-full border-2 border-transparent transition-colors duration-200 ease-in-out focus:outline-none bg-primary">
                                <span
                                    class="translate-x-5 pointer-events-none inline-block h-5 w-5 transform rounded-full bg-white shadow ring-0 transition duration-200 ease-in-out"></span>
                            </button>
                        </div>
                    </div>
                    <div class="flex items-center gap-3">
                        <button
                            class="px-4 py-2 text-sm font-medium text-slate-600 hover:text-slate-800 dark:text-slate-400 dark:hover:text-white transition-colors">Reset
                            to Default</button>
                        <button
                            class="px-4 py-2 text-sm font-medium text-slate-600 border border-slate-200 dark:border-slate-700 dark:text-slate-400 rounded-lg hover:bg-slate-50 dark:hover:bg-slate-700 transition-all flex items-center gap-2">
                            <span class="material-icons text-sm">visibility</span> Preview
                        </button>
                        <button
                            class="px-6 py-2 bg-primary text-white text-sm font-bold rounded-lg shadow-md shadow-primary/20 hover:bg-primary/90 transition-all">Save
                            Changes</button>
                    </div>
                </header>
                <div class="flex-1 flex overflow-hidden">
                    <aside
                        class="w-1/5 bg-white dark:bg-slate-800 border-r border-slate-200 dark:border-slate-700 overflow-y-auto p-4">
                        <h3 class="text-xs font-bold text-slate-400 uppercase tracking-widest mb-4">Component Library
                        </h3>
                        <div class="space-y-3">
                            <div
                                class="p-4 border border-slate-200 dark:border-slate-700 rounded-xl bg-slate-50 dark:bg-slate-900/50 cursor-move hover:border-primary transition-all group">
                                <div class="flex items-center gap-3">
                                    <span
                                        class="material-icons text-slate-400 group-hover:text-primary">featured_play_list</span>
                                    <span class="text-sm font-semibold">Hero Section</span>
                                </div>
                            </div>
                            <div
                                class="p-4 border border-slate-200 dark:border-slate-700 rounded-xl bg-slate-50 dark:bg-slate-900/50 cursor-move hover:border-primary transition-all group">
                                <div class="flex items-center gap-3">
                                    <span
                                        class="material-icons text-slate-400 group-hover:text-primary">view_list</span>
                                    <span class="text-sm font-semibold">Category List</span>
                                </div>
                            </div>
                            <div
                                class="p-4 border border-slate-200 dark:border-slate-700 rounded-xl bg-slate-50 dark:bg-slate-900/50 cursor-move hover:border-primary transition-all group">
                                <div class="flex items-center gap-3">
                                    <span
                                        class="material-icons text-slate-400 group-hover:text-primary">view_carousel</span>
                                    <span class="text-sm font-semibold">Image Slider</span>
                                </div>
                            </div>
                            <div
                                class="p-4 border border-slate-200 dark:border-slate-700 rounded-xl bg-slate-50 dark:bg-slate-900/50 cursor-move hover:border-primary transition-all group">
                                <div class="flex items-center gap-3">
                                    <span class="material-icons text-slate-400 group-hover:text-primary">ad_units</span>
                                    <span class="text-sm font-semibold">Ad Banner</span>
                                </div>
                            </div>
                            <div
                                class="p-4 border border-slate-200 dark:border-slate-700 rounded-xl bg-slate-50 dark:bg-slate-900/50 cursor-move hover:border-primary transition-all group">
                                <div class="flex items-center gap-3">
                                    <span
                                        class="material-icons text-slate-400 group-hover:text-primary">play_circle</span>
                                    <span class="text-sm font-semibold">Video News</span>
                                </div>
                            </div>
                        </div>
                        <div class="mt-8">
                            <p class="text-[10px] text-slate-400 italic">Drag and drop components to the center canvas
                                to build
                                your homepage.</p>
                        </div>
                    </aside>
                    <main class="w-3/5 p-8 overflow-y-auto bg-slate-100 dark:bg-slate-900/30">
                        <div class="max-w-3xl mx-auto space-y-4">
                            <div class="wireframe-block rounded-lg p-4 relative ring-2 ring-primary">
                                <div class="flex items-center justify-between mb-4 border-b border-slate-100 pb-2">
                                    <div class="flex items-center gap-2">
                                        <span class="material-icons text-slate-400 grab-handle">drag_indicator</span>
                                        <span class="text-xs font-bold uppercase text-primary tracking-wider">Hero
                                            Section</span>
                                    </div>
                                    <div class="flex gap-1">
                                        <button class="p-1 text-slate-400 hover:text-slate-600"><span
                                                class="material-icons text-sm">visibility_off</span></button>
                                        <button class="p-1 text-slate-400 hover:text-red-500"><span
                                                class="material-icons text-sm">delete</span></button>
                                    </div>
                                </div>
                                <div
                                    class="h-40 bg-slate-50 dark:bg-slate-800 rounded flex items-center justify-center">
                                    <span class="material-icons text-slate-300 text-5xl">image</span>
                                </div>
                            </div>
                            <div class="wireframe-block rounded-lg p-4 relative">
                                <div class="flex items-center justify-between mb-2">
                                    <div class="flex items-center gap-2">
                                        <span class="material-icons text-slate-300 grab-handle">drag_indicator</span>
                                        <span class="text-xs font-bold uppercase text-slate-400 tracking-wider">Ad
                                            Banner
                                            (Full Width)</span>
                                    </div>
                                    <div class="flex gap-1">
                                        <button class="p-1 text-slate-400 hover:text-red-500"><span
                                                class="material-icons text-sm">delete</span></button>
                                    </div>
                                </div>
                                <div
                                    class="h-16 bg-slate-50 dark:bg-slate-800 rounded border border-dashed border-slate-200 dark:border-slate-700 flex items-center justify-center">
                                    <span class="text-xs text-slate-400 font-medium">ADVERTISEMENT SPACE</span>
                                </div>
                            </div>
                            <div class="wireframe-block rounded-lg p-4 relative">
                                <div class="flex items-center justify-between mb-4">
                                    <div class="flex items-center gap-2">
                                        <span class="material-icons text-slate-300 grab-handle">drag_indicator</span>
                                        <span class="text-xs font-bold uppercase text-slate-400 tracking-wider">Category
                                            List: Technology</span>
                                    </div>
                                    <div class="flex gap-1">
                                        <button class="p-1 text-slate-400 hover:text-red-500"><span
                                                class="material-icons text-sm">delete</span></button>
                                    </div>
                                </div>
                                <div class="grid grid-cols-3 gap-3">
                                    <div class="h-24 bg-slate-50 dark:bg-slate-800 rounded"></div>
                                    <div class="h-24 bg-slate-50 dark:bg-slate-800 rounded"></div>
                                    <div class="h-24 bg-slate-50 dark:bg-slate-800 rounded"></div>
                                </div>
                            </div>
                            <div
                                class="canvas-drop-zone h-32 rounded-lg flex items-center justify-center flex-col gap-2">
                                <span class="material-icons text-slate-300 text-3xl">add_circle_outline</span>
                                <span class="text-sm font-medium text-slate-400">Drop components here</span>
                            </div>
                        </div>
                    </main>
                    <aside
                        class="w-1/5 bg-white dark:bg-slate-800 border-l border-slate-200 dark:border-slate-700 overflow-y-auto p-6">
                        <div class="flex items-center justify-between mb-6">
                            <h3 class="text-xs font-bold text-slate-400 uppercase tracking-widest">Property Editor</h3>
                            <span
                                class="text-[10px] bg-primary/10 text-primary px-2 py-0.5 rounded-full font-bold">HERO</span>
                        </div>
                        <div class="space-y-6">
                            <div>
                                <label
                                    class="block text-xs font-bold text-slate-600 dark:text-slate-400 uppercase mb-2">Display
                                    Category</label>
                                <select
                                    class="w-full bg-slate-50 dark:bg-slate-900 border-slate-200 dark:border-slate-700 rounded-lg text-sm focus:ring-primary focus:border-primary">
                                    <option>Breaking News</option>
                                    <option>World Events</option>
                                    <option>Technology</option>
                                    <option>AI Trends</option>
                                </select>
                            </div>
                            <div>
                                <div class="flex justify-between items-center mb-2">
                                    <label
                                        class="block text-xs font-bold text-slate-600 dark:text-slate-400 uppercase">Article
                                        Count</label>
                                    <span class="text-xs font-bold text-primary">5</span>
                                </div>
                                <input
                                    class="w-full h-2 bg-slate-100 dark:bg-slate-700 rounded-lg appearance-none cursor-pointer accent-primary"
                                    max="10" min="1" type="range" value="5" />
                                <div class="flex justify-between text-[10px] text-slate-400 mt-1">
                                    <span>1</span>
                                    <span>10</span>
                                </div>
                            </div>
                            <div>
                                <label
                                    class="block text-xs font-bold text-slate-600 dark:text-slate-400 uppercase mb-3">Display
                                    Style</label>
                                <div
                                    class="flex bg-slate-50 dark:bg-slate-900 p-1 rounded-lg border border-slate-200 dark:border-slate-700">
                                    <button
                                        class="flex-1 py-1.5 text-xs font-bold rounded-md bg-white dark:bg-slate-800 shadow-sm text-primary">Grid</button>
                                    <button
                                        class="flex-1 py-1.5 text-xs font-bold text-slate-400 hover:text-slate-600">Slider</button>
                                    <button
                                        class="flex-1 py-1.5 text-xs font-bold text-slate-400 hover:text-slate-600">List</button>
                                </div>
                            </div>
                            <div class="pt-6 border-t border-slate-100 dark:border-slate-700">
                                <label class="flex items-center gap-3 cursor-pointer">
                                    <input checked="" class="rounded text-primary focus:ring-primary h-4 w-4"
                                        type="checkbox" />
                                    <span class="text-sm font-medium text-slate-600 dark:text-slate-300">Show Date &amp;
                                        Time</span>
                                </label>
                            </div>
                            <div>
                                <label class="flex items-center gap-3 cursor-pointer">
                                    <input class="rounded text-primary focus:ring-primary h-4 w-4" type="checkbox" />
                                    <span class="text-sm font-medium text-slate-600 dark:text-slate-300">Enable
                                        Auto-refresh</span>
                                </label>
                            </div>
                            <div
                                class="mt-8 p-4 bg-blue-50 dark:bg-blue-900/20 rounded-xl border border-blue-100 dark:border-blue-900/30">
                                <div class="flex items-center gap-2 mb-2">
                                    <span class="material-icons text-primary text-sm">auto_awesome</span>
                                    <span class="text-xs font-bold text-primary">AI Optimization</span>
                                </div>
                                <p class="text-[10px] text-slate-600 dark:text-slate-400 leading-relaxed">
                                    AI has optimized this section for peak morning engagement (07:00 - 10:00).
                                </p>
                            </div>
                        </div>
                    </aside>
                </div>
            </main>
        </div>
    </body>

    </html>