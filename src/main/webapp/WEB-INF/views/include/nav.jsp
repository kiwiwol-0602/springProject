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
	  	padding: 0 12% 0 10%;
	  	margin: 0;
	  	background-color: white;
	  	border-bottom: 1px solid #ddd;
	  	top: 11.8%;
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
	    padding:0.5% 3%;
	    border-top: 1px solid #ddd;
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
 			top: 22.5%; /* 부모 요소의 하단에서 약간 떨어진 위치 */
	    left: 0;
	    width: 100%;
	    list-style: none;
	    justify-content: space-around !important;
	    flex-direction: row;
	    text-align: center;
	    font-weight: bold;
	    background-color: transparent;
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
		var ctp = '${ctp}';
		function selectCategory(categoryName, category) {
			location.href = ctp+'/shop/shopMainList?categoryName='+categoryName+'&category='+category;
		}
		
		 // 페이지네이션 스크립트 추가
        let currentPage = 0;
        const itemsPerPage = 6;

        function showPage(pageIndex, menuClass) {
            const menuItems = document.querySelectorAll(menuClass + ' li');
            const totalItems = menuItems.length;

            // 전체 페이지 수
            const totalPages = Math.ceil(totalItems / itemsPerPage);

            if (pageIndex < 0 || pageIndex >= totalPages) return;

            currentPage = pageIndex;

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
            document.querySelector(menuClass + ' .prev-button').classList.toggle('disabled', pageIndex === 0);
            document.querySelector(menuClass + ' .next-button').classList.toggle('disabled', pageIndex === totalPages - 1);
        }

        function goToPreviousPage(menuClass) {
            if (currentPage > 0) {
                showPage(currentPage - 1, menuClass);
            }
        }

        function goToNextPage(menuClass) {
            const menuItems = document.querySelectorAll(menuClass + ' li');
            const totalItems = menuItems.length;
            const totalPages = Math.ceil(totalItems / itemsPerPage);

            if (currentPage < totalPages - 1) {
                showPage(currentPage + 1, menuClass);
            }
        }

        // 초기 페이지 설정
        window.addEventListener('DOMContentLoaded', () => {
            showPage(0, '.detail-menu');
        });
        
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
	          <li>
	          	<a href="#">
	          	<div><img src="${ctp}/shop/noimage.jpg" width="100px" height="150px;"></div>
	          	<div>LOVE</div>
	          	</a>
	          </li>
	          <li><a href="#">저스트 앵 끌루</a></li>
	          <li><a href="#">트리니티</a></li>
	          <li><a href="#">팬더</a></li>
	          <li><a href="#">그랑 드 카페</a></li>
	          <li><a href="#">클래쉬</a></li>
	        </ul>
	      </div>
	      -->
	      <div class="subMenu-section">
	        <h4 onclick="selectCategory('baseName','Bracelets')">Bracelets</h4>
	        <ul class="detail-menu bracelets">
	        	<div class="pagination-controls">
      	      <button class="pagination-button prev-button" onclick="goToPreviousPage('.bracelets')"> &lt; </button>
  			    </div>
	          <li>
	          	<a href="#">
	          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          	<div>LOVE</div>
	          	</a>
	          </li>
	          <li>
	          	<a href="#">
	          		<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>저스트엥끌루</div>
	          	</a>
	          </li>
	          <li>
	          	<a href="#">
	         			<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>트리니티</div>
	          	</a>
	          </li>
	          <li>
	          	<a href="#">
	          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>팬더</div>
	          	</a>
	          </li>
	          <li>
		          <a href="#">
		          <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>클래쉬</div>
	          	</a>
	          </li>
	          <li>
		          <a href="#">
		          <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>다이아몬드</div>
	          	</a>
	          </li>
	          <li>
		          <a href="#">
		          <div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>다무르</div>
	          	</a>
	          </li>
	          <li>
		          <a href="#">
		          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>에크루</div>
	          	</a>
	          </li>
	          <li>
		          <a href="#">
		          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>링크</div>
	          	</a>
	          </li>
	          <li>
		          <a href="#">
		          	<div><img src="${ctp}/shop/bracelets/love.jpg" width="200px" height="200px;"></div>
	          		<div>칵투스</div>
	          	</a>
	          </li>
            <div class="pagination-controls">
	            <button class="pagination-button next-button" onclick="goToNextPage('.bracelets')"> &gt; </button>
		        </div>
	        </ul>
	      </div>
	      <div class="subMenu-section">
        	<h4>Rings</h4>
        	<ul class="detail-menu">
	          <li><a href="#">LOVE</a></li>
	          <li><a href="#">저스트엥끌루</a></li>
	          <li><a href="#">트리니티</a></li>
	          <li><a href="#">클래쉬</a></li>
	          <li><a href="#">팬더</a></li>
	          <li><a href="#">그랑드카페</a></li>
	          <li><a href="#">다이아몬드</a></li>
	          <li><a href="#">에크루</a></li>
	          <li><a href="#">마이용팬더</a></li>
	          <li><a href="#">파우나앤플로라</a></li>
	          <li><a href="#">레베를랭고</a></li>
	        </ul>
	      </div>
	      <div class="subMenu-section">
        	<h4>Necklaces</h4>
        	<ul class="detail-menu">
	          <li><a href="#">LOVE</a></li>
	          <li><a href="#">저스트엥끌루</a></li>
	          <li><a href="#">클래쉬</a></li>
	          <li><a href="#">팬더</a></li>
	          <li><a href="#">아그라프</a></li>
	          <li><a href="#">C끌떼</a></li>
	          <li><a href="#">다이아몬드</a></li>
	          <li><a href="#">트리니티</a></li>
	          <li><a href="#">그랑드카페</a></li>
	          <li><a href="#">다무르</a></li>
	          <li><a href="#">레베를랭고</a></li>
	          <li><a href="#">파우나앤플로라</a></li>
	          <li><a href="#">링크</a></li>
	        </ul>
	      </div>
	      <div class="subMenu-section">
        	<h4>Earrings</h4>
      		<ul class="detail-menu">
	          <li><a href="#">LOVE</a></li>
	          <li><a href="#">저스트엥끌루</a></li>
	          <li><a href="#">트리니티</a></li>
	          <li><a href="#">클래쉬</a></li>
	          <li><a href="#">팬더</a></li>
	          <li><a href="#">그랑드카페</a></li>
	          <li><a href="#">다이아몬드</a></li>
	          <li><a href="#">C끌떼</a></li>
	          <li><a href="#">칵투스</a></li>
	          <li><a href="#">다무르</a></li>
	          <li><a href="#">파우나앤플로라</a></li>
	        </ul>
	      </div>
	      <div class="subMenu-section">
        	<h4>Engagement rings</h4>
        	<ul class="detail-menu">
	          <li><a href="#">LOVE</a></li>
	          <li><a href="#">솔리테어</a></li>
	          <li><a href="#">에땅셀</a></li>
	          <li><a href="#">발레린</a></li>
	          <li><a href="#">데스티네</a></li>
	          <li><a href="#">트리니티루반</a></li>
	        </ul>
	      </div>
	      <div class="subMenu-section">
        	<h4>Wedding bands</h4>
        	<ul class="detail-menu">
	          <li><a href="#">LOVE</a></li>
	          <li><a href="#">솔리테어</a></li>
	          <li><a href="#">C끌떼</a></li>
	          <li><a href="#">에땅셀</a></li>
	          <li><a href="#">다무르</a></li>
	          <li><a href="#">데스티네</a></li>
	          <li><a href="#">트리니티루반</a></li>
	          <li><a href="#">발레린</a></li>
	          <li><a href="#">루이방돔</a></li>
	          <li><a href="#">마이용팬더</a></li>
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
	  	<a href="javascript:selectCategory('mainName','Watches')" class="main-menu"> Watches </a>
	  	<div class="sub-menu">
	  	<hr/>
	      <div class="subMenu-section">
	        <h4>Watches</h4>
	        <ul class="detail-menu">
	          <li><a href="#">탱크</a></li>
	          <li><a href="#">베누아</a></li>
	          <li><a href="#">팬더</a></li>
	          <li><a href="#">발롱</a></li>
	          <li><a href="#">산토스</a></li>
	          <li><a href="#">롱드</a></li>
	          <li><a href="#">파샤</a></li>
	          <li><a href="#">프리베</a></li>
	          <li><a href="#">리플렉션</a></li>
	          <li><a href="#">팬더</a></li>
	          <li><a href="#">클래쉬</a></li>
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
	  	<a href="javascript:selectCategory('mainName','Bags and Accessories')" class="main-menu">Bags and Accessories</a>
	  	<div class="sub-menu">
	  	<hr/>
	  		<div class="subMenu-section">
        	<h4>Collections</h4>
	      </div>
	      <div class="subMenu-section">
	        <h4>Bags</h4>
	        <ul class="detail-menu">
	          <li><a href="#">핸드백</a></li>
	          <li><a href="#">숄더백</a></li>
	          <li><a href="#">토트백</a></li>
	          <li><a href="#">미니백</a></li>
	          <li><a href="#">이브닝백</a></li>
	          <li><a href="#">비지니스백</a></li>
	        </ul>
	      </div>
	      <div class="subMenu-section">
	        <h4>Leather goods</h4>
	        <ul class="detail-menu">
	          <li><a href="#">벨트</a></li>
	          <li><a href="#">카드홀더</a></li>
	          <li><a href="#">키케이스</a></li>
	          <li><a href="#">지갑</a></li>
	        </ul>
	      </div>
	      <div class="subMenu-section">
        	<h4>Accessories</h4>
        	<ul class="detail-menu">
	          <li><a href="#">커프링크스</a></li>
	          <li><a href="#">스카프</a></li>
	          <li><a href="#">키링</a></li>
	          <li><a href="#">머니클립</a></li>
	          <li><a href="#">라이터</a></li>
	          <li><a href="#">선글라스</a></li>
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
	  	<a href="javascript:selectCategory('mainName','Fragrances')" class="main-menu"> Fragrances </a>
	  	<div class="sub-menu">
	  	<hr/>
	      <div class="subMenu-section">
	        <h4>Fragrances</h4>
	        <ul class="detail-menu">
	          <li><a href="#">라펜더</a></li>
	          <li><a href="#">파샤</a></li>
	          <li><a href="#">베제볼레</a></li>
	          <li><a href="#">데클라라시옹</a></li>
	          <li><a href="#">리비에르</a></li>
	        </ul>
	      </div>
	      <div class="subMenu-section">
	        <h4>High Perfumery</h4>
	        <ul class="detail-menu">
	          <li><a href="#">레제르</a></li>
	          <li><a href="#">보야제즈</a></li>
	          <li><a href="#">레줴퓌르</a></li>
	          <li><a href="#">레네쎄세르아</a></li>
	        </ul>
	      </div>
	      <div class="subMenu-section">
        	<h4>Scented Candle</h4>
        	<ul class="detail-menu">
	          <li><a href="#">레제크랭</a></li>
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
	  	<a href="javascript:selectCategory('mainName','Art of Living')" class="main-menu">Art of Living</a>
	  	<div class="sub-menu">
	  	<hr/>
	      <div class="subMenu-section">
	        <h4>Writing & Stationery</h4>
	        <ul class="detail-menu">
	          <li><a href="#">필기구</a></li>
	          <li><a href="#">필기구</a></li>
	        </ul>
	      </div>
	      <div class="subMenu-section">
	        <h4>Home</h4>
	        <ul class="detail-menu">
	          <li><a href="#">쿠션</a></li>
	          <li><a href="#">블랭킷</a></li>
	          <li><a href="#">테이블웨어</a></li>
	          <li><a href="#">오브제</a></li>
	          <li><a href="#">게임</a></li>
	          <li><a href="#">베이비기프트</a></li>
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
