package com.spring.javaGroupS7.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaGroupS7.dao.WebMessageDAO;
import com.spring.javaGroupS7.vo.WebMessageVO;

@Service
public class WebMessageServiceImpl implements WebMessageService {
	
	@Autowired
	WebMessageDAO webMessageDAO;

	@Override
	public List<WebMessageVO> getWmMessageList(String mid, int mSw, int startIndexNo, int pageSize) {
		return webMessageDAO.getWmMessageList(mid, mSw, startIndexNo, pageSize);
	}

	@Override
	public WebMessageVO getWmMessageContent(int idx, String mid) {
		//String receiveSw = webMessageDAO.getWmMessageReceiveSw(idx);
		webMessageDAO.setWmUpdate(idx,mid);
		return webMessageDAO.getWmMessageContent(idx, mid);
	}

	@Override
	public int setWmInputOk(WebMessageVO vo) {
		return webMessageDAO.setWmInputOk(vo);
	}

	@Override
	public int setwmDeleteCheck(int idx, int mFlag) {
		return webMessageDAO.setwmDeleteCheck(idx, mFlag);
	}
	
}
