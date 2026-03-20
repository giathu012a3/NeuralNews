package neuralnews.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Filter bảo vệ khu vực Admin.
 * Chỉ cho phép người dùng có role ADMIN và status ACTIVE truy cập.
 */
@WebFilter("/admin/*")
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String contextPath = httpRequest.getContextPath();
        
        // Lấy thông tin từ session (Các thuộc tính này phải được set khi Login)
        String userRole = (session != null) ? (String) session.getAttribute("userRole") : null;
        String userStatus = (session != null) ? (String) session.getAttribute("userStatus") : null;

        // KIỂM TRA QUYỀN TRUY CẬP TRANG ADMIN
        boolean isAdmin = (userRole != null && "ADMIN".equalsIgnoreCase(userRole))
                          && "ACTIVE".equalsIgnoreCase(userStatus);

        if (isAdmin) {
            // Là Admin xịn -> cho đi tiếp
            chain.doFilter(request, response);
        } else {
            // Không phải Admin
            System.out.println(">>> Cảnh báo bảo mật: Phát hiện truy cập trái phép vào trang Admin!");
            
            if (session == null || userRole == null) {
                // Trường hợp 1: Chưa đăng nhập -> về trang Login
                httpResponse.sendRedirect(contextPath + "/auth/login.jsp");
            } else {
                // Trường hợp 2: Đã đăng nhập nhưng không phải Admin -> về Trang chủ với thông báo lỗi
                httpResponse.sendRedirect(contextPath + "/index.jsp?error=access_denied");
            }
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Khởi tạo filter nếu cần
    }

    @Override
    public void destroy() {
        // Thu hồi tài nguyên nếu cần
    }
}
