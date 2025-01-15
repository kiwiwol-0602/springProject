<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>아이디 찾기</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <style>
        /* 전체 스타일 */

        /* 헤더 스타일 */
        .search > .row > div {
            font-size: 18px;
            font-weight: 500;
        }

        /* 버튼 스타일 */
        .search .btn {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            font-size: 14px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .search .btn:hover {
            background-color: #45a049;
        }

        /* 입력 필드 스타일 */
        .search .form-group input {
            border-radius: 5px;
            padding: 10px;
            border: 1px solid #ddd;
            width: calc(100% - 170px);
            margin-right: 10px;
        }

        .search .form-group button {
            width: 150px;
            height: 40px;
            font-size: 14px;
            background-color: #4CAF50;
            color: white;
            border-radius: 5px;
            border: none;
        }

        /* 스피너 스타일 */
        .search .spinner-border {
            width: 40px;
            height: 40px;
            border-width: 4px;
            color: #FFF4B7; 
        }

        /* 아이디 찾기 후 내용 표시 영역 스타일 */
        .search #addContent {
            margin-top: 20px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        .search .input-icon {
            position: absolute;
            top: 12px;
            left: 15px;
            font-size: 20px;
            color: #aaa;
        }

        /* Error 텍스트 스타일 */
        .search .error-text {
            color: red;
            margin-top: 10px;
        }

        /* 숨겨진 요소 */
        .search #searchIdSpin, .search #addContent {
            display: none;
        }

    </style>
</head>
<body>
    <div class="search container">
        <c:if test="${empty vo}">
            <div>입력하신 정보에 해당되는 아이디가 존재하지 않습니다.</div>
        </c:if>
        <c:if test="${!empty vo}">
            <div>
                <div class="mb-3">
                    <h5>고객님 아이디 찾기가 완료되었습니다.</h5>
                    <hr style="width: 400px;"/>
                    <p><strong>이름:</strong> ${vo.name}</p>
                    <p><strong>이메일:</strong> ${vo.email}</p>
                    <hr style="width: 400px;"/>
                    <p>
                        <c:set var="mid" value="${vo.mid}" />
                        ${fn:substring(mid, 0, 3)}**** (${fn:substring(vo.joinDay, 0, 16)} 가입)
                    </p>
                </div>

                <button type="button" class="btn" onclick="allIdCheck()">전체아이디 확인</button>

                <div id="emailCheck" style="display:none; margin-top: 20px;">
                    <div class="form-group" style="position: relative;">
                        <input type="text" name="email" id="email" class="form-style" placeholder="이메일 형식에 맞춰 입력해주세요" autocomplete="off" style="flex: 1; padding-right: 120px;">
                        <button type="button" name="emailCheckBtn" id="emailCheckBtn" class="btn" onclick="emailCheck()">이메일 인증</button>
                        <i class="input-icon uil uil-at"></i>
                        <div id="emailError" class="error-text"></div>
                    </div>

                    <div id="searchIdSpin"></div>
                    <div id="addContent">
                        <p><strong>전체 아이디:</strong> ${vo.mid}</p>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <script type="text/javascript">
        function allIdCheck() {
            $(".search #emailCheck").show();
        }

        function emailCheck() {
            let email = $("#email").val();
            if(email.trim() == "") {
                alert("이메일을 입력하세요");
                $("#email").focus();
                return false;
            }
            let spin = "<div class='spinner-border'></div>";
            $(".search #searchIdSpin").html(spin);
            $(".search #searchIdSpin").show();

            $.ajax({
                type: "post",
                url: "${ctp}/member/emailCheck",
                data: { email: email },
                success: function(res) {
                    if(res == 1) {
                        alert("인증번호가 발송되었습니다.\n메일 확인 후 인증번호를 입력해주세요");
                        addVerificationInput();
                    } else {
                        alert("인증번호 받기 버튼을 다시 눌러주세요");
                    }
                },
                error: function() {
                    alert("전송 오류");
                }
            });
        }

        function addVerificationInput() {
            const searchIdSpin = $(".search #searchIdSpin")[0];

            // 인증번호 입력 필드 생성
            const formGroup = document.createElement("div");
            formGroup.classList.add("form-group");
            formGroup.style.position = "relative";
            formGroup.style.marginTop = "20px";

            const checkKeyInput = document.createElement("input");
            checkKeyInput.type = "text";
            checkKeyInput.name = "checkKey";
            checkKeyInput.id = "checkKey";
            checkKeyInput.classList.add("form-style");
            checkKeyInput.placeholder = "인증번호를 입력하세요";
            checkKeyInput.style.flex = "1";
            checkKeyInput.style.paddingRight = "120px";

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
            checkOkBtn.textContent = "인증번호 확인";
            checkOkBtn.onclick = emailCheckOk;

            const icon = document.createElement("i");
            icon.classList.add("input-icon", "uil", "uil-key-skeleton");

            formGroup.appendChild(checkKeyInput);
            formGroup.appendChild(checkOkBtn);
            formGroup.appendChild(icon);

            searchIdSpin.innerHTML = '';  // 기존 내용을 지우고 새로 추가
            searchIdSpin.appendChild(formGroup);
            $(".search #addContent").show();
        }

        function emailCheckOk() {
            let checkKey = $("#checkKey").val();
            if (checkKey.trim() == "") {
                alert("전송받은 메일에서 인증받은 인증키를 입력해주세요");
                return false;
            }

            $.ajax({
                type: "post",
                url: "${ctp}/member/memberEmailCheckOk",
                data: { checkKey: checkKey },
                success: function(res) {
                    if (res != "0") {
                        alert("인증 확인되었습니다.");
                        $(".search #email").css("background-color", "#f5f5f5");
                        $(".search #email").css("borderColor", "#ddd");
                        $(".search #email").css("color", "#aaa");
                        $(".search #email").css("cursor", "not-allowed");
                        let emailCheckBtn = $(".search #emailCheckBtn")[0];
                        emailCheckBtn.disabled = true;
                        emailCheckBtn.innerText = "이메일 인증 완료";
                        emailCheckBtn.style.color = "gray"; 
                        $(".search #searchIdSpin").html('');
                        $(".search #searchIdSpin").hide();
                        $(".search #addContent").show();
                    } else {
                        alert("인증 실패\n메일주소를 확인하시고 다시 인증메일을 전송해 주세요.");
                    }
                },
                error: function() {
                    alert("전송 오류");
                }
            });
        }
    </script>
</body>
</html>
