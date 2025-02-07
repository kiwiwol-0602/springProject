<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header.jsp</title>
<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
<jsp:include page="/WEB-INF/views/include/fonts.jsp" />
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript">

</script>
<style type="text/css">
	.header {
	  display: flex;
		position:fixed;
		top:0;
		margin: 0;
	  padding: 1% 5%;
	  width: 100%;
		font-family: 'YiSunShinDotumM';
	  justify-content: space-between;
	  align-items: center;
	  background-color: white;
	  border-bottom: 1px solid #ddd;
		overflow: visible; /* 드롭다운이 header 영역 밖으로 나올 수 있게 설정 */
	  z-index: 101;
  }
  .header .menu-left,
  .header .menu-right {
    display: flex;
    align-items: center;
    gap: 25px;
    font-size: 15px;
    text-transform: uppercase;
    letter-spacing: 1px;
    position: relative;
  }
  .header .menu-left a,
  .header .menu-right a {
    text-decoration: none;
    color: black;
    transition: color 0.3s;
  }
  .header .menu-left a:hover,
  .header .menu-right a:hover {
    color: #888;
  }
  .header .logo {
    font-family: '116watermelon';
    font-size: 50px;
  }
  .header .logo a{
		color: black;
		text-decoration: none;    
  }
  .header .menu-right .icon {
    font-size: 25px;
  }
  
	.dropdown-container {
	  position: relative;
	  z-index: 1100; /* 드롭다운 메뉴가 다른 콘텐츠 위로 오도록 설정 */
	}
	
	/* 드롭다운 메뉴를 포함한 부모 요소에 hover 시 메뉴가 보이게 설정 */
	.dropdown-container:hover .dropdown-menu {
	  display: block;
	}
	
	.dropdown-menu {
	  display: none;
	  position: absolute;
	  top: 100%; /* 아이콘 바로 아래로 */
	  left: 0;
	  background-color: #fff;
	  border: 1px solid #ccc;
	  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	  padding: 10px 0;
	  width: 150px;
	  z-index: 1000; /* 드롭다운 메뉴가 다른 요소 위로 나오도록 설정 */
	}
	
	.myMenu-item {
	  padding: 10px 15px;
	  color: #333;
	  cursor: pointer;
	  text-align: center;
	  text-decoration: none;
	  display: block;
	}
	
	.myMenu-item:hover {
	  background-color: #f1f1f1;
	}




</style>
<script type="text/javascript">

window.Kakao.init("");
function logout() {
	  const accessToken = Kakao.Auth.getAccessToken();
	  if(accessToken) {
		  Kakao.Auth.logout(function() {
			  window.location.href = "https://kauth.kakao.com/oauth/logout?client_id=&logout_redirect_uri=http://localhost:9090/javaGroupS7/member/memberLogout";
		  });
	  }
	  else{
			location.href = "${ctp}/member/memberLogout";
	  }
  }
  
</script>
</head>
<body>
  <header class="header">
    <!-- 왼쪽 메뉴 -->
    <div class="menu-left">
      <a href="${ctp}/shared/introduction">Contact Us</a>
      <a href="${ctp}/webMessage/webMessage">Services</a>
    </div>
    <!-- 중앙 로고 -->
    <div class="logo">
      <a href="${ctp}/main">LUMI</a>
    </div>
    <!-- 오른쪽 메뉴 -->
    <div class="menu-right">
      <c:if test="${empty sMid}">
      	<a href="${ctp}/member/memberLogin" class="icon"><i class="far fa-user"></i></a>
      </c:if>
      <c:if test="${!empty sMid}">
     		<a href="javascript:logout()" class="icon" title="Logout"><i class="fa-solid fa-user"></i></a>
     		<a href="${ctp}/member/userPage" class="icon" title="MyPage"><i class="fa-regular fa-file-lines"></i></a>
      </c:if>
      <a href="#" class="icon"><i class="fas fa-map-marker-alt"></i></a>
      <a href="${ctp}/shop/productCartList" class="icon"><i class="fas fa-shopping-bag"></i></a>
    </div>
  </header>
</body>
</html>