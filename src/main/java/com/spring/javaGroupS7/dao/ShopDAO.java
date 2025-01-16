package com.spring.javaGroupS7.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaGroupS7.vo.CategorySubVO;
import com.spring.javaGroupS7.vo.ProductVO;

public interface ShopDAO {

	List<ProductVO> getProductList(@Param("categoryName") String categoryName, @Param("category") String category);

	List<CategorySubVO> getCategoryList(@Param("categoryName") String categoryName, @Param("category") String category);

}
