package neuralnews.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/api/upload")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50   // 50MB
)
public class UploadController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            Part filePart = request.getPart("image");
            if (filePart == null) {
                response.getWriter().write("{\"success\": false, \"message\": \"No file uploaded\"}");
                return;
            }

            String fileName = filePart.getSubmittedFileName();
            String extension = "";
            if (fileName != null && fileName.contains(".")) {
                extension = fileName.substring(fileName.lastIndexOf("."));
            }
            
            // Tạo tên file ngẫu nhiên để tránh trùng
            String newFileName = UUID.randomUUID().toString() + extension;
            
            // Đường dẫn lưu trữ vật lý
            String uploadPath = getServletContext().getRealPath("/") + "uploads" + File.separator + "images";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            String filePath = uploadPath + File.separator + newFileName;
            filePart.write(filePath);

            // Trả về đường dẫn tương đối để lưu vào DB
            String relativePath = "uploads/images/" + newFileName;
            response.getWriter().write("{\"success\": true, \"url\": \"" + relativePath + "\"}");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }
}
