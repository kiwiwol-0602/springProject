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
			/* 기본적인 스타일링 */
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
				font-size : 18px;
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
		
		select.form-control {
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
		
		
		/* 가격 입력 부분 */
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
		
		/* 버튼 스타일 */
		button[type="submit"] {
				color: white;
				font-size: 18px;
				padding: 15px 30px;
				border: none;
				border-radius: 5px;
				width: 100%;
				cursor: pointer;
				transition: background-color 0.3s;
		}
		
		
		hr {
				border: 1px solid #cfcccc;
		}
		
		
		/* 라디오 버튼 */
		
		.wrap .radio_area label {
				cursor: pointer;
				display: flex;
				align-items: center;
				gap: 15px;
				height: 40px;
				padding: 0 18px 0 15px;
				font-size: 15px;
				font-weight: 500;
				color: #999;
				background: ;
				transition: all .2s;
				border: 1px solid #eee;
		}
		
		.wrap .radio_area label span {
				opacity: .3;
				display: flex;
				width: 18px;
				height: 18px;
				border: 2px solid #111;
				border-radius: 50%;
				transition: all .2s
		}
		
		.wrap .radio_area label span:before {
				content: "";
				width: 6px;
				height: 6px;
				margin: auto;
				border-radius: 50%;
				background: #111;
				transition: all .2s
		}
		
		.wrap .radio_area label:hover {
				background: #e1e1e1
		}
		
		.radio_area input[type=radio] {
				display: none
		}
		
		.radio_area input[type=radio]:checked+label {
				color: #fff;
				background: #8a7c66;
		}
		
		.radio_area input[type=radio]:checked+label span {
				opacity: 1;
				border-color: #fff
		}
		
		.radio_area input[type=radio]:checked+label span:before {
				background: #fff
		}
		.image-upload-row {
		  display: flex;
		  justify-content: space-between; /* 각 컨테이너 사이 간격 조절 */
		  gap: 20%; /* 여백 추가 */
		}
		
		.image-upload-column {
		  flex: 1; /* 컨테이너 너비 균등 분배 */
		}

		/* 이미지 업로드 박스 스타일 */
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

    /* 이미지 업로드 버튼을 클릭했을 때 플러스 아이콘 외에도 이미지 미리보기 */
    .image-upload-container img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      border-radius: 10px;
    }
    
		
		  /* 버튼 스타일 */
 .blackLine-btn {
  background-color: #fff; /* 버튼 배경을 흰색 */
  color: #3D3B3B; /* 글씨를 검정색으로 */
  border: 1px solid #333; /* 진회색 테두리 */
  border-radius: 5px; /* 네모 모양으로 */
  padding: 10px 20px; /* 적당한 패딩으로 크기 조정 */
  font-size: 25px;
  font-weight: 400;
  cursor: pointer;
  text-align: center;
  transition: all 0.3s ease;
  width: 100%;
}

.blackLine-btn:hover {
  background-color: #eee; /* hover 시 연한 회색 */
  border-color: #666; /* hover 시 테두리 색 변화 */
  transform: translateY(-2px); /* 약간 위로 이동 */
}

.blackLine-btn:active {
  background-color: #ccc; /* 클릭 시 배경이 조금 더 어두워짐 */
  border-color: #555; /* 클릭 시 테두리 색 */
  transform: translateY(0); /* 클릭 시 위치 복원 */
}

.blackLine-btn:focus {
  outline: none;
  box-shadow: 0 0 0 2px rgba(138, 124, 102, 0.7); /* 포커스 시 그림자 */
}
		
	</style>
  <script type="text/javascript">
  
	 
	 
			//이미지 선택 시 미리보기 처리 함수
			  function handleImageChange(event, previewId) {
			    const file = event.target.files[0]; // 파일 객체 얻기
			    if (file) {
			      const reader = new FileReader(); // FileReader 객체 생성
			      
			      // 파일이 읽히면 실행되는 콜백 함수
			      reader.onload = function(e) {
			        const imageUrl = e.target.result; // 이미지 URL 얻기
			        const imagePreview = document.getElementById(previewId); // 미리보기 이미지 요소
			        
			        imagePreview.src = imageUrl; // 이미지 URL을 src에 설정
			        imagePreview.style.display = 'block'; // 이미지를 표시
			      };
			      
			      // 파일을 Data URL 형식으로 읽어들임
			      reader.readAsDataURL(file);
			    }
			  }
			
				function finalpay() {
				  const price = Number(document.getElementById("price").value); // 판매가
				  const discount = Number(document.getElementById("discount").value); // 할인 값

				  let pay = price;

				    // 할인율 계산
				    pay = (price - (price * (discount / 100))).toFixed(0);

				  // 최종 판매가가 음수로 내려가지 않도록 처리
				  pay = pay < 0 ? 0 : pay;

				  // 최종 판매가 필드 업데이트
				  document.getElementById("pay").value = pay;
				}
				
				function categoryBaseChange() {
					var categoryName = document.getElementById("mainName").value;
					
					$.ajax({
						type : "post",
						url  : "${ctp}/shop/categoryBase",
						data : {categoryName : categoryName},
						success:function(data){
							var str = "";
							str += "<option value=''>중분류</option>";
							for(var i=0; i<data.length; i++) {
								str += "<option value='"+data[i].baseName+"'>"+data[i].baseName+"</option>";
							}
							$("#baseName").html(str);
						},
						error : function() {
							alert("전송오류");
						}
					});
				}
				
				function categorySubChange() {
			    	var mainName = myform.mainName.value;
			    	var baseName = myform.baseName.value;
						$.ajax({
							type : "post",
							url  : "${ctp}/shop/categorySub",
							data : {
								mainName : mainName,
								baseName : baseName
							},
							success:function(data) {
								var str = "";
								str += "<option value=''>소분류</option>";
								for(var i=0; i<data.length; i++) {
									str += "<option value='"+data[i].subName+"'>"+data[i].subName+"</option>";
								}
								$("#subName").html(str);
							},
							error : function() {
								alert("전송오류");
							}
						});
						
						
			  	}
				
				 function fCheck() {
					  let categoryMainName = myform.mainName.value;
			    	let categoryBaseName = myform.baseName.value;
			    	let categorySubName = myform.subName.value;
			    	let productName = myform.productName.value;
						let price = myform.price.value;
						let discount = myform.discount.value;
						let thumbnail = myform.thumbnail.value;	
						let titleImg = myform.titleImg.value;	
						let ext1 = thumbnail.substring(thumbnail.lastIndexOf(".")+1);
						let ext2 = titleImg.substring(titleImg.lastIndexOf(".")+1);
						let uExt1 = ext1.toUpperCase();
						let uExt2 = ext2.toUpperCase();
						let regExpPrice = /^[0-9|_]*$/;
						
						if(categoryMainName == "") {
							alert("상품 대분류를 입력하세요");
							return false;
						}
						else if(categoryBaseName == "") {
							alert("상품 중분류를 입력하세요");
							return false;
						}
						else if(categorySubName == "") {
							alert("상품 소분류를 입력하세요");
							return false;
						}
						else if(productName == "") {
							alert("상품명을 입력하세요");
							return false;
						}
						else if(thumbnail == "") {
							alert("상품 썸네일 이미지를 등록하세요");
							return false;
						}
						else if(titleImg == "") {
							alert("상품 대표 이미지를 등록하세요");
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
						else if(document.getElementById("thumbnail").value != "" && document.getElementById("titleImg").value != "") {
							var maxSize = 1024 * 1024 * 10;  // 10MByte까지 허용
							var thumbnailFileSize = myform.thumbnail.files[0].size;
							var titleImgFileSize = myform.titleImg.files[0].size;
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
	<div id="productIput" class="productIput">
    <h1 style="font-family: 'EliceDigitalBaeum-Bd';">상품 등록</h1>
    <form name="myform" id="myform" enctype="multipart/form-data" method="post" action="${ctp}/shop/productInput">
      
      <!-- 카테고리 -->
      <div class="form-group">
        <div class="section-title">카테고리</div>
        <div class="input-group" style="display: flex; gap: 20px;">
      		<!-- 대분류 -->
        	<div class="input-group" style="flex: 1;">
        		<input type="text" value="대분류" readonly class="form-control" style="text-align: center; flex: 2;">
        		<!-- <div class="input-group-text"><label for="mainCode">대분류</label></div> -->
        		<select class="form-control category-group" name="mainName" id="mainName" onchange="categoryBaseChange()" style="flex: 8;">
		          <option value="">대분류</option>
		          <c:forEach var="mainVO" items="${mainVos}">
		          	<option value="${mainVO.mainName}">${mainVO.mainName}</option>
		          </c:forEach>
        		</select>
        	</div>
      		<!-- 중분류 -->
        	<div class="input-group" style="flex: 1;">
        		<input type="text" value="중분류" readonly class="form-control" style="text-align: center; flex: 2;">
        		<select class="form-control category-group" name="baseName" id="baseName" onchange="categorySubChange()" style="flex: 8;">
		          <option value="">중분류</option>
        		</select>
        	</div>
      		<!-- 소분류 -->
        	<div class="input-group" style="flex: 1;">
        		<input type="text" value="소분류" readonly class="form-control" style="text-align: center; flex: 2;">
        		<select class="form-control category-group" name="subName" id="subName" style="flex: 8;">
		          <option value="">소분류</option>
        		</select>
        	</div>
        </div>
      </div>
      <hr>
      <!-- 상품명 -->
      <div class="form-group">
        <div class="section-title">상품명</div>
        <input type="text" name="productName" id="productName" class="form-control">
      </div>
      <hr>
      <!-- 판매가 -->
      <div class="form-group">
			  <div class="section-title">판매가</div>
			  <div class="input-group price-group" style="display: flex; gap: 20px;">
			    <!-- 판매가 (price)-->
			    <div class="input-group price-group" style="flex: 1;">
			      <input type="number" name="price" id="price" placeholder="판매가" class="form-control" oninput="finalpay()" style="flex: 9;"/>
			      <input type="text" value="원" readonly class="form-control" style="text-align: center; flex: 1;">
			    </div>
			    <!-- 할인 (discount)-->
			    <div class="input-group price-group" style="flex: 1;">
			      <input type="number" name="discount" id="discount" placeholder="할인" class="form-control" oninput="finalpay()" style="flex: 9;"/>
			      <input type="text" value="%" readonly class="form-control" style="text-align: center; flex: 1;">
			    </div>
			    <!-- 최종 판매가 (pay)-->
			    <div class="input-group price-group" style="flex: 1;">
			      <input type="number" name="pay" id="pay" placeholder="최종 판매가" readonly class="form-control" style="flex: 9;"/>
			      <input type="text" value="원" readonly class="form-control" style="text-align: center; flex: 1;">
			    </div>
			  </div>
			</div> 
			<hr> 
      <!-- 상품 이미지 -->
			<div class="form-group">
			  <div class="section-title mb-2">상품 이미지</div>
			  <div class="image-upload-row">
			    <div class="image-upload-column">
			      <div class="section-title" style="font-size: 17px; color: gray; margin-top: 10px;">썸네일이미지</div>
			      <div class="image-upload-container">
			        <label for="image-upload-thumbnail" style="width: 100%; height: 100%; display: flex; justify-content: center; align-items: center;">
			          <div class="plus-icon" id="thumbnail"><i class="fa-solid fa-plus"></i></div>
			          <img id="image-preview-thumbnail" class="image-preview" style="display: none;" />
			        </label>
			        <input type="file" id="image-upload-thumbnail" name="thumbnail" accept="image/*" onchange="handleImageChange(event, 'image-preview-thumbnail')" />
			      </div>
			    </div>
			    <div class="image-upload-column">
			      <div class="section-title" style="font-size: 17px; color: gray; margin-top: 10px;">대표이미지</div>
			      <div class="image-upload-container">
			        <label for="image-upload-main" style="width: 100%; height: 100%; display: flex; justify-content: center; align-items: center;">
			          <div class="plus-icon" id="titleImg"><i class="fa-solid fa-plus"></i></div>
			          <img id="image-preview-main" class="image-preview" style="display: none;" />
			        </label>
			        <input type="file" id="image-upload-main" name="titleImg" accept="image/*" onchange="handleImageChange(event, 'image-preview-main')" />
			      </div>
			    </div>
			  </div>
			</div>
			<hr>
		  <!-- 상세페이지 이미지 -->
			<div class="form-group">
		    <div class="section-title mb-2">상세페이지</div>
	    	<div>
	    	<textarea rows="5" name="content" id="CKEDITOR" class="form-control" required></textarea>
		    </div>
		    <script>
			    CKEDITOR.replace("content",{
			    	uploadUrl:"${ctp}/imageUpload",
			    	filebrowserUploadUrl: "${ctp}/imageUpload",
			    	height:460
			    });
		  </script>
		  </div>
			<hr>
	    <!-- 제출 버튼 -->
	    <button class="blackLine-btn" type="button" onclick="fCheck()">상품 등록</button>
	    <input type="hidden" name="fSize" id="fSize"/>
    </form>
  </div>
</body>
</html>