<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
<jsp:include page="/WEB-INF/views/include/fonts.jsp" />

<style type="text/css">
  	.logo{
  	display: flex;
		font-size: 20px;
		text-align:center;
		color: black;
		font-family: '116watermelon';
		padding: 30px;
		text-decoration: none;
		justify-content: center;  /* 수평 중앙 배치 */
    align-items: center;      /* 수직 중앙 배치 */
    width: 100%;
	}
	.logo a{
		color: black;
		text-decoration: none;
	}
	.logo a:hover{
		color: black;
		text-decoration: none;
	}
</style>

  <!-- Sidebar/menu -->
<nav class="w3-sidebar w3-collapse w3-white w3-animate-left" style="z-index:3; width:300px;" id="mySidebar"><br>
	<span class="logo"><a href="${ctp}/admin/admin" target="_top">LUMI</a></span>
  <div class="w3-container w3-row">
    <div class="w3-col s4">
      <img src="/w3images/avatar2.png" class="w3-circle w3-margin-right" style="width:46px">
    </div>
    <div class="w3-col s8 w3-bar">
      <span>Welcome, <strong>Mike</strong></span><br>
      <a href="#" class="w3-bar-item w3-button"><i class="fa fa-envelope"></i></a>
      <a href="#" class="w3-bar-item w3-button"><i class="fa fa-user"></i></a>
      <a href="#" class="w3-bar-item w3-button"><i class="fa fa-cog"></i></a>
    </div>
  </div>
  <hr>
  <div class="w3-container">
    <h5>Dashboard</h5>
  </div>
	<div class="w3-bar-block">
	  <a href="#" class="w3-bar-item w3-button w3-hide-large w3-dark-grey w3-hover-black" style="padding: 10px 30px;" onclick="w3_close()" title="close menu" style="padding: 10px 30px;"><i class="fa fa-remove fa-fw"></i> Close Menu</a>
	  <a href="${ctp}/admin/userList" class="w3-bar-item w3-button" style="padding: 10px 30px;"><i class="fa fa-users"></i> user</a>
	  <a href="#" class="w3-bar-item w3-button" style="padding: 10px 30px;"><i class="fa fa-eye fa-fw"></i> Views</a>
	  <a href="#" class="w3-bar-item w3-button" style="padding: 10px 30px;"><i class="fa fa-users fa-fw"></i> Traffic</a>
	  <a href="#" class="w3-bar-item w3-button" style="padding: 10px 30px;"><i class="fa fa-bullseye fa-fw"></i> Geo</a>
	  <a href="#" class="w3-bar-item w3-button" style="padding: 10px 30px;"><i class="fa fa-diamond fa-fw"></i> Orders</a>
	  <a href="#" class="w3-bar-item w3-button" style="padding: 10px 30px;"><i class="fa fa-bell fa-fw"></i> News</a>
	  <a href="#" class="w3-bar-item w3-button" style="padding: 10px 30px;"><i class="fa fa-bank fa-fw"></i> General</a>
	  <a href="#" class="w3-bar-item w3-button" style="padding: 10px 30px;"><i class="fa fa-history fa-fw"></i> History</a>
	  <a href="#" class="w3-bar-item w3-button" style="padding: 10px 30px;"><i class="fa fa-cog fa-fw"></i> Settings</a><br><br>
	  <a href="${ctp}/main" class="w3-bar-item w3-button" style="padding: 10px 30px;"><i class="fa fa-cog fa-fw"></i> exit</a><br><br>
	</div>

</nav>


<!-- Overlay effect when opening sidebar on small screens -->
<div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>

<script>
// Get the Sidebar
var mySidebar = document.getElementById("mySidebar");

// Get the DIV with overlay effect
var overlayBg = document.getElementById("myOverlay");


// Close the sidebar with the close button
function w3_close() {
  mySidebar.style.display = "none";
  overlayBg.style.display = "none";
}
</script>
