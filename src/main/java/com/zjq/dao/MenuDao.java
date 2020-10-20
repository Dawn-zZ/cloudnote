package com.zjq.dao;

import java.util.List;

import com.zjq.entity.Menu;

public interface MenuDao {

	Menu getMenuById(int menuId);

	List<Menu> getAllMenus();

	void updataMenuByKey(Menu m);

	List<Menu> checkNameSameLevel(Menu menus);

	Menu getMenuByName(String name);

	void updataMenu(Menu menus);

	void insMenu(Menu menus);

	List<Menu> getMenuByParentId(int menuId);

	void delMenuById(int menuId);

}
