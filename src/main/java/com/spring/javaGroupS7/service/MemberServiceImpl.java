package com.spring.javaGroupS7.service;

import java.io.IOException;
import java.util.List;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaGroupS7.common.JavaGroupProvide;
import com.spring.javaGroupS7.dao.MemberDAO;
import com.spring.javaGroupS7.vo.UserVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memberDAO;
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	@Autowired
	JavaGroupProvide javaGroupProvide;

	@Override
	public UserVO getMemberIdDuplicationCheck(String mid) {
		return memberDAO.getMemberIdDuplicationCheck(mid);
	}

	@Override
	public int setMemberJoin(UserVO vo) {
		String birthdayStr = vo.getBirthday();
		String genderStr = vo.getGender();
		
		String birthday = "";
		String gender = "";
		
		// 성별 변환	
		if(genderStr.equals("1")||genderStr.equals("3")) {
			gender = "남성";
		}
		else {
			gender = "여성";
		}
		
		// 생년월일 변환	
		if(genderStr.equals("1")||genderStr.equals("2")) {
			String year = "19" + birthdayStr.substring(0, 2);
      String month = birthdayStr.substring(2, 4);       
      String day = birthdayStr.substring(4, 6);
      
      birthday = year + "-" + month + "-" + day;
		}
		else if(genderStr.equals("3")||genderStr.equals("4")){
			String year = "20" + birthdayStr.substring(0, 2);
      String month = birthdayStr.substring(2, 4);       
      String day = birthdayStr.substring(4, 6);
      
      birthday = year + "-" + month + "-" + day;
		}
		else {
			birthday = "1900-01-01";
		}
		
		vo.setBirthday(birthday);
		vo.setGender(gender);
		
		System.out.println("Birthday: " + vo.getBirthday());
		System.out.println("Gender: " + vo.getGender());
		
		return memberDAO.setMemberJoin(vo);
	}

	@Override
	public boolean getDuplicateEmailExist(String email) {
		return memberDAO.getDuplicateEmailExist(email) > 0;
	}

	@Override
	public UserVO getMemberIdCheck(String mid) {
		return memberDAO.getMemberIdCheck(mid);
	}

	@Override
	public void setMemberDatePointUpdate(String mid, int todayCnt) {
		memberDAO.setMemberDatePointUpdate(mid, todayCnt);
		
	}

	@Override
	public UserVO getFindIdCheck(String name, String email, String tel) {
		return memberDAO.getFindIdCheck(name, email, tel);
	}

	@Override
	public int getInforCheck(String mid, String email) {
		return memberDAO.getInforCheck(mid, email);
	}

	@Override
	public void setimsiPwd(String mid, String email, String pwd) {
		memberDAO.setimsiPwd(mid, email, pwd);
		
	}

	@Override
	public void setKakaoMemberInput(String mid, String name, String email, String imsiPwd) {
		memberDAO.setKakaoMemberInput(mid, name, email, imsiPwd);
	}

	@Override
	public int setMemberDelete(String mid) {
		return memberDAO.setMemberDelete(mid);
	}

	@Override
	public int setMemberUpdate(UserVO vo, MultipartFile fName) {
		
		String birthdayStr = vo.getBirthday();
		String genderStr = vo.getGender();
		String birthday = "";
		String gender = "";
		
		
		if(!fName.isEmpty()) {
			String imsi = RandomStringUtils.randomAlphanumeric(4);
			
			//서버로 전송되어온 파일의 정보를 읽어온다.
			String oFileName = fName.getOriginalFilename();
			String sFileName = vo.getMid() + "_" + imsi + "_" + oFileName;
			String savePath = "member";
			
			if(vo.getPhoto() != "noimage.jpg" && sFileName != vo.getPhoto()) {
				javaGroupProvide.deleteFile(vo.getPhoto(),savePath);
			}
			
			
			// 서버에 파일 올리기
			try {
				javaGroupProvide.writeFile(fName, sFileName, savePath);
				vo.setPhoto(sFileName);
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		
		// 비밀번호처리
		if(vo.getPwd() != null && !vo.getPwd().equals("")) {
			vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		}
		
		// 성별 변환	
		if(genderStr.equals("1")||genderStr.equals("3")) {
			gender = "남성";
		}
		else {
			gender = "여성";
		}
		vo.setGender(gender);
		
		
		// 생년월일 변환	
		if(genderStr.equals("1")||genderStr.equals("2")) {
			String year = "19" + birthdayStr.substring(0, 2);
      String month = birthdayStr.substring(2, 4);       
      String day = birthdayStr.substring(4, 6);
      
      birthday = year + "-" + month + "-" + day;
		}
		else if(genderStr.equals("3")||genderStr.equals("4")){
			String year = "20" + birthdayStr.substring(0, 2);
      String month = birthdayStr.substring(2, 4);       
      String day = birthdayStr.substring(4, 6);
      
      birthday = year + "-" + month + "-" + day;
		}
		else {
			birthday = "1900-01-01";
		}
		vo.setBirthday(birthday);
		
		
		
		System.out.println("service vo:" + vo);
		return memberDAO.setMemberUpdate(vo);
	}


	@Override
	public List<UserVO> getUserList(int level) {
		return memberDAO.getUserList(level);
	}

	@Override
	public int setMemberDeleteOk(String mid) {
		return memberDAO.setMemberDeleteOk(mid);
	}


}
