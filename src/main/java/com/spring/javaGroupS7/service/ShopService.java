package com.spring.javaGroupS7.service;

import java.util.List;

import com.spring.javaGroupS7.vo.CategorySubVO;
import com.spring.javaGroupS7.vo.ProductVO;

public interface ShopService {

	List<ProductVO> getProductList(String categoryName, String category, String categoryTop);

	List<CategorySubVO> getCategoryList(String categoryName, String category, String categoryTop);

}
