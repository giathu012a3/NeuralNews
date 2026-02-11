<!DOCTYPE html>
<html class="dark" lang="en">

<head>
    <title>Account Settings - NexusAI</title>
    <jsp:include page="components/head.jsp" />
</head>

<body
    class="bg-background-light dark:bg-background-dark text-text-main dark:text-white font-display antialiased overflow-x-hidden transition-colors duration-200">
    <div class="flex min-h-screen w-full flex-col">
        <jsp:include page="components/header.jsp" />

        <main class="flex-1 w-full max-w-[1440px] mx-auto p-4 lg:p-8 flex flex-col lg:flex-row gap-8">
            <jsp:include page="components/sidebar.jsp" />

            <div class="flex-1 flex flex-col gap-8">
                <div class="flex items-center justify-between">
                    <div>
                        <h1 class="text-2xl font-black text-slate-900 dark:text-white tracking-tight">Account Settings
                        </h1>
                        <p class="text-sm text-slate-500 dark:text-slate-400">Manage your profile information and
                            preferences.</p>
                    </div>
                    <div class="flex items-center gap-3">
                        <button
                            class="px-4 py-2 text-sm font-bold text-slate-600 dark:text-slate-400 hover:bg-slate-100 dark:hover:bg-surface-dark rounded-lg transition-colors">Cancel</button>
                        <button
                            class="px-6 py-2 text-sm font-bold bg-primary text-white rounded-lg hover:bg-primary-dark shadow-lg shadow-primary/20 transition-all">Save
                            Changes</button>
                    </div>
                </div>
                <div class="space-y-6">
                    <section
                        class="bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-2xl p-6 md:p-8">
                        <div class="flex items-center gap-2 mb-8">
                            <span class="material-symbols-outlined text-primary">person</span>
                            <h3 class="font-bold text-lg text-slate-900 dark:text-white">Profile Information</h3>
                        </div>
                        <div class="flex flex-col md:flex-row gap-8 items-start">
                            <div class="flex flex-col items-center gap-4">
                                <div class="relative group">
                                    <div
                                        class="size-32 rounded-2xl bg-slate-200 overflow-hidden border-4 border-slate-50 dark:border-slate-800 shadow-md">
                                        <div class="size-full bg-cover bg-center"
                                            style="background-image: url('https://lh3.googleusercontent.com/aida-public/AB6AXuCqHJoDOZXEs2I-dWg4cNlhnZWUAg-oBJGZBmq-PpFoJ50SV0NIa98rHAwe3bxy50vyDTw8NHXXjoiNAgpWnLDQFnXhwjbF1AjVEqM11aGgAOtWj5SSP8yDkoQK1AtowhO1u68BOZOlFIT9MNofGpAlZ3JqZTUDZnPnJXrW2cjFXP9ywq1Un_lnbETpHo9rOZaGlocLFlhstxpM83Zzw8q542F04tYAv4jhfi5wKUicr1qd6_Lz2OKuF66ucETPy-Se0VxXmBa0LSQo');">
                                        </div>
                                    </div>
                                    <button
                                        class="absolute -bottom-2 -right-2 p-2 bg-primary text-white rounded-xl shadow-lg border-4 border-white dark:border-surface-dark hover:scale-110 transition-transform">
                                        <span class="material-symbols-outlined text-sm">photo_camera</span>
                                    </button>
                                </div>
                                <p class="text-xs text-slate-500 dark:text-slate-400 font-medium">Change Avatar</p>
                            </div>
                            <div class="flex-1 grid grid-cols-1 md:grid-cols-2 gap-6 w-full">
                                <div class="space-y-2">
                                    <label class="text-sm font-bold text-slate-700 dark:text-slate-300 ml-1">Full
                                        Name</label>
                                    <input
                                        class="w-full bg-slate-50 dark:bg-background-dark/50 border border-slate-200 dark:border-border-dark rounded-xl px-4 py-3 text-sm focus:ring-primary focus:border-primary transition-all"
                                        type="text" value="Alex Johnson" />
                                </div>
                                <div class="space-y-2">
                                    <label class="text-sm font-bold text-slate-700 dark:text-slate-300 ml-1">Email
                                        Address</label>
                                    <input
                                        class="w-full bg-slate-50 dark:bg-background-dark/50 border border-slate-200 dark:border-border-dark rounded-xl px-4 py-3 text-sm focus:ring-primary focus:border-primary transition-all"
                                        type="email" value="alex.johnson@nexusai.com" />
                                </div>
                                <div class="space-y-2">
                                    <label class="text-sm font-bold text-slate-700 dark:text-slate-300 ml-1">Phone
                                        Number</label>
                                    <input
                                        class="w-full bg-slate-50 dark:bg-background-dark/50 border border-slate-200 dark:border-border-dark rounded-xl px-4 py-3 text-sm focus:ring-primary focus:border-primary transition-all"
                                        type="tel" value="+1 (555) 000-1234" />
                                </div>
                                <div class="space-y-2">
                                    <label class="text-sm font-bold text-slate-700 dark:text-slate-300 ml-1">Bio</label>
                                    <textarea
                                        class="w-full bg-slate-50 dark:bg-background-dark/50 border border-slate-200 dark:border-border-dark rounded-xl px-4 py-3 text-sm focus:ring-primary focus:border-primary transition-all"
                                        rows="1">Tech enthusiast and avid reader of global politics.</textarea>
                                </div>
                            </div>
                        </div>
                    </section>
                    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                        <section
                            class="bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-2xl p-6">
                            <div class="flex items-center gap-2 mb-6">
                                <span class="material-symbols-outlined text-primary">translate</span>
                                <h3 class="font-bold text-lg text-slate-900 dark:text-white">Language &amp; Region</h3>
                            </div>
                            <div class="space-y-4">
                                <div class="space-y-2">
                                    <label
                                        class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Display
                                        Language</label>
                                    <select
                                        class="w-full bg-slate-50 dark:bg-background-dark/50 border border-slate-200 dark:border-border-dark rounded-xl px-4 py-3 text-sm focus:ring-primary focus:border-primary transition-all">
                                        <option selected="">English (US)</option>
                                        <option>Spanish</option>
                                        <option>French</option>
                                        <option>German</option>
                                        <option>Mandarin</option>
                                    </select>
                                </div>
                                <div class="space-y-2">
                                    <label
                                        class="text-xs font-bold text-slate-500 dark:text-slate-400 uppercase tracking-wider">Regional
                                        Feed</label>
                                    <select
                                        class="w-full bg-slate-50 dark:bg-background-dark/50 border border-slate-200 dark:border-border-dark rounded-xl px-4 py-3 text-sm focus:ring-primary focus:border-primary transition-all">
                                        <option selected="">North America</option>
                                        <option>Europe</option>
                                        <option>Asia Pacific</option>
                                        <option>Global</option>
                                    </select>
                                </div>
                            </div>
                        </section>
                        <section
                            class="bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-2xl p-6">
                            <div class="flex items-center gap-2 mb-6">
                                <span class="material-symbols-outlined text-primary">mail</span>
                                <h3 class="font-bold text-lg text-slate-900 dark:text-white">Email Subscriptions</h3>
                            </div>
                            <div class="space-y-4">
                                <label
                                    class="flex items-center justify-between p-3 rounded-xl hover:bg-slate-50 dark:hover:bg-background-dark/50 transition-colors cursor-pointer border border-transparent hover:border-slate-100 dark:hover:border-border-dark">
                                    <div class="flex flex-col">
                                        <span class="text-sm font-bold text-slate-800 dark:text-slate-200">Daily
                                            Digest</span>
                                        <span class="text-xs text-slate-500">The top AI-curated news every
                                            morning.</span>
                                    </div>
                                    <input checked="" class="rounded text-primary focus:ring-primary size-5"
                                        type="checkbox" />
                                </label>
                                <label
                                    class="flex items-center justify-between p-3 rounded-xl hover:bg-slate-50 dark:hover:bg-background-dark/50 transition-colors cursor-pointer border border-transparent hover:border-slate-100 dark:hover:border-border-dark">
                                    <div class="flex flex-col">
                                        <span class="text-sm font-bold text-slate-800 dark:text-slate-200">Tech
                                            Weekly</span>
                                        <span class="text-xs text-slate-500">Deep dives into emerging
                                            technologies.</span>
                                    </div>
                                    <input checked="" class="rounded text-primary focus:ring-primary size-5"
                                        type="checkbox" />
                                </label>
                                <label
                                    class="flex items-center justify-between p-3 rounded-xl hover:bg-slate-50 dark:hover:bg-background-dark/50 transition-colors cursor-pointer border border-transparent hover:border-slate-100 dark:hover:border-border-dark">
                                    <div class="flex flex-col">
                                        <span class="text-sm font-bold text-slate-800 dark:text-slate-200">Product
                                            Updates</span>
                                        <span class="text-xs text-slate-500">New features and platform
                                            improvements.</span>
                                    </div>
                                    <input class="rounded text-primary focus:ring-primary size-5" type="checkbox" />
                                </label>
                            </div>
                        </section>
                    </div>
                </div>
                <div
                    class="bg-gradient-to-r from-slate-900 to-primary-dark border border-white/10 rounded-2xl p-8 relative overflow-hidden group">
                    <div
                        class="absolute top-0 right-0 p-12 opacity-10 pointer-events-none group-hover:scale-110 transition-transform duration-700">
                        <span class="material-symbols-outlined text-[160px]">edit_note</span>
                    </div>
                    <div class="relative z-10">
                        <div class="flex flex-col md:flex-row md:items-center justify-between gap-8">
                            <div class="max-w-xl">
                                <span
                                    class="inline-flex items-center gap-1.5 px-3 py-1 bg-primary/20 backdrop-blur-md text-blue-400 text-[10px] font-bold uppercase tracking-widest rounded-full mb-4 border border-primary/30">
                                    <span class="material-symbols-outlined text-[14px]">stars</span>
                                    Nexus Creator Program
                                </span>
                                <h2 class="text-3xl md:text-4xl font-black text-white mb-4 tracking-tight">Become a
                                    Nexus Journalist</h2>
                                <p class="text-lg text-blue-100/90 mb-2 font-medium">Reach millions of readers with our
                                    next-gen news platform.</p>
                            </div>
                            <div class="shrink-0 flex flex-col items-center gap-4">
                                <button
                                    class="w-full md:w-auto px-10 py-4 bg-white text-primary-dark font-black text-lg rounded-xl shadow-xl shadow-black/20 hover:bg-cyan-50 hover:text-primary hover:shadow-cyan-400/20 hover:scale-105 active:scale-95 transition-all duration-300">
                                    Apply Now
                                </button>
                                <p class="text-xs text-blue-200/60 font-medium">Application takes &lt; 5 minutes</p>
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