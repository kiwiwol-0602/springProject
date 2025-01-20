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
	<title>상품리스트 | LUMI</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<jsp:include page="/WEB-INF/views/include/fonts.jsp" />
	<style type="text/css">
		body {
	    font-family: Arial, sans-serif;
	    margin: 0;
	    padding: 0;
	    background-color: #f4f4f4;
		}
		
		.productListAdmin {
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
		    let checkboxes = document.querySelectorAll('input[name="productCheck"]');
		    checkboxes.forEach(function(checkbox) {
		      checkbox.checked = !checkbox.checked;
		    });
		  }
		
		function productDelete(idx) {
			alert("idx : "+idx);
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
		
		function checkedProductDelete() {
			let checkedProducts = document.querySelectorAll('input[type="checkbox"]:checked');
			let productIdxs = Array.from(checkedProducts).map(checkbox => checkbox.id.replace('productCheck', ''));
			alert("productIdxs : "+productIdxs);
			
			$.ajax({
				type : "post",
				url  : "${ctp}/shop/productDelete",
				data: { idx: productIdxs },  // 배열을 전송
		    traditional: true,  // 배열을 직렬화해서 전송
		    success: function(res) {
	        if (res != "0") {
            alert("상품을 삭제했습니다.");
            location.reload();
	        } else {
            alert("상품을 삭제하는데 오류가 발생했습니다.");
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
	<div class="productListAdmin">
  	<h1>상품 리스트</h1>
  			<table style="width: 100%; margin-top: 40px;">
  				<tr style="width: 100%;">
      			<td class="left-align" style="justify-content: flex-start;">
      			<a href="#" class="btn-edit" style="padding: 5px 20px;">옵션등록</a>
      			<a href="javascript:checkedProductDelete()" class="btn-delete" style="padding: 5px 20px;">상품삭제</a>
      			</td>
      			<td class="right-align" style="justify-content: flex-end; text-align: right;">
      			<a href="#" class="btn-gray" style="">판매상태 OK</a>
      			<a href="#" class="btn-gray" style="">판매상태 Sold Out</a>
      			<a href="#" class="btn-gray" style="">진열상태 ON</a>
      			<a href="#" class="btn-gray" style="">진열상태 OFF</a>
      			</td>
      		</tr>
  			</table>
				<div class="searchProduct" style="display: flex; justify-content: center; align-items: center; width: 100%; height: 100%; padding: 20px 0;">
			    <form name="searchForm" method="get" style="width: 100%;">
			        <div class="input-group">
			            <select name="search" id="search" class="form-select" onchange="cursorMove()" style="border-radius:0;  width: 16%">
			                <option value="product">상품명</option>
			                <option value="categoryName">분류명</option>
			                <option value="status">판매상태</option>
			                <option value="display">진열상태</option>
			            </select>
			            <input type="text" name="searchString" id="searchString" class="form-control" required placeholder="검색어를 입력하세요" style="width: 73%"/>
			            <input type="submit" value="검색" class="btn btn-secondary btn-sm" style="width: 9.5%"/>
			            <input type="hidden" name="pag" value="${pag}" />
			            <input type="hidden" name="pageSize" value="${pageSize}" />
			        </div>
			    </form>
				</div>
        <table class="product-table">
            <thead>
                <tr>
                		<th><input type="checkbox" id="allCheck" onclick="reverseCheck()"/></th>
                    <th></th>
                    <th>상품 ID</th>
                    <th>상품명</th>
                    <th>대분류</th>
                    <th>중분류</th>
                    <th>소분류</th>
                    <th>원가격</th>
                    <th>할인율</th>
                    <th>판매가격</th>
                    <th>등록일</th>
                    <th>판매상태</th>
                    <th>진열상태</th>
                    <th>관리</th>
                </tr>
            </thead>
             <c:forEach var="vo" items="${vos}" varStatus="st">
                <tr style="word-break: break-all;">
                		<td style="width: 50px;"><input type="checkbox" name="productCheck" id="productCheck${vo.idx}" value="${vo.idx}" /></td>
                    <td style="width: 90px;"><img src="${ctp}/product/${vo.thumbnail}" width="80px" height="90px"/></td>
                    <td style="width: 110px;">${vo.productCode}</td>
                    <td style="word-break: break-all; width: 240px;">${vo.productName}</td>
                    <td style="word-break: break-all; width: 110px;">${vo.mainName}</td>
                    <td style="word-break: break-all; width: 110px;">${vo.baseName}</td>
                    <td style="word-break: break-all; width: 110px;">${vo.subName}</td>
                    <td style="width: 110px;"><fmt:formatNumber value="${vo.price}" pattern="#,##0"/>원</td>
                    <td style="width: 70px;">${vo.discount}%</td>
                    <td style="width: 110px;"><fmt:formatNumber value="${vo.pay}" pattern="#,##0"/>원</td>
                    <td style="width: 100px;">${fn:substring(vo.wDate,0,10)}</td>
                    <td style="width: 60px;">${vo.status}</td>
                    <td style="width: 60px;">${vo.display}</td>
                    <td style="width: 90px;">
	                    <div style="padding-bottom: 10px;"><a href="${ctp}/shop/productUpdate?idx=${vo.idx}" class="btn-edit">수정</a></div>
	                    <div><a href="javascript:productDelete(${vo.idx})" class="btn-delete">삭제</a></div>
                    </td>
                </tr>
              </c:forEach>
        </table>
        
        <div class="text-center" style="margin-top: 20px;">
  <ul class="pagination justify-content-center">
	  <c:if test="${pag > 1}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/productList?pageSize=${pageSize}&pag=1">첫페이지</a></li></c:if>
	  <c:if test="${curBlock > 0}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/productList?pageSize=${pageSize}&pag=${(curBlock-1)*blockSize + 1}">이전블록</a></li></c:if>
	  <c:forEach var="i" begin="${(curBlock*blockSize)+1}" end="${(curBlock*blockSize) + blockSize}" varStatus="st">
	    <c:if test="${i <= totPage && i == pag}"><li class="page-item active"><a class="page-link bg-secondary border-secondary" href="${ctp}/admin/productList?pageSize=${pageSize}&pag=${i}">${i}</a></li></c:if>
	    <c:if test="${i <= totPage && i != pag}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/productList?pageSize=${pageSize}&pag=${i}">${i}</a></li></c:if>
	  </c:forEach>
	  <c:if test="${curBlock < lastBlock}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/productList?pageSize=${pageSize}&pag=${(curBlock+1)*blockSize+1}">다음블록</a></li></c:if>
	  <c:if test="${pag < totPage}"><li class="page-item"><a class="page-link text-secondary" href="${ctp}/admin/productList?pageSize=${pageSize}&pag=${totPage}">마지막페이지</a></li></c:if>
  </ul>
</div>
	</div>
</body>
</html>