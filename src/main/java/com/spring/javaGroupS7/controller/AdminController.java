package com.spring.javaGroupS7.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaGroupS7.service.AdminService;
import com.spring.javaGroupS7.service.MemberService;
import com.spring.javaGroupS7.service.ShopService;
import com.spring.javaGroupS7.vo.ProductVO;
import com.spring.javaGroupS7.vo.UserVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	AdminService adminService;
	@Autowired
	MemberService memberService;
	@Autowired
	ShopService shopService;
	
	@GetMapping("/admin")
	public String adminGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		UserVO vo = memberService.getMemberIdCheck(mid);
		model.addAttribute("vo",vo);
		return "admin/admin";
	}
	@GetMapping("/userList")
	public String userListGet(Model model,
			@RequestParam(defaultValue = "999", required = false) int level
			) {
		List<UserVO> vos = memberService.getUserList(level);
		model.addAttribute("vos", vos);
		return "admin/userList";
	}
	
	
	
}
