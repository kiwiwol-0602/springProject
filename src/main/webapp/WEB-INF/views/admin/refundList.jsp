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
	<title>교환 및 환불 리스트 | LUMI</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<jsp:include page="/WEB-INF/views/include/fonts.jsp" />
	<style type="text/css">
		body {
	    font-family: Arial, sans-serif;
	    margin: 0;
	    padding: 0;
	    background-color: #f4f4f4;
		}
		
		.refundListAdmin {
	    width: 100%;
	    margin: 20px auto;
	    background-color: white;
	    padding: 50px 40px;
	    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		}
		
		h1 {
	    text-align: center;
	    color: #333;
		}
		
		/* 테이블 스타일 */
		.product-table {
		    width: 100%;
		    border-collapse: collapse;
		    margin-top: 20px;
		}
		
		.product-table th, .product-table td {
		    padding: 12px 15px;
		    border: 1px solid #ddd;
		    text-align: center;
		}
		
		.product-table th {
		    background-color: #f8f8f8;
		    color: #333;
		    font-size: 13px;
		    font-weight: bold;
		}
		.product-table td {
		    font-size: 13px;
		}
		
		.product-table tr:nth-child(even) {
		    background-color: #f9f9f9;
		}
		
		.product-table tr:hover {
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
		    let checkboxes = document.querySelectorAll('input[name="orderCheck"]');
		    checkboxes.forEach(function(checkbox) {
		      checkbox.checked = !checkbox.checked;
		    });
		  }
		
		function productDelete(idx) {
			let ans = confirm("선택한 상품을 삭제하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				type : "post",
				url  : "${ctp}/shop/productDelete",
				data : {idx : idx},
				success:function(res){
					if(res != "0"){
						alert("상품을 삭제했습니다.");
						location.reload();
					}
					else{
						alert("상품을 삭제하는데 오류가 발생했습니다.");
					}
				},
				error:function(){
					alert("전송오류");
				}
			});
		}
		
		function stausSelectCheck() {
			let select = document.getElementById("ordrtstatus");
			let statusSelectText = select.options[select.selectedIndex].text;
	    let statusSelect = document.getElementById("ordrtstatus").value;
	    	
			let checkedOrders = document.querySelectorAll('input[type="checkbox"]:checked');
			let orderIdxs = Array.from(checkedOrders).map(checkbox => checkbox.id.replace('orderCheck', ''));
			
			let idxSelectArray = '';
	    	for(let i=0; i<orderform.orderCheck.length; i++) {
	    		if(orderform.orderCheck[i].checked) idxSelectArray += orderform.orderCheck[i].value + "/";
	    	}
	    	idxSelectArray = idxSelectArray.substring(0,idxSelectArray.lastIndexOf("/"));
	    	
	    	let query = {
	    			statusSelect : statusSelect,
	    			idxSelectArray : idxSelectArray
	    	}
	    	
			$.ajax({
				type : "post",
				url  : "${ctp}/admin/statusSelectCheck",
				data: query,  // 배열을 전송
		    success: function(res) {
	        if (res != "0") {
	        	alert("선택한 항목들이 " + statusSelectText + "(으)로 변경되었습니다.");
            location.reload();
	        } else {
            alert("상품을 삭제하는데 오류가 발생했습니다.");
            location.reload();
	        }
		    },
		    error: function() {
		        alert("전송오류");
		    }
			});
		}
	
	</script>
</head>
<body>
	<div class="refundListAdmin">
  	<h1>교환 및 환불 신청 리스트</h1>
  			<table style="width: 100%; margin-top: 40px;">
  				<tr style="width: 100%;">
      			<td class="left-align" style="justify-content: flex-start; width: 350px">
      			<div class="input-group">
	            <input type="text" name="orderString" id="orderString" class="form-control" value="선택한 주문을" style="width: 10%;" readonly/>
	            <select name="ordrtstatus" id="ordrtstatus" class="form-select" style="border-radius:0;  width: 20%">
	                <option value=""></option>
	                <option value="결제완료">결제완료</option>
	                <option value="상품준비중">상품준비중</option>
	                <option value="배송중">배송중</option>
	                <option value="배송완료">배송완료</option>
	                <option value="구매확정">구매확정</option>
	            </select>
	            <input type="button" value="일괄처리" onclick="stausSelectCheck()" class="btn btn-secondary btn-sm" style="width: 22%"/>
	            <input type="hidden" name="pag" value="${pag}" />
	            <input type="hidden" name="pageSize" value="${pageSize}" />
			        </div>
      			</td>
      			<td class="right-align" style="justify-content: flex-end; text-align: right;">
      			<a href="#" class="btn-gray" style="">취소</a>
      			<a href="#" class="btn-gray" style="">교환</a>
      			<a href="#" class="btn-gray" style="">반품</a>
      			<a href="#" class="btn-gray" style="">환불</a>
      			</td>
      		</tr>
  			</table>
				<div class="searchProduct" style="display: flex; justify-content: center; align-items: center; width: 100%; height: 100%; padding: 20px 0;">
			    <form name="searchForm" method="get" action="${ctp}/admin/orderSearchList" style="width: 100%;">
			        <div class="input-group">
			            <select name="search" id="search" class="form-select" onchange="cursorMove()" style="border-radius:0;  width: 16%">
			                <option value="orderIdx">주문번호</option>
			                <option value="name">주문자</option>
			                <option value="productName">상품명</option>
			                <option value="orderStatus">주문상태</option>
			            </select>
			            <input type="text" name="searchString" id="searchString" class="form-control" required placeholder="검색어를 입력하세요" style="width: 73%"/>
			            <input type="submit" value="검색" class="btn btn-secondary btn-sm" style="width: 9.5%"/>
			            <input type="hidden" name="pag" value="${pag}" />
			            <input type="hidden" name="pageSize" value="${pageSize}" />
			        </div>
			    </form>
				</div>
				<form name="orderform">
	        <table class="product-table">
	            <thead>
	                <tr>
	                		<th><input type="checkbox" id="allCheck" onclick="reverseCheck()"/></th>
	                    <th>상품주문번호</th>
	                    <th>주문번호</th>
	                    <th>주문일시</th>
	                    <th>주문자</th>
	                    <th>주문상품</th>
	                    <th>옵션정보</th>
	                    <th>수량</th>
	                    <th>총주문금액</th>
	                    <th>주문상태</th>
	                    <th>관리</th>
	                </tr>
	            </thead>
							<c:forEach var="vo" items="${vos}" varStatus="st">
								<c:if test="${vo.orderStatus eq '교환및환불'}">
							 	 <tr style="word-break: break-all;">
			            	<td style="width: 50px;"><input type="checkbox" name="orderCheck" id="orderCheck${vo.idx}" value="${vo.idx}" /></td>
			              <td style="width: 80px;">${vo.idx}</td>
			              <td style="word-break: break-all; width: 110px;">${vo.orderIdx}</td>
			              <td style="word-break: break-all; width: 90px;">${fn:substring(vo.orderDate,0,19)}</td>
			              <td style="word-break: break-all; width: 100px;">${vo.name}</td>
			              <td style="word-break: break-all; width: 240px;">${vo.productName}</td>
			              <td style="word-break: break-all; width: 110px;">${vo.optionName}</td>
			              <td style="word-break: break-all; width: 70px;">${vo.optionNum}</td>
			              <td style="width: 110px;"><fmt:formatNumber value="${vo.totalPay}" pattern="#,##0"/>원</td>
			              <td style="width: 80px;">${vo.orderStatus}</td>
			              <td style="width: 90px;">
			              </td>
			            </tr>
		            </c:if>
	            </c:forEach>
	        </table>
	       </form>
        
        <div class="text-center" style="margin-top: 20px;">
  <ul class="pagination justify-content-center">
	  <c:if test="${pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/refundList?pageSize=${pageSize}&pag=1">첫페이지</a></li></c:if>
	  <c:if test="${curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/refundList?pageSize=${pageSize}&pag=${(curBlock-1)*blockSize + 1}">이전블록</a></li></c:if>
	  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize) + blockSize}" varStatus="st">
	    <c:if test="${i <= totPage && i == pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/admin/refundList?pageSize=${pageSize}&pag=${i}">${i}</a></li></c:if>
	    <c:if test="${i <= totPage && i != pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/refundList?pageSize=${pageSize}&pag=${i}">${i}</a></li></c:if>
	  </c:forEach>
	  <c:if test="${curBlock < lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/refundList?pageSize=${pageSize}&pag=${(curBlock+1)*blockSize+1}">다음블록</a></li></c:if>
	  <c:if test="${pag < totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/refundList?pageSize=${pageSize}&pag=${totPage}">마지막페이지</a></li></c:if>
  </ul>
</div>
	</div>
</body>
</html>