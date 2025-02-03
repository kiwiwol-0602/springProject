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
	<title>이벤트 | LUMI</title>
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
	    let checkboxes = document.querySelectorAll('input[name="eventCheck"]');
	    checkboxes.forEach(function(checkbox) {
	        checkbox.checked = !checkbox.checked;
	    });
		}
		
		function eventCheckedActiveChange(variable) {
			let idxSelectArray = '';
			
			let checkboxes = document.getElementsByName('eventCheck');
			if (checkboxes.length) {
		    for (let i = 0; i < checkboxes.length; i++) {
	        if (checkboxes[i].checked) {
            idxSelectArray += checkboxes[i].value + "/";
	        }
		    }
			}
			else {
		    if (checkboxes.checked) {
	        idxSelectArray += checkboxes.value + "/";
		    }
			}
			
    	idxSelectArray = idxSelectArray.substring(0,idxSelectArray.lastIndexOf("/"));
    	
    	let query = {
    			variable : variable,
    			idxSelectArray : idxSelectArray
    	}
    	alert(variable);
    	alert(idxSelectArray);
	    	
	    	
			$.ajax({
				type : "post",
				url  : "${ctp}/admin/eventActiveChange",
				data : query,
				success: function(res){
					if(res !="0"){
						alert('이벤트 상태가 변경되었습니다.');
						location.reload();
					}
					else{
						alert('이벤트 상태를 변경하던 중 오류가 발생했습니다.');
					}
				},
				error: function(){
					alert('전송오류');
				}
			});
		}
		
		function eventActiveChange(variable, idx) {
    	let query = {
    			variable : variable,
    			idx : idx
    	}
    	alert(variable);
    	alert(idx);
	    	
	    	
			$.ajax({
				type : "post",
				url  : "${ctp}/admin/eventActiveChange",
				data : query,
				success: function(res){
					if(res !="0"){
						alert('이벤트 상태가 변경되었습니다.');
						location.reload();
					}
					else{
						alert('이벤트 상태를 변경하던 중 오류가 발생했습니다.');
					}
				},
				error: function(){
					alert('전송오류');
				}
			});
		}
		
		function onCheck() {
      let minIdx = parseInt(document.getElementById("minIdx").value);
      let maxIdx = parseInt(document.getElementById("maxIdx").value);
      
      let emptyCnt=0;
      
      for(let i=minIdx;i<=maxIdx;i++){
        if($("#eventCheck"+i).length != 0 && document.getElementById("eventCheck"+i).checked==false){
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
    }
		
		function allCheck(){
    	let minIdx = parseInt(document.getElementById("minIdx").value);
      let maxIdx = parseInt(document.getElementById("maxIdx").value);
      if(document.getElementById("allcheck").checked){
        for(let i=minIdx;i<=maxIdx;i++){
          if($("#eventCheck"+i).length != 0){
            document.getElementById("eventCheck"+i).checked=true;
          }
        }
      }
      else {
        for(let i=minIdx;i<=maxIdx;i++){
          if($("#eventCheck"+i).length != 0){
            document.getElementById("eventCheck"+i).checked=false;
          }
        }
      }
    }
	</script>
</head>
<body>
<div class="couponListAdmin">
	<h2>이벤트 관리</h2>
	<!-- 쿠폰 리스트 테이블 -->
	<table style="width: 100%; margin-top: 40px;">
		<tr style="width: 100%;">
			<td class="left-align" style="justify-content: flex-start;">
			<a href="${ctp}/admin/eventInput" class="btn-edit" style="padding: 5px 20px;">이벤트등록</a>
			</td>
			<td class="right-align" style="justify-content: flex-end; text-align: right;">
			<a href="javascript:eventCheckedActiveChange('ON')" class="btn-gray" style="">이벤트상태 ON</a>
			<a href="javascript:eventCheckedActiveChange('OFF')" class="btn-gray" style="">이벤트상태 OFF</a>
			</td>
		</tr>
	</table>
	
	<form name="myform">
		<table class="couponList" id="couponList">
			<tr>
				<th><input type="checkbox" id="allcheck" onClick="allCheck()"/></th>
		    <th></th>
		    <th>제목</th>
		    <th>부제목</th>
		    <th>시작일</th>
		    <th>만료일</th>
		    <th>쿠폰코드</th>
		    <th>이벤트상태</th>
		    <th>관리</th>
			</tr>
			<c:forEach var="vo" items="${vos}" varStatus="st">
				<tr style="word-break: break-all;">
					<td style="width: 50px;"><input type="checkbox" name="eventCheck" id="eventCheck${vo.idx}" value="${vo.idx}" onClick="onCheck()"/></td>
				  <td style="width: 70px; margin: 0; padding: 10px 0"><img src="${ctp}/event/${vo.thumbnail}" alt="Thumbnail" class="default-img" width="150px;"></td>
				  <td style="word-break: break-all; width: 150px;">${vo.title}</td>
				  <td style="word-break: break-all; width: 200px;">${vo.subTitle}</td>
				  <td style="width: 70px;">${fn:substring(vo.startDate,0,10)}</td>
				  <td style="width: 70px;">${fn:substring(vo.endDate,0,10)}</td>
				  <td style="width: 100px;">${vo.couponCode}</td>
				  <td style="width: 50px;">${vo.active}</td>
				  <td style="width: 50px;">
				  	<c:if test="${vo.active eq 'ON'}">
				  		<a href="javascript:eventActiveChange('OFF',${vo.idx})" class="btn-gray" style="">OFF</a>
				  	</c:if>
				  	<c:if test="${!(vo.active eq 'ON')}">
				  		<a href="javascript:eventActiveChange('ON',${vo.idx})" class="btn-gray" style="">ON</a>
				  	</c:if>
			  	</td>
				</tr>
			</c:forEach>
		</table>
	</form>
	
	<c:set var="minIdx" value="${vos[0].idx}"/>						<!-- 구매한 첫번째 상품의 idx -->
  <c:set var="maxSize" value="${fn:length(vos)-1}"/>		
  <c:set var="maxIdx" value="${vos[maxSize].idx}"/>			<!-- 구매한 마지막 상품의 idx -->
  <input type="hidden" id="minIdx" name="minIdx" value="${minIdx}"/>
  <input type="hidden" id="maxIdx" name="maxIdx" value="${maxIdx}"/>
</div>
</body>
</html>