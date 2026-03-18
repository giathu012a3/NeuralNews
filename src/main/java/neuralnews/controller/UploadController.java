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
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.UUID;

@WebServlet("/api/upload")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,      // 10MB
    maxRequestSize = 1024 * 1024 * 50   // 50MB
)
public class UploadController extends HttpServlet {

    private Path resolveProjectUploadsDir() {
        // Ưu tiên cấu hình bằng env/JVM (không cần sửa DB)
        String env = System.getenv("NEURALNEWS_UPLOAD_DIR");
        if (env != null && !env.isBlank()) return Paths.get(env.trim());

        String sys = System.getProperty("neuralnews.upload.dir");
        if (sys != null && !sys.isBlank()) return Paths.get(sys.trim());

        // Context-param trong web.xml (nếu muốn cấu hình qua server)
        try {
            String ctx = getServletContext().getInitParameter("NEURALNEWS_UPLOAD_DIR");
            if (ctx != null && !ctx.isBlank()) return Paths.get(ctx.trim());
        } catch (Exception ignored) {}

        // Mặc định dùng 1 folder "ai mở cũng thấy" (không phụ thuộc đường dẫn project):
        //   Windows: C:/Users/<user>/NeuralNews/uploads/images
        //   macOS/Linux: /Users/<user>/NeuralNews/uploads/images (hoặc /home/<user>/...)
        try {
            String home = System.getProperty("user.home");
            if (home != null && !home.isBlank()) {
                return Paths.get(home, "NeuralNews", "uploads", "images");
            }
        } catch (Exception ignored) {}

        return null; // fallback: chỉ lưu ở deployed dir
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try {
            Part filePart = request.getPart("image");
            if (filePart == null) {
                filePart = request.getPart("file");
            }

            if (filePart == null) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\": \"No file uploaded\"}");
                return;
            }

            String fileName = filePart.getSubmittedFileName();
            String extension = "";
            if (fileName != null && fileName.contains(".")) {
                extension = fileName.substring(fileName.lastIndexOf("."));
            }
            
            // Tạo tên file ngẫu nhiên để tránh trùng
            String newFileName = UUID.randomUUID().toString() + extension;
            
            // 1) Lưu vào thư mục deploy (để URL /uploads/... truy cập được ngay)
            String deployedUploadPath = getServletContext().getRealPath("/") + "uploads" + File.separator + "images";
            File deployedDir = new File(deployedUploadPath);
            if (!deployedDir.exists()) deployedDir.mkdirs();

            Path deployedFile = Paths.get(deployedUploadPath, newFileName);
            filePart.write(deployedFile.toString());

            // 2) (Tuỳ chọn) copy thêm về đúng folder trong project: src/main/webapp/uploads/images
            // để bạn nhìn thấy file ngay trong repo.
            boolean projectCopied = false;
            String projectDirUsed = null;
            Path projectDir = resolveProjectUploadsDir();
            if (projectDir != null) {
                try {
                    Files.createDirectories(projectDir);
                    Path projectFile = projectDir.resolve(newFileName).normalize();
                    if (!projectFile.equals(deployedFile)) {
                        Files.copy(deployedFile, projectFile, StandardCopyOption.REPLACE_EXISTING);
                    }
                    projectCopied = true;
                    projectDirUsed = projectDir.toAbsolutePath().normalize().toString();
                } catch (Exception ignored) {
                    // Nếu không copy được (quyền/đường dẫn), vẫn OK vì file đã nằm ở deploy dir.
                }
            }

            // Trả về đường dẫn tương đối để lưu vào DB, 
            // và trường "location" cho TinyMCE (đường dẫn tuyệt đối từ root)
            String relativePath = "uploads/images/" + newFileName;
            String contextPath  = request.getContextPath();
            String location     = (contextPath.endsWith("/") ? contextPath : contextPath + "/") + relativePath;

            String deployedDirUsed = deployedDir.getAbsolutePath();
            response.getWriter().write("{"
                    + "\"success\": true,"
                    + "\"url\": \"" + relativePath + "\","
                    + "\"location\": \"" + location + "\","
                    + "\"deployedDir\": \"" + escapeJson(deployedDirUsed) + "\","
                    + "\"projectCopied\": " + projectCopied + ","
                    + "\"projectDir\": " + (projectDirUsed != null ? "\"" + escapeJson(projectDirUsed) + "\"" : "null")
                    + "}");

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }

    private String escapeJson(String s) {
        if (s == null) return "";
        return s.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
