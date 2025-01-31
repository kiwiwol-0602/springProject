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
  <link rel="icon" href="${ctp}/main/favicon.png">
	<title>${vo.productName} | LUMI</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<jsp:include page="/WEB-INF/views/include/fonts.jsp" />
	<style type="text/css">
   body {
    font-family: 'Arial', sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f4f9;
  }
	#content-form {
		display: flex;
    flex-direction: row;
    max-width: 78%;
    margin: 3% auto;
    padding-top: 8%;
    gap: 30px;
	}
	
	/* 이미지 전환 효과 */
		.image-container {
		  position: relative; /* 이미지를 겹칠 컨테이너 설정 */
		  width: 100%;
		  height: 100%; /* 이미지 높이 */
		  overflow: hidden; /* 이미지가 영역을 넘지 않도록 설정 */
		}
		
		.image-container img {
		  width: 100%;
		  height: 100%;
		  object-fit: cover; /* 이미지를 컨테이너에 맞게 조정 */
		}
		
  /* 보조 이미지 */
  .sub-img {
    margin-top: 20px;
  }

  .sub-img img {
    width: 100%;
    border-radius: 8px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  }

  /* 포트폴리오 */
  .see-more {
    margin-top: 30px;
  }

  .grid-container {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 20px;
  }

  .grid-item {
    text-align: center;
  }

  .grid-item img {
    width: 100%;
    height: auto;
    border-radius: 8px;
  }
  
  		h6 {
			position: fixed;
			right: 1rem;
			bottom: -100px;
			transition: 0.7s ease;
		}
		h6.on {
			opacity: 0.8;
			cursor: pointer;
			bottom: 15px;
			z-index: 10;
		}
		
			
		
		.fixed-sidebar {
	    position: fixed;
	    top: 20%;
	    right: -120px;
	    width: 120px;
	    flex-direction: column;
	    align-items: center;
	    background: none;
	    z-index: 50;
	    gap: 20px;
	    opacity: 0;
	    transition: 0.5s ease-in-out;
		}
		
		.fixed-sidebar.on {
	    right: 10px;
	    opacity: 1;
		}
	
		
		.sidebar-item {
	    text-align: center;
	    cursor: pointer;
		}
		
		.icon-circle {
	    width: 60px;
	    height: 60px;
	    border-radius: 50%;
	    background-color: #ffffff;
	    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
	    display: flex;
	    align-items: center;
	    justify-content: center;
	    transition: transform 0.3s ease, box-shadow 0.3s ease;
	    margin-bottom: 20px;
		}
		
		.icon-circle i {
		    font-size: 25px;
		    color: #333;
		}
		
		.icon-circle:hover {
	    transform: scale(1.1);
	    box-shadow: 0px 6px 12px rgba(0, 0, 0, 0.3);
		}
		#productOption {
			border-radius: 0 !important;
			border: 1px solid black !important;
		}
	  #selectProductList {
	    border: 1px solid #ccc;
	    background-color: #f9f9f9;
	    padding: 20px;
	    border-radius: 0;
	    margin-top: 20px;
	    height: 100%;
	    max-height: 360px;
	  }

  /* 옵션 레이어 스타일 */
  .layer {
 		display: flex;
    align-items: center;
    background-color: #fff;
    border: 1px solid #ccc;
    align-items: center;
    padding: 10px;
    margin-bottom: 10px;
    border-radius: 0;
    box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
  }

  /* 옵션명 스타일 */
  .layer .col-4 {
  	width: 40%!important;
    font-weight: 400;
    margin-right: 10px;
    color: #333;
    white-space: nowrap;
    flex: 1;
  }

  /* 수량 입력 필드 스타일 */
  .numBox {
    width: 50px;
    height: 40px;
    padding: 5px;
    margin: 0 5px;
    text-align: center;
    border: 1px solid #ccc;
    border-radius: 0;
  }

  /* 가격 필드 스타일 */
  #selectProductList .price {
    width: 150px;
    height: 40px;
    padding: 5px;
    text-align: right;
    border: 1px solid #ddd;
    border-radius: 0;
    background-color: #f0f0f0;
  }

  /* 삭제 버튼 스타일 */
  .btn-outline-black {
  	width: 50px;
   	height: 40px; /* 수량 입력 필드와 동일한 높이 */
    line-height: 1; /* 텍스트가 가운데 정렬되도록 */
    border: 1px solid #0a0a0a;
    background-color: #0a0a0a;
    color: #fff;
    font-size: 12px;
    border-radius: 0;
    transition: background-color 0.3s ease;
    margin-bottom: 3px;
  }

  .btn-outline-black:hover {
    background-color: #fff;
    color: #0a0a0a;
    
  }
  .btn-black {
  	width: 90%;
   	height: 40px; /* 수량 입력 필드와 동일한 높이 */
    line-height: 1; /* 텍스트가 가운데 정렬되도록 */
    border: 1px solid #0a0a0a;
    background-color: #fff;
    color: #0a0a0a;
    font-size: 15px;
    border-radius: 0;
    transition: background-color 0.3s ease;
    margin-bottom: 3px;
  }

  .btn-black:hover {
    background-color: #0a0a0a;
    color: #fff;
    
  }
    .btn-outline-gray {
  	width: 30px;
   	height: 30px; /* 수량 입력 필드와 동일한 높이 */
    line-height: 15px; /* 텍스트가 가운데 정렬되도록 */
    border: 1px solid #ccc;
    background-color: #fff;
    color: #0a0a0a;
    font-size: 12px;
    border-radius: 0;
    transition: background-color 0.3s ease;
    margin-bottom: 3px;
  }

  .btn-outline-gray:hover {
    background-color: #fff;
    color: #0a0a0a;
    
  }

  /* 옵션 선택 박스 스타일 */
  #selectOption {
    width: 100%;
    padding: 10px;
    border: 1px solid black;
    border-radius: 0;
    background-color: transparent;
    margin-bottom: 20px;
  }

  /* 총 금액 필드 스타일 */
  #totalPriceResult, #totalPrice {
    font-size: 18px;
    font-weight: bold;
    color: #333;
    border: none;
    background-color: transparent;
    text-align: right;
  }
	</style>
	<script type="text/javascript">
	  function toggleLike(idx, btn) {
	    const icon = btn.querySelector('i');
	        $.ajax({
	        	type : "post",
	        	url : "interestCheck.fu",
	        	data : {idx : idx},
	        	success: function(res) {
							if(res == "1"){
								icon.classList.remove('fa-regular');
				        icon.classList.add('fa-solid');
							}
							else if(res == "2"){
				        icon.classList.remove('fa-solid');
				        icon.classList.add('fa-regular');
					    }
						},
						error: function() {
							alert("전송오류");
						}
        });
	  }
	  
		$(window).scroll(function(){
	  if($(this).scrollTop() > 100){
	     $("#topBtn").addClass("on");
	  }
	  else{
	     $("#topBtn").removeClass("on");
	  }
	  $("#topBtn").click(function() {
				window.scrollTo({top:0, behavior: "smooth"});	
			});
		});
		
			$(window).scroll(function(){
			  if($(this).scrollTop() > 300){
			     $("#mainSidebar").addClass("on");
			  }
			  else{
			     $("#mainSidebar").removeClass("on");
			  }
			});
		
			
			function showHoverImage(container) {
	  	  const defaultImg = container.querySelector('.default-img');
	  	  const hoverImg = container.querySelector('.hover-img');
	  	  
	  	  defaultImg.style.display = 'none'; // 기본 이미지 숨기기
	  	  hoverImg.style.display = 'block'; // Hover 이미지 표시
	  	}

	  	function showDefaultImage(container) {
	  	  const defaultImg = container.querySelector('.default-img');
	  	  const hoverImg = container.querySelector('.hover-img');
	  	  
	  	  defaultImg.style.display = 'block'; // 기본 이미지 표시
	  	  hoverImg.style.display = 'none'; // Hover 이미지 숨기기
	  	}
	  	
	  	 let idxArray = new Array();

	     // 옵션박스에서, 옵션항목을 선택하였을때 처리하는 함수(고유번호/옵션명/콤마붙인가격)을 화면에 출력시켜주고 있다.
	     $(function(){
	       $("#selectOption").change(function(){
	         let selectOption = $(this).val();		// (옵션값은 '옵션고유번호:옵션명_옵션가격' 형식으로 넘어오고 있다.)
	         let idx = selectOption.substring(0,selectOption.indexOf(":"));
	         let optionName = selectOption.substring(selectOption.indexOf(":")+1,selectOption.indexOf("_"));
	         let optionPrice = selectOption.substring(selectOption.indexOf("_")+1);
	         let commaPrice = numberWithCommas(optionPrice);

	      // 이미 선택된 옵션이 있을 경우 기존 옵션을 삭제하고 새 옵션으로 교체
	         if ($(".layer").length > 0) {
	           $(".layer").remove(); // 기존 선택된 옵션 삭제
	         }

	         // 새로운 옵션을 추가하는 부분
	         if (selectOption != "") {
	           idxArray[idx] = idx;
	           let str = '';
	           str += '<div class="layer row" id="layer' + idx + '"><div class="col-5">' + optionName + '</div><div class="col-7">';
	           str += '<button type="button" class="btn-outline-gray" onclick="decreaseQuantity(' + idx + ')">-</button>';
	           str += '<input type="number" class="text-center numBox" id="numBox' + idx + '" name="optionNum" onchange="numChange(' + idx + ')" value="1" min="1"/>';
	           str += '<button type="button" class="btn-outline-gray" style="margin-right:10px;" onclick="increaseQuantity(' + idx + ')">+</button>';
	           str += '<input type="text" id="imsiPrice' + idx + '" class="price" value="' + commaPrice + '" readonly />';
	           str += '<input type="hidden" id="price' + idx + '" value="' + optionPrice + '"/> &nbsp;';
	           str += '<input type="button" class="btn-outline-black" onclick="remove(' + idx + ')" value="삭제"/>';
	           str += '<input type="hidden" name="statePrice" id="statePrice' + idx + '" value="' + optionPrice + '"/>';
	           str += '<input type="hidden" name="optionIdx" value="' + idx + '"/>';
	           str += '<input type="hidden" name="optionName" value="' + optionName + '"/>';
	           str += '<input type="hidden" name="optionPrice" value="' + optionPrice + '"/>';
	           str += '</div></div>';
	           $("#selectProductList").append(str); // 선택한 옵션을 추가

	           onTotal(); // 총합 계산
	         }
	       });
	     });
	     
	  // 수량 증가 함수
		  	function increaseQuantity(idx) {
		  	  let numBox = document.getElementById("numBox" + idx);
		  	  numBox.value = parseInt(numBox.value) + 1;
		  	  numChange(idx);  // 수량 변경 시 가격도 변경되도록 호출
		  	}

		  	// 수량 감소 함수
		  	function decreaseQuantity(idx) {
		  	  let numBox = document.getElementById("numBox" + idx);
		  	  if (parseInt(numBox.value) > 1) {
		  	    numBox.value = parseInt(numBox.value) - 1;
		  	    numChange(idx);  // 수량 변경 시 가격도 변경되도록 호출
		  	  }
		  	}
	 			
	     // 등록(추가)시킨 옵션의 상품을 삭제처리하기
	     function remove(idx) {
	       $("div").remove("#layer"+idx);

	       if($(".price").length) onTotal();
	       else location.reload();
	     }

	 		// 상품의 총 금액을 (재)계산처리한다.
	     function onTotal() {
	       let total = 0;
	       for(let i=0; i<idxArray.length; i++) {
	         if($("#layer"+idxArray[i]).length != 0) {
	           total +=  parseInt(document.getElementById("price"+idxArray[i]).value);
	           document.getElementById("totalPriceResult").value = total;
	         }
	       }
	       document.getElementById("totalPrice").value = numberWithCommas(total);
	     }

	 		// 수량을 변경시 처리하는 함수(콤마붙인가격과 콤마없는 가격을 함께 변경적용시켜준다.)
	     function numChange(idx) {
	       let price = document.getElementById("statePrice"+idx).value * document.getElementById("numBox"+idx).value;
	       document.getElementById("imsiPrice"+idx).value = numberWithCommas(price);
	       document.getElementById("price"+idx).value = price;
	       onTotal();
	     }
	  	
	     function numberWithCommas(x) {
         return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g,",");
       }
	  	
	 		 // 장바구니 호출시 수행하는 함수
	     function cart() {
	       if(document.getElementById("totalPrice").value==0) {
	         alert("옵션을 선택해주세요");
	         return false;
	       }
	       else {
	    	   document.myform.action = "${ctp}/shop/productCart";
	    	   document.myform.submit();
	       }
	     }

	 		// 직접 주문하기
	     function order() {
	       let totalPrice = document.getElementById("totalPrice").value;
	       if('${sMid}' == "") {
	         alert("로그인 후 이용 가능합니다.");
	         location.href = "${ctp}/member/memberLogin";
	       }
	       else if(totalPrice=="" || totalPrice==0) {
	         alert("옵션을 선택해주세요");
	         return false;
	       }
	       else {
	         document.getElementById("flag").value = "order";
	         document.myform.action = "${ctp}/shop/productOrder";
	         document.myform.submit();
	       }
	     }
	  	
	  	
			
  </script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<div id="content-form" class="container">
  <table id="content-table" style="width: 100%; margin: 0 auto; border-collapse: collapse;">
	  <!-- 이미지와 제품 정보 -->
	  <tr>
	  	<td style="padding: 10px;">
				<div>Home > ${vo.mainName} > ${vo.baseName} > ${vo.subName}</div>
	  	</td>
	  </tr>
	  <tr>
	    <td style="width: 50%; vertical-align: top; padding: 10px;">
	      <div class="main-img">
	        <div class="image-container" onmouseover="showHoverImage(this)" onmouseout="showDefaultImage(this)">
			      <!-- 기본 이미지 -->
			      <img src="${ctp}/product/${vo.titleImg}" alt="Thumbnail" class="default-img">
			      <!-- Hover 시 표시할 이미지 -->
			      <img src="${ctp}/product/${vo.thumbnail}" alt="Hover Image" class="hover-img" style="display: none;">
			    </div>
	      </div>
	    </td>
	    <td style="width: 50%; vertical-align: top; padding: 10px;">
	      <h2 style="font-size: 1.8em;">${vo.productName}</h2>
	      <div style="display: flex; align-items: center; margin-top: 20px;">
				  <p class="price" style="font-size: 1.4em; color: gray; text-decoration: line-through; margin-right: 10px;">
				    <fmt:formatNumber value="${vo.price}" pattern="#,##0"/> 원
				  </p>
				  <p class="discount" style="font-size: 1.2em; color: red; font-weight: bold;">
				    ${vo.discount}%
				  </p>
				</div>
	    	<p class="pay" style="font-size: 1.5em; margin-bottom: 30px;"><fmt:formatNumber value="${vo.pay}" pattern="#,##0"/> 원</p>
	    	<form name="optionForm">
		    	<select id="selectOption" name="productOption" class="form-select" style="flex: 8;" required>
						<option value="">선택</option>
						<c:forEach var="vo" items="${optionVOS}">
		          <option value="${vo.idx}:${vo.optionName}_${vo.price}">${vo.optionName}</option>
		        </c:forEach>
					</select>
				</form>
        	
				<form name="myform" method="post">
					<input type="hidden" name="mid" value="${sMid}"/>
					<input type="hidden" name="idx" value="${vo.idx}"/>
					<input type="hidden" name="productIdx" value="${vo.idx}"/>
					<input type="hidden" name="productCode" value="${vo.productCode}"/>
					<input type="hidden" name="productName" value="${vo.productName}"/>
					<input type="hidden" name="price" value="${vo.price}"/>
					<input type="hidden" name="pay" value="${vo.pay}"/>
					<input type="hidden" name="thumbnail" value="${vo.thumbnail}"/>
					<input type="hidden" name="totalPrice" id="totalPriceResult"/>
					<input type="hidden" name="flag" id="flag"/>
				 
					<div id="selectProductList"></div>	<!-- 앞의 콤보상자에서 선택한 옵션항목을 동적폼으로 출력처리하고 있다. -->
				</form>
        <hr/>
        <div style="width: 100%; display: flex; justify-content: space-between; align-items: center; padding: 1% 20%">
		    	<div class="text-left">
			        <font size="4" color="black">총상품금액</font>
			    </div>
			    <p class="text-right">
			        <b><input type="text" class="totalPrice text-right" id="totalPrice" style="font-size: 20px;" value="<fmt:formatNumber value='0' />" readonly />&nbsp;원</b>
			    </p>
				</div>
      	<div style="width: 100%; display: flex; justify-content: space-between; align-items: center; margin-top: 10px;">
	        <button type="button" onclick="order()" class="btn-black" style="margin-right: 10px;">구매하기</button>
	        <button type="button" onclick="cart()" class="btn-black">장바구니 담기</button>
      	</div>
	      
	    </td>
	  </tr>
	  <tr>
	    <td colspan="2" style="padding: 10px; text-align: center;">
	    
	    
	      <div class="additional-info" style="width:65%; padding: 20px; margin:auto; background-color: #fff; border: 1px solid #ddd;">
	        <h3>배송 안내</h3>
	        <!-- <p><font color="blue">* 1인 1개만 구매가 가능합니다. *</font></p> -->
	        <p>전국 무료 배송 및 설치<br/>(제주도 및 울릉도 등 도서/산간 지역의 경우 택배상품만 온라인 주문 가능)</p>
	        <hr>
	        <h3>제품 사진 관련 안내</h3>
	        <p>위의 사진들은 모니터에 따라 약간의 색상 차이가 발생될 수 있습니다.</p>
	      </div>
	    </td>
	  </tr>
	  <!-- 보조 이미지 -->
	  <tr>
	    <td colspan="2" style="padding: 10px; text-align: center;">
	      <div id="content" class="text-center"><br/>
			    ${vo.content}
			  </div>
	    </td>
	  </tr>
	  <!-- 추천상품 더보기 -->
	  <!--  
	  <tr>
	    <td colspan="2" style="padding: 20px;">
	      <div class="see-more">
	        <h5>추천 상품</h5>
	        <hr/>
	        <div class="grid-container" style="display: flex; flex-wrap: wrap; gap: 20px;">
	          <c:forEach var="vo1" items="${vos}" varStatus="st">
	            <c:if test="${vo.idx != vo1.idx}">
	              <a href="FurnitureContent.fu?idx=${vo1.idx}" style="text-decoration: none; color: inherit;">
	                <div class="grid-item" style="width: 200px; text-align: center;">
	                  <img src="${ctp}/images/furniture/upload/${vo1.thumbnail}" alt="Thumbnail" style="width: 100%; height: auto; border-radius: 8px;">
	                  <div class="title-grid">${vo1.title}</div>
	                  <div class="company-category">${vo1.company} | ${fn:toUpperCase(vo1.category)}</div>
	                </div>
	              </a>
	            </c:if>
	          </c:forEach>
	        </div>
	      </div>
	    </td>
	  </tr>
	  -->
	</table>
		
		<!-- 위로가기 버튼 -->
	  <h6 id="topBtn" class="text-right mr-3"><font color="#af9e84"><i class="fa-solid fa-circle-chevron-up fa-2x"></i></font></h6>
  </div>
	<%-- <jsp:include page="/WEB-INF/views/include/footer.jsp"/> --%>
	<footer>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</footer>
</body>
</html>