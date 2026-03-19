package neuralnews.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import neuralnews.dao.ArticleDao;

import java.io.IOException;

/**
 * Servlet implementation class InterestController
 */
@WebServlet("/update-interest")
public class InterestController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
    	System.out.println("--- Đã nhận yêu cầu cập nhật điểm ---");
        
        HttpSession session = request.getSession();
        neuralnews.model.User currentUser = (neuralnews.model.User) session.getAttribute("currentUser");
        
        if (currentUser != null) {
            try {
                int categoryId = Integer.parseInt(request.getParameter("categoryId"));
                int score = Integer.parseInt(request.getParameter("score"));
                
                ArticleDao dao = new ArticleDao();
                dao.updateInterestScore(currentUser.getId(), categoryId, score);
            } catch (Exception e) { e.printStackTrace(); }
            System.out.println("User ID: " + currentUser.getId() + " | Cat ID: " + request.getParameter("categoryId"));
        }
        else {
            System.out.println("--- Cảnh báo: Có request gửi lên nhưng User chưa đăng nhập! ---");
        }
        
    }
    
}
