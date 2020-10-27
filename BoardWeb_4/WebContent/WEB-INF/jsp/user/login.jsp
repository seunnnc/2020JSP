<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>로그인</title>
         <style>
            * {
            	font-family: 'Noto Sans KR', sans-serif;
            	background: #fcfefe;
            }
            *:focus {
            	outline:none;
            }
            .container {
            	width: 300px;
            	margin: 80px auto;
            	border-radius: 7%;
            	background: #e7e7db;
            	padding: 20px;
            }
            h1 {
            	background: #e7e7db;
            	margin-bottom: 10px;
            	color: #331606;
            	font-size: 1.8em;
            	text-align: center;
            }
            #frm{
            	background: #e7e7db;
            	margin : 20px;
            	margin-top: 40px;
            }
            #frm input {
            	background: #e7e7db;
            	width: 200px;
            	padding: 7px;
            	border: 0;
            	border-bottom: 2px solid #331606;
            	margin: 0px 0px 10px 20px;
            	color: #331606;
            	text-indent: 10px;
            	font-weight: bold;
            }
            #frm input:-webkit-autofill,
			#frm input:-webkit-autofill:hover,
			#frm input:-webkit-autofill:focus,
			#frm input:-webkit-autofill:active {
    			-webkit-transition: "color 9999s ease-out, background-color 9999s ease-out";
    			-webkit-transition-delay: 9999s;
			}
            #frm div {
            	margin : 20px;
            	background: #e7e7db;
            }
            #frm button {
            	width: 84px;
            	background-color: #babc99;
            	text-align: center;
            	border: none;
            	padding: 8px;
            	color: #331606;
            	border-radius: 10px;
            	margin-top: 20px;
            	margin-left: 126px;
            	font-weight : bolder;
            }
             #join {
            	background: #e7e7db;
            	text-decoration: none;
            	color: #331606;
            	margin: 10px;
            	font-weight: bold;
            }
            .err {
            	background: #e7e7db;
            	color: #ff6f69;
            	text-align: center;
            	font-size: 0.9em;
            	font-weight : bold;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Login</h1>
            <form id="frm" action="/login" method="post">
				<input type="text" name="user_id" placeholder="아이디" autofocus value="${user_id }">
                <input type="password" name="user_pw" placeholder="비밀번호">
                <div><button type="submit">로그인</button></div>
            </form>
            <div class="err">${msg }</div>
            <a href="/join" id="join">JOIN</a>
        </div>
    </body>
</html>