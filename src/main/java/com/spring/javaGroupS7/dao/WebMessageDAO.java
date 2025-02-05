package com.spring.javaGroupS7.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaGroupS7.vo.WebMessageVO;

public interface WebMessageDAO {

	List<WebMessageVO> getWmMessageList(@Param("mid") String mid, @Param("mSw") int mSw, @Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	WebMessageVO getWmMessageContent(@Param("idx") int idx, @Param("mid") String mid);

	void setWmUpdate(@Param("idx") int idx, @Param("mid") String mid);

	String getWmMessageReceiveSw(@Param("idx") int idx);

	int setWmInputOk(@Param("vo") WebMessageVO vo);

	int setwmDeleteCheck(@Param("idx") int idx, @Param("mFlag") int mFlag);


}
