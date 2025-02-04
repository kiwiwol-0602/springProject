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
import com.spring.javaGroupS7.vo.BaesongVO;
import com.spring.javaGroupS7.vo.CategorySubVO;
import com.spring.javaGroupS7.vo.CouponsVO;
import com.spring.javaGroupS7.vo.EventsVO;
import com.spring.javaGroupS7.vo.ProductCartVO;
import com.spring.javaGroupS7.vo.ProductOptionVO;
import com.spring.javaGroupS7.vo.ProductOrderVO;
import com.spring.javaGroupS7.vo.ProductVO;
import com.spring.javaGroupS7.vo.UserCouponsVO;

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

	@Override
	public List<ProductVO> ProductListAll() {
		return shopDAO.ProductListAll();
	}

	@Override
	public int setProductUpdate(MultipartFile file1, MultipartFile file2, ProductVO vo) {
		int res = 0;
		
		try {
			if(!file1.isEmpty()) {
				String oFileName = file1.getOriginalFilename();
				String sFileName = "s_"+javaGroupProvide.saveFileName(oFileName);
				String savePath = "shop/product";
				
				if(vo.getThumbnail() != "noimage.jpg" && sFileName != vo.getThumbnail()) {
					javaGroupProvide.deleteFile(vo.getThumbnail(),savePath);
				}
				
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
				
				if(vo.getTitleImg() != "noimage.jpg" && sFileName != vo.getTitleImg()) {
					javaGroupProvide.deleteFile(vo.getTitleImg(),savePath);
				}
				
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
		
		
		if(content != null && !content.isEmpty()) {
			String existingContent = shopDAO.getExistingContent(vo.getIdx());
			if(existingContent !=null && !existingContent.isEmpty()) {
				List<String> existingImgs = javaGroupProvide.extractImagePaths(existingContent);
				for(String imgPath : existingImgs) {
					javaGroupProvide.deleteFile(imgPath, "shop/product");
				}
			}
			javaGroupProvide.imgCheck(content,"shop/product");
			vo.setContent(content.replace("/data/ckeditor/", "/data/shop/product/"));
		}
		
		String display = vo.getDisplay();
		if(display == null || display.trim().isEmpty()) {
			display = "OFF";
		}
		vo.setDisplay(display);
		
		res = shopDAO.setProductUpdate(vo);
		
		return res;
	}

	@Override
	public int setProductDelete(int idx) {
		ProductVO vo = shopDAO.getProduct(idx);
		String savePath = "shop/product";
		String existingContent = shopDAO.getExistingContent(idx);
		
		//썸네일 삭제 (noimg 뺴고)
		if(vo.getThumbnail() != "noimage.jpg") {
			javaGroupProvide.deleteFile(vo.getThumbnail(),savePath);
		}
		//타이틀 삭제 (noimg 뺴고)
		if(vo.getTitleImg() != "noimage.jpg") {
			javaGroupProvide.deleteFile(vo.getTitleImg(),savePath);
		}
		//content 이미지 삭제 (noimg 뺴고)
		if(existingContent !=null && !existingContent.isEmpty()) {
			List<String> existingImgs = javaGroupProvide.extractImagePaths(existingContent);
			for(String imgPath : existingImgs) {
				javaGroupProvide.deleteFile(imgPath, savePath);
			}
		}
		
		
		return shopDAO.setProductDelete(idx);
	}

	@Override
	public List<ProductVO> getCategoryProductName(String mainName, String baseName, String subName) {
		return shopDAO.getCategoryProductName(mainName, baseName, subName);
	}

	@Override
	public ProductVO productInforGet(String productName) {
		return shopDAO.productInforGet(productName);
	}

	@Override
	public List<ProductOptionVO> optionList(int productIdx) {
		return shopDAO.optionList(productIdx);
	}

	@Override
	public int setOptionDelete(int idx) {
		return shopDAO.setOptionDelete(idx);
	}

	@Override
	public int getOptionSame(int productIdx, String optionName) {
		return shopDAO.getOptionSame(productIdx, optionName);
	}

	@Override
	public int setOptionInput(ProductOptionVO vo) {
		return shopDAO.setOptionInput(vo);
	}

	@Override
	public List<ProductOptionVO> getOption(int idx) {
		return shopDAO.getOption(idx);
	}

	@Override
	public ProductCartVO getCartOptionSearch(String productName, String optionName, String mid) {
		return shopDAO.getCartOptionSearch(productName, optionName, mid);
	}

	@Override
	public int cartUpdate(ProductCartVO vo) {
		return shopDAO.cartUpdate(vo);
	}

	@Override
	public int cartInput(ProductCartVO vo) {
		return shopDAO.cartInput(vo);
	}

	@Override
	public List<ProductCartVO> getCartList(String mid) {
		return shopDAO.getCartList(mid);
	}

	@Override
	public int cartDelete(int idx) {
		return shopDAO.cartDelete(idx);
	}

	@Override
	public ProductOrderVO getOrderMaxIdx() {
		return shopDAO.getOrderMaxIdx();
	}

	@Override
	public ProductCartVO getCartIdx(int idx) {
		return shopDAO.getCartIdx(idx);
	}

	@Override
	public List<CouponsVO> getAllCoupons() {
		return shopDAO.getAllCoupons();
	}

	@Override
	public int setCouponInput(CouponsVO vo) {
		String couponCode = vo.getCouponCode();
		String randomCode = RandomStringUtils.randomAlphabetic(8);
		
		if(couponCode=="") {
			couponCode = randomCode;
		}
		vo.setCouponCode(couponCode);
		
		return shopDAO.setCouponInput(vo);
	}

	@Override
	public List<UserCouponsVO> getUserCouponList(String mid) {
		return shopDAO.getUserCouponList(mid);
	}

	@Override
	public CouponsVO getCouponInfo(int couponIdx) {
		return shopDAO.getCouponInfo(couponIdx);
	}

	@Override
	public UserCouponsVO getUsedUserCouponInfo(int userCoIdx) {
		return shopDAO.getUsedUserCouponInfo(userCoIdx);
	}

	@Override
	public void setOrder(ProductOrderVO vo) {
		shopDAO.setOrder(vo);
	}

	@Override
	public void setCartDeleteAll(int cartIdx) {
		shopDAO.setCartDeleteAll(cartIdx);
	}

	@Override
	public void setBaesong(BaesongVO baesongVO) {
		shopDAO.setBaesong(baesongVO);
	}

	@Override
	public void setUserPointPlus(int point, String mid) {
		shopDAO.setUserPointPlus(point, mid);
	}

	@Override
	public int getTotalBaesongOrder(String orderIdx) {
		return shopDAO.getTotalBaesongOrder(orderIdx);
	}

	@Override
	public void setCouponUsed(String userCouponCode) {
		shopDAO.setCouponUsed(userCouponCode);
	}

	@Override
	public void setUserPointMinus(String mid, int point) {
		shopDAO.setUserPointMinus(mid, point);
	}

	@Override
	public ProductOrderVO getOrderDetail(int idx) {
		return shopDAO.getOrderDetail(idx);
	}

	@Override
	public BaesongVO getBaesongDetail(String orderIdx) {
		return shopDAO.getBaesongDetail(orderIdx);
	}

	@Override
	public String setStatusSelectCheck(String statusSelect, String idxSelectArray) {
		String res = "0";
		String[] idxSelectArrays = idxSelectArray.split("/");
		
		for(String idx : idxSelectArrays) {
			shopDAO.setStatusSelectCheck(Integer.parseInt(idx), statusSelect);
			res = "1";
		}
		
		return res;
	}

	@Override
	public int setProductState(int productIdx, String state, String flag) {
		return shopDAO.setProductState(productIdx, state, flag);
	}

	@Override
	public List<ProductOrderVO> getOrderList(String mid) {
		return shopDAO.getOrderList(mid);
	}

	@Override
	public List<ProductOrderVO> getRecentOrderList(String mid) {
		return shopDAO.getRecentOrderList(mid);
	}

	@Override
	public int setOrderStatusChange(int idx, String state) {
		return shopDAO.setOrderStatusChange(idx, state);
	}

	
}
