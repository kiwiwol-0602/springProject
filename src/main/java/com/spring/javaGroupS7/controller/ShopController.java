package com.spring.javaGroupS7.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.javaGroupS7.service.ShopService;
import com.spring.javaGroupS7.vo.CategoryBaseVO;
import com.spring.javaGroupS7.vo.CategorySubVO;
import com.spring.javaGroupS7.vo.ProductVO;


@Controller
@RequestMapping("/shop")
public class ShopController {
	@Autowired
	ShopService shopService;

	@GetMapping("/shopMainList")
	public String shopMainListGet(Model model, String categoryName, String category) {
		System.out.println(categoryName);
		System.out.println(category);
		List<ProductVO> vos = shopService.getProductList(categoryName, category);
		List<CategorySubVO> categorySubVOS = shopService.getCategoryList(categoryName, category);
//		List<CategoryBaseVO> categoryBaseVOS = shopService.getCategoryList(categoryName, category);
		
		System.out.println(categorySubVOS);
		model.addAttribute("categorySubVOS",categorySubVOS);
		model.addAttribute("vos",vos);
		model.addAttribute("category",category);
		model.addAttribute("categoryName",categoryName);
		return "shop/shopMainList";
	}
}
