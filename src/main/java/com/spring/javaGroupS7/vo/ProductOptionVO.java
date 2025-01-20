package com.spring.javaGroupS7.vo;

import lombok.Data;

@Data
public class ProductOptionVO {
	private int idx;
	private String optionName;
	private int productIdx;
	private int price;
	private int quantity;
	
	private String productName;
}
