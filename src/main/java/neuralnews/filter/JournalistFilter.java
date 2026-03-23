package neuralnews.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Filter để bảo vệ các tính năng của Nhà báo.
 * Chỉ cho phép người dùng có role JOURNALIST (hoặc ADMIN) và status ACTIVE.
 */
@WebFilter("/journalist/*")
public class JournalistFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String contextPath = httpRequest.getContextPath();
        String userRole = (session != null) ? (String) session.getAttribute("userRole") : null;
        String userStatus = (session != null) ? (String) session.getAttribute("userStatus") : null;

        // Cho phép ADMIN hoặc JOURNALIST có trạng thái ACTIVE
        boolean isAuthorized = (userRole != null && ("JOURNALIST".equals(userRole) || "ADMIN".equals(userRole)))
                && "ACTIVE".equals(userStatus);

        if (isAuthorized) {
            chain.doFilter(request, response);
        } else {
            if (session == null || userRole == null) {
                // Chưa đăng nhập -> về login
                httpResponse.sendRedirect(contextPath + "/auth/login.jsp");
            } else if ("PENDING".equals(userStatus)) {
                // Đang chờ duyệt -> về trang cá nhân xem tiến độ hoặc trang thông tin
                httpResponse.sendRedirect(contextPath + "/user/profile.jsp?info=pending_journalist");
            } else {
                // Không đủ quyền hoặc bị khóa -> về trang lỗi/profile
                httpResponse.sendRedirect(contextPath + "/user/profile.jsp?error=unauthorized_journalist");
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
