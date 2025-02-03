<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="${ctp}/main/favicon.png">
	<title>이벤트 상세 | LUMI</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<jsp:include page="/WEB-INF/views/include/fonts.jsp" />
  <style>
	  body {
	    font-family: Arial, sans-serif;
	    margin: 0;
	    padding: 0;
	    background-color: #f4f4f4;
		}
		
		.eventContentContainer {
	    width: 100%;
	    max-width: 1200px;
	    margin: 11% auto;
	    background-color: white;
	    padding: 40px;
	    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		}
		
		h2 {
	    text-align: center;
	    color: #333;
	    margin-bottom: 20px;
		}
		h4 {
	    text-align: center;
	    color: #eee;
	    margin-bottom: 20px;
		}
		
		.eventContent {
	    display: flex;
	    flex-direction: column;
	    align-items: center;
	    text-align: center;
		}
		
		.eventContent img {
	    width: 100%;
	    max-width: 600px;
	    height: auto;
	    margin-bottom: 30px;
		}
		
		.eventDescription {
	    font-size: 16px;
	    color: #666;
	    line-height: 1.6;
	    margin-bottom: 30px;
	    text-align: left;
	    width: 100%;
	    max-width: 800px;
		}
		
		.eventDate {
	    font-size: 14px;
	    color: #999;
	    margin-bottom: 20px;
		}
		
		/* 쿠폰 다운로드 버튼 */
		.btn-coupon-download {
	    display: block;
	    width: 100%;
	    max-width: 300px;
	    margin: 20px auto;
	    padding: 20px 0;
	    background-color: #006A67;
	    color: white;
	    font-size: 18px;
	    font-weight: bold;
	    text-align: center;
	    text-decoration: none;
	    border-radius: 10px;
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	    transition: background-color 0.3s ease;
		}
		
		.btn-coupon-download:hover {
	    background-color: #004f4e;
		}
	</style>
	<script type="text/javascript">
		'use strict'
		
		function couponDownload() {
			let couponCode = '${vo.couponCode}';
			alert(couponCode);
			
			$.ajax({
				type : "post",
				url  : "${ctp}/event/couponDownload",
				data : {
					couponCode : couponCode
				},
				success: function(res) {
					if(res!="0"){
						alert('쿠폰이 발급되었습니다.');
					}
					else {
						alert('쿠폰을 발급하는 중 오류가 발생했습니다.');
					}
				},
				error: function(){
					alert("전송오류");
				}
			});
		}
	
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="eventContentContainer">
	<h2>${vo.title}</h2>
	<h4>${vo.subTitle}</h4>
	
	<div class="eventContent">
		<!-- 이벤트 썸네일 이미지 -->
		<img src="${ctp}/event/${vo.thumbnail}" alt="${vo.title} 이미지">
		
		<!-- 이벤트 기간 -->
		<p class="eventDate">기간: ${fn:substring(vo.startDate, 0, 10)} ~ ${fn:substring(vo.endDate, 0, 10)}</p>
		
		<!-- 이벤트 설명 -->
		<p class="eventDescription">
			${vo.content}
		</p>
		
		<!-- 쿠폰 다운로드 버튼 -->
		<a href="javascript:couponDownload()" class="btn-coupon-download">
			쿠폰 다운로드
		</a>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>
