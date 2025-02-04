package com.spring.javaGroupS7.vo;

import lombok.Data;

@Data
public class ProductOrderVO {
  private int idx;
  private String orderIdx;
  private String mid;
  private int productIdx;
  private String productName;
  private int price;
  private int pay;
  private String thumbnail;
  private String optionName;
  private String optionPrice;
  private String optionNum;
  private int totalPay;
  private String orderDate;
  
  private int cartIdx;  // 장바구니 고유번호.
  private int maxIdx;   // 주문번호를 구하기위한 기존 최대 비밀번호필드
  private int baesong;  // 배송비저장필드
  private String userCouponCode;
  private int totalPrice;
  private int point;
  
  private String name;
  private String address;
  private String orderStatus;
  
  private int totOrderCnt;

  
  
  
  
}