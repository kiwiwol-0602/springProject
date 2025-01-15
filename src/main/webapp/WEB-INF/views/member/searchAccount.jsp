<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="icon" href="${ctp}/main/favicon.png">
	<title>계정찾기 | LUMI</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <jsp:include page="/WEB-INF/views/include/fonts.jsp" />
<style>
  body {
      font-family: 'Arial', sans-serif;
      margin: 0;
      padding: 0;
      align-items: center;
      height: 100vh;
      display: flex;
      flex-direction: column;
      background-color: hsl(210, 60%, 15%);
      overflow-y: hidden; 
  }
  .Logo {
      font-family: '116watermelon';
      font-size: 200px;
      color: white;
      text-decoration: none;
      margin-bottom: 20px;
      text-align: center;
  }
  .Logo a {
      color: white;
      text-decoration: none;
  }
  .Logo a:hover {
      color: white;
      text-decoration: none;
  }
  .con {
      width: 100%;
      max-width: 800px;
      height: 550px;
      padding: 30px;
      background: #fff;
      border-radius: 12px;
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
  }
  .tabs {
      display: flex;
      justify-content: space-around;
      margin-bottom: 20px;
      border-bottom: 2px solid #ddd;
  }
  .tabs button {
      background: none;
      border: none;
      font-size: 16px;
      font-weight: bold;
      color: #555;
      padding: 10px;
      cursor: pointer;
  }
  .tabs button.active {
      color: #000B58;
      border-bottom: 2px solid #000B58;
  }
   /* 라디오 버튼 스타일링 */
    input[type="radio"] {
      appearance: none;
      width: 20px;
      height: 20px;
      border-radius: 50%;
      border: 2px solid #555; /
      background-color: transparent;
      position: relative;
      cursor: pointer;
    }

    input[type="radio"]:checked::before {
         content: '';
        position: absolute;
        top: 3px;
        left: 3px;
        width: 10px;
        height: 10px;
        background-color: #555; /* 체크된 부분 */
        border-radius: 50%;
    }




  .form-group {
      margin-bottom: 20px;
  }
  label {
      font-size: 14px;
      color: #555;
  }
  .control {
      width: 100%;
      height: 45px;
      border-radius: 8px;
      border: 1px solid #ddd;
      padding: 10px;
      font-size: 16px;
      transition: border-color 0.3s ease;
  }
  .control:focus {
      border-color: #43a047;
      outline: none;
      box-shadow: 0 0 5px rgba(67, 160, 71, 0.5);
  }
  .nextBtn {
      background: #003161;
      color: #fff;
      border: none;
      width: 100%;
      height: 50px;
      font-size: 18px;
      font-weight: bold;
      border-radius: 8px;
      cursor: pointer;
      transition: background-color 0.3s ease, transform 0.2s ease;
  }
  .nextBtn:hover {
      background: #000B58;
      transform: translateY(-2px);
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
  }
  .nextBtn:active {
      transform: translateY(0);
      box-shadow: none;
  }
  
  .tel-group {
      display: flex;
      gap: 10px; /* 입력 필드 간 간격 */
  }
  .tel-group .control {
      flex: 1; /* 각 입력 필드가 동일한 비율로 크기를 차지 */
  }
  
  .spinner-overlay {
	    position: fixed;
	    top: -17.2%;
	    left: 0;
	    width: 100%;
	    height: 650px;
	    background-color: rgba(0, 0, 0, 0.2); 
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    z-index: 1050;
    }

		.spinner-border {
	    width: 5rem; 
	    height: 5rem;
	    border-width: 0.5rem;
	    color: #FFF4B7; 
		}
		
		.fieldCheck {
		  font-size: 16px;
		  color: #555;
		  display: flex;
		  cursor: pointer;
		}
		
		.radio-group {
  display: flex;
  align-items: center;
   justify-content: center; /* 텍스트 가로 가운데 정렬 */
		  text-align: center;
}

</style>
<script>
  function switchTab(tabId) {
      const findIdForm = document.getElementById('findIdForm');
      const findPasswordForm = document.getElementById('findPasswordForm');
      const tabs = document.querySelectorAll('.tabs button');
      
      // Remove active class from all buttons
      tabs.forEach(tab => tab.classList.remove('active'));
      
      // Add active class to clicked button
      document.getElementById(tabId).classList.add('active');
      
      // Toggle form visibility
      if (tabId === 'idTab') {
          findIdForm.style.display = 'block';
          findPasswordForm.style.display = 'none';
      } else if (tabId === 'passwordTab') {
          findIdForm.style.display = 'none';
          findPasswordForm.style.display = 'block';
      }
  }
  
  // 라디오 버튼 클릭 시 이메일/전화번호 입력창 토글하는 함수
  function inputField() {
    const emailInput = document.getElementById('emailInput');
    const phoneInput = document.getElementById('phoneInput');
    
    if (document.getElementById('findEmail').checked) {
      emailInput.style.display = 'block'; // 이메일 입력창 보이기
      phoneInput.style.display = 'none';  // 전화번호 입력창 숨기기
    } 
    else if (document.getElementById('findTel').checked) {
      emailInput.style.display = 'none';  // 이메일 입력창 숨기기
      phoneInput.style.display = 'block'; // 전화번호 입력창 보이기
    }
  }

  // 초기 상태 설정 (페이지 로드 시)
  window.onload = function() {
    inputField(); // 페이지가 로드될 때 라디오 버튼에 맞는 입력창 보이기
  };
  
  // 아이디 찾기
  function findIdCheck() {
	  let name = findIdform.name.value.trim();
	  let email = findIdform.email.value.trim();
	  
	  let tel1 = findIdform.tel1.value.trim();
	  let tel2 = findIdform.tel2.value.trim();
	  let tel3 = findIdform.tel3.value.trim();
	  
	  let tel = tel1 + "-" + tel2 + "-" + tel3;
	  
	  if(email.trim() == "") {
  		alert("이메일을 입력하세요");
  		return false;
  	}
	  
  	$.ajax({
		  type : "post",
		  url  : "${ctp}/member/findId",
		  data : {
			  name : name,
			  email : email,
			  tel : tel
		  },
		  success: function(res) {
			  if(res != ""){
				  $('#findIdForm').html(res);
			  }
			  else {
				  alert("입력하신 정보를 확인해 주세요.");
			  }
			},
			error : function() {
    			alert("전송오류");
  		}
	  });
	}
   
  function inforCheck() {
  	let mid = findPasswordform.mid.value.trim();
  	let email = findPasswordform.email.value.trim();
  	
  	
  	$.ajax({
  		type : "post",
  		url  : "${ctp}/member/inforCheck",
  		data : {
  			mid : mid,
  			email : email
  		},
  		success:function(res) {
  			if(res != "0") {
  				let spin = "<div class='spinner-overlay'><div class='spinner-border'></div></div>";
  			  $("#demoSpin").html(spin);
			    emailSendOk(mid, email);
  			}
  			else alert("개인정보를 확인하시고 다시 전송하세요");
  		}
  	});
  }
  
  // 메일로 전송받은 인증키 확인처리하기
  function emailSendOk(mid, email) {
  	$.ajax({
  		type : "post",
  		url  : "${ctp}/member/emailSendOk",
  		data : {
  			mid : mid,
  			email : email
  		},
  		success:function() {
		    	alert("임시 비밀번호를 메일로 발송했습니다.\n다시 로그인해 주세요");
		    	location.href = "${ctp}/member/memberLogin";
  		},
  		error : function() {
  			alert("전송오류!");
  		}
  	});
  }
  
  
  
</script>
</head>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false" onkeydownn="return false">
  <div class="Logo">
      <a href="${ctp}/main">LUMI</a>
  </div>
  <div class="con">
    <div class="tabs">
        <button id="idTab" class="active" onclick="switchTab('idTab')">아이디 찾기</button>
        <button id="passwordTab" onclick="switchTab('passwordTab')">비밀번호 찾기</button>
    </div>
    <!-- 아이디 찾기 폼 -->
    <div id="findIdForm">
      <form name="findIdform">
	  		<div class="form-group" style="text-align: center;">
		  		<div style="font-weight:bold; padding: 20px 0; ">가입하신 방법에 따라 아이디 찾기가 가능합니다.</div>
	  			<!-- 라디오 버튼 그룹 -->
	  			<div class="radio-group mt-3 mb-3">
	          <input type="radio" name="findType" id="findEmail" value="findEmail" checked onclick="inputField()"/>
	          <label for="findEmail" class="fieldCheck ms-2" style="margin-right: 10%;">이메일</label>
	          <input type="radio" name="findType" id="findTel" value="findTel" onclick="inputField()"/>
	          <label for="findTel" class="fieldCheck ms-2">휴대폰번호</label>
          </div>
	  		</div>
	      <div class="form-group">
	          <label for="name">이름</label>
	          <input type="text" class="control" id="name" name="name" placeholder="이름을 입력해주세요." required>
	      </div>
	      <div class="form-group" id="emailInput">
	          <label for="email">이메일</label>
	          <input type="text" class="control" id="email" name="email" placeholder="이메일을 입력해주세요." required>
	      </div>
	      <div class="form-group" id="phoneInput" style="display: none;">
	          <label for="phone">핸드폰번호</label>
	          <div class="tel-group">
	            <input type="text" class="control" id="tel1" name="tel1" placeholder="010" value="010" maxlength="3" required>
	            <input type="text" class="control" id="tel2" name="tel2" placeholder="1234" maxlength="4" required>
	            <input type="text" class="control" id="tel3" name="tel3" placeholder="5678" maxlength="4" required>
	          </div>
            <input type="hidden" id="tel" name="tel">
	      </div>
	      <button type="button" onclick="findIdCheck()" class="nextBtn mt-5">다음</button>
      </form>
      <div id="idCheckBox"></div>
    </div>
    
    <!-- 비밀번호 찾기 폼 -->
    <div id="findPasswordForm" style="display: none;">
      <form name="findPasswordform" method="post" action="#">
          <div class="form-group">
              <label for="mid">아이디</label>
              <input type="text" class="control" id="mid" name="mid" placeholder="아이디를 입력해주세요." required>
          </div>
          <div class="form-group">
              <label for="name">이름</label>
              <input type="text" class="control" id="name" name="name" placeholder="이름을 입력해주세요." required>
          </div>
          <div class="form-group">
              <label for="emailPwd">이메일</label>
              <input type="text" class="control" id="emailPwd" name="email" placeholder="이메일을 입력해주세요" required>
              
          </div>
          <div id="demoSpin" style="display: none;"></div>
          <button type="button" onclick="inforCheck()" class="nextBtn">다음</button>
      </form>
    </div>
  </div>
</body>
</html>