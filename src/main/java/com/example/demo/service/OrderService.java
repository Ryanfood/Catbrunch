package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.dao.OrderDao;
import com.example.demo.dao.OrderItemDao;
import com.example.demo.model.dto.OrderDto;
import com.example.demo.model.dto.OrderItemDto;
import com.example.demo.model.po.Order;
import com.example.demo.model.po.OrderItem;

@Service
public class OrderService {
	
	@Autowired
	private OrderDao orderDao;
	
	@Autowired
	private OrderItemDao orderItemDao;
	
	// 取得多筆 Order
	public List<Order> getAllOrder() {
		return orderDao.findAllOrder();
	}
	
	//取得多筆 OrderItem
	public List<OrderItem> getAllOrderItem() {
		return orderItemDao.fintAllOrderItem();
	}
	
	
    // 取得單筆 Order
    public Order findOrderById(Integer orderId) {
        return orderDao.findOrderById(orderId);
    }

    // 取得多筆 OrderItems
    public List<OrderItem> getOrderItemById(Integer orderId) {
        return orderItemDao.findOrderItemById(orderId);
    }
	
	
	
	
	// 取得單筆 order
	public Order getOrderById(Integer orderId) {
		return orderDao.findOrderById(orderId);
	}
	
	/*
	// 取得單筆 orderItem
	public OrderItem getOrderItemById(Integer orderId) {
		System.out.println("Order item fetched from database: " + orderId);
		return orderItemDao.findOrderItemById(orderId);
	}
	*/
	
	// 新增 order
	@Transactional
    public void createOrder(OrderDto orderDto) {
        // Insert order and get generated order_id
        int orderId = orderDao.createOrder(orderDto);

        // Insert order items
        for (OrderItemDto item : orderDto.getItems()) {
            orderDao.createOrderItem(orderId, item);
        }
    }
	
	
	/* 原本的
	// 新增 order
	public int createOrder(Order order, OrderItem orderItem) {
		orderDao.createOrder(order, orderItem);
		orderItemDao.createOrderItem(orderItem);
		return orderDao.createOrder(order, orderItem);
	}
	*/
	
	// 刪除 order
	@Transactional
    public void deleteOrder(Integer orderId) {
        orderDao.deleteOrder(orderId);
    }
	
	
	// 判斷要呼叫DAO語法幾次
	
	

}
