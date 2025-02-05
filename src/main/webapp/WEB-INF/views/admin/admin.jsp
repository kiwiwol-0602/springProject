<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="${ctp}/main/favicon.png">
  <title>관리자 | LUMI</title>
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<jsp:include page="/WEB-INF/views/include/fonts.jsp" />
  <meta name="description" content="This is an example dashboard created using build-in elements and components.">
  <meta name="msapplication-tap-highlight" content="no">
  <link href="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.css" rel="stylesheet" />
  <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.10.1/main.min.js"></script>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <style type="text/css">
  	.stats-container {
  display: flex;
  
  justify-content: space-between;
  width: 100%;
  max-width: 1200px;
}

.stat-box {
  width: 22%;
  background-color: #fff;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  padding: 20px;
  text-align: center;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
}

.stat-box .icon {
  font-size: 40px;
  margin-bottom: 15px;
}

.stat-box .data h3 {
  font-size: 36px;
  margin: 0;
  color: white;
}

.stat-box .data h4 {
  font-size: 16px;
  color: white;
  margin: 5px 0 0;
}

.stat-box.red {
  background-color: #f44336;
  color: white;
}

.stat-box.blue {
  background-color: #2196F3;
  color: white;
}

.stat-box.teal {
  background-color: #009688;
  color: white;
}

.stat-box.orange {
  background-color: #FF9800;
  color: white;
}

.calendar a{
 color: black;
 text-decoration: none;
}

/* 메세지 관리 레이아웃 */
.message{
	width: 100%;
	display: flex; 
	flex-direction: row;
	
}
    #leftWindow {
      width: 30%;
      height: 485px;
      background-color: #ddd;
      overflow: auto;
      padding: 10px;
      text-align: left;
    }

    #rightWindow {
      width: 70%;
      height: 485px;
      background-color: #eee;
      overflow: auto;
      padding: 10px;
      text-align: left;
    }

    #footerMargin {
      clear: both;
      margin: 10px;
    }
  
  </style>
  <script>
        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');

            var calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth', // 기본 보기 (월간)
                headerToolbar: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'dayGridMonth,timeGridWeek,timeGridDay'
                  },
                  // 서버에서 일정을 불러오는 Ajax 요청
                  events: function(fetchInfo, successCallback, failureCallback) {
								    $.ajax({
							        url: '${ctp}/admin/loadSchedule',
							        method: 'GET',
							        success: function(data) {
						            // 서버에서 받은 데이터를 FullCalendar에 맞는 형식으로 변환
						            var events = data.map(function(event) {
				                	let endD = new Date(event.endDate);
					                endD.setDate(endD.getDate() + 1);
					                return {
				                    title: event.title,
				                    start: event.startDate, // startDate는 서버에서 반환된 날짜 필드명
				                    end: endD.toISOString().split('T')[0] || event.startDate, // endDate가 없으면 startDate와 동일하게 처리
				                    allDay: true
					                };
						            });
						            successCallback(events); // FullCalendar에 이벤트 전달
							        },
							        error: function(error) {
						            failureCallback(error); // 실패 시 처리
						            alert('일정을 불러오는 중 오류가 발생했습니다.');
							        }
								    });
									},
                  // 날짜 클릭 이벤트 핸들러
                  dateClick: function(info) {
								    var title = prompt('일정 제목을 입력하세요:');
								    if (title) {
							        var endDate = prompt('종료 날짜를 입력하세요 (형식: YYYY-MM-DD):');
							        
							        // 종료 날짜가 입력되지 않으면 시작 날짜와 동일하게 설정
							        if (!endDate) {
						            endDate = info.dateStr;
							        }
							        
							        $.ajax({
							            url: '${ctp}/admin/saveSchedule',
							            method: 'POST',
							            data: {
						                title: title,
						                startDate: info.dateStr,
						                endDate: endDate
							            },
							            success: function(res) {
						                let endD = new Date(endDate);
						                endD.setDate(endD.getDate() + 1);
						                calendar.addEvent({
					                    title: title,
					                    start: info.dateStr,
					                    end: endD.toISOString().split('T')[0],
					                    allDay: true
						                });
						                alert('일정이 저장되었습니다.');
							            },
							            error: function(error) {
						                alert('일정을 저장하는 중 오류가 발생했습니다.');
							            }
							        });
								    }
								    else {
							        alert('일정 등록 중 오류가 발생했습니다.');
								    }
									}
                });


            calendar.render(); // 캘린더 렌더링
        });
    </script>
</head>
<body>
<div style="width: 95%; margin: 2% auto; display: flex;">
  <!-- 달력 영역 (70% 공간) -->
  <div style="width: 70%; margin-right: 2%;">
    <div id="calendar" class="calendar" style="width: 100%;"></div>
  </div>
  
  <!-- 고객 탈퇴신청, 주문건수, 교환환불 등의 칸 (30% 공간) -->
  <div style="width: 30%; display: flex; flex-direction: column; justify-content: space-between;">
    <div class="stats-container">
    	<div class="stat-box orange" onclick="location.href='${ctp}/admin/userList'">
	      <div class="icon"><i class="fa-solid fa-user-plus"></i></div>
	      <div class="data">
	        <h3>${newUserCnt}</h3>
	        <h4>신규회원</h4>
	      </div>
	    </div>
	    <div class="stat-box teal" onclick="location.href='${ctp}/admin/userList?level=99'">
	      <div class="icon"><i class="fa-solid fa-user-xmark"></i></div>
	      <div class="data">
	        <h3>${leaveUserCnt}</h3>
	        <h4>탈퇴신청</h4>
	      </div>
	    </div>
	    <div class="stat-box blue" onclick="location.href='${ctp}/admin/orderList'">
	      <div class="icon"><i class="fa-solid fa-box"></i></div>
	      <div class="data">
	        <h3>${newOrderCnt}</h3>
	        <h4>주문건수</h4>
	      </div>
	    </div>
	    <div class="stat-box red" onclick="location.href='${ctp}/admin/refundList'">
	      <div class="icon"><i class="fa-solid fa-truck-ramp-box"></i></div>
	      <div class="data">
	        <h3>${refundCnt}</h3>
	        <h4>교환환불</h4>
	      </div>
	    </div>
	  </div>
  <br/>
  <div class="message">
	  <div id="leftWindow">
	      <p><br/></p>
	      <p><a href="${ctp}/webMessage/webMessage?mSw=0" class="text-dark link-primary link-underline-opacity-0 link-underline-opacity-75-hover">메세지작성</a></p>
	      <p><a href="${ctp}/webMessage/webMessage?mSw=1&mFlag=1" class="text-dark link-primary link-underline-opacity-0 link-underline-opacity-75-hover">받은메세지</a></p>
	      <p><a href="${ctp}/webMessage/webMessage?mSw=2&mFlag=2" class="text-dark link-primary link-underline-opacity-0 link-underline-opacity-75-hover">새메세지</a></p>
	      <p><a href="${ctp}/webMessage/webMessage?mSw=3&mFlag=3" class="text-dark link-primary link-underline-opacity-0 link-underline-opacity-75-hover">보낸메세지</a></p>
	      <p><a href="${ctp}/webMessage/webMessage?mSw=4&mFlag=4" class="text-dark link-primary link-underline-opacity-0 link-underline-opacity-75-hover">수신확인</a></p>
	    </div>
	
	    <div id="rightWindow">
	      <p>
	        <c:if test="${mSw == 0}">
	          <h3>메세지 작성</h3>
	          <jsp:include page="${ctp}/webMessage/wmInput" />
	        </c:if>
	        <c:if test="${mSw == 1}">
	          <h3>받은메세지</h3>
	          <jsp:include page="${ctp}/webMessage/wmList" />
	        </c:if>
	        <c:if test="${mSw == 2}">
	          <h3>새메세지</h3>
	          <jsp:include page="${ctp}/webMessage/wmList" />
	        </c:if>
	        <c:if test="${mSw == 3}">
	          <h3>보낸메세지</h3>
	          <jsp:include page="${ctp}/webMessage/wmList" />
	        </c:if>
	        <c:if test="${mSw == 6}">
	          <h3>메세지 내용보기</h3>
	          <jsp:include page="${ctp}/webMessage/wmContent" />
	        </c:if>
	      </p>
	    </div>
		</div>
	</div>
</div>
</body>
</body>
</html>