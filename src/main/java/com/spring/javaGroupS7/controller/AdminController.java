package com.spring.javaGroupS7.controller;

import java.awt.Event;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.javaGroupS7.pagination.PageProcess;
import com.spring.javaGroupS7.service.AdminService;
import com.spring.javaGroupS7.service.EventService;
import com.spring.javaGroupS7.service.MemberService;
import com.spring.javaGroupS7.service.ShopService;
import com.spring.javaGroupS7.vo.BaesongVO;
import com.spring.javaGroupS7.vo.EventsVO;
import com.spring.javaGroupS7.vo.ProductOrderVO;
import com.spring.javaGroupS7.vo.ProductVO;
import com.spring.javaGroupS7.vo.ScheduleVO;
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
	EventService eventServise;
	@Autowired
	PageProcess pageProcess;
	
	@GetMapping("/admin")
	public String adminGet(Model model) {
		int newUserCnt = adminService.getNewUserCnt();
		int leaveUserCnt = adminService.getLeaveUserCnt();
		int newOrderCnt = adminService.getNewOrderCnt();
		int refundCnt = adminService.getRefundCnt();
		
		model.addAttribute("newUserCnt", newUserCnt);
		model.addAttribute("leaveUserCnt", leaveUserCnt);
		model.addAttribute("newOrderCnt", newOrderCnt);
		model.addAttribute("refundCnt", refundCnt);
		
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
	
	@GetMapping("/saleChart")
	public String saleChartGet(Model model) {
		
		List<ProductOrderVO> productCntVOS = adminService.getProductCnt();
		model.addAttribute("productCntVOS", productCntVOS);
		
		int monthlySales = adminService.getMonthlySales();
		model.addAttribute("monthlySales", monthlySales);
		
		return "admin/saleChart";
	}
	
	@GetMapping("/eventList")
	public String eventListGet(Model model) {
		List<EventsVO> vos = eventServise.getEventList("admin");
		model.addAttribute("vos", vos);
		
		return "admin/eventList";
	}
	
	@GetMapping("/eventInput")
	public String eventInputGet() {
		return "admin/eventInput";
	}
	
	@PostMapping("/eventInput")
	public String eventInputPost(MultipartFile file1, EventsVO vo) {
		int res = eventServise.setEventInput(file1,  vo);
		
		if(res != 0) return "redirect:/message/eventInputOk";
		return "redirect:/message/eventInputNO";
	}
	
	@ResponseBody
	@PostMapping("/eventActiveChange")
	public String eventActiveChangePost(String variable, 
			@RequestParam(defaultValue = "") String idxSelectArray,
			@RequestParam(defaultValue = "0") int idx
		) {
		String res = "0";
		
		if(!idxSelectArray.isEmpty()) {
			String[] idxSelectArrays = idxSelectArray.split("/");
			for(String arrayIdx : idxSelectArrays) {
				eventServise.setEventActiveChangePost(Integer.parseInt(arrayIdx), variable);
				res = "1";
			}
		}
		else {
			eventServise.setEventActiveChangePost(idx, variable);
			res = "1";
		}
		
		return res;
	}
	
	@GetMapping("/userChart")
	public String userChartGet(Model model) {
		// 많이 방문한 사람
		List<UserVO> visitCntVOS = adminService.getVisitCnt();
		model.addAttribute("visitCntVOS", visitCntVOS);
		
		List<ProductOrderVO> orderCntVOS = adminService.getOrderCnt();
		model.addAttribute("orderCntVOS", orderCntVOS);
		
		return "admin/userChart";
	}
	
	@ResponseBody
	@PostMapping("/saveSchedule")
	public String saveSchedulePost(
			@RequestParam String title,
			@RequestParam String startDate,
			@RequestParam(defaultValue = "") String endDate
			) {
    
    return adminService.setSaveSchedule(title, startDate, endDate)+"";
	}
	
	@ResponseBody
	@GetMapping("/loadSchedule")
	public List<ScheduleVO> loadSchedulePost() {
    List<ScheduleVO> scheduleVOS = adminService.getLoadSchedule();

    //model.addAttribute("scheduleVO", scheduleVO);
    
    return scheduleVOS;
	}
	
	@GetMapping("/refundList")
	public String refundListGet(Model model
			) {
		List<BaesongVO> vos = adminService.getRefundList();
		model.addAttribute("vos",vos);
		
		return "admin/refundList";
	}
	
}
