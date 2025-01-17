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
	<title>상품페이지 | LUMI</title>
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
    max-width: 85%;
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
							alert("안됨");
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
			
  </script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<div id="content-form" class="container">
  <table id="content-table" style="width: 85%; margin: 0 auto; border-collapse: collapse;">
	  <!-- 이미지와 제품 정보 -->
	  <tr>
	    <td style="width: 50%; vertical-align: top; padding: 10px;">
	      <div class="main-img">
	        <div class="image-container" onmouseover="showHoverImage(this)" onmouseout="showDefaultImage(this)">
			      <!-- 기본 이미지 -->
			      <img src="${ctp}/images/shop/${vo.thumbnail}" alt="Thumbnail" class="default-img">
			      <!-- Hover 시 표시할 이미지 -->
			      <img src="${ctp}/images/shop/${vo.titleImg}" alt="Hover Image" class="hover-img" style="display: none;">
			    </div>
	      </div>
	    </td>
	    <td style="width: 50%; vertical-align: top; padding: 10px;">
	      <div class="product-info">
	      	<p><br/></p>
	        <div class="input-group" style="text-align: center;">
	          <div class="company input-group-prepend">${vo.baseName}</div>
	          <div class="trash company"> / </div>
	          <div class="category input-group-append">${vo.subName}</div>
	        </div>
	        <h2>${vo.productName}</h2>
	        <p class="price"><fmt:formatNumber value="${vo.price}" pattern="#,##0"/> 원</p>
	        <button type="button" onclick="buy()" class="btn btn-outline-secondary">구매하기</button>
	        <button type="button" onclick="cartCheck()" class="btn btn-outline-secondary">장바구니 담기</button><br/><br/><br/><br/>
		      <div class="additional-info" style="padding: 20px; background-color: #fff; border: 1px solid #ddd;">
		        <h3>배송 안내</h3>
		        <p><font color="blue">* 1인 1개만 구매가 가능합니다. *</font></p>
		        <p>전국 무료 배송 및 설치<br/>(제주도 및 울릉도 등 도서/산간 지역의 경우 택배상품만 온라인 주문 가능)</p>
		        <hr>
		        <h3>제품 사진 관련 안내</h3>
		        <p>위의 사진들은 모니터에 따라 약간의 색상 차이가 발생될 수 있습니다.</p>
		      </div>
	      </div>
	    </td>
	  </tr>
	  <!-- 보조 이미지 -->
	  <tr>
	    <td colspan="2" style="padding: 10px; text-align: center;">
	      <div class="sub-img">
	        <img src="${ctp}/images/shop/${vo.titleImg}" alt="보조 이미지" style="width: 100%; max-width: 600px; border-radius: 8px;">
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
</body>
</html>