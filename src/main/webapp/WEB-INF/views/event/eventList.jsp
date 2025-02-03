<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="ctp/main/favicon.png">
	<title>이벤트 | LUMI</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<jsp:include page="/WEB-INF/views/include/fonts.jsp" />
  <style>
	  body {
	    font-family: Arial, sans-serif;
	    margin: 0;
	    padding: 0;
	    background-color: #f4f4f4;
		}
		
		.eventListContainer {
	    width: 80%;
	    margin: 20px auto;
	    background-color: white;
	    margin-top: 10%;
	    padding: 50px 40px;
		}
		
		h2 {
	    text-align: center;
	    color: #333;
		}
		
		/* 그리드 레이아웃 스타일 */
		.eventGrid {
	    display: grid;
	    grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
	    gap: 20px;
	    margin-top: 30px;
		}
		
		.eventCard {
	    background-color: #fff;
	    border: 1px solid #ddd;
	    border-radius: 10px;
	    overflow: hidden;
	    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	    transition: box-shadow 0.3s ease;
		}
		
		.eventCard:hover {
	    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
		}
		
		.eventCard img {
	    width: 100%;
	    height: 200px;
	    object-fit: cover;
		}
		
		.eventCardContent {
	    padding: 20px;
	    text-align: center;
		}
		
		.eventCardContent h3 {
	    font-size: 18px;
	    margin-bottom: 10px;
	    color: #333;
		}
		
		.eventCardContent p {
	    font-size: 14px;
	    color: #666;
		}
		
		.eventCardContent .eventDate {
	    margin-top: 10px;
	    font-size: 12px;
	    color: #999;
		}
		
		.eventCardContent .btn-detail {
	    display: inline-block;
	    margin-top: 15px;
	    padding: 10px 20px;
	    background-color: #006A67;
	    color: white;
	    text-decoration: none;
	    border-radius: 5px;
		}
		
		.eventCardContent .btn-detail:hover {
	    background-color: #004f4e;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<div class="eventListContainer">
	<h2>진행 중인 이벤트</h2>
	<!-- 이벤트 그리드 -->
	<div class="eventGrid">
		<c:forEach var="vo" items="${vos}">
			<div class="eventCard">
				<img src="${ctp}/event/${vo.thumbnail}" alt="${vo.title} 썸네일">
				<div class="eventCardContent">
					<h3>${vo.title}</h3>
					<p>${vo.subTitle}</p>
					<p class="eventDate">${fn:substring(vo.startDate, 0, 10)} ~ ${fn:substring(vo.endDate, 0, 10)}</p>
					<a href="${ctp}/event/eventContent?idx=${vo.idx}" class="btn-detail">자세히 보기</a>
				</div>
			</div>
		</c:forEach>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</body>
</html>