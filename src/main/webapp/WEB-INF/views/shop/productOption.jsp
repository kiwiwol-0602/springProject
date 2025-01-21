<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="${ctp}/main/favicon.png">
	<title>상품옵션등록 | LUMI</title>
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
		#productOption {
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
		.section-title {
			margin-top: 30px; 
			font-size: 18px;
			font-weight: bold;
			color: #2c3e50;
		}
		.optionDeleteA{
			text-decoration: none;
			font-size: 15px;
			color: gray;
			padding-top: 10px;
		}
		.optionDeleteA:hover{
			text-decoration: none;
			color: black;
		}
		
		
		.form-group {
			margin-bottom: 30px;
		}
		.form-control {
			width: 100%;
			padding: 10px;
			margin: 10px 0;
			border: 1px solid #ccc;
			border-radius: 5px;
			font-size: 16px;
		}
		.form-select {
			width: 100%;
			padding: 10px;
			margin: 10px 0;
			border: 1px solid #ccc;
			border-radius: 5px;
			font-size: 16px;
			height: 46px;
		}
		
		.blackLine-btn {
			background-color: #fff;
			color: #3D3B3B;
			border: 1px solid #333;
			border-radius: 5px;
			padding: 7px 20px;
			font-size: 15px;
			font-weight: 400;
			cursor: pointer;
			transition: all 0.3s ease;
			width: 300px;;
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
		.table {
			border-bottom-color: white;
			color: gray;
		}
		th {
      text-align: center;
      background-color: #eee;
    }
    .btn-gray {
		    background-color: gray;
		    color: white;
		    padding: 5px 10px;
		    text-decoration: none;
		    border-radius: 0px;
		}
		
		
	</style>
	  <script>
  	'use strict';
    let cnt = 1;
    
    
    // 옵션항목 추가
    function addOption() {
    	let strOption = "";
    	let test = "t" + cnt; 
    	
    	strOption += '<div id="'+test+'"><hr size="5px"/>';
    	strOption += '<font size="4"><b>상품옵션등록</b></font>&nbsp;&nbsp;';
    	strOption += '<input type="button" value="옵션삭제" class="btn btn-outline-danger btn-sm" onclick="removeOption('+test+')"/><br/>'
    	strOption += '상품옵션이름';
    	strOption += '<input type="text" name="optionName" id="optionName'+cnt+'" class="form-control"/>';
    	strOption += '<div class="form-group">';
    	strOption += '상품옵션가격';
    	strOption += '<input type="text" name="price" id="price'+cnt+'" class="form-control"/>';
    	strOption += '</div>';
    	strOption += '</div>';
    	$("#optionType").append(strOption);
    	cnt++;
    }
    
    // 옵션항목 삭제
    function removeOption(test) {
    	$("#"+test.id).remove();
    }
    
    // 옵션 입력후 등록전송
    function fCheck() {
    	for(let i=1; i<=cnt; i++) {
    		if($("#t"+i).length != 0 && document.getElementById("optionName"+i).value=="") {
    			alert("빈칸 없이 상품 옵션명을 모두 등록하셔야 합니다");
    			return false;
    		}
    		else if($("#t"+i).length != 0 && document.getElementById("price"+i).value=="") {
    			alert("빈칸 없이 상품 옵션가격을 모두 등록하셔야 합니다");
    			return false;
    		}
    	}
    	if(document.getElementById("optionName").value=="") {
    		alert("상품 옵션이름을 등록하세요");
    		return false;
    	}
    	else if(document.getElementById("price").value=="") {
    		alert("상품 옵션가격을 등록하세요");
    		return false;
    	}
    	else if(document.getElementById("productName").value=="") {
    		alert("상품명을 선택하세요");
    		return false;
    	}
    	else {
    		myform.submit();
    	}
    }
    
    function categoryMainChange() {
		var mainName = document.getElementById("mainName").value;
		$.ajax({
			type: "post",
			url: "${ctp}/shop/categoryBase",
			data: { mainName: mainName },
			success: function(data) {
				var strSub = "<option value=''>소분류</option>";
				var strBase = "<option value=''>중분류</option>";
				data.forEach(function(item) {
					strBase += "<option value='" + item.baseName + "'>" + item.baseName + "</option>";
				});
				$("#baseName").html(strBase);
				$("#subName").html(strSub);
			},
			error: function() {
				alert("전송오류");
			}
		});
	}
	
	function categoryBaseChange() {
		var mainName = myform.mainName.value;
		var baseName = myform.baseName.value;
		$.ajax({
			type: "post",
			url: "${ctp}/shop/categorySub",
			data: {
				mainName: mainName,
				baseName: baseName
			},
			success: function(data) {
				var str = "<option value=''>소분류</option>";
				data.forEach(function(item) {
					str += "<option value='" + item.subName + "'>" + item.subName + "</option>";
				});
				$("#subName").html(str);
			},
			error: function() {
				alert("전송오류");
			}
		});
	}
    
    // 상품 입력창에서 소분류 선택(Change)시 해당 상품들을 가져와서 품목 선택박스에 뿌리기
    function categorySubChange() {
    	var mainName = myform.mainName.value;
    	var baseName = myform.baseName.value;
    	var subName = myform.subName.value;
			$.ajax({
				type : "post",
				url  : "${ctp}/shop/categoryProductName",
				data : {
					mainName : mainName,
					baseName : baseName,
					subName : subName
				},
				success:function(data) {
					var str = "";
					str += "<option value=''>상품선택</option>";
					for(var i=0; i<data.length; i++) {
						str += "<option value='"+data[i].productName+"'>"+data[i].productName+"</option>";
					}
					$("#productName").html(str);
				},
				error : function() {
					alert("전송오류!");
				}
			});
  	}
    
    // 상품리스트 상세보기에서 옵션등록 버튼클릭시 수행하는 부분....
    <c:if test="${!empty productVO}">productNameCheck('${productVO.productName}')</c:if>
    
    // 상품명을 선택하면 상품의 설명을 띄워준다.
    function productNameCheck(productName) {
    	if(productName == "") productName = document.getElementById("productName").value;
    	
    	$.ajax({
    		type:"post",
    		url : "${ctp}/shop/productInfor",
    		data: {productName : productName},
    		success:function(vo) {
    			let str = '<br/>';
    			str += '<table class="table">';
    			str += '<tr><th>대분류명</th><td>'+vo.mainName+'</td>';
    			str += '<td rowspan="6" class="text-center"><img src="${ctp}/product/'+vo.thumbnail+'" width="250px"/></td></tr>';
    			str += '<tr><th>중분류명</th><td>'+vo.baseName+'</td></tr>';
    			str += '<tr><th>소분류명</th><td>'+vo.subName+'</td></tr>';
    			str += '<tr><th>상 품 명</th><td>'+vo.productName+'</td></tr>';
    			str += '<tr><th>상품가격</th><td>'+numberWithCommas(vo.price)+'원</td></tr>';
    			str += '<tr><th>판매가격</th><td>'+numberWithCommas(vo.pay)+'원</td></tr>';
    			str += '<tr><td colspan="3" class="text-center"><input type="button" value="등록된 옵션" onclick="optoinShow('+vo.idx+')" class="blackLine-btn"/></td></tr>';
    			str += '</table>';
    			str += '<hr/>';
    			str += '<div id="optionDemo"></div>';
    			$("#demo").html(str);
    			document.myform.productIdx.value = vo.idx;
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 옵션상세내역보기
    function optoinShow(productIdx) {
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/shop/optionList",
    		data : {productIdx : productIdx},
    		success:function(vos) {
    			let str = '';
    			if(vos.length != 0) {
						str = '<div class="section-title" style="margin-bottom:5px;">등록된 옵션</div>  ';
	    			for(let i=0; i<vos.length; i++) {
	    				str += '&nbsp;&nbsp;<a href="javascript:optionDelete('+vos[i].idx+')" class="optionDeleteA">';
							str += vos[i].optionName + "</a>&nbsp;&nbsp;";
	    			}
    			}
    			else {
    				str = "<div class='text-center'><font color='#A31D1D'>상품에 등록된 옵션이 없습니다.</font></div>";
    			}
					$("#optionDemo").html(str);
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 옵션항목 삭제하기
    function optionDelete(idx) {
    	let ans = confirm("선택한 옵션을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		type : "post",
    		url  : "${ctp}/shop/optionDelete",
    		data : {idx : idx},
    		success:function() {
    			alert("삭제되었습니다.");
    			location.reload();
    		},
    		error : function() {
    			alert("전송오류!");
    		}
    	});
    }
    
    // 콤마찍기
    function numberWithCommas(x) {
		  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
  </script>
</head>
<body>
<p><br/></p>
<div class="container" id="productOption">
  <h2>상품 옵션 등록</h2>
  <form name="myform" method="post">
  	<!-- 카테고리  -->
			<div class="form-group">
				<div class="section-title">카테고리</div>
				<div class="input-group" style="display: flex; gap: 20px;">
					<!-- 대분류 -->
					<div class="input-group" style="flex: 1;">
						<input type="text" value="대분류" disabled class="form-control" style="text-align: center; flex: 2; background-color: transparent;">
						<select id="mainName" name="mainName" class="form-select" onchange="categoryMainChange()" style="flex: 8;" required>
							<option value="">대분류</option>
							<c:forEach var="mainVO" items="${mainVos}">
								<option value="${mainVO.mainName}">${mainVO.mainName}</option>
							</c:forEach>
							 <c:if test="${!empty productVO}"><option value="${productVO.mainName}" selected>${productVO.mainName}</option></c:if>
						</select>
					</div>
					<!-- 중분류 -->
					<div class="input-group" style="flex: 1;">
						<input type="text" value="중분류" disabled class="form-control" style="text-align: center; flex: 2; background-color: transparent;">
						<select id="baseName" name="baseName" class="form-select" onchange="categoryBaseChange()" style="flex: 8;" required>
							<option value="">중분류</option>
							<c:if test="${!empty productVO}"><option value="${productVO.baseName}" selected>${productVO.baseName}</option></c:if>
						</select>
					</div>
					<!-- 소분류 -->
					<div class="input-group" style="flex: 1;">
						<input type="text" value="소분류" disabled class="form-control" style="text-align: center; flex: 2; background-color: transparent;">
						<select id="subName" name="subName" class="form-select" onchange="categorySubChange()" style="flex: 8;" required>
							<option value="">소분류</option>
							<c:if test="${!empty productVO}"><option value="${productVO.subName}" selected>${productVO.subName}</option></c:if>
						</select>
					</div>
				</div>
			</div>
			<hr>
  
    <div class="form-group">
      <label for="productName" class="section-title">상품명(모델명)</label>
      <!-- <select name="productName" id="productName" class="form-control" onchange="productNameCheck('')"> -->
      <select name="productCode" id="productName" class="form-select" onchange="productNameCheck('')">
        <option value="">상품선택</option>
        <c:if test="${!empty productVO}"><option value="${productVO.productName}" selected>${productVO.productName}</option></c:if>
        <%-- <c:if test="${!empty productVO}"><option value="${productVO.productName}" selected>${productVO.productName}</option></c:if> --%>
      </select>
      <div id="demo"></div>
    </div>
    <hr/>
     <div style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
		    <font size="4"><b>상품옵션등록</b></font>
		    <input type="button" value="옵션추가" onclick="addOption()" class="addOption blackLine-btn" style="width: 120px; font-size: 12px; text-align:center;"/>
		</div>
		<br/>
    <div class="form-group">
      <label for="optionName">상품옵션이름</label>
      <input type="text" name="optionName" id="optionName" class="form-control"/>
    </div>
    <div class="form-group">
      <label for="price">상품옵션가격</label>
      <input type="text" name="price" id="price" class="form-control"/>
    </div>
    <div id="optionType"></div>
    <hr/>
    <div style="display: flex; justify-content: center;">
    	<input type="button" value="옵션등록" onclick="fCheck()" class="blackLine-btn" style="width: 600px; font-size: 20px; text-align:center; justify-content: center;"/>
    </div>
    <input type="hidden" name="productIdx">
  </form>
</div>
<p><br/></p>
</body>
</html>
