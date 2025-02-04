package com.spring.javaGroupS7.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaGroupS7.vo.EventsVO;
import com.spring.javaGroupS7.vo.UserCouponsVO;

public interface EventService {

	List<EventsVO> getEventList(String user);

	int setEventInput(MultipartFile file1, EventsVO vo);

	EventsVO getEventInfo(int idx);

	int setCoponDownload(String mid, String couponCode, UserCouponsVO vo);

	String setEventActiveChangePost(int idx, String variable);

	void updateActiveStatus(LocalDate today);

	void updateCouponStatus(LocalDate today);

}
