package com.spring.javaGroupS7.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaGroupS7.service.MemberService;
import com.spring.javaGroupS7.service.ShopService;
import com.spring.javaGroupS7.vo.CategorySubVO;
import com.spring.javaGroupS7.vo.ProductCartVO;
import com.spring.javaGroupS7.vo.ProductOptionVO;
import com.spring.javaGroupS7.vo.ProductOrderVO;
import com.spring.javaGroupS7.vo.ProductVO;
import com.spring.javaGroupS7.vo.UserVO;


@Controller
@RequestMapping("/shop")
public class ShopController {
	@Autowired
	ShopService shopService;
	@Autowired
	MemberService memberService;

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
	
	@PostMapping("/productInput")
	public String productInputPost(MultipartFile file1, MultipartFile file2, ProductVO vo) {
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
		ProductVO vo = shopService.getProduct(idx);
		List<ProductOptionVO> optionVOS = shopService.getOption(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("optionVOS", optionVOS);
		return "shop/productContent";
	}
	
	@GetMapping("/productOption")
	public String productOptionGet(Model model,
			@RequestParam(name="productName", defaultValue = "", required=false) String productName
		) {
		
		if(productName.equals("")) {
			List<ProductVO> mainVos = shopService.getCategoryMain();
			model.addAttribute("mainVos",mainVos);
		}
		else {
			ProductVO imsiVO = shopService.getCategoryProductNameOne(productName);
			ProductVO productVO = shopService.getCategoryProductNameOneVO(imsiVO);
			model.addAttribute("productVO", productVO);
		}
		
		return "shop/productOption";
	}
	
	@ResponseBody
	@PostMapping( "/categoryProductName")
	public List<ProductVO> categoryProductNamePost(String mainName, String baseName, String subName) {
		return shopService.getCategoryProductName(mainName, baseName, subName);
	}
	
	//'옵션등록폼'에서 상품선택시에 해당상품의 옵션리스트를 가져와서 출력
	@ResponseBody
	@PostMapping("/productInfor")
	public ProductVO productInforGet(String productName) {
		return shopService.productInforGet(productName);
	}
	
	@ResponseBody
	@PostMapping("/optionList")
	public List<ProductOptionVO> optionListPost(int productIdx) {
		return shopService.optionList(productIdx);
	}
	
	// 상품 옵션 삭제
	@ResponseBody
	@PostMapping("/optionDelete")
	public String optionDeletePost(int idx) {
		int res = shopService.setOptionDelete(idx);
		return res + "";
	}
	
	// 상품 옵션 등록
	@PostMapping("/productOption")
	public String productOptionPost(Model model, ProductOptionVO vo, String[] optionName, int[] price) {
		int res = 0;
		for(int i=0; i<optionName.length; i++) {
			int optionCnt = shopService.getOptionSame(vo.getProductIdx(), optionName[i]);
			if(optionCnt != 0) continue;
			
			// 동일한 옵션이 없다면 vo에 현재 옵션 이름과 가격을 set시킨후 옵션테이블에 등록처리한다.
			vo.setProductIdx(vo.getProductIdx());
			vo.setOptionName(optionName[i]);
			vo.setPrice(price[i]);
			
			res = shopService.setOptionInput(vo);
		}
		model.addAttribute("tempFlag", vo.getProductName());
		if(res != 0) return "redirect:/message/optionInputOk";
		else return "redirect:/message/optionInputNo";
	}
	
	// 상품 수정 폼
	@GetMapping("/productUpdate")
	public String productUpdateGet(Model model,
			@RequestParam(name="idx", defaultValue = "0", required=false) int idx
		) {
		
		ProductVO vo = shopService.getProduct(idx);
		ArrayList<ProductVO> mainVos = shopService.getCategoryMain();
		ArrayList<ProductVO> baseVos = shopService.getCategoryBase(vo.getMainName());
		ArrayList<ProductVO> subVos = shopService.getCategorySub(vo.getMainName(), vo.getBaseName());
		
		model.addAttribute("vo",vo);
		model.addAttribute("mainVos",mainVos);
		model.addAttribute("baseVos",baseVos);
		model.addAttribute("subVos",subVos);
		
		return "shop/productUpdate";
	}
	
	// 상품 수정
	@PostMapping("/productUpdate")
	public String productUpdatePost(MultipartFile file1, MultipartFile file2, ProductVO vo) {
		int res = shopService.setProductUpdate(file1, file2, vo);
		
		if(res != 0) return "redirect:/message/productUpdateOk";
		return "redirect:/message/productUpdateNo?idx="+vo.getIdx();
		
	}
	
	// 상품 삭제
	@ResponseBody
	@PostMapping("/productDelete")
	public String productDeletePost(@RequestParam("idx") int[] idx) {
		int res = 0;
	  for (int productIdx : idx) {
	  	res += shopService.setProductDelete(productIdx);
	  }
		return res+"";
	}
	
	
	// 장바구니 담기
	@PostMapping("/productCart")
	public String productCartPost(HttpSession session, ProductCartVO vo) {
		String mid = (String) session.getAttribute("sMid");
		
		ProductCartVO cartVO = shopService.getCartOptionSearch(vo.getProductName(), vo.getOptionName(), mid);
	// 지금 구매한 항목을 기존 구매 카트에서와 비교를 위해 검색
			int res = 0;
			
			if(cartVO != null) { // 같은 제품(기본품목+옵션항목)일 경우는 수량만 업데이트
				String[] voOptionNums = vo.getOptionNum().split(",");
				
				String[] resOptionNums = cartVO.getOptionNum().split(",");
				
				int[] nums = new int[99];
				String strNums = "";
				for(int i=0; i<voOptionNums.length; i++) {
					nums[i] += (Integer.parseInt(voOptionNums[i]) + Integer.parseInt(resOptionNums[i]));
					strNums += nums[i] + ",";
				}
				strNums = strNums.substring(0,strNums.length()-1);
				
				vo.setOptionNum(strNums);
				res = shopService.cartUpdate(vo);
			}
			else {
				res = shopService.cartInput(vo);
			}
			return "redirect:/shop/productCartList";
	}
	
	//장바구니
	@GetMapping("/productCartList")
	public String productCartGet(HttpSession session, ProductCartVO vo, Model model) {
		String mid = (String) session.getAttribute("sMid");
		List<ProductCartVO> vos = shopService.getCartList(mid);	// idx오름차순으로 정리해서 가져왔다.
		UserVO userVO = memberService.getUser(mid);
		if(vos.size() == 0) return "redirect:/message/cartEmpty";
		
		model.addAttribute("cartListVos", vos);
		model.addAttribute("userVO", userVO);
		
		return "shop/productCartList";
	}
	
	@PostMapping("cartDelete")
	public String cartDeleteGet(int idx) {
		return shopService.cartDelete(idx) + "";
	}
	
	@PostMapping("/productCartList")
	public String productCartListPost(HttpServletRequest request, HttpSession session, Model model,
			@RequestParam(name="baesong", defaultValue="0", required=false) int baesong) {
		
		String mid = (String) session.getAttribute("sMid");
		
		// 주문한 상품에 대한 '주문 고유번호'를 만들어준다.
		ProductOrderVO maxIdx = shopService.getOrderMaxIdx();
		int idx = 1;
    if(maxIdx != null) idx = maxIdx.getMaxIdx() + 1;
    
    // 주문번호 만들기
    Date today = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
    String orderIdx = sdf.format(today) + idx;
    
    // 장바구니에서 여러항목 구매시 체크된 항목만 넘어온다.
    String[] idxChecked = request.getParameterValues("idxChecked");

    ProductCartVO cartVO = new ProductCartVO();
    List<ProductOrderVO> orderVos = new ArrayList<ProductOrderVO>();
    
    for(String strIdx : idxChecked) {
    	cartVO = shopService.getCartIdx(Integer.parseInt(strIdx));
    	ProductOrderVO orderVO = new ProductOrderVO();
      orderVO.setProductIdx(cartVO.getProductIdx());
      orderVO.setProductName(cartVO.getProductName());
      orderVO.setMainPrice(cartVO.getPrice());
      orderVO.setThumbImg(cartVO.getThumbnail());
      orderVO.setOptionName(cartVO.getOptionName());
      orderVO.setOptionPrice(cartVO.getOptionPrice());
      orderVO.setOptionNum(cartVO.getOptionNum());
      orderVO.setTotalPrice(cartVO.getTotalPrice());
      orderVO.setCartIdx(cartVO.getIdx());
      orderVO.setBaesong(baesong);

      orderVO.setOrderIdx(orderIdx); 
      orderVO.setMid(mid);

      orderVos.add(orderVO);
    }
    
    session.setAttribute("sOrderVos", orderVos);

    UserVO memberVO = memberService.getMemberIdCheck(mid);
    model.addAttribute("memberVO", memberVO);
		
		
		return "shop/dbOrder";
	}
	
}
