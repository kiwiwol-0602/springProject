package com.spring.javaGroupS7.vo;

import lombok.Data;

@Data
public class CouponsVO {
	private int idx;
	private String couponCode;
	private String couponName;
	private String discountType;
	private int discount;
	private int minOrderPay;
	private String expirationDate;
	private String active;
}
