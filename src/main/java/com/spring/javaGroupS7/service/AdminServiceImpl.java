package com.spring.javaGroupS7.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaGroupS7.dao.AdminDAO;
import com.spring.javaGroupS7.vo.BaesongVO;
import com.spring.javaGroupS7.vo.ProductOrderVO;
import com.spring.javaGroupS7.vo.ScheduleVO;
import com.spring.javaGroupS7.vo.UserVO;

@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	AdminDAO adminDAO;

	@Override
	public List<UserVO> getVisitCnt() {
		return adminDAO.getVisitCnt();
	}

	@Override
	public List<ProductOrderVO> getOrderCnt() {
		return adminDAO.getOrderCnt();
	}

	@Override
	public int setSaveSchedule(String title, String startDate, String endDate) {
		return adminDAO.setSaveSchedule(title, startDate, endDate);
	}

	@Override
	public List<ScheduleVO> getLoadSchedule() {
		return adminDAO.getLoadSchedule();
	}

	@Override
	public List<BaesongVO> getRefundList() {
		return adminDAO.getRefundList();
	}

	@Override
	public int getNewUserCnt() {
		return adminDAO.getNewUserCnt();
	}

	@Override
	public int getLeaveUserCnt() {
		return adminDAO.getLeaveUserCnt();
	}

	@Override
	public int getNewOrderCnt() {
		return adminDAO.getNewOrderCnt();
	}

	@Override
	public int getRefundCnt() {
		return adminDAO.getRefundCnt();
	}

	@Override
	public List<ProductOrderVO> getProductCnt() {
		return adminDAO.getProductCnt();
	}

	@Override
	public long getMonthlySales() {
		return adminDAO.getMonthlySales();
	}
}
