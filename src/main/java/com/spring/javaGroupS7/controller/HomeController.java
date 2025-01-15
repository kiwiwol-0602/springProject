package com.spring.javaGroupS7.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {

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
        model.addAttribute("serverTime", getCurrentServerTime(locale));
        return "main";
    }
}
