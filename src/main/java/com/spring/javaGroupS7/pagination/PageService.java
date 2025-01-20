package com.spring.javaGroupS7.pagination;

import java.util.List;

public interface PageService<T> {


	int getTotRecCnt(String type, String user);

	List<T> List(String type, int startIndexNo, int pageSize, String user);
	
}
