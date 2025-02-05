<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>webMessage.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <jsp:include page="/WEB-INF/views/include/fonts.jsp" />
  <style>
    body {
      width: 100%;
      background-color: #f8f9fa;
      font-family: 'Pretendard', sans-serif;
    }

    .webMessage {
      width: 90%;
      max-width: 1200px;
      margin: 10% auto 5% auto;
      padding: 20px;
      background: white;
      border-radius: 12px;
      box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
    }

    .message-container {
      display: flex;
      flex-wrap: wrap;
      gap: 20px;
    }

    #leftWindow {
      flex: 1;
      min-width: 250px;
      max-width: 300px;
      height: 600px;
      text-align: center;
      background-color: #343a40;
      color: white;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
      overflow: auto;
    }

    #leftWindow p a {
      display: block;
      padding: 12px;
      color: #ffffff;
      background: #495057;
      margin: 10px 0;
      border-radius: 8px;
      text-decoration: none;
      transition: 0.3s;
    }

    #leftWindow p a:hover {
      background: #6c757d;
    }

    #rightWindow {
      flex: 3;
      min-width: 400px;
      height: 600px;
      text-align: center;
      background-color: #ffffff;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
      overflow: auto;
    }

    h3 {
      text-align: center;
      color: #343a40;
      font-weight: bold;
      margin-bottom: 20px;
    }

    #footerMargin {
      clear: both;
      margin-top: 20px;
    }

    @media (max-width: 768px) {
      .message-container {
        flex-direction: column;
      }
      #leftWindow, #rightWindow {
        width: 100%;
        height: auto;
      }
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
<p><br/></p>

<div class="webMessage">
  <div class="message-container">
    <div id="leftWindow">
      <p><br/></p>
      <p><a href="webMessage?mSw=0">메세지 작성</a></p>
      <p><a href="webMessage?mSw=1&mFlag=1">받은 메세지</a></p>
      <p><a href="webMessage?mSw=2&mFlag=2">새 메세지</a></p>
      <p><a href="webMessage?mSw=3&mFlag=3">보낸 메세지</a></p>
      <p><a href="webMessage?mSw=4&mFlag=4">수신 확인</a></p>
      <p><a href="webMessage?mSw=5&mFlag=5">휴지통</a></p>
    </div>
    
    <div id="rightWindow">
      <p>
        <c:if test="${mSw == 0}">
          <jsp:include page="wmInput.jsp" />
        </c:if>
        <c:if test="${mSw == 1}">
          <h3>받은 메세지</h3>
          <jsp:include page="wmList.jsp" />
        </c:if>
        <c:if test="${mSw == 2}">
          <h3>새 메세지</h3>
          <jsp:include page="wmList.jsp" />
        </c:if>
        <c:if test="${mSw == 3}">
          <h3>보낸 메세지</h3>
          <jsp:include page="wmList.jsp" />
        </c:if>
        <c:if test="${mSw == 4}">
          <h3>수신 확인</h3>
          <jsp:include page="wmList.jsp" />
        </c:if>
        <c:if test="${mSw == 5}">
          <h3>휴지통</h3>
          <jsp:include page="wmList.jsp" />
        </c:if>
        <c:if test="${mSw == 6}">
          <h3>메세지 내용보기</h3>
          <jsp:include page="wmContent.jsp" />
        </c:if>
      </p>
    </div>
  </div>
</div>

<footer style="width: 100%">
  <jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</footer>
</body>
</html>
