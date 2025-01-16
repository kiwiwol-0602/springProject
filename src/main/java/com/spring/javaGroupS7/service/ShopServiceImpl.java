package com.spring.javaGroupS7.service;

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
	public List<ProductVO> getProductList(String categoryName, String category) {
		return shopDAO.getProductList(categoryName, category);
	}

	@Override
	public List<CategorySubVO> getCategoryList(String categoryName, String category) {
		return shopDAO.getCategoryList(categoryName, category);
	}
}
