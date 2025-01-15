package com.spring.javaGroupS7.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.javaGroupS7.vo.ProductVO;


@Controller
@RequestMapping("/shop")
public class ShopController {

	@GetMapping("/shopMainList")
	public String shopMainListGet(String category) {
		return "shop/shopMainList";
	}
}
