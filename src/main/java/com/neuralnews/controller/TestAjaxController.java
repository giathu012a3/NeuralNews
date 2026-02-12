package com.neuralnews.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet implementation class TestAjaxController
 * This is a demo controller to test AJAX functionality.
 */
@WebServlet("/api/test-ajax")
public class TestAjaxController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public TestAjaxController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set response content type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Simulate some data
        String jsonResponse = "{\"message\": \"Hello from Server!\", \"status\": \"success\", \"timestamp\": \""
                + System.currentTimeMillis() + "\"}";

        PrintWriter out = response.getWriter();
        out.print(jsonResponse);
        out.flush();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set response content type to JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Read JSON body (simplified for demo, usually use a library like Gson or
        // Jackson)
        // For this demo, we just return a success message

        String jsonResponse = "{\"message\": \"Data received successfully!\", \"status\": \"success\"}";

        PrintWriter out = response.getWriter();
        out.print(jsonResponse);
        out.flush();
    }

}
