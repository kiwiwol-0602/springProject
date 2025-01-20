package com.spring.javaGroupS7.pagination;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;

@Component
public class PageProcess {
	@Autowired
	PageService pageService;

	 public <T> void totRecCnt(Model model, int pag, int pageSize, String type, String user) {
     
     int totRecCnt = pageService.getTotRecCnt(type, user);
     int startIndexNo = (pag - 1) * pageSize;
     int blockSize = 10;
     int curBlock = (pag - 1) / blockSize;
     int totPage = (totRecCnt % pageSize) == 0 ? (totRecCnt / pageSize) : (totRecCnt / pageSize) + 1;
     int curScrStartNo = totRecCnt - startIndexNo;
     int lastBlock = (totPage - 1) / blockSize;
     
     List<T> vos = pageService.List(type, startIndexNo, pageSize, user);

     model.addAttribute("vos", vos);    
     model.addAttribute("pag", pag);    
     model.addAttribute("pageSize", pageSize);
     model.addAttribute("totRecCnt", totRecCnt);
     model.addAttribute("totPage", totPage);
     model.addAttribute("curScrStartNo", curScrStartNo);
     model.addAttribute("blockSize", blockSize);
     model.addAttribute("curBlock", curBlock);
     model.addAttribute("lastBlock", lastBlock);
     
 }


}
