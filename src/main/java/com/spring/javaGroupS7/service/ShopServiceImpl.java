package com.spring.javaGroupS7.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaGroupS7.dao.ShopDAO;
import com.spring.javaGroupS7.vo.CategorySubVO;
import com.spring.javaGroupS7.vo.ProductVO;

@Service
public class ShopServiceImpl implements ShopService {
	
	@Autowired
	ShopDAO shopDAO;

	@Override
	public List<ProductVO> getProductList(String categoryName, String category, String categoryTop) {
		return shopDAO.getProductList(categoryName, category, categoryTop);
	}

	@Override
	public List<CategorySubVO> getCategoryList(String categoryName, String category, String categoryTop) {
		return shopDAO.getCategoryList(categoryName, category, categoryTop);
	}

	@Override
	public CategorySubVO getCategoryIndex(String categoryName, String category, String categoryTop) {
		return shopDAO.getCategoryIndex(categoryName, category, categoryTop);
	}

	@Override
	public ProductVO getProduct(int idx) {
		return shopDAO.getProduct(idx);
	}

	@Override
	public ArrayList<ProductVO> getCategoryMain() {
		return shopDAO.getCategoryMain();
	}

	@Override
	public ArrayList<ProductVO> getCategoryBase(String mainName) {
		return shopDAO.getCategoryBase(mainName);
	}
}
