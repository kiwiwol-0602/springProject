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
  <link rel="icon" href="${ctp}/main/favicon.png">
	<title>
		<c:if test="${categoryName eq 'mainName'}">${categorySuvVO.mainName}</c:if>
		<c:if test="${categoryName eq 'baseName'}">${categorySuvVO.baseName}</c:if>
		<c:if test="${categoryName eq 'subName'}">${categorySuvVO.subName}</c:if>
	 	| LUMI
	 </title>
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
			justify-content: flex-start;
			gap: 10px;
			width: 100%;
  	}
  	.mainList .container .itemList .card{
  		display: flex;
      flex-direction: column;
      border: 1px solid white;
/*       border: 1px solid #eee; */
      width: 280px; /* 4개씩 배치 */
   		height: 385px;
  		/*height: 420px;*/
  		position: relative;
  	}
	 .mainList .container .itemList .card:hover {
  		border: 1px solid #eee;
  		border-radius: 0;
    }
    .mainList .container .itemList .card .img {
		  display: flex;
		  justify-content: center; /* 수평 가운데 정렬 */
		  width: 100%;
		  height: 250px; /* 카드 높이에 맞게 이미지 영역 설정 */
		}
  	.mainList .container .itemList .card img{
  		padding-top: 15px;
  		width: 90%;
  		height: 250px;
  	}
  	.mainList .container .itemList .card .text {
      padding: 10px;
      text-align: center;
      justify-content: center;
      width: 100%;
    }

    .mainList .container .itemList .card .text h2 {
      font-size: 1.1rem;
      font-weight: bold;
      margin: 0;
      color: #333;
      padding: 0 10%;
      height: 30px;
    }
  	.mainList .container .itemList .card .text p{
  		font-size: 1.2rem;
  		font-size: 16px;
  		opacity: .8;
  		margin-top: 10px;
  		margin-bottom: 5px;;
  		padding: 0 10%;
  	}
  	.mainList .container .itemList .card .text button{
  		background-color: black;
  		color: white;
  		border: 2px solid white;
  		border-radius: 0;
  		padding: 10px 20px;
  		width: 90%;
  		font-size: 10px;
  		transition: .5s ease;
		  opacity: 0;
  		visibility: hidden;
  	}
  	/* 카드에 마우스 호버시 버튼 보이기 */
		.mainList .container .itemList .card:hover .text button {
		  opacity: 1;
		  visibility: visible;
		}
  	.mainList .container .itemList .card .text button:hover{
  		background: transparent;
  		color: black;
  		border: 2px solid black;
  		transition: .5s ease;
  	}

		  h6 {
			position: fixed;
			right: 1rem;
			bottom: -100px;
			transition: 0.7s ease;
		}
		h6.on {
			opacity: 0.8;
			cursor: pointer;
			bottom: 15px;
			z-index: 10;
		}	
		  	
  	
  	
  </style>
  <script type="text/javascript">
  $(window).scroll(function(){
	  if($(this).scrollTop() > 100){
	     $("#topBtn").addClass("on");
	  }
	  else{
	     $("#topBtn").removeClass("on");
	  }
	  $("#topBtn").click(function() {
				window.scrollTo({top:0, behavior: "smooth"});	
			});
		});
		
			$(window).scroll(function(){
			  if($(this).scrollTop() > 300){
			     $("#mainSidebar").addClass("on");
			  }
			  else{
			     $("#mainSidebar").removeClass("on");
			  }
			});
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
					<a href="${ctp}/shop/productContent?idx=${vo.idx}" style="text-decoration: none;">
						<div class="card">
							<div class="img">
								<img src="${ctp}/product/${vo.thumbnail}">
							</div>
							<div class="text">
								<h2 style="font-size: 15px;">${vo.productName}</h2>
								<p><fmt:formatNumber value="${vo.price}" type="number" groupingUsed="true" /> 원</p>
								<button>구매하기</button>
								<!-- <button>장바구니</button> -->
							</div>
						</div>
					</a>
				</c:forEach>
			</div>
		</div>
	</section>
	
	<!-- 위로가기 버튼 -->
	  <h6 id="topBtn" class="text-right mr-3"><font color="#af9e84"><i class="fa-solid fa-circle-chevron-up fa-2x"></i></font></h6>
	  
	<footer>
	<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
</footer>
</body>
</html>