package com.spring.javaGroupS7.pagination;

import lombok.Data;

@Data
public class PageVO {
	/*
	// 소연 방식
	private int pag;
  private int pageSize;
  private int totRecCnt;
  private int totPage;
  private int startIndexNo;
  private int curScrStartNo;
  private int blockSize = 3;
  private int curBlock;
  private int lastBlock;
	*/
	
  // 선생님
  
  private int pag;
  private int pageSize;
  private int totRecCnt;
  private int totPage;
  private int startIndexNo;
  private int curScrStartNo;
  private int blockSize;
  private int curBlock;
  private int lastBlock;
  
  private String search;
  private String searchString;
  private String searchTitle;
  private String part;
  
}


