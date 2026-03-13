package neuralnews.model;

import java.sql.Timestamp;

public class Article {

    // Core fields
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

    // Display fields - được set bởi Controller
    private String statusLabel;
    private String statusBadgeClass;
    private String statusDotClass;
    private String formattedViews;

    public Article() {}

    // ── id ──────────────────────────────────────────────────────────────────
    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    // ── title ────────────────────────────────────────────────────────────────
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    // ── content ──────────────────────────────────────────────────────────────
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    // ── summary ──────────────────────────────────────────────────────────────
    public String getSummary() { return summary; }
    public void setSummary(String summary) { this.summary = summary; }

    // ── imageUrl ─────────────────────────────────────────────────────────────
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    // ── authorId ─────────────────────────────────────────────────────────────
    public long getAuthorId() { return authorId; }
    public void setAuthorId(long authorId) { this.authorId = authorId; }

    // ── categoryId ───────────────────────────────────────────────────────────
    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }

    // ── status ───────────────────────────────────────────────────────────────
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    // ── views ────────────────────────────────────────────────────────────────
    public int getViews() { return views; }
    public void setViews(int views) { this.views = views; }

    // ── likesCount ───────────────────────────────────────────────────────────
    public int getLikesCount() { return likesCount; }
    public void setLikesCount(int likesCount) { this.likesCount = likesCount; }

    // ── sentimentLabel ───────────────────────────────────────────────────────
    public String getSentimentLabel() { return sentimentLabel; }
    public void setSentimentLabel(String sentimentLabel) { this.sentimentLabel = sentimentLabel; }

    // ── sourceScore ──────────────────────────────────────────────────────────
    public double getSourceScore() { return sourceScore; }
    public void setSourceScore(double sourceScore) { this.sourceScore = sourceScore; }

    // ── popularityScore ──────────────────────────────────────────────────────
    public double getPopularityScore() { return popularityScore; }
    public void setPopularityScore(double popularityScore) { this.popularityScore = popularityScore; }

    // ── publishedAt ──────────────────────────────────────────────────────────
    public Timestamp getPublishedAt() { return publishedAt; }
    public void setPublishedAt(Timestamp publishedAt) { this.publishedAt = publishedAt; }

    // ── createdAt ────────────────────────────────────────────────────────────
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    // ── categoryName ─────────────────────────────────────────────────────────
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    // ── Display fields ───────────────────────────────────────────────────────
    public String getStatusLabel() { return statusLabel; }
    public void setStatusLabel(String statusLabel) { this.statusLabel = statusLabel; }

    public String getStatusBadgeClass() { return statusBadgeClass; }
    public void setStatusBadgeClass(String statusBadgeClass) { this.statusBadgeClass = statusBadgeClass; }

    public String getStatusDotClass() { return statusDotClass; }
    public void setStatusDotClass(String statusDotClass) { this.statusDotClass = statusDotClass; }

    public String getFormattedViews() { return formattedViews; }
    public void setFormattedViews(String formattedViews) { this.formattedViews = formattedViews; }
}