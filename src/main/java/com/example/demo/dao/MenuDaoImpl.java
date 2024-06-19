package com.example.demo.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.example.demo.model.po.Menu;

//MenuDao 的實現類，使用 JDBC 來執行資料庫操作
@Repository
public class MenuDaoImpl implements MenuDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;

	// 查詢所有
	@Override
	public List<Menu> findAllMenu() {
		String sql = "SELECT menu_id, meal_name, meal_type, description, meal_price, meal_image FROM menu";
		return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Menu.class));
	}

	// 根據 ID 單筆查詢，查不到會有 DataAccess 例外
	@Override
	public Menu findMenuById(Integer menuId) {
		String sql = "SELECT menu_id, meal_name, meal_type, description, meal_price, meal_image FROM menu WHERE menu_id = ?";
		
		try {
			return jdbcTemplate.queryForObject(sql, new BeanPropertyRowMapper<>(Menu.class), menuId);
		} catch (DataAccessException e) {
			e.printStackTrace();
			return null;
		}
	}

	// 新增
	@Override
	public int createMenu(Menu menu) {
		String sql = "INSERT INTO menu (meal_name, meal_type, description, meal_price, meal_image) VALUES (?, ?, ?, ?, ?)";
		return jdbcTemplate.update(sql, menu.getMealName(), menu.getMealType(), menu.getDescription(), menu.getMealPrice(), menu.getMealImage());
	}

	// 修改
	@Override
	public int updateMenu(Integer menuId, Menu menu) {
		String sql = "UPDATE menu SET meal_name = ?, meal_type = ?, description = ?, meal_price = ?, meal_image = ? WHERE menu_id = ?";
		return jdbcTemplate.update(sql, menu.getMealName(), menu.getMealType(), menu.getDescription(), menu.getMealPrice(), menu.getMealImage(), menuId);
	}

	// 刪除
	@Override
	public int deleteMenu(Integer menuId) {
		String sql = "DELETE FROM menu WHERE menu_id = ?";
		return jdbcTemplate.update(sql, menuId);
	}


}
