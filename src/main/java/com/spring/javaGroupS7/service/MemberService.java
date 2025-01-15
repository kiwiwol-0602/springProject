package com.spring.javaGroupS7.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaGroupS7.vo.CustomerVO;

public interface MemberService {

	CustomerVO getMemberIdDuplicationCheck(String mid);

	int setMemberJoin(CustomerVO vo);

	boolean getDuplicateEmailExist(String email);

	CustomerVO getMemberIdCheck(String mid);

	void setMemberDatePointUpdate(String mid, int todayCnt);

	CustomerVO getFindIdCheck(String name, String email, String tel);

	int getInforCheck(String mid, String email);

	void setimsiPwd(String mid, String email, String pwd);

	void setKakaoMemberInput(String mid, String name, String email, String imsiPwd);

	int setMemberDelete(String mid);

	int setMemberUpdate(CustomerVO vo, MultipartFile fName);

	List<CustomerVO> getUserList(int level);

	int setMemberDeleteOk(String mid);

	
}
