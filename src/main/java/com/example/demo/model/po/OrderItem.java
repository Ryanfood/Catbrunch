package com.example.demo.model.po;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderItem {
	private Integer orderItemId;
	private Integer orderId;
	private String orderName; // 餐點名稱
	private Integer quantity; // 餐點數量
	private Integer price; // 餐點價格
}
