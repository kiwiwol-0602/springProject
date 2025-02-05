<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>구매내역</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
  <style type="text/css">
    body {
      font-family: 'Arial', sans-serif;
      background-color: #f4f7fc;
      color: #333;
      margin: 0;
      padding: 0;
    }

    .orderDetail {
      max-width: 70%;
      margin: 15% auto 10% auto;
      background-color: #fff;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    h1 {
      text-align: center;
      color: #333;
      font-size: 32px;
      font-weight: bold;
      margin-bottom: 40px;
    }
    table {
	    margin: 0 auto; /* 가로로 테이블을 가운데 정렬 */
	    border-collapse: collapse; /* 테두리 간격 없애기 */
	    width: 80%; /* 원하는 넓이로 설정 */
	  }

    .section-title {
      margin-top: 30px;
      font-size: 18px;
      font-weight: bold;
      color: #2c3e50;
      border-bottom: 2px solid #ddd;
      padding-bottom: 5px;
    }

    .detail td {
      padding: 10px;
      vertical-align: top;
    }

    .detail img {
      border-radius: 5px;
      transition: transform 0.2s;
    }

    .price {
      color: #e74c3c;
      font-weight: bold;
    }

    .line-through {
      text-decoration: line-through;
      color: #aaa;
    }

    .order-summary {
      background-color: #f9f9f9;
      padding: 15px;
      border-radius: 5px;
      margin-top: 20px;
      text-align: center;
      font-size: 20px;
    }

    .order-summary .total {
      font-size: 24px;
      font-weight: bold;
      color: #2c3e50;
    }

    .order-info {
      color: #7f8c8d;
    }

    .order-info div {
      margin-bottom: 10px;
    }
    
    .btn-black {
  	width: 400px;
   	height: 60px; /* 수량 입력 필드와 동일한 높이 */
    line-height: 1; /* 텍스트가 가운데 정렬되도록 */
    border: 1px solid #0a0a0a;
    background-color: #fff;
    color: #0a0a0a;
    font-size: 20px;
    border-radius: 0;
    transition: background-color 0.3s ease;
    margin-bottom: 3px;
  }

  .btn-black:hover {
    background-color: #0a0a0a;
    color: #fff;
    
  }
  </style>
  <script>
    function nWin(orderIdx) {
      var url = "${ctp}/dbShop/dbOrderBaesong?orderIdx=" + orderIdx;
      window.open(url, "dbOrderBaesong", "width=350px,height=400px");
    }
  </script>
</head>
<body>
  <jsp:include page="/WEB-INF/views/include/header.jsp" />
  <jsp:include page="/WEB-INF/views/include/nav.jsp"/>
  <div class="orderDetail">
    <h1>주문 상세 정보</h1>
    <table class="detail">
      <tr>
        <td colspan="2">
          <div class="order-info">
            <div>주문일자 : ${fn:substring(orderVO.orderDate, 0, 19)}</div>
            <div>주문번호 : ${orderVO.orderIdx}</div>
          </div>
        </td>
      </tr>
      <tr><td colspan="2" class="section-title">주문상품</td></tr>
      <tr><td colspan="2" style="text-align:left; font-weight: bold; color: #2c3e50;">결제완료</td></tr>
      <c:forEach var="vo" items="${orderVos}">
        <tr>
          <td style="text-align:center;">
            <img src="${ctp}/product/${vo.thumbnail}" width="150px"/>
          </td>
          <td style="text-align:left; width: 400px; padding: auto;">
            <div><span style="color:black; font-weight:bold;">${vo.productName}</span><br/></div>
            <div>${vo.optionName} / ${vo.optionNum}개</div>
            <c:if test="${vo.totalPrice != vo.totalPay}">
              <div class="line-through"><fmt:formatNumber value="${vo.totalPrice}"/>원</div>
            </c:if>
            <div class="price"><fmt:formatNumber value="${vo.totalPay}"/>원</div>
          </td>
        </tr>
      </c:forEach>
      <tr><td colspan="2"><div class="section-title">배송지</div></td></tr>
      <tr>
        <td colspan="2">
          <div><b>${baesongVO.name}</b>(${baesongVO.mid})</div>
          <div>${baesongVO.tel}</div>
          <div><b>${baesongVO.address}</b></div>
        </td>
      </tr>
    </table>
    <div class="order-summary" sty>
      구매한 상품 총 금액(배송비 포함) : <b><fmt:formatNumber value="${baesongVO.totalPay}"/></b>원
    </div>
    <div style="width: 100%; display: flex; justify-content: space-between; align-items: center; margin-top: 10px;">
      <button type="button" onclick="location.href='${ctp}/main';" class="btn-black" style="margin-right: 10px;">계속 쇼핑하기</button>
      <button type="button" onclick="location.href='${ctp}/shop/myOrder';" class="btn-black">구매내역 보기</button>
  	</div>
  </div>
</body>
</html>
