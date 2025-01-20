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
	<title>상품등록 | LUMI</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<jsp:include page="/WEB-INF/views/include/fonts.jsp" />
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
	<style type="text/css">
		body {
			font-family: Arial, sans-serif;
			background-color: #f4f7f6;
			color: #333;
			margin: 0;
			padding: 0;
		}
		#productIput {
			width: 77%;
			margin: 0 auto 3% auto;
			background-color: #fff;
			padding: 80px;
			box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
		}
		h1 {
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
		input[type="file"] {
			margin: 10px 0;
		}
		.hidden {
			display: none;
		}
		.file-upload div {
			margin-bottom: 15px;
		}
		.file-upload span {
			font-size: 16px;
			margin-right: 10px;
		}
		input[type="text"]{
			background-color: transparent !important;		
		}
		.price-group {
			display: flex;
			justify-content: space-between;
			align-items: center;
		}
		.price-group input[type="text"] {
			width: 80%;
		}
		.price-group input[type="text"]:focus {
			border-color: #3498db;
			box-shadow: 0 0 5px rgba(52, 152, 219, 0.5);
		}
		.sale-group {
			margin-top: 20px;
		}
		.sale-group label {
			margin-right: 15px;
			font-size: 16px;
		}
		
		hr {
			border: 1px solid #cfcccc;
		}

		.image-upload-row {
			display: flex;
			justify-content: space-between;
			gap: 20%;
		}
		.image-upload-column {
			flex: 1;
		}
		.image-upload-container {
			display: flex;
			justify-content: center;
			align-items: center;
			width: 100%;
			height: 400px;
			background-color: #f5f5f5;
			border-radius: 10px;
			border: 2px dashed #ccc;
			cursor: pointer;
			position: relative;
		}
		.image-upload-container input[type="file"] {
			display: none;
		}
		.image-upload-container .plus-icon {
			font-size: 36px;
			color: #8a7c66;
			font-weight: bold;
		}
		.image-preview {
			position: absolute;
			top: 50%;
			left: 50%;
			transform: translate(-50%, -50%);
			max-width: 100%;
			max-height: 100%;
			object-fit: contain;
			border-radius: 10px;
		}
		
		.blackLine-btn {
			background-color: #fff;
			color: #3D3B3B;
			border: 1px solid #333;
			border-radius: 5px;
			padding: 10px 20px;
			font-size: 25px;
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
		//이미지 선택 시 미리보기 처리 함수
		function handleImageChange(event, previewId) {
			const file = event.target.files[0];
			if (file) {
				const reader = new FileReader();
				reader.onload = function(e) {
					const imageUrl = e.target.result;
					const imagePreview = document.getElementById(previewId);
					imagePreview.src = imageUrl;
					imagePreview.style.display = 'block';
				};
				reader.readAsDataURL(file);
			}
		}
		
		function finalpay() {
			const price = Number(document.getElementById("price").value);
			const discount = Number(document.getElementById("discount").value);
			let pay = (price - (price * (discount / 100))).toFixed(0);
			document.getElementById("pay").value = Math.max(pay, 0);
		}
		
		function categoryBaseChange() {
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
		
		function categorySubChange() {
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
		
		CKEDITOR.replace('content');
		
		function fCheck() {
			let mainName = myform.mainName.value;
    	let baseName = myform.baseName.value;
    	let subName = myform.subName.value;
    	let productName = myform.productName.value;
			let price = myform.price.value;
			let discount = myform.discount.value;
			let file1 = myform.file1.value;	
			let file2 = myform.file2.value;	
			var content = CKEDITOR.instances.content.getData();
			let ext1 = file1.substring(file1.lastIndexOf(".")+1);
			let ext2 = file2.substring(file2.lastIndexOf(".")+1);
			let uExt1 = ext1.toUpperCase();
			let uExt2 = ext2.toUpperCase();
			let regExpPrice = /^[0-9|_]*$/;
			
			if(productName == "") {
				alert("상품명을 입력하세요");
				document.getElementById('productName').focus();
				return false;
			}
			else if(mainName == "") {
				alert("대분류를 입력하세요");
				document.getElementById('mainName').focus();
				return false;
			}
			else if(baseName == "") {
				alert("중분류를 입력하세요");
				document.getElementById('baseName').focus();
				return false;
			}
			else if(subName == "") {
				alert("소분류를 입력하세요");
				document.getElementById('baseName').focus();
				return false;
			}
			else if(price == "") {
				alert("상금액을 입력하세요");
				document.getElementById('price').focus();
				return false;
			}
			else if(discount == "") {
				alert("할인율(%)를 입력하세요");
				document.getElementById('discount').focus();
				return false;
			}
			else if(file1 == "") {
				alert("썸네일 이미지를 등록하세요");
				return false;
			}
			else if(file2 == "") {
				alert("대표 이미지를 등록하세요");
				return false;
			}
			else if(!content || content.trim() == '') {
				alert("상세페이지의 내용을 입력하세요");
				return false;
			}
			else if(uExt1 != "JPG" && uExt1 != "GIF" && uExt1 != "PNG" && uExt1 != "JPEG") {
				alert("업로드 가능한 파일이 아닙니다.");
				return false;
			}
			else if(uExt2 != "JPG" && uExt2 != "GIF" && uExt2 != "PNG" && uExt2 != "JPEG") {
				alert("업로드 가능한 파일이 아닙니다.");
				return false;
			}
			else if(price == "" || !regExpPrice.test(price)) {
				alert("상품금액은 숫자로 입력하세요.");
				return false;
			}
			else if(file1 != "" && file2 != "") {
				var maxSize = 1024 * 1024 * 10;  // 10MByte까지 허용
				var thumbnailFileSize = myform.file1.files[0].size;
				var titleImgFileSize = myform.file2.files[0].size;
				if(thumbnailFileSize > maxSize) {
					alert("첨부파일의 크기는 10MB 이내로 등록하세요");
					return false;
				}
				else if(titleImgFileSize > maxSize) {
					alert("첨부파일의 크기는 10MB 이내로 등록하세요");
					return false;
				}
				else {
					myform.submit();
				}
			}
		}
	</script>
</head>
<body>
	<form id="myform" method="post" enctype="multipart/form-data">
		<div id="productIput">
			<h1>상품 수정</h1>
			
			<!-- 상품명 -->
			<div class="form-group">
				<label for="productName" class="section-title">상품명</label>
				<input type="text" class="form-control" value="${vo.productName}" id="productName" name="productName" required>
			</div>
			<hr>
			<!-- 카테고리  -->
			<div class="form-group">
				<div class="section-title">카테고리</div>
				<div class="input-group" style="display: flex; gap: 20px;">
					<!-- 대분류 -->
					<div class="input-group" style="flex: 1;">
						<input type="text" value="대분류" disabled class="form-control" style="text-align: center; flex: 2;">
						<select id="mainName" name="mainName" class="form-select" onchange="categoryBaseChange()" style="flex: 8;" required>
							<option value="">대분류</option>
							<c:forEach var="mainVO" items="${mainVos}">
								<option value="${mainVO.mainName}"<c:if test="${mainVO.mainName eq vo.mainName}">selected</c:if>>${mainVO.mainName}</option>
							</c:forEach>
						</select>
					</div>
					<!-- 중분류 -->
					<div class="input-group" style="flex: 1;">
						<input type="text" value="중분류" disabled class="form-control" style="text-align: center; flex: 2;">
						<select id="baseName" name="baseName" class="form-select" onchange="categorySubChange()" style="flex: 8;" required>
							<option value="">중분류</option>
							<c:forEach var="baseVO" items="${baseVos}">
								<option value="${baseVO.baseName}"<c:if test="${baseVO.baseName eq vo.baseName}">selected</c:if>>${baseVO.baseName}</option>
							</c:forEach>
						</select>
					</div>
					<!-- 소분류 -->
					<div class="input-group" style="flex: 1;">
						<input type="text" value="소분류" disabled class="form-control" style="text-align: center; flex: 2;">
						<select id="subName" name="subName" class="form-select" style="flex: 8;" required>
							<option value="">소분류</option>
							<c:forEach var="subVO" items="${subVos}">
								<option value="${subVO.subName}"<c:if test="${subVO.subName eq vo.subName}">selected</c:if>>${subVO.subName}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>
			<hr>
			
			<!-- 판매가 -->
			<div class="form-group">
				<div class="section-title">판매가</div>
				<div class="input-group price-group" style="display: flex; gap: 20px;">
					<!-- 판매가 (price)-->
					<div class="input-group price-group" style="flex: 1;">
						<input type="text" class="form-control" id="price" name="price" value="${vo.price}" placeholder="판매가" oninput="finalpay()" style="flex: 9;" required>
						<input type="text" value="원" disabled class="form-control" style="text-align: center; flex: 1;">
					</div>
					<!-- 할인 (discount)-->
					<div class="input-group price-group" style="flex: 1;">
						<input type="text" class="form-control" id="discount" name="discount" value="${vo.discount}" placeholder="할인율" oninput="finalpay()" style="flex: 9;" required>
						<input type="text" value="%" disabled class="form-control" style="text-align: center; flex: 1;">
					</div>
					<!-- 최종 판매가 (pay)-->
					<div class="input-group price-group" style="flex: 1;">
						<input type="text" class="form-control" id="pay" name="pay" value="${vo.pay}" placeholder="최종 판매가" style="flex: 9;" readonly>
						<input type="text" value="원" disabled class="form-control" style="text-align: center; flex: 1;">
					</div>
				</div>
			</div>
			<hr>
			
			<!-- 상품 이미지 -->
			<div class="form-group">
				<label class="section-title mb-2">상품 이미지</label>
				<div class="image-upload-row">
					<div class="image-upload-column">
						<div class="section-title" style="font-size: 17px; color: gray; margin-top: 10px;">썸네일이미지</div>
						<label for="file1" class="image-upload-container">
							<img id="preview1" src="${ctp}/product/${vo.thumbnail}" class="image-preview">
							<div class="plus-icon"><i class="fa-solid fa-plus"></i></div>
							<input type="file" name="file1" id="file1" value="${vo.thumbnail}" onchange="handleImageChange(event, 'preview1')">
						</label>
					</div>
					<div class="image-upload-column">
						<div class="section-title" style="font-size: 17px; color: gray; margin-top: 10px;">대표이미지</div>
						<label for="file2" class="image-upload-container">
							<img id="preview2" src="${ctp}/product/${vo.titleImg}" class="image-preview">
							<div class="plus-icon"><i class="fa-solid fa-plus"></i></div>
							<input type="file" name="file2" id="file2" value="${ctp}/product/${vo.titleImg}" onchange="handleImageChange(event, 'preview2')">
						</label>
					</div>
				</div>
			</div>
			<hr>
			<div class="form-group">
				<label for="content" class="section-title mb-2">상세설명</label>
				<textarea id="content" name="content" rows="5" class="form-control" required>${vo.content}</textarea>
				<script>
				 		CKEDITOR.replace("content",{
				    	uploadUrl:"${ctp}/imageUpload",
				    	filebrowserUploadUrl: "${ctp}/imageUpload",
				    	height:460
				    });
				</script>
			</div>
			<hr>
			<div class="form-group">
		    <label class="section-title">판매 상태</label>
		    <div class="radio-group" style="display: flex; align-items: center; gap: 20px; font-size:16px; margin-top: 10px;">
	        <div class="form-check">
	          <input type="radio" id="statusOK" name="status" value="OK" class="form-check-input" ${vo.status == 'OK' ? 'checked' : ''}>
	          <label for="statusOK" class="form-check-label">판매중</label>
	        </div>
	        <div class="form-check">
	          <input type="radio" id="statusSoldOut" name="status" value="Sold Out" class="form-check-input" ${vo.status == 'Sold Out' ? 'checked' : ''}>
	          <label for="statusSoldOut" class="form-check-label">품절</label>
	        </div>
		    </div>
			</div>
			<hr>
			<div class="form-group">
		    <label class="section-title">진열 상태</label>
  			<div class="form-group" style="display: flex; align-items: center; gap: 10px; font-size:16px; margin-top: 10px;">
	    		<span>OFF</span>
		    	<span class="form-check form-switch">
        		<input class="form-check-input" type="checkbox" id="displayON" name="display" value="ON" ${vo.display == 'ON' ? 'checked' : ''}>
          	<label for="displayON" class="form-check-label">ON</label>
        	</span>
	    	</div>
			</div>
			<hr>
			<button type="button" class="blackLine-btn" onclick="fCheck()">상품 수정</button>
		</div>
	</form>
</body>
</html>
