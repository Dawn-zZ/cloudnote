package com.zjq.entity;

import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Admin {

	private int id;

	private String username;

	private String image;

	private String password;

	private String nickname;

	private int roleId;
	
	private String roleName;

	private String sex;

	private String phone;

	private String email;

	private String code;

	private int isAdmin;

	@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	private Date createTime;

	private int status;

	private String note;


	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}
	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUsername() {
		return username;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getImage() {
		return image;
	}

	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public int getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(int isAdmin) {
		this.isAdmin = isAdmin;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	@Override
	public String toString() {
		return "Admin{" +
				"id=" + id +
				", username='" + username + '\'' +
				", image='" + image + '\'' +
				", password='" + password + '\'' +
				", nickname='" + nickname + '\'' +
				", roleId=" + roleId +
				", roleName='" + roleName + '\'' +
				", sex='" + sex + '\'' +
				", phone='" + phone + '\'' +
				", email='" + email + '\'' +
				", isAdmin=" + isAdmin +
				", createTime=" + createTime +
				", status=" + status +
				", note='" + note + '\'' +
				'}';
	}
}
