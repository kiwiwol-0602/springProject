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
	<style>
		html, body {
			margin: 0;
			padding: 0;
			height: 100%;
			overflow-x: hidden; /* 가로 스크롤 제거 */
		}
		.timer {
	    width: 100%;
	    height: 100vh;
	    text-align: center;
	    padding: 20px 0 0 0;
	    position: relative; /* 타이머를 기준으로 배치 */
		}
		/* 비디오 스타일 */
		.timer .video-container {
	    position: absolute;
	    top: 0;
	    left: 0;
	    width: 100%;
	    height: 100%;
	    overflow: hidden;
		}
		
		.timer .video-container video {
	    object-fit: cover; /* 비디오가 화면을 꽉 채우도록 설정 */
	    width: 100%;
	    height: 100%;
		}
		
		.timer .arrow-down {
	    cursor: pointer;
	    font-size: 2em;
	    color: white;
	    margin-top: 20px;
	    position: relative; /* 타이머를 비디오 위에 위치시킴 */
	    z-index: 2; /* 타이머가 비디오 위에 표시되도록 설정 */
	    opacity: 0; /* 초기 상태에서 보이지 않음 */
	    transform: translateY(50px); /* 초기 상태에서 아래에 위치 */
	    transition: transform 1s ease, opacity 1s ease; /* 애니메이션 효과 */
		}
		
		.timer .timerText {
			font-family: '116watermelon';
	    cursor: pointer;
	    font-size: 25em;
	    color: white;
	    margin: 2.5% 0 5% 0;
	    position: relative; /* 타이머를 비디오 위에 위치시킴 */
	    z-index: 2; /* 타이머가 비디오 위에 표시되도록 설정 */
	    opacity: 0; /* 초기 상태에서 보이지 않음 */
	    transform: translateY(50px); /* 초기 상태에서 아래에 위치 */
	    transition: transform 1s ease, opacity 1s ease; /* 애니메이션 효과 */
		}
		
		.timer .timerText a {
	    color: white;
	    text-decoration: none;
		}
		
		.timer #timer {
			font-family: 'SF_HambakSnow';
	    font-weight: lighter;
	    font-size: 3em;
	    color: white;
	    text-shadow: 0 0 20px #B1CDF1;
	    position: relative; /* 타이머를 비디오 위에 위치시킴 */
	    z-index: 2; /* 타이머가 비디오 위에 표시되도록 설정 */
		}
		
		.timer #timer div {
	    display: inline-block;
	    min-width: 90px;
		}
		
		.timer #timer div span {
	    color: white;
	    display: block;
	    font-size: .35em;
	    font-weight: 400;
		}
		/* X 버튼 스타일 */
		.timer .close-button {
			position: absolute;
			top: 10px;
			right: 10px;
			font-size: 2em;
			color: red;
			cursor: pointer;
			z-index: 3;
			display: none; /* 기본적으로 숨김 */
		}

		/* 타이머와 화살표가 동시에 나타날 때 */
		.timer.visible .timerText,
		.timer.visible .arrow-down {
	    opacity: 1; /* 애니메이션 후 나타남 */
	    transform: translateY(0); /* 위로 올라옴 */
		}
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
		  const navigateToMain = document.getElementById("navigateToMain");
		  const timer = document.querySelector(".timer");

		  // 타이머를 즉시 계산하여 초기 표시
		  updateTimer();

		  // 타이머와 화살표, LUMI가 동시에 나타나게 하기 위한 setTimeout 사용
		  setTimeout(function () {
		    timer.classList.add("visible"); // 타이머와 관련 요소가 동시에 나타남
		  }, 100); // 페이지 로드 후 100ms 후에 애니메이션 시작

		  // 타이머를 1초마다 갱신
		  setInterval(updateTimer, 1000);
		  
			// 페이드아웃 후 페이지 이동
	    navigateToMain.addEventListener("click", function () {
	      // .timer 컨테이너만 페이드아웃
	      timer.style.transition = "opacity 0.5s";
	      timer.style.opacity = "0";

	      // 0.5초 후 페이지 이동
	      setTimeout(function () {
	        window.location.href = "${ctp}/main";
	      }, 500);
	    });

	    // 애니메이션 효과 초기화
	    setTimeout(function () {
	      timer.classList.add("visible");
	    }, 100);
		});
	  
	</script>
</head>
<body>
	<div>
	  <div class="timer">
	  	<div class="close-button">×</div>
	    <div class="video-container">
	      <video autoplay loop muted>
        	<source src="https://www.cartier.com/on/demandware.static/-/Library-Sites-CartierSharedLibrary-BGTJ/default/homepage/2024/November/W1/Banners_Fullscreen_9-16/EOY24_PUJE11580_FILM_15s_WITHOUT%20LOGO_VI_1920x1080.mp4" type="video/mp4">
	      </video>
	    </div>
	    <div id="timer"></div>
	    <div class="timerText"><a href="${ctp}/main">LUMI</a></div>
	    <span class="arrow-down"><i class="fa-solid fa-chevron-down" id="navigateToMain"></i></span>
	  </div>
	</div>
</body>
</html>
