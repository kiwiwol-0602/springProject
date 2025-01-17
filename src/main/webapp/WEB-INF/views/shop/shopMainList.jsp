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
	<title>상품페이지 | LUMI</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<jsp:include page="/WEB-INF/views/include/fonts.jsp" />
  <style type="text/css">
  	.mainList {
  		margin: 10% 0 0 0;
  	}
  	.mainList .container {
  		max-width: 78%;
  		margin: auto;
  	}
  	.mainList .container .channel{
  		margin: 20px 0;
  		font-size: 20px;
  		color: #102770;
  		font-family: 'GowunDodum-Regular';
  	}
  	.mainList .container .title img {
  		width: 100%;
  		height: 600px;
  		object-fit: cover;
  	}
  	
  	.mainList .container .titleImg::before {
  		content: '';
  		position: absolute;
  		top: 25%;
  		left: 11.6%;
  		width: 76.8%;
  		height: 600px;
  		background-color: rgba(0, 0, 0, 0.5);
  		z-index: 1;
  	}
  	 
  	.mainList .container .title h1 {
  		position: absolute;
  		top: 50%;
  		left: 50%;
  		transform: translate(-50%, -50%);
  		color: white;
  		z-index: 2; 
  		font-size: 48px;
  		font-weight: bold;
  	}
  	
  	.mainList .container .title ul {
  		padding-left: 0;
  		list-style: none;
  		margin-top: 30px;
  		text-align: center;
  	}
  	.mainList .container .title ul li{
  		display: inline;
  		margin: 15px 30px 15px 0;
  		font-size: 18px;
  	}
  	.mainList .container .title ul li a{
			text-decoration: none;
			color: #444;
  	}
  	.mainList .container .title ul li a:hover{
			text-decoration: none;
			color: #000B58;
			font-weight: bold;
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
	  'use strict'
		var ctp = '${ctp}';
		function selectCategory(categoryName, category) {
			location.href = ctp+'/shop/shopMainList?categoryName='+categoryName+'&category='+category;
		}
  </script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<section class="mainList">
		<div class="container">
			<div class="channel">
				<div>
					<c:if test="${categoryName eq 'mainName'}">Home > ${categorySuvVO.mainName}</c:if>
					<c:if test="${categoryName eq 'baseName'}">Home > ${categorySuvVO.mainName} > ${categorySuvVO.baseName}</c:if>
					<c:if test="${categoryName eq 'subName'}">Home > ${categorySuvVO.mainName} > ${categorySuvVO.baseName} > ${categorySuvVO.subName}</c:if>
				</div>
			</div>
			<div class="title">
				<c:if test="${!(categoryName eq 'subName')}">
					<div class="titleImg">
						<c:set var="categoryPhoto" value="${fn:replace(category,' ','')}"/>
						<img src="${ctp}/shop/${categoryName}/${categoryPhoto}.jpg">
					</div>
					<h1>${category}</h1>
				</c:if>
				<div>
					<input type="button" value="상품등록" onclick="location.href='${ctp}/shop/productInput'">
				</div>
				<ul class="category-list">
					<c:forEach var="csVOS" items="${categorySubVOS}">
						<c:if test="${categoryName eq 'mainName'}">
							<li class="main-category"><a href="javascript:selectCategory('baseName','${csVOS.baseName}','${csVOS.mainName}')">${csVOS.baseName}</a></li>
						</c:if>
						<c:if test="${categoryName eq 'baseName'}">
							<li class="sub-category"><a href="javascript:selectCategory('subName','${csVOS.subName}','${csVOS.baseName}')">${csVOS.subName}</a></li>
						</c:if>
					</c:forEach>
				</ul>
				<hr/>
			</div>
			<div class="itemList">
				<c:forEach var="vo" items="${vos}">
					<a href="${ctp}/shop/productContent?idx=${vo.idx}">
						<div class="card">
							<div class="img">
								<img src="${ctp}/shop/${vo.thumbnail}">
							</div>
							<div class="text">
								<h2 style="font-size: 15px;">${vo.productName}</h2>
								<p>${vo.price}</p>
								<button><i class="fas fa-check"></i>구매하기</button>
							</div>
						</div>
					</a>
				</c:forEach>
			</div>
		</div>
	</section>
</body>
</html>