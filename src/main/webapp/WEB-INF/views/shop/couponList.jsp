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
  <link rel="icon" href="ctp/main/favicon.png">
	<title>쿠폰등록 | LUMI</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<jsp:include page="/WEB-INF/views/include/fonts.jsp" />
  <style>
	  body {
	    font-family: Arial, sans-serif;
	    margin: 0;
	    padding: 0;
	    background-color: #f4f4f4;
		}
		
		.couponListAdmin {
	    width: 100%;
	    margin: 20px auto;
	    background-color: white;
	    padding: 50px 40px;
	    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		}
		
		h2 {
	    text-align: center;
	    color: #333;
		}
		
		/* 테이블 스타일 */
		.couponList {
	    width: 100%;
	    border-collapse: collapse;
	    margin-top: 20px;
		}
		
		.couponList th, .couponList td {
	    padding: 12px 15px;
	    border: 1px solid #ddd;
	    text-align: center;
		}
		
		.couponList th {
	    background-color: #f8f8f8;
	    color: #333;
	    font-size: 13px;
	    font-weight: bold;
		}
		.couponList td {
    	font-size: 13px;
		}
		
		.couponList tr:nth-child(even) {
   		background-color: #ffff;
		}
		
		.couponList tr:hover {
    	background-color: #f1f1f1;
		}
		
		/* 버튼 스타일 */
		.btn-gray {
	    background-color: gray;
	    color: white;
	    padding: 5px 10px;
	    text-decoration: none;
	    border-radius: 0px;
		}
		.btn-edit {
	    background-color: #003161;
	    color: white;
	    padding: 5px 10px;
	    text-decoration: none;
	    border-radius: 0px;
		}
		
		.btn-delete {
	    background-color: #006A67;
	    color: white;
	    padding: 5px 10px;
	    text-decoration: none;
	    border-radius: 0px;
		}
		
		.btn-edit:hover, .btn-delete:hover {
    	opacity: 0.8;
		}
	</style>
	<script type="text/javascript">
		'use strict'
		
		function reverseCheck() {
		    let checkboxes = document.querySelectorAll('input[name="couponCheck"]');
		    checkboxes.forEach(function(checkbox) {
		      checkbox.checked = !checkbox.checked;
		    });
		  }
	</script>
</head>
<body>
<div class="couponListAdmin">
	<h2>쿠폰 발급 및 관리</h2>
	<!-- 쿠폰 리스트 테이블 -->
	<table style="width: 100%; margin-top: 40px;">
		<tr style="width: 100%;">
			<td class="left-align" style="justify-content: flex-start;">
			<a href="${ctp}/shop/couponInput" class="btn-edit" style="padding: 5px 20px;">쿠폰등록</a>
			</td>
			<td class="right-align" style="justify-content: flex-end; text-align: right;">
			<a href="#" class="btn-gray" style="">쿠폰상태 ON</a>
			<a href="#" class="btn-gray" style="">쿠폰상태 OFF</a>
			</td>
		</tr>
	</table>
	<table class="couponList" id="couponList">
		<tr>
			<th><input type="checkbox" id="allCheck" onclick="reverseCheck()"/></th>
	    <th>쿠폰코드</th>
	    <th>쿠폰명</th>
	    <th>할인유형</th>
	    <th>할인값</th>
	    <th>최소주문금액</th>
	    <th>만료일</th>
	    <th>쿠폰상태</th>
	    <th>관리</th>
		</tr>
		<c:forEach var="vo" items="${couponVOS}" varStatus="st">
			<tr style="word-break: break-all;">
				<td style="width: 50px;"><input type="checkbox" name="couponCheck" id="couponCheck${vo.idx}" value="${vo.idx}" /></td>
			  <td style="width: 110px;">${vo.couponCode}</td>
			  <td style="word-break: break-all; width: 240px;">${vo.couponName}</td>
			  <td style="word-break: break-all; width: 110px;">${vo.discountType}</td>
			  <td style="word-break: break-all; width: 110px;">${vo.discount}</td>
			  <td style="width: 110px;"><fmt:formatNumber value="${vo.minOrderPay}" pattern="#,##0"/>원</td>
			  <td style="width: 100px;">${fn:substring(vo.expirationDate,0,10)}</td>
			  <td style="width: 60px;">${vo.active}</td>
			  <td style="width: 90px;">
			  	<c:if test="${vo.active eq 'ON'}">
			  		<a href="#" class="btn-gray" style="">쿠폰상태 ON</a>
			  	</c:if>
			  	<c:if test="${!(vo.active eq 'ON')}">
			  		<a href="#" class="btn-gray" style="">쿠폰상태 OFF</a>
			  	</c:if>
		  	</td>
			</tr>
		</c:forEach>
	</table>
</div>
</body>
</html>