package com.spring.javaGroupS7.pagination;

import java.util.List;

public interface PageService<T> {


	int getTotRecCnt(String type, String user);

	List<T> List(String type, int startIndexNo, int pageSize, String user);

	List<T> SearchList(String type, int startIndexNo, int pageSize, String user, String search, String searchString);

	int getTotRecCntSearch(String type, String user, String part, String searchString);
	
}
