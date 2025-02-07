<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <link rel="icon" href="${ctp}/main/favicon.png">
	<title>로그인 | 회원가입</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <jsp:include page="/WEB-INF/views/include/fonts.jsp" />
	<link href="https://unicons.iconscout.com/release/v4.0.0/css/line.css" rel="stylesheet">
	<link href="https://unicons.iconscout.com/release/v4.0.0/css/unicons.css" rel="stylesheet">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	

  <style>
    @import url('https://fonts.googleapis.com/css?family=Poppins:400,500,600,700,800,900');

		body{
		  font-family: 'Poppins', sans-serif;
		  font-weight: 300;
		  font-size: 15px;
		  line-height: 1.7;
		  color: #c4c3ca;
		  margin: 0;
      height: 100vh;
		  display: flex;
      justify-content: center;
      align-items: center;
		  overflow-x: hidden;
		  overflow-y: hidden;
      background-color: hsl(210, 60%, 15%);
		}
		
		#snowball {
			clip-path: circle(50%);
			width: 220px;
			height: 220px;
		}

		.snowflake-area {
		  width: 220px;
		  height: 220px;
		  border-radius: 50%;
		  border: 1px solid rgba(255, 255, 255, 0.1);
		  position: absolute; /* 위치를 절대값으로 변경 */
		  top: 4%; /* 페이지 상단에서의 위치 */
		  left: 50%; /* 페이지 왼쪽에서의 위치 */
		  transform: translateX(-50%); /* 가로 중앙 정렬 */
		  background: radial-gradient(
		    circle,
		    rgba(255, 255, 255, 0.05) 60%,
		    rgba(255, 255, 255, 0.2) 80%
		  );
		  display: flex;
		  justify-content: center;
		  align-items: center;
		}

		/* Highlights */
		.snowflake-area::before {
			content: "";
			filter: blur(1px);
			position: absolute;
			width: 55%;
			height: 30%;
			top: 2%;
			left: 21%;
			border-radius: 50%;
			background-image: linear-gradient(
				to bottom,
				rgba(255, 255, 255, 0.15),
				rgba(255, 255, 255, 0)
			);
		}

		/* Reflections */
		.snowflake-area::after {
			content: "";
			border-radius: 30%;
			width: 200px;
			height: 230px;
			position: absolute;
			z-index: -1;
			bottom: -110px;
			left: 10px;
			transform: perspective(150px) rotatex(80deg);
			filter: blur(20px);
			background: radial-gradient(
				circle,
				rgba(255, 255, 255, 0.3) 10%,
				hsla(210, 60%, 30%, 0.8) 25%,
				rgba(255, 255, 255, 0.8) 40%
			);
		}
		
		.container {
			margin-top: 7%;
		}
		
		a {
		  cursor: pointer;
			text-decoration:none;
		  transition: all 200ms linear;
		}
		
		a:hover {
		  text-decoration: none;
		}
		
		.link {
			padding: 0 30px;
		  font-weight: 500;
			font-size: 18px;
		  line-height: 1.7;
		  color: gray;
		}
		
		.link:hover {
		  color: #345342;
		}
		
		h4 {
			font-size: 30px;
		  font-weight: 600;
		}
		
		h6 span{
		  padding: 0 20px;
		  text-transform: uppercase;
		  font-weight: 700;
		  font-size: 30px;
		}
		
		.section{
			margin: 0;
			padding: 0;
		  position: relative;
		  width: 100%;
		  display: block;
		}
		
		.full-height{
		  min-height: 100vh;
		}
		
		[type="checkbox"]:checked,
		[type="checkbox"]:not(:checked){
		  position: absolute;
		  left: -9999px;
		}
		
		.checkbox:checked + label,
		.checkbox:not(:checked) + label{
		  position: relative;
		  display: block;
		  text-align: center;
		  width: 60px;
		  height: 16px;
		  border-radius: 8px;
		  padding: 10px 0 0 0;
		  margin: 35px auto 10px auto;
		  cursor: pointer;
		  background-color: white;
		}
		.checkbox:checked + label:before,
		.checkbox:not(:checked) + label:before{
		  position: absolute;
		  display: block;
		  width: 36px;
		  height: 36px;
		  border-radius: 50%;
		  color: white;
		  background-color: #102770;
		  content: '↖';
		  z-index: 20;
		  top: -10px;
		  left: -10px;
		  line-height: 36px;
		  text-align: center;
		  font-size: 25px;
		  font-weight: bold;
		  transition: all 0.5s ease;
		}
		.checkbox:checked + label:before {
		  transform: translateX(44px) rotate(+450deg);
		}
		
		.card-3d-wrap {
		  position: relative;
			margin-top: 20px;
			margin-bottom: 0;
		  width: 800px;
		  max-width: 100%;
		  height: 650px;
		  transform-style: preserve-3d;
		  perspective: 800px;
		}
		.card-3d-wrapper {
		  width: 100%;
		  height: 100%;
		  position:absolute;    
		  top: 0;
		  left: 0;  
		  transform-style: preserve-3d;
		  transition: all 600ms ease-out; 
		}
		.card-front, .card-back {
		  width: 100%;
		  height: 100%;
		  background-color: white;
		  position: absolute;
		  border-radius: 6px;
		  left: 0;
		  top: 0;
		  transform-style: preserve-3d;
		  backface-visibility: hidden;
		}
		.card-back {
		  transform: rotateY(180deg);
		}
		.checkbox:checked ~ .card-3d-wrap .card-3d-wrapper {
		  transform: rotateY(180deg);
		}
		.center-wrap{
		  position: absolute;
		  color: #000B58;
		  width: 100%;
		  padding: 0 35px;
		  top: 50%;
		  left: 0;
		  transform: translate3d(0, -50%, 35px) perspective(100px);
		  z-index: 20;
		  display: block;
		}
		
		.form-group{ 
		  position: relative;
		  display: block;
		  margin: 0;
		  padding: 0;
		}
		
		.form-group input{ 
		  color: #003161;
		}
		
		.form-style {
			position: relative;
		  padding: 13px 20px 13px 55px;
		  height: 48px;
		  width: 100%;
		  font-weight: 500;
		  border-radius: 4px;
		  font-size: 14px;
		  line-height: 1.5;
		  letter-spacing: 0.5px;
		  outline: none;
		  background-color: white;
		  border: 1px solid #A8A196;
		  transition: box-shadow 200ms linear;
		}
		
		.signupform .form-style {
			position: relative;
		  padding: 10px 20px 10px 55px;
		  height: 43px;
		  width: 100%;
		  font-weight: 500;
		  border-radius: 4px;
		  font-size: 14px;
		  line-height: 1.5;
		  letter-spacing: 0.5px;
		  outline: none;
		  background-color: white;
		  border: 1px solid #A8A196;
		  transition: box-shadow 200ms linear;
		}
		
		.form-style:focus,
		.form-style:active {
		  outline: none;
		  background-color: white;
		  border: 1px solid #A8A196;
		  box-shadow: 0 4px 8px 0 rgba(21,21,21,.2);
		}
		
		.input-icon {
		  position: absolute;
		  top: 0;
		  left: 18px;
		  height: 48px;
		  font-size: 24px;
		  line-height: 48px;
		  text-align: left;
		  color: #9DB2BF;
		  transition: all 200ms linear;
		}
		
		.form-group input::placeholder  {
		  color: #a6a6a6;
		}
		
		.form-group input:focus::placeholder  {
		  opacity: 0;
		}
		
		.btn{  
			padding: 0;
		  border-radius: 4px;
		  height: 44px;
		  width: 100%;
		  font-size: 15px;
		  font-weight: bold;
		  text-transform: uppercase;
		  transition: all 200ms linear;
		  letter-spacing: 1px;
		  display: inline-flex;
		  align-items: center;
		  justify-content: center;
		  text-align: center;
		  border: none;
		  background-color: #102770;
		  color: white;
		}
		.btn:active,
		.btn:focus,
		.btn:hover{  
		  background-color: #ffeba7;
		  color: #102770;
		  border: 1 solid #102770;
		}
		
		#idSave{
			position: initial;
			width: 16px;
		  height: 16px;
		}
		
		.kakao-btn {
			display: flex;
			align-items: center;
			justify-content: center;
			text-align: center;
			height: 44px;
		  width: 100%;
			background-color: #FEE500;
			color: #000000;
			border-radius: 4px;
			font-size: 15px;
		  font-weight: bold;
		  letter-spacing: 1px;
			cursor: pointer;
			transition: background-color 0.3s;
			box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
		}
		
		.kakao-btn:active,
		.kakao-btn:focus,
		.kakao-btn:hover {
		  background-color: #e8c902;
		}
		
		.kakao-btn svg {
		  margin-right: 10px;
		}
		
		.error-text {
	    font-size: 13px;
	    text-align: left;
	    margin-top: 3px;
	    padding-left: 50px;
	    color: #003161;
	    font-weight: bold;
	  }
		
		.spinner-overlay {
	    position: fixed;
	    top: -20%;
	    left: 0;
	    width: 100%;
	    height: 650px;
	    background-color: transparent; 
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
		
		.logo {
    	font-family: '116watermelon';
    	padding-top: 30px;
    	padding-left: 50px;
	    font-size: 40px;
	    color: #afadb7;
	    position: absolute;  /* 화면 상에서 위치 고정 */
	    top: 0;  /* 화면 상단 */
	    left: 0;  /* 화면 왼쪽 */
	    z-index: 10;  /* 다른 요소들 위에 표시되도록 설정 */
  	}
  	
  	.logo a {
  		color: #afadb7;
  	}


  </style>
  <script>
  document.addEventListener("DOMContentLoaded", function () {
	  //Setup spin animation
	  const spin = gsap.timeline({ paused: true });
	  spin.from("#snowball", {
	    duration: 5,
	    rotate: 360,
	    transformOrigin: "50%,50%",
	    ease: "expo.out"
	  });

	  //Setup Canvas
	  const canvas = document.getElementById("snowball");
	  const ctx = canvas.getContext("2d");
	  canvas.width = 200;
	  canvas.height = 200;
	  let snowflakes = [];

	  function Snowflake(x, y, radius, speed, wind, alpha) {
	    this.x = x;
	    this.y = y;
	    this.radius = radius;
	    this.speed = speed;
	    this.wind = wind;
	    this.update = function () {
	      this.y += this.speed;
	      this.x += this.wind;
	      if (this.y > canvas.height) {
	        this.y = 0; // Reset to top
	        this.x = Math.random() * canvas.width; // Random X position
	      }
	    };

	    this.draw = function () {
	      ctx.beginPath();
	      ctx.arc(this.x, this.y, this.radius, 0, Math.PI * 2);
	      ctx.fillStyle = "white";
	      ctx.globalAlpha = alpha;
	      ctx.fill();
	    };
	  }

	  function createSnowflakes() {
	    spin.restart(); // Start spin animation
	    snowflakes = []; // Reset the array
	    let count = Math.floor(Math.random() * 301) + 100; // Random count between 100 and 400
	    for (let i = 0; i < count; i++) {
	      let x = Math.random() * canvas.width;
	      let y = Math.random() * canvas.height;
	      let radius = Math.random() * 3;
	      let speed = Math.random() * 0.1 + 1;
	      let wind = Math.random() * 2 - 1;
	      let alpha = Math.random() * 0.6 + 0.4;
	      snowflakes.push(new Snowflake(x, y, radius, speed, wind, alpha));
	    }
	  }

	  function animate() {
	    ctx.clearRect(0, 0, canvas.width, canvas.height);
	    snowflakes.forEach((snowflake) => {
	      snowflake.update();
	      snowflake.draw();
	    });

	    requestAnimationFrame(animate);
		  }
	
		  createSnowflakes();
		  animate();
		});
  
  /* 회원가입 */
  // 아이디 중복버튼을 클릭했는지의 여부를 확인하기 위한 변수(버튼 클릭 후엔 내용 수정처리 불가)
		let idCheckSw = 0;
 
		// 정규식 검사 함수
		let regMid = /^[a-zA-Z0-9]{4,20}$/; //(아이디) 영문자 또는 숫자 4~20자
	  let regPwd = /^(?=.*?[0-9])(?=.*?[a-zA-Z])[a-zA-Z0-9!@#$%^&*()._-]{4,20}$/;  //(비밀번호)4자 이상 20자 이하, 영어/숫자 1개 이상 필수, 특수문자 허용
	  let regName = /^[가-힣a-zA-Z]{1,10}$/;  // (성명)한글,영문만 적어도 1자이상 
 		let regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/; // 이메일 
 		let regTel = /\d{2,3}-\d{3,4}-\d{4}$/; //(전화번호)
 		let regBd = /^(0[0-9]|[1-9][0-9])(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])$/; //(birthday)
 		//let regex6 = /\d{6}[1-4]$/; //(resident-고객(주민등록번호):마지막자리는 성별을 나타내서 1-4까지의 숫자만 들어오도록)

 		/* 고 객 회 원 가 입 */		
		// 아이디 중복 검사 
		 function idCheck() {
    	let mid = signupform.mid.value;
    	
    	if(!regMid.test(mid)) {
    		alert("아이디는 4~20자리의 영문과 숫자만 사용가능합니다.");
    		signupform.mid.focus();
    		return false;
    	}
    	else {
    		$.ajax({
    			type : "post",
    			url  : "${ctp}/member/memberIdDuplicationCheck",
    			data : {mid : mid},
    			success:function(res) {
    				if(res != "0") alert("이미 사용중인 아이디 입니다.\n다른 아이디를 사용하세요.");
    				else {
    					alert("사용 가능한 아이디 입니다.");
			    		idCheckSw = 1;
			    		
			    		// signupform.mid를 사용해 스타일 적용
              signupform.mid.style.backgroundColor = "#f5f5f5";
              signupform.mid.style.borderColor = "#ddd";
              signupform.mid.style.color = "#aaa";
              signupform.mid.style.cursor = "not-allowed";
              
           		// 버튼 비활성화
              let idCheckBtn = document.getElementById("idCheckBtn");
              idCheckBtn.disabled = true;
              idCheckBtn.innerText = "아이디 중복확인 완료";
              idCheckBtn.style.color = "gray"; // 버튼 글씨 색 변경
    				}
    			},
    			error : function() {
    				alert("전송오류!");
    			}
    		});
    	}
    }
 		
		function midCheck() {
			//let regMid = /^[a-zA-Z0-9]{4,20}$/; //(아이디) 영문자 또는 숫자 4~20자 
			let mid = signupform.mid.value.trim();
			document.getElementById("midError").innerHTML="";
			const idCheckBtn = document.getElementById("idCheckBtn");
			
		  // 아이디 확인
		  if(!regMid.test(mid)) {
		    document.getElementById("midError").innerHTML="midCheck:아이디 형식에 맞춰주세요.(영어/숫자만 4~20자)";
		    idCheckBtn.style.transform = "translateY(9px)"; // 버튼 이동
		  } 
		  else {
			   idCheckBtn.style.transform = "translateY(9px)"; // 원래 위치로 복귀
			   document.getElementById("midError").innerHTML="";
		  }			
		}
		
		function pwdCheck() {
			//let regPwd = /^(?=.*[0-9])(?=.*[a-zA-Z])[a-zA-Z0-9!@#$%^&*()._-]{4,20}$/g; //(비밀번호)4자 이상 20자 이하, 영어/숫자 1개 이상 필수, 특수문자 허용
			let pwd = signupform.pwd.value.trim();
			document.getElementById("pwdError").innerHTML="";
			
		  // 비밀번호 확인
		  if(!regPwd.test(pwd)) {
		    document.getElementById("pwdError").innerHTML="pwdCheck:비밀번호가 올바르지 않습니다.(영어/숫자 필수, 특수문자 가능 4~20자)";
		  }
		  else {
		    document.getElementById("pwdError").innerHTML="";
		    signupform.pwd.addEventListener('keydown', function(event) {
	        if (event.key === 'Enter') {
        	  document.getElementById('name').focus();
	        }
		    });
	  	}	
		}
		
		function nameCheck() {
			//let regName = /^[가-힣a-zA-Z]{1,10}$/;  // (성명)한글,영문만 적어도 1자이상 
			let name = document.getElementById("name").value.trim();
			document.getElementById("nameError").innerHTML="";
			
		  // 성명 확인
		  if(!regName.test(name)){
		    document.getElementById("nameError").innerHTML="nameCheck:성명이 올바르지 않습니다.(한글/영문만 10자 이하)";
		  }
		  else {
			  document.getElementById("nameError").innerHTML="";
			  document.getElementById('name').addEventListener('keydown', function(event) {
	        if (event.key === 'Enter') {
        	  document.getElementById('email').focus();
	        }
		    });
		  }			
		}
		
		function birthdayCheck() {
			//let regBd = /\d{6}$/; //(birthday)
			let birthday = document.getElementById("birthday").value;
			document.getElementById("birthday").innerHTML="";
			
			// 생년월일 확인
			if(!regBd.test(birthday)){
			    document.getElementById("residentError").innerHTML="birthdayCheck: 주민등록번호가 올바르지 않습니다.(생년월일 + 성별(1~4))";
			  }
		  else {
			  document.getElementById("residentError").innerHTML="";
			  if (birthday.length >= 6) {
				  signupform.gender.focus();
	      }
		  }
		}
		
		function genderCheck() {
	    let gender = document.getElementById("gender").value.trim();
	    document.getElementById("residentError").innerHTML = "";

	    // 성별 값이 1~4 사이에 있는지 확인
	    if (gender < 1 || gender > 4 || isNaN(gender)) {
	        document.getElementById("residentError").innerHTML = "genderCheck: 주민등록번호가 올바르지 않습니다.(성별은 1~4 사이의 숫자여야 합니다)";
	    }
	    else {
        document.getElementById("residentError").innerHTML = "";
	    }
		}
		
		function telCheck() {
			//let regTel = /\d{2,3}-\d{3,4}-\d{4}$/g; //(전화번호)
		  let tel1 = signupform.tel1.value;
		  let tel2 = signupform.tel2.value;
		  let tel3 = signupform.tel3.value;
		  let tel = tel1 + "-" + tel2 + "-" + tel3;
		  
		  // 전화번호 확인
		  if(tel2===""){
		    document.getElementById("telError").innerHTML="전화번호의 가운데 자리를 입력해주세요.";
		  }
		  else if(tel3===""){
		    document.getElementById("telError").innerHTML="전화번호의 마지막 자리를 입력해주세요.";
		  }
		  else if(!regTel.test(tel)){
		    document.getElementById("telError").innerHTML="telCheck:전화번호 형식에 맞게 입력해주세요.";
		  }
		  else {
		    document.getElementById("telError").innerHTML="";
		    document.getElementById('tel3').addEventListener('keydown', function(event) {
	        if (event.key === 'Enter') {
	      	  document.getElementById('birthday').focus();
	        }
		    });
		  }
		}

		// 이메일 인증체크
	    function emailCheck() {
	    	// 필수입력란의 체크를 모두 마친후 인증번호를 메일로 발송한다.
	    	let email = $("#email").val();
	    	if(email.trim() == "") {
	    		alert("이메일을 입력하세요");
	    		$("#email").focus();
	    		return false;
	    	}
	    	let spin = "<div class='spinner-overlay'><div class='spinner-border'></div></div>";
	    	$("#demoSpin").html(spin);
	    	
 	    	$.ajax({
	    		type : "post",
	    		url  : "${ctp}/member/memberEmailCheck",
	    		data : {email : email},
	    		success:function(res) {
	    			if(res == 1) {
	    				alert("이 이메일은 이미 사용 중입니다.\n다른 이메일을 입력해주세요.");
	    				$("#demoSpin").html("");
	    			}
	    			else if(res == 2) {
	    				alert("인증번호가 발송되었습니다.\n메일 확인후 인증번호를 입력해주세요");
	    				addVerificationInput();
	    			}
	    			else alert("인증번호받기 버튼을 다시 눌러주세요");
	    		},
	    		error : function() {
	    			alert("전송오류");
	    		}
	    	});
	    }
		
	    function addVerificationInput() {
	        const demoSpin = document.getElementById("demoSpin");

	        // 전체 컨테이너 생성
	        const formGroup = document.createElement("div");
	        formGroup.classList.add("form-group");
	        formGroup.style.position = "relative";
	        formGroup.style.marginTop = "20px";

	        // 인증번호 입력 필드 생성
	        const checkKeyInput = document.createElement("input");
	        checkKeyInput.type = "text";
	        checkKeyInput.name = "checkKey";
	        checkKeyInput.id = "checkKey";
	        checkKeyInput.classList.add("form-style");
	        checkKeyInput.placeholder = "인증번호를 입력하세요";
	        checkKeyInput.style.flex = "1";
	        checkKeyInput.style.paddingRight = "120px";

	        // 인증번호 확인 버튼 생성
	        const checkOkBtn = document.createElement("button");
	        checkOkBtn.type = "button";
	        checkOkBtn.name = "emailCheckOkBtn";
	        checkOkBtn.id = "emailCheckOkBtn";
	        checkOkBtn.classList.add("btn");
	        checkOkBtn.style.position = "absolute";
	        checkOkBtn.style.right = "10px";
	        checkOkBtn.style.top = "-3px";
	        checkOkBtn.style.width = "150px";
	        checkOkBtn.style.height = "30px";
	        checkOkBtn.style.fontSize = "13px";
	        checkOkBtn.style.transform = "translateY(9px)";
	        checkOkBtn.style.transition = "transform 0.3s";
	        checkOkBtn.textContent = "인증번호확인";
	        checkOkBtn.onclick = emailCheckOk;  // 인증번호 확인 함수 호출

	        // 아이콘 생성
	        const icon = document.createElement("i");
	        icon.classList.add("input-icon", "uil", "uil-key-skeleton");

	        // 요소들 DOM에 추가
	        formGroup.appendChild(checkKeyInput);
	        formGroup.appendChild(checkOkBtn);
	        formGroup.appendChild(icon);
	        
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
			    		
			    		// signupform.email을 통해 이메일 입력 필드 스타일을 변경
			    		signupform.email.style.backgroundColor = "#f5f5f5";
	            signupform.email.style.borderColor = "#ddd";
	            signupform.email.style.color = "#aaa";
	            signupform.email.style.cursor = "not-allowed";
              
	            // 이메일 인증 버튼 비활성화
	            let emailCheckBtn = document.getElementById("emailCheckBtn");
	            emailCheckBtn.disabled = true;
	            emailCheckBtn.innerText = "이메일 인증 완료";
	            emailCheckBtn.style.color = "gray"; // 버튼 글씨 색 변경
			    		
			    		$("#demoSpin").hide();
			    		// 추가로 입력할부분을 show() 시켜준다.
			    		$("#addContent").show();
			      }
	    			else alert("인증실패\n메일주소를 확인하시고 다시 인증메일을 전송해 주세요.");
	    		},
	    		error : function() {
	    			alert("전송오류");
	    		}
	    	});
	    }
		
		// 회원가입 버튼 클릭시 체크
		function joinCheck(){
			let mid = signupform.mid.value;
		  let pwd = signupform.pwd.value;
		  let name = document.getElementById("name").value.trim();
	  	let email = document.getElementById("email").value.trim();
			let birthday = document.getElementById("birthday").value.trim();
			let gender = document.getElementById("gender").value.trim();
	  	 
		  let tel1 = signupform.tel1.value;
		  let tel2 = signupform.tel2.value;
		  let tel3 = signupform.tel3.value;
		  let tel = tel1 + "-" + tel2 + "-" + tel3;
	  	
		  let resident = birthday + "-" + gender; 
			
		  // 아이디 확인
		  if(!regMid.test(mid)) {
		    document.getElementById("midError").innerHTML="아이디 형식에 맞춰주세요.(영어/숫자만 4~20자)";
		    signupform.mid.focus();
		    return false;
		  } 
		  else {
			   document.getElementById("midError").innerHTML="";
		  }
		  
		  // 비밀번호 확인
		  if(!regPwd.test(pwd)) {
		    document.getElementById("pwdError").innerHTML="비밀번호가 올바르지 않습니다.(영어/숫자 필수, 특수문자 가능 4~20자)";
		    signupform.pwd.focus();
		    return false;
		  }
		  else {
		    document.getElementById("pwdError").innerHTML="";
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
		  // 아이디 중복체크
	    if(idCheckSw == 0) {
				alert("아이디 중복확인을 해주세요.");
				document.getElementById("mid").focus();
			} 
			else {
		    signupform.mid.value = mid;
		    signupform.email.value = email;
		    signupform.tel.value = tel;
		    signupform.resident.value = resident;
		    
		   	
		    signupform.submit();
			}
		}
		
		// 카카오 로그인앱키
		window.Kakao.init("");

		function kakaoLogin() {
			let spin = "<div class='spinner-overlay'><div class='spinner-border'></div></div>";
	    	$("#kakaoSpin").html(spin);
	    	
	  	window.Kakao.Auth.login({
	  		scope: 'profile_nickname, account_email',
	  		success:function(autoObj) {
	  			console.log(Kakao.Auth.getAccessToken(), "정상적으로 토큰이 발급됨");
	  			window.Kakao.API.request({
	  				url : '/v2/user/me',
	  				success:function(res) {
	  					const kakao_account = res.kakao_account;
	  					console.log("전송된정보 :",kakao_account);
	  					location.href="${ctp}/member/kakaoLogin?name="+kakao_account.profile.nickname+"&email="+kakao_account.email+"&accessToken="+Kakao.Auth.getAccessToken();
	  				}
	  			});
	  		}
	  	});
		}
  </script>
</head>
<body>
	<!-- 중앙 로고 -->
  <div class="logo">
   	<a href="${ctp}/main" style="text-align: left;">
   		<i class="fa-solid fa-caret-left"></i>
	   	LUMI
   	</a>
  </div>
	<!-- 스노우볼 영역 -->
	<div class="snowflake-area">
		<canvas id="snowball" width="200" height="200"></canvas>
	</div>
	
	 <!-- 로그인 & 회원가입 -->
	<div class="container">
    <div class="section">
      <div class="row full-height justify-content-center">
        <div class="col-12 text-center align-self-center">
          <div class="section text-center">
            <h6 class="mb-0 row-layout">
            	<span>Log In </span>
            	<span>Sign Up</span>
          	</h6>
            <input class="checkbox" type="checkbox" id="reg-log" name="reg-log"/>
            <label for="reg-log"></label>
            
            <!-- 3D 카드 -->
            <div class="card-3d-wrap mx-auto">
              <div class="card-3d-wrapper">
              
		          	<!-- 로그인 -->
                <div class="card-front">
          				<form name="loginform" method="post" action="${ctp}/member/memberLogin">
	                  <div class="center-wrap" style="padding: 0 20%;">
	                    <div class="section text-center">
	                      <h4 style="padding-bottom: 12%;">LOGIN</h4>
	                      <div class="form-group">
	                        <input type="text" name="mid" id="mid" value="${cMid}" class="form-style" placeholder="아이디를 입력하세요." autocomplete="off">
	                        <i class="input-icon uil uil-user"></i>
	                      </div>  
	                      <div class="form-group mt-4">
	                        <input type="password" name="pwd" id="pwd" class="form-style" placeholder="비밀번호를 입력하세요" autocomplete="off">
	                        <i class="input-icon uil uil-lock-alt"></i>
	                      </div>
	                      <div class="form-group my-3" style="text-align: right; color: #a6a6a6;">
	                      	<input type="checkbox" name="idSave" id="idSave" checked/>
	                      	<span >아이디 저장</span>
	                      </div>
	                      <div class="mt-2">
		                      <button type="submit" class="btn mb-3">LOGIN</button>
		                      <a href="javascript:kakaoLogin()" class="kakao-btn">
			                      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" style="margin-right: 10px;">
	                 						<path fill="#000000" d="M12.001 2C6.477 2 2 5.862 2 10.5c0 2.808 1.68 5.29 4.315 6.822-.193.703-.693 2.524-.793 2.866 0 0-.015.137.073.186s.177.018.177.018c.234 0 .344-.137.344-.137 0-.015 1.416-.958 2.445-1.545.47.073.95.11 1.438.11 5.524 0 10.001-3.863 10.001-8.5S17.525 2 12.001 2z"/>
	             							</svg>
	             							카카오 로그인
             							</a>
             							
	                      </div>
	                      <div id="kakaoSpin"></div>
	                      <div class="mt-5">
	                        <span><a href="${ctp}/member/searchAccount" class="link" >Forgot your account?</a></span>
                        </div>
											</div>
                    </div>
									</form>
								</div>
								
	              <!-- 회원가입 -->
	              <div class="card-back">
		              <form name="signupform" class="signupform" method="post" action="${ctp}/member/memberJoin">
	                	<div class="center-wrap">
	                    <div class="section text-center" style="padding: 20px 30px;">
	                    <h4 style="margin-bottom: 40px;">SIGN UP</h4>
	                    <!-- 아이디 -->
                      <div class="form-group" style="position: relative;">
											  <input type="text" name="mid" class="form-style" oninput="midCheck()" maxlength="20" placeholder="영문과 숫자를 포함한 4~20자 이내" autocomplete="off" style="flex: 1; padding-right: 120px;">
											  <button type="button" id="idCheckBtn" class="btn" onclick="idCheck()" style="position: absolute; right: 10px; top: -3px; width:150px; height:30px; font-size:13px; transform: translateY(9px); transition: transform 0.3s;">아이디 중복체크</button>
											  <i class="input-icon uil uil-user"></i>
											</div>
										  <div id="midError" class="error-text"></div>
										  <!-- 비밀번호 -->
	                    <div class="form-group" style="margin-top: 20px;">
	                      <input type="password" name="pwd" class="form-style" oninput="pwdCheck()" maxlength="20" placeholder="영문/숫자 필수, 특수문자 가능 4~20자 이내" autocomplete="off">
	                      <i class="input-icon uil uil-lock-alt"></i>
	                    </div>
                      <div id="pwdError" class="error-text"></div>
                      <!-- 이름 -->
	                    <div class="form-group" style="margin-top: 20px;">
	                      <input type="text" name="name" id="name" class="form-style" onchange="nameCheck()" maxlength="10" placeholder="한글 또는 영문 10자 이내" autocomplete="off">
	                      <i class="input-icon uil uil-users-alt"></i>
	                      <div id="nameError" class="error-text"></div>
	                    </div>  
                      <!-- 이메일 -->
	                    <div class="form-group" style="position: relative; margin-top: 20px;">
	                      <input type="text" name="email" id="email" class="form-style" placeholder="이메일 형식에 맞춰 입력해주세요" autocomplete="off" style="flex: 1; padding-right: 120px;">
	                      <button type="button" name="emailCheckBtn" id="emailCheckBtn" class="btn" onclick="emailCheck()" style="position: absolute; right: 10px; top: -3px; width:150px; height:30px; font-size:13px; transform: translateY(9px); transition: transform 0.3s;">이메일 인증</button>
	                      <i class="input-icon uil uil-at"></i>
	                      <div id="emailError" class="error-text"></div>
	                    </div>  
                      <div id="demoSpin"></div>
                      <!-- 이메일 인증시 보이는 부분 -->
                      <div id="addContent" style="display:none;">
	                      <!-- 전화번호 -->
		                    <div class="form-group" style="white-space: nowrap; text-align: left; width: 100%; margin: 20px 0 0 0; padding: 0;">
												  <!-- TEL1 (셀렉트 박스) -->
												  <select name="tel1" id="tel1" class="form-style" style="color: #003161; width: 22%; display: inline-block; vertical-align: middle; padding: 10px; text-align: right;">
												    <option value="010" selected>010</option>
												    <option value="02">02</option>
												    <option value="032">032</option>
												    <option value="033">033</option>
												    <option value="041">041</option>
												    <option value="042">042</option>
												    <option value="043">043</option>
												  </select>
												  <span style="margin: 0 5px; color:#c9c7c7;">-</span>
												  <!-- 가운데 자리 -->
												  <input type="text" class="form-style" name="tel2" id="tel2" maxlength="4" onkeyup="telCheck()" placeholder="가운데 자리" style="padding: 0; width: 35%; display: inline-block; vertical-align: middle; text-align: center;">
												  <span style="margin: 0 5px; color:#c9c7c7;">-</span>
												  <!-- 마지막 자리 -->
												  <input type="text" class="form-style" name="tel3" id="tel3" maxlength="4" onkeyup="telCheck()" placeholder="마지막 자리" style="padding: 0; width: 35%; display: inline-block; vertical-align: middle; text-align: center;">
												  <!-- 아이콘 -->
												  <i class="input-icon uil uil-phone" style="vertical-align: middle;"></i>
												</div>
											  <div id="telError" class="error-text"></div>
											  <input type="hidden" name="tel" id="tel"/>
											  <!-- 주민등록번호 -->
		                    <div class="form-group" style="white-space: nowrap; text-align: left; width: 100%; margin: 20px 0 0 0; padding: 0;">
												  <input type="text" name="birthday" id="birthday" class="form-style" maxlength="6" onkeyup="birthdayCheck()"  placeholder="주민등록번호 앞 6자리만" autocomplete="off" style="padding: 13px 20px; width: 50%; display: inline-block; vertical-align: middle; text-align: center;">
												  <span style="margin: 0 5px; color:#c9c7c7">-</span>
												  <input type="text" name="gender" id="gender" class="form-style" maxlength="1" onkeyup="genderCheck()"  placeholder="주민등록번호 뒤 1자리만" autocomplete="off" style="padding: 13px 20px; width: 46%; display: inline-block; vertical-align: middle; text-align: center;">
												  <i class="input-icon uil uil-registered"></i>
												  <input type="hidden" name="resident" id="resident"/>
												</div>
											  <div id="residentError" class="error-text"></div>
											</div>
										  <!-- 회원가입 버튼 -->
                     	<div>
	                      <button type="button" class="btn" onclick="joinCheck()" style="margin-top: 30px; margin-bottom: 15px;">SIGN UP</button>
	                      <input type="hidden" name="level" id="level" value="1">
												<a href="javascript:kakaoLogin()" class="kakao-btn">
												  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="20" height="20" style="margin-right: 10px;">
														<path fill="#000000" d="M12.001 2C6.477 2 2 5.862 2 10.5c0 2.808 1.68 5.29 4.315 6.822-.193.703-.693 2.524-.793 2.866 0 0-.015.137.073.186s.177.018.177.018c.234 0 .344-.137.344-.137 0-.015 1.416-.958 2.445-1.545.47.073.95.11 1.438.11 5.524 0 10.001-3.863 10.001-8.5S17.525 2 12.001 2z"/>
													</svg>
													카카오 회원가입
												</a>
											</div> 
	                  	</div>
	                	</div>
	          			</form>
	          		</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>