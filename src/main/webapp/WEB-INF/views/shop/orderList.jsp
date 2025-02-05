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
	<title>구매내역 | LUMI</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<jsp:include page="/WEB-INF/views/include/fonts.jsp" />
	<style>
	  .table {
	      background-color: #fff;
	      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	      table-layout: auto; /* Allow columns to size based on content */
	      width: 100%; /* Ensure table stretches fully */
	  }
	  .table th, .table td {
	      padding: 15px;
	      font-size: 14px;
	      white-space: nowrap; /* Prevent wrapping */
	      text-align: center;
	  }
	  .table-row:hover {
	      background-color: #e9f5ff !important;
	      transition: background-color 0.3s ease;
	  }
	  .text-center {
	      text-align: center;
	  }
	  .blank {
	      margin-bottom: 50px;
	      height: 50px;
	  }
	  .cart-items {
      width: 80%;
      margin: 0px auto 30px auto; 
    }

    .cart-item {
      display: flex;
      align-items: center;
      border-bottom: 1px solid #eee;
      padding: 15px 0;
    }

    .cart-item img {
      width: 200px;
      height: 200px;
      padding-left: 20px;
      margin-right: 30px;
    }

    .item-details {
      flex: 1;
    }

    .item-details .input-group {
      font-size: 14px;
      margin-bottom: 3px;
    }

    .item-details .original-price {
      text-decoration: line-through;
      color: #999;
      font-size: 14px;
      margin: 0;
    }

    .item-details .price {
      font-weight: bold;
      font-size: 16px;
      margin: 0;
    }

    .quantity {
      display: flex;
      align-items: center;
    }

    .quantity button {
      width: 30px;
      height: 30px;
      border: 1px solid #ddd;
      background-color: #f7f7f7;
      cursor: pointer;
    }
	</style>
	<script type="text/javascript">
		function statusChange(idx, state) {
			
			alert(idx);
			alert(state);
			
			
			$.ajax({
				type : "post",
				url  : "${ctp}/shop/orderStatusChange",
				data: {
					idx		: idx,
					state : state
				}, 
		    success: function(res) {
	        alert(state+" 신청했습니다.");
	        location.reload();
		    },
		    error: function() {
		        alert("전송오류");
		    }
			});
		}
	
	</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<div class="container" style="margin-top: 10%">
	<i class="fa-solid fa-arrow-left" style="font-size: 30px; padding: 0; margin: 0;" onclick="location.href='${ctp}/member/userPage'"></i>
	<h1 class="text-center" style="margin-bottom: 30px;">구매 리스트</h1>
	<div class="cart-items">
	      <div>
	      </div>
        <c:forEach var="vo" items="${vos}" varStatus="st">
        <hr/>
          <div class="cart-item">
          	<img src="${ctp}/product/${vo.thumbnail}" alt="Thumbnail" class="default-img">
            <input type="hidden" name="thumbnail" value="${vo.thumbnail}">
            <div class="item-details">
            	<div>
            		<c:if test="${vo.orderStatus eq '결제완료'}"><div style="color: gray; font-weight: bold; font-size: 20px;">${vo.orderStatus}</div></c:if>
	          		<c:if test="${vo.orderStatus eq '배송준비중'}"><div style="color: green; font-weight: bold; font-size: 20px;">${vo.orderStatus}</div></c:if>
	          		<c:if test="${vo.orderStatus eq '배송중'}"><div style="color: green; font-weight: bold; font-size: 20px;">${vo.orderStatus}</div></c:if>
	          		<c:if test="${vo.orderStatus eq '배송완료'}"><div style="color: green; font-weight: bold; font-size: 20px;">${vo.orderStatus}</div></c:if>
	          		<c:if test="${vo.orderStatus eq '구매확정'}"><div style="color: #37AFE1; font-weight: bold; font-size: 20px;">${vo.orderStatus}</div></c:if>
	          		<c:if test="${vo.orderStatus eq '교환및환불'}"><div style="color: red; font-weight: bold; font-size: 20px;">${vo.orderStatus}</div></c:if>
            	</div>
            	<div style="text-align: right;">
            		<c:if test="${!(vo.orderStatus eq '구매확정' || vo.orderStatus eq '교환및환불')}">
	              	<button type="button" onClick="statusChange(${vo.idx},'교환및환불')" class="btn btn-outline-danger btn-sm">교환 및 환불</button>
	              </c:if>
            	</div>
              <div class="input-group" style="text-align: center; margin-top: 15px;">
             		<div class="company input-group-prepend">${vo.orderIdx}</div>
                <div class="trash company">&nbsp;&nbsp;/&nbsp;&nbsp;</div>
                <div class="category input-group-append">${fn:substring(vo.orderDate,0,16)}</div>
              </div>
              <div class="productName" style="font-size: 18px; margin-top: 5px;">
              	<div class="company input-group-prepend">
                	<a href="${ctp}/shop/productContent?idx=${vo.productIdx}">${vo.productName}</a>
                </div>
               </div>
              <p style="margin-top: 5px; font-size: 15px;">
	              <c:set var="optionNames" value="${fn:split(vo.optionName,',')}"/>
				        <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
				        <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
		          	<c:forEach var="i" begin="0" end="${fn:length(optionNames)-1}">
		            	옵션:&nbsp;${optionNames[i]} &nbsp;&nbsp; ${optionNums[i]}개 &nbsp;&nbsp;<fmt:formatNumber value="${optionPrices[i]*optionNums[i]}"/>원<br/>
		          	</c:forEach>
              	<input type="hidden" name="price" id="cartPrice${st.index}" value="${vo.price}"/>
            	</p>
            	<div style="font-size: 18px;">
            		총 가격 : <fmt:formatNumber value="${vo.totalPrice}" pattern='#,###원'/>
          		<input type="hidden" id="totalPrice${vo.idx}" value="${vo.totalPrice}"/>
            	</div>
            </div>
          </div>
          <div style="width: 100%; text-align: center; margin-top: 10px;">
          	<c:if test="${!(vo.orderStatus eq '구매확정')}">
          		<button type="button" onClick="" class="btn btn-warning" style="width: 30%; height: 45px; color:white;">배송조회</button>
          		<button type="button" onClick="statusChange(${vo.idx},'구매확정')" class="btn btn-primary" style="width: 30%; height: 45px;">구매확정</button>
          	</c:if>
          	<c:if test="${vo.orderStatus eq '구매확정'}">
          		<button type="button" onClick="location.href='${ctp}/shop/productContent?idx=${vo.productIdx}'" class="btn btn-primary" style="width: 30%; height: 45px;">재구매</button>
          	</c:if>
          		<button type="button" onClick="" class="btn btn-success" style="width: 30%; height: 45px;">리뷰작성</button>
          </div>
          <hr/>
          <div style="margin-bottom: 50px;"></div>
        </c:forEach>
      </div>
	</div>
	<footer>
		<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
	</footer>
</body>
</html>