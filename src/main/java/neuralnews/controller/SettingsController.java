package neuralnews.controller;

import neuralnews.dao.UserDAO;
import neuralnews.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;

@WebServlet("/SettingsController")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50    // 50MB
)
public class SettingsController extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if ("updatePassword".equals(action)) {
            handleUpdatePassword(request, response, currentUser);
        } else if ("deleteAccount".equals(action)) {
            handleDeleteAccount(request, response, currentUser);
        } else {
            handleUpdateProfile(request, response, currentUser);
        }
    }

    private void handleDeleteAccount(HttpServletRequest request, HttpServletResponse response, User currentUser) 
            throws IOException {
        boolean success = userDAO.deleteUser(currentUser.getId());
        if (success) {
            request.getSession().invalidate();
            response.sendRedirect(request.getContextPath() + "/home?success=account_deleted");
        } else {
            response.sendRedirect(request.getContextPath() + "/user/settings.jsp?error=server");
        }
    }

    private void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response, User currentUser) 
            throws ServletException, IOException {
        String fullName = request.getParameter("fullName");
        String bio = request.getParameter("bio");
        
        // Handle File Upload
        Part filePart = request.getPart("avatarFile");
        String avatarPath = request.getParameter("avatarUrl");

        if (filePart != null && filePart.getSize() > 0) {
            String fileName = getFileName(filePart);
            if (fileName != null && !fileName.isEmpty()) {
                String extension = "";
                int i = fileName.lastIndexOf('.');
                if (i > 0) extension = fileName.substring(i);
                String newFileName = "uid_" + currentUser.getId() + "_" + System.currentTimeMillis() + extension;
                
                String uploadPath = getServletContext().getRealPath("/uploads/avatars");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();
                
                File file = new File(uploadDir, newFileName);
                try (InputStream input = filePart.getInputStream()) {
                    Files.copy(input, file.toPath(), StandardCopyOption.REPLACE_EXISTING);
                }
                avatarPath = "uploads/avatars/" + newFileName;
            }
        }

        if (fullName == null || fullName.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/user/settings.jsp?error=invalid_name");
            return;
        }

        currentUser.setFullName(fullName.trim());
        currentUser.setBio(bio != null ? bio.trim() : "");
        if (avatarPath != null && !avatarPath.trim().isEmpty()) {
            currentUser.setAvatarUrl(avatarPath.trim());
        }

        boolean success = userDAO.updateProfile(currentUser);
        if (success) {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", currentUser);
            session.setAttribute("userName", currentUser.getFullName()); 
            session.setAttribute("avatarUrl", currentUser.getAvatarUrl());
            response.sendRedirect(request.getContextPath() + "/user/settings.jsp?success=updated");
        } else {
            response.sendRedirect(request.getContextPath() + "/user/settings.jsp?error=server");
        }
    }

    private void handleUpdatePassword(HttpServletRequest request, HttpServletResponse response, User currentUser) 
            throws IOException {
        String currentPass = request.getParameter("currentPassword");
        String newPass = request.getParameter("newPassword");
        String confirmPass = request.getParameter("confirmPassword");

        if (currentPass == null || newPass == null || confirmPass == null || 
            currentPass.isEmpty() || newPass.isEmpty() || confirmPass.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/user/settings.jsp?error=missing_fields#security_section");
            return;
        }

        if (!newPass.equals(confirmPass)) {
            response.sendRedirect(request.getContextPath() + "/user/settings.jsp?error=password_mismatch#security_section");
            return;
        }

        String storedHash = userDAO.getPasswordHashById(currentUser.getId());
        if (storedHash == null || !org.mindrot.jbcrypt.BCrypt.checkpw(currentPass, storedHash)) {
            response.sendRedirect(request.getContextPath() + "/user/settings.jsp?error=wrong_password#security_section");
            return;
        }

        String newHash = org.mindrot.jbcrypt.BCrypt.hashpw(newPass, org.mindrot.jbcrypt.BCrypt.gensalt());
        boolean success = userDAO.updatePassword(currentUser.getId(), newHash);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/user/settings.jsp?success=password_updated#security_section");
        } else {
            response.sendRedirect(request.getContextPath() + "/user/settings.jsp?error=server#security_section");
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length() - 1);
            }
        }
        return null;
    }
}
