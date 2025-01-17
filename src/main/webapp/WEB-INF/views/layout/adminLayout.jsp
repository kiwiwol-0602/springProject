<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="icon" href="${ctp}/images/main/favicon.png">
  <title>관리자 | LUMI</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <style type="text/css">
  	.adminNav{
  		float: left;
  		width: 17%;
  		padding-top: 2%;
  	}
  	.adminBody{
  		float: right;
  		width: 82%;
  		padding: 3% 1% 1% 1%;
  		justify-content: center;  /* 수평 중앙 배치 */
    	align-items: center;      /* 수직 중앙 배치 */
  	}
  	
  </style>
</head>
<body>
<div class="adminNav"><tiles:insertAttribute name="nav"/></div>
<div class="adminBody"><tiles:insertAttribute name="body"/></div>
</body>
</html>