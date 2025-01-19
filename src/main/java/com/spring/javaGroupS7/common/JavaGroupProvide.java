package com.spring.javaGroupS7.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;

@Component
public class JavaGroupProvide {
	
	@Autowired
	JavaMailSender mailSender;
	
	
	//메일 전송하기(이메일주소, 제목, 내용)
	public void mailSend(String toMail, String title, String mailFlag, String photoName, HttpServletRequest request) throws MessagingException {
		String content = "";
		
		// 메일 전송을 위한 객체 : MimeMessage(), MimeMessageHelper()
		MimeMessage message = mailSender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
		
		messageHelper.setTo(toMail);			// 받는 사람의 메일주소
		messageHelper.setSubject(title);	// 메일 제목
		messageHelper.setText(content);		// 메일 내용
		messageHelper.setText(content);		// 메일 내용
		
		content = content.replace("\n", "<br>");
		content += "<br>"+mailFlag+"<br>";
		messageHelper.setText(content, true);
		
		if(photoName != null || photoName !="") {
			FileSystemResource file = new FileSystemResource(request.getSession().getServletContext().getRealPath("/resources/images/mail/"+photoName));
			messageHelper.addInline(photoName, file);
		}
		
		
		// 메일 전송하기
		mailSender.send(message);
	}
	
	// 파일 서버 저장
	@SuppressWarnings("unused")
	public void writeFile(MultipartFile fName, String sFileName, String savePath) throws IOException {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+savePath+"/");
		
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		
		if(fName.getBytes().length != -1) {
			fos.write(fName.getBytes());
		}
		fos.flush();
		fos.close();
	}
	
	// 파일삭제
	public void deleteFile(String file, String savePath) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/"+savePath+"/");
		File fName = new File(realPath + file);
		
		if(fName.exists()) {
			fName.delete();
		}
	}
	
	// 파일이름 중복방지
	public String saveFileName(String originalFilename) {
		Date date = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");
    String saveFileName = sdf.format(date) + "_" + originalFilename;
		return saveFileName;
	}
	
	//ckeditor 파일등록 시 폴더명 길이 상관없이 파일 올리는 법
	public void imgCheck(String content, String folderName) {
    HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
    String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
    String imgs[] = content.split("<img ");
    ArrayList<String> img = new ArrayList<String>();
    
    for(int i = 0; i< imgs.length; i++) {
	    if(imgs[i].contains("src")) {
	      imgs[i] = imgs[i].substring(imgs[i].indexOf("src=\""));    // src="/javaGroupS/data/ckeditor/241213145233_파일명.jpg" style="height:225px; width:225px" /></p>\r\n
	      imgs[i] = imgs[i].substring(0, imgs[i].lastIndexOf("\"")); // src="/javaGroupS/data/ckeditor/241213145233_파일명.jpg" style="height:225px; width:225px" />
	      
	      String temp1 = imgs[i].substring(0, imgs[i].lastIndexOf(".")); // src="/javaGroupS/data/ckeditor/241213145233_파일명
	      temp1 = temp1.substring(temp1.lastIndexOf("/")+1);  //  241213145233_파일명
	      
	      String temp2 = imgs[i].substring(imgs[i].lastIndexOf("."));  // .jpg" style="height:225px; width:225px" /></p>
	      temp2 = temp2.substring(0, temp2.indexOf("\""));  // .jpg
	      
	      img.add(temp1 + temp2);  // 241213145233_파일명 + .jpg
	    }
    }
    
    for(int i = 0; i < img.size(); i++) {
	    String origFilePath = realPath + "ckeditor/" + img.get(i);
	    String copyFilePath = realPath +  folderName + "/" + img.get(i);
	    fileCopyCheck(origFilePath, copyFilePath);
    }
	}
	// 파일 복사처리
	private void fileCopyCheck(String origFilePath, String copyFilePath) {
    try {
//    File file = new File(origFilePath);
//    FileInputStream fis = new FileInputStream(file);
	    FileInputStream fis = new FileInputStream(new File(origFilePath));
	    FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
	    
	    byte[] bytes = new byte[2048];
	    int cnt = 0;
	    while((cnt=fis.read(bytes)) != -1) {
	        fos.write(bytes, 0, cnt);
	    }
	    fos.flush();
	    fos.close();
	    fis.close();
    } catch (FileNotFoundException e) {
      e.printStackTrace();
    } catch (IOException e) {
      e.printStackTrace();
    }
	}
	
	
	
	
}
