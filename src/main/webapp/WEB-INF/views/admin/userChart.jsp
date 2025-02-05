<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="${ctp}/images/main/favicon.png">
  <title>고객 리스트 | LUMI</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<jsp:include page="/WEB-INF/views/include/fonts.jsp" />
 	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f9f9f9;
    }
    .container {
      max-width: 1000px;
      margin: 0 auto;
      background-color: #fff;
      padding: 20px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
      border-radius: 10px;
      margin-bottom: 20px;
    }
    h2 {
      text-align: center;
      font-weight: bold;
      color: #333;
      margin-bottom: 30px;
    }
    #donutchart, #columnchart_material {
      margin: 0 auto;
    }
  </style>

  <script type="text/javascript">
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart1);

    function drawChart1() {
    	var data = google.visualization.arrayToDataTable([
    		['name','visitCnt'],
    		<c:forEach var="vo" items="${visitCntVOS}" varStatus="st">
    			['${vo.name}',${vo.visitCnt}],
    		</c:forEach>
        ]);

        var options = {
            title: '최다 방문자',
            pieHole: 0.4,  // 도넛형으로 변경
            backgroundColor: 'transparent',
            colors: ['#1e90ff', '#ff6347', '#32cd32', '#ffcc00', '#9b59b6'],  // 커스텀 색상
            legend: {
              position: 'right',
              textStyle: { fontSize: 14, color: '#333' }
            },
            titleTextStyle: { fontSize: 18, bold: true, color: '#333' },
            pieSliceTextStyle: { color: '#fff' }
        };

        var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
        chart.draw(data, options);
    }

    google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawChart2);

    function drawChart2() {
      var data = google.visualization.arrayToDataTable([
        ['성명', '구매횟수'],
        <c:forEach var="vo" items="${orderCntVOS}" varStatus="st">
					['${vo.name}',${vo.totOrderCnt}],
				</c:forEach>
      ]);

      var options = {
        chart: {
          title: '최다 구매자',
          subtitle: '구매횟수',
        },
        bars: 'horizontal',  // 가로형 바차트
        colors: ['#1e90ff'],  // 커스텀 색상
        legend: { position: 'none' },
        hAxis: {
          title: '구매 횟수',
          textStyle: { fontSize: 12, color: '#333' }
        },
        vAxis: {
          textStyle: { fontSize: 12, color: '#333' }
        }
      };

      var chart = new google.charts.Bar(document.getElementById('columnchart_material'));
      chart.draw(data, google.charts.Bar.convertOptions(options));
    }
  </script>
</head>

<body>
  <p><br/></p>

  <!-- 방문자 통계 도넛 차트 -->
  <div class="container">
    <h2>최다 방문자 통계</h2>
    <div id="donutchart" style="width: 900px; height: 500px;"></div>
  </div>

  <!-- 구매자 통계 바 차트 -->
  <div class="container">
    <h2>최다 구매자 통계</h2>
    <div id="columnchart_material" style="width: 900px; height: 500px;"></div>
  </div>

</body>
</html>
