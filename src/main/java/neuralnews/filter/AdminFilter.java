package neuralnews.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/admin/*")
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String contextPath = httpRequest.getContextPath();
        
        String userRole = (session != null) ? (String) session.getAttribute("userRole") : null;
        String userStatus = (session != null) ? (String) session.getAttribute("userStatus") : null;

        boolean isAdmin = (userRole != null && "ADMIN".equalsIgnoreCase(userRole))
                          && "ACTIVE".equalsIgnoreCase(userStatus);

        if (isAdmin) {
            chain.doFilter(request, response);
        } else {
            System.out.println(">>> Cảnh báo bảo mật: Phát hiện truy cập trái phép vào trang Admin!");
            
            if (session == null || userRole == null) {
                httpResponse.sendRedirect(contextPath + "/auth/login.jsp");
            } else {
                httpResponse.sendRedirect(contextPath + "/index.jsp?error=access_denied");
            }
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void destroy() {
    }
}
