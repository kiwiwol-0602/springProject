<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="${ctp}/main/favicon.png">
	<title>마이페이지 | LUMI</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
<style type="text/css">
  body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
  }
  .contain {
      max-width: 900px;
      margin: 11% auto 5% auto;
     background-color: #fff;
      border-radius: 10px;
      padding: 30px;
  }
  .information {
      display: flex;
      align-items: center;
      border-bottom: 1px solid #eee;
      padding-bottom: 15px;
      margin-bottom: 30px;
  }
  .information div {
      font-size: 24px;
      margin-right: 20px;
  }
  .logout {
      margin-left: auto; /* 버튼을 오른쪽으로 밀어내는 핵심 */
      background: transparent;
      border: 2px solid #eee;
      border-radius: 5px;
      padding: 5px 15px;
      color: gray;
      cursor: pointer;
  }
  .logout:hover {
      background-color: #f0f0f0;
  }
  .info-Update {
    position: absolute; /* 부모 요소 기준으로 위치 */
    top: 30px; /* 연락처 텍스트와 수평 정렬 */
    transform: translateY(-50%); /* 수직 중앙 정렬 */
    right: 20px; /* 오른쪽으로 배치 */
    background: transparent;
    text-decoration: underline;
    color: black;
    font-size: 16px;
    cursor: pointer;
	}
  .info-Update:hover {
      color: black;
  }
  .user-information {
      display: flex;
      margin-bottom: 30px;
  }
  .user {
    border: 1px solid #eee;
    padding: 20px;
    text-align: left;
    display: flex;
  	flex-direction: column;
  }
  .tabs {
    display: flex;
  }
  .tab {
      flex: 1;
      text-align: center;
      border: 1px solid #eee;
      color: black;
  }
  .tab a{
  	color: black;
  	padding: 20px;
  	text-decoration: none;
  }
  .tab a:hover{
  	color: black;
  	text-decoration: none;
  }
  .tab:hover{
  	background: #eee;
  }
  .section {
    margin-bottom: 20px;
  }
  .section a {
    width: 100%;
    border: 1px solid #eee;
    border-radius: 10px;
		font-size: 20px;
    display: block;
    text-decoration: none;
    margin: 5px 0;
    color: black;
    padding: 30px;
  }
  .section a:hover {
    background: #eee;
    text-decoration: none;
    color: black;  
  }
  .user-details {
    flex-direction: column;
  }
  .user-title{
  	color: gray;
  }
  .user-info{
  	font-size: 18px;
  	font-weight: bold;
  }
  .section-title{
  	font-size: 30px;
  	font-weight: bold;
  	margin: 20px;
  }
  .Name{
  	font-size: 30px;
  	font-weight: bold; 
  }
  .Id{
  	font-size: 20px;
  	color: gray;
  }
  .MemberDelete{
  	color: gray;
  	text-decoration: underline;
  	float: right;
  }
  .MemberDelete:hover{
  	color: gray;
  	text-decoration: underline;
  }
</style>
<script type="text/javascript">
	function memberDelete() {
		let ans = confirm("탈퇴하시겠습니까?");
	  if(ans) {
		  $.ajax({
			  type : "post",
			  url  : "${ctp}/member/memberDelete",
			  success:function(res) {
				  if(res != "0") {
					  alert("탈퇴신청이 완료되었습니다.\n로그아웃 처리 됩니다.");
					  location.href = '${ctp}/main';
				  }
				  else alert("회원 탈퇴신청에 실패하셨습니다.\n확인 후 다시 시도 하세요");
			  },
			  error : function() {
				  alert("전송오류");
			  }
		  });
	  }
	}
</script>
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false" onkeydownn="return false">
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="contain">
	<div class="information">
    <div class="user-details">
        <div class="Name">${vo.name}</div>
        <div class="Id">${vo.mid}</div>
    </div>
    <c:if test="${sLevel != 0}"><button onclick="location.href='${ctp}/member/memberLogout'" class="logout">로그아웃</button></c:if>
    <c:if test="${sLevel == 0}"><button onclick="location.href='${ctp}/admin/admin'" class="logout">관리자</button></c:if>
	</div>


  
  <div class="user-information">
		<div class="user" style="width: 60%;">
	  	<div class="user-title">주소</div>
	  	<div class="user-info">${fn : replace(vo.address, '/', ' ')}</div>
	  </div>
	  
		<div class="user" style="width: 40%; position: relative;">
	    <div class="user-title">연락처</div>
	    <div class="user-info">${vo.tel}</div>
    	<a href="${ctp}/member/memberUpdate" class="info-Update">내 정보 수정</a>
	  </div>
  </div>
  
  <div style="margin-bottom: 100px;" class="input-group">
		<div class="tab">
			<a href="${ctp}/shop/couponPage">
		  	<p class="talTitle">쿠폰</p>
		  	<div class="talContent">${couponCnt}</div>
	  	</a>
	  </div>
		<div class="tab">
	    <a href="${ctp}/shop/productCartList">
		  	<p class="talTitle">장바구니</p>
		  	<div class="talContent">${cartCnt}</div>
	  	</a>
	  </div>
		<div class="tab">
	    <a href="${ctp}/shop/orderList">
		  	<p class="talTitle">구매 내역</p>
		  	<div class="talContent">${recentoOrderCnt}(${orderListCnt})</div>
	  	</a>
	  </div>
  </div>
  
  <div class="section-title">나의 문의</div>
  <div class="section">
    <a href="#"><i class="fa-regular fa-newspaper"></i> 상담 신청 현황</a>
    <a href="#"><i class="fa-regular fa-newspaper"></i> 상품 문의 현황</a>
  </div>
  <div class="section-title">나의 쇼핑</div>
  <div class="section">
    <a href="#"><i class="fa-solid fa-heart"></i> 관심 목록</a>
    <a href="#"><i class="fa-solid fa-magnifying-glass"></i> 최근 본 내역</a>
    <a href="#"><i class="fa-regular fa-newspaper"></i> 나의 후기</a>
  </div>
  <a href="javascript:memberDelete()" class="MemberDelete">회원탈퇴</a>
</div>
<footer>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</footer>
</body>
</html>