package com.spring.javaGroupS7.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaGroupS7.vo.BaesongVO;
import com.spring.javaGroupS7.vo.ProductOrderVO;
import com.spring.javaGroupS7.vo.ScheduleVO;
import com.spring.javaGroupS7.vo.UserVO;

public interface AdminDAO {

	List<UserVO> getVisitCnt();

	List<ProductOrderVO> getOrderCnt();

	int setSaveSchedule(@Param("title") String title, @Param("startDate") String startDate, @Param("endDate") String endDate);

	List<ScheduleVO> getLoadSchedule();

	List<BaesongVO> getRefundList();

	int getNewUserCnt();

	int getLeaveUserCnt();

	int getNewOrderCnt();

	int getRefundCnt();

	List<ProductOrderVO> getProductCnt();

	int getMonthlySales();

}
