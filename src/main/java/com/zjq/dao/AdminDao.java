package com.zjq.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.zjq.entity.Search;
import org.apache.ibatis.annotations.Param;

import com.zjq.entity.Admin;
import com.zjq.entity.AdminLog;


public interface AdminDao {
	
	/************************登录相关************************/
	Admin login(@Param("username")String username,@Param("password")String password);
	
	/************************Admin相关************************/
	int updAdmin(Admin admin);

	List<Admin> getAdminsList(Search search);

	Admin getAdminById(int id);

	Admin getAdminByUsername(String username);

	Admin getAdminByEmail(String email);
	
	void insAdmin(Admin admin);
	
	void delAdminById(int id);

	void updateStatusById(@Param("id")int id, @Param("status")int status);

	Map<String,Integer> getUserCount();

	void updateEmail(@Param("id")int id , @Param("email")String email);
	
	/************************AdminLog相关************************/
	List<AdminLog> getAdminLogsList();

	void insAdminLog(@Param("adminUsername")String username, @Param("loginIp")String loginIp, @Param("loginTime")Date loginTime,@Param("roleId")int roleId);

	Map<String,Integer> getLogCount();
}
