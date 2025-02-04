<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
	<!-- Optional theme -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
	<link href="https://fonts.googleapis.com/css?family=Josefin+Sans:300,400,700&subset=latin-ext" rel="stylesheet">

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
   
   .mainText {
   	text-align: center;
   	font-size: 30px;
   	margin-top: 2%;
   }
   
   
.imgSlide #slider-control i {
  padding-top: 130px;
  margin: 0 auto;
}

.imgSlide img {
  width: 100%; /* 이미지가 부모 요소의 너비에 맞춰지도록 */
  height: auto; /* 원본 비율을 유지하도록 */
  object-fit: contain; /* 이미지를 비율에 맞게 유지하면서 컨테이너에 맞춤 */
}

.imgSlide .item img {
  margin: 0 10px; /* 좌우에 10px의 여백을 추가 */
}

imgSlide .carousel-inner {
  display: flex;
  justify-content: center;
  align-items: center;
  width: 80%;
  gap: 15px; /* 슬라이드 항목 간 간격 추가 */
}

.imgSlide .carousel-inner .item {
  flex-shrink: 0; /* 슬라이드 항목들이 수축하지 않도록 설정 */
}

.imgSlide .carousel-inner img {
  width: 100%; /* 이미지의 너비를 슬라이드 항목 크기에 맞추도록 */
  height: auto;
  object-fit: contain;
}

.imgSlide .carousel-showmanymoveone .carousel-control {
  width: 4%;
  background-image: none;
}
.imgSlide .carousel-showmanymoveone .carousel-control.left {
  margin-left: 5px;
}
.imgSlide .carousel-showmanymoveone .carousel-control.right {
  margin-right: 5px;
}

.imgSlide .carousel-showmanymoveone .cloneditem-1,
.imgSlide .carousel-showmanymoveone .cloneditem-2,
.imgSlide .carousel-showmanymoveone .cloneditem-3,
.imgSlide .carousel-showmanymoveone .cloneditem-4{
  display: block; /* 새로운 슬라이드를 보이도록 */
}

@media all and (min-width: 768px) {
  .imgSlide .carousel-inner .item {
    flex: 0 0 25%;  /* 4개 항목을 보이도록 설정 */
  }
}

@media all and (min-width: 992px) {
  .imgSlide .carousel-inner .item {
    flex: 0 0 25%;  /* 4개 항목을 보이도록 설정 */
  }

  /* cloneditems가 4개 항목만 보이게 조정 */
  .imgSlide .carousel-showmanymoveone .carousel-inner .cloneditem-2,
  .imgSlide .carousel-showmanymoveone .carousel-inner .cloneditem-3,
  .imgSlide .carousel-showmanymoveone .carousel-inner .cloneditem-4,
  .imgSlide .carousel-showmanymoveone .carousel-inner .cloneditem-5{
    display: none;  /* 초기에 숨겨지도록 */
  }
}

@media all and (min-width: 768px) {
  .imgSlide .carousel-showmanymoveone .carousel-inner > .active.left,
  .imgSlide .carousel-showmanymoveone .carousel-inner > .prev {
    left: -50%;
  }

  .imgSlide .carousel-showmanymoveone .carousel-inner > .active.right,
  .imgSlide .carousel-showmanymoveone .carousel-inner > .next {
    left: 50%;
  }

  .imgSlide .carousel-showmanymoveone .carousel-inner > .left,
  .imgSlide .carousel-showmanymoveone .carousel-inner > .prev.right,
  .imgSlide .carousel-showmanymoveone .carousel-inner > .active {
    left: 0;
  }

  .imgSlide .carousel-showmanymoveone .carousel-inner .cloneditem-1 {
    display: block;
  }
}

@media all and (min-width: 992px) {
  .imgSlide .carousel-showmanymoveone .carousel-inner > .active.left,
  .imgSlide .carousel-showmanymoveone .carousel-inner > .prev {
    left: -16.666%;
  }

  .imgSlide .carousel-showmanymoveone .carousel-inner > .active.right,
  .imgSlide .carousel-showmanymoveone .carousel-inner > .next {
    left: 16.666%;
  }

  .imgSlide .carousel-showmanymoveone .carousel-inner > .left,
  .imgSlide .carousel-showmanymoveone .carousel-inner > .prev.right,
  .imgSlide .carousel-showmanymoveone .carousel-inner > .active {
    left: 0;
  }

  .imgSlide .carousel-showmanymoveone .carousel-inner .cloneditem-2,
  .imgSlide .carousel-showmanymoveone .carousel-inner .cloneditem-3,
  .imgSlide .carousel-showmanymoveone .carousel-inner .cloneditem-4,
  .imgSlide .carousel-showmanymoveone .carousel-inner .cloneditem-5{
    display: block;
  }
}

@media all and (min-width: 992px) and (transform-3d), all and (min-width: 992px) and (-webkit-transform-3d) {
  .imgSlide .carousel-showmanymoveone .carousel-inner > .item.active.right,
  .imgSlide .carousel-showmanymoveone .carousel-inner > .item.next {
    -webkit-transform: translate3d(16.666%, 0, 0);
    transform: translate3d(16.666%, 0, 0);
    left: 0;
  }
  .imgSlide .carousel-showmanymoveone .carousel-inner > .item.active.left,
  .imgSlide .carousel-showmanymoveone .carousel-inner > .item.prev {
    -webkit-transform: translate3d(-16.666%, 0, 0);
    transform: translate3d(-16.666%, 0, 0);
    left: 0;
  }
  .imgSlide .carousel-showmanymoveone .carousel-inner > .item.left,
  .imgSlide .carousel-showmanymoveone .carousel-inner > .item.prev.right,
  .imgSlide .carousel-showmanymoveone .carousel-inner > .item.active {
    -webkit-transform: translate3d(0, 0, 0);
    transform: translate3d(0, 0, 0);
    left: 0;
  }
}

@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap');

.productArea {
  margin: 0;
  padding: 70px 0 0 0;
  box-sizing: border-box;
  border: 0px solid silver;
  outline: none;
  font-family: 'Noto Sans KR', sans-serif;
}

::-webkit-scrollbar {width: 10px; height: 10px; border: 3px solid #fff; }
::-webkit-scrollbar-button:start:decrement, ::-webkit-scrollbar-button:end:increment {display: block; height: 10px; background: url('./images/bg.png') #fff}
::-webkit-scrollbar-track {background: #efefef; -webkit-border-radius: 10px; border-radius:10px; -webkit-box-shadow: inset 0 0 4px rgba(0,0,0,.0)}
::-webkit-scrollbar-thumb {height: 50px; width: 50px; background: rgba(0,0,0,.2); -webkit-border-radius: 8px; border-radius: 8px; -webkit-box-shadow: inset 0 0 4px rgba(0,0,0,.1)}


.productArea h1 {
  font-size: 2.8rem;
  line-height: 2.8rem;
  font-weight: bolder;
  color: #fff;
}

.productArea h2 {
  font-size: 2.3rem;
  line-height: 2.3rem;
  font-weight: bold;
}

.productArea h3 {
  font-size: 1.8rem;
  line-height: 1.8rem;
  font-weight: bolder;
  color: #333;
}

.productArea h4 {
  font-size: 1.3rem;
  font-size: 1.3em;
  text-transform: uppercase;
  font-weight: bolder;
  color: #333;
}

.productArea h5 {
  font-size: 1rem;
  line-height: 1.4rem;
  text-transform: uppercase;
}

.productArea h6 {
  font-size: 0.85rem;
  color: black;
  line-height: 1.5rem;
  text-transform: uppercase;
}

.productArea span {
  font-size: 1.2rem;
}

.productArea a:link {
  color: white;
  text-transform: uppercase;
  text-decoration: none;
}

.productArea a:visited {
  color: white;
  text-transform: uppercase;
}

.productArea a:active {
  color: white;
  text-transform: uppercase;
}

.productArea a:hover {
  color: white;
  text-transform: uppercase;
}

.productArea small {
  font-size: 1rem;
  line-height: 0.9rem;
  color: #999;
}

.productArea li {
  list-style: none;
}

 .productArea .solid {
    font-size: 2.5rem;
    font-weight: bold;
    line-height: 2.5rem;
    text-align: center;
    color: #333;
  }


/*~~~~mobile start~~~~*/


/* best */
.productArea .best {
  padding: 5rem 3%;
  text-align: center;
}

.productArea .best small {
  text-decoration: line-through;
}

.productArea .container {
  width: 100%;
  height: ;
  display: flex;
  justify-content: center;
  align-items: center;
}

.productArea .container img {
  width: 95%;
}

.productArea .frame {
  width: 95%;
  overflow: auto;
}

.productArea .card-list {
  display: flex;
  cursor: pointer;
}

.productArea .card {
  flex-shrink: 0;
  width: 200px;
  height: 300px;
  margin-left: 10px;
  margin-right: 10px;
  margin-bottom: 40px;
  transition: 0.7s;
}


/*gender */
.productArea .gender {
  width: 360px;
  background: #fff;
  margin: 30px 0px;
  padding: 0 20px;
}

.productArea .gender> :first-child {
  text-align: center;
  padding-bottom: 30px;
}

.productArea .gender h1 {
  padding: 10px 20px;
  text-decoration: underline;
}

.productArea .gender p {
  margin: 0px 20px;
  width: 170px;
  background: rgba(0, 0, 0, 0.25);
  border-radius: 5px;
  font-size: 0.85rem;
  color: #fff;
  padding: 0.4rem;
}

.productArea .gender button {
  background: #a39886;
  color: #fff;
  font-size: 1.1rem;
  font-weight: bold;
  cursor: pointer;
}


.productArea .gender section {
  background: #fff;
}

.productArea .gender section> :first-child {
  position: relative;
  width: 100%;
  height: 500px;
  background-image: url('${ctp}/images/main/1.jpg');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  margin-bottom: 30px;
  cursor: pointer;
}

.productArea .gender section> :first-child button {
  position: absolute;
  bottom: 0;
  width: 100%;
  height: 60px;
}

.productArea .gender section> :last-child {
  width: 100%;
}

.productArea .gender section> :last-child> :first-child {
  position: relative;
  height: 500px;
  background-image: url('${ctp}/images/main/2.jpg');
  background-size: cover;
  background-position: 10% 0;
  background-repeat: no-repeat;
  margin-bottom: 30px;
  cursor: pointer;
}

.productArea .gender section> :last-child> :first-child button {
  position: absolute;
  top: 95px;
  right: -94px;
  width: 250px;
  height: 60px;
  transform: rotate(90deg); 
}

.productArea .gender section> :last-child> :last-child {
  position: relative;
  height: 500px;
  background-image: url('${ctp}/images/main/3.jpg');
  background-size: cover;
  background-position: center center;
  background-repeat: no-repeat;
  cursor: pointer;
}

.productArea .gender section> :last-child> :last-child h1 {
  position: absolute;
  right: 0;
}

.productArea .gender section> :last-child> :last-child p {
  position: absolute;
  width: 185px;
  right: 0;
  top: 65px;
}

.productArea .gender section> :last-child> :last-child button {
  position: absolute;
  top: 90px;
  left: -90px;
  width: 240px;
  height: 60px;
  transform: rotate(90deg); 
}


/* new */

.productArea .new> :nth-child(1){
  text-align: center;
  margin-bottom: 30px;
}

.productArea .new-flex {
}

.productArea .new-flex h3 {
  color: #fff;
  padding: 10px 20px;
}

.productArea .new-flex button {
  color: #fff;
  background: none;
  font-size: 1.5rem;
  margin-left: 72%;
  margin-top: 250px;
  cursor: pointer;
}

.productArea .new-flex div section {
  background: rgba(0, 0, 0, 0.3);
  cursor: pointer;
  width: 100%;
  height: 350px;
  transition: .3s;
}

/* .new-flex div section:hover {
  background: rgba(0, 0, 0, 0);
  cursor: pointer;
  width: 100%;
  height: 350px;
} */

.productArea .new-flex> :nth-child(1) {
  width: 100%;
  background: url('https://www.giordano.co.kr/_data/attach/202103/22/10406353856fb279927d255e0d1b87fc.jpg#addimg');
  background-size: cover;
  background-position: top center;
}

.productArea .new-flex> :nth-child(2) {
  width: 100%;
  background: url('https://www.giordano.co.kr/_data/attach/202103/16/38c86787104a050ea92df8751d056eb6.jpg#addimg');
  background-size: cover;
  background-position: top center;
}

 .productArea .new> :nth-child(3) {
    min-width: 360px;
    height: 220px;
    text-align: center;
    margin: 0 auto;
    padding: 0.6rem 0; 
    background: rgba(0, 0, 0, 0.2);
  }
  
 .productArea .new> :nth-child(3) h4 {
    color: #fff;
  }
  
 .productArea .new> :nth-child(3) p {
    width: 300px;
    margin: 10px auto;
    color: #eee;
    font-style: italic;
  }
  
  .new> :nth-child(3) button {
    font-weight: bold;
    background: #585554;
    color: #fff;
    width: 100%;
    padding: 10px 0;
    margin-top: 5px;
    cursor: pointer;
  }



/*~~~~labtop start~~~~*/
@media screen and (min-width: 1000px) {
  
  /* labtop best */

  .productArea .best {
    width: 90%;
    margin: 50px auto;
    text-align: center;
  }
  
  .productArea .best h2 {
    margin-bottom: 2rem;
  }
  
.productArea .prodList {
  width: 100%;
  margin: 0 auto;
}

  .productArea .container {
    width: 100%;
    margin-top: 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .productArea .container img {
    width: 90%;
  }

  .productArea .frame {
    width: 100%;
    overflow: auto;
  }

  .productArea .card-list {
    display: flex;
    cursor: pointer;
  }

  .productArea .card {
    text-align: center;
    flex-shrink: 0;
    width: 240px;
    height: 350px;
    border: 0px solid #d5d5d5;
    border-radius: 0px;
    margin-bottom: 40px;
  }
  
  .productArea .card h5 {
    margin-top: 0.3rem;
  }
  

  /* labtop-gender */
.productArea .gender {
  width: 77%;
  margin: 50px auto;
  padding: 0px 0;
}
  
.productArea .gender section {
    height: 700px;
    display: flex;
    background: #fff;
  }

.productArea .gender section h1 {
  padding: 10px 20px;
  text-decoration: underline;
}

.productArea .gender section> :first-child {
  width: 40%;
  height: 700px;
  background-image: url('${ctp}/images/main/1.jpg');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  margin-right: 10px;
  transition: 0.4s;
}
  
 .productArea .gender section> :first-child:hover {
 transform: translateY(-5%);
}

.productArea .gender section> :last-child {
  width: 60%;
}

.productArea .gender section> :last-child> :first-child {
  height: 350px;
  background-image: url('${ctp}/images/main/2.jpg');
  background-size: cover;
  background-position: 0 5%;
  background-repeat: no-repeat;
  margin-bottom: 10px;
  transition: 0.4s;
}
  
 .productArea .gender section> :last-child> :first-child:hover {
 transform: translateX(5%);
}

.productArea .gender section> :last-child> :last-child {
  height: 340px;
  background-image: url('${ctp}/images/main/3.jpg');
  background-size: cover;
  background-position: 0 8%;
  background-repeat: no-repeat;
  transition: 0.4s;
}
  
.productArea .gender section> :last-child> :last-child:hover {
 transform: translateY(10%);
}
  

 /* labtop-new */
  
  .productArea .new {
    position: relative;
    width: 60%;
    height: 550px;
    margin: 50px auto;
  }
  .productArea .new-flex {
  display: flex;
}
  
  .productArea .new-flex> :nth-child(1) {
  width: 50%;
  background: url('${ctp}/images/main/5.jpg');
  background-size: cover;
  background-position: top center;
}
  
.productArea .new-flex> :nth-child(2) {
  width: 50%;
  background: url('${ctp}/images/main/7.jpg');
  background-size: cover;
  background-position: top center;
}
  
  .productArea .new> :nth-child(3) {
    position: absolute;
    top: 48%;
    left: 50%;
    transform: translate(-50%, -40%);
    width: 350px;
    height: 180px;
    text-align: center;
    padding: 0.6rem 0; 
    background: rgba(0, 0, 0, 0.25);
    transition: 0.4s;
  }
  
    .productArea .new> :nth-child(3):hover {
    background: rgba(0, 0, 0, 0.5);
  }
  
  .productArea .new> :nth-child(3) h4 {
    color: #fff;
  }
  
  .productArea .new> :nth-child(3) p {
    width: 300px;
    margin: 10px auto;
    color: #eee;
    font-style: italic;
  }
  
  .productArea .new> :nth-child(3) button {
    font-weight: bold;
    background: #585554;
    color: #fff;
    width: 100%;
    padding: 10px 0;
    margin-top: 5px;
    cursor: pointer;
    transition: 0.4s;
  }
  
    .productArea .new> :nth-child(3) button:hover {
    background: #eee;
    color: #333;
  }

/* labtop-store */
 .productArea .store {
  background: #585554;
  text-align: center;
  margin-top: 200px;
  padding: 50px 0px;
}

.productArea .store table {
  background: #585554;
  width: 1000px;
  border-collapse: collapse;
  margin: 50px auto;
  margin-bottom: 0;
}

.productArea .store table td {
  color: #eee;
  border: 4px solid #a19b99;
  width: 170px;
  height: 100px;
  word-break:break-all;
  table-layout: fixed;
  cursor: pointer;
  transition: .15s;
}

.productArea .store table td:hover {
  background: rgba(0, 0, 0, 0.3);
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
	  
	  
	  $(document).ready(function(){

		  $('#itemslider').carousel({ interval: 3000 });

		  $('.carousel-showmanymoveone .item').each(function(){
		  var itemToClone = $(this);

		  for (var i=1;i<6;i++) {
		  itemToClone = itemToClone.next();

		  if (!itemToClone.length) {
		  itemToClone = $(this).siblings(':first');
		  }

		  itemToClone.children(':first-child').clone()
		  .addClass("cloneditem-"+(i))
		  .appendTo($(this));
		  }
		  });
		  });
	  
	
	  //best product slide
	  var slides = document.getElementsByClassName("slide-in");
	  var index = 0;

	  function goLeft() {
	      
	      if (index == 0) index = slides.length - 1;
	      else index--;
	     
	      slides[0].style.marginLeft = "-" + index * 800 + "px";
	  }

	  function goRight() {
	      
	      if (index == slides.length - 1) index = 0;
	      else index++;
	      
	      slides[0].style.marginLeft = "-" + index * 800 + "px";
	  }

	  jQuery('#selectBox').change(function() {
	  	var state = jQuery('#selectBox option:selected').val();
	    
	    if ( state == 'option1' ) {
	  		jQuery('.layer1').show();
	  	} else {
	  		jQuery('.layer1').hide();
	  	}
	    
	     if ( state == 'option2' ) {
	  		jQuery('.layer2').show();
	  	} else {
	  		jQuery('.layer2').hide();
	  	}
	    
	     if ( state == 'option3' ) {
	  		jQuery('.layer3').show();
	  	} else {
	  		jQuery('.layer3').hide();
	  	}
	    
	      if ( state == 'option4' ) {
	  		jQuery('.layer4').show();
	  	} else {
	  		jQuery('.layer4').hide();
	  	}
	    
	     if ( state == 'option5' ) {
	  		jQuery('.layer5').show();
	  	} else {
	  		jQuery('.layer5').hide();
	  	}
	    
	    if ( state == 'option6' ) {
	  		jQuery('.layer6').show();
	  	} else {
	  		jQuery('.layer6').hide();
	  	}
	    
	    
	  	if ( state == 'option7' ) {
	  		jQuery('.layer7').show();
	  	} else {
	  		jQuery('.layer7').hide();
	  	}
	  });
	  
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
				</div>
				<div class="swiper-slide">
					<div class="mainImgCrop">
						<img src="${ctp}/images/main/main2.jpg" alt="Slide 2" />
					</div>
				</div>
				<div class="swiper-slide">
					<div class="mainImgCrop">
						<img src="${ctp}/images/main/main3.jpg" alt="Slide 3" />
					</div>
					</div>
				</div> 
			</div>
			<div class="mainText">
				<div style="font-family: 'SF_HambakSnow';">COLLECTION</div>
				<div style="font-family: 'Gyeonggi_Batang_Regular';">루미, 하이엔드 주얼리의 세계로 초대</div>
			</div>
			<div class="imgSlide" style="padding: 5% 50px;">
				<div class="container-fluid">
				  <div class="row">
				    <div class="col-xs-12 col-sm-12 col-md-12">
				      <div class="carousel carousel-showmanymoveone slide" id="itemslider">
				        <div class="carousel-inner">
									<c:forEach var="vo" items="${vos}" varStatus="st">
										<c:if test="${st.index == 0}">
						          <div class="item active">
						            <div class="col-xs-12 col-sm-6 col-md-2">
						              <a href="${ctp}/shop/productContent?idx=${vo.idx}"><img src="${ctp}/product/${vo.thumbnail}"></a>
						            </div>
						          </div>
					          </c:if>
										<c:if test="${st.index > 0 && st.index < 4}">
						          <div class="item">
						            <div class="col-xs-12 col-sm-6 col-md-2">
						              <a href="${ctp}/shop/productContent?idx=${vo.idx}"><img src="${ctp}/product/${vo.thumbnail}"></a>
						            </div>
						          </div>
					          </c:if>
									</c:forEach>
				        </div>
				        <div id="slider-control">
					        <a class="left carousel-control" href="#itemslider" data-slide="prev"><i class="fa-solid fa-angle-left" style="font-size: 40px!important;"></i></a>
					        <a class="right carousel-control" href="#itemslider" data-slide="next"><i class="fa-solid fa-angle-right" style="font-size: 40px!important;"></i></a>
				     	  </div>
			      	</div>
				    </div>
				  </div>
				</div>
			</div>	
		</div>	

		<div class="productArea" >
		  <article class="gender" style="padding-top: 100px;">
	    	<section>
			    <div onclick="selectCategory('baseName','Necklaces','Jewelry')"></div>
		   		<div>
		      	<div onclick="selectCategory('baseName','Engagement rings','Jewelry')"></div>
		      	<div onclick="selectCategory('baseName','Rings','Jewelry')"></div>
		   		</div>
	 			</section> 
 			</article>
			<article class="best">
				<div class="prodList">
 					<h3>Best Products</h3>
	       	<span class="solid">—</span>
					<div class="container">
						<div class="frame">
						  <div class="card-list">
						  	<c:forEach var="vo" items="${Bvos}" varStatus="st">
						  		<c:if test="${st.index > 0 && st.index < 10}">
								    <div class="card"><a href="${ctp}/shop/productContent?idx=${vo.idx}"><img src="${ctp}/product/${vo.thumbnail}"></a>
								    	<h5>${vo.productName}</h5>
								      <small><fmt:formatNumber value="${vo.price}" pattern="#,##0"/>원</small>
								      <span><fmt:formatNumber value="${vo.pay}" pattern="#,##0"/>원</span>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</article>
		  <article class="new"  style="margin-bottom: 100px; padding-bottom: 100px;">
		  	<div>
		    	<h3>New Arraivals</h3>
		      <span class="solid">—</span>
		    </div>
		    <div class="new-flex">
			    <div>
			     <section>
			      <div></div> 
			      </section>
			    </div>
		    	<div>
			      <section>
			      	<div></div>
			      </section>
		  		</div>
				</div>
	    	<div>
      		<p>사람의 가치관이나 생각,<br>새로운 시대의 숨결<br>우리가 생각하는 라이프<br><br>2025년 2월, 새로운 감성을 담은<br>컬렉션을 만나보세요.<br></p>
    		</div>
			</article>
		</div>	
	</main >
	
	<!-- 위로가기 버튼 -->
	<h6 id="topBtn" class="text-right mr-3"><font color="#758694"><i class="fa-solid fa-circle-chevron-up fa-2x"></i></font></h6>
	  
	<footer>
		<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
	</footer>
</body>
</html>
