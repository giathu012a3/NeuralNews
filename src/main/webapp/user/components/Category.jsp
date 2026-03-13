<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="neuralnews.model.Category" %>
<%
    List<Category> listCat = (List<Category>) request.getAttribute("listCategory");
%>
   <% if (listCat != null && !listCat.isEmpty()) { %>
					        <% for (Category cat : listCat) { %>
					            <a class="text-sm font-semibold text-slate-600 dark:text-slate-300 hover:text-primary dark:hover:text-primary
						             transition-colors uppercase tracking-wide"
						             href="${pageContext.request.contextPath}/home?id=<%= cat.getId() %>"><%= cat.getName() %>
					           	</a>
					        <% } %>
					    <% } else { %>
					        <span>Chưa có danh mục</span>
					    <% } %>
