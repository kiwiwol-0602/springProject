package com.spring.javaGroupS7.vo;

import lombok.Data;

@Data
public class BaesongVO {
  private int idx;
  private int oIdx;
  private String orderIdx;
  private int totalPay;
  private String mid;
  private String name;
  private String address;
  private String tel;
  private String message;
  private String payment;
  private String payMethod;
  private String orderStatus;
  
  // 아래는 주문테이블에서 사용된 필드리스트이다.
	private int productIdx;
	private String orderDate;
	private String productName;
	private String thumbnail;
	private String optionName;
	private String optionPrice;
	private String optionNum;
	private int totalPrice;
	private int totalDiscount;
	private String userCouponCode;
	private int point;
	
	
}
