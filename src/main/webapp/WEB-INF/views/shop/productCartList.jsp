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
	<title>장바구니 | LUMI</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<jsp:include page="/WEB-INF/views/include/fonts.jsp" />
		<style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f9f9f9;
    }

    .cart-container {
      max-width: 50%;
      margin: 10% auto 3% auto;
      padding: 3%;
      background-color: #fff;
    }

    h2 {
      font-family: 'Gyeonggi_Title_Medium';
      font-size: 10px;
      padding-bottom: 10px;
      padding-left: 30px;
      text-align: center;
    }

    .cart-items {
      margin-bottom: 30px;
    }

    .cart-item {
      display: flex;
      align-items: center;
      border-bottom: 1px solid #eee;
      padding: 15px 0;
    }

    .cart-item img {
      width: 150px;
      height: 170px;
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

    .summary h3 {
      font-family: 'Gyeonggi_Title_Medium';
      font-size: 30px;
      margin-bottom: 30px;
    }

    .summary p {
      margin: 10px 0;
      font-size: 14px;
    }

    .summary .total {
      font-size: 25px;
      font-family: 'Gyeonggi_Title_Medium';
      padding: 20px 0;
    }
    
    a {
    	text-decoration: none !important;
    	color: black !important;
    }
		a:hover {
			text-decoration: none !important;
    	color: gray !important;
		}
		
	 .btn-outline-black {
  	width: 80px;
   	height: 50px; /* 수량 입력 필드와 동일한 높이 */
    line-height: 1; /* 텍스트가 가운데 정렬되도록 */
    border: 1px solid #0a0a0a;
    background-color: #fff;
    color: #0a0a0a;
    font-size: 12px;
    border-radius: 0;
    transition: background-color 0.3s ease;
    margin-bottom: 3px;
  }

  .btn-outline-black:hover {
    background-color: #0a0a0a;
    color: #fff;;
  }
  
  .totSubBox {
  	border: none;
  	background-color: transparent;
  }
  </style>
  <script type="text/javascript">
  'use strict';
  
  // 선택상품 구매 취고(장바구니에서 빼기)
  function cartDelete(idx) {
      let ans = confirm("선택하신 현재상품을 장바구니에서 제거 하시겠습니까?");
      if(!ans) return false;
      
      $.ajax({
        type : "post",
        url  : "${ctp}/shop/cartDelete",
        data : {idx : idx},
        success:function(res) {
          location.reload();
        },
        error : function() {
        	alert("전송에러");
        }
      });
    }
    
    function onCheck() {
        let minIdx = parseInt(document.getElementById("minIdx").value);
        let maxIdx = parseInt(document.getElementById("maxIdx").value);
        
        let emptyCnt=0;
        for(let i=minIdx;i<=maxIdx;i++){
          if($("#idx"+i).length != 0 && document.getElementById("idx"+i).checked==false){
            emptyCnt++;
            break;
          }
        }
        if(emptyCnt!=0){
          document.getElementById("allcheck").checked=false;
        } 
        else {
          document.getElementById("allcheck").checked=true;
        }
        onTotal();
      }
      
      // 선택한 상품의 총가격 구하기
      function onTotal() {
        let total = 0;
        let minIdx = parseInt(document.getElementById("minIdx").value);
        let maxIdx = parseInt(document.getElementById("maxIdx").value);
        for(let i=minIdx;i<=maxIdx;i++){
          if($("#totalPrice"+i).length != 0 && document.getElementById("idx"+i).checked){
            total = total + parseInt(document.getElementById("totalPrice"+i).value); 
          }
        }
        document.getElementById("total").value=numberWithCommas(total);
        
        // 배송비 처리(5만원 이상이면 무료배송, 미만이면 3000원 지급)
        
        let lastPrice=total;
        document.getElementById("lastPrice").value = numberWithCommas(lastPrice);
        document.getElementById("orderTotalPrice").value = numberWithCommas(lastPrice);	
      }
      
      // 전체 상품 선택처리
      function allCheck(){
      	let minIdx = parseInt(document.getElementById("minIdx").value);
        let maxIdx = parseInt(document.getElementById("maxIdx").value);
        if(document.getElementById("allcheck").checked){
          for(let i=minIdx;i<=maxIdx;i++){
            if($("#idx"+i).length != 0){
              document.getElementById("idx"+i).checked=true;
            }
          }
        }
        else {
          for(let i=minIdx;i<=maxIdx;i++){
            if($("#idx"+i).length != 0){
              document.getElementById("idx"+i).checked=false;
            }
          }
        }
        onTotal();	// 체크박스의 사용후에는 항상 재계산해야 한다.
      }
      
      // 장바구니에서 선택한 상품만을 주문처리하기
      function order(){
    	  /*
      	let minIdx = parseInt(document.getElementById("minIdx").value);
        let maxIdx = parseInt(document.getElementById("maxIdx").value);
        for(let i=minIdx;i<=maxIdx;i++){
          if($("#idx"+i).length != 0 && document.getElementById("idx"+i).checked){
            document.getElementById("checkItem"+i).value="1";
          }
        }
				*/
        document.myform.baesong.value = 0;
        
        if(document.getElementById("lastPrice").value==0){
          alert("장바구니에서 주문처리할 상품을 선택해주세요!");
          return false;
        } 
        else {
          document.myform.submit();
        }
      }
      
      function numberWithCommas(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
      }
  </script>
</head>
<body>
  <jsp:include page="/WEB-INF/views/include/header.jsp" />
  <jsp:include page="/WEB-INF/views/include/nav.jsp"/>
  <form name="myform" method="post" action="${ctp}/shop/productOrder">
    <div class="cart-container">
      <h2 style="font-family: 'Gyeonggi_Title_Medium'; font-size: 40px; margin-bottom: 30px;">장바구니</h2>
      <div class="cart-items">
	      <div>
		      <input type="checkbox" id="allcheck" onClick="allCheck()" class="m-2"/> 전체선택
	      </div>
        <c:forEach var="vo" items="${cartListVos}" varStatus="st">
          <div class="cart-item">
            <input type="checkbox" name="idxChecked" id="idx${vo.idx}" value="${vo.idx}" onClick="onCheck()">
          	<img src="${ctp}/product/${vo.thumbnail}" alt="Thumbnail" class="default-img">
            <input type="hidden" name="thumbnail" value="${vo.thumbnail}">
            <div class="item-details">
              <div class="input-group" style="text-align: center;">
             		<div class="company input-group-prepend">${vo.productCode}</div>
                <div class="trash company">&nbsp;&nbsp;/&nbsp;&nbsp;</div>
                <div class="category input-group-append">${fn:substring(vo.cartDate,0,16)}</div>
              </div>
              <div class="productName" style="font-size: 18px; margin-top: 15px;">
              	<div class="company input-group-prepend">
                	<a href="${ctp}/shop/productContent?idx=${vo.productIdx}">${vo.productName}</a>
                </div>
               </div>
              <p style="margin-top: 15px; font-size: 15px;">
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
            <div>
            		<button type="button" onClick="cartDelete(${vo.idx})" class="btn-outline-black">삭제</button>
				        <input type="hidden" name="checkItem" value="0" id="checkItem${vo.idx}"/>	<!-- 구매체크가 되지 않은 품목은 '0'으로, 체크된것은 '1'로 처리하고자 한다. -->
				        <input type="hidden" name="idx" value="${vo.idx }"/>
				        <input type="hidden" name="thumbnail" value="${vo.thumbnail}"/>
				        <input type="hidden" name="productName" value="${vo.productName}"/>
				        <input type="hidden" name="price" value="${vo.price}"/>
				        <input type="hidden" name="optionName" value="${optionNames}"/>
				        <input type="hidden" name="optionPrice" value="${optionPrices}"/>
				        <input type="hidden" name="optionNum" value="${optionNums}"/>
				        <input type="hidden" name="totalPrice" value="${vo.totalPrice}"/>
				        <input type="hidden" name="mid" value="${sMid}"/>
            </div>
          </div>
        </c:forEach>
        <c:set var="minIdx" value="${cartListVos[0].idx}"/>						<!-- 구매한 첫번째 상품의 idx -->
			  <c:set var="maxSize" value="${fn:length(cartListVos)-1}"/>		
			  <c:set var="maxIdx" value="${cartListVos[maxSize].idx}"/>			<!-- 구매한 마지막 상품의 idx -->
			  <input type="hidden" id="minIdx" name="minIdx" value="${minIdx}"/>
			  <input type="hidden" id="maxIdx" name="maxIdx" value="${maxIdx}"/>
			  <input type="hidden" name="orderTotalPrice" id="orderTotalPrice"/>
		    <input type="hidden" name="baesong"/>
      </div>
      <div class="summary">
      	<input type="hidden" id="total" value="0" class="totSubBox" readonly/>
        <p class="total" style="text-align: center;">총 주문 금액: <input type="text" id="lastPrice" value="0" class="totSubBox" style="text-align: right;" readonly/>&nbsp; 원</p>
        <input type="button" value="주 문 하 기" onclick="order()" class="form-control btn btn-outline-secondary" style="font-family: 'Gyeonggi_Title_Medium'; font-size: 20px;"/>
        <input type="hidden" name="idxArray" id="idxArray" value="">
      </div>
    </div>
  </form>   
</body>
</html>