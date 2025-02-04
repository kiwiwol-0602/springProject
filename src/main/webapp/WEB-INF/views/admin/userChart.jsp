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
  <script type="text/javascript">
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart1);

    function drawChart1() {
    	var data = google.visualization.arrayToDataTable([
    
    		['name','visitCnt'],
    		<c:forEach var="vo" items="${visitCntVOS}" varStatus="st">
    			['${vo.name}',${vo.visitCnt}],
    		</c:forEach>
    			/*
            ['Task', 'Hours per Day'],
            ['Work',     11],
            ['Eat',      2],
            ['Commute',  2],
            ['Watch TV', 2],
            ['Sleep',    7]
    			
    			*/
          ]);

          var options = {
            title: '최다 방문자',
          };

          var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
          chart.draw(data, options);
        }
    
    google.charts.load('current', {'packages':['bar']});
    google.charts.setOnLoadCallback(drawChart2);

    function drawChart2() {
      var data = google.visualization.arrayToDataTable([
        ['name', '구매횟수'],
        <c:forEach var="vo" items="${orderCntVOS}" varStatus="st">
					['${vo.name}',${vo.totOrderCnt}],
				</c:forEach>
      ]);

      var options = {
        chart: {
          title: '최다구매자',
          subtitle: '구매횟수',
        }
      };

      var chart = new google.charts.Bar(document.getElementById('columnchart_material'));

      chart.draw(data, google.charts.Bar.convertOptions(options));
    }
  </script>
</head>
<body>
<p><br/></p>
<div class="container">
  <div id="donutchart" style="width: 900px; height: 500px;"></div>
</div>

<div class="container">
  <div id="columnchart_material" style="width: 800px; height: 500px;"></div>
</div>
</body>
</html>