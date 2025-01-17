<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="${ctp}/main/favicon.png">
	<title>상품등록 | LUMI</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<jsp:include page="/WEB-INF/views/include/fonts.jsp" />
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

		/* 이미지 업로드 박스 스타일 */
    .image-upload-container {
      display: flex;
      justify-content: center;
      align-items: center;
      width: 100%;
      height: 200px;
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
    

		/* 색상 변수 */
		:root {
		  --bg: #fff;
		  --text: #382b22;
	    --light-pink: #e4dfcb; 
		  --pink: #8a7c66;       
		  --dark-pink: #6e5f4f;  
		  --pink-border: #8a7c66;
		  --pink-shadow: #b8b094;
		}
		
		button {
		  position: relative;
		  display: inline-block;
		  cursor: pointer;
		  outline: none;
		  border: 0;
		  vertical-align: middle;
		  text-decoration: none;
		  font-size: inherit;
		  font-family: inherit;
		}
		
		button.learn-more {
		  font-weight: 600;
		  color: var(--text);
		  width: 100%;
		  text-transform: uppercase;
		  padding: 1.25em 2em;
		  background: var(--light-pink);
		  border: 2px solid var(--pink-border);
		  border-radius: 0.75em;
		  transform-style: preserve-3d;
		  transition: transform 150ms cubic-bezier(0, 0, 0.58, 1), background 150ms cubic-bezier(0, 0, 0.58, 1);
		}
		
		button.learn-more::before {
		  position: absolute;
		  content: '';
		  width: 100%;
		  height: 100%;
		  top: 0;
		  left: 0;
		  right: 0;
		  bottom: 0;
		  background: var(--dark-pink);
		  border-radius: inherit;
		  box-shadow: 0 0 0 2px var(--pink-border), 0 0.625em 0 0 var(--pink-shadow);
		  transform: translate3d(0, 0.75em, -1em);
		  transition: transform 150ms cubic-bezier(0, 0, 0.58, 1), box-shadow 150ms cubic-bezier(0, 0, 0.58, 1);
		}
		
		button.learn-more:hover {
		  transform: translate(0, 0.25em);
		}
		
		button.learn-more:hover::before {
		  box-shadow: 0 0 0 2px var(--pink-border), 0 0.5em 0 0 var(--pink-shadow);
		  transform: translate3d(0, 0.5em, -1em);
		}
		
		button.learn-more:active {
		  background: var(--light-pink);
		  transform: translate(0em, 0.75em);
		}
		
		button.learn-more:active::before {
		  box-shadow: 0 0 0 2px var(--pink-border), 0 0 var(--pink-shadow);
		  transform: translate3d(0, 0, -1em);
		}
	</style>
  <script type="text/javascript">
  /* 
	  function fCheck() {
		    let titleImg = document.getElementById("image-upload-main").value;
		    let subImg = document.getElementById("image-upload-detail").value;
		    let thumbnail = document.getElementById("image-upload-thumbnail").value;
		    let titleImgExt = titleImg.substring(titleImg.lastIndexOf(".") + 1).toLowerCase();
		    let subImgExt = subImg.substring(subImg.lastIndexOf(".") + 1).toLowerCase();
		    let thumbnailExt = thumbnail.substring(thumbnail.lastIndexOf(".") + 1).toLowerCase();
		    let maxSize = 1024 * 1024 * 50;
		    let validExtensions = ['jpg', 'gif', 'png'];
				let title = document.getElementById("title").value;
				let category = document.getElementById("category").value;
				let pay = document.getElementById("pay").value;
				let discount = document.getElementById("discount").value;
		    
		    if (title.trim() == "") {
		        alert("제목을 입력해주세요");
		        myform.title.focus();
		        return false;
		    }
		    
		    if (category.trim() == "null") {
		        alert("카테고리를 선택해주세요");
		        myform.category.focus();
		        return false;
		    }
		    if (pay.trim() == "") {
		        alert("판매가격을 입력해주세요");
		        myform.pay.focus();
		        return false;
		    }
		    
		    if (discount.trim() == "") {
		        alert("할인율(금액)을 입력해주세요");
		        myform.discount.focus();
		        return false;
		    }
		    
		    if (titleImg.trim() === "" || subImg.trim() === "" || thumbnail.trim() === "") {
		        alert("업로드할 파일을 선택하세요");
		        myform.title.focus();
		        return false;
		    }

		    // 파일 크기 확인
		    let titleImgSize = document.getElementById("image-upload-main").files[0].size;
		    let subImgSize = document.getElementById("image-upload-detail").files[0].size;
		    let thumbnailSize = document.getElementById("image-upload-thumbnail").files[0].size;
		    if (titleImgSize > maxSize || subImgSize > maxSize || thumbnailSize > maxSize) {
		        alert("업로드할 1개 파일의 최대용량은 50MByte 입니다.");
		        myform.title.focus();
		        return false;
		    }

		    if (!validExtensions.includes(titleImgExt)) {
		        alert("대표 이미지 업로드 가능한 파일은 'jpg/gif/png'만 가능합니다.");
		        myform.title.focus();
		        return false;
		    }
		    if (!validExtensions.includes(subImgExt)) {
		        alert("상세 페이지 업로드 가능한 파일은 'jpg/gif/png'만 가능합니다.");
		        myform.title.focus();
		        return false;
		    }
		    if (!validExtensions.includes(thumbnailExt)) {
		        alert("썸네일 이미지 업로드 가능한 파일은 'jpg/gif/png'만 가능합니다.");
		        myform.title.focus();
		        return false;
		    }
		    myform.submit();
		}
	 */ 
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
			
				function finalPrice() {
				  const pay = Number(document.getElementById("pay").value); // 판매가
				  const discount = Number(document.getElementById("discount").value); // 할인 값

				  let price = pay;

				    // 할인율 계산
				    price = (pay - (pay * (discount / 100))).toFixed(0);

				  // 최종 판매가가 음수로 내려가지 않도록 처리
				  price = price < 0 ? 0 : price;

				  // 최종 판매가 필드 업데이트
				  document.getElementById("price").value = price;
				}
				
				function categoryBaseChange() {
					var categoryName = document.getElementById("mainCategory").value;
					
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
							$("#baseCategory").html(str);
						},
						error : function() {
							alert("전송오류");
						}
					});
				}
				
				function categorySubChange() {
			    	var mainCategory = myform.mainCategory.value;
			    	var baseCategory = myform.baseCategory.value;
						$.ajax({
							type : "post",
							url  : "${ctp}/shop/categorySub",
							data : {
								mainCategory : mainCategory,
								baseCategory : baseCategory
							},
							success:function(data) {
								var str = "";
								str += "<option value=''>소분류</option>";
								for(var i=0; i<data.length; i++) {
									str += "<option value='"+data[i].subName+"'>"+data[i].subName+"</option>";
								}
								$("#subCategory").html(str);
							},
							error : function() {
								alert("전송오류");
							}
						});
			  	}
  </script>
</head>
<body>
	<div id="productIput" class="productIput">
    <h1 style="font-family: 'EliceDigitalBaeum-Bd';">상품 등록</h1>
    <form name="myform" id="myform" enctype="multipart/form-data" method="post">
      
      <!-- 카테고리 -->
      <div class="form-group">
        <div class="section-title">카테고리</div>
        <div class="input-group" style="display: flex; gap: 20px;">
      		<!-- 대분류 -->
        	<div class="input-group" style="flex: 1;">
        		<input type="text" value="대분류" readonly class="form-control" style="text-align: center; flex: 2;">
        		<!-- <div class="input-group-text"><label for="mainCode">대분류</label></div> -->
        		<select class="form-control category-group" name="mainCategory" id="mainCategory" onchange="categoryBaseChange()" style="flex: 8;">
		          <option value="">대분류</option>
		          <c:forEach var="mainVO" items="${mainVos}">
		          	<option value="${mainVO.mainName}">${mainVO.mainName}</option>
		          </c:forEach>
        		</select>
        	</div>
      		<!-- 중분류 -->
        	<div class="input-group" style="flex: 1;">
        		<input type="text" value="중분류" readonly class="form-control" style="text-align: center; flex: 2;">
        		<select class="form-control category-group" name="baseCategory" id="baseCategory" onchange="categorySubChange()" style="flex: 8;">
		          <option value="">중분류</option>
        		</select>
        	</div>
      		<!-- 소분류 -->
        	<div class="input-group" style="flex: 1;">
        		<input type="text" value="소분류" readonly class="form-control" style="text-align: center; flex: 2;">
        		<select class="form-control category-group" name="subCategory" id="subCategory" style="flex: 8;">
		          <option value="">소분류</option>
        		</select>
        	</div>
        </div>
      </div>
      <hr>
      <!-- 상품명 -->
      <div class="form-group">
        <div class="section-title">상품명</div>
        <input type="text" name="company" id="company" class="form-control">
      </div>
      <hr>
      <!-- 판매가 -->
      <div class="form-group">
			  <div class="section-title">판매가</div>
			  <div class="input-group price-group" style="display: flex; gap: 20px;">
			    <!-- 판매가 (price)-->
			    <div class="input-group price-group" style="flex: 1;">
			      <input type="number" name="pay" id="pay" placeholder="판매가" class="form-control" oninput="finalPrice()" style="flex: 9;"/>
			      <input type="text" value="원" readonly class="form-control" style="text-align: center; flex: 1;">
			    </div>
			    <!-- 할인 (discount)-->
			    <div class="input-group price-group" style="flex: 1;">
			      <input type="number" name="discount" id="discount" placeholder="할인" class="form-control" oninput="finalPrice()" style="flex: 9;"/>
			      <input type="text" value="%" readonly class="form-control" style="text-align: center; flex: 1;">
			    </div>
			    <!-- 최종 판매가 (pay)-->
			    <div class="input-group price-group" style="flex: 1;">
			      <input type="number" name="price" id="price" placeholder="최종 판매가" readonly class="form-control" style="flex: 9;"/>
			      <input type="text" value="원" readonly class="form-control" style="text-align: center; flex: 1;">
			    </div>
			  </div>
			</div> 
			<hr> 
      <!-- 상품 이미지 -->
			<div class="form-group">
			  <div class="section-title">상품 이미지</div>
			  <hr>
			  <div>
			  <!-- 썸네일 이미지 -->
			  <div>
			    <div class="section-title">썸네일이미지</div>
			    <div class="image-upload-container">
			      <label for="image-upload-thumbnail" style="width: 100%; height: 100%; display: flex; justify-content: center; align-items: center;">
			        <div class="plus-icon" id="thumbnail"><i class="fa-solid fa-plus"></i></div>
			        <img id="image-preview-thumbnail" class="image-preview" style="display: none;" />
			      </label>
			      <input type="file" id="image-upload-thumbnail" name="thumbnail" accept="image/*" onchange="handleImageChange(event, 'image-preview-thumbnail')" />
			    </div>
			  </div>
			  <!-- 대표 이미지 -->
			  <div>
			    <div class="section-title">대표이미지</div>
			    <div class="image-upload-container">
			      <label for="image-upload-main" style="width: 100%; height: 100%; display: flex; justify-content: center; align-items: center;">
			        <div class="plus-icon" id="titleImg"><i class="fa-solid fa-plus"></i></div>
			        <img id="image-preview-main" class="image-preview" style="display: none;" />
			      </label>
			      <input type="file" id="image-upload-main" name="titleImg" accept="image/*" onchange="handleImageChange(event, 'image-preview-main')" />
			    </div>
			  </div>
				<hr>
			  <!-- 상세페이지 이미지 -->
			  <div>
			    <div class="section-title">상세페이지</div>
				    <div class="image-upload-container">
				      <label for="image-upload-detail" style="width: 100%; height: 100%; display: flex; justify-content: center; align-items: center;">
				        <div class="plus-icon" id="subImg"><i class="fa-solid fa-plus"></i></div>
				        <img id="image-preview-detail" class="image-preview" style="display: none;" />
				      </label>
				      <input type="file" id="image-upload-detail" name="subImg" accept="image/*" onchange="handleImageChange(event, 'image-preview-detail')" />
				    </div>
				  </div>
					<hr>
				</div>
			</div>
	    <!-- 제출 버튼 -->
	    <button class="learn-more" type="button" onclick="fCheck()">상품 등록</button>
	    <input type="hidden" name="fSize" id="fSize"/>
    </form>
  </div>
</body>
</html>