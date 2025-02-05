<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Send Message</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <style>
    body {
      background-color: #f8f9fa;
    }
    .form-container {
      margin: 3rem auto;
      max-width: 600px;
      background: white;
      padding: 2rem;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .form-container h1 {
      text-align: center;
      margin-bottom: 2rem;
      font-size: 1.8rem;
      color: #343a40;
    }
    .form-container .form-control {
      border-radius: 6px;
      font-size: 0.95rem;
    }
    .form-container .btn {
      width: 100%;
      margin-top: 1rem;
    }
    .form-container .btn-outline-primary {
      background-color: #007bff;
      color: white;
    }
    .form-container .btn-outline-primary:hover {
      background-color: #0056b3;
      border-color: #0056b3;
    }
  </style>
  <script type="text/javascript">
   'use strict';
   function fCheck() {
      let receiveId = document.getElementById('receiveId').value;
      let title = document.getElementById('title').value;
      let content = document.getElementById('content').value;
      
      if (receiveId.trim() === "") {
        alert("받는 사람 아이디를 입력하세요!");
        document.getElementById('receiveId').focus();
        return;
      }
      if (title.trim() === "") {
        alert("메세지 제목을 입력하세요!");
        document.getElementById('title').focus();
        return;
      }
      if (content.trim() === "") {
        alert("메세지 내용을 입력하세요!");
        document.getElementById('content').focus();
        return;
      }
      document.myform.submit();
    }
  </script>
</head>
<body>
<div class="container">
  <div class="form-container">
    <h1>Send Message</h1>
    <form name="myform" method="post" action="wmInputOk">
      <div class="mb-3">
        <label for="sendId" class="form-label">보내는 사람</label>
        <input type="text" id="sendId" name="sendId" value="${sMid}" readonly class="form-control" />
      </div>
      <div class="mb-3">
        <label for="receiveId" class="form-label">받는 사람</label>
        <input type="text" id="receiveId" name="receiveId" value="${param.receiveId}" class="form-control" />
      </div>
      <div class="mb-3">
        <label for="title" class="form-label">메세지 제목</label>
        <input type="text" id="title" name="title" placeholder="메세지 제목을 입력하세요" class="form-control" />
      </div>
      <div class="mb-3">
        <label for="content" class="form-label">메세지 내용</label>
        <textarea rows="4" id="content" name="content" class="form-control" placeholder="메세지 내용을 입력하세요"></textarea>
      </div>
      <button type="button" onclick="fCheck()" class="btn btn-outline-primary">메세지 전송</button>
      <button type="button" onclick="location.href='webMessage?mSw=';" class="btn btn-warning">돌아가기</button>
      <button type="reset" class="btn btn-outline-danger">다시쓰기</button>
    </form>
  </div>
</div>
</body>
</html>
