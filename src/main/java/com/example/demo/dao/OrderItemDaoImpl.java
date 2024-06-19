package com.example.demo.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.example.demo.model.po.OrderItem;

//OrderItemDao 的實現類，使用 JDBC 來執行資料庫操作
@Repository
public class OrderItemDaoImpl implements OrderItemDao{

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	// 根據 OrderID 單筆查詢，查不到會有 DataAccess 例外
	@Override
	public List<OrderItem> findOrderItemById(Integer orderId) {
		String sql = "SELECT order_id, order_name, quantity, price FROM order_items WHERE order_id = ?";
		
		try {
			return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(OrderItem.class), orderId);
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}

	


	
	// service呼叫 DAO 執行動作
}
