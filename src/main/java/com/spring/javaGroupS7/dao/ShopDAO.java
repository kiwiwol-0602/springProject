package com.spring.javaGroupS7.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaGroupS7.vo.CategorySubVO;
import com.spring.javaGroupS7.vo.ProductVO;

public interface ShopDAO {

	List<ProductVO> getProductList(@Param("categoryName") String categoryName, @Param("category") String category, @Param("categoryTop") String categoryTop);

	List<CategorySubVO> getCategoryList(@Param("categoryName") String categoryName, @Param("category") String category, @Param("categoryTop") String categoryTop);

	CategorySubVO getCategoryIndex(@Param("categoryName") String categoryName, @Param("category") String category, @Param("categoryTop") String categoryTop);

	ProductVO getProduct(@Param("idx") int idx);

	ArrayList<ProductVO> getCategoryMain();

	ArrayList<ProductVO> getCategoryBase(@Param("mainName") String mainName);

	ArrayList<ProductVO> getCategorySub(@Param("mainName") String mainName, @Param("baseName") String baseName);

}
