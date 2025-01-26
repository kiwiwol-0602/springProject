<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
<jsp:include page="/WEB-INF/views/include/fonts.jsp" />

<style type="text/css">
    .logo {
        display: flex;
        font-size: 24px;
        text-align: center;
        color: black;
        font-family: '116watermelon';
        padding: 30px;
        text-decoration: none;
        justify-content: center; /* 수평 중앙 배치 */
        align-items: center; /* 수직 중앙 배치 */
        width: 100%;
    }
    .logo a {
        color: black;
        text-decoration: none;
    }
    .logo a:hover {
        color: black;
        text-decoration: none;
    }
    .w3-sidebar {
        position: fixed !important;
        top: 0;
        height: 100%;
        background-color: #f8f9fa; /* 밝은 배경 색상으로 변경 */
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 살짝의 그림자 효과 */
        overflow-y: auto; /* 사이드바 스크롤 추가 */
    }
    .navList {
        padding: 10px 20px;
    }
    h5 {
        padding: 10px 0;
        margin: 0;
        font-weight: bold;
        font-size: 18px;
        cursor: pointer;
        border-bottom: 1px solid #ddd; /* 하단에 구분선 */
    }
    .w3-bar-block {
        display: none;
        padding-left: 20px;
        margin-bottom: 10px;
    }
    .w3-bar-item {
        padding: 10px 0;
        color: #333;
        text-decoration: none;
        font-size: 16px;
        display: block;
    }
    .w3-bar-item:hover {
        background-color: #e9ecef !important; /* 호버 시 약간 어두운 배경 */
    }

    /* 하위 메뉴는 기본적으로 숨김 */
    .show {
        display: block !important;
    }
</style>
<script>
// Toggle between showing and hiding the sidebar, and add overlay effect
function w3_open() {
    var mySidebar = document.getElementById("mySidebar");
    if (mySidebar.style.display === 'block') {
        mySidebar.style.display = 'none';
    } else {
        mySidebar.style.display = 'block';
    }
}

// Close the sidebar with the close button
function w3_close() {
    document.getElementById("mySidebar").style.display = "none";
}

function toggleMenu(element) {
    // 모든 하위 메뉴를 닫음
    var allSubmenus = document.querySelectorAll('.w3-bar-block');
    allSubmenus.forEach(function(submenu) {
        submenu.style.display = 'none';
    });

    // 클릭된 메뉴의 하위 메뉴를 보여줌
    var nextElement = element.nextElementSibling;
    if (nextElement.style.display === "block") {
        nextElement.style.display = "none";
    } else {
        nextElement.style.display = "block";
    }
}

</script>

<div class="w3-bar w3-top w3-white w3-large" style="z-index:4; text-align: right;">
    <button class="w3-bar-item w3-button w3-hide-large w3-hover-none w3-hover-text-gray" onclick="w3_open();">
        <i class="fa fa-bars"></i>
    </button>
</div>

<!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse" style="width:300px;" id="mySidebar">
    <br>
    <span class="logo"><a href="${ctp}/admin/admin" target="_top">LUMI</a></span>
    <div class="w3-container w3-row">
        <div class="w3-col s4">
            <img src="${ctp}/member/${adminVO.photo}" class="w3-circle w3-margin-right" style="width:46px">
        </div>
        <div class="w3-col s8 w3-bar">
            <span>${adminVO.mid} <strong>${adminVO.name}</strong></span><br>
            <a href="#" class="w3-bar-item w3-button"><i class="fa fa-envelope"></i></a>
            <a href="#" class="w3-bar-item w3-button"><i class="fa fa-user"></i></a>
            <a href="#" class="w3-bar-item w3-button"><i class="fa fa-cog"></i></a>
        </div>
    </div>
    <hr>

    <div class="navList">
        <!-- 회원관리 -->
        <div class="w3-container">
            <h5 onclick="toggleMenu(this)">회원관리</h5>
	        <div class="w3-bar-block">
	            <a href="${ctp}/admin/userList" class="w3-bar-item w3-button">회원리스트</a>
	            <a href="#" class="w3-bar-item w3-button">접속통계</a>
        	</div>
        </div>

        <!-- 상품관리 -->
        <div class="w3-container">
            <h5 onclick="toggleMenu(this)">상품관리</h5>
        <div class="w3-bar-block">
            <a href="${ctp}/shop/productInput" class="w3-bar-item w3-button">상품등록</a>
            <a href="${ctp}/shop/productOption" class="w3-bar-item w3-button">옵션관리</a>
            <a href="${ctp}/admin/productList" class="w3-bar-item w3-button">상품리스트</a>
        </div>
        </div>

        <!-- 주문 및 판매관리 -->
        <div class="w3-container">
            <h5 onclick="toggleMenu(this)">주문 및 판매관리</h5>
        <div class="w3-bar-block">
            <a href="${ctp}/admin/orderList" class="w3-bar-item w3-button">주문</a>
            <a href="#" class="w3-bar-item w3-button">배송</a>
            <a href="#" class="w3-bar-item w3-button">판매</a>
            <a href="#" class="w3-bar-item w3-button">정산</a>
        </div>
        </div>

        <!-- 커뮤니티 -->
        <div class="w3-container">
            <h5 onclick="toggleMenu(this)">커뮤니티</h5>
        <div class="w3-bar-block">
            <a href="#" class="w3-bar-item w3-button">게시물</a>
            <a href="#" class="w3-bar-item w3-button">문의</a>
        </div>
        </div>

        <!-- 프로모션 -->
        <div class="w3-container">
            <h5 onclick="toggleMenu(this)">프로모션</h5>
        <div class="w3-bar-block">
            <a href="${ctp}/shop/couponList" class="w3-bar-item w3-button">쿠폰</a>
            <a href="#" class="w3-bar-item w3-button">마케팅</a>
            <a href="#" class="w3-bar-item w3-button">이벤트</a>
        </div>
        </div>

        <a href="${ctp}/main" class="w3-bar-item w3-button">
            <i class="fa fa-cog fa-fw"></i> exit
        </a>
    </div>
</nav>

<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>


