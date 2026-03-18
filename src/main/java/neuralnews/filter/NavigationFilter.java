package neuralnews.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.List;
import neuralnews.dao.CategoryDao;
import neuralnews.model.Category;

@WebFilter("/*")
public class NavigationFilter implements Filter {

    private CategoryDao catDao;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        catDao = new CategoryDao();
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        String path = httpRequest.getRequestURI();

        if (!path.contains("/assets/") && !path.contains("/api/") &&
                (path.endsWith(".jsp") || path.endsWith("/") || !path.contains("."))) {

            if (request.getAttribute("listCategory") == null) {
                List<Category> listCat = catDao.getAllCategory();
                request.setAttribute("listCategory", listCat);
            }
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}
