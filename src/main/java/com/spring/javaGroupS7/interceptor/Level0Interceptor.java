package com.spring.javaGroupS7.interceptor;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.spring.javaGroupS7.service.MemberService;
import com.spring.javaGroupS7.vo.UserVO;

public class Level0Interceptor extends HandlerInterceptorAdapter{
	@Autowired
	MemberService memberService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 9999 : (int) session.getAttribute("sLevel");
		
		String mid = (String) session.getAttribute("sMid");
		UserVO vo = memberService.getMemberIdCheck(mid);
		request.setAttribute("adminVO",vo);
		
		//로그인하지 않은 회원은 '로그인' 페이지로 보내자.
		if(level > 1) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/message/loginNo");
			dispatcher.forward(request, response);
			return false;
		}
		else if(level != 0) {
			RequestDispatcher dispatcher = request.getRequestDispatcher("/message/adminLevelNo");
			dispatcher.forward(request, response);
			return false;
		}
		
		
		
		return true;
	}

}
