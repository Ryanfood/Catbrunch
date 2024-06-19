package com.example.demo.dao;

import java.util.List;

import com.example.demo.model.po.Menu;

public interface MenuDao {
	List<Menu> findAllMenu(); // 多筆查詢
	Menu findMenuById(Integer menuId); // 單筆查詢
	int createMenu(Menu menu); // 新增
	int updateMenu(Integer menuId, Menu menu); // 修改
	int deleteMenu(Integer menuId); // 刪除
}
