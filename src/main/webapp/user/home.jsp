<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="neuralnews.model.Article_Model" %>
<%@ page import="neuralnews.dao.Article_Dao" %>

    <!DOCTYPE html>
    <html class="dark" lang="en">

    <head>
        <title>Trang chủ Tin tức AI</title>
        <jsp:include page="components/head.jsp" />
    </head>

    <body
        class="bg-background-light dark:bg-background-dark text-text-main dark:text-white font-display antialiased overflow-x-hidden transition-colors duration-200">
        <div class="flex min-h-screen w-full flex-col">
            <jsp:include page="components/header.jsp" />

            <main class="flex-1 w-full max-w-[1440px] mx-auto p-4 lg:p-8 grid grid-cols-1 lg:grid-cols-12 gap-8">
                <div class="lg:col-span-8 flex flex-col gap-10">
                    <section class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    
			                    <% 
			    Article_Model featured = (Article_Model) request.getAttribute("featuredArt"); 
			    if(featured != null) {
			%>
                    
                        <article onclick="window.location.href='user/article?id=<%= featured.getId() %>'"
                            class="relative md:col-span-2 lg:col-span-1 xl:col-span-1 h-[450px] rounded-xl overflow-hidden group cursor-pointer shadow-sm hover:shadow-md transition-shadow">
                            <div class="absolute inset-0 bg-cover bg-center transition-transform duration-700 group-hover:scale-105"
                                style="background-image: url('<%= featured.getImageUrl() %>');">
                            </div>
                            <div class="absolute inset-0 bg-gradient-to-t from-black/90 via-black/40 to-transparent">
                            </div>
                            <div class="absolute bottom-0 left-0 p-6 w-full">
                                <span
                                    class="inline-block px-2.5 py-0.5 rounded bg-primary text-white text-[10px] font-bold uppercase tracking-wider mb-3">Nổi
                                    bật</span>
                                <h2
                                    class="text-2xl md:text-3xl font-bold text-white leading-tight mb-2 group-hover:text-blue-100 transition-colors">
                                    <%= featured.getTitle() %></h2>
                                <p class="text-slate-300 text-sm line-clamp-2 mb-4 hidden md:block">
                                    <%= featured.getSummary() %>
                                </p>
                                <div class="flex items-center text-xs text-slate-400 gap-3">
                                    <span class="flex items-center gap-1"><span
                                            class="material-symbols-outlined text-sm">schedule</span> featured.getCreatedAt</span>
                                    <span class="flex items-center gap-1"><span
                                            class="material-symbols-outlined text-sm">visibility</span> 14k</span>
                                </div>
                            </div>
                        </article>
                        
		<% 
        }
 %>
   
                        <div class="flex flex-col gap-4 h-[450px]">
                        
			                        <% 
			        List<Article_Model> subArts = (List<Article_Model>) request.getAttribute("subFeaturedArts");
			        if(subArts != null) {
			            for(Article_Model art : subArts) {
			    %>
                        
                            <article
                                onclick="window.location.href='user/article?id=<%= art.getId() %>'"
                                class="flex-1 flex gap-4 bg-white dark:bg-surface-dark p-3 rounded-lg border border-border-light dark:border-border-dark hover:border-primary/50 transition-colors cursor-pointer group">
                                <div class="w-1/3 h-full rounded-md overflow-hidden bg-slate-100">
                                    <div class="w-full h-full bg-cover bg-center"
                                        style="background-image: url('<%= art.getImageUrl() %>');">
                                    </div>
                                </div>
                                <div class="w-2/3 flex flex-col justify-center">
                                    <span class="text-[10px] font-bold text-primary uppercase mb-1"><%= art.getCategoryName() %></span>
                                    <h3
                                        class="text-sm font-bold text-slate-900 dark:text-white leading-snug group-hover:text-primary transition-colors line-clamp-2">
                                        <%= art.getTitle() %></h3>
                                </div>
                            </article>
                            
                            <% 
            }
        } 
    %>
                                  
                        </div>
                    </section>
                    <div class="h-px w-full bg-slate-200 dark:bg-slate-700"></div>
                    <section>
                        <div class="flex items-center justify-between mb-6">
                            <h3 class="text-xl font-bold flex items-center gap-2 text-slate-900 dark:text-white">
                                <span class="w-1.5 h-6 bg-primary rounded-full"></span>
                                Cập nhật mới nhất
                            </h3>
                            <div class="flex gap-2 text-sm text-slate-500">
                                <span class="cursor-pointer hover:text-primary font-medium">Thịnh hành</span>
                                <span class="text-slate-300">|</span>
                                <span class="cursor-pointer hover:text-primary font-medium">Bàn luận nhiều nhất</span>
                            </div>
                        </div>
                        <div class="flex flex-col gap-6">
                        
						<% 
						    List<Article> latest = (List<Article>) request.getAttribute("latestArtsWithCat");
						if(latest != null && !latest.isEmpty()) {
					        for(Article art : latest) {
					%>
					
                            <article
                                onclick="window.location.href='user/article?id=<%= art.getId() %>'"
                                class="flex flex-col sm:flex-row gap-5 bg-white dark:bg-surface-dark p-4 rounded-xl border border-slate-100 dark:border-border-dark hover:shadow-lg hover:border-primary/30 transition-all duration-300 group">
                                <div class="sm:w-56 h-40 shrink-0 rounded-lg overflow-hidden relative">
                                    <div
                                        class="absolute top-2 left-2 bg-black/60 backdrop-blur-sm text-white text-[10px] font-bold px-2 py-0.5 rounded">
                                        <%= art.getCategoryName() %></div>
                                    <div class="w-full h-full bg-cover bg-center transition-transform duration-500 group-hover:scale-105"
                                        style="background-image: url('<%= art.getImageUrl() %>');">
                                    </div>
                                </div>
                                <div class="flex flex-col flex-1 justify-between py-1">
                                    <div>
                                        <h3
                                            class="text-lg font-bold text-slate-900 dark:text-white mb-2 group-hover:text-primary transition-colors leading-snug">
                                            <%= art.getTitle() %>
                                        </h3>
                                        <p class="text-slate-600 dark:text-slate-400 text-sm line-clamp-2 mb-3">
                                            <%= art.getSummary() %></p>
                                        </p>
                                    </div>
                                    <div
                                        class="flex items-center justify-between text-xs text-slate-400 border-t border-slate-100 dark:border-slate-800 pt-3">
                                        <div class="flex items-center gap-4">
                                            <span class="flex items-center gap-1"><span
                                                    class="material-symbols-outlined text-sm">calendar_today</span> featured.getCreatedAt</span>
                                            <span class="flex items-center gap-1"><span
                                                    class="material-symbols-outlined text-sm">schedule</span> 5 min
                                                read</span>
                                        </div>
                                        <button class="text-slate-400 hover:text-primary"><span
                                                class="material-symbols-outlined text-lg">bookmark_add</span></button>
                                    </div>
                                </div>
                            </article>
                            
							<% 
					        }
					    } 
					 %>
                            
                        </div>
                        <button
                            class="w-full py-3 mt-8 text-sm font-semibold text-primary border border-primary/20 rounded-lg hover:bg-primary/5 transition-colors flex items-center justify-center gap-2">
                            Tải thêm bài viết
                            <span class="material-symbols-outlined text-lg">expand_more</span>
                        </button>
                    </section>
                </div>
                <aside class="lg:col-span-4 flex flex-col gap-8">
                    <div
                        class="bg-gradient-to-br from-primary to-primary-dark rounded-xl p-5 text-white shadow-lg relative overflow-hidden">
                        <div class="absolute top-0 right-0 p-8 opacity-10">
                            <span class="material-symbols-outlined text-9xl">cloud</span>
                        </div>
                        <div class="relative z-10 flex justify-between items-start mb-4">
                            <div>
                                <p class="text-blue-100 text-xs font-medium uppercase tracking-wider mb-1">Thời tiết địa
                                    phương</p>
                                <h3 class="text-2xl font-bold">San Francisco</h3>
                                <div class="flex items-center gap-2 mt-1">
                                    <span class="text-4xl font-light">72°</span>
                                    <div class="flex flex-col text-xs text-blue-100">
                                        <span>Nắng</span>
                                        <span>C:75° T:62°</span>
                                    </div>
                                </div>
                            </div>
                            <span class="material-symbols-outlined text-4xl text-yellow-300">sunny</span>
                        </div>
                        <div class="relative z-10 pt-4 border-t border-white/20">
                            <div class="flex justify-between items-center text-sm">
                                <span class="font-medium">USD/EUR</span>
                                <span class="font-bold">0.94 <span class="text-green-300 text-xs">▲ +0.1%</span></span>
                            </div>
                            <div class="flex justify-between items-center text-sm mt-2">
                                <span class="font-medium">BTC/USD</span>
                                <span class="font-bold">64,230 <span class="text-red-300 text-xs">▼ -1.2%</span></span>
                            </div>
                        </div>
                    </div>
                    <div
                        class="bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-xl p-5">
                        <h3 class="text-lg font-bold text-slate-900 dark:text-white mb-4 flex items-center gap-2">
                            <span class="material-symbols-outlined text-primary">trending_up</span>
                            Đọc nhiều nhất
                        </h3>
                        <div class="flex flex-col gap-4">
                        
						<% 
						    List<Article> top = (List<Article>) request.getAttribute("mostViewedArts");
						    if(top != null && !top.isEmpty()) {
						        for(int i = 0; i < top.size(); i++) {
						            Article art = top.get(i);
						%>
                        
                            <a class="group flex gap-3 items-start" href="user/article?id=<%= art.getId() %>">
                                <span
                                    class="text-2xl font-black text-slate-200 dark:text-slate-700 leading-none group-hover:text-primary transition-colors"><%= i + 1 %></span>
                                <div>
                                    <h4
                                        class="text-sm font-semibold text-slate-800 dark:text-slate-200 leading-snug group-hover:text-primary transition-colors">
                                        <%= art.getTitle() %>
                                    </h4>
                                    <span class="text-xs text-slate-500 mt-1 block"><%= art.getSummary() %></span>
                                </div>
                            </a>
                            
                            <%	}	}	%>

                        </div>
                    </div>
                    <div
                        class="h-[300px] w-full bg-slate-100 dark:bg-surface-dark border border-dashed border-slate-300 dark:border-slate-700 rounded-xl flex flex-col items-center justify-center p-4 text-center relative overflow-hidden group">
                        <div class="absolute inset-0 bg-slate-200 dark:bg-slate-800 opacity-50"></div>
                        <span
                            class="relative z-10 text-xs font-bold text-slate-400 uppercase tracking-widest mb-2">Quảng
                            cáo</span>
                        <h4 class="relative z-10 text-lg font-bold text-slate-600 dark:text-slate-300">Giải pháp AI Đám
                            mây
                        </h4>
                        <p class="relative z-10 text-xs text-slate-500 mt-2 max-w-[200px]">Tăng tốc doanh nghiệp của bạn
                            với học máy cấp doanh nghiệp.</p>
                        <button
                            class="relative z-10 mt-4 px-4 py-2 bg-white dark:bg-surface-dark border border-slate-200 dark:border-slate-600 text-xs font-bold rounded shadow-sm hover:shadow text-slate-700 dark:text-slate-200">Tìm
                            hiểu thêm</button>
                    </div>
                </aside>
            </main>

            <jsp:include page="components/footer.jsp" />
        </div>
    </body>

    </html>