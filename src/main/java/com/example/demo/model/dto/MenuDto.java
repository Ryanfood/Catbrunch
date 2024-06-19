package com.example.demo.model.dto;

import com.example.demo.model.po.Menu;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MenuDto {
	private Integer menuId;
	private String mealName;
	private String mealType;
	private String description;
	private Integer mealPrice;
	private String mealImage;
	
	private Menu menu;

}
