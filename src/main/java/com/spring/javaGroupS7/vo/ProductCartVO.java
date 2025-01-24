package com.spring.javaGroupS7.vo;

import lombok.Data;

@Data
public class ProductCartVO {
	private int idx;
	private String mid;
	private String productCode;
	private int productIdx;
	private String productName;
	private int price;
	private int pay;
	private String thumbnail;
	private String optionIdx;
	private String optionName;
	private String optionPrice;
	private String optionNum;
	private int totalPrice;
	private String cartDate;
	
	private String userCouponCode;
}
