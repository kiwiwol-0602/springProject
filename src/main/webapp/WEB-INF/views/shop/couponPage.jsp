<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="ctp/main/favicon.png">
	<title>쿠폰 | LUMI</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<jsp:include page="/WEB-INF/views/include/fonts.jsp" />
	<script>
    // 쿠폰 다운로드 로직
    function downloadCoupon(couponCode) {
      alert(couponCode + " 쿠폰을 다운로드합니다!");
      // 쿠폰 다운로드 서버 호출
      window.location.href = "/downloadCoupon?couponCode=" + couponCode;
    }
  </script>
	<style>
		body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
 	  }
 	  .couponPage {
 	  	width: 78%;
 	  	margin: 13% auto auto auto;
 	  }
    .coupon-list {
      width: 100%;
      margin: 0 auto;
      border-collapse: collapse;
    }
    .coupon-list th, .coupon-list td {
      padding: 10px;
      text-align: left;
      border-bottom: 1px solid #ddd;
    }
    .coupon-list th {
      background-color: #f4f4f4;
    }
    .download-btn {
      background-color: #4CAF50;
      color: white;
      padding: 5px 10px;
      border: none;
      cursor: pointer;
    }
    .download-btn:hover {
      background-color: #45a049;
    }
  </style>
  <script type="text/javascript">
  	'use strict'
  </script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<div class="couponPage">
  <h2 style="text-align: center;">쿠폰함</h2>
	
  <table class="coupon-list">
    <thead>
      <tr>
        <th>쿠폰 코드</th>
        <th>쿠폰 이름</th>
        <th>할인</th>
        <th>최소 주문 금액</th>
        <th>만료일</th>
      </tr>
    </thead>
    <tbody>
      <!-- 쿠폰 데이터를 반복해서 출력 -->
      <c:forEach var="coupon" items="${couponVOS}">
        <tr>
          <td>${coupon.userCouponCode}</td>
          <td>${coupon.couponName}</td>
          <td>
	          <c:choose>
					    <c:when test="${coupon.discountType eq 'percent'}">
					      ${coupon.discount}%
					    </c:when>
					    <c:otherwise>
					      ${coupon.discount}₩
					    </c:otherwise>
					  </c:choose>
				  </td>
          <td>${coupon.minOrderPay}</td>
          <td>${coupon.expirationDate}</td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
	</div>
</body>
</html>