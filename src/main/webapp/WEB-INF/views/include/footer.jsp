<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<jsp:include page="/WEB-INF/views/include/fonts.jsp" />
  <link rel="stylesheet" type="text/css" href="${ctp}/css/footer.css">
</head>
		<div class="footer-content">
		<div class="row">
			<hr/>
			<div class="col left-col" >
				<div class="title-link mt-2">고객서비스</div>
				<div class="input-group contact-info">
					<div class="input-group-append"><font size="3px" class="phone-number"><b>1234-1234</b></font></div>
					<div class="input-group-append pl-2"><font size="3px" class="business-hours">&nbsp; 09:00 ~ 18:00</font></div>
				</div>
				<div class="input-group-append info-list">
					<ul>
						<li>전체 문의 상담</li>
						<li>부티크 찾기</li>
						<li>방문예약</li>
					</ul>
				</div>
			</div>
			<div class="col text-left middle-col">
				<div class="title-link  mt-2 mb-2">회사정보</div>
				<div><a href="" class="menu-link">이용약관</a></div>
				<div><a href="" class="menu-link">공지사항</a></div>
				<div><a href="" class="menu-link">개인정보처리방침</a></div>
			</div>
			<div class="col text-left">
				<div class="title-link mt-2 mb-2">이용안내</div>
				<div><a href="" class="menu-link">자주 묻는 질문</a></div>
				<div><a href="" class="menu-link">입점신청</a></div>
				<div><a href="" class="menu-link">제휴/광고문의</a></div>
				<div><a href="" class="menu-link">고객의 소리</a></div>
			</div>
		</div>
		<div class="row foot">
			<div class="col text-center text-gray">
				<hr/><br/>
				<div>(주) LUMI | 대표이사 : sy | 주소: 충청북도 청주시 서원구 사직대로 109 4층 | 사업자등록번호 : 123-45-67890 | 이메일: info.grinterior.com</div>	
				<div> 개인정보보호책임자: 한소연 호스팅 서비스: Soyeon International HSY | 통신판매 신고번호: 2025-청주-1234</div>	
				<div>&copy; 2025 LUMI. All Rights Reserved.</div>
				<div>GREEN에서 제공하는 구매안전 서비스에 가입하여 안전한 거래를 보장하고 있습니다.</div>
			</div>
		</div>
		</div>
</html>
