<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Send Message</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <style>
    body {
      background-color: #f8f9fa;
      font-family: 'Helvetica Neue', Arial, sans-serif;
    }
    .form-container {
      margin: 3rem auto;
      max-width: 500px;
      background: white;
      padding: 2.5rem;
      border-radius: 15px;
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
      animation: fadeIn 0.6s ease-in-out;
    }
    @keyframes fadeIn {
      from { opacity: 0; transform: translateY(20px); }
      to { opacity: 1; transform: translateY(0); }
    }
    .form-container h1 {
      text-align: center;
      margin-bottom: 2rem;
      font-size: 2rem;
      color: #343a40;
      font-weight: 600;
    }
    .form-container .form-control {
      border-radius: 8px;
      font-size: 1rem;
      padding: 0.8rem;
      transition: all 0.3s ease-in-out;
    }
    .form-container .form-control:focus {
      box-shadow: 0 0 10px rgba(0, 123, 255, 0.3);
      border-color: #007bff;
    }
    .form-container .btn {
      width: 100%;
      margin-top: 1rem;
      font-size: 1rem;
      padding: 0.8rem;
      transition: background-color 0.3s ease;
      border-radius: 10px;
    }
    .form-container .btn-outline-primary {
      background-color: #007bff;
      color: white;
    }
    .form-container .btn-outline-primary:hover {
      background-color: #0056b3;
      border-color: #0056b3;
    }
    .form-container .btn-warning {
      background-color: #ffc107;
      color: #212529;
      border-radius: 10px;
    }
    .form-container .btn-warning:hover {
      background-color: #e0a800;
    }
    .form-container .btn-outline-danger {
      background-color: #dc3545;
      color: white;
    }
    .form-container .btn-outline-danger:hover {
      background-color: #c82333;
    }
    .form-label {
      font-size: 1rem;
      color: #495057;
    }
    textarea.form-control {
      resize: none;
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
<div class="wmContainer">
  <div class="form-container">
    <h1>메세지 전송</h1>
    <form name="myform" method="post" action="${ctp}/webMessage/wmInputOk">
      <div class="mb-3">
        <label for="sendId" class="form-label">보내는 사람</label>
        <input type="text" id="sendId" name="sendId" value="${sMid}" readonly class="form-control" />
      </div>
      <div class="mb-3">
        <label for="receiveId" class="form-label">받는 사람</label>
        <input type="text" id="receiveId" name="receiveId" value="admin" readonly class="form-control" />
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
