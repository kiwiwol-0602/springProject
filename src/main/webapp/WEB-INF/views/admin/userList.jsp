<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<c:set var="level" value="${param.level}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="icon" href="${ctp}/images/main/favicon.png">
  <title>고객 리스트 | LUMI</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
	<jsp:include page="/WEB-INF/views/include/fonts.jsp" />
  <style>
    /* 기본 스타일 */
    body {
        font-family: '맑은 고딕', 'Noto Sans', Arial, sans-serif;
        margin: 0;
        padding: 0;
    }
    .table-container {
        padding: 10px 0;
        overflow-x: auto;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin: 0 auto;
        font-size: 14px;
        color: #333;
    }
    table th {
        background-color: #f1faee;
        color: #457b9d;
        padding: 12px;
        font-weight: bold;
        text-align: center;
        border-bottom: 2px solid #a8dadc;
        white-space: nowrap;
    }
    table td {
        padding: 10px;
        text-align: center;
        border-bottom: 1px solid #ddd;
        white-space: nowrap;       /* 줄바꿈 방지 */
        overflow: hidden;          /* 넘치는 텍스트 숨김 */
        text-overflow: ellipsis;   /* 말줄임표(...) 표시 */
        max-width: 150px;          /* 최대 셀 너비 설정 */
    }
    table tr:hover {
        background-color: #f1f5fa;
    }
  </style>
  <script type="text/javascript">
  
  
  // 등급별 조회
  function levelViewCheck() {
	  let level = document.getElementById("levelView").value;
	  location.href = "${ctp}/admin/userList?level=" + level; // level 값을 URL에 전달
  }
  
  // 탈퇴신청후 30일 지난 회원들 DB에서 자료 삭제시키기
  function memberDeleteOk(mid) {
  	let ans = confirm("회원정보를 삭제하시겠습니까?");
  	if(!ans) return false;
  		
  	$.ajax({
  		type : "post",
  		url  : "${ctp}/member/memberDeleteOk",
  		data : {mid : mid},
  		success:function(res) {
  			if(res != "0") {
  				alert(mid + " 회원정보를 DB에서 삭제 시켰습니다.");
  				location.reload();
  			}
  			else alert(mid + "회원정보 삭제 실패");
  		},
  		error : function() {
  			alert("전송오류");
  		}
  	});
  		
  }
  /*
  // 전체 선택
  function allCheck() {
	  let checkboxes = document.querySelectorAll('input[name="userCheck"]');
	  checkboxes.forEach(function(checkbox) {
	    checkbox.checked = true;
	  });
  }
  
  // 전체 해제
  function allReset() {
	  let checkboxes = document.querySelectorAll('input[name="userCheck"]');
	  checkboxes.forEach(function(checkbox) {
	    checkbox.checked = false;
	  });
  }
  */
  
	//선택된 항목 반전 (체크박스의 상태를 반전)
  function reverseCheck() {
    let checkboxes = document.querySelectorAll('input[name="userCheck"]');
    checkboxes.forEach(function(checkbox) {
      checkbox.checked = !checkbox.checked;
    });
  }
 
  </script>
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false" onkeydownn="return false">
<div class="container-fluid">
    <div class="table-container">
      <table class="table table-borderless m-0">
    <tr>
      <td class="text-start">
        <div>
        <!--  
          <input type="button" value="전체선택" onclick="allCheck()" class="btn btn-success btn-sm me-1"/>
          <input type="button" value="전체취소" onclick="allReset()" class="btn btn-warning btn-sm me-1"/>
          <input type="button" value="선택반전" onclick="reverseCheck()" class="btn btn-info btn-sm me-1"/>
        </div>
        -->
      </td>
      <td class="text-end">
        <select name="levelView" id="levelView" onchange="levelViewCheck()">
			    <option value="999" <c:if test="${level == 999}">selected</c:if>>전체회원</option>
			    <option value="1"   <c:if test="${level == 1}">selected</c:if>>활동중회원</option>
			    <option value="99"  <c:if test="${level == 99}">selected</c:if>>탈퇴신청회원</option>
				</select>

      </td>
    </tr>
  </table>
    
    
    
        <table>
            <thead>
                <tr>
                    <th>
	                    <input type="checkbox" id="allCheck" onclick="reverseCheck()"/>
                    </th>
                    <th>순번</th>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>전화번호</th>
                    <th>이메일</th>
                    <th>주민등록번호</th>
                    <th>주소</th>
                    <th>성별</th>
                    <th>생일</th>
                    <th>탈퇴여부</th>
                    <th>회원가입날</th>
                    <th>마지막 접속일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="vo" items="${vos}" varStatus="st">
                   <%--  <tr onclick="location.href='UserDetail.ad?mid=${vo.mid}'"> --%>
                    <tr>
                        <td>
                        	<c:if test="${vo.level != 0}"><input type="checkbox" name="userCheck" id="userCheck${vo.idx}" value="${vo.idx}" /></c:if>
			       							<c:if test="${vo.level == 0}"><input type="checkbox" name="userCheck" id="userCheck${vo.idx}" value="${vo.idx}" disabled /></c:if>
			       						</td>
                        <td>${st.count}</td>
                        <td>${vo.mid}</td>
                        <td>${vo.name}</td>
                        <td>${vo.tel}</td>
                        <td>${vo.email}</td>
                        <td>${vo.resident}</td>
                        <td>${fn : replace(vo.address, "/" , "")}</td>
                        <td>${vo.gender}</td>
                        <td>${fn : substring(vo.birthday, 0, 10)}</td>
                        <td>${vo.userDel == 'OK' ? '<font color="red">탈퇴신청</font>' : '활동 중'}
                        <c:if test="${vo.userDel == 'OK'}"><div><button type="button" onclick='memberDeleteOk("${vo.mid}")' class="btn btn-sm btn-danger">회원탈퇴</button></div></c:if>
                        </td>
                        <td>${fn : substring(vo.joinDay,0,10)}</td>
	            					<td>${fn : substring(vo.lastDate,0,10)}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
