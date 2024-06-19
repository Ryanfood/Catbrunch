package com.example.demo.dao;

import java.util.List;

import com.example.demo.model.po.OrderItem;

public interface OrderItemDao {
	List<OrderItem> findOrderItemById(Integer OrderItemId);  // 單筆查詢
}
