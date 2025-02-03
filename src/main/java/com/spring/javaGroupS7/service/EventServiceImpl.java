package com.spring.javaGroupS7.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaGroupS7.common.JavaGroupProvide;
import com.spring.javaGroupS7.dao.EventDAO;
import com.spring.javaGroupS7.vo.CouponsVO;
import com.spring.javaGroupS7.vo.EventsVO;
import com.spring.javaGroupS7.vo.UserCouponsVO;

@Service
public class EventServiceImpl implements EventService {
	
	@Autowired
	EventDAO eventDAO;
	@Autowired
	JavaGroupProvide javaGroupProvide;
	
	@Override
	public List<EventsVO> getEventList() {
		return eventDAO.getEventList();
	}

	@Override
	public int setEventInput(MultipartFile file1, EventsVO vo) {
		int res = 0;
		
		try {
			if(!file1.isEmpty()) {
				String oFileName = file1.getOriginalFilename();
				String sFileName = "s_"+javaGroupProvide.saveFileName(oFileName);
				String savePath = "shop/event";
				
				javaGroupProvide.writeFile(file1, sFileName, savePath);
				vo.setThumbnail(sFileName);
			}
			else {
				return res;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		//ckeditor img
		String content = vo.getContent();
		javaGroupProvide.imgCheck(content,"shop/event");
		vo.setContent(content.replace("/data/ckeditor/", "/data/shop/event/"));
		
		
		res = eventDAO.setEventInput(vo);
		
		return res;
	}

	@Override
	public EventsVO getEventInfo(int idx) {
		return eventDAO.getEventInfo(idx);
	}

	@Override
	public int setCoponDownload(String mid, String couponCode, UserCouponsVO vo) {
		CouponsVO couponVO = eventDAO.getCouponInfo(couponCode);
		
		int maxIdx = 1;
		UserCouponsVO maxVO = eventDAO.getUserCouponMaxIdx();
		System.out.println(maxVO);
		if(maxVO != null) {
			maxIdx = maxVO.getMaxIdx()+1;
			System.out.println(maxIdx);
		}
		vo.setUserCouponCode(couponCode+"-"+maxIdx);
		vo.setMid(mid);
		vo.setCouponIdx(couponVO.getIdx());
		vo.setCouponName(couponVO.getCouponName());
		vo.setDiscountType(couponVO.getDiscountType());
		vo.setDiscount(couponVO.getDiscount());
		
		return eventDAO.setCoponDownload(vo);
	}
}
