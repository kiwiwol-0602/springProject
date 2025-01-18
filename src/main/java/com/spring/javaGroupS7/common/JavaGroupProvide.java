package com.spring.javaGroupS7.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
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
		String realPath = request.getSession().getServletContext().getRealPath("/resources"+savePath);
		
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		
		if(fName.getBytes().length != -1) {
			fos.write(fName.getBytes());
		}
		fos.flush();
		fos.close();
	}

	public void deleteFile(String file, String savePath) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources"+savePath);
		File fName = new File(realPath + file);
		
		if(fName.exists()) {
			fName.delete();
		}
	}
	

	
	
	
}
