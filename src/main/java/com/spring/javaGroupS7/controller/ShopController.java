package com.spring.javaGroupS7.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
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
import com.spring.javaGroupS7.vo.BaesongVO;
import com.spring.javaGroupS7.vo.CategorySubVO;
import com.spring.javaGroupS7.vo.CouponsVO;
import com.spring.javaGroupS7.vo.PayMentVO;
import com.spring.javaGroupS7.vo.ProductCartVO;
import com.spring.javaGroupS7.vo.ProductOptionVO;
import com.spring.javaGroupS7.vo.ProductOrderVO;
import com.spring.javaGroupS7.vo.ProductVO;
import com.spring.javaGroupS7.vo.UserCouponsVO;
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
	
	@ResponseBody
	@PostMapping("/cartDelete")
	public String cartDeleteGet(int idx) {
		return shopService.cartDelete(idx) + "";
	}
	
	@PostMapping("/productOrder")
	public String productOrderPost(HttpServletRequest request, HttpSession session, Model model, ProductVO productVO,
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
    
    if (idxChecked == null || idxChecked.length == 0) {
    	cartVO = shopService.getCartIdx(idx);
  		ProductOrderVO orderVO = new ProductOrderVO();
  		
  		orderVO.setProductIdx(productVO.getIdx());
  		orderVO.setProductName(productVO.getProductName());
  		orderVO.setPrice(productVO.getPrice());
  		orderVO.setPay(productVO.getPay());
  		orderVO.setThumbnail(productVO.getThumbnail());
  		orderVO.setOptionName(productVO.getOptionName());
  		orderVO.setOptionPrice(productVO.getOptionPrice());
  		orderVO.setOptionNum(productVO.getOptionNum());
  		orderVO.setTotalPrice(productVO.getTotalPrice());
  		orderVO.setBaesong(baesong);
  		
  		orderVO.setOrderIdx(orderIdx); 
  		orderVO.setMid(mid);
  		
  		orderVos.add(orderVO);
    } 
    else {
    	for(String strIdx : idxChecked) {
    		cartVO = shopService.getCartIdx(Integer.parseInt(strIdx));
    		ProductOrderVO orderVO = new ProductOrderVO();
    		
    		orderVO.setProductIdx(cartVO.getProductIdx());
    		orderVO.setProductName(cartVO.getProductName());
    		orderVO.setPrice(cartVO.getPrice());
    		orderVO.setPay(cartVO.getPay());
    		orderVO.setThumbnail(cartVO.getThumbnail());
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
    }
    
    session.setAttribute("sOrderVos", orderVos);

    UserVO userVO = memberService.getMemberIdCheck(mid);
    
    List<UserCouponsVO> userCouponVOS = shopService.getUserCouponList(mid);
    
    
    model.addAttribute("userVO", userVO);
    model.addAttribute("userCouponVOS", userCouponVOS);
		
		
		return "shop/productOrder";
	}
	
	@GetMapping("/couponList")
	public String couponListGet(Model model) {
		 List<CouponsVO> vos = shopService.getAllCoupons();  // 모든 쿠폰 리스트를 가져옴
     model.addAttribute("couponVOS", vos);  // "coupons"라는 이름으로 쿠폰 리스트를 모델에 저장
		
		return "shop/couponList";
	}
	
	@GetMapping("/couponInput")
	public String couponInputGet() {
		return "shop/couponInput";
	}
	
	@PostMapping("/couponInput")
	public String couponInputPost(CouponsVO vo) {
		int res= shopService.setCouponInput(vo);
		
		if(res != 0) return "redirect:/message/couponInputOk";
		return "redirect:/message/couponInputNo?";
	}
	
	@GetMapping("/couponPage")
	public String couponPageGet(Model model) {
		 List<CouponsVO> vos = shopService.getAllCoupons();
     model.addAttribute("couponVOS", vos);  // 
		
		return "shop/couponPage";
	}
	
	//쿠폰적용
	@ResponseBody
	@PostMapping("/applyCoupon")
	public Map<String, Object> applyCoupon( HttpSession session,
			@RequestParam(name="couponIdx", defaultValue="0", required=false) int couponIdx,
			@RequestParam(name="totalPay", defaultValue="0", required=false) int totalPay,
			//@RequestParam(name="totalDiscount", defaultValue="0", required=false) int totalDiscount,
			@RequestParam(name="userCoIdx", defaultValue="0", required=false) int userCoIdx
		){
		String mid = (String) session.getAttribute("sMid");
		UserCouponsVO userUCInfo = shopService.getUsedUserCouponInfo(userCoIdx);

		Map<String, Object> response = new HashMap<>();
		CouponsVO couponInfo = shopService.getCouponInfo(couponIdx);
		// 쿠폰 상태 조회
		if (!couponInfo.getActive().equals("ON")) {
      response.put("success", false);
      response.put("message", "유효하지 않은 쿠폰입니다.");
      return response;
		}
		
		// 쿠폰에 따른 할인 계산
    int discountAmount = 0;
    if ("percent".equals(couponInfo.getDiscountType())) {
        discountAmount = (totalPay*couponInfo.getDiscount()) / 100;
    } else {
        discountAmount = couponInfo.getDiscount();
    }
    
    // 할인 금액 적용 후 새로운 총 금액 계산
    int newTotalPay = totalPay - discountAmount;
    if (newTotalPay < 0) {
    	newTotalPay = 0;  // 총 금액이 0원 이하로 내려가지 않도록 설정
    }
    
    int newTotalDiscount = discountAmount;
    
    String ucName = couponInfo.getCouponName()+"("+userUCInfo.getUserCouponCode()+")";
    String ucCode = userUCInfo.getUserCouponCode();
    // 성공 응답 반환
    response.put("success", true);
    response.put("newTotalPay", newTotalPay);
    response.put("newTotalDiscount", newTotalDiscount);
    response.put("ucName", ucName);
    response.put("ucCode", ucCode);
    
		return response;
	}
	
	@PostMapping("/payment")
	public String paymentPost(ProductOrderVO orderVO, PayMentVO payMentVO, BaesongVO baesongVO, HttpSession session, Model model) {
		payMentVO.setName(orderVO.getProductName());
		baesongVO.setName(payMentVO.getBuyer_name());
		
		model.addAttribute("payMentVO", payMentVO);
		session.setAttribute("sPayMentVO", payMentVO);
		
		session.setAttribute("sBaesongVO", baesongVO);
		
		return "shop/paymentOk";
	}
	
	@GetMapping("/paymentResult")
	public String paymentResultGet(HttpSession session, PayMentVO receivePayMentVO, Model model) {
		List<ProductOrderVO> orderVos = (List<ProductOrderVO>) session.getAttribute("sOrderVos");
		ProductOrderVO buyOrderVO = (ProductOrderVO) session.getAttribute("sBuyOrderVO");
		PayMentVO payMentVO = (PayMentVO) session.getAttribute("sPayMentVO");
		BaesongVO baesongVO = (BaesongVO) session.getAttribute("sBaesongVO");
		
		session.removeAttribute("sBaesongVO");
		
		String ucCode=baesongVO.getUserCouponCode();
		int usPoint=baesongVO.getPoint();
		int individualPrice = 0;
		int individualPay = 0;
		
		
		for(ProductOrderVO vo : orderVos) {
		  vo.setIdx(Integer.parseInt(vo.getOrderIdx().substring(8)));
			vo.setOrderIdx(vo.getOrderIdx());
			vo.setMid(vo.getMid());
			individualPrice = vo.getTotalPrice();
			
			if(!ucCode.equals("")) {
				String idx[] = ucCode.split("-");
				UserCouponsVO couponVO = shopService.getUsedUserCouponInfo(Integer.parseInt(idx[1]));
				
				// 쿠폰에 따른 할인 계산
				if (couponVO != null) {
			    int discountAmount = 0;
			    if ("percent".equals(couponVO.getDiscountType())) {
			        discountAmount = (individualPrice*couponVO.getDiscount()) / 100;
			    } 
			    else {
			        discountAmount = couponVO.getDiscount();
			    }
			    individualPrice = individualPrice-discountAmount;
					//individualPrice = individualPrice - (individualPrice * (couponVO.getDiscount() / 100));
				}
			}
			vo.setTotalPrice(individualPrice);
			
			if(usPoint!=0) {
				individualPay = individualPrice - Math.round((float)usPoint / orderVos.size());
			}
			else {
        individualPay = individualPrice;
			}
			vo.setTotalPay(individualPay);
			
			shopService.setOrder(vo);
			shopService.setCartDeleteAll(vo.getCartIdx());
		}
		System.out.println("baesongVO 초기"+baesongVO);
		
		//쿠폰 사용함으로 변경
		if (!ucCode.equals("")) {
      shopService.setCouponUsed(baesongVO.getUserCouponCode());
		}
		
		//사용포인트 빼기
		if (usPoint != 0) {
      shopService.setUserPointMinus(baesongVO.getMid(), usPoint);
		}
		
		// 포인트 적립
		shopService.setUserPointPlus((int)(baesongVO.getTotalPay() * 0.01), orderVos.get(0).getMid());
		
		int totalBaesongOrder = 0;
		for(int i =0; i<orderVos.size(); i++) {
			totalBaesongOrder += orderVos.get(i).getTotalPrice();
		}
		System.out.println(orderVos);
		for(int i =0; i<orderVos.size(); i++) {
		BaesongVO newBaesongVO = new BaesongVO();
		
    newBaesongVO.setOIdx((orderVos.get(i).getIdx())+i);
		newBaesongVO.setOrderIdx(orderVos.get(i).getOrderIdx());
		newBaesongVO.setTotalPay(totalBaesongOrder);
		newBaesongVO.setMid(baesongVO.getMid());
		newBaesongVO.setName(baesongVO.getName());
		newBaesongVO.setAddress(payMentVO.getBuyer_addr());
		newBaesongVO.setTel(payMentVO.getBuyer_tel());
		newBaesongVO.setMessage(baesongVO.getMessage());
		
		System.out.println("newBaesongVO"+newBaesongVO);
		shopService.setBaesong(newBaesongVO);
		System.out.println("newBaesongVO 셋후"+newBaesongVO);
		}
		
		
		
		payMentVO.setImp_uid(receivePayMentVO.getImp_uid());
		payMentVO.setMerchant_uid(receivePayMentVO.getMerchant_uid());
		payMentVO.setPaid_amount(receivePayMentVO.getPaid_amount());
		payMentVO.setApply_num(receivePayMentVO.getApply_num());
		
		session.setAttribute("sPayMentVO", payMentVO);
		session.setAttribute("orderTotalPrice", baesongVO.getTotalPay());
		
		return "redirect:/message/paymentResultOk";
	}
	
	@GetMapping("/paymentResultOk")
	public String paymentResultOkGet(HttpSession session, Model model) {
		List<ProductOrderVO> orderVos = (List<ProductOrderVO>) session.getAttribute("sOrderVos");
		model.addAttribute("orderVos", orderVos);
		
		session.removeAttribute("sOrderVos");
		/*
		int totalBaesongOrder = shopService.getTotalBaesongOrder(orderVos.get(orderVos.size()-1).getOrderIdx());
		
		model.addAttribute("totalBaesongOrder", totalBaesongOrder);
		*/
		return "shop/paymentResult";
	}
	
	
	
	
	
	
}
