<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
	<style type="text/css">
		body {
	    font-family: Arial, sans-serif;
			background-color: #f4f7f6;
			color: #333;
			margin: 0;
			padding: 0;
		}
		.couponInput {
		  width: 77%;
			margin: 0 auto 3% auto;
			background-color: #fff;
			padding: 80px;
			box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
		}
		h2 {
			text-align: center;
			color: #2c3e50;
			font-size: 28px;
			margin-bottom: 30px;
		}
		label {
		  margin-top: 10px; 
		  margin-bottom: 5px; 
			font-size: 18px;
			font-weight: bold;
			color: #2c3e50;
		}
		input, select {
		    width: 100%;
		    padding: 10px;
		    margin-bottom: 10px;
		    border: 1px solid #ccc;
		    border-radius: 5px;
		}
		.blackLine-btn {
			background-color: #fff;
			color: #3D3B3B;
			border: 1px solid #333;
			border-radius: 5px;
			padding: 7px 20px;
			font-size: 20px;
			font-weight: 400;
			cursor: pointer;
			transition: all 0.3s ease;
			width: 100%;
		}
		.blackLine-btn:hover {
			background-color: #eee;
			border-color: #666;
			transform: translateY(-2px);
		}
		.blackLine-btn:active {
			background-color: #ccc;
			border-color: #555;
			transform: translateY(0);
		}
		.blackLine-btn:focus {
			outline: none;
			box-shadow: 0 0 0 2px rgba(138, 124, 102, 0.7);
		}
	</style>
	<script type="text/javascript">
		'use strict'
		function fCheck() {
	    	if(document.getElementById("couponName").value=="") {
	    		alert("쿠폰명을 입력하세요");
	    		return false;
	    	}
	    	else if(document.getElementById("discountType").value=="") {
	    		alert("할인유형을 선택하세요");
	    		return false;
	    	}
	    	else if(document.getElementById("discount").value=="") {
	    		alert("할인값을 입력하세요");
	    		return false;
	    	}
	    	else if(document.getElementById("minOrderPay").value=="") {
	    		alert("최소주문금액을 입력하세요");
	    		return false;
	    	}
	    	else if(document.getElementById("expirationDate").value=="") {
	    		alert("쿠폰만료일을 설정하세요");
	    		return false;
	    	}
	    	else if(document.getElementById("active").value=="") {
	    		alert("쿠폰상태를 설정하세요");
	    		return false;
	    	}
	    	else {
	    		couponForm.submit();
	    	}
		}
	
	</script>
</head>
<body>
	<div class="couponInput">
		<h2>쿠폰 등록</h2>
		  <!-- 쿠폰 발급/수정 폼 -->
	  <form id="couponForm" method="post">
	    <label for="couponCode">쿠폰 코드</label>
	    <input type="text" id="couponCode" name="couponCode" required placeholder="쿠폰 코드를 입력하세요. (미입력시 자동설정됩니다)">
	    
	    <label for="couponName">쿠폰명</label>
	    <input type="text" id="couponName" name="couponName" required placeholder="쿠폰명을 입력하세요">
	
	    <label for="discountType">할인 유형</label>
	    <select id="discountType" name="discountType" required>
	      <option value="percent">퍼센트 할인 (%)</option>
	      <option value="amount">금액 할인 (₩)</option>
	    </select>
	
	    <label for="discount">할인 값</label>
	    <input type="number" id="discount" name="discount" required placeholder="할인 값을 입력하세요">
	
	    <label for="minOrderPay">최소 주문 금액</label>
	    <input type="number" id="minOrderPay" name="minOrderPay" placeholder="최소 주문 금액">
	
	    <label for="expirationDate">만료일</label>
	    <input type="date" id="expirationDate" name="expirationDate" required>
	
	    <label for="active">쿠폰 활성화 여부</label>
	    <select id="active" name="active" required>
	      <option value="ON">활성화</option>
	      <option value="OFF">비활성화</option>
	    </select>
	    
			<div style="margin-top: 20px;">
	      <button type="button" onclick="fCheck()" class="blackLine-btn">쿠폰 발급</button>
			</div>
	  </form>
	</div>
</body>
</html>