
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
	<title>회원정보수정 | LUMI</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script src="${ctp}/js/woo.js"></script>
 <style>
  body, html {
    height: 100%;
    margin: 0;
    padding: 0;
    font-family: 'EliceDigitalBaeum-Bd';
    background-size: cover;
    background-position: center;
  }
  
  .container {
    display: flex;
    justify-content: center; /* 수평 중앙 정렬 */
    align-items: center; /* 수직 중앙 정렬 */
    padding-top: 15%;
    padding-bottom: 3%; /* 폼 아래에 여백을 줘서 배경 이미지가 5% 정도 보이게 함 */
  }
  
  .Logo {
    font-family: "Playfair Display", serif;
    font-size: 30px;
    color: white;
    text-decoration: none;
  }

  .Logo:hover {
    color: white;
    text-decoration: none;
  }

  html {
    scroll-behavior: smooth;
  }

  #container {
    font-size: 1.1em;
  }

  input.form-control {
    font-size: 15px;
    border-radius: 0;
    outline: none; /* 포커스 시 기본 외곽선 제거 */
  }
  input.form-control:focus {
	  border-color: black; /* 포커스 될 때 테두리 색상을 검정으로 변경 */
	  outline: none !important; /* 포커스 시 기본 외곽선 제거 */
	  box-shadow: 0 0 0 3px rgba(0, 0, 0, 0.1); /* 포커스 시 약간의 그림자 효과 추가 */
}

  .text-primary {
    font-size: 0.8em;
    padding: 2px 10px;
  }

  .btn {
    background-color: white;
    border-color: #8a7c66;
    color: #8a7c66;
    border-width: medium;
  }

  .btn:hover {
    background-color: #8a7c66;
    color: white;
  }

  .input-group-append {
    z-index: 0;
  }

 
  /* 버튼 스타일 */
 .blackLine-btn {
  background-color: #fff; /* 버튼 배경을 흰색 */
  color: #3D3B3B; /* 글씨를 검정색으로 */
  border: 1px solid #333; /* 진회색 테두리 */
  border-radius: 0px; /* 네모 모양으로 */
  padding: 6px 12px; /* 적당한 패딩으로 크기 조정 */
  font-size: 13px;
  font-weight: 600;
  cursor: pointer;
  text-align: center;
  transition: all 0.3s ease;
}

.blackLine-btn:hover {
  background-color: #eee; /* hover 시 연한 회색 */
  border-color: #666; /* hover 시 테두리 색 변화 */
  transform: translateY(-2px); /* 약간 위로 이동 */
}

.blackLine-btn:active {
  background-color: #ccc; /* 클릭 시 배경이 조금 더 어두워짐 */
  border-color: #555; /* 클릭 시 테두리 색 */
  transform: translateY(0); /* 클릭 시 위치 복원 */
}

.blackLine-btn:focus {
  outline: none;
  box-shadow: 0 0 0 2px rgba(138, 124, 102, 0.7); /* 포커스 시 그림자 */
}

  /* 테이블 스타일 */
  #userTable {
  border-collapse: collapse;
  width: 100%;
  table-layout: fixed; /* 테이블의 열 크기를 고정 */
}

#userTable th {
  border: none;
  padding: 10px; /* 셀에 패딩 추가 (선택 사항) */
  text-overflow: ellipsis; /* 텍스트가 넘칠 경우 생략 표시 */
  overflow: hidden;
  text-align: left;
  font-weight: normal; /* 글씨 굵기를 일반으로 설정 */
  vertical-align: middle;
}
#userTable td {
  border: none;
  padding: 10px; /* 셀에 패딩 추가 (선택 사항) */
  width: 70%;
  text-overflow: ellipsis; /* 텍스트가 넘칠 경우 생략 표시 */
  overflow: hidden;
}

  #userTable tr {
    border-color: #E2E2E2;
  }
  #selectTable {
  border-collapse: collapse;
  width: 100%;
  table-layout: fixed; /* 테이블의 열 크기를 고정 */
}

#selectTable th {
  border: none;
  padding: 10px; /* 셀에 패딩 추가 (선택 사항) */
  text-overflow: ellipsis; /* 텍스트가 넘칠 경우 생략 표시 */
  overflow: hidden;
  text-align: left;
  font-weight: normal; /* 글씨 굵기를 일반으로 설정 */
  vertical-align: middle;
}
#selectTable td {
  border: none;
  padding: 10px; /* 셀에 패딩 추가 (선택 사항) */
  width: 70%;
  text-overflow: ellipsis; /* 텍스트가 넘칠 경우 생략 표시 */
  overflow: hidden;
}

  #selectTable tr {
    border-color: #E2E2E2;
  }
  
   /* 라디오 버튼 스타일링 */
   /* 커스터마이즈된 라디오 버튼 */
input[type="radio"] {
      appearance: none;
      width: 20px;
      height: 20px;
      border-radius: 50%;
      border: 2px solid #555; /
      background-color: transparent;
      position: relative;
      cursor: pointer;
      vertical-align: middle; /* 라벨과 세로 정렬 */
      margin-right: 3px;
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

    
    .spinner-overlay {
	    position: fixed;
	    top: 0;
	    left: 0;
	    width: 100vw;
	    height: 100vh;
	    background-color: rgba(0, 0, 0, 0.2); 
	    display: flex;
	    justify-content: center;
	    align-items: center;
	    z-index: 1050;
    }

		.spinner-border {
	    width: 5rem; 
	    height: 5rem;
	    border-width: 0.1rem;
	    color: white; 
		}
    
    .cancel-btn {
     width: 48%; /* 버튼을 반반씩 차지하게 만듬 */
  height: 50px; /* 버튼 높이 설정 */
  font-size: 16px;
  cursor: pointer;
  transition: all 0.3s ease; /* 호버 시 부드럽게 변화 */
  background-color: white; /* 흰 배경 */
  color: black; /* 검정 글씨 */
  border: 1px solid lightgray; /* 연한 회색 테두리 */
}

.cancel-btn:hover {
  border-color: black; /* 호버 시 검정 테두리 */
}

/* 회원정보수정 버튼 스타일 */
.update-btn {
 width: 48%; /* 버튼을 반반씩 차지하게 만듬 */
  height: 50px; /* 버튼 높이 설정 */
  border: 1px solid transparent; /* 기본 테두리 없앰 */
  font-size: 16px;
  cursor: pointer;
  transition: all 0.3s ease; /* 호버 시 부드럽게 변화 */
  background-color: black; /* 검정 배경 */
  color: white; /* 흰색 글씨 */
}

.update-btn:hover {
  background-color: #282828; /* 호버 시 진회색 배경 */
}
</style>

  <script type="text/javascript">
  	let emailSw = 1;
  	let pwdSw = 1;

		// 정규식 검사 함수
	  let regPwd = /^(?=.*?[0-9])(?=.*?[a-zA-Z])[a-zA-Z0-9!@#$%^&*()._-]{4,20}$/;  //(비밀번호)4자 이상 20자 이하, 영어/숫자 1개 이상 필수, 특수문자 허용
	  let regName = /^[가-힣a-zA-Z]{1,10}$/;  // (성명)한글,영문만 적어도 1자이상 
 		let regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/; // 이메일 
 		let regTel = /\d{2,3}-\d{3,4}-\d{4}$/; //(전화번호)
 		let regBd = /^(0[0-9]|[1-9][0-9])(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])$/; //(birthday)
 		//let regex6 = /\d{6}[1-4]$/; //(resident-고객(주민등록번호):마지막자리는 성별을 나타내서 1-4까지의 숫자만 들어오도록)

		function currentPwdCheck() {
			//let regPwd = /^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%^&*()._-]{4,20}$/g; //(비밀번호)4자 이상 20자 이하, 영어/숫자 1개 이상 필수, 특수문자 허용
			let currentPwd = document.getElementById("currentPwd").value.trim();
			let mid = document.getElementById("mid").value.trim();
			document.getElementById("pwdError1").innerHTML="";
			
		 	if (!currentPwd) {
			 	document.getElementById("pwdError1").innerHTML="기존 비밀번호를 입력해주세요.";
        pwdSw = 0;
        return;
	    }
				// 비밀번호 확인
		  if(!regPwd.test(currentPwd)) {
		    document.getElementById("pwdError1").innerHTML="비밀번호가 올바르지 않습니다.(영어/숫자 필수, 특수문자 가능 4~20자)";
		    pwdSw = 0;
		    return;
		  }
		  // 서버에 비밀번호 확인 요청
		    $.ajax({
		        type: "post",
		        url: "${ctp}/member/pwdCheck",
		        data: {
		            mid : mid,
		            currentPwd : currentPwd
		        },
		        success: function (res) {
		            if (res != "1") {
		                alert("기존 비밀번호와 동일하지 않습니다. 확인 후 다시 입력해주세요.");
		                pwdSw = 0;
		            } else {
		                alert("비밀번호가 확인되었습니다. 계속 진행하세요");
		                pwdSw = 1;  // 비밀번호가 일치하는 경우 상태 변경
		            }
		        },
		        error: function () {
		            alert("전송오류");
		            pwdSw = 0;
		        }
		    });
		}
 		
		function newPwdCheck() {
			let newPwd = document.getElementById("newPwd").value.trim();
			document.getElementById("pwdError2").innerHTML="";
			
			if (!newPwd) {
	        // 비밀번호가 입력되지 않았으므로 아무 작업도 하지 않음
	        return;
	   	}
			
			// 비밀번호 확인2
			if(!regPwd.test(newPwd)) {
			    document.getElementById("pwdError2").innerHTML="비밀번호가 올바르지 않습니다.(영어/숫자 필수, 특수문자 가능 4~20자)";
			  }
		  else {
		    document.getElementById("pwdError2").innerHTML="";
	  	}	
		 
		}
		function nameCheck() {
			//let regName = /^[가-힣a-zA-Z]{1,10}$/;  // (성명)한글,영문만 적어도 1자이상 
			let name = document.getElementById("name").value.trim();
			document.getElementById("nameError").innerHTML="";
			
		  // 성명 확인
		  if(!regName.test(name)){
		    document.getElementById("nameError").innerHTML="성명이 올바르지 않습니다.(한글/영문만 10자 이하)";
		  }
		  else {
			  document.getElementById("nameError").innerHTML="";
		  }			
		}
		
		function birthdayCheck() {
			//let regBd = /\d{6}$/; //(birthday)
			let birthday = document.getElementById("birthday").value;
			document.getElementById("birthday").innerHTML="";
			
			// 생년월일 확인
			if(!regBd.test(birthday)){
			    document.getElementById("residentError").innerHTML="주민등록번호가 올바르지 않습니다.(생년월일 + 성별(1~4))";
			  }
		  else {
			  document.getElementById("residentError").innerHTML="";
			  if (birthday.length >= 6) {
				  document.getElementById('gender').focus();
	      }
		  }
		}
		
		function genderCheck() {
	    let gender = document.getElementById("gender").value.trim();
	    document.getElementById("residentError").innerHTML = "";

	    // 성별 값이 1~4 사이에 있는지 확인
	    if (gender < 1 || gender > 4 || isNaN(gender)) {
	        document.getElementById("residentError").innerHTML = "주민등록번호가 올바르지 않습니다.(성별은 1~4 사이의 숫자여야 합니다)";
	    }
	    else {
        document.getElementById("residentError").innerHTML = "";
	    }
		}
		
		function telCheck() {
			//let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g; //(전화번호)
		  let tel1 = document.getElementById("tel1").value;
		  let tel2 = document.getElementById("tel2").value;
		  let tel3 = document.getElementById("tel3").value;
		  let tel = tel1 + "-" + tel2 + "-" + tel3;
		  
		  // 전화번호 확인
		  if(tel2===""){
		    document.getElementById("telError").innerHTML="전화번호의 가운데 자리를 입력해주세요.";
		  }
		  else if(tel3===""){
		    document.getElementById("telError").innerHTML="전화번호의 마지막 자리를 입력해주세요.";
		  }
		  else if(!regTel.test(tel)){
		    document.getElementById("telError").innerHTML="전화번호 형식에 맞게 입력해주세요.";
		  }
		  else {
		    document.getElementById("telError").innerHTML="";
		  }
		}

		// 이메일 인증체크
	    function emailCheck() {
	    	// 필수입력란의 체크를 모두 마친후 인증번호를 메일로 발송한다.
	    	let email = $("#email").val();
	    	let originalEmail = "${vo.email}";  // 기존 이메일
	    	
	    	if(email.trim() == "") {
	    		document.getElementById("emailError").innerHTML="이메일을 입력해주세요.";
	    		emailSw=0;
	    		$("#email").focus();
	    		return;
	    	}
	    	
    	 	if (email == originalEmail) {
		      // 이메일이 변경되지 않았으면 인증 생략
		      document.getElementById("emailError").innerHTML = "";
		      return;
	    	}
    	 	else {
		    	let spin = "<div class='spinner-overlay'><div class='spinner-border'></div></div>";
		    	$("#demoSpin").html(spin);
		    	
	 	    	$.ajax({
		    		type : "post",
		    		url  : "${ctp}/member/memberEmailCheck",
		    		data : {email : email},
		    		success:function(res) {
		    			if(res == 1) {
		    				alert("이 이메일은 이미 사용 중입니다.\n다른 이메일을 입력해주세요.");
		    				emailSw=0;
		    				$("#demoSpin").html("");
		    			}
		    			else if(res == 2) {
		    				alert("인증번호가 발송되었습니다.\n메일 확인후 인증번호를 입력해주세요");
		    				addVerificationInput();
		    			}
		    			else {
		    				alert("인증번호받기 버튼을 다시 눌러주세요");
		    				emailSw=0;
		    			}
		    		},
		    		error : function() {
		    			alert("전송오류");
		    		}
		    	});
    	 	}
	    }
		
	    function addVerificationInput() {
	        const demoSpin = document.getElementById("demoSpin");

	        // 전체 컨테이너 생성
	        const formGroup = document.createElement("div");
	        formGroup.classList.add("form-group");
	        formGroup.style.position = "relative";
	        formGroup.style.display = "flex";
	        formGroup.style.alignItems = "center";
	        formGroup.style.marginTop = "10px";

	        // 인증번호 입력 필드 생성
	        const checkKeyInput = document.createElement("input");
	        checkKeyInput.type = "text";
	        checkKeyInput.name = "checkKey";
	        checkKeyInput.id = "checkKey";
	        checkKeyInput.classList.add("form-control");
	        checkKeyInput.placeholder = "인증번호를 입력하세요";
	        checkKeyInput.style.flex = "1";
	        checkKeyInput.style.marginRight = "10px";

	        // 인증번호 확인 버튼 생성
	        const checkOkBtn = document.createElement("button");
	        checkOkBtn.type = "button";
	        checkOkBtn.name = "emailCheckOkBtn";
	        checkOkBtn.id = "emailCheckOkBtn";
	        checkOkBtn.classList.add("blackLine-btn");
	        checkOkBtn.style.paddingRight = "5px";
	        checkOkBtn.style.paddingLeft = "5px";
	        checkOkBtn.textContent = "인증번호 확인";
	        checkOkBtn.onclick = emailCheckOk;  // 인증번호 확인 함수 호출

	        // 요소들 DOM에 추가
	        formGroup.appendChild(checkKeyInput);
	        formGroup.appendChild(checkOkBtn);
	        
	        demoSpin.innerHTML = '';  // 기존 내용을 지우고 새로 추가
	        demoSpin.appendChild(formGroup);
	    }
	    
	    // 메일로 전송받은 인증키에대한 인증확인처리
	    function emailCheckOk() {
	    	let checkKey = $("#checkKey").val();
	    	if(checkKey.trim() == "") {
	    		alert("전송받은 메일에서 인증받은 인증키를 입력해주세요");
	    		return false;
	    	}
	    	
	    	$.ajax({
	    		type : "post",
	    		url  : "${ctp}/member/memberEmailCheckOk",
	    		data : {checkKey : checkKey},
	    		success:function(res) {
	    			if(res != "0") {
			    		alert("인증 확인되었습니다.\n계속해서 추가 인적사항을 기입해 주세요.");
			    		// updateform.email을 통해 이메일 입력 필드 스타일을 변경
			    		updateform.email.style.backgroundColor = "#f5f5f5";
	            updateform.email.style.borderColor = "#ddd";
	            updateform.email.style.color = "#aaa";
	            updateform.email.style.cursor = "not-allowed";
              
	            // 이메일 인증 버튼 비활성화
	            let emailCheckBtn = document.getElementById("emailCheckBtn");
	            emailCheckBtn.disabled = true;
	            emailCheckBtn.innerText = "이메일 인증 완료";
	            emailCheckBtn.style.color = "gray"; // 버튼 글씨 색 변경
	            
	            
			    		$("#demoSpin").hide();
			    		// 추가로 입력할부분을 show() 시켜준다.
			      }
	    			else {
	    				alert("인증실패\n메일주소를 확인하시고 다시 인증메일을 전송해 주세요.");
	    				emailSw=0;
	    			}
	    		},
	    		error : function() {
	    			alert("전송오류");
	    		}
	    	});
	    }
		
		// 회원가입 버튼 클릭시 체크
		
		function updateCheck(){
		  let currentPwd = document.getElementById("currentPwd").value.trim();
		  let newPwd = document.getElementById("newPwd").value.trim();
		  let name = document.getElementById("name").value.trim();
	  	let email = document.getElementById("email").value.trim();
	  	let originalEmail = "${vo.email}";
			let birthday = document.getElementById("birthday").value.trim();
			let gender = document.getElementById("gender").value.trim();
	  	 
		  let tel1 = document.getElementById("tel1").value;
		  let tel2 = document.getElementById("tel2").value;
		  let tel3 = document.getElementById("tel3").value;
		  let tel = tel1 + "-" + tel2 + "-" + tel3;
		  
		  let address = updateform.postcode.value.trim()+" /"+updateform.roadAddress.value.trim()+" /"+updateform.detailAddress.value.trim()+" /"+updateform.extraAddress.value.trim()+" ";
	  	
		  let resident = birthday + "-" + gender; 
		  
		  
			
		  // currentPwd가 비어있지 않으면 유효성 검사
		    if (currentPwd && !regPwd.test(currentPwd)) {
		        document.getElementById("pwdError1").innerHTML = "비밀번호가 올바르지 않습니다.(영어/숫자 필수, 특수문자 가능 4~20자)";
		        document.getElementById("currentPwd").focus();
		        return false;
		    }

		    // 비밀번호가 다를 경우 처리
		    if (newPwd && !regPwd.test(newPwd)) {
		        document.getElementById("pwdError2").innerHTML = "비밀번호가 올바르지 않습니다.(영어/숫자 필수, 특수문자 가능 4~20자)";
		        document.getElementById("newPwd").focus();
		        return false;
		    } else {
		        // currentPwd가 비어있지 않으면 password 값을 폼에 추가
		        if (currentPwd) {
		            updateform.pwd.value = newPwd; // 비밀번호를 폼에 추가
		        } else {
		            updateform.pwd.value = ""; // currentPwd가 비어 있으면 빈 값 전송
		        }
		        document.getElementById("pwdError1").innerHTML = "";
		        document.getElementById("pwdError2").innerHTML = "";
		    }
				  
		  // 성명 확인
		  if(!regName.test(name)){
		    document.getElementById("nameError").innerHTML="성명이 올바르지 않습니다.(한글/영문만 10자 이내)";
		    document.getElementById("name").focus();
		    return false;
		  }
		  else {
			  document.getElementById("nameError").innerHTML="";
		  }
		   
		  // 이메일확인
		  if(!regEmail.test(email)){
		    document.getElementById("emailError").innerHTML="이메일이 올바르지 않습니다.";
		    document.getElementById("email").focus();
		    return false;
		  }
		  else {
			  document.getElementById("emailError").innerHTML="";
		  }	 
				     
		  // 전화번호 확인
		  if(tel2==="" || tel3===""){
		    document.getElementById("telError").innerHTML="전화번호를 입력해주세요.";
		    document.getElementById("tel2").focus();
		    return false;
		  }
		  else if(!regTel.test(tel)){
		    document.getElementById("telError").innerHTML="전화번호 형식에 맞게 입력해주세요.";
		    document.getElementById("tel2").focus();
		    return false;
		  }
		  else {
		    document.getElementById("telError").innerHTML="";
		  }
		  
		  // 주민번호 확인
		  if(!regBd.test(birthday)|| gender < 1 || gender > 4){
			    document.getElementById("residentError").innerHTML="주민등록번호가 올바르지 않습니다.(생년월일 + 성별(1~4))";
			    document.getElementById("birthday").focus();
			    return false;
			  }
		  else {
			  document.getElementById("residentError").innerHTML="";
		  }
		  
		  
	  	let fName = document.getElementById("fName").value;
	  	let maxSize = 1024 * 1024 * 20; 	// 저장파일 최대용량을 20MByte까지로 제한
	  	let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase();
	  	
	  	alert("fName:"+fName);
	  	
	  	if (fName != ""){
		  	let fileSize = document.getElementById("fName").files[0].size;
		  	
		  	alert("fileSize :"+fileSize);
		  	alert("ext :"+ext);
		  	
		  	if(fileSize > maxSize) {
		  		alert("업로드할 파일의 최대용량은 20MByte 입니다.");
		  		return false;
		  	}
		  	else if(ext != 'jsp' && ext != 'gif' && ext != 'png' && ext != 'jpg') {
		  		alert("업로드 가능한 파일은 'jpg/gif/png/jpg'만 가능합니다.")
		  		return false;
		  	}
	  	}
	  	if(emailSw == 0){
			  alert("이메일 인증을 진행해주세요.");
			  return false;
		  }
		  else if(pwdSw == 0){
			  alert("기존 비밀번호와 일치여부를 확인해주세요.");
			  return false;
		  }
		  else{
		    updateform.email.value = email;
		    updateform.tel.value = tel;
		    updateform.resident.value = resident;
		    updateform.address.value = address;
		   	
		    updateform.submit();
		  }
		}
  	
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/nav.jsp"/>
	<form name="updateform" method="post" action="${ctp}/member/memberUpdate" enctype="multipart/form-data">
	  <div class="container h-100">
			<div class="card" style="width: 72%;">
			  <div class="card-body">
			  	<div style="font-size: 40px; font-weight: bold; text-align: center;">회 원 정 보 수 정</div>
			    <div class="m-sm-4 p-3">
				      <div class="mb-3" style="text-align: right;"> <font color="red">*</font> 필수입력사항</div>  
				     	<div style="font-size: 20px; font-weight: bold; text-align: left;">기본정보</div>
			     	<table class="table table-bordered" id="userTable">
			     	<tr>
				      <th><font color="red"><b>*&nbsp;</b></font><label for="mid" class="form-label">아이디</label></th>
				      <td><input type="text" class="form-control" name="mid" id="mid" oninput="midCheck()" maxlength="20" value="${sMid}" readonly/></td>
				    </tr>
			     	<tr>
				      <th><font color="red"><b>*&nbsp;</b></font><label for="currentPwd" class="password">기존 비밀번호</label></th>
				      <td>
				      	<div style="display: flex; align-items: center;">
					      	<input type="password" class="form-control"  name="currentPwd" id="currentPwd" maxlength="20" placeholder="비밀번호 변경시에만 입력해주세요">
					      	<input type="button" class="blackLine-btn"  name="currentPwdBtn" id="currentPwdBtn" value="비밀번호 확인" onclick="currentPwdCheck()" style="margin-left: 10px;">
					      </div>
				      	<div id="pwdError1" class="text-primary"></div>
				      </td>
				    </tr>
			     	<tr>
				      <th><font color="red"><b>*&nbsp;</b></font><label for="newPwd" class="password">변경할 비밀번호</label></th>
				      <td>
				      	<input type="password" class="form-control"  name="newPwd" id="newPwd" oninput="newPwdCheck()" maxlength="20" placeholder="영문/숫자 필수, 특수문자 가능 4~20자 이내">
				      	<div id="pwdError2" class="text-primary"></div>
				      	<input type="hidden" name="pwd" id="pwd">
				      </td>
				    </tr>
			     	<tr>
				      <th><font color="red"><b>*&nbsp;</b></font><label for="name" class="password">이름</label></th>
				      <td>
				      	<input type="text" class="form-control"  name="name" id="name" oninput="nameCheck()" value="${vo.name}" maxlength="20" placeholder="한글 또는 영문 10자 이내">
				      	<div id="nameError" class="text-primary"></div>
				      </td>
				    </tr>
			     	<tr>
				      <th><font color="red"><b>*&nbsp;</b></font><label>주민등록번호</label></th>
				      <td>
				      	<div style="display: flex; align-items: center;">
							    <input type="text" class="form-control"  style="flex: 1;" name="birthday" id="birthday" maxlength="6" onkeyup="birthdayCheck()" value="${fn:substring(vo.resident, 0, 6)}" placeholder="주민등록번호 앞 6자리만">
							    <span>-</span>
							    <input type="text" class="form-control"  style="flex: 1;" name="gender" id="gender" maxlength="1" onkeyup="genderCheck()" value="${fn:substring(vo.resident, 7, 8)}" placeholder="주민등록번호 뒤 1자리만">
								</div>
								<input type="hidden" name="resident" id="resident"/>	
								<div id="residentError" class="text-primary"></div>  
				      </td>
				    </tr>
			     	<tr>
				      <th><font color="red"><b>*&nbsp;</b></font><label>전화번호</label></th>
				      <td>
				      	<div style="display: flex; align-items: center;">
							    <select name="tel1" id="tel1" class="form-control" style="flex: 2;">
			              <option value="010"  ${vo.tel1 == 010 ? "selected" : ""}>010</option>
			              <option value="02"  ${vo.tel1 == 02 ? "selected" : ""}>02</option>
					          <option value="032"  ${vo.tel1 == 032 ? "selected" : ""}>032</option>
					          <option value="033"  ${vo.tel1 == 033 ? "selected" : ""}>033</option>
					          <option value="041"  ${vo.tel1 == 041 ? "selected" : ""}>041</option>
					          <option value="042"  ${vo.tel1 == 042 ? "selected" : ""}>042</option>
					          <option value="043"  ${vo.tel1 == 043 ? "selected" : ""}>043</option>
			            </select>
			            <span>-</span>
	                <input type="text" class="form-control" name="tel2" id="tel2" maxlength="4" value="${vo.tel2}" onkeyup="telCheck()" placeholder="가운데 자리" style="flex: 4;"/>
	                <span>-</span>
	                <input type="text" class="form-control" name="tel3" id="tel3" maxlength="4" value="${vo.tel3}" onkeyup="telCheck()" placeholder="마지막 자리" style="flex: 4;"/>
								</div>
								<div id="telError" class="text-primary"></div>  
								<input type="hidden" name="tel" id="tel"/>	
				      </td>
				    </tr>
			    	<tr>
				      <th><font color="red"><b>*&nbsp;</b></font><label for="email">이메일</label></th>
				      <td>
				      	<div style="display: flex; align-items: center;">
					      	<input type="text" class="form-control"  name="email" id="email" value="${vo.email}" maxlength="20" placeholder="이메일 형식에 맞춰 입력해주세요" >
					      	<input class="blackLine-btn" type="button" name="emailCheckBtn" id="emailCheckBtn" value="이메일 인증" onclick="emailCheck()" style="margin-left: 10px;">
					      </div>
				      	<div id="emailError" class="text-primary"></div>
				      	<div id="demoSpin"></div>
				      </td>
				    </tr>
				    </table>
				    
	          <div style="font-size: 20px; font-weight: bold; margin-top: 20px;">선택 입력 사항</div>
	          <table class="table table-bordered" id="selectTable">
		          <tr>
						    <th style="text-align: left;">
						      <font color="black"><b>*&nbsp;</b></font><label for="address">주소</label>
						    </th>
						    <td>
			      	  	<div style="display: flex; align-items: center;">
								    <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" value="${vo.postcode}" class="form-control mb-1" style="width: 150px;" onclick="sample6_execDaumPostcode()" readonly>
								    <!-- 주소 찾기 버튼을 우편번호 입력 옆에 배치 -->
								    <input class="blackLine-btn" type="button" value="주소 찾기" onclick="sample6_execDaumPostcode()" style="margin-left: 10px;">
								  </div>
					      	<div id="homeAddressInput">
				            <div class="form-group">
								     	<div class="input-group">
								     		<input type="text" name="roadAddress" id="sample6_address" placeholder="주소" value="${vo.roadAddress}" class="form-control mb-1" onclick="sample6_execDaumPostcode()" readonly>
								     	</div>
								      <div class="input-group">
								        <div class="input-group-append" style="display: flex; width: 100%;">
								          <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" value="${vo.extraAddress}" class="form-control" style="flex: 4;" onclick="sample6_execDaumPostcode()" readonly>
								        	<input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" value="${vo.detailAddress}" class="form-control" style="flex: 6;">
								        </div>
								      </div>
								    </div>
								  </div>
								  <input type="hidden" name="address" id="address">
					      </td>
					    </tr>
					    <tr>
					      <th><font color="black"><b>*&nbsp;</b></font><label for="photo">프로필</label></th>
					      <td>
					      	<img src="${ctp}/data/member/${vo.photo}" width="100px"/>
					      	<br/><br/>
							  	<input type="file" name="fName" id="fName" class="form-control" accept=".jsp,.gif,.png,.jpg"/>
							  	<input type="hidden" name="photo" id="photo" value="${vo.photo}">
					      </td>
					    </tr>
					    <tr>
					      <th><font color="black"><b>*&nbsp;</b></font><label for="userInfor">개인정보</label></th>
					      <td style="vertical-align: middle;">
					      	<input type="radio" name="userInfor" id="userInforOK" value="공개" <c:if test="${vo.userInfor == '공개'}">checked</c:if> />
					      	<label for="userInforOK" class="form-label" style="margin-right: 10%;">공개</label>
          				<input type="radio" name="userInfor" id="userInforNO" value="비공개" <c:if test="${vo.userInfor == '비공개'}">checked</c:if> />
          				<label for="userInforNO" class="form-label">비공개</label>
					      </td>
					    </tr>
				    </table>
						<p><br/></p>
						<table class="table table-borderless">
						  <tr style="vertical-align: middle;">
						    <td style="vertical-align: middle;">
						      <button type="button" onclick="location.href='${ctp}/member/customerPage';" class="cancel-btn">취소</button>
						      <button type="button" onclick="updateCheck()" class="update-btn">회원정보수정</button>
						    </td>
						  </tr>
						</table>
			  	</div>
	      </div>
	    </div>
	  </div>
  </form>
<%-- <jsp:include page="/WEB-INF/views/include/footer.jsp"/> --%>
</body>
</html>