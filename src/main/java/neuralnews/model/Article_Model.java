package neuralnews.model;

import java.sql.Timestamp;

public class Article_Model {
    private int id;
    private String title;
    private String content;
    private String summary;
    private String imageUrl;
    private int categoryId;
    private int views;
    private Timestamp publishedAt;
    private Timestamp createdAt;
    private String categoryName;

    public Article_Model() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getSummary() { return summary; }
    public void setSummary(String summary) { this.summary = summary; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public int getViews() { return views; }
    public void setViews(int views) { this.views = views; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
}