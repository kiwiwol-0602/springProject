package com.spring.javaGroupS7.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaGroupS7.common.JavaGroupProvide;
import com.spring.javaGroupS7.service.MemberService;
import com.spring.javaGroupS7.service.ShopService;
import com.spring.javaGroupS7.vo.UserVO;

@Controller
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	ShopService shopService;
	
	@Autowired
	JavaGroupProvide javaGroupProvide;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	
	// 로그인 폼
	@GetMapping(value = "/memberLogin")
	public String memberLoginGet(HttpServletRequest request) {
	// 로그인창의 아이디 체크 유무에 대한 처리(쿠키)
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cMid")) {
					request.setAttribute("cMid", cookies[i].getValue());
					break;
				}
			}
		}
		return "member/memberLogin";
	}
	
	// 일반 로그인
	@PostMapping(value="/memberLogin")
	public String memberLoginPost(HttpServletRequest request, HttpServletResponse response, HttpSession session, String mid, String pwd,
			@RequestParam(defaultValue = "", required = false) String idSave
		) {
		
		UserVO vo = memberService.getMemberIdCheck(mid);

		if(vo != null) {
			if(passwordEncoder.matches(pwd, vo.getPwd())) {
				// 로그인 인증완료시 세션처리
				String strLevel = "";
				if(vo.getLevel() == 0) strLevel = "관리자";
				else if(vo.getLevel() == 1) strLevel = "고객";
				//else if(vo.getLevel() == 2) strLevel = "파트너";
				
				session.setAttribute("sMid", mid);
				session.setAttribute("sLevel", vo.getLevel());
				session.setAttribute("strLevel", strLevel);
				
				// 로그인창의 아이디 체크 유무에 대한 처리(쿠키 저장/삭제)
				if(idSave.equals("on")) {
					Cookie cookieMid = new Cookie("cMid", mid);
					cookieMid.setPath("/");
					cookieMid.setMaxAge(60*60*24*7); // 7일간저장
					response.addCookie(cookieMid);
				}
				else {
					Cookie[] cookies = request.getCookies();
					if(cookies != null) {
						for(int i=0; i<cookies.length; i++) {
							if(cookies[i].getName().equals("cMid")) {
								cookies[i].setPath("/");
								cookies[i].setMaxAge(0); // 쿠키삭제
								response.addCookie(cookies[i]);
								break;
							}
						}
					}
				}
				
				// DB처리 내용 작업하기(방문포인트, 총방문횟수, 오늘방문횟수, 마지막방문일자)
				// 오늘 방문횟수 처리
				Date nowDate = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				String strDate = sdf.format(nowDate);
				
				int todayCnt = 0;
				
				if(vo.getLastDate().substring(0, 10).equals(strDate)) {
					todayCnt = vo.getTodayCnt() + 1;
				}
				else {
					todayCnt = 1;
				}
				
				memberService.setMemberDatePointUpdate(mid, todayCnt);
				
				return "redirect:/message/memberLoginOk?mid="+mid;
			}
		}
		return "redirect:/message/memberLoginNo";
	}
	
	// 카카오 로그인 인증처리
	@SuppressWarnings("unused")
	@GetMapping(value = "/kakaoLogin")
	public String kakaoLoginGet(HttpSession session, HttpServletRequest request,
			@RequestParam String name,
			@RequestParam String email, 
			@RequestParam String accessToken
		) throws MessagingException {
		session.setAttribute("sAccessToken", accessToken);
		session.setAttribute("sLogin", "kakao");
		
		// 카카오회원이 우리 회원인지 조사?
		Boolean duplicateEmail = memberService.getDuplicateEmailExist(email);
		
		// 카카오회원이 우리회원이 아니라면 자동으로 우리회원에 가입처리한다.
		// 필수입력:아이디, 이메일, 성명(닉네임으로 대체), 비밀번호(임시비밀번호 발급처리), 레벨:1
		String newMember = "NO";	// 신규회원은 OK, 기존회원은 NO
		String mid = email.substring(0, email.indexOf("@"));
		
		if(!duplicateEmail) { 
			// 신규회원인지에 대한 체크하기....
			UserVO userVO = memberService.getMemberIdCheck(mid);
			
			if(userVO != null) return "redirect:/message/memberIdSameCheck";
		
			// 임시 비밀번호 발급처리
			String pwd = UUID.randomUUID().toString().substring(0, 8);
			session.setAttribute("sImsiPwd", pwd);
			
			// 새로 발급된 비밀번호를 암호화 시켜서 DB에 저장처리한다. 이때 카카오로그인한 회원은 바로 정회원으로 등업처리한다.
			String imsiPwd = passwordEncoder.encode(pwd);
			memberService.setKakaoMemberInput(mid, name, email, imsiPwd);
			
			// 새로 발급받은 임시비밀번호를 메일로 전송처리
			String mailFlag="";
			mailFlag = "<html>"
	        + "<body>"
	        + "<div style='font-family: Arial, sans-serif; line-height: 1.6;'>"
	        + "<img src='cid:lumi.png' style='max-width: 400px; height: auto; border-radius: 8px;'>"
	        + "<h2 style='color: #000B58;'>LUMI 임시 비밀번호 발급</h2>"
	        + "<p>안녕하세요,</p>"
	        + "<p>LUMI 로그인을 위한 임시 비밀번호는 다음과 같습니다.</p>"
	        + "<h3 style='background-color: #f0f0f0; width:400px; padding: 10px; color: #333; border-radius: 5px; text-align: center;'>"
	        + "<strong>" + pwd + "</strong>"
	        + "</h3>"
	        + "<p>위의 발급받은 임시 비밀번호로 로그인 한 후 마이페이지에서 비밀번호를 변경해주세요.</p>"
	        + "<p>감사합니다.</p><br/>"
	        + "<hr>"
	        + "<p style='font-size: 0.9em; color: #555;'>본 메일은 자동으로 발송된 메일입니다.</p>"
	        + "</div>"
	        + "</body>"
	        + "</html>";
			
			String photoName = "lumi.png";
			
			javaGroupProvide.mailSend(email, "[Lumi] 로그인을 위한 임시 비밀번호입니다.", mailFlag, photoName, request);
			
			
			// 신규회원은 비밀번호를 새로발급하였기에, memberMain창에서 '개인정보/비밀번호'를 변경하라는 메세지를 지속적으로 뿌리기 위함.
			session.setAttribute("sLoginNew", "OK");
			newMember = "OK";
		}
			// 로그인 인증완료시 세션처리
			
			UserVO vo = memberService.getMemberIdCheck(mid);
			
			String strLevel = "";
			if(vo.getLevel() == 0) strLevel = "관리자";
			else if(vo.getLevel() == 1) strLevel = "고객";
			//else if(vo.getLevel() == 2) strLevel = "파트너";
			
			session.setAttribute("sMid", vo.getMid());
			session.setAttribute("sName", vo.getName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("strLevel", strLevel);
			
			
			// DB처리 내용 작업하기(방문포인트, 총방문횟수, 오늘방문횟수, 마지막방문일자)
			// 오늘 방문횟수 처리
			Date nowDate = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String strDate = sdf.format(nowDate);
			
			int todayCnt = 0;
			
			if(vo.getLastDate().substring(0, 10).equals(strDate)) {
				todayCnt = vo.getTodayCnt() + 1;
			}
			else {
				todayCnt = 1;
			}
			memberService.setMemberDatePointUpdate(mid, todayCnt);
			
			return "redirect:/message/memberLoginOk?mid="+vo.getMid();
	}
	
	//로그아웃
	@GetMapping(value = "memberLogout")
	public String memberLogoutGet(HttpSession session) {
		session.invalidate();
		return "redirect:/message/memberLogout";
	}
	
	
	
	//회원 아이디 중복체크
	@ResponseBody
	@PostMapping(value = "/memberIdDuplicationCheck")
	public String memberIdDuplicationCheckPost(String mid) {
		UserVO vo = memberService.getMemberIdDuplicationCheck(mid);
		String str = "0";
		if(vo != null) str = "1";
		return str;
	}
	
	//회원가입시 이메일로 인증번호 발송하기
	@ResponseBody
	@PostMapping(value = "/memberEmailCheck")
	public String memberEmailCheckPost(HttpSession session, HttpServletRequest request, String email ) throws MessagingException {
		// 1. 이메일 중복 체크
    boolean duplicateEmail = memberService.getDuplicateEmailExist(email);
    if (duplicateEmail) {
        // 이미 사용 중인 이메일일 경우, 중복 메시지 반환
        return "1";
    }
    
    // 2. 이메일 중복이 없다면 인증 메일 발송
		String emailKey = UUID.randomUUID().toString().substring(0, 8);
		session.setAttribute("sEmailKey", emailKey);
		
		String mailFlag="";
		mailFlag = "<html>"
        + "<body>"
        + "<div style='font-family: Arial, sans-serif; line-height: 1.6;'>"
        + "<img src='cid:lumi.png' style='max-width: 400px; height: auto; border-radius: 8px;'>"
        + "<h2 style='color: #000B58;'>LUMI 회원가입 인증 번호</h2>"
        + "<p>안녕하세요,</p>"
        + "<p>LUMI 회원가입을 위한 인증 번호는 다음과 같습니다.</p>"
        + "<h3 style='background-color: #f0f0f0; width:400px; padding: 10px; color: #333; border-radius: 5px; text-align: center;'>"
        + "<strong>" + emailKey + "</strong>"
        + "</h3>"
        + "<p>위의 인증 번호를 인증 페이지에 입력하여 이메일을 인증해주세요.</p>"
        + "<p>감사합니다.</p><br/>"
        + "<hr>"
        + "<p style='font-size: 0.9em; color: #555;'>본 메일은 자동으로 발송된 메일입니다.</p>"
        + "</div>"
        + "</body>"
        + "</html>";
		
		
		String photoName = "lumi.png";
		
		javaGroupProvide.mailSend(email, "[Lumi] 회원가입 이메일 인증번호입니다.", mailFlag, photoName, request);
		
		return "2";
	}
	
	// 회원가입시 이메일로전송받은 인증번호 확인하기
	@ResponseBody
	@PostMapping(value = "/memberEmailCheckOk")
	public String memberEmailCheckPost(HttpSession session, String checkKey){
		String emailKey = (String) session.getAttribute("sEmailKey");
		if(emailKey.equals(checkKey))	return "1";
		else return "0";
	}
	
	// 회원가입
	@PostMapping(value = "/memberJoin")
	public String memberJoinPost(UserVO vo) {
		vo.setPwd(passwordEncoder.encode(vo.getPwd()));
		
		int res = memberService.setMemberJoin(vo);
		
		if(res != 0) {
			return "redirect:/message/memberJoinOk";
		}
		else {
			return "redirect:/message/memberJoinNo";
		}
	}
	
	// 계정찾기
	@GetMapping(value = "/searchAccount")
	public String searchAccountGet(String name) {
		return "member/searchAccount";
	}
	
	// 아이디찾기
	@PostMapping(value = "/findId")
	public String findIdPost(Model model, String name,
			@RequestParam(defaultValue = "", required = false) String email,
			@RequestParam(defaultValue = "", required = false) String tel
			) {
		
		UserVO vo = memberService.getFindIdCheck(name, email, tel);
		
		model.addAttribute("vo",vo);
		
		return "member/searchId";
	}
	
	//이메일로 인증번호 발송하기
	@ResponseBody
	@PostMapping(value = "/emailCheck")
	public String emailCheckPost(HttpSession session, HttpServletRequest request, String email ) throws MessagingException {
		String emailKey = UUID.randomUUID().toString().substring(0, 8);
		session.setAttribute("sEmailKey", emailKey);
		
		String mailFlag="";
		mailFlag = "<html>"
        + "<body>"
        + "<div style='font-family: Arial, sans-serif; line-height: 1.6;'>"
        + "<img src='cid:lumi.png' style='max-width: 400px; height: auto; border-radius: 8px;'>"
        + "<h2 style='color: #000B58;'>LUMI 이메일 인증 번호</h2>"
        + "<p>안녕하세요,</p>"
        + "<p>LUMI 이메일 인증 번호는 다음과 같습니다.</p>"
        + "<h3 style='background-color: #f0f0f0; width:400px; padding: 10px; color: #333; border-radius: 5px; text-align: center;'>"
        + "<strong>" + emailKey + "</strong>"
        + "</h3>"
        + "<p>위의 인증 번호를 인증 페이지에 입력하여 이메일을 인증해주세요.</p>"
        + "<p>감사합니다.</p><br/>"
        + "<hr>"
        + "<p style='font-size: 0.9em; color: #555;'>본 메일은 자동으로 발송된 메일입니다.</p>"
        + "</div>"
        + "</body>"
        + "</html>";
		
		
		String photoName = "lumi.png";
		
		javaGroupProvide.mailSend(email, "[Lumi] 이메일 인증번호입니다.", mailFlag, photoName, request);
		
		return "1";
	}
	
	// 임시 비밀번호 전송을 위한 아이디와 이메일 확인
	@ResponseBody
	@RequestMapping(value = "/inforCheck", method = RequestMethod.POST)
	public String inforCheckGet(String mid, String email) {
		return memberService.getInforCheck(mid, email) + "";
	}
	
	//임시 비밀번호 전송하기
	@ResponseBody
	@RequestMapping(value = "/emailSendOk", method = RequestMethod.POST)
	public void emailSendOkGet(HttpServletRequest request, String mid, String email) throws MessagingException {
		String imsiPwd = UUID.randomUUID().toString().substring(0,8);
		
		String mailFlag="";
		mailFlag = "<html>"
        + "<body>"
        + "<div style='font-family: Arial, sans-serif; line-height: 1.6;'>"
        + "<img src='cid:lumi.png' style='max-width: 400px; height: auto; border-radius: 8px;'>"
        + "<h2 style='color: #000B58;'>LUMI 임시 비밀번호 발급</h2>"
        + "<p>안녕하세요,</p>"
        + "<p>LUMI 로그인을 위한 임시 비밀번호는 다음과 같습니다.</p>"
        + "<h3 style='background-color: #f0f0f0; width:400px; padding: 10px; color: #333; border-radius: 5px; text-align: center;'>"
        + "<strong>" + imsiPwd + "</strong>"
        + "</h3>"
        + "<p>위의 발급받은 임시 비밀번호로 로그인 한 후 마이페이지에서 비밀번호를 변경해주세요.</p>"
        + "<p>감사합니다.</p><br/>"
        + "<hr>"
        + "<p style='font-size: 0.9em; color: #555;'>본 메일은 자동으로 발송된 메일입니다.</p>"
        + "</div>"
        + "</body>"
        + "</html>";
		
		String photoName = "lumi.png";
		
		javaGroupProvide.mailSend(email, "[Lumi] 로그인을 위한 임시 비밀번호입니다.", mailFlag, photoName, request);
		
		String pwd = passwordEncoder.encode(imsiPwd);
		
		memberService.setimsiPwd(mid, email, pwd);
	}
	
	// 마이페이지(고객)
	@GetMapping(value="/userPage")
	public String userPageGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		UserVO vo = memberService.getMemberIdCheck(mid);
		
		int couponCnt = shopService.getUserCouponList(mid).size();
		int cartCnt = shopService.getCartList(mid).size();
		//int orderListCnt = shopService.getOrderList(mid).size();
		
		
		model.addAttribute("vo", vo);
		model.addAttribute("couponCnt", couponCnt);
		model.addAttribute("cartCnt", cartCnt);
		
		return "member/userPage";
	}
	
	// 회원 탈퇴 신청
	@ResponseBody
	@PostMapping(value = "/memberDelete")
	public String memberDeletePost(HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		int res = memberService.setMemberDelete(mid);
		
		if(res != 0) {
			session.invalidate();
			return "1";
		}
		else return "0";
	}
	@ResponseBody
	@PostMapping(value = "/memberDeleteOk")
	public String memberDeleteOkPost(String mid) {
		
		return memberService.setMemberDeleteOk(mid)+"";
	}
	
	
	@GetMapping(value = "/memberUpdate")
	public String memberUpdateGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		UserVO vo = memberService.getMemberIdCheck(mid);
		
		if(vo.getTel() != null && vo.getTel() != "") {
			String[] tels = vo.getTel().split("-");
			
			vo.setTel1(tels[0]);
			vo.setTel2(tels[1]);
			vo.setTel3(tels[2]);
		}
		if(vo.getAddress() != null && vo.getAddress() != "") {
			String[] addresss = vo.getAddress().split("/");
			
			vo.setPostcode(addresss[0]);
			vo.setRoadAddress(addresss[1]);
			vo.setDetailAddress(addresss[2]);
			vo.setExtraAddress(addresss[3]);	
		}
		
		model.addAttribute("vo", vo);
		
		return "member/memberUpdate";
	}
	
	// 기존비밀번호와 일치여부 확인
	@ResponseBody
	@PostMapping(value = "/pwdCheck")
	public String pwdCheckPost(@RequestParam(defaultValue = "", required = false) String mid, 
			@RequestParam(defaultValue = "", required = false) String currentPwd
		) {
		UserVO vo = memberService.getMemberIdCheck(mid);
		
		if(passwordEncoder.matches(currentPwd, vo.getPwd())) {
			return "1";
		}
		return "0";
	}
	
	@PostMapping(value = "/memberUpdate")
	public String memberUpdatePost(Model model, HttpSession session, UserVO vo,
			@RequestParam(defaultValue = "", required = false) MultipartFile fName
		) {
		
		int res = memberService.setMemberUpdate(vo, fName);
		
		if(res != 0) {
			return "redirect:/message/memberUpdateOk";
		}
		else return "redirect:/message/memberUpdateNo";
	}
}
