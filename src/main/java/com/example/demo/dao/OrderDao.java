package com.example.demo.dao;

import java.util.List;

import com.example.demo.model.dto.OrderDto;
import com.example.demo.model.dto.OrderItemDto;
import com.example.demo.model.po.Order;

public interface OrderDao {
	List<Order> findAllOrder(); // 多筆查詢 Order
	Order findOrderById(Integer orderId); // 單筆查詢
	int createOrder(OrderDto orderDto); // 新增 Order
    void createOrderItem(Integer orderId, OrderItemDto orderItemDto); // 新增 Order 明細
    int deleteOrder(Integer orderId); // 刪除
}
