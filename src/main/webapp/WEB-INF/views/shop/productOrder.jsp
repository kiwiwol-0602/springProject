<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbOrder.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp"/>
 
  <style>
    td, th {padding: 5px}
    body {
		  font-family: Arial, sans-serif;
		  margin: 0;
		  padding: 0;
		  background-color: #f9f9f9;
		}

		.order-container {
			  max-width: 100%;
			  margin: 9% 11.5%;
			  background-color: #fff;
			}
	
		h2 {
			font-family: 'Gyeonggi_Title_Medium';
		  font-size: 10px;
		  text-align: center;
		}
		
		.cart-items {
		  border: 1px solid #eee; /* 보더 색상과 두께 설정 */
		  padding: 30px; /* 보더 안쪽 여백 설정 */
		  border-radius: 10px; /* 보더 모서리를 둥글게 설정 (선택 사항) */
		  background-color: #fff; /* 배경 색상 추가 (선택 사항) */
		  margin-bottom: 20px; /* 외부 여백 추가 */
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
		
		.item-details .discounted-price {
		  color: #e60023;
		  font-weight: bold;
		  font-size: 14px;
		  margin: 0;
		}
		.item-details .price {
		  font-weight: bold;
		  font-size: 16px;
		  margin: 0;
		}
		.item-details .titleName {
		  font-size: 16px;
		  margin: 0 0 50px 0;
		}
		.item-details p {
			margin: 0;
			padding: 0;
		}
		
		.quantity {
		  display: flex;
		  align-items: center;
		}
		
		.quantity button {
		  width: 70px;
		  height: 30px;
		  font-size: 14px;
		  border: 1px solid #ddd;
		  background-color: #f7f7f7;
		  cursor: pointer;
		}
		
		.quantity span {
		  margin: 0 10px;
		}
		
		.summary {
			width: 100%;
		  padding: 30px 50px;
		  border: 1px solid #eee;
		  border-radius: 8px;
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
		  font-size: 18px;
			font-family: 'Gyeonggi_Title_Medium';
			padding: 20px 0;
			
		}
		.information {
      display: flex;
      align-items: center;
      border-top: 1px solid #eee;
      border-bottom: 1px solid #eee;
      padding-top: 20px;
      padding-bottom: 20px;
      margin-top: 30px;
      margin-bottom: 30px;
  }
  .information div {
      font-size: 24px;
      margin-right: 20px;
  }
  .user-information {
      display: flex;
      flex-direction: column;
      margin-bottom: 20px;
  }
  .user {
    border: 1px solid #eee;
    padding: 20px;
    text-align: left;
    display: flex;
  	flex-direction: column;
  }
  .Name{
  	font-size: 28px;
  	font-family: 'Gyeonggi_Title_Medium';
  }
  .Id{
  	font-size: 15px;
  	color: gray;
  }
  .coupons{
  	font-size: 13px;
  	color: gray;
  }
  .point{
  	font-size: 13px;
  	color: gray;
  }
  .user-title{
  	font-size: 14px;
  	margin-bottom: 8px;
  }
  
  .btn-outline-black {
  	width: 100%;
   	height: 50px; /* 수량 입력 필드와 동일한 높이 */
    line-height: 1; /* 텍스트가 가운데 정렬되도록 */
    border: 1px solid #0a0a0a;
    background-color: #0a0a0a;
    color: #fff;
    font-size: 15px;
    border-radius: 5px;
    transition: background-color 0.3s ease;
    margin-bottom: 3px;
  }

  .btn-outline-black:hover {
    background-color: #fff;
    color: #0a0a0a;
  }
  
  .back{
	  font-size: 30px;
	  color: gray;
	  z-index: 10;  /* 다른 요소들 위에 표시되도록 설정 */
  }
  
  .back a{
  color: gray;
  text-decoration: none;
  }
  
  </style>
	<script type="text/javascript">
		'use strict'
  	function calculateOrder() {
    	let totalPrice = 0;
	    let totalDiscount = 0;
	    
	    // 모든 옵션에 대해 계산
	    document.querySelectorAll('[data-price]').forEach(function(item) {
	      const price = parseFloat(item.getAttribute('data-price'));
	      const quantity = parseInt(item.getAttribute('data-quantity'));
	      const pay = parseFloat(item.getAttribute('data-pay'));
	      
	      // 주문금액: price * quantity
	      totalPrice += price * quantity;
	      
	      // 할인금액: pay * quantity
	      totalDiscount += (price-pay) * quantity;
	    });
	
	    // 결과를 화면에 출력
	    document.getElementById('totalPrice').value = totalPrice;
	    
	    document.getElementById('totalDiscount').value = totalDiscount;
	    document.getElementById('originalDiscount').value = totalDiscount;
	    
	    document.getElementById('totalPay').value = (totalPrice - totalDiscount);
	    document.getElementById('originalTotalPay').value = (totalPrice - totalDiscount);
		}
		
		// 페이지가 로드되면 계산 수행
		window.onload = function() {
    	calculateOrder();
		}
  	
  	function selectCoupon() {
  	  // 모달을 띄움
  	  $('#couponModal').modal('show');
		}
  	
  	
  	$(document).ready(function(){
		  $(".nav-tabs a").click(function(){
		    $(this).tab('show');
  	  });
      $('.nav-tabs a').on('shown.bs.tab', function(event){
		    var x = $(event.target).text();         // active tab
        var y = $(event.relatedTarget).text();  // previous tab
      });
    });
     
  	
  	function couponDC() {
  	    // 선택된 쿠폰 가져오기
  	    const selectedCoupon = document.querySelector('input[name="selectedCoupon"]:checked');
  	    if (!selectedCoupon) {
  	        alert('쿠폰을 선택해주세요.');
  	        return;
  	    }

  	    const couponIdx = selectedCoupon.dataset.couponidx;
  	    const userCoIdx = selectedCoupon.value;

  	    // 원래 총 결제 금액 (변경 전의 금액)
  	    let originalTotalPay = document.getElementById('originalTotalPay').value;
  	    let originalDiscount = document.getElementById('originalDiscount').value;

  	    // 현재 적용된 할인 금액을 가져옴
  	    let totalDiscountElement = document.getElementById('totalDiscount');
  	    let currentDiscount = parseFloat(totalDiscountElement.value);

  	    // 기존 할인 제거: 기존 할인 금액을 원래 금액에서 뺀 것을 복구
  	    let totalPayElement = document.getElementById('totalPay');
  	    let totalPay = originalTotalPay + currentDiscount;

  	    // 새로운 쿠폰 할인 적용
  	    $.ajax({
  	        type: 'POST',
  	        url: '${ctp}/shop/applyCoupon',
  	        data: {
  	            couponIdx: couponIdx,
  	            totalPay: originalTotalPay, // 원래 금액을 서버로 보냄
  	            userCoIdx: userCoIdx
  	        },
  	        success: function (response) {
  	            if (response.success) {
  	                // 서버에서 새 쿠폰 할인 금액을 가져와 반영
  	                let newTotalDiscount = response.newTotalDiscount;

  	                // 새 할인 금액으로 총 결제 금액 다시 계산
  	                totalPay = originalTotalPay - newTotalDiscount;

  	                // 새로운 할인 금액 반영
  	                $('#totalDiscount').val(Number(newTotalDiscount)+Number(originalDiscount));
  	                $('#totalPay').val(totalPay);

  	                // 쿠폰 정보 업데이트
  	                $('#ucNameCode').val(response.ucName);
  	                $('#userCouponCode').val(response.ucCode);

  	                // 모달 닫기
  	                $('#couponModal').modal('hide');
  	            } else {
  	                alert('쿠폰 적용에 실패했습니다.');
  	            }
  	        },
  	        error: function () {
  	            alert('서버 오류가 발생했습니다.');
  	        }
  	    });
  	}
 
function pointCheck(all){
	let allPoint = ${userVO.point};
		let	point = document.getElementById("point").value;
	let totDiscount = document.getElementById("totalDiscount").value;
	let totPay = document.getElementById("totalPay").value;
	
	if(all){
		point = allPoint;  // 전액 사용시 보유 포인트를 사용
    document.getElementById("point").value = point;  // 포인트 입력창에도 전액 사용한 값으로 업데이트
	}
	
	// 포인트가 결제 금액을 넘는지 체크 (넘으면 총 결제 금액까지만 적용)
  if (Number(point) > Number(totPay)) {
      point = totPay;  // 결제 금액보다 많은 포인트 사용을 방지
  }
	
	
	$('#totalDiscount').val((Number(totDiscount)+Number(point)));

	$('#totalPay').val((totPay-point));
}
     
     
     // 결제하기
     function order() {
       var ans = confirm("결재하시겠습니까?");
       if(ans) {
         myform.action = "${ctp}/shop/payment";
         myform.submit();
       }
     }
     

   </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>
<div class="order-container">
	<form name="myform" method="post">
	<div class="summary">
		<div class="back">
   	<a href="${ctp}/shop/productCartList" style="text-align: left;">
   		<i class="fa-solid fa-caret-left"></i>
	   	<!-- <i class="fas fa-shopping-bag"></i> -->
   	</a>
  </div>
		<h2>주문서</h2>
		
	  <!-- 상품 정보 -->
	  <div class="information">
	    <div class="user-details">
	      <span class="Name">${userVO.name}</span>
	      <span class="Id">${userVO.mid}</span>
	      <span class="coupons">쿠폰(${fn:length(userCouponVOS)})</span>
	      <span class="point">포인트(<fmt:formatNumber value="${userVO.point}" pattern="#,##0"/>원)</span>
	    </div>
	  </div>
	  
  <div class="row">
    <!-- 상품 정보 영역 (왼쪽, 6 비율) -->
    <div class="col-7">
    <table class="text-center" style="margin:auto; width:90%">
    	<c:forEach var="vo" items="${sOrderVos}">
    	<tr>
    		<td><p><br/>주문번호 : ${vo.orderIdx}</p></td>
    	</tr>
      <tr align="center">
        <td><img src="${ctp}/product/${vo.thumbnail}" width="150px"/></td>
        <td align="left">
          <p class="text-left">
            <span style="font-weight:bold; font-size: 18px;">${vo.productName}</span><br/>
	          <c:set var="optionNames" value="${fn:split(vo.optionName,',')}"/>
	          <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
	          <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
	          <span>
	            <br/>
	            <c:forEach var="i" begin="1" end="${fn:length(optionNames)}">
	              &nbsp; &nbsp;ㆍ ${optionNames[i-1]}  &nbsp; ${optionNums[i-1]}개  &nbsp; <fmt:formatNumber value="${optionPrices[i-1]*optionNums[i-1]}"/>원<br/>
	             <span data-price="${vo.price}" data-quantity="${optionNums[i-1]}" data-pay="${optionPrices[i-1]}"></span>
	            </c:forEach>
	            <br/>
	          </span>
	          <div style="text-align: right; margin-right: 20px; font-size: 13px;">
		          (즉시 할인 적용)<br/>
		          <b style="font-size: 18px;"><fmt:formatNumber value="${vo.totalPrice}" pattern='₩ #,###'/></b><br/>
	          </div>
          </p>
         </td>
        </tr>
       <tr>
        <td colspan="3">
		  		<hr style="width: 100%; margin: 0;" />
        </td>
      </tr>
      <%-- <input type="hidden" name="cartIdx" value="${idx}"/> --%>  <!-- 장바구니고유번호를 비롯한 주문된 상품의 정보들은 세션에 담겨있기에 굳이 따로 넘길필요없다. 즉 따로이 입력된 배송지 정보들만 넘긴다. -->
    </c:forEach>
  </table>
  <table style="margin:auto; width:90%">
  	<tr>
  		<td>
  			<div>
  				<span>할인쿠폰</span>
					<div class="input-group">
					<input type="text" class="form-control" id="ucNameCode" value=""/>
        	<input type="button" class="btn btn-dark" id="couponSelectBtn" value="쿠폰 선택" onclick="selectCoupon()"/>
        	<input type="hidden" id="userCouponCode" name="userCouponCode"/>
					</div>
  			</div>
  		</td>
  	</tr>
  	<tr>
  		<td>
  			<div>
  				<span>보유포인트 <font style="color: red; font-weight: bold;"><fmt:formatNumber value="${userVO.point}" pattern='#,###원'/></font></span>
					<div class="input-group">
					<input type="number" class="form-control" id="point" name="point" value="0" onchange="pointCheck()"/>
        	<input type="button" class="btn btn-dark" id="couponSelectBtn" value="전액사용" onclick="pointCheck(true)"/>
					</div>
  			</div>
  		</td>
  	</tr>
  	<tr>
  		<td>주문금액
  			<div><input type="number" id="totalPrice" name="totalPrice" style="text-align: right; font-weight: bold;"/></div>
  		</td>
  	</tr>
  	<tr>
  		<td>할인금액
  			<div><input type="number" id="totalDiscount" name="totalDiscount" style="text-align: right; font-weight: bold;"></div>
  		</td>
  	</tr>
  	<tr>
  		<td>
  			<hr/>
			  <div><b>총 주문(결재) 금액</b></div>
		    <div><input type="number" id="totalPay" name="totalPay" style="text-align: right; font-weight: bold;"></div>
  		</td>
  	</tr>
  </table>
  </div>
    <!-- 구매자 정보 영역 (오른쪽, 4 비율) -->
   <div class="col-5">
  <div class="cart-items">
    <div class="user-information">
      <div class="user-title">성명</div>
      <div class="user-info">
        <input type="text" name="buyer_name" value="${userVO.name}" readonly class="form-control" />
      </div>
    </div>
    
     <div class="user-information">
      <div class="user-title">연락처</div>
      <div class="user-info">
        <input type="text" name="buyer_tel" value="${userVO.tel}" class="form-control" />
      </div>
    </div>
    
    <div class="user-information">
      <div class="user-title">이메일</div>
      <div class="user-info">
        <input type="text" name="buyer_email" value="${userVO.email}" class="form-control" />
      </div>
    </div>
    
    <div class="user-information">
      <div class="user-title">배송지</div>
      <div class="user-info">
        <input type="text" name="buyer_addr" value="${fn:replace(userVO.address, '/', ' ')}" class="form-control" />
      </div>
    </div>
    
    <div class="user-information">
      <div class="user-title">배송요청사항</div>
      <div class="user-info">
        <select name="message" class="form-select">
          <option>문 앞에 놔주세요</option>
          <option>경비실에 맡겨주세요</option>
          <option>택배함에 넣어주세요</option>
          <option>배송 전에 연락주세요</option>
        </select>
      </div>
    </div>
    
    <div class="tab-content">
      <button type="button" class="btn-outline-black" onClick="order()">결제하기</button><%-- 
      <button type="button" class="btn btn-info" onclick="location.href='${ctp}/dbShop/dbCartList';">장바구니보기</button> &nbsp;
      <button type="button" class="btn btn-success" onClick="location.href='${ctp}/dbShop/dbProductList';">계속 쇼핑하기</button> --%>
     </div>
    </div>
  </div>
	  <input type="hidden" name="orderIdx" value="${orderIdx}"/>
	  <input type="hidden" name="mid" value="${sMid}"/>
	  <input type="hidden" name="payment" id="payment"/>
	  <input type="hidden" name="payMethod" id="payMethod"/>
	  <input type="hidden" name="amount" value="10"/>
	  <input type="hidden" name="productName" value="${sOrderVos[0].productName}"/>
	  <input type="hidden" name="originalTotalPay" id="originalTotalPay"/>
	  <input type="hidden" name="originalDiscount" id="originalDiscount"/>
	  </div>
	  </div>
	  
	  <!-- 쿠폰 선택 모달 -->
<div class="modal fade" id="couponModal" tabindex="-1" aria-labelledby="couponModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="couponModalLabel">쿠폰 선택</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <ul id="couponModalBody" style="list-style-type: none;">
        	<c:forEach var="userCoupon"	items="${userCouponVOS}" varStatus="st">
		        <li>
			        <input type="radio" name="selectedCoupon" value="${userCoupon.idx}" id="coupon${userCoupon.idx}" data-couponIdx="${userCoupon.couponIdx}">
			        <label for="coupon${userCoupon.idx}">${userCoupon.couponName}(${userCoupon.userCouponCode}) 
			        	- 할인 
			        	<c:choose>
							    <c:when test="${userCoupon.discountType eq 'percent'}">
							      ${userCoupon.discount}%
							    </c:when>
							    <c:otherwise>
							      ${userCoupon.discount}₩
							    </c:otherwise>
							  </c:choose>
			        </label>
		        </li>
        	</c:forEach>
        </ul>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
        <button type="button" class="btn btn-primary" id="applyCouponBtn" onclick="couponDC()">쿠폰 적용</button>


      </div>
    </div>
  </div>
</div>
</form>
</div>
<p><br/></p>
</body>
</html>