<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<jsp:include page="/WEB-INF/views/include/fonts.jsp" />
  <link rel="stylesheet" type="text/css" href="${ctp}/css/footerStyle.css">
   
</head>
<body>
	<footer	>
		<div class="footer">
			<div class="bubbles">
			    <%-- Bubble 생성 스크립트 --%>
			    <script>
			        for (var i = 0; i < 128; i++) {
			            var size = 2 + Math.random() * 4;
			            var distance = 6 + Math.random() * 4;
			            var position = -5 + Math.random() * 110;
			            var time = 2 + Math.random() * 2;
			            var delay = -(2 + Math.random() * 2);
			            var bubble = document.createElement('div');
			            bubble.classList.add('bubble');
			            bubble.style.setProperty('--size', size + 'rem');
			            bubble.style.setProperty('--distance', distance + 'rem');
			            bubble.style.setProperty('--position', position + '%');
			            bubble.style.setProperty('--time', time + 's');
			            bubble.style.setProperty('--delay', delay + 's');
			            document.querySelector('.bubbles').appendChild(bubble);
			        }
			    </script>
			</div>
			<div class="content">
			    <div>
			        <b>Eldew</b>
			        <a href="#">Secuce</a>
			        <a href="#">Drupand</a>
			        <a href="#">Oceash</a>
			        <a href="#">Ugefe</a>
			        <a href="#">Babed</a>
			    </div>
			    <br/>
			    <div>
			        <b>Spotha</b>
			        <a href="#">Miskasa</a>
			        <a href="#">Agithe</a>
			        <a href="#">Scesha</a>
			        <a href="#">Lulle</a>
			    </div>
			    <br/>
			    <div>
			        <b>Chashakib</b>
			        <a href="#">Chogauw</a>
			        <a href="#">Phachuled</a>
			        <a href="#">Tiebeft</a>
			        <a href="#">Ocid</a>
			        <a href="#">Izom</a>
			        <a href="#">Ort</a>
			    </div>
			    <div>
			        <b>Athod</b>
			        <a href="#">Pamuz</a>
			        <a href="#">Vapert</a>
			        <a href="#">Neesk</a>
			        <a href="#">Omemanen</a>
			    </div>
			    <br/>
			    <div>
			        <a class="image" href="https://codepen.io/z-" target="_blank" style="background-image: url('https://s3-us-west-2.amazonaws.com/s.cdpn.io/199011/happy.svg')"></a>
			            <p>©2019 Not Really</p>
			        </div>
			    </div>
			</div>

    <svg>
        <defs>
            <filter id="blob">
                <feGaussianBlur in="SourceGraphic" stdDeviation="10" result="blur" />
                <feColorMatrix in="blur" mode="matrix" values="1 0 0 0 0  0 1 0 0 0  0 0 1 0 0  0 0 0 19 -9" result="blob" />
            </filter>
        </defs>
    </svg>
	</footer>
</body>
</html>
