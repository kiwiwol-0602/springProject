package com.spring.javaGroupS7.vo;

import lombok.Data;

@Data
	public class CustomerVO {
		private int idx;
		private String mid;
		private String pwd;
		private String name;
		private String tel;
		private String email;
		private String resident;
		private String address;
		private String gender;
		private String birthday;
		private String photo;
		private String userInfor;
		private String userDel;
		private int level;
		private int point;
		private int visitCnt;
		private int todayCnt;
		private String joinDay;
		private String lastDate;
		
		private String tempMid;	  // 아이디 중복체크를위한 임시 아이디
		private int elapsed_date;	// 최종접속 경과일(탈퇴시 사용)
		//private String strUserDel; // OK:탈퇴신청 , NO:활동중
		
		private String tel1;
		private String tel2;
		private String tel3;
		private String postcode;
		private String roadAddress;
		private String detailAddress;
		private String extraAddress;
		private String currentPwd;
		private String newPwd;
}
