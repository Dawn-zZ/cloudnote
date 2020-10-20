package com.zjq.entity;

import java.util.Date;

public class AdminLog {

	private int id;
	
	private String adminUsername;

	private int roleId;

	private String roleName;
	
	private String loginIp;
	
	private Date loginTime;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAdminUsername() {
		return adminUsername;
	}

	public void setAdminUsername(String adminUsername) {
		this.adminUsername = adminUsername;
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

	public String getLoginIp() {
		return loginIp;
	}

	public void setLoginIp(String loginIp) {
		this.loginIp = loginIp;
	}

	public Date getLoginTime() {
		return loginTime;
	}

	public void setLoginTime(Date loginTime) {
		this.loginTime = loginTime;
	}


	@Override
	public String toString() {
		return "AdminLog [id=" + id + ", adminUsername=" + adminUsername + ", loginIp=" + loginIp + ", loginTime="
				+ loginTime + "]";
	}
	
	
	
}
