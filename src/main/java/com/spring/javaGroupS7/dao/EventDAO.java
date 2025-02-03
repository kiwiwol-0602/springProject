package com.spring.javaGroupS7.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaGroupS7.vo.CouponsVO;
import com.spring.javaGroupS7.vo.EventsVO;
import com.spring.javaGroupS7.vo.UserCouponsVO;

public interface EventDAO {
	
	List<EventsVO> getEventList();

	int setEventInput(@Param("vo") EventsVO vo);

	EventsVO getEventInfo(@Param("idx") int idx);

	UserCouponsVO getUserCouponMaxIdx();

	CouponsVO getCouponInfo(@Param("couponCode") String couponCode);

	int setCoponDownload(@Param("vo") UserCouponsVO vo);

	int setEventActiveChangePost(@Param("idx") int idx, @Param("variable") String variable);

}
