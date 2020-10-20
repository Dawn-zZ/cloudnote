package com.zjq.dao;

import java.util.List;

import com.zjq.entity.Role;

public interface RoleDao {

	List<Role> selRoles();

	Role getRoleById(int id);

	void updateByKey(Role role);

	Role selectRoleByRoleName(String roleName);

	void delRole(int roleId);

	void insertRole(Role role);

}
