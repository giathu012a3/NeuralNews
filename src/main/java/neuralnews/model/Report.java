package neuralnews.model;

import java.sql.Timestamp;

public class Report {
    private long id;
    private String targetType; // ARTICLE or COMMENT
    private long targetId;
    private Long reporterId;
    private String reporterName;
    private int reporterTrust;
    private String targetTitle;
    private String authorName;
    private String section;
    private String reason;
    private String details;
    private String status;
    private String problematicSnippet;
    private int reportCount;
    private Timestamp createdAt;

    // Constructors
    public Report() {}

    // Getters and Setters
    public int getReportCount() { return reportCount; }
    public void setReportCount(int reportCount) { this.reportCount = reportCount; }

    // Getters and Setters
    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    public String getTargetType() { return targetType; }
    public void setTargetType(String targetType) { this.targetType = targetType; }

    public long getTargetId() { return targetId; }
    public void setTargetId(long targetId) { this.targetId = targetId; }

    public Long getReporterId() { return reporterId; }
    public void setReporterId(Long reporterId) { this.reporterId = reporterId; }

    public String getReporterName() { return reporterName; }
    public void setReporterName(String reporterName) { this.reporterName = reporterName; }

    public int getReporterTrust() { return reporterTrust; }
    public void setReporterTrust(int reporterTrust) { this.reporterTrust = reporterTrust; }

    public String getTargetTitle() { return targetTitle; }
    public void setTargetTitle(String targetTitle) { this.targetTitle = targetTitle; }

    public String getAuthorName() { return authorName; }
    public void setAuthorName(String authorName) { this.authorName = authorName; }

    public String getSection() { return section; }
    public void setSection(String section) { this.section = section; }

    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }

    public String getDetails() { return details; }
    public void setDetails(String details) { this.details = details; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }


    public String getProblematicSnippet() { return problematicSnippet; }
    public void setProblematicSnippet(String problematicSnippet) { this.problematicSnippet = problematicSnippet; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
