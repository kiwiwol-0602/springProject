package com.spring.javaGroupS7.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaGroupS7.service.ShopService;
import com.spring.javaGroupS7.vo.ProductVO;

@Controller
public class HomeController {
	
	@Autowired
	ShopService shopService;

    private String getCurrentServerTime(Locale locale) {
        Date date = new Date();
        DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
        return dateFormat.format(date);
    }

    @RequestMapping(value = {"/", "/index"}, method = RequestMethod.GET)
    public String home(Locale locale, Model model) {
        model.addAttribute("serverTime", getCurrentServerTime(locale));
        return "home";
    }

    @RequestMapping(value = "/main", method = RequestMethod.GET)
    public String main(Locale locale, Model model) {
    		List<ProductVO> vos = shopService.getProductList("baseName", "Rings", "Jewelry");
    		List<ProductVO> Bvos = shopService.getProductList("baseName", "Bracelets", "Jewelry");
    		
        model.addAttribute("serverTime", getCurrentServerTime(locale));
        model.addAttribute("vos", vos);
        model.addAttribute("Bvos", Bvos);
        
        return "main";
    }
    
  	@RequestMapping(value = "/imageUpload", method = RequestMethod.POST)
  	public void imageUpload(MultipartFile upload, HttpServletRequest request, HttpServletResponse response) throws IOException {
  		response.setCharacterEncoding("utf-8");
  		response.setContentType("text/html; charset=utf-8");
  		
  		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/ckeditor/");
  		String oFileName = upload.getOriginalFilename();
  		
  		// 파일명 중복방지를 위한 이름 설정
  		Date date = new Date();
  		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
  		oFileName = sdf.format(date) + "_" + oFileName;
  		
  		// 파일 서버로 업로드처리
  		byte[] bytes = upload.getBytes();
//  		File file = new File(realPath + oFileName);
//  		FileOutputStream fos = new FileOutputStream(file);
  		FileOutputStream fos = new FileOutputStream(new File(realPath + oFileName));
  		fos.write(bytes);
  		
  		// 브라우저에 서버에 전송된 그림을 표시시켜주기
  		PrintWriter out = response.getWriter();
  		String fileUrl = request.getContextPath() + "/data/ckeditor/" + oFileName;
  		out.println("{\"originalFilename\":\""+oFileName+"\",\"uploaded\":1,\"url\":\""+fileUrl+"\"}");
  		
  		out.flush();
  		fos.close();
  	}
}
