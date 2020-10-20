package com.zjq.dao;

import java.util.List;

import com.zjq.entity.RoleMenu;

public interface RoleMenuDao {

	List<RoleMenu> selMenusByRoleId(int roleId);

	void deleteMenusByRoleId(int roleId);

	void insert(RoleMenu record);

	void deleteMenuByMenuId(int menuId);

}
