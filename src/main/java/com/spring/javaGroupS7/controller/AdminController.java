package com.spring.javaGroupS7.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaGroupS7.service.AdminService;
import com.spring.javaGroupS7.service.MemberService;
import com.spring.javaGroupS7.vo.CustomerVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	AdminService adminService;
	@Autowired
	MemberService memberService;
	
	@GetMapping("/admin")
	public String adminGet() {
		return "admin/admin";
	}
	@GetMapping("/userList")
	public String userListGet(Model model,
			@RequestParam(defaultValue = "999", required = false) int level
			) {
		List<CustomerVO> vos = memberService.getUserList(level);
		model.addAttribute("vos", vos);
		return "admin/userList";
	}
}
