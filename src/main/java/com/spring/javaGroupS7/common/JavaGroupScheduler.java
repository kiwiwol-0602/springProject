package com.spring.javaGroupS7.common;

import java.time.LocalDate;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.spring.javaGroupS7.service.EventService;

@Component
public class JavaGroupScheduler {
	@Autowired
	EventService eventService;
	
	@Scheduled(cron = "0 0 1 * * *")
	public void updateEventStatus() {
		LocalDate today = LocalDate.now();
		
    eventService.updateActiveStatus(today);
	}
	
	@Scheduled(cron = "0 0 1 * * *")
	public void updateCouponStatus() {
		LocalDate today = LocalDate.now();
		
		eventService.updateCouponStatus(today);
	}
	
}
