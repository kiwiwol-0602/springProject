package com.spring.javaGroupS7.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;


public interface PageDAO<T> {

	int getTotRecCnt(@Param("type") String type, @Param("user") String user);

	List<T> List(@Param("type") String type, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("user") String user);
	

}
