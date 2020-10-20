package com.zjq.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.zjq.entity.Admin;
import com.zjq.entity.Menu;
import com.zjq.entity.Role;
import com.zjq.entity.Search;
import com.zjq.utils.ResultUtil;

public interface AdminService {
	
	/************************登录相关************************/
	Admin login(String username,String password);
	
	/************************Admin相关************************/
	void updAdmin(Admin admin);

	Admin getAdminById(int id);

	Admin getAdminByUsername(String username);

	Admin getAdminByEmail(String email);

	ResultUtil getAdminsList(Integer page, Integer limit, Search search);

	List<Admin> getAdminsList(Search search);
	
	void insAdmin(Admin admin);

	void delAdminById(int id);

	ResultUtil updateStatusById(int id, int status);

	Map<String,Integer> getUserCount();

	ResultUtil updateEmail(int id , String email);

	/************************AdminLog相关************************/
	void insAdminLog(String username, String loginIp, Date loginTime ,int roleId);

	ResultUtil getAdminLogsList(Integer page, Integer limit);

	Map<String,Integer> getLogCount();

	/************************Role相关************************/
	ResultUtil getRoles(Integer page, Integer limit);

	Role getRoleById(int id);
	
	List<Role> getRoles();

	void updRole(Role role, String m);

	Role getRoleByRoleName(String roleName);

	void delRole(int roleId);

	void insRole(Role role, String m);

	/************************RoleMenu相关************************/
	List<Menu> getXtreeData(Admin admin);

	/************************Menu相关************************/
	List<Menu> getMenus(Admin admin);
	
	List<Menu> getAllMenus();

	void updMenuSortingById(Menu menu);

	List<Menu> checkNameSameLevel(Menu menus);

	Menu getMenuById(int menuId);
	
	Menu getMenuByName(String name);

	void updMenu(Menu menus);

	void insMenu(Menu menus);

	List<Menu> getMenusByParentId(int menuId);

	void delMenuById(int menuId);
}
