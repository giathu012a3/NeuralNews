<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <jsp:include page="components/head.jsp" />
        <title>Visual Layout Editor | NexusAI Admin</title>
        <style>
            .source-item {
                cursor: grab;
            }

            .source-item:active {
                cursor: grabbing;
            }

            .drop-zone {
                min-height: 400px;
                background-image: radial-gradient(#cbd5e1 1px, transparent 1px);
                background-size: 20px 20px;
                transition: all 0.2s;
            }

            .drop-zone.drag-over {
                background-color: rgba(59, 130, 246, 0.05);
                border: 2px dashed #3b82f6;
            }

            /* Preview Component Styles */
            .preview-component {
                position: relative;
                transition: all 0.2s;
            }

            .preview-component:hover {
                box-shadow: 0 0 0 2px #3b82f6;
            }

            .preview-component .actions {
                display: none;
                position: absolute;
                top: -12px;
                right: 10px;
                background: white;
                border-radius: 6px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                padding: 2px;
                z-index: 10;
            }

            .preview-component:hover .actions {
                display: flex;
            }

            /* Mock Skeleton Loaders for Preview */
            .skeleton {
                @apply bg-slate-200 dark:bg-slate-700 animate-pulse rounded;
            }
        </style>
    </head>

    <body class="bg-dashboard-bg dark:bg-background-dark font-sans text-slate-800 dark:text-slate-100 overflow-hidden">
        <div class="flex h-screen overflow-hidden">
            <jsp:include page="components/sidebar.jsp">
                <jsp:param name="activePage" value="layout" />
            </jsp:include>

            <main class="flex-1 ml-64 flex flex-col min-w-0 bg-dashboard-bg dark:bg-slate-900 overflow-hidden">
                <!-- Header -->
                <header
                    class="bg-white dark:bg-slate-800 px-6 py-3 flex items-center justify-between border-b border-slate-200 dark:border-slate-700 shrink-0">
                    <div>
                        <p class="text-[10px] font-bold text-slate-400 uppercase tracking-widest">Visual Editor</p>
                        <h2 class="text-xl font-bold text-slate-800 dark:text-white">Homepage Builder</h2>
                    </div>
                    <div class="flex items-center gap-3">
                        <button onclick="resetCanvas()"
                            class="text-xs font-bold text-slate-500 hover:text-red-500 transition-colors">Reset</button>
                        <button
                            class="px-5 py-2 bg-primary text-white text-sm font-bold rounded-lg shadow-md hover:bg-primary/90 transition-all flex items-center gap-2">
                            <span class="material-symbols-outlined text-[18px]">save</span> Save Layout
                        </button>
                    </div>
                </header>

                <div class="flex-1 flex overflow-hidden">
                    <!-- Sidebar Tools -->
                    <aside
                        class="w-64 bg-white dark:bg-slate-800 border-r border-slate-200 dark:border-slate-700 overflow-y-auto p-4 shrink-0 z-10">
                        <h3 class="text-xs font-bold text-slate-400 uppercase tracking-widest mb-4">Components</h3>

                        <div class="space-y-3">
                            <!-- Tool: Hero -->
                            <div draggable="true" ondragstart="handleDragStart(event)" data-type="HERO"
                                class="source-item p-3 border border-slate-200 dark:border-slate-700 rounded-lg hover:border-primary hover:shadow-md bg-slate-50 dark:bg-slate-900 transition-all">
                                <div class="flex items-center gap-3 pointer-events-none">
                                    <span class="material-symbols-outlined text-indigo-500">view_carousel</span>
                                    <div>
                                        <p class="text-sm font-bold">Hero Slider</p>
                                        <p class="text-[10px] text-slate-400">Main features</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Tool: Grid -->
                            <div draggable="true" ondragstart="handleDragStart(event)" data-type="GRID"
                                class="source-item p-3 border border-slate-200 dark:border-slate-700 rounded-lg hover:border-primary hover:shadow-md bg-slate-50 dark:bg-slate-900 transition-all">
                                <div class="flex items-center gap-3 pointer-events-none">
                                    <span class="material-symbols-outlined text-blue-500">grid_view</span>
                                    <div>
                                        <p class="text-sm font-bold">News Grid</p>
                                        <p class="text-[10px] text-slate-400">Rows & Columns</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Tool: List -->
                            <div draggable="true" ondragstart="handleDragStart(event)" data-type="LIST"
                                class="source-item p-3 border border-slate-200 dark:border-slate-700 rounded-lg hover:border-primary hover:shadow-md bg-slate-50 dark:bg-slate-900 transition-all">
                                <div class="flex items-center gap-3 pointer-events-none">
                                    <span class="material-symbols-outlined text-green-500">view_list</span>
                                    <div>
                                        <p class="text-sm font-bold">Vertical List</p>
                                        <p class="text-[10px] text-slate-400">Traditional Feed</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Tool: HTML -->
                            <div draggable="true" ondragstart="handleDragStart(event)" data-type="HTML"
                                class="source-item p-3 border border-slate-200 dark:border-slate-700 rounded-lg hover:border-primary hover:shadow-md bg-slate-50 dark:bg-slate-900 transition-all">
                                <div class="flex items-center gap-3 pointer-events-none">
                                    <span class="material-symbols-outlined text-orange-500">code</span>
                                    <div>
                                        <p class="text-sm font-bold">Custom HTML</p>
                                        <p class="text-[10px] text-slate-400">Ad / Banner</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div
                            class="mt-8 p-4 bg-blue-50 dark:bg-blue-900/20 rounded-lg border border-blue-100 dark:border-blue-800">
                            <p class="text-xs text-blue-800 dark:text-blue-200 leading-relaxed">
                                <strong>Tip:</strong> Drag items from here to the right canvas to build your page.
                            </p>
                        </div>
                    </aside>

                    <!-- Canvas -->
                    <main class="flex-1 overflow-y-auto p-8 bg-slate-100 dark:bg-slate-900/50">
                        <div
                            class="max-w-4xl mx-auto bg-white dark:bg-slate-800 min-h-[800px] shadow-xl rounded-xl border border-slate-200 dark:border-slate-700 flex flex-col">
                            <!-- Mock Browser Header -->
                            <div
                                class="h-8 bg-slate-100 dark:bg-slate-700 border-b border-slate-200 dark:border-slate-600 rounded-t-xl flex items-center px-4 gap-2">
                                <div class="flex gap-1.5">
                                    <div class="w-2.5 h-2.5 rounded-full bg-red-400"></div>
                                    <div class="w-2.5 h-2.5 rounded-full bg-yellow-400"></div>
                                    <div class="w-2.5 h-2.5 rounded-full bg-green-400"></div>
                                </div>
                                <div
                                    class="mx-auto w-1/2 h-5 bg-white dark:bg-slate-800 rounded text-[10px] flex items-center justify-center text-slate-400 overflow-hidden">
                                    neuralnews.com
                                </div>
                            </div>

                            <!-- Drop Zone -->
                            <div id="canvas" ondragover="handleDragOver(event)" ondragleave="handleDragLeave(event)"
                                ondrop="handleDrop(event)" class="drop-zone flex-1 p-4 space-y-4">

                                <!-- Placeholder message -->
                                <div id="emptyState"
                                    class="h-full flex flex-col items-center justify-center text-slate-300 pointer-events-none mt-20">
                                    <span class="material-symbols-outlined text-6xl mb-4">drag_click</span>
                                    <p class="text-lg font-bold">Drag components here</p>
                                </div>

                            </div>
                        </div>
                    </main>
                </div>
            </main>
        </div>

        <script>
            // --- Drag & Drop Logic ---
            function handleDragStart(e) {
                e.dataTransfer.setData("type", e.target.dataset.type);
                e.dataTransfer.effectAllowed = "copy";
            }

            function handleDragOver(e) {
                e.preventDefault();
                e.currentTarget.classList.add('drag-over');
                e.dataTransfer.dropEffect = "copy";
            }

            function handleDragLeave(e) {
                e.currentTarget.classList.remove('drag-over');
            }

            function handleDrop(e) {
                e.preventDefault();
                const canvas = document.getElementById('canvas');
                canvas.classList.remove('drag-over');
                document.getElementById('emptyState').classList.add('hidden'); // Hide placeholder

                const type = e.dataTransfer.getData("type");
                const newComponent = createComponent(type);
                canvas.appendChild(newComponent);
            }

            // --- Component Factory ---
            function createComponent(type) {
                const div = document.createElement('div');
                div.className = "preview-component bg-white dark:bg-slate-900 border border-slate-100 dark:border-slate-700 rounded-lg p-2 group hover:ring-2 hover:ring-primary hover:border-transparent transition-all relative";

                let contentHtml = '';

                // Generate visual mockups based on type
                if (type === 'HERO') {
                    contentHtml = `
                    <div class="w-full h-48 bg-slate-200 dark:bg-slate-700 rounded animate-pulse flex items-center justify-center">
                        <span class="text-slate-400 font-bold text-2xl">HERO SLIDER</span>
                    </div>
                `;
                } else if (type === 'GRID') {
                    contentHtml = `
                    <div class="grid grid-cols-3 gap-2">
                        <div class="h-24 bg-slate-100 dark:bg-slate-800 rounded"></div>
                        <div class="h-24 bg-slate-100 dark:bg-slate-800 rounded"></div>
                        <div class="h-24 bg-slate-100 dark:bg-slate-800 rounded"></div>
                        <div class="h-24 bg-slate-100 dark:bg-slate-800 rounded"></div>
                        <div class="h-24 bg-slate-100 dark:bg-slate-800 rounded"></div>
                        <div class="h-24 bg-slate-100 dark:bg-slate-800 rounded"></div>
                    </div>
                `;
                } else if (type === 'LIST') {
                    contentHtml = `
                    <div class="space-y-2">
                        <div class="h-16 bg-slate-100 dark:bg-slate-800 rounded flex gap-2 p-1">
                            <div class="w-14 h-full bg-slate-200 dark:bg-slate-700 rounded"></div>
                            <div class="flex-1 space-y-1 py-1">
                                <div class="w-3/4 h-2 bg-slate-200 dark:bg-slate-700 rounded"></div>
                                <div class="w-1/2 h-2 bg-slate-200 dark:bg-slate-700 rounded"></div>
                            </div>
                        </div>
                         <div class="h-16 bg-slate-100 dark:bg-slate-800 rounded flex gap-2 p-1">
                            <div class="w-14 h-full bg-slate-200 dark:bg-slate-700 rounded"></div>
                            <div class="flex-1 space-y-1 py-1">
                                <div class="w-3/4 h-2 bg-slate-200 dark:bg-slate-700 rounded"></div>
                                <div class="w-1/2 h-2 bg-slate-200 dark:bg-slate-700 rounded"></div>
                            </div>
                        </div>
                    </div>
                `;
                } else if (type === 'HTML') {
                    contentHtml = `
                    <div class="w-full h-20 bg-orange-50 dark:bg-orange-900/20 border border-dashed border-orange-200 dark:border-orange-800 rounded flex items-center justify-center">
                        <span class="text-orange-400 font-mono text-xs">< HTML Embed /></span>
                    </div>
                `;
                }

                div.innerHTML = `
                <div class="actions">
                    <button class="p-1 hover:bg-slate-100 rounded text-slate-400 hover:text-red-500" onclick="this.closest('.preview-component').remove()">
                        <span class="material-symbols-outlined text-[16px]">delete</span>
                    </button>
                     <button class="p-1 hover:bg-slate-100 rounded text-slate-400 hover:text-primary" onclick="openSettings(this)">
                        <span class="material-symbols-outlined text-[16px]">settings</span>
                    </button>
                    <button class="p-1 hover:bg-slate-100 rounded text-slate-400 hover:text-slate-600 cursor-move">
                        <span class="material-symbols-outlined text-[16px]">drag_indicator</span>
                    </button>
                </div>
                <!-- Label -->
                <div class="mb-2 flex items-center justify-between">
                    <span class="text-[10px] bg-slate-100 dark:bg-slate-700 px-2 py-0.5 rounded font-bold uppercase text-slate-500">${type} Section</span>
                </div>
                ${contentHtml}
            `;

                return div;
            }

            function resetCanvas() {
                document.getElementById('canvas').innerHTML = `
                <div id="emptyState" class="h-full flex flex-col items-center justify-center text-slate-300 pointer-events-none mt-20">
                     <span class="material-symbols-outlined text-6xl mb-4">drag_click</span>
                     <p class="text-lg font-bold">Drag components here</p>
                 </div>
            `;
            }

            // --- Settings Modal Logic ---
            let currentComponent = null;

            function openSettings(btn) {
                currentComponent = btn.closest('.preview-component');
                const type = currentComponent.querySelector('span.uppercase').innerText.split(' ')[0]; // HERO, GRID...

                // Show/Hide fields based on type
                document.getElementById('gridSettings').style.display = type === 'GRID' ? 'block' : 'none';

                document.getElementById('settingsModal').showModal();
            }

            function saveSettings() {
                if (!currentComponent) return;

                const cols = document.getElementById('settingColumns').value;
                const limit = document.getElementById('settingLimit').value;
                const category = document.getElementById('settingCategory').value;

                // Update visual label to reflect changes
                const label = currentComponent.querySelector('span.uppercase');
                const type = label.innerText.split(' ')[0];

                let infoText = "";
                if (type === 'GRID') infoText = ` - ${category} (${cols} Cols)`;
                else if (type === 'LIST') infoText = ` - ${category} (List)`;

                label.innerText = type + " SECTION" + infoText;

                document.getElementById('settingsModal').close();
            }
        </script>

        <!-- Settings Modal -->
        <dialog id="settingsModal"
            class="modal bg-transparent p-0 backdrop:bg-black/50 backdrop:backdrop-blur-sm open:animate-fade-in">
            <div
                class="bg-white dark:bg-slate-800 rounded-2xl shadow-xl w-[400px] border border-slate-100 dark:border-slate-700 p-6">
                <h3 class="text-lg font-bold text-slate-800 dark:text-white mb-4">Component Settings</h3>

                <div class="space-y-4">
                    <div>
                        <label class="block text-xs font-bold text-slate-500 uppercase mb-2">Category Source</label>
                        <select id="settingCategory"
                            class="w-full px-3 py-2 rounded-lg bg-slate-50 dark:bg-slate-900 border border-slate-200 dark:border-slate-700">
                            <option>Technology</option>
                            <option>Politics</option>
                            <option>Health</option>
                            <option>Latest News</option>
                        </select>
                    </div>

                    <div id="gridSettings" class="hidden">
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label class="block text-xs font-bold text-slate-500 uppercase mb-2">Columns</label>
                                <input id="settingColumns" type="number" value="3"
                                    class="w-full px-3 py-2 rounded-lg border border-slate-200 dark:border-slate-700">
                            </div>
                            <div>
                                <label class="block text-xs font-bold text-slate-500 uppercase mb-2">Max Items</label>
                                <input id="settingLimit" type="number" value="6"
                                    class="w-full px-3 py-2 rounded-lg border border-slate-200 dark:border-slate-700">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="flex justify-end gap-2 mt-6">
                    <button onclick="document.getElementById('settingsModal').close()"
                        class="px-4 py-2 text-sm font-bold text-slate-500 hover:bg-slate-100 rounded-lg">Cancel</button>
                    <button onclick="saveSettings()"
                        class="px-4 py-2 text-sm font-bold bg-primary text-white rounded-lg shadow-md hover:bg-primary/90">Apply</button>
                </div>
            </div>
        </dialog>

    </html>