package com.spring.javaGroupS7.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaGroupS7.vo.UserVO;

public interface MemberDAO {

	UserVO getMemberIdDuplicationCheck(@Param("mid") String mid);

	int setMemberJoin(@Param("vo") UserVO vo);

	int getDuplicateEmailExist(@Param("email") String email);

	UserVO getMemberIdCheck(@Param("mid") String mid);

	void setMemberDatePointUpdate(@Param("mid") String mid, @Param("todayCnt") int todayCnt);

	UserVO getFindIdCheck(@Param("name") String name, @Param("email") String email, @Param("tel") String tel);

	int getInforCheck(@Param("mid") String mid, @Param("email") String email);

	void setimsiPwd(@Param("mid") String mid, @Param("email") String email, @Param("pwd") String pwd);

	void setKakaoMemberInput(@Param("mid") String mid, @Param("name") String name, @Param("email") String email, @Param("imsiPwd") String imsiPwd);

	int setMemberDelete(@Param("mid") String mid);

	int setMemberUpdate(@Param("vo") UserVO vo);

	List<UserVO> getUserList(@Param("level") int level);

	int setMemberDeleteOk(@Param("mid") String mid);

	UserVO getUser(@Param("mid") String mid);


}
