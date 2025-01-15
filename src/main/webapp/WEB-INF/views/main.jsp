<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<link rel="icon" href="${ctp}/main/favicon.png">
	<title>LUMI</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<jsp:include page="/WEB-INF/views/include/fonts.jsp" />
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css" />
	<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
	<style>
		html, body {
			margin: 0;
			padding: 0;
			height: 100%;
		}
		
		.timer {
			display: block;
			position: fixed; /* 화면에 고정 */
	    top: 0;
	    left: 0;
			background-color: #003161;
			color: white;
			font-family: 'SF_HambakSnow';
	    font-weight: lighter;
	    width: 100%;
	   	height: auto;
	    text-align: center;
	    padding: 20px 0 20px 0;
	    z-index: 100;
		}
		
		.timer #timer {
	    font-size: 1.5em;
	    text-shadow: none;
		}
		
		.timer #timer div {
	    display: inline-block;
	    min-width: 50px;
		}
		
		.timer #timer div span {
	    display: block;
	    font-size: .5em;
	    font-weight: 400;
		}

		/* X 버튼 스타일 */
		.timer .close-button {
			position: absolute;
			top: 10px;
			right: 50px;
			font-size: 2em;
			color: white;
			cursor: pointer;
			z-index: 3;
		}

		.timer .deliveryInfo{
			font-family: 'Gyeonggi_Batang_Regular';
			font-size: 1em;
			font-weight: 300;
		}
		
		.main_area {
			margin-top: 14.85%;
			height: 1100px;
    }
    
    /* swiper-container */
    	.swiper {
	    position: relative;
	}
	
	.mainImgCrop{
		position: relative;
		transform: translate(0%, -10%);		
    overflow: hidden;
	}
	
	.swiper-interior {
    overflow-x: hidden;  /* 가로 스크롤 숨기기 */
	}
	
	.swiper-wrapper {
	    width: 100%;  /* swiper-wrapper 너비를 100%로 설정 */
	}
	
	a:hover{
		text-decoration: none;
	}
	.mainImgCrop img {
		position: relative;
		bottom: 0;
	  width: 100%;
	  height: 750px;
	}
	/*
	.mainImgText {
		position: absolute;
		bottom: 40%;
		left: 4.5%;
		color: white;
	}
	.titleEng{
	  font-family: 'TTBookendBatangR';
	  font-size: 25px;
	}
	
	.titleKor{
	  font-family: 'Chosunilbo_myungjo';
	  font-weight: 400;
	  font-size: 40px;
	}
   */ 
		
	</style>
	<script type="text/javascript">
	  // 타이머 업데이트 함수
	  function updateTimer() {
	    let future = Date.parse("feb 14, 2025 00:00:00");
	    let now = new Date();
	    let diff = future - now;
	
	    let days = Math.floor(diff / (1000 * 60 * 60 * 24));
	    let hours = Math.floor(diff / (1000 * 60 * 60));
	    let mins = Math.floor(diff / (1000 * 60));
	    let secs = Math.floor(diff / 1000);
	
	    let d = days;
	    let h = hours - days * 24;
	    let m = mins - hours * 60;
	    let s = secs - mins * 60;
	
	    document.getElementById("timer").innerHTML =
	      '<div>' + d + '<span>Days</span></div>' +
	      '<div>' + h + '<span>Hours</span></div>' +
	      '<div>' + m + '<span>Min</span></div>' +
	      '<div>' + s + '<span>Second</span></div>';
	  }
	
	  document.addEventListener("DOMContentLoaded", function () {
		  <!-- Swiper 초기화 스크립트 -->
			var swiper = new Swiper('.swiper', {
				  slidesPerView: 1,  // 한 번에 보일 슬라이드 개수
				  spaceBetween: 0,   // 슬라이드 간격
				  centeredSlides: true, // 슬라이드가 중앙에 오지 않도록 설정
				  loop: true,         // 무한 루프
				  loopAdditionalSlides: 1,
				  autoplay: {
				    delay: 2500,      // 자동으로 슬라이드 전환 (밀리초 단위)
				    disableOnInteraction: false
				  }
			});
			
		  const timer = document.querySelector(".timer");
		  const header = document.querySelector(".header");
		  const main = document.querySelector(".main_area");
		  const nav = document.querySelector(".navbar-container");
		  const subMenus = document.querySelectorAll(".detail-menu");
		  const closeButton = document.querySelector(".close-button"); // X 버튼 선택

		  // 타이머를 즉시 계산하여 초기 표시
		  updateTimer();

		  // X 버튼 클릭 시 타이머 영역 전체를 숨기기
		  closeButton.addEventListener("click", () => {
		    timer.style.visibility = "hidden";; // 타이머 영역 숨김
			  timer.style.height = "0"; // 타이머 영역의 높이를 0으로 설정
		    //timer.style.padding = "0"; // 패딩 제거
		    header.style.top = "0";  
		    nav.style.top = "11.8%";  
		    main.style.marginTop = "8.9%";  
		    
		    subMenus.forEach(subMenu => {
		        subMenu.style.top = "22.6%"; // 원하는 위치로 수정
		      });
		    
		  });

		  // 타이머를 1초마다 갱신
		  setInterval(updateTimer, 1000);
		});
	  
	</script>
</head>
<body>
<header>
  <div class="timer">
  	<div class="close-button">×</div>
    <div id="timer"></div>
    <div class="deliveryInfo">Place your order by February 13 at 2 PM delivery by February 14. <a href="#" style="color: white;">Learn More </a></div>
  </div>
	<jsp:include page="/WEB-INF/views/include/mainHeader.jsp" />
	<jsp:include page="/WEB-INF/views/include/mainNav.jsp"/>
</header>
<main role="main">
<div class="main_area">
	<div class="swiper">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<div class="mainImgCrop">
					<img src="${ctp}/images/main/main1.jpg" alt="Slide 1" />
				</div>
				<!--
				<div class="mainImgText">
					<div class="titleEng">HOME STYLING</div>
					<div class="titleKor">전문가가 제안하는<br>최고의 가구 경험</div>
				</div>
				 -->
			</div>
			<div class="swiper-slide">
				<div class="mainImgCrop">
					<img src="${ctp}/images/main/main2.jpg" alt="Slide 2" />
				</div>
				<!--
				<div class="mainImgText">
					<div class="titleEng">HIGH-END STYLING</div>
					<div class="titleKor">프리미엄 공간<br>나만의 고요한 안식처</div>
				</div>
			 -->
			</div>
			<div class="swiper-slide">
				<div class="mainImgCrop">
					<img src="${ctp}/images/main/main3.jpg" alt="Slide 3" />
				</div>
				<!--
				<div class="mainImgText">
					<div class="titleEng">PREMIUM STYLING</div>
					<div class="titleKor">한남더힐<br>꿈의 집 미리보기</div>
				</div>
			  -->
				</div>
			</div> 
		</div>
	</div>
</main >
</body>
</html>
