package neuralnews.model;

import java.sql.Timestamp;

/**
 * POJO model ánh xạ bảng `users` trong database.
 */
public class User {

	private long id;
	private String email;
	private String passwordHash;
	private String fullName;
	private Role role;
	private String status; 
	private String avatarUrl;
	private String bio;
	private int experienceYears;
	private Timestamp createdAt;

	public User() {
	}
	public boolean hasRole(String roleName) {
		if (this.role == null || this.role.getName() == null) {
			return false;
		}

		String currentRole = this.role.getName().toUpperCase();

		if ("ADMIN".equals(currentRole)) {
			return true;
		}

		if ("JOURNALIST".equals(currentRole)) {
			if ("USER".equalsIgnoreCase(roleName) || "JOURNALIST".equalsIgnoreCase(roleName)) {
				return true;
			}
		}

		return currentRole.equalsIgnoreCase(roleName);
	}


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
