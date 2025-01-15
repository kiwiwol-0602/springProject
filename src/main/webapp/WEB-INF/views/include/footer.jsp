<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
<jsp:include page="/WEB-INF/views/include/fonts.jsp" />
  <link rel="stylesheet" type="text/css" href="${ctp}/css/footerStyle.css">
</head>
<body>
	<footer	>
		<div class="row">
			<div class="col left-col">
				<div class="title-link">고객센터</div>
				<div class="input-group contact-info">
					<div class="input-group-append"><font size="3px" class="phone-number"><b>1234-1234</b></font></div>
					<div class="input-group-append pl-2"><font size="3px" class="business-hours">09:00 ~ 18:00</font></div>
				</div>
				<div class="input-group-append info-list">
					<ul>
						<li>평일 : 전체 문의 상담</li>
						<li>토요일, 공휴일 : 그린테리어 직접배송 주문 건 상담</li>
						<li>일요일 : 휴무</li>
					</ul>
				</div>
			</div>
			<div class="col text-left middle-col">
				<div class="title-link">회사정보</div>
				<div><a href="" class="menu-link">회사소개</a></div>
				<div><a href="" class="menu-link">이용약관</a></div>
				<div><a href="" class="menu-link">공지사항</a></div>
				<div><a href="" class="menu-link">개인정보처리방침</a></div>
			</div>
			<div class="col text-left">
				<div class="title-link">이용안내</div>
				<div><a href="" class="menu-link">자주 묻는 질문</a></div>
				<div><a href="" class="menu-link">입점신청</a></div>
				<div><a href="" class="menu-link">제휴/광고문의</a></div>
				<div><a href="" class="menu-link">고객의 소리</a></div>
			</div>
		</div>
		<div class="row foot">
			<div class="col text-left text-white">
				<hr class="footer-hr" width="200%">
				<div>주식회사 그린테리어 | 대표이사 : hm & sy | 주소: 충청북도 청주시 서원구 사직대로 109 4층 | 사업자등록번호 : 123-45-67890 | 이메일: info.grinterior.com</div>	
				<div>&copy; 2024 grinterior. All Rights Reserved.</div>
			</div>
		</div>
	</footer>
</body>
</html>
