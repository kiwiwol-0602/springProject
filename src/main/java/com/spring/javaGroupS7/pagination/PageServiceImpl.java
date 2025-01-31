package com.spring.javaGroupS7.pagination;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaGroupS7.dao.PageDAO;

@Service
public class PageServiceImpl<T> implements PageService<T> {

	@Autowired
	PageDAO<T> pageDAO;

	@Override
	public int getTotRecCnt(String type, String user) {
		return pageDAO.getTotRecCnt(type, user);
	}

	@Override
	public List<T> List(String type, int startIndexNo, int pageSize, String user) {
		return pageDAO.List(type, startIndexNo, pageSize, user);
	}

	@Override
	public List<T> SearchList(String type, int startIndexNo, int pageSize, String user, String search, String searchString) {
		return pageDAO.SearchList(type, startIndexNo, pageSize, user, search, searchString);
	}

	@Override
	public int getTotRecCntSearch(String type, String user, String part, String searchString) {
		return pageDAO.getTotRecCntSearch(type, user, part, searchString);
	}



	
}
