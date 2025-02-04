package com.spring.javaGroupS7.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.spring.javaGroupS7.service.EventService;
import com.spring.javaGroupS7.vo.EventsVO;

public class AllInterceptor extends HandlerInterceptorAdapter{
	@Autowired
	EventService eventService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		List<EventsVO> eventVOS = eventService.getEventList("user");
		request.setAttribute("eventVOS", eventVOS);
		
		return true;
	}

}
