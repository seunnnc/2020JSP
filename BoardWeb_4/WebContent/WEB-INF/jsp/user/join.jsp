<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>회원가입</title>
        <link
            href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@500&display=swap"
            rel="stylesheet"
        />
         <style>
            * {
                font-family: "Noto Sans KR", sans-serif;
                background-color: #fcfefe;
            }
            *:focus {
                outline: none;
            }
            #container {
                width: 450px;
                margin: 80px auto;
                border-radius: 7%;
                background: #e7e7db;
                padding: 20px;
            }
            h1 {
            background: #e7e7db;
                margin: 10px;
                color: #331606;
                font-size: 1.8em;
                text-align: center;
                letter-spacing: 3px;
            }
            #frm {
                margin: 20px;
                background: #e7e7db;
            }
            #frm label {
            	background: #e7e7db;
                width: 100px;
                float: left;
                text-align: right;
                margin-right: 25px;
                color: #331606;
                font-size: 0.9em;
                padding: 6px;
            }
            #frm div {
                margin: 20px;
                background: #e7e7db;
            }
            #frm input {
            	background: #f1f1ea;
                width: 200px;
                padding: 7px;
                border: none;
                border-radius: 20px;
                color: #331606;
                text-indent: 10px;
            }
            #frm input:hover {
                box-shadow: 1px 1px 1.5px 1px #e3e4d6;
                transition-delay: 0.07s;
                border: none;
            }
            #frm button {
                width: 90px;
                background-color: #babc99;
                text-align: center;
                border: none;
                padding: 8px;
                color: #331606;
                border-radius: 10px;
                margin-top: 20px;
                margin-left: 138px;
                font-weight: bold;
            }
            #login {
                text-decoration: none;
                color: #331606;
                margin: 20px;
                font-weight: bold;
                background: #e7e7db;
            }
            .err {
                color: #ff6f69;
                text-align: left;
                font-size: 0.9em;
                background: #e7e7db;
            }
        </style>
    </head>
    <body>
        <div id="container">
            <h1>회원가입</h1>
                <form id="frm" action="/join" method="post" onsubmit="return chk()">
                    <div>
                        <label>아이디</label>
                        <input type="text" name="user_id" placeholder="아이디" value="${data.user_id }" required>
                    </div>
                    <div>
                        <label>비밀번호</label>
                        <input type="password" name="user_pw" placeholder="비밀번호" required>
                    </div>
                    <div>
                        <label>비밀번호 확인</label>
                        <input type="password" name="user_pwre" placeholder="비밀번호 확인" required>
                    </div>
                    <div>
                        <label>이름</label>
                        <input type="text" name="nm" placeholder="이름" value="${data.nm }" required>
                    </div>
                    <div>
                        <label>이메일</label>
                        <input type="email" name="email" placeholder="이메일" value="${data.email }">
                    </div>
                    <div>
                    	<button type="submit">SUBMIT</button>
                    </div>
                </form>
            <a href="login" id="login">LOGIN</a>
            <div class="err">${msg }</div>
        </div>
        <script>
            function chk() {
                if (frm.user_id.value.length < 5) {
                    alert("아이디는 5글자 이상이 되어야 합니다");
                    frm.user_id.focus();
                    return false;
                } else if (frm.user_pw.value.length < 5) {
                    alert("비밀번호는 5글자 이상이 되어야 합니다");
                    frm.user_pw.focus();
                    return false;
                } else if (frm.user_pw.value != frm.user_pwre.value) {
                    alert("비밀번호가 일치하지 않습니다");
                    frm.user_pw.focus();
                    return false;
                } else if (frm.nm.value.length > 0) {
                    const korean = /[^가-힣]/;
                    if (korean.test(frm.nm.value)) {
                        alert("올바른 이름을 입력하세요");
                        frm.nm.focus();
                        return false;
                    }
                }
                if (frm.email.value.length > 0) {
                    const email = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
                    if (!email.test(frm.email.value)) {
                        alert("이메일을 확인해 주세요");
                        frm.email.focus();
                        return false;
                    }
                }
            }
        </script>
    </body>
</html>