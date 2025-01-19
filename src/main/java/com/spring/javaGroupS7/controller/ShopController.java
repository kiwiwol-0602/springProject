package com.spring.javaGroupS7.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

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
	public String shopMainListGet(Model model, String categoryName, String category,
			@RequestParam(defaultValue = "", required = false) String categoryTop
			
			) {
		List<ProductVO> vos = shopService.getProductList(categoryName, category, categoryTop);
		List<CategorySubVO> categorySubVOS = shopService.getCategoryList(categoryName, category, categoryTop);
		CategorySubVO categorySuvVO = shopService.getCategoryIndex(categoryName, category, categoryTop);
		
		model.addAttribute("categorySubVOS",categorySubVOS);
		model.addAttribute("categorySuvVO",categorySuvVO);
		model.addAttribute("vos",vos);
		model.addAttribute("category",category);
		model.addAttribute("categoryName",categoryName);
		model.addAttribute("categoryTop",categoryTop);
		return "shop/shopMainList";
	}
	
	@GetMapping("/productInput")
	public String productInputGet(Model model) {
		ArrayList<ProductVO> mainVos = shopService.getCategoryMain();
		model.addAttribute("mainVos",mainVos);
		return "shop/productInput";
	}
	
//	@PostMapping("/productInput")
//	public void productInputPost(ProductVO vo) {
//		System.out.println("ProductVO : "+vo);
//		//System.out.println("??????????????");
//	}
	
	@PostMapping("/productInput")
	public String productInputPost(MultipartFile file1, MultipartFile file2, ProductVO vo) {
		System.out.println(vo);
		int res = shopService.setProductInput(file1, file2, vo);
		
		if(res != 0) return "redirect:/message/productInputOk";
		return "redirect:/message/productInputNo";
	}
	
	@ResponseBody
	@PostMapping("/categoryBase")
	public ArrayList<ProductVO> categoryBaseGet(
			@RequestParam(defaultValue = "", required = false) String mainName
		) {
		ArrayList<ProductVO> res = shopService.getCategoryBase(mainName);
		return res;
	}
	
	@ResponseBody
	@PostMapping("/categorySub")
	public ArrayList<ProductVO> ccategorySubGet(
			@RequestParam(defaultValue = "", required = false) String mainName,
			@RequestParam(defaultValue = "", required = false) String baseName
			) {
		ArrayList<ProductVO> res = shopService.getCategorySub(mainName, baseName);
		return res;
	}
	
	@GetMapping("/productContent")
	public String productContentGet(Model model, int idx) {
		System.out.println("idx"+idx);
		ProductVO vo = shopService.getProduct(idx);
		
		model.addAttribute("vo", vo);
		return "shop/productContent";
	}
	
	@GetMapping("/productOption")
	public String productOptionGet(Model model,
			@RequestParam(name="productName", defaultValue = "", required=false) String productName) {
		/*
		if(productName.equals("")) {
		}
		else {
			ProductVO imsiVO = shopService.getCategoryProductNameOne(productName);
			ProductVO productVO = shopService.getCategoryProductNameOneVO(imsiVO);
			model.addAttribute("productVO", productVO);
		}
		*/
		return "shop/productOption";
	}
}
