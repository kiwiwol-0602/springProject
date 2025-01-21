package com.spring.javaGroupS7.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaGroupS7.vo.UserVO;

public interface MemberService {

	UserVO getMemberIdDuplicationCheck(String mid);

	int setMemberJoin(UserVO vo);

	boolean getDuplicateEmailExist(String email);

	UserVO getMemberIdCheck(String mid);

	void setMemberDatePointUpdate(String mid, int todayCnt);

	UserVO getFindIdCheck(String name, String email, String tel);

	int getInforCheck(String mid, String email);

	void setimsiPwd(String mid, String email, String pwd);

	void setKakaoMemberInput(String mid, String name, String email, String imsiPwd);

	int setMemberDelete(String mid);

	int setMemberUpdate(UserVO vo, MultipartFile fName);

	List<UserVO> getUserList(int level);

	int setMemberDeleteOk(String mid);

	UserVO getUser(String mid);

	
}
