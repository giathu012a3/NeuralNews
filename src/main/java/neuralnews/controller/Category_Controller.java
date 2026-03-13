package neuralnews.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import neuralnews.dao.Category_Dao;
import neuralnews.model.Category_Model;

@WebServlet("/home")
public class Category_Controller extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {

	    Category_Dao dao = new Category_Dao();
	    List<Category_Model> list = dao.getAllCategory();

	    request.setAttribute("listCategory", list);
	    request.getRequestDispatcher("/user/home.jsp").forward(request, response);
	}
}