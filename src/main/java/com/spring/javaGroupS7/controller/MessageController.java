package com.spring.javaGroupS7.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MessageController {
	
	@GetMapping(value = "/message/{msgFlag}")
	public String MessageGet(Model model,
			@PathVariable String msgFlag,
			@RequestParam(name="mid", defaultValue = "", required = false) String mid,
			@RequestParam(name="idx", defaultValue = "0", required = false) int idx,
			@RequestParam(name="tempFlag", defaultValue = "", required = false) String tempFlag
		) {
		
		if(msgFlag.equals("memberJoinOk")) {
			model.addAttribute("message", "회원가입이 완료되었습니다.\\n 로그인 후 사용해 주세요.");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberJoinNo")) {
			model.addAttribute("message", "회원가입에 실패하셨습니다.\\n 다시 회원 가입 후 사용해 주세요.");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberLoginOk")) {
			model.addAttribute("message", mid + "회원님 로그인 되셨습니다.");
			model.addAttribute("url", "main");
		}
		else if(msgFlag.equals("memberLoginNo")) {
			model.addAttribute("message", "회원 정보가 일치하지 않습니다.\\n 확인 후 다시 로그인해 주세요.");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("loginNo")) {
			model.addAttribute("message", "로그인 후 이용해주세요.");
			model.addAttribute("url", "member/memberLogin");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("message", "로그아웃 되셨습니다.");
			model.addAttribute("url", "main");
		}
		else if(msgFlag.equals("memberIdSameCheck")) {
			model.addAttribute("message", "같은 아이디로 가입된 기록이 있습니다. \\n 계정찾기를 진행하세요.");
			model.addAttribute("url", "member/searchAccount");
		}
		else if(msgFlag.equals("memberUpdateOk")) {
			model.addAttribute("message", "정보가 수정되었습니다.");
			model.addAttribute("url", "member/userPage");
		}
		else if(msgFlag.equals("memberUpdateNo")) {
			model.addAttribute("message", "정보 수정 중 오류가 발생했습니다.\\n확인 후 다시 시도해주세요.");
			model.addAttribute("url", "member/memberUpdate");
		}
		else if(msgFlag.equals("productInputOk")) {
			model.addAttribute("message", "상품이 등록되었습니다.");
			model.addAttribute("url", "admin/admin");
		}
		else if(msgFlag.equals("productInputNo")) {
			model.addAttribute("message", "상품 등록 중 오류가 발생했습니다.");
			model.addAttribute("url", "shop/productInput");
		}
		else if(msgFlag.equals("productUpdateOk")) {
			model.addAttribute("message", "상품이 수정되었습니다.");
			model.addAttribute("url", "admin/productList");
		}
		else if(msgFlag.equals("productUpdateNo")) {
			model.addAttribute("message", "상품 수정 중 오류가 발생했습니다.");
			model.addAttribute("url", "shop/productUpdate?idx="+idx);
		}
		else if(msgFlag.equals("adminLevelNo")) {
			model.addAttribute("message", "접속 권한이 없습니다.");
			model.addAttribute("url", "main");
		}
		else if(msgFlag.equals("optionInputOk")) {
			model.addAttribute("message", "옵션항목이 등록되었습니다.");
			model.addAttribute("url", "shop/productOption?productName="+tempFlag);
		}
		else if(msgFlag.equals("optionInputNo")) {
			model.addAttribute("message", "옵션항목 등록 중 오류가 발생했습니다.");
			model.addAttribute("url", "shop/productOption?productName="+tempFlag);
		}
		else if(msgFlag.equals("cartEmpty")) {
			model.addAttribute("message", "장바구니에 상품을 담아주세요");
			model.addAttribute("url", "main");
		}
		else if(msgFlag.equals("couponInputOk")) {
			model.addAttribute("message", "쿠폰이 등록되었습니다.");
			model.addAttribute("url", "shop/couponList");
		}
		else if(msgFlag.equals("couponInputNo")) {
			model.addAttribute("message", "쿠폰 등록 중 오류가 발생했습니다.");
			model.addAttribute("url", "shop/couponInput");
		}
		else if(msgFlag.equals("eventInputOk")) {
			model.addAttribute("message", "이벤트가 등록되었습니다.");
			model.addAttribute("url", "admin/eventList");
		}
		else if(msgFlag.equals("eventInputNo")) {
			model.addAttribute("message", "이벤트 등록 중 오류가 발생했습니다.");
			model.addAttribute("url", "admin/eventInput");
		}
//		else if(msgFlag.equals("paymentResultOk")) {
//			model.addAttribute("message", "결제가 완료되었습니다.");
//			model.addAttribute("url", "shop/paymentResultOk");
//		}
		
		return "include/message";
	}

}
