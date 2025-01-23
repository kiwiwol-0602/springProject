package com.spring.javaGroupS7.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaGroupS7.vo.BaesongVO;
import com.spring.javaGroupS7.vo.CategorySubVO;
import com.spring.javaGroupS7.vo.CouponsVO;
import com.spring.javaGroupS7.vo.ProductCartVO;
import com.spring.javaGroupS7.vo.ProductOptionVO;
import com.spring.javaGroupS7.vo.ProductOrderVO;
import com.spring.javaGroupS7.vo.ProductVO;
import com.spring.javaGroupS7.vo.UserCouponsVO;

public interface ShopDAO {

	List<ProductVO> getProductList(@Param("categoryName") String categoryName, @Param("category") String category, @Param("categoryTop") String categoryTop);

	List<CategorySubVO> getCategoryList(@Param("categoryName") String categoryName, @Param("category") String category, @Param("categoryTop") String categoryTop);

	CategorySubVO getCategoryIndex(@Param("categoryName") String categoryName, @Param("category") String category, @Param("categoryTop") String categoryTop);

	ProductVO getProduct(@Param("idx") int idx);

	ArrayList<ProductVO> getCategoryMain();

	ArrayList<ProductVO> getCategoryBase(@Param("mainName") String mainName);

	ArrayList<ProductVO> getCategorySub(@Param("mainName") String mainName, @Param("baseName") String baseName);

	ProductVO getProductMaxIdx();

	int setProductInput(@Param("vo") ProductVO vo);

	String getProductCode(@Param("mainName") String mainName, @Param("baseName") String baseName, @Param("subName") String subName, @Param("maxIdx") int maxIdx);

	ProductVO getCategoryProductNameOne(@Param("productName") String productName);

	ProductVO getCategoryProductNameOneVO(@Param("vo") ProductVO imsiVO);

	List<ProductVO> ProductListAll();

	String getExistingContent(@Param("idx") int idx);

	int setProductUpdate(@Param("vo") ProductVO vo);

	int setProductDelete(@Param("idx") int idx);

	List<ProductVO> getCategoryProductName(@Param("mainName") String mainName, @Param("baseName") String baseName, @Param("subName") String subName);

	ProductVO productInforGet(@Param("productName") String productName);

	List<ProductOptionVO> optionList(@Param("productIdx") int productIdx);

	int setOptionDelete(@Param("idx") int idx);

	int getOptionSame(@Param("productIdx") int productIdx, @Param("optionName") String optionName);

	int setOptionInput(@Param("vo") ProductOptionVO vo);

	List<ProductOptionVO> getOption(@Param("productIdx") int idx);

	ProductCartVO getCartOptionSearch(@Param("productName") String productName, @Param("optionName") String optionName, @Param("mid") String mid);

	int cartUpdate(@Param("vo") ProductCartVO vo);

	int cartInput(@Param("vo") ProductCartVO vo);

	List<ProductCartVO> getCartList(@Param("mid") String mid);

	int cartDelete(@Param("idx") int idx);

	ProductOrderVO getOrderMaxIdx();

	ProductCartVO getCartIdx(int idx);

	List<CouponsVO> getAllCoupons();

	int setCouponInput(@Param("vo") CouponsVO vo);

	List<UserCouponsVO> getUserCouponList(@Param("mid") String mid);

	CouponsVO getCouponInfo(@Param("idx") int idx);

	UserCouponsVO getUsedUserCouponInfo(@Param("userCoIdx") int userCoIdx);

	void setOrder(@Param("vo") ProductOrderVO vo);

	void setCartDeleteAll(@Param("cartIdx") int cartIdx);

	void setBaesong(@Param("baesongVO") BaesongVO baesongVO);

	void setUserPointPlus(@Param("mid") String mid);

	int getTotalBaesongOrder(@Param("orderIdx") String orderIdx);

}
