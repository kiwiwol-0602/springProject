package com.spring.javaGroupS7.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("/shared")
public class SharedController {
	
	@GetMapping("/introduction")
	public String introductionGet() {
		return "shared/introduction";
	}
	
}