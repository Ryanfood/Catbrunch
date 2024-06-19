package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.MenuDao;
import com.example.demo.model.po.Menu;

@Service
public class MenuService{
	
	@Autowired
	private MenuDao menuDao;
	
	// 取得多筆 menu
	public List<Menu> getAllMenu() {
		return menuDao.findAllMenu();
	}

	// 取得單筆 menu
	public Menu getMenuById(Integer menuId) {
		return menuDao.findMenuById(menuId);
	}

	// 新增 menu
	public int createMenu(Menu menu) {
		return menuDao.createMenu(menu);
	}

	// 修改 menu
	public int updateMenu(Integer menuId, Menu menu) {
		return menuDao.updateMenu(menuId, menu);
	}

	// 刪除 menu
	public int deleteMenu(Integer menuId) {
		return menuDao.deleteMenu(menuId);
	}

}
