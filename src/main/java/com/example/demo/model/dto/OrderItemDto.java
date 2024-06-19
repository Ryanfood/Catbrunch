package com.example.demo.model.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrderItemDto {
	private String orderName; // 餐點名稱
	private Integer quantity; // 餐點數量
	private Integer price; // 餐點價格

}
