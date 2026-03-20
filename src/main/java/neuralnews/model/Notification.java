package neuralnews.model;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;

public class Notification {
    private long id;
    private long userId;
    private String title;
    private String content;
    private String type; // SYSTEM, ARTICLE, COMMENT, etc.
    private boolean isRead;
    private Timestamp createdAt;
    private String url;

    public Notification() {}

    public Notification(long userId, String title, String content, String type, String url) {
        this.userId = userId;
        this.title = title;
        this.content = content;
        this.type = type;
        this.isRead = false;
        this.createdAt = new Timestamp(System.currentTimeMillis());
        this.url = url;
    }

    // Getters and Setters
    public long getId() { return id; }
    public void setId(long id) { this.id = id; }
    public long getUserId() { return userId; }
    public void setUserId(long userId) { this.userId = userId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public boolean isRead() { return isRead; }
    public void setRead(boolean read) { isRead = read; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    public String getUrl() { return url; }
    public void setUrl(String url) { this.url = url; }

    // Helper for relative time
    public String getTimeAgo() {
        if (createdAt == null) return "";
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime then = createdAt.toLocalDateTime();
        long minutes = ChronoUnit.MINUTES.between(then, now);
        if (minutes < 1) return "Vừa xong";
        if (minutes < 60) return minutes + " phút trước";
        long hours = ChronoUnit.HOURS.between(then, now);
        if (hours < 24) return hours + " giờ trước";
        long days = ChronoUnit.DAYS.between(then, now);
        if (days < 30) return days + " ngày trước";
        return then.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }

    // Design Helpers
    public String getIconClass() {
        if ("ARTICLE".equalsIgnoreCase(type)) return "auto_awesome";
        if ("COMMENT".equalsIgnoreCase(type)) return "comment";
        if ("LIKE".equalsIgnoreCase(type)) return "thumb_up";
        if ("SYSTEM".equalsIgnoreCase(type)) return "info";
        return "notifications";
    }

    public String getBgColor() {
        if ("ARTICLE".equalsIgnoreCase(type)) return "bg-blue-100 dark:bg-blue-900/40 text-blue-600";
        if ("COMMENT".equalsIgnoreCase(type)) return "bg-amber-100 dark:bg-amber-900/40 text-amber-600";
        if ("LIKE".equalsIgnoreCase(type)) return "bg-pink-100 dark:bg-pink-900/40 text-pink-600";
        if ("SYSTEM".equalsIgnoreCase(type)) return "bg-emerald-100 dark:bg-emerald-900/40 text-emerald-600";
        return "bg-slate-100 dark:bg-slate-800 text-slate-500";
    }
}
