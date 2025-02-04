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
	<title>이벤트등록 | LUMI</title>
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
		#eventInput {
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
		
		
		CKEDITOR.replace('content');
		
		function fCheck() {
			let title = myform.title.value;
    	let subTitle = myform.subTitle.value;
    	let startDate = myform.startDate.value;
    	let endDate = myform.endDate.value;
			let couponCode = myform.couponCode.value;
			let file1 = myform.file1.value;	
			var content = CKEDITOR.instances.content.getData();
			let ext1 = file1.substring(file1.lastIndexOf(".")+1);
			let uExt1 = ext1.toUpperCase();
			
			if(title == "") {
				alert("제목을 입력하세요");
				document.getElementById('title').focus();
				return false;
			}
			else if(subTitle == "") {
				alert("부제목를 입력하세요");
				document.getElementById('subTitle').focus();
				return false;
			}
			else if(startDate == "") {
				alert("시작일을 입력하세요");
				document.getElementById('startDate').focus();
				return false;
			}
			else if(endDate == "") {
				alert("만료일을 입력하세요");
				document.getElementById('endDate').focus();
				return false;
			}
			else if(couponCode == "") {
				alert("쿠폰코드를 입력하세요");
				document.getElementById('couponCode').focus();
				return false;
			}
			else if(file1 == "") {
				alert("썸네일 이미지를 등록하세요");
				return false;
			}
			else if(!content || content.trim() == '') {
				alert("이벤트의 내용을 입력하세요");
				return false;
			}
			else if(uExt1 != "JPG" && uExt1 != "GIF" && uExt1 != "PNG" && uExt1 != "JPEG") {
				alert("업로드 가능한 파일이 아닙니다.");
				return false;
			}
			else if(file1 != "") {
				var maxSize = 1024 * 1024 * 10;  // 10MByte까지 허용
				var thumbnailFileSize = myform.file1.files[0].size;
				if(thumbnailFileSize > maxSize) {
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
		<div id="eventInput">
			<h1>이벤트 등록</h1>
			
			<div class="form-group">
				<label for="title" class="section-title">제목</label>
				<input type="text" class="form-control" id="title" name="title" required>
			</div>
			<hr>
			<div class="form-group">
				<label for="subTitle" class="section-title">부제목</label>
				<input type="text" class="form-control" id="subTitle" name="subTitle" required>
			</div>
			<hr>
			
			<div class="form-group">
				<div class="section-title">기간</div>
				<div class="input-group price-group" style="display: flex; gap: 20px;">
					<div class="input-group price-group" style="flex: 1;">
						<input type="text" value="시작일" disabled class="form-control" style="text-align: center; flex: 2;">
						<input type="datetime-local" class="form-control" id="startDate" name="startDate" style="flex: 8;" required>
					</div>
					<div class="input-group price-group" style="flex: 1;">
						<input type="text" value="만료일" disabled class="form-control" style="text-align: center; flex: 2;">
						<input type="datetime-local" class="form-control" id="endDate" name="endDate" style="flex: 8;" required>
					</div>
				</div>
			</div>
			<hr>
			
			<div class="form-group">
				<label for="subTitle" class="section-title">쿠폰코드</label>
				<input type="text" class="form-control" id="couponCode" name="couponCode" required>
			</div>
			<hr>
			
			<div class="form-group">
				<label class="section-title mb-2">이미지</label>
				<div class="image-upload-row">
					<div class="image-upload-column">
						<div class="section-title" style="font-size: 17px; color: gray; margin-top: 10px;">썸네일이미지</div>
						<label for="file1" class="image-upload-container">
							<img id="preview1" class="image-preview" style="display:none;">
							<div class="plus-icon"><i class="fa-solid fa-plus"></i></div>
							<input type="file" name="file1" id="file1" onchange="handleImageChange(event, 'preview1')">
						</label>
					</div>
				</div>
			</div>
			<hr>
			<div class="form-group">
				<label for="content" class="section-title mb-2">상세설명</label>
				<textarea id="content" name="content" rows="5" class="form-control" required></textarea>
				<script>
				 		CKEDITOR.replace("content",{
				    	uploadUrl:"${ctp}/imageUpload",
				    	filebrowserUploadUrl: "${ctp}/imageUpload",
				    	height:460
				    });
				</script>
			</div>
			<hr>
			<button type="button" class="blackLine-btn" onclick="fCheck()">이벤트 등록</button>
			<input type="hidden" name="active" value="OFF"/>
		</div>
	</form>
</body>
</html>
