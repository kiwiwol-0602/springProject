package com.spring.javaGroupS7.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaGroupS7.service.EventService;
import com.spring.javaGroupS7.service.ShopService;
import com.spring.javaGroupS7.vo.EventsVO;
import com.spring.javaGroupS7.vo.UserCouponsVO;

@Controller
@RequestMapping("/event")
public class EventController {
	@Autowired
	EventService eventServise;
	
	@GetMapping("/eventList")
	public String eventListGet(Model model) {
		List<EventsVO> vos = eventServise.getEventList("user");
		model.addAttribute("vos",vos);
		return "event/eventList";
	}
	
	@GetMapping("/eventContent")
	public String eventContentGet(Model model, int idx) {
		EventsVO vo = eventServise.getEventInfo(idx);
		model.addAttribute("vo", vo);
		return "event/eventContent";
	}
	
	@ResponseBody
	@PostMapping("/couponDownload")
	public String couponDownload(HttpSession session, String couponCode, UserCouponsVO vo) {
		String mid = (String) session.getAttribute("sMid");
		int	res = eventServise.setCoponDownload(mid, couponCode, vo);
		return res + "";
	}
}
