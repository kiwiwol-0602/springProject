package com.spring.javaGroupS7.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaGroupS7.common.JavaGroupProvide;
import com.spring.javaGroupS7.dao.ShopDAO;
import com.spring.javaGroupS7.vo.CategorySubVO;
import com.spring.javaGroupS7.vo.ProductVO;

@Service
public class ShopServiceImpl implements ShopService {
	
	@Autowired
	ShopDAO shopDAO;
	@Autowired
	JavaGroupProvide javaGroupProvide;

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

	@Override
	public ArrayList<ProductVO> getCategorySub(String mainName, String baseName) {
		return shopDAO.getCategorySub(mainName, baseName);
	}

	@Override
	public int setProductInput(MultipartFile file1, MultipartFile file2, ProductVO vo) {
		int res = 0;
		
		try {
			if(!file1.isEmpty()) {
				String oFileName = file1.getOriginalFilename();
				String sFileName = "s_"+javaGroupProvide.saveFileName(oFileName);
				String savePath = "shop/product";
				
				javaGroupProvide.writeFile(file1, sFileName, savePath);
				vo.setThumbnail(sFileName);
			}
			else {
				return res;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		try {
			if(!file2.isEmpty()) {
				String oFileName = file2.getOriginalFilename();
				String sFileName = javaGroupProvide.saveFileName(oFileName);
				String savePath = "shop/product";
				
				javaGroupProvide.writeFile(file2, sFileName, savePath);
				vo.setTitleImg(sFileName);
			}
			else {
				return res;
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		//ckeditor img
		String content = vo.getContent();
		javaGroupProvide.imgCheck(content,"shop/product");
		vo.setContent(content.replace("/data/ckeditor/", "/data/shop/product/"));
		
		//idx
		int maxIdx = 1;
    ProductVO maxVo = shopDAO.getProductMaxIdx();
    if(maxVo != null) maxIdx = maxVo.getIdx() + 1;
		vo.setIdx(maxIdx);
		
		/*
		int subCode = vo.getSubCode();
		String strSubCode = "";
		if(subCode<10) {
			strSubCode="00"+subCode;
		}
		else if(subCode<100) {
			strSubCode="0"+subCode;
		}
		else {
			strSubCode = subCode+"";
		}
		
		//productCode
		vo.setProductCode(vo.getMainCode()+"-"+ (vo.getBaseCode()<10?vo.getBaseCode():("0"+vo.getBaseCode()))+"-"+strSubCode+"-"+maxIdx);
		*/
		
		String productCode = shopDAO.getProductCode(vo.getMainName(), vo.getBaseName(), vo.getSubName(), maxIdx);
		vo.setProductCode(productCode);
		
		System.out.println("productCode : "+productCode);
		System.out.println("productVO" + vo);
		
		res = shopDAO.setProductInput(vo);
		
		
		return res;
	}

	@Override
	public ProductVO getCategoryProductNameOne(String productName) {
		return shopDAO.getCategoryProductNameOne(productName);
	}

	@Override
	public ProductVO getCategoryProductNameOneVO(ProductVO imsiVO) {
		return shopDAO.getCategoryProductNameOneVO(imsiVO);
	}
}
