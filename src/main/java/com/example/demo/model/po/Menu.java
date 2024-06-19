package com.example.demo.model.po;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Menu {
	private Integer menuId;
	private String mealName;
	private String mealType;
	private String description;
	private Integer mealPrice;
	private String mealImage;
}
