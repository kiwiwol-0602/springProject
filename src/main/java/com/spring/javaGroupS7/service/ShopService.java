package com.spring.javaGroupS7.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaGroupS7.vo.CategorySubVO;
import com.spring.javaGroupS7.vo.ProductVO;

public interface ShopService {

	List<ProductVO> getProductList(String categoryName, String category, String categoryTop);

	List<CategorySubVO> getCategoryList(String categoryName, String category, String categoryTop);

	CategorySubVO getCategoryIndex(String categoryName, String category, String categoryTop);

	ProductVO getProduct(int idx);

	ArrayList<ProductVO> getCategoryMain();

	ArrayList<ProductVO> getCategoryBase(String mainName);

	ArrayList<ProductVO> getCategorySub(String mainName, String baseName);

}
