<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="neuralnews.model.Category" %>
<%
    List<Category> listCat = (List<Category>) request.getAttribute("listCategory");
    int displayLimit = 6;
    if (listCat != null && !listCat.isEmpty()) { 
        int total = listCat.size();
        for (int i = 0; i < Math.min(total, displayLimit); i++) {
            Category cat = listCat.get(i);
%>
    <a class="text-sm font-semibold text-slate-600 dark:text-slate-300 hover:text-primary dark:hover:text-primary transition-colors uppercase tracking-wide whitespace-nowrap"
       href="${pageContext.request.contextPath}/category?id=<%= cat.getId() %>"><%= cat.getName() %></a>
<%      } 
        if (total > displayLimit) { 
%>
    <div class="relative group py-2">
        <button class="flex items-center gap-1 text-sm font-semibold text-slate-600 dark:text-slate-300 hover:text-primary dark:hover:text-primary transition-colors uppercase tracking-wide">
            Thêm <span class="material-symbols-outlined text-[18px]">expand_more</span>
        </button>
        <div class="absolute left-0 top-full hidden group-hover:block pt-2">
            <div class="bg-white dark:bg-surface-dark border border-slate-200 dark:border-border-dark rounded-xl shadow-xl min-w-[200px] py-3 overflow-hidden animate-in fade-in slide-in-from-top-1 duration-200">
                <% for (int i = displayLimit; i < total; i++) { 
                    Category cat = listCat.get(i);
                %>
                <a class="block px-6 py-2.5 text-sm font-medium text-slate-600 dark:text-slate-300 hover:bg-slate-50 dark:hover:bg-slate-800 hover:text-primary dark:hover:text-primary transition-colors whitespace-nowrap"
                   href="${pageContext.request.contextPath}/category?id=<%= cat.getId() %>"><%= cat.getName() %></a>
                <% } %>
            </div>
        </div>
    </div>
<%      } 
    } else { %>
    <span class="text-xs text-slate-400 italic">Chưa có danh mục</span>
<% } %>
