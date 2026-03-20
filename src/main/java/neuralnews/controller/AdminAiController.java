package neuralnews.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import neuralnews.dao.SystemSettingDao;
import neuralnews.model.SystemSetting;

@WebServlet("/admin/ai-settings")
public class AdminAiController extends HttpServlet {
    private final SystemSettingDao settingDao = new SystemSettingDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        List<SystemSetting> settings = settingDao.getAllSettings();
        request.setAttribute("settings", settings);
        request.getRequestDispatcher("/admin/ai_settings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String apiKey = request.getParameter("gemini_api_key");
        if (apiKey != null) {
            boolean success = settingDao.updateSetting("gemini_api_key", apiKey.trim());
            if (success) {
                request.setAttribute("successMsg", "Cập nhật cấu hình AI thành công!");
            } else {
                request.setAttribute("errorMsg", "Cập nhật thất bại, vui lòng thử lại.");
            }
        }
        doGet(request, response);
    }
}
