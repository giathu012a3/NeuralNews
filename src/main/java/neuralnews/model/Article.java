package neuralnews.model;

import java.sql.Timestamp;

public class Article {

    private long id;
    private String title;
    private String content;
    private String summary;
    private String imageUrl;
    private long authorId;
    private int categoryId;
    private String status;
    private int views;
    private int likesCount;
    private String sentimentLabel;
    private double sourceScore;
    private double popularityScore;
    private Timestamp publishedAt;
    private Timestamp createdAt;
    private String categoryName;

    // Display fields - ─æ╞░ß╗úc set bß╗ƒi Controller
    private String authorName;
    private String statusLabel;
    private String statusBadgeClass;
    private String statusDotClass;
    private String formattedViews;

    public Article() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    /**
     * Xử lý nội dung HTML bài viết để đảm bảo các ảnh nội bộ (uploads/...)
     * luôn có contextPath đi kèm, giúp hiển thị đúng dù ở bất kỳ URL nào.
     */
    public String getContentProcessed(String contextPath) {
        if (content == null)
            return "";
        // Tìm các src="uploads/ và thay thế bằng src="contextPath/uploads/
        String search = "src=\"uploads/";
        String replace = "src=\"" + contextPath + "/uploads/";
        return content.replace(search, replace);
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    /**
     * Trả về đường dẫn ảnh để hiển thị.
     * Nếu là URL tuyệt đối (http...) thì giữ nguyên.
     * Nếu là đường dẫn tương đối (uploads/...) thì thêm contextPath.
     */
    public String getDisplayImageUrl(String contextPath) {
        if (imageUrl == null || imageUrl.isBlank()) {
            return contextPath + "/uploads/images/placeholder.jpg";
        }
        if (imageUrl.startsWith("http")) {
            return imageUrl;
        }
        // Đảm bảo không bị nhân đôi dấu /
        String path = imageUrl.startsWith("/") ? imageUrl : "/" + imageUrl;
        return contextPath + path;
    }

    public long getAuthorId() {
        return authorId;
    }

    public void setAuthorId(long authorId) {
        this.authorId = authorId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public int getLikesCount() {
        return likesCount;
    }

    public void setLikesCount(int likesCount) {
        this.likesCount = likesCount;
    }

    public String getSentimentLabel() {
        return sentimentLabel;
    }

    public void setSentimentLabel(String sentimentLabel) {
        this.sentimentLabel = sentimentLabel;
    }

    public double getSourceScore() {
        return sourceScore;
    }

    public void setSourceScore(double sourceScore) {
        this.sourceScore = sourceScore;
    }

    public double getPopularityScore() {
        return popularityScore;
    }

    public void setPopularityScore(double popularityScore) {
        this.popularityScore = popularityScore;
    }

    public Timestamp getPublishedAt() {
        return publishedAt;
    }

    public void setPublishedAt(Timestamp publishedAt) {
        this.publishedAt = publishedAt;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getStatusLabel() {
        return statusLabel;
    }

    public void setStatusLabel(String statusLabel) {
        this.statusLabel = statusLabel;
    }

    public String getAuthorName() {
        return authorName;
    }

    public void setAuthorName(String authorName) {
        this.authorName = authorName;
    }

    public String getStatusBadgeClass() {
        return statusBadgeClass;
    }

    public void setStatusBadgeClass(String statusBadgeClass) {
        this.statusBadgeClass = statusBadgeClass;
    }

    public String getStatusDotClass() {
        return statusDotClass;
    }

    public void setStatusDotClass(String statusDotClass) {
        this.statusDotClass = statusDotClass;
    }

    public String getFormattedViews() {
        return formattedViews;
    }

    public void setFormattedViews(String formattedViews) {
        this.formattedViews = formattedViews;
    }
}
