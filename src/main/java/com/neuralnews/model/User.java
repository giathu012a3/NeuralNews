package com.neuralnews.model;

import java.sql.Timestamp;

/**
 * POJO model ánh xạ bảng `users` trong database.
 */
public class User {

    private long id;
    private String email;
    private String passwordHash;
    private String fullName;
    private Role role; // Giờ chỉ cần 1 Role duy nhất
    private String status; // 'ACTIVE', 'PENDING', 'BANNED', 'SUSPENDED'
    private String avatarUrl;
    private String bio;
    private int experienceYears;
    private Timestamp createdAt;

    public User() {
    }

    // --- Helper Methods ---

    /**
     * Kiểm tra nhanh xem user có chứa role cụ thể hay không.
     * Cây phân quyền phân cấp: ADMIN có mọi quyền, JOURNALIST có quyền USER.
     */
    public boolean hasRole(String roleName) {
        if (this.role == null || this.role.getName() == null) {
            return false;
        }

        String currentRole = this.role.getName().toUpperCase();

        // Cấp 1: Nếu là ADMIN, full quyền
        if ("ADMIN".equals(currentRole)) {
            return true;
        }

        // Cấp 2: Nếu là JOURNALIST, được qua cửa USER hoặc JOURNALIST
        if ("JOURNALIST".equals(currentRole)) {
            if ("USER".equalsIgnoreCase(roleName) || "JOURNALIST".equalsIgnoreCase(roleName)) {
                return true;
            }
        }

        // Cấp 3: Khớp chính xác (Ví dụ tài khoản USER thì chỉ vào được trang USER)
        return currentRole.equalsIgnoreCase(roleName);
    }

    // --- Getters & Setters ---

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public int getExperienceYears() {
        return experienceYears;
    }

    public void setExperienceYears(int experienceYears) {
        this.experienceYears = experienceYears;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "User{id=" + id + ", email='" + email + "', role=" + (role != null ? role.getName() : "null")
                + ", status='" + status + "'}";
    }
}
