package com.spring.javaGroupS7.service;

import java.util.List;

import com.spring.javaGroupS7.vo.BaesongVO;
import com.spring.javaGroupS7.vo.ProductOrderVO;
import com.spring.javaGroupS7.vo.ScheduleVO;
import com.spring.javaGroupS7.vo.UserVO;

public interface AdminService {

	List<UserVO> getVisitCnt();

	List<ProductOrderVO> getOrderCnt();

	int setSaveSchedule(String title, String startDate, String endDate);

	List<ScheduleVO> getLoadSchedule();

	List<BaesongVO> getRefundList();

	int getNewUserCnt();

	int getLeaveUserCnt();

	int getNewOrderCnt();

	int getRefundCnt();

	List<ProductOrderVO> getProductCnt();

	long getMonthlySales();

}
