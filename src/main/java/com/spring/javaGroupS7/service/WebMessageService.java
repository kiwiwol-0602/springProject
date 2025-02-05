package com.spring.javaGroupS7.service;

import java.util.List;

import com.spring.javaGroupS7.vo.WebMessageVO;

public interface WebMessageService {

	List<WebMessageVO> getWmMessageList(String mid, int mSw, int startIndexNo, int pageSize);

	WebMessageVO getWmMessageContent(int idx, String mid);

	int setWmInputOk(WebMessageVO vo);

	int setwmDeleteCheck(int idx, int mFlag);
	
}
