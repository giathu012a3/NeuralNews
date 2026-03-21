package neuralnews.service;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import neuralnews.dao.SystemSettingDao;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

public class GeminiService {
    private static final String BASE_URL = "https://generativelanguage.googleapis.com/v1/models/gemini-2.5-flash:generateContent?key=";
    private final HttpClient client;
    private final Gson gson;
    private final SystemSettingDao settingDao;

    public GeminiService() {
        this.client = HttpClient.newBuilder()
                .connectTimeout(Duration.ofSeconds(10))
                .build();
        this.gson = new Gson();
        this.settingDao = new SystemSettingDao();
    }

    public String generateSummary(String content) {
        try {
            if (content == null || content.trim().isEmpty()) {
                return "Nội dung quá ngắn để tóm tắt.";
            }

            // Clean HTML tags if any (basic approach)
            String cleanText = content.replaceAll("<[^>]*>", "").trim();
            if (cleanText.length() > 5000) {
                cleanText = cleanText.substring(0, 5000); // Truncate if very long
            }

            String prompt = "Dựa trên nội dung sau, hãy viết một bản tóm tắt cực kỳ ngắn gọn gồm 4-5 gạch đầu dòng tóm tắt các ý quan trọng nhất của bài báo này. Chỉ trả về các gạch đầu dòng, không thêm lời dẫn. \n\nNội dung: "
                    + cleanText;

            // Construct JSON request
            JsonObject part = new JsonObject();
            part.addProperty("text", prompt);

            JsonArray parts = new JsonArray();
            parts.add(part);

            JsonObject contentObj = new JsonObject();
            contentObj.add("parts", parts);

            JsonArray contents = new JsonArray();
            contents.add(contentObj);

            JsonObject requestBody = new JsonObject();
            requestBody.add("contents", contents);

            String apiKey = settingDao.getSetting("gemini_api_key");
            if (apiKey == null || apiKey.trim().isEmpty() || apiKey.equals("YOUR_API_KEY_HERE")) {
                return "Tóm tắt AI hiện chưa sẵn dùng (Admin chưa cấu hình API Key).";
            }

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(BASE_URL + apiKey))
                    .header("Content-Type", "application/json")
                    .POST(HttpRequest.BodyPublishers.ofString(gson.toJson(requestBody)))
                    .timeout(Duration.ofSeconds(60))
                    .build();

            HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());

            if (response.statusCode() == 200) {
                JsonObject responseBody = gson.fromJson(response.body(), JsonObject.class);
                return responseBody.getAsJsonArray("candidates")
                        .get(0).getAsJsonObject()
                        .getAsJsonObject("content")
                        .getAsJsonArray("parts")
                        .get(0).getAsJsonObject()
                        .get("text").getAsString();
            } else {
                return "Lỗi từ dịch vụ AI (Status: " + response.statusCode() + "): " + response.body();
            }

        } catch (Exception e) {
            e.printStackTrace();
            return "Đã xảy ra lỗi khi kết nối với máy chủ AI: " + e.getMessage();
        }
    }
}
