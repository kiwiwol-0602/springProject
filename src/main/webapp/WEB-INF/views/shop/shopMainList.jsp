<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="${ctp}/main/favicon.png">
	<title>상품페이지 | LUMI</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <style type="text/css">
  	.mainList {
  		margin: 10% 0 0 0;
  	}
  	.mainList .container {
  		max-width: 70%;
  		margin: auto;
  	}
  	.mainList .container .title img {
  		width: 100%;
  		height: 500px;
  		
  	}
  	.mainList .container .title ul {
  		padding-left: 0;
  		list-style: none;
  	}
  	.mainList .container .title ul li{
  		display: inline;
  		margin-right: 30px;
  	}
  	.mainList .container .title ul li a{
			text-decoration: none;
			color: #444;
  	}
  	
  	.mainList .container .itemList{
			display: flex;
			flex-wrap: wrap;
			justify-content: space-between;
  	}
  	.mainList .container .itemList .card{
  		border: 1px solid #eee;
  		border-radius: 5px;
  		height: 350px;
  		width: 250px;
  		padding: 5px;
  		margin-bottom: 10px;
  	}
  	.mainList .container .itemList .card img{
  		height: 200;
  		width: 250px;
  	}
  	.mainList .container .itemList .card .text p{
  		font-size: 14px;
  		opacity: .8;
  	}
  	.mainList .container .itemList .card .text button{
  		background-color: black;
  		color: white;
  		border: 2px solid white;
  		border-radius: 5px;
  		padding: 5px 10px;
  		font-size: 10px;
  		transition: .5s ease;
  	}
  	.mainList .container .itemList .card .text button:hover{
  		background: transparent;
  		color: black;
  		border: 2px solid black;
  		transition: .5s ease;
  	}
  	
  	
  	
  	
  </style>
  <script type="text/javascript">
  
  </script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<section class="mainList">
		<div class="container">
			<div class="title">
				<div class="titleImg">
					<img src="${ctp}/shop/Bracelets.png">
				</div>
				<h1>LIST</h1>
					<ul>
						<li><a href="#">item</a></li>
						<li><a href="#">item</a></li>
						<li><a href="#">item</a></li>
						<li><a href="#">item</a></li>
						<li><a href="#">item</a></li>
					</ul>
			</div>
			<div class="itemList">
				<div class="card">
					<div class="img">
						<img src="${ctp}/shop/ring1.png">
					</div>
					<div class="text">
						<h2>Ring</h2>
						<p>상품명</p>
						<p>가격</p>
						<button><i class="fas fa-check"></i>구매하기</button>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>