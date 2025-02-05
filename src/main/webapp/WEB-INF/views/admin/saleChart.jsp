<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="icon" href="ctp/main/favicon.png">
	<title>판매통계 | LUMI</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<jsp:include page="/WEB-INF/views/include/fonts.jsp" />
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f5f5f5;
    }
    #donutchart {
      margin: 0 auto;
      background-color: white;
      border-radius: 15px;
      box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
      padding: 20px;
    }
    h2 {
      color: #333;
      font-weight: bold;
    }
    .monthly-sales {
      text-align: center;
      margin-top: 20px;
    }
    .monthly-sales h2 {
      font-size: 28px;
      color: #333;
    }
  </style>
  
  <script type="text/javascript">
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart1);

    function drawChart1() {
    	var data = google.visualization.arrayToDataTable([
    		['name','productCnt'],
    		<c:forEach var="vo" items="${productCntVOS}" varStatus="st">
    			['${vo.productName}',${vo.totOrderCnt}],
    		</c:forEach>
        ]);

        var options = {
            title: '최다 판매 품목',
            pieHole: 0.4,  // 도넛 모양으로 변경
            backgroundColor: 'transparent',
            colors: ['#3366CC', '#DC3912', '#FF9900', '#109618', '#990099'], // 커스텀 색상
            pieSliceTextStyle: {
              color: 'white',
            },
            legend: {
              position: 'right',
              textStyle: {
                fontSize: 14,
                color: '#333'
              }
            },
            chartArea: {
              width: '70%', 
              height: '80%'
            },
            titleTextStyle: {
              fontSize: 18,
              bold: true,
              color: '#333'
            }
        };

        var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
        chart.draw(data, options);
    }
  </script>
</head>

<body>
  <p><br/></p>
  <div style="width: 1100px; margin: 0 auto;">
    <div id="donutchart" style="width: 100%; height: 500px;"></div>
  </div>

  <div class="monthly-sales">
    <h2>월 매출 : <fmt:formatNumber pattern="#,##0" value="${monthlySales}"/>원</h2>
  </div>
</body>
</html>
