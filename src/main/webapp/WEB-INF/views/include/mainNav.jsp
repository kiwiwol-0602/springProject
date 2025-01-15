<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Navigation</title>
	<style>
		.navbar-container {
	  	display: flex;
	  	justify-content: space-between;
	  	position: fixed;
	  	align-items: center;
	  	padding: 0 5% 0 10%;
	  	margin: 0;
	  	background-color: white;
	  	border-bottom: 1px solid #ddd;
	  	top: 23.8%;
	  	width: 100%;
	  	z-index: 100;
	  	font-family: Arial, sans-serif;
		}
		.nav-menu {
			display: flex;
			position: relative;
	    list-style: none;
	    margin: 0;
	    padding: 0;
		}
		
		.nav-item {
	    position: relative;
	    padding: 15px 30px;
	    cursor: pointer;
		}
		
		.main-menu {
	    text-decoration: none;
	    color: black;
	    font-size: 16px;
	    text-transform: uppercase;
	    position: relative;
		}
		
		/* 밑줄 */
		.nav-item .main-menu::after {
	    content: "";
	    position: absolute;
	    bottom: -5px;
	    left: -10%;
	    width: 120%;
	    height: 2px;
	    background-color: navy; 
	    transform: scaleX(0);
	    transform-origin: bottom right;
	    transition: transform 0.3s ease-out;
		}
		
		.nav-item:hover .main-menu{
			font-weight: bold;
		}
		
		.nav-item:hover .main-menu::after {
	    transform: scaleX(1);
	    transform-origin: bottom left;
		}
		
		/* 서브 메뉴 */
		.sub-menu {
			display: none;
 			position: fixed; 
/* 	   	position: relative; */
/* 	   	position: sticky; */
	    left: 0;
	    width: 100%;
	    height: 300px;
	    background-color: white;
	    text-align:center;
	    margin:0.5% 0 0 0;
	    padding:0.5% 20%;
	    border-top: 1px solid #ddd;
	    justify-content: space-between;
	    z-index: 101;
		}
		
		.nav-item:hover .sub-menu {
	    display: flex;
		}
		
		.subMenu-section {
			position: relative; /* 각 섹션의 내용이 밀리지 않도록 위치를 조정 */
			justify-content: flex-start;
			width: 100%;
	    flex: 1;
		}

		.subMenu-section h4 {
			position: relative; /* h4를 기준으로 ::after 배치 */
			margin: 0;
			padding: 10px 0;
			justify-content: space-between;
			text-align: center;
		  font-size: 16px;
		  text-transform: uppercase;
		  border-bottom: 1px solid #ddd;
		}
		
		.subMenu-section h4::after {
	    content: "";
	    position: absolute;
	    bottom: 0px;
	    left: 30%;
	    width: 40%;
	    height: 2px;
	    background-color: navy;
	    transform: scaleX(0);
	    transform-origin: right;
	    transition: transform 0.3s ease-out;
		}

		.subMenu-section h4:hover::after {
	    transform: scaleX(1);
	    transform-origin: left;
		}
		
		.detail-menu {
	    display: none;
	    /*position: absolute;*/ /* 독립적으로 위치 */
		  /*top: 100%;*/ /* sub-menu 바로 아래 (간격 조정) */
		  position: fixed; /* 화면에 고정 */
 			top: 34.5%; /* 부모 요소의 하단에서 약간 떨어진 위치 */
	    left: 0;
	    width: 100%;
	    list-style: none;
	    justify-content: space-around !important;
	    flex-direction: row;
	    text-align: center;
	    font-weight: bold;
	    background-color: white;
	    z-index: 102;
		}
		.detail-menu li {
	    margin: 5px 10px;
		}
		
		.detail-menu li a {
			display: block; /* 링크가 항목 전체를 차지하도록 설정 */
	    text-decoration: none;
	    color: #333;
	    font-size: 14px;
	    padding: 10px;
			text-align: center; /* 텍스트를 중앙 정렬 */
			width: 100%; /* 각 항목이 100% 너비를 차지하도록 설정 */
		}
		
		.detail-menu li a:hover {
	    color: #b11226;
		}
		
		/* subMenu-section에 호버 시 보임 */
		.subMenu-section:hover .detail-menu {
			display:flex;
			flex-direction: row;
		  justify-content: center;
		  align-items: center;
	    flex: 1;
		}
		
		/* 이미지 섹션 */
		.sub-menu-image {
	    flex: 1;
	    display: flex;
	    justify-content: center;
	    align-items: center;
		}
		
		.sub-menu-image img {
	    max-width: 100%;
	    height: auto;
	    border-radius: 5px;
		}

		#subBorder{
		  border-top: 2px solid #ddd;
		  z-index: 102;
		}
		
	</style>
	<script type="text/javascript">
	
		function selectCategory(category) {
			location.href='${ctp}/shop/shopMainList?category='+category;
		}
	</script>
</head>
<body>
<div class="navbar-container">
	<ul class="nav-menu">
		<!--  
	  <li class="nav-item">
	    <a href="#" class="main-menu">컬렉션</a>
	    <div class="sub-menu">
	  	<hr/>
	      <div class="subMenu-section">
	        <h4>Essential Gifts</h4>
	        <ul class="detail-menu">
	          <li><a href="#">Festive Essentials</a></li>
	          <li><a href="#">Enchanted Jewelry</a></li>
	          <li><a href="#">Melodious Hours</a></li>
	          <li><a href="#">Seasonal Accessories</a></li>
	        </ul>
	      </div>
	      <div class="subMenu-section">
	        <h4>Gifts of Love</h4>
	        <ul class="detail-menu">
	          <li><a href="#">Luxury Watches</a></li>
	          <li><a href="#">Fine Fragrances</a></li>
	          <li><a href="#">Gift Services</a></li>
	        </ul>
	      </div>
	      <div class="subMenu-section">
        	<h4>Grand Gestures</h4>
	      </div>
	      <div class="subMenu-section">
        	<h4>A Gift,A Service</h4>
	      </div>
	    </div>
	  </li>
	 
	  <li class="nav-item">
	  	<a href="#" class="main-menu">주얼리</a>
	  	<div class="sub-menu">
	  	<hr/>
	      <div class="subMenu-section">
	        <h4>컬렉션</h4>
	        <ul class="detail-menu">
	          <li><a href="#">LOVE</a></li>
	          <li><a href="#">저스트 앵 끌루</a></li>
	          <li><a href="#">트리니티</a></li>
	          <li><a href="#">팬더</a></li>
	          <li><a href="#">그랑 드 카페</a></li>
	          <li><a href="#">클래쉬</a></li>
	        </ul>
	      </div>
	      <div class="subMenu-section">
	        <h4>Latest collections</h4>
	        <ul class="detail-menu">
	          <li><a href="#">Luxury Watches</a></li>
	          <li><a href="#">Fine Fragrances</a></li>
	          <li><a href="#">Gift Services</a></li>
	        </ul>
	      </div>
	    </div>
	  </li>
	   -->
	  <li class="nav-item">
	  	<a href="javascript:selectCategory('Jewelry')" class="main-menu">Jewelry</a>
	  	<div class="sub-menu">
	  	
	  	
	  	<hr/>
	      <div class="subMenu-section">
	        <h4>All Collections</h4>
	        <ul class="detail-menu">
	          <li><a href="#">LOVE</a></li>
	          <li><a href="#">저스트 앵 끌루</a></li>
	          <li><a href="#">트리니티</a></li>
	          <li><a href="#">팬더</a></li>
	          <li><a href="#">그랑 드 카페</a></li>
	          <li><a href="#">클래쉬</a></li>
	        </ul>
	      </div>
	      <div class="subMenu-section">
	        <h4>Bracelets</h4>
	        <ul class="detail-menu">
	          <li><a href="#">LOVE</a></li>
	          <li><a href="#">저스트 엥 끌루</a></li>
	          <li><a href="#">트리니티</a></li>
	          <li><a href="#">팬더</a></li>
	          <li><a href="#">클래쉬</a></li>
	          <li><a href="#">다이아몬드</a></li>
	        </ul>
	      </div>
	      <div class="subMenu-section">
        	<h4>Rings</h4>
	      </div>
	      <div class="subMenu-section">
        	<h4>Necklaces</h4>
	      </div>
	      <div class="subMenu-section">
        	<h4>Earrings</h4>
	      </div>
	      <div class="subMenu-section">
        	<h4>Engagement rings</h4>
	      </div>
	      <div class="subMenu-section">
        	<h4>Wedding bands</h4>
	      </div>
	      <!--
	      <div class="sub-menu-image">
        	<img src="https://via.placeholder.com/300x200" alt="Festive Season">
	      </div>
	      -->
	    </div>
	  </li>
	  <li class="nav-item">
	  	<a href="#" class="main-menu"> Watches </a>
	  	<div class="sub-menu">
	  	<hr/>
	      <div class="subMenu-section">
	        <h4>Watches</h4>
	        <ul class="detail-menu">
	          <li><a href="#">Festive Essentials</a></li>
	          <li><a href="#">Enchanted Jewelry</a></li>
	          <li><a href="#">Melodious Hours</a></li>
	          <li><a href="#">Seasonal Accessories</a></li>
	        </ul>
	      </div>
	      
	      <!--
	      <div class="sub-menu-image">
        	<img src="https://via.placeholder.com/300x200" alt="Festive Season">
	      </div>
	      -->
	    </div>
	  </li>
	  <li class="nav-item">
	  	<a href="#" class="main-menu">Bags and Accessories</a>
	  	<div class="sub-menu">
	  	<hr/>
	  		<div class="subMenu-section">
        	<h4>Collections</h4>
	      </div>
	      <div class="subMenu-section">
	        <h4>Bags</h4>
	        <ul class="detail-menu">
	          <li><a href="#">Festive Essentials</a></li>
	          <li><a href="#">Enchanted Jewelry</a></li>
	          <li><a href="#">Melodious Hours</a></li>
	          <li><a href="#">Seasonal Accessories</a></li>
	        </ul>
	      </div>
	      <div class="subMenu-section">
	        <h4>Small Leather goods</h4>
	        <ul class="detail-menu">
	          <li><a href="#">Luxury Watches</a></li>
	          <li><a href="#">Fine Fragrances</a></li>
	          <li><a href="#">Gift Services</a></li>
	        </ul>
	      </div>
	      <div class="subMenu-section">
        	<h4>Accessories</h4>
	      </div>
	      <!--
	      <div class="sub-menu-image">
        	<img src="https://via.placeholder.com/300x200" alt="Festive Season">
	      </div>
	      -->
	    </div>
	  </li>
	  <li class="nav-item">
	  	<a href="#" class="main-menu"> Fragrances </a>
	  	<div class="sub-menu">
	  	<hr/>
	      <div class="subMenu-section">
	        <h4>Fragrances</h4>
	        <ul class="detail-menu">
	          <li><a href="#">Festive Essentials</a></li>
	          <li><a href="#">Enchanted Jewelry</a></li>
	          <li><a href="#">Melodious Hours</a></li>
	          <li><a href="#">Seasonal Accessories</a></li>
	        </ul>
	      </div>
	      <div class="subMenu-section">
	        <h4>High Perfumery</h4>
	        <ul class="detail-menu">
	          <li><a href="#">Luxury Watches</a></li>
	          <li><a href="#">Fine Fragrances</a></li>
	          <li><a href="#">Gift Services</a></li>
	        </ul>
	      </div>
	      <div class="subMenu-section">
        	<h4>Scented Candle</h4>
	      </div>
	      <!--
	      <div class="sub-menu-image">
        	<img src="https://via.placeholder.com/300x200" alt="Festive Season">
	      </div>
	      -->
	    </div>
	  </li>
	  <li class="nav-item">
	  	<a href="#" class="main-menu">Art of Living</a>
	  	<div class="sub-menu">
	  	<hr/>
	      <div class="subMenu-section">
	        <h4>Writing & Stationery</h4>
	        <ul class="detail-menu">
	          <li><a href="#">Festive Essentials</a></li>
	          <li><a href="#">Enchanted Jewelry</a></li>
	          <li><a href="#">Melodious Hours</a></li>
	          <li><a href="#">Seasonal Accessories</a></li>
	        </ul>
	      </div>
	      <div class="subMenu-section">
	        <h4>Home</h4>
	        <ul class="detail-menu">
	          <li><a href="#">Luxury Watches</a></li>
	          <li><a href="#">Fine Fragrances</a></li>
	          <li><a href="#">Gift Services</a></li>
	        </ul>
	      </div>
	      <!--
	      <div class="sub-menu-image">
        	<img src="https://via.placeholder.com/300x200" alt="Festive Season">
	      </div>
	      -->
	    </div>
	  </li>
	  <li class="nav-item">
	  	<a href="#" class="main-menu">Archive</a>
	  	<div class="sub-menu">
	  	<hr/>
	      <div class="subMenu-section">
	      </div>
	    </div>
	  </li>
	</ul>
	<div class="nav-icons">
  	<i class="fas fa-search"></i>
	</div>
</div>

</body>
</html>
