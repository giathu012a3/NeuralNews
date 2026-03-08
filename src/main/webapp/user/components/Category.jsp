<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="neuralnews.model.Category_Model" %>
<%@ page import="neuralnews.dao.Category_Dao" %>
<%
    List<Category_Model> listCat = (List<Category_Model>) request.getAttribute("listCategory");

    if (listCat == null) {
        Category_Dao dao = new Category_Dao();
        listCat = dao.getAllCategory();
        request.setAttribute("listCategory", listCat);
    }
%>
   <% if (listCat != null && !listCat.isEmpty()) { %>
					        <% for (Category_Model cat : listCat) { %>
					            <a class="text-sm font-semibold text-slate-600 dark:text-slate-300 hover:text-primary dark:hover:text-primary
						             transition-colors uppercase tracking-wide"
						             href="category?id=<%= cat.getId() %>"><%= cat.getName() %>
					           	</a>
					        <% } %>
					    <% } else { %>
					        <span>Chưa có danh mục</span>
					    <% } %>
