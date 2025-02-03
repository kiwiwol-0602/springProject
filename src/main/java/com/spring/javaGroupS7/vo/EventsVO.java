package com.spring.javaGroupS7.vo;

import lombok.Data;

@Data
public class EventsVO {
	private int idx;
	private String title;
	private String subTitle;
	private String thumbnail;
	private String content;
	private String startDate;
	private String endDate;
	private String active;
	private String couponCode;
}
