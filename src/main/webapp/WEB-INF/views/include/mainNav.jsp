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
	    flex-direction: row;
	    text-align: center;
	    background-color: white;
	    z-index: 102;
		}
		.detail-menu ul {
	    width: 100%;
	    justify-content: space-around;
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
		
		.detail-menu li div{
	    margin: 0;
	    padding: 0;
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
		
		/* Detail 메뉴 페이지네이션 추가 */
    .pagination-controls {
        display: flex;
        justify-content: space-between;
        align-items: center;
        margin-top: 10px;
    }
    .pagination-button {
        background-color: #333;
        color: white;
        border: none;
        padding: 5px 10px;
        cursor: pointer;
    }
    .pagination-button.disabled {
        background-color: #ddd;
        cursor: not-allowed;
    }
        
		
	</style>
	<script type="text/javascript">
		'use strict'
		var ctp = '${ctp}';
		function selectCategory(categoryName, category, categoryTop) {
			location.href = ctp+'/shop/shopMainList?categoryName='+categoryName+'&category='+category+'&categoryTop='+categoryTop;
		}
		
		// 페이지네이션 스크립트 추가
        const itemsPerPage = 5;
		
     // 각 클래스별 currentPage 상태를 저장할 객체
        let currentPage = {};

        function showPage(pageIndex, menuClass) {
            const menuItems = document.querySelectorAll(menuClass + ' li');
            const totalItems = menuItems.length;

            // 전체 페이지 수
            const totalPages = Math.ceil(totalItems / itemsPerPage);

            if (pageIndex < 0 || pageIndex >= totalPages) return;

            
         	// 각 클래스별로 currentPage 상태를 저장
            currentPage[menuClass] = pageIndex;

            // 모든 항목 숨기기
            menuItems.forEach(item => {
                item.style.display = 'none';
            });

            // 현재 페이지에 해당하는 항목만 표시
            const start = pageIndex * itemsPerPage;
            const end = Math.min(start + itemsPerPage, totalItems);
            for (let i = start; i < end; i++) {
                menuItems[i].style.display = 'block';
            }

            // 이전/다음 버튼 활성화/비활성화
            //document.querySelector(menuClass + ' .prev-button').classList.toggle('disabled', pageIndex === 0);
            //document.querySelector(menuClass + ' .next-button').classList.toggle('disabled', pageIndex === totalPages - 1);
            
            const prevButton = document.querySelector(menuClass + ' .pagination-controls .prev-button');
            const nextButton = document.querySelector(menuClass + ' .pagination-controls .next-button');
            
            prevButton.style.display = pageIndex == 0 ? 'none' : 'inline-block';
            nextButton.style.display = pageIndex == totalPages - 1 ? 'none' : 'inline-block';
        }

        function goToPreviousPage(menuClass) {
            if (currentPage[menuClass] > 0) {
                showPage(currentPage[menuClass] - 1, menuClass);
            }
        }

        function goToNextPage(menuClass) {
            const menuItems = document.querySelectorAll(menuClass + ' li');
            const totalItems = menuItems.length;
            const totalPages = Math.ceil(totalItems / itemsPerPage);

            if (currentPage[menuClass] < totalPages - 1) {
                showPage(currentPage[menuClass] + 1, menuClass);
            }
        }
        
        const menuClasses = [
        	'.bracelets', '.rings', '.necklaces', '.earrings', '.engagementRings', '.weddingBands', '.watches',
        	'.bags', '.leatherGoods', '.collections', '.accessories', '.sunglasses', '.fragrances', '.highPerfumery',
        	'.scentedHome', '.writing', '.home'
        	];

        // 초기 페이지 설정
        window.addEventListener('DOMContentLoaded', () => {
        	 menuClasses.forEach(menuClass => {
        		 currentPage[menuClass] = 0;
  	         showPage(0, menuClass);
    	    });
        });
        
        // 특정 메뉴를 클릭할 때 페이지네이션 초기화
        /*
        function initializePagination(menuClass) {
            showPage(0, menuClass);
        }
        */
        
	</script>
</head>
<body>
<div class="navbar-container">
	<ul class="nav-menu">
	  <li class="nav-item">
	  	<a href="javascript:selectCategory('mainName','Jewelry')" class="main-menu">Jewelry</a>
	  	<div class="sub-menu">
	  		<hr/>
	  		<!--  
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
	      -->
	      <!-- Bracelets -->
	      <div class="subMenu-section">
	        <h4 onclick="selectCategory('baseName','Bracelets','Jewelry')">Bracelets</h4>
	        <ul class="detail-menu bracelets">
	        	<div class="pagination-controls">
      	      <button class="pagination-button prev-button" onclick="goToPreviousPage('.bracelets')"> &lt; </button>
  			    </div>
	          <li>
	          	<a href="javascript:selectCategory('subName','LOVE','Bracelets')">
	          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          	<div>LOVE</div>
	          	</a>
	          </li>
	          <li>
	          	<a href="javascript:selectCategory('subName','저스트앵끌루','Bracelets')">
	          		<div><img src="${ctp}/shop/bracelets/저스트앵끌루.jpg" width="200px" height="200px;"></div>
	          		<div>저스트앵끌루</div>
	          	</a>
	          </li>
	          <li>
	          	<a href="javascript:selectCategory('subName','트리니티','Bracelets')">
	         			<div><img src="${ctp}/shop/bracelets/트리니티.jpg" width="200px" height="200px;"></div>
	          		<div>트리니티</div>
	          	</a>
	          </li>
	          <li>
	          	<a href="javascript:selectCategory('subName','팬더','Bracelets')">
	          	<div><img src="${ctp}/shop/bracelets/팬더.jpg" width="200px" height="200px;"></div>
	          		<div>팬더</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','클래쉬','Bracelets')">
		          <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>클래쉬</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','다이아몬드','Bracelets')">
		          <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>다이아몬드</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','다무르','Bracelets')">
		          <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>다무르</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','에크루','Bracelets')">
		          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>에크루</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','링크','Bracelets')">
		          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>링크</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','칵투스','Bracelets')">
		          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>칵투스</div>
	          	</a>
	          </li>
            <div class="pagination-controls">
	            <button class="pagination-button next-button" onclick="goToNextPage('.bracelets')"> &gt; </button>
		        </div>
	        </ul>
	      </div>
	      
	      
	      <!-- Rings -->
	      <div class="subMenu-section">
	        <h4 onclick="selectCategory('baseName','Rings','Jewelry')">Rings</h4>
	        <ul class="detail-menu rings">
	        	<div class="pagination-controls">
      	      <button class="pagination-button prev-button" onclick="goToPreviousPage('.rings')"> &lt; </button>
  			    </div>
	          <li>
	          	<a href="javascript:selectCategory('subName','LOVE','Rings')">
	          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          	<div>LOVE</div>
	          	</a>
	          </li>
	          <li>
	          	<a href="javascript:selectCategory('subName','저스트앵끌루','Rings')">
	          		<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>저스트앵끌루</div>
	          	</a>
	          </li>
	          <li>
	          	<a href="javascript:selectCategory('subName','트리니티','Rings')">
	         			<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>트리니티</div>
	          	</a>
	          </li>
	          <li>
	          	<a href="javascript:selectCategory('subName','클래쉬','Rings')">
	          		<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>클래쉬</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','팬더','Rings')">
		          <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>팬더</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','그랑드카페','Rings')">
		          <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>그랑드카페</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','다이아몬드','Rings')">
		          <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>다이아몬드</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','에크루','Rings')">
		          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>에크루</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','마이용팬더','Rings')">
		          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>마이용팬더</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','파우나앤플로라','Rings')">
		          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>파우나앤플로라</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','레베를랭고','Rings')">
		          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>레베를랭고</div>
	          	</a>
	          </li>
            <div class="pagination-controls">
	            <button class="pagination-button next-button" onclick="goToNextPage('.rings')"> &gt; </button>
		        </div>
	        </ul>
	      </div>
	      
	      
	      
	      <!-- Necklaces -->
	      <div class="subMenu-section">
	        <h4 onclick="selectCategory('baseName','Necklaces','Jewelry')">Necklaces</h4>
	        <ul class="detail-menu necklaces">
	        	<div class="pagination-controls">
      	      <button class="pagination-button prev-button" onclick="goToPreviousPage('.necklaces')"> &lt; </button>
  			    </div>
	          <li>
	          	<a href="javascript:selectCategory('subName','LOVE','Necklaces')">
	          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          	<div>LOVE</div>
	          	</a>
	          </li>
	          <li>
	          	<a href="javascript:selectCategory('subName','저스트앵끌루','Necklaces')">
	          		<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>저스트앵끌루</div>
	          	</a>
	          </li>
	          <li>
	          	<a href="javascript:selectCategory('subName','클래쉬','Necklaces')">
	         			<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>클래쉬</div>
	          	</a>
	          </li>
	          <li>
	          	<a href="javascript:selectCategory('subName','팬더','Necklaces')">
	          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>팬더</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','아그라프','Necklaces')">
		          <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>아그라프</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','C끌떼','Necklaces')">
		          <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>C끌떼</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','다이아몬드','Necklaces')">
		          <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>다이아몬드</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','트리니티','Necklaces')">
		          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>트리니티</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','그랑드카페','Necklaces')">
		          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>그랑드카페</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','다무르','Necklaces')">
		          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>다무르</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','레베를랭고','Necklaces')">
		          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>레베를랭고</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','파우나앤플로라','Necklaces')">
		          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>파우나앤플로라</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','링크','Necklaces')">
		          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>링크</div>
	          	</a>
	          </li>
            <div class="pagination-controls">
	            <button class="pagination-button next-button" onclick="goToNextPage('.necklaces')"> &gt; </button>
		        </div>
	        </ul>
	      </div>
	      
	      
	      
	      
	      <!-- Earrings -->
	       <div class="subMenu-section">
	        <h4 onclick="selectCategory('baseName','Earrings','Jewelry')">Earrings</h4>
	        <ul class="detail-menu earrings">
	        	<div class="pagination-controls">
      	      <button class="pagination-button prev-button" onclick="goToPreviousPage('.earrings')"> &lt; </button>
  			    </div>
	          <li>
	          	<a href="javascript:selectCategory('subName','LOVE','Earrings')">
	          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          	<div>LOVE</div>
	          	</a>
	          </li>
	          <li>
	          	<a href="javascript:selectCategory('subName','저스트앵끌루','Earrings')">
	          		<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>저스트앵끌루</div>
	          	</a>
	          </li>
	          <li>
	          	<a href="javascript:selectCategory('subName','트리니티','Earrings')">
	         			<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>트리니티</div>
	          	</a>
	          </li>
	          <li>
	          	<a href="javascript:selectCategory('subName','클래쉬','Earrings')">
	          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>클래쉬</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','팬더','Earrings')">
		          <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>팬더</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','그랑드카페','Earrings')">
		          <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>그랑드카페</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','다이아몬드','Earrings')">
		          <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>다이아몬드</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','C끌떼','Earrings')">
		          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>C끌떼</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','칵투스','Earrings')">
		          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>칵투스</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','다무르','Earrings')">
		          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>다무르</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','파우나앤플로라','Earrings')">
		          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>파우나앤플로라</div>
	          	</a>
	          </li>
            <div class="pagination-controls">
	            <button class="pagination-button next-button" onclick="goToNextPage('.earrings')"> &gt; </button>
		        </div>
	        </ul>
	      </div>
	      
	      
	      
	      
	      <!-- Engagement rings -->
	       <div class="subMenu-section">
	        <h4 onclick="selectCategory('baseName','Engagement rings','Jewelry')">Engagement rings</h4>
	        <ul class="detail-menu engagementRings">
	        	<div class="pagination-controls">
      	      <button class="pagination-button prev-button" onclick="goToPreviousPage('.engagementRings')"> &lt; </button>
  			    </div>
	          <li>
	          	<a href="javascript:selectCategory('subName','LOVE','Engagement rings')">
	          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          	<div>LOVE</div>
	          	</a>
	          </li>
	          <li>
	          	<a href="javascript:selectCategory('subName','솔리테어','Engagement rings')">
	          		<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>솔리테어</div>
	          	</a>
	          </li>
	          <li>
	          	<a href="javascript:selectCategory('subName','에땅셀','Engagement rings')">
	         			<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>에땅셀</div>
	          	</a>
	          </li>
	          <li>
	          	<a href="javascript:selectCategory('subName','발레린','Engagement rings')">
	          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>발레린</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','데스티네','Engagement rings')">
		          <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>데스티네</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','트리니티루반','Engagement rings')">
		          <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>트리니티루반</div>
	          	</a>
	          </li>
            <div class="pagination-controls">
	            <button class="pagination-button next-button" onclick="goToNextPage('.engagementRings')"> &gt; </button>
		        </div>
	        </ul>
	      </div>
	      
	      
	      
	      
	      <!-- Wedding bands -->
	       <div class="subMenu-section">
	        <h4 onclick="selectCategory('baseName','Wedding bands','Jewelry')">Wedding bands</h4>
	        <ul class="detail-menu weddingBands">
	        	<div class="pagination-controls">
      	      <button class="pagination-button prev-button" onclick="goToPreviousPage('.weddingBands')"> &lt; </button>
  			    </div>
	          <li>
	          	<a href="javascript:selectCategory('subName','LOVE','Wedding bands')">
	          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          	<div>LOVE</div>
	          	</a>
	          </li>
	          <li>
	          	<a href="javascript:selectCategory('subName','솔리테어','Wedding bands')">
	          		<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>솔리테어</div>
	          	</a>
	          </li>
	          <li>
	          	<a href="javascript:selectCategory('subName','C끌떼','Wedding bands')">
	         			<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>C끌떼</div>
	          	</a>
	          </li>
	          <li>
	          	<a href="javascript:selectCategory('subName','에땅셀','Wedding bands')">
	          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>에땅셀</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','다무르','Wedding bands')">
		          <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>다무르</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','데스티네','Wedding bands')">
		          <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>데스티네</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','트리니티루반','Wedding bands')">
		          <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>트리니티루반</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','발레린','Wedding bands')">
		          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>발레린</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','루이방돔','Wedding bands')">
		          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>루이방돔</div>
	          	</a>
	          </li>
	          <li>
		          <a href="javascript:selectCategory('subName','마이용팬더','Wedding bands')">
		          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>마이용팬더</div>
	          	</a>
	          </li>
            <div class="pagination-controls">
	            <button class="pagination-button next-button" onclick="goToNextPage('.weddingBands')"> &gt; </button>
		        </div>
	        </ul>
	      </div>
	    </div>
	  </li>
	  
	  
	  
	  
	  <!-- Watches -->
	  <li class="nav-item">
	  	<a href="javascript:selectCategory('mainName','Watches')" class="main-menu"> Watches </a>
	  	<div class="sub-menu">
		  	<hr/>
				<div class="subMenu-section">
					<h4 onclick="selectCategory('baseName','Watches','Watches')">Watches</h4>
					<ul class="detail-menu watches">
						<div class="pagination-controls">
					    <button class="pagination-button prev-button" onclick="goToPreviousPage('.watches')"> &lt; </button>
						</div>
						<li>
							<a href="javascript:selectCategory('subName','탱크','Watches')">
							<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
							<div>탱크</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','베누아','Watches')">
								<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>베누아</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','팬더','Watches')">
								<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>팬더</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','발롱','Watches')">
							<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>발롱</div>
							</a>
						</li>
						<li>
						  <a href="javascript:selectCategory('subName','산토스','Watches')">
						  <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>산토스</div>
							</a>
						</li>
						<li>
						  <a href="javascript:selectCategory('subName','롱드','Watches')">
						  <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>롱드</div>
							</a>
						</li>
						<li>
						  <a href="javascript:selectCategory('subName','파샤','Watches')">
						  <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>파샤</div>
							</a>
						</li>
						<li>
						  <a href="javascript:selectCategory('subName','프리베','Watches')">
						  	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>프리베</div>
							</a>
						</li>
						<li>
						  <a href="javascript:selectCategory('subName','리플렉션','Watches')">
						  	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>리플렉션</div>
							</a>
						</li>
						<li>
						  <a href="javascript:selectCategory('subName','팬더','Watches')">
						  	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>팬더</div>
							</a>
						</li>
						<li>
						  <a href="javascript:selectCategory('subName','클래쉬','Watches')">
						  	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>클래쉬</div>
							</a>
						</li>
						<div class="pagination-controls">
					  	<button class="pagination-button next-button" onclick="goToNextPage('.watches')"> &gt; </button>
			      </div>
	  			</ul>
  			</div>
			</div>
		</li>
	  
	  
	  
	  
	  <li class="nav-item">
	  	<a href="javascript:selectCategory('mainName','Bags and Accessories')" class="main-menu">Bags and Accessories</a>
	  	<div class="sub-menu">
	  		<hr/>
	  		<!-- Bags -->
	  		<div class="subMenu-section">
					<h4 onclick="selectCategory('baseName','Bags', 'Bags and Accessories')">Bags</h4>
					<ul class="detail-menu bags">
						<div class="pagination-controls">
					    <button class="pagination-button prev-button" onclick="goToPreviousPage('.bags')"> &lt; </button>
						</div>
						<li>
							<a href="javascript:selectCategory('subName','핸드백','Bags')">
							<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
							<div>핸드백</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','숄더백','Bags')">
								<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>숄더백</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','토트백','Bags')">
								<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>토트백</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','미니백','Bags')">
							<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>미니백</div>
							</a>
						</li>
						<li>
						  <a href="javascript:selectCategory('subName','이브닝백','Bags')">
						  <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>이브닝백</div>
							</a>
						</li>
						<li>
						  <a href="javascript:selectCategory('subName','비지니스백','Bags')">
						  <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>비지니스백</div>
							</a>
						</li>
						<div class="pagination-controls">
					  	<button class="pagination-button next-button" onclick="goToNextPage('.bags')"> &gt; </button>
			      </div>
	  			</ul>
  			</div>
		


				<!-- Leather goods -->
	  		<div class="subMenu-section">
					<h4 onclick="selectCategory('baseName','Leather goods', 'Bags and Accessories')">Leather goods</h4>
					<ul class="detail-menu leatherGoods">
						<div class="pagination-controls">
					    <button class="pagination-button prev-button" onclick="goToPreviousPage('.leatherGoods')"> &lt; </button>
						</div>
						<li>
							<a href="javascript:selectCategory('subName','벨트','Leather goods')">
							<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
							<div>벨트</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','카드홀더','Leather goods')">
								<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>카드홀더</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','키케이스','Leather goods')">
								<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>키케이스</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','지갑','Leather goods')">
							<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>지갑</div>
							</a>
						</li>
						<div class="pagination-controls">
					  	<button class="pagination-button next-button" onclick="goToNextPage('.leatherGoods')"> &gt; </button>
			      </div>
	  			</ul>
  			</div>		


				<!-- Accessories -->
	  		<div class="subMenu-section">
					<h4 onclick="selectCategory('baseName','Accessories', 'Bags and Accessories')">Accessories</h4>
					<ul class="detail-menu accessories">
						<div class="pagination-controls">
					    <button class="pagination-button prev-button" onclick="goToPreviousPage('.accessories')"> &lt; </button>
						</div>
						<li>
							<a href="javascript:selectCategory('subName','커프링크스','Accessories')">
							<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
							<div>커프링크스</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','스카프','Accessories')">
								<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>스카프</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','키링','Accessories')">
								<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>키링</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','머니클립','Accessories')">
							<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>머니클립</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','라이터','Accessories')">
							<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>라이터</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','선글라스','Accessories')">
							<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>선글라스</div>
							</a>
						</li>
						<div class="pagination-controls">
					  	<button class="pagination-button next-button" onclick="goToNextPage('.accessories')"> &gt; </button>
			      </div>
	  			</ul>
  			</div>				
	    </div>
	  </li>
	  
	  
	  <li class="nav-item">
	  	<a href="javascript:selectCategory('mainName','Fragrances')" class="main-menu"> Fragrances </a>
	  	<div class="sub-menu">
	  		<hr/>
	  	
				<!-- Fragrances -->
	  		<div class="subMenu-section">
					<h4 onclick="selectCategory('baseName','Fragrances','Fragrances')">Fragrances</h4>
					<ul class="detail-menu fragrances">
						<div class="pagination-controls">
					    <button class="pagination-button prev-button" onclick="goToPreviousPage('.fragrances')"> &lt; </button>
						</div>
						<li>
							<a href="javascript:selectCategory('subName','라펜더','Fragrances')">
							<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
							<div>라펜더</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','파샤','Fragrances')">
								<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>파샤</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','베제볼레','Fragrances')">
								<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>베제볼레</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','데클라라시옹','Fragrances')">
							<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>데클라라시옹</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','리비에르','Fragrances')">
							<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>리비에르</div>
							</a>
						</li>
						<div class="pagination-controls">
					  	<button class="pagination-button next-button" onclick="goToNextPage('.fragrances')"> &gt; </button>
			      </div>
	  			</ul>
  			</div>		  	
	  	
	  	
				<!-- High Perfumery -->
	  		<div class="subMenu-section">
					<h4 onclick="selectCategory('baseName','High Perfumery','Fragrances')">High Perfumery</h4>
					<ul class="detail-menu highPerfumery">
						<div class="pagination-controls">
					    <button class="pagination-button prev-button" onclick="goToPreviousPage('.highPerfumery')"> &lt; </button>
						</div>
						<li>
							<a href="javascript:selectCategory('subName','레제르','High Perfumery')">
							<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
							<div>레제르</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','보야제즈','High Perfumery')">
								<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>보야제즈</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','레줴퓌르','High Perfumery')">
								<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>레줴퓌르</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','레네쎄세르아','High Perfumery')">
							<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>레네쎄세르아</div>
							</a>
						</li>
						<div class="pagination-controls">
					  	<button class="pagination-button next-button" onclick="goToNextPage('.highPerfumery')"> &gt; </button>
			      </div>
	  			</ul>
  			</div>		  		  	
	  	
	  	
				<!-- Scented Candle -->
	  		<div class="subMenu-section">
					<h4 onclick="selectCategory('baseName','Scented Candle','Fragrances')">Scented Candle</h4>
					<ul class="detail-menu scentedCandle">
						<li>
							<a href="javascript:selectCategory('subName','레제크랭','Scented Candle')">
							<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
							<div>레제크랭</div>
							</a>
						</li>
	  			</ul>
  			</div>		  		  	
	    </div>
	  </li>
	  
	  
	  
	  
	  <li class="nav-item">
	  	<a href="javascript:selectCategory('mainName','Art of Living')" class="main-menu">Art of Living</a>
	  	<div class="sub-menu">
	  		<hr/>
	  	
				<!-- Stationery -->
	  		<div class="subMenu-section">
					<h4 onclick="selectCategory('baseName','Stationery', 'Art of Living')">Stationery</h4>
					<ul class="detail-menu writing">
						<div class="pagination-controls">
					    <button class="pagination-button prev-button" onclick="goToPreviousPage('.writing')"> &lt; </button>
						</div>
						<li>
							<a href="javascript:selectCategory('subName','필기구','Stationery')">
							<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
							<div>필기구</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','노트북','Stationery')">
								<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>노트북</div>
							</a>
						</li>
						<div class="pagination-controls">
					  	<button class="pagination-button next-button" onclick="goToNextPage('.writing')"> &gt; </button>
			      </div>
	  			</ul>
  			</div>		  	
  			

				<!-- Home -->
	  		<div class="subMenu-section">
					<h4 onclick="selectCategory('baseName','Home', 'Art of Living')">Home</h4>
					<ul class="detail-menu home">
						<div class="pagination-controls">
					    <button class="pagination-button prev-button" onclick="goToPreviousPage('.home')"> &lt; </button>
						</div>
						<li>
							<a href="javascript:selectCategory('subName','쿠션','Home')">
							<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
							<div>쿠션</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','블랭킷','Home')">
								<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>블랭킷</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','테이블웨어','Home')">
								<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>테이블웨어</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','오브제','Home')">
							<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>오브제</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','게임','Home')">
							<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>게임</div>
							</a>
						</li>
						<li>
							<a href="javascript:selectCategory('subName','베이비기프트','Home')">
							<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
								<div>베이비기프트</div>
							</a>
						</li>
						<div class="pagination-controls">
					  	<button class="pagination-button next-button" onclick="goToNextPage('.home')"> &gt; </button>
			      </div>
	  			</ul>
  			</div>		  	
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
