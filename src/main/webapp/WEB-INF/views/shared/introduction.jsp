<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="ctp/main/favicon.png">
	<title>상품페이지 | LUMI</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<jsp:include page="/WEB-INF/views/include/fonts.jsp" />
	<style>
        .introductionContainer {
            font-family: Arial, sans-serif;
            background-color: white;
            color: #333;
            margin: 0;
            padding: 0;
            padding: 40px;
            width: 100%;
            margin: 11% auto 8% auto;
            text-align: center;
        }
        .introductionContainer .title {
            text-align: center;
				   	font-size: 30px;
				   	margin-top: 2%;
        }
        .introductionContainer .intro {
            text-align: center;
            margin-bottom: 40px;
        }
        .introductionContainer .features {
            display: flex;
            justify-content: space-around;
        }
        .introductionContainer .feature-box {
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            width: 30%;
            text-align: center;
        }
        .introductionContainer .feature-box h3 {
            margin-bottom: 10px;
        }
        .introductionContainer .subtitle {
            text-align: center;
            padding: 20px;
            background-color: #333;
            color: white;
            margin-top: 40px;
        }
        .introductionContainer a {
            color: #ff4081;
            text-decoration: none;
        }
        .introductionContainer .solid {
			    font-size: 2.5rem;
			    font-weight: bold;
			    line-height: 2.5rem;
			    text-align: center;
			    color: #333;
			  }
			  .introductionContainer .image-container {
			  		position: relative;
            width: 80%;
            height: 600px;
            overflow: hidden;
            margin: 5% auto;
        }
        .introductionContainer .image {
            width: 100%;
            height:	600px;
            border-radius: 0px;
        }
        .introductionContainer .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5); /* 검정색 반투명 오버레이 */
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            color: white;
            font-size: 40px;
            border-radius: 0px;
        }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<div class="introductionContainer">
		<span class="solid">—</span>
  	<div class="title">
    	<div style="font-family: 'SF_HambakSnow';">Store information & Contact</div>
    </div>

    <div class="intro" style="font-family: 'Gyeonggi_Batang_Regular';">
	    <div class="image-container">
	      <img class="image" src="${ctp}/images/main/introduction.png" alt="introduction">
		    <div class="overlay">
		    	<div style="font-size: 30px;">The heritage since 2025</div><br/>
		    	<div>"사랑하는 사람은 닮아간다"</div>
		    	<div>감성과 과학이 어우러진 스토리텔링 주얼리</div>
		    </div>
	    </div>
	    <div style="font-size: 30px;">
	    	<p>루미, 하이엔드 주얼리의 세계로 초대</p><br/><br/>
	      <p>우리는 당신의 일상을 더욱 빛나게 해 줄 특별한 주얼리들을 제공합니다.</p>
	      <p>다양한 디자인과 트렌디한 컬렉션을 지금 바로 확인해 보세요.</p>
	    </div>
    </div>
			<div id="map" style="width:50%; height:500px; text-align: center; margin: 3% auto 0 auto;" ></div>
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey="></script>
			<script>
				var container = document.getElementById('map');
				var options = {
					center: new kakao.maps.LatLng(36.6351715371822, 127.45954114907293),
					//draggable: false,
					level: 2
				};
		
				var map = new kakao.maps.Map(container, options);
				// 마커가 표시될 위치입니다 
				var markerPosition  = new kakao.maps.LatLng(36.6351715371822, 127.45954114907293); 
		
				// 마커를 생성합니다
				var marker = new kakao.maps.Marker({
				    position: markerPosition
				});
		
				// 마커가 지도 위에 표시되도록 설정합니다
				marker.setMap(map);
			</script>
			<div style="font-size: 18px; font-family: 'Gyeonggi_Batang_Regular'; margin-top: 2%;">
	    	<div style="font-weight: bold; font-size: 22px; margin-bottom: 1%">LUMI 청주점</div>
	      <div style="margin-bottom: 15px;">충북 청주시 서원구 사직대로 109 4층</div>
	      <div style="margin-bottom: 15px;">Tell. 043-123-4567</div>
	      <div>-오픈시간-</div>
	      <div style="font-size: 17px;">
		      <div >10am - 8pm, 수요일 부터 월요일</div>
		      <div style="color: red;">화요일 휴무</div>
	      </div>
	    </div>
  </div>
	<footer>
		<jsp:include page="/WEB-INF/views/include/footer.jsp"/>
	</footer>
</body>
</html>