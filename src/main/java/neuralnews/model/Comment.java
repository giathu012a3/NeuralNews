package neuralnews.model;

import java.sql.Timestamp;
import java.util.List;

public class Comment {

    private long id;
    private String content;
    private String status;
    private String statusLabel;
    private String statusBadgeClass;
    private String statusDotClass;
    private Timestamp createdAt;
    private String formattedTime;
    private int likesCount;
    private boolean likedByUser;

    // User info
    private long userId;
    private String userName;
    private String userAvatar;
    private String userAvatarBgClass;

    // Article info
    private long articleId;
    private String articleTitle;

    // Reply support
    private Long parentId;
    private List<Comment> replies;

    public Comment() {}

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getStatusLabel() { return statusLabel; }
    public void setStatusLabel(String statusLabel) { this.statusLabel = statusLabel; }

    public String getStatusBadgeClass() { return statusBadgeClass; }
    public void setStatusBadgeClass(String statusBadgeClass) { this.statusBadgeClass = statusBadgeClass; }

    public String getStatusDotClass() { return statusDotClass; }
    public void setStatusDotClass(String statusDotClass) { this.statusDotClass = statusDotClass; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }

    public String getFormattedTime() { return formattedTime; }
    public void setFormattedTime(String formattedTime) { this.formattedTime = formattedTime; }

    public long getUserId() { return userId; }
    public void setUserId(long userId) { this.userId = userId; }

    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }

    public String getUserAvatar() { return userAvatar; }
    public void setUserAvatar(String userAvatar) { this.userAvatar = userAvatar; }

    public String getUserAvatarBgClass() { return userAvatarBgClass; }
    public void setUserAvatarBgClass(String userAvatarBgClass) { this.userAvatarBgClass = userAvatarBgClass; }

    public long getArticleId() { return articleId; }
    public void setArticleId(long articleId) { this.articleId = articleId; }

    public String getArticleTitle() { return articleTitle; }
    public void setArticleTitle(String articleTitle) { this.articleTitle = articleTitle; }

    public Long getParentId() { return parentId; };
    public void setParentId(Long parentId) { this.parentId = parentId; }
    
    public int getLikesCount() { return likesCount; }
    public void setLikesCount(int likesCount) { this.likesCount = likesCount; }
    
    public boolean isLikedByUser() { return likedByUser; }

    public void setLikedByUser(boolean likedByUser) { this.likedByUser = likedByUser; }

    public List<Comment> getReplies() { return replies; }
    public void setReplies(List<Comment> replies) { this.replies = replies; }
}