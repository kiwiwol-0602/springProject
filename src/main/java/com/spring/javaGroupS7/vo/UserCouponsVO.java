package com.spring.javaGroupS7.vo;

import lombok.Data;

@Data
public class UserCouponsVO {
	private int idx;
	private int couponIdx;
	private String mid;
	private String userCouponCode;
	private String used;
	private String usedDate;
}
