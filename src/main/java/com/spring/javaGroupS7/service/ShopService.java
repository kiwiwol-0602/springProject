package com.spring.javaGroupS7.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaGroupS7.vo.BaesongVO;
import com.spring.javaGroupS7.vo.CategorySubVO;
import com.spring.javaGroupS7.vo.CouponsVO;
import com.spring.javaGroupS7.vo.EventsVO;
import com.spring.javaGroupS7.vo.ProductCartVO;
import com.spring.javaGroupS7.vo.ProductOptionVO;
import com.spring.javaGroupS7.vo.ProductOrderVO;
import com.spring.javaGroupS7.vo.ProductVO;
import com.spring.javaGroupS7.vo.UserCouponsVO;

public interface ShopService {

	List<ProductVO> getProductList(String categoryName, String category, String categoryTop);

	List<CategorySubVO> getCategoryList(String categoryName, String category, String categoryTop);

	CategorySubVO getCategoryIndex(String categoryName, String category, String categoryTop);

	ProductVO getProduct(int idx);

	ArrayList<ProductVO> getCategoryMain();

	ArrayList<ProductVO> getCategoryBase(String mainName);

	ArrayList<ProductVO> getCategorySub(String mainName, String baseName);

	int setProductInput(MultipartFile file1, MultipartFile file2, ProductVO vo);

	ProductVO getCategoryProductNameOne(String productName);

	ProductVO getCategoryProductNameOneVO(ProductVO imsiVO);

	List<ProductVO> ProductListAll();

	int setProductUpdate(MultipartFile file1, MultipartFile file2, ProductVO vo);

	int setProductDelete(int idx);

	List<ProductVO> getCategoryProductName(String mainName, String baseName, String subName);

	ProductVO productInforGet(String productName);

	List<ProductOptionVO> optionList(int productIdx);

	int setOptionDelete(int idx);

	int getOptionSame(int productIdx, String optionName);

	int setOptionInput(ProductOptionVO vo);

	List<ProductOptionVO> getOption(int idx);

	ProductCartVO getCartOptionSearch(String productName, String optionName, String mid);

	int cartUpdate(ProductCartVO vo);

	int cartInput(ProductCartVO vo);

	List<ProductCartVO> getCartList(String mid);

	int cartDelete(int idx);

	ProductOrderVO getOrderMaxIdx();

	ProductCartVO getCartIdx(int parseInt);

	List<CouponsVO> getAllCoupons();

	int setCouponInput(CouponsVO vo);

	List<UserCouponsVO> getUserCouponList(String mid);

	CouponsVO getCouponInfo(int couponIdx);

	UserCouponsVO getUsedUserCouponInfo(int userCoIdx);

	void setOrder(ProductOrderVO vo);

	void setCartDeleteAll(int cartIdx);

	void setBaesong(BaesongVO baesongVO);

	void setUserPointPlus(int point, String mid);

	int getTotalBaesongOrder(String orderIdx);

	void setCouponUsed(String userCouponCode);

	void setUserPointMinus(String mid, int point);

	ProductOrderVO getOrderDetail(int idx);

	BaesongVO getBaesongDetail(String orderIdx);

	String setStatusSelectCheck(String statusSelect, String idxSelectArray);

	int setProductState(int productIdx, String state, String flag);

	List<ProductOrderVO> getOrderList(String mid);

	List<ProductOrderVO> getRecentOrderList(String mid);

	int setOrderStatusChange(int idx, String state);

}
