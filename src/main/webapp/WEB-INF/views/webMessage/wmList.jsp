<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>wmList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script type="text/javascript">
  	'use strict'
  	setTimeout("location.reload()", 1000*10);
  </script>
  </head>
<body>
<p><br/></p>
<div class="container">
  <table class="table table-hover">
    <tr class="table-secondary">
      <th>번호</th>
      <th>
        <c:if test="${mSw==1 || mSw==2 || mSw==5}">보낸사람</c:if>
        <c:if test="${mSw==3 || mSw==4}">받은사람</c:if>
      </th>
      <th>제목</th>
      <th>
        보낸/확인(날짜)
      </th>
    </tr>
    <c:set var="curScrStartNo" value="${fn:length(vos)}"/>
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <tr>
        <td>${curScrStartNo}</td>
        <td>
          <c:if test="${mSw==1 || mSw==2 || mSw==5}">${vo.sendId}</c:if>
          <c:if test="${mSw==3 || mSw==4}">${vo.receiveId}</c:if>
        </td>
        <td class="text-start">
          <a href="webMessage?mSw=6&mFlag=${param.mSw}&idx=${vo.idx}" class="text-dark link-primary link-underline-opacity-0 link-underline-opacity-75-hover">${vo.title}</a>
          <c:if test="${vo.receiveSw=='n'}"><img src="${ctp}/images/new.gif"/></c:if>
        </td>
        <td>
          <c:if test="${mSw==1 || mSw==2 || mSw==5}">${fn:substring(vo.sendDate,0,19)}</c:if>
          <c:if test="${mSw==3 || mSw==4}">${fn:substring(vo.receiveDate,0,19)}</c:if>
        </td>
      </tr>
      <c:set var="curScrStartNo" value="${curScrStartNo - 1}"/>
    </c:forEach>
  </table>
</div>
<p><br/></p>
</body>
</html>