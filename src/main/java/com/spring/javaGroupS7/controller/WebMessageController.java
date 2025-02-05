package com.spring.javaGroupS7.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaGroupS7.pagination.PageProcess;
import com.spring.javaGroupS7.service.MemberService;
import com.spring.javaGroupS7.service.WebMessageService;
import com.spring.javaGroupS7.vo.UserVO;
import com.spring.javaGroupS7.vo.WebMessageVO;

@Controller
@RequestMapping("/webMessage")
public class WebMessageController {

	@Autowired
	WebMessageService webMessageService;
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	MemberService memberService;
	
	@RequestMapping(value = "/webMessage", method = RequestMethod.GET)
	public String webMessageGet(Model model, HttpSession session,
			@RequestParam(name="mSw", defaultValue = "1", required = false) int mSw,
			@RequestParam(name="mFlag", defaultValue = "1", required = false) int mFlag,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "30", required = false) int pageSize,
			//@RequestParam(name="receiveSw", defaultValue = "", required = false) String receiveSw,
			@RequestParam(name="idx", defaultValue = "0", required = false) int idx
		) {
		
		String mid = (String) session.getAttribute("sMid");
		
		if(mSw == 0) {}			// 메세지 작성
		else if(mSw == 6) {	// 메세지 내용보기
			WebMessageVO vo = webMessageService.getWmMessageContent(idx, mid);
			model.addAttribute("vo", vo);
		}
		else if(mSw == 9) {	// 휴지통보기
			
		}
		else {
			// 페이징처리..... pageVO 가져오기....
			List<WebMessageVO> vos = webMessageService.getWmMessageList(mid, mSw, 0, pageSize);
			model.addAttribute("vos", vos);
			// model.addAttribute("pageVO", pageVO);
		}
		
		model.addAttribute("mSw", mSw);
		
		return "webMessage/webMessage";
	}
	
	@PostMapping("/wmInputOk")
  public String wmInputOkPost(WebMessageVO vo) {
     UserVO vo2 = memberService.getMemberIdCheck(vo.getReceiveId());
     if(vo2 == null) {
        return "redirect:/message/wmMemberIdNo";
     }
     if(webMessageService.setWmInputOk(vo) != 0) {
        return "redirect:/message/wmInputOk";
     }
     else {
        return "redirect:/message/wmInputNo";
     }
  }
	@GetMapping("/wmDeleteCheck")
	public String wmDeleteCheckGet(Model model, int idx, int mFlag) {
		model.addAttribute("mSw", mFlag);
		if(webMessageService.setwmDeleteCheck(idx, mFlag) != 0) {
			return "redirect:/message/wmDeleteCheckOk";
		}
		else {
			return "redirect:/message/wmDeleteCheckNo";
		}
	}
	
}
