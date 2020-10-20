package com.zjq.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import com.zjq.entity.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zjq.dao.AdminDao;
import com.zjq.dao.MenuDao;
import com.zjq.dao.RoleDao;
import com.zjq.dao.RoleMenuDao;
import com.zjq.service.AdminService;
import com.zjq.utils.MD5Utils;
import com.zjq.utils.ResultUtil;

@Service
@Transactional
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDao adminDao;

	@Autowired
	private RoleMenuDao roleMenuDao;
	
	@Autowired
	private RoleDao roleDao;
	
	@Autowired
	private MenuDao menuDao;
	
	/************************************登录相关************************************/
	@Override
	public Admin login(String username, String password) {
		return adminDao.login(username, MD5Utils.md5(password));
	}
	
	/************************************Admin相关************************************/
	@Override
	public ResultUtil getAdminsList(Integer page, Integer limit, Search search) {
		PageHelper.startPage(page,limit);
		List<Admin> admins = adminDao.getAdminsList(search);
		for(Admin admin : admins) {
			List<Role> roles = roleDao.selRoles();
			for(Role role : roles) {
				if(role.getRoleId() == admin.getRoleId()) {
					admin.setRoleName(role.getRoleName());
				}
			}
		}
		PageInfo<Admin> pageInfo = new PageInfo<Admin>(admins);
		ResultUtil resultUtil = new ResultUtil();
		resultUtil.setCode(0);
		resultUtil.setCount(pageInfo.getTotal());
		resultUtil.setData(pageInfo.getList());
		return resultUtil;
	}

	@Override
	public List<Admin> getAdminsList(Search search) {
		return adminDao.getAdminsList(search);
	}


	@Override
	public Admin getAdminById(int id) {
		return adminDao.getAdminById(id);
	}
	
	@Override
	public Admin getAdminByUsername(String username) {
		return adminDao.getAdminByUsername(username);
	}

	@Override
	public Admin getAdminByEmail(String email) {
		return adminDao.getAdminByEmail(email);
	}
	
	@Override
	public void updAdmin(Admin admin) {
		adminDao.updAdmin(admin);
	}

	@Override
	public void insAdmin(Admin admin) {
		admin.setPassword(MD5Utils.md5(admin.getPassword()));
		admin.setCreateTime(new Date());
		adminDao.insAdmin(admin);
	}

	@Override
	public void delAdminById(int id) {
		adminDao.delAdminById(id);
	}

	@Override
	public ResultUtil updateStatusById(int id, int status) {
		adminDao.updateStatusById(id,status);
		return ResultUtil.ok();
	}

	@Override
	public Map<String, Integer> getUserCount() {
		return adminDao.getUserCount();
	}


	@Override
	public ResultUtil updateEmail(int id , String email) {
		adminDao.updateEmail(id,email);
		return ResultUtil.ok();
	}


	/************************************AdminLog相关************************************/
	@Override
	public void insAdminLog(String username, String loginIp, Date loginTime,int roleId) {
		adminDao.insAdminLog(username, loginIp, loginTime,roleId);
	}

	@Override
	public ResultUtil getAdminLogsList(Integer page, Integer limit) {
		PageHelper.startPage(page, limit);
		List<AdminLog> adminLogs = adminDao.getAdminLogsList();
		PageInfo<AdminLog> pageInfo = new PageInfo<AdminLog>(adminLogs);
		for(AdminLog adminLog : adminLogs) {
			List<Role> roles = roleDao.selRoles();
			for(Role role : roles) {
				if(role.getRoleId() == adminLog.getRoleId()) {
					adminLog.setRoleName(role.getRoleName());
				}
			}
		}
		ResultUtil resultUtil = new ResultUtil();
		resultUtil.setCode(0);
		resultUtil.setCount(pageInfo.getTotal());
		resultUtil.setData(pageInfo.getList());
		return resultUtil;
	}

	@Override
	public Map<String, Integer> getLogCount() {
		return adminDao.getLogCount();
	}
	
	/************************************Role相关************************************/
	@Override
	public ResultUtil getRoles(Integer page, Integer limit) {
		PageHelper.startPage(page,limit);
		List<Role> roles = roleDao.selRoles();
		PageInfo<Role> pageInfo = new PageInfo<Role>(roles);
		ResultUtil resultUtil = new ResultUtil();
		resultUtil.setCode(0);
		resultUtil.setCount(pageInfo.getTotal());
		resultUtil.setData(pageInfo.getList());
		return resultUtil;
	}

	@Override
	public Role getRoleById(int id) {
		return roleDao.getRoleById(id);
	}

	@Override
	public List<Role> getRoles() {
		return roleDao.selRoles();
	}

	@Override
	public Role getRoleByRoleName(String roleName) {
		return roleDao.selectRoleByRoleName(roleName);
	}
	
	@Override
	public void updRole(Role role, String m) {
		roleDao.updateByKey(role);
		roleMenuDao.deleteMenusByRoleId(role.getRoleId());
		// 维护角色-菜单表
		if (m != null && m.length() != 0) {
			String[] result = m.split(",");
			// 重新赋予权限
			if (result != null && result.length > 0) {
				for (int i = 0; i < result.length; i++) {
					RoleMenu roleMenu = new RoleMenu();
					roleMenu.setMenuId(Integer.parseInt(result[i]));
					Menu menu = menuDao.getMenuById(Integer.parseInt(result[i]));
					roleMenu.setRoleId(role.getRoleId());
					// 维护角色—菜单表
					roleMenuDao.insert(roleMenu);
				}
			}
		}
	}

	@Override
	public void delRole(int roleId) {
		roleDao.delRole(roleId);
	}

	@Override
	public void insRole(Role role, String m) {
		roleDao.insertRole(role);
		Role role2 = roleDao.selectRoleByRoleName(role.getRoleName());
		if (m != null && m.length() != 0) {
			String[] result = m.split(",");
			// 重新赋予权限
			if (result != null && result.length > 0) {
				for (int i = 0; i < result.length; i++) {
					RoleMenu roleMenu = new RoleMenu();
					roleMenu.setMenuId(Integer.parseInt(result[i]));
					Menu menu = menuDao.getMenuById(Integer.parseInt(result[i]));
					roleMenu.setRoleId(role2.getRoleId());
					// 维护角色—菜单表
					roleMenuDao.insert(roleMenu);
				}
			}
		}
	}
	
	/************************************RoleMenu相关************************************/
	@Override
	public List<Menu> getXtreeData(Admin admin) {
		List<Menu> allMenus = menuDao.getAllMenus();
		int roleId = admin.getRoleId();
		if(roleId!=-1) {
			List<RoleMenu> roleMenus = roleMenuDao.selMenusByRoleId(roleId);
			for(Menu menu : allMenus) {
				for(RoleMenu roleMenu : roleMenus) {
					if(roleMenu.getMenuId() == menu.getMenuId()) {
						menu.setChecked("true");
					}
				}
			}
		}
		return allMenus;
	}
	
	/************************************Menu相关************************************/
	@Override
	public List<Menu> getMenus(Admin admin) {
		List<Menu> menuList = new ArrayList<Menu>();
		int roleId = admin.getRoleId();
		List<RoleMenu> roleMenus = roleMenuDao.selMenusByRoleId(roleId);

		if (roleMenus != null && roleMenus.size() > 0) {
			
			List<Menu> noChildrenMenus = new ArrayList<Menu>();
			for (int i = 0; i < roleMenus.size(); i++) {
				Menu menu = menuDao.getMenuById(roleMenus.get(i).getMenuId());
				noChildrenMenus.add(menu);
			}
			
			for (int i = 0; i < noChildrenMenus.size(); i++) {
				if (noChildrenMenus.get(i).getParentId() == 0) {
					Menu menu = new Menu();
					menu = noChildrenMenus.get(i);
					List<Menu> menus = new ArrayList<Menu>();
					for (int j = 0; j < noChildrenMenus.size(); j++) {
						if (noChildrenMenus.get(i).getMenuId() == noChildrenMenus.get(j).getParentId()) {
							Menu menu2 = new Menu();
							menu2 = noChildrenMenus.get(j);
							menus.add(menu2);
						}
					}
					menu.setChildren(menus);
					menuList.add(menu);

				}
			}

		}
		return menuList;
	}
	
	@Override
	public List<Menu> getAllMenus() {
		
		return menuDao.getAllMenus();
	}

	@Override
	public Menu getMenuById(int menuId) {
		return menuDao.getMenuById(menuId);
	}

	@Override
	public Menu getMenuByName(String name) {
		return menuDao.getMenuByName(name);
	}
	
	@Override
	public List<Menu> getMenusByParentId(int menuId) {
		return menuDao.getMenuByParentId(menuId);
	}
	
	@Override
	public void updMenuSortingById(Menu menu) {
		Menu m = menuDao.getMenuById(menu.getMenuId());
		m.setSorting(menu.getSorting());
		menuDao.updataMenuByKey(m);
	}

	@Override
	public List<Menu> checkNameSameLevel(Menu menus) {
		return menuDao.checkNameSameLevel(menus);
	}

	@Override
	public void updMenu(Menu menus) {
		menuDao.updataMenu(menus);
	}

	@Override
	public void insMenu(Menu menus) {
		menuDao.insMenu(menus);
	}

	@Override
	public void delMenuById(int menuId) {
		menuDao.delMenuById(menuId);
		roleMenuDao.deleteMenuByMenuId(menuId);
	}

}
