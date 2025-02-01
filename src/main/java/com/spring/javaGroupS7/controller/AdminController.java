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

import com.spring.javaGroupS7.pagination.PageProcess;
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
	@Autowired
	PageProcess pageProcess;
	
	@GetMapping("/admin")
	public String adminGet(Model model, HttpSession session) {
		String mid = (String) session.getAttribute("sMid");
		UserVO vo = memberService.getMemberIdCheck(mid);
		model.addAttribute("adminVO",vo);
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
	
	@GetMapping("/productList")
	public String productListGet(Model model,
			@RequestParam(defaultValue = "1") int pag,
			@RequestParam(defaultValue = "10") int pageSize
		) {
		pageProcess.totRecCnt(model, pag, pageSize, "product", "admin");
		return "admin/productList";
	}
	
	@GetMapping("/productSearchList")
	public String productSearchListGet(Model model,
			@RequestParam("search") String search,
			@RequestParam(defaultValue = "") String searchString,
			@RequestParam(defaultValue = "1") int pag,
			@RequestParam(defaultValue = "10") int pageSize
			) {
		pageProcess.totRecCntSearchList(model, pag, pageSize, "product", "admin", search, searchString);
		return "admin/productSearchList";
	}
	
	@GetMapping("/orderList")
	public String orderListGet(Model model,
			@RequestParam(defaultValue = "1") int pag,
			@RequestParam(defaultValue = "10") int pageSize
			) {
		pageProcess.totRecCnt(model, pag, pageSize, "productOrder", "admin");
		return "admin/orderList";
	}
	
	@GetMapping("/orderSearchList")
	public String orderSearchListGet(Model model,
			@RequestParam("search") String search,
			@RequestParam(defaultValue = "") String searchString,
			@RequestParam(defaultValue = "1") int pag,
			@RequestParam(defaultValue = "10") int pageSize
			) {
		
		if(search.equals("name")||search.equals("orderStatus")) {
			pageProcess.totRecCntSearchList(model, pag, pageSize, "productOrder", "admin", "b."+search, searchString);
		}
		
		pageProcess.totRecCntSearchList(model, pag, pageSize, "productOrder", "admin", search, searchString);
		return "admin/orderSearchList";
	}
	
	@ResponseBody
	@PostMapping("/statusSelectCheck")
	public String statusSelectCheckPost(String statusSelect, String idxSelectArray) {
		System.out.println(statusSelect);
		System.out.println(idxSelectArray);
		return shopService.setStatusSelectCheck(statusSelect, idxSelectArray);
	}
	
	@ResponseBody
	@PostMapping("/productState")
	//public String productStatePost(String productIdxs, String state, String flag) {
		public String productStatePost(@RequestParam("productIdxs") int[] productIdxs, String state, String flag) {
		int res = 0;
		 for (int productIdx : productIdxs) {
		  	res += shopService.setProductState(productIdx,state, flag);
		  }
		return res+"";
	}
	
	@GetMapping("/saleStatistics")
	public String saleStatisticsGet(Model model,
			@RequestParam(defaultValue = "1") int pag,
			@RequestParam(defaultValue = "10") int pageSize
			) {
		//pageProcess.totRecCnt(model, pag, pageSize, "productOrder", "admin");
		return "admin/saleStatistics";
	}
	
	
}
