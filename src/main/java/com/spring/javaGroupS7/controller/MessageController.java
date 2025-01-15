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
			@RequestParam(name="mid", defaultValue = "", required = false) String mid
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
			model.addAttribute("url", "member/customerPage");
		}
		else if(msgFlag.equals("memberUpdateNo")) {
			model.addAttribute("message", "정보 수정 중 오류가 발생했습니다.\\n확인 후 다시 시도해주세요.");
			model.addAttribute("url", "member/memberUpdate");
		}
		
		return "include/message";
	}

}
