package com.spring.javaGroupS7.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaGroupS7.vo.CategorySubVO;
import com.spring.javaGroupS7.vo.ProductCartVO;
import com.spring.javaGroupS7.vo.ProductOptionVO;
import com.spring.javaGroupS7.vo.ProductOrderVO;
import com.spring.javaGroupS7.vo.ProductVO;

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

	String cartDelete(int idx);

	ProductOrderVO getOrderMaxIdx();

	ProductCartVO getCartIdx(int parseInt);


}
