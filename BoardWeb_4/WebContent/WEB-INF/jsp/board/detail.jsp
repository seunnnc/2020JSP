<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>상세페이지</title>
		<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
		<style>
			* {
				font-family: 'Noto Sans KR', sans-serif;
				background-color: #fcfefe;
			}
		
			*:focus {
				outline: none;
			}
			
			.container {
				width: 700px;
				margin: 30px auto;
			}
		
			table {
				width: 700px;
				border: 1px solid #331606;
				border-collapse: collapse;
			}
		
			tr, th, td {
				padding: 8px;
				border: 1px solid #331606;
			}
		
			.detail #title {
				border-bottom: 1px solid #331606;
                color: #331606;
			}
            .detail #title-1 {
                border-bottom: 1px solid #331606;
                color: black;
            }
			
			.detail #nm {
				width: 10%;
				text-align: center;
                color: #331606;
			}
			
			.detail #nm-1 {
				width: 28%;
                color: black;
			}
			
			.detail #date {
				width: 14%;
				text-align: center;
                color: #331606;
			}
			
			.detail #date-1 {
				width: 28%;
				text-align: center;
                color: black;
			}
			
			.detail #hits {
				width: 10%;
				text-align: center;
                color: #331606;
			}
			
			.detail #hits-1 {
				width: 10%;
				text-align: center;
                color: black;
			}
			#like {
				width: 33px;
				border-left: none;
				cursor: pointer;
				float: right;
				margin: 20px 340px 0px 0px;
				border: 1.5px solid #babc99;
				border-radius: 5px;
				padding: 2px 5px;
			}
			#like-color {
				color: #ffa500;
				font-size: 1.1em;
			}
			.far, .fas {
				color: #ffe12b;
				font-size: 1em;
			}
			.ctnt {
				width: 678.5px;
				border-bottom: 1.5px solid #331606;
				height: 200px;
				padding: 10px 10px 0px 10px;
                color: black;
			}
			.btn a {
				display:inline-block;
		    	width: 65px;
		    	height: 26px;
		    	margin-top: 20px;
		    	margin-right: 3px;
		    	padding: 1px;
		    	text-align:center;
		    	border-radius: 10px;
		    	background-color: #babc99;
			}
			.btn button {
				width: 65px;
				height: 26px;
				background-color: #babc99;
				text-align: center;
				border: none;
				padding: 1px;
				color: #331606;
				border-radius: 10px;
				margin-right: 3px;
				font-weight: bold;
				font-size: 0.9em;
			}
			
			#delFrm {
				display: inline-block;
			}
			
			#cmtFrm {
				margin: 20px 0px;
				display:inline-block;
			}
			
			#cmtFrm input[type="text"] {
				width: 580px;
				height: 40px;
				margin: 10px 0px 10px 5px;
				text-indent: 10px;
			}
			/*
			#cmtFrm textarea {
				display: inline-block;
				width: 620px;
				height: 40px;
				margin: 10px 0px 10px 5px;
				text-indent: 10px;
			}*/
			#cmtFrm button {
				width: 40px;
				border: none;
				background-color: #babc99; 
				border-radius: 5px;
				padding: 6px;
				margin: 0px 0px 0px 6px;
			}
			.comment table {
				width: 700px;
				border-collapse: collapse; 
				border: 1.5px solid #babc99; 
			}
			.comment td,tr {
				border-top: 1.5px solid #babc99;
				border-bottom: 1.5px solid #babc99;
			}
			.comment #cmt {
				width: 53%;
				text-indent: 10px;
				font-size: 0.9em;
			}
			.comment #cmt-nm {
				width: 17%;
				text-align: center;
			}
			.comment #cmt-r_dt {
				width: 14%;
			}
			.comment #cmt-btn {
				width: 16%;
			}
			.comment #cmt-btn button {
				width: 34px;
				height: 24px;
				border: none;
				border-radius: 4px;
				background-color: #babc99; 
				padding: 2px;
				margin-right: 5px;
				text-align: center;
			}
			.comment #cmt-btn a {
				display:inline-block;
				width: 34x;
				height: 24px;
				border: none;
				border-radius: 4px;
				background-color: #babc99; 
				padding: 2px;
				margin-right: 5px;
				text-decoration: none;
				text-align:center;
			}
			.comment span {
				margin-left: 15px;
			}
		</style>
	</head>
	
	<body>
		<div class="container">
			<table class="detail">
				<tr>
					<th id="title">제목</th>
					<td id="title-1" colspan="5">
						${data.title}
					</td>
				</tr>
				<tr>
					<th id="nm">작성자</th>
					<td id="nm-1">${data.nm }</td>
					<th id="date">작성일시</th>
					<td id="date-1">${data.r_dt == data.m_dt ? data.r_dt : data.m_dt}</td>
					<th id="hits">조회수</th>
					<td id="hits-1">${data.hits }</td>
				</tr>
			</table>
			<div class="ctnt">${data.ctnt }</div>
			
			<div class="btn">
				<c:set var="loginUser.i_user" value="data.i_user" />
				<c:choose>
					<c:when test="${loginUser.i_user eq data.i_user}">
		        		<a href="/board/list">
		        			<button type="button">목록</button>
		        		</a>
						<a href="/board/regmod?i_board=${data.i_board}">
							<button type="submit" id="mod">수정</button>
						</a>
						<form id="delFrm" action="/board/del" method="post">
							<input type="hidden" name="i_board" value="${data.i_board}">
								<button type="submit" onclick="submitDel()">삭제</button>
						</form>
		    		</c:when>
					<c:otherwise>
		        		<a href="/board/list">
		        			<button type="button">목록</button>
						</a>
		    		</c:otherwise>
				</c:choose>
				<span id="like" onclick="toggleLike(${data.yn_like})">
					<c:set var="data.yn_like" value="0" />
					<c:choose>
						<c:when test="${data.yn_like eq 0 }">
							<i class="far fa-thumbs-up"></i>
						</c:when>
						<c:otherwise>
							 <i class="fas fa-thumbs-up"></i>
						</c:otherwise>
					</c:choose>
					<span id="like-color">${data.like_count }</span>
				</span>
			</div>
			
			<div>
				<form id="cmtFrm" action="/board/cmt" method="post">
					<input type="hidden" name="i_cmt" value="0">
					<input type="hidden" name="i_board" value="${data.i_board}">
					<input type="text" name="cmt" placeholder="댓글을 작성하세요 (최대 240자)" maxlength=240>
					<!--  <textarea name="cmt" placeholder="댓글을 작성하세요 (최대 240자)" maxlength="240"></textarea>-->
					<button type="submit" id="cmtSubmit">등록</button>
					<button type="button" onclick="clkCmtCancel()">취소</button>
				</form>
			</div>
			<div class="cmt-list">
				<table class="comment">
					<c:forEach items="${cmtList}" var="item">
	                    <tr>
	                        <td id="cmt">${item.cmt}</td>
	                        <td id="cmt-nm">${item.nm}</td>
	                        <td id="cmt-r_dt">${item.r_dt == item.m_dt ? item.r_dt : item.m_dt}</td>
	                        <td id="cmt-btn">
	                        	<span>
			                        <c:if test="${loginUser.i_user == item.i_user }">
			                       		<button type="submit" onclick="clkCmtMod(${item.i_cmt}, '${item.cmt }')">수정</button>
				                       	<button type="submit" onclick="clkCmtDel(${item.i_cmt})">삭제</button>
			                        </c:if>
		                        </span>
							</td>
	                    </tr>
                	</c:forEach>
				</table>
			</div>
		</div>
		<script>
	        function submitDel() {
	        	delFrm.submit()
	        }
	        
	        function toggleLike(yn_like) {
	        	location.href='/board/toggleLike?i_board=${data.i_board}&yn_like=' + yn_like
	        }
	        
	        function clkCmtMod(i_cmt, cmt) {
	        	console.log('i_cmt:' + i_cmt)
	        	
	        	cmtFrm.i_cmt.value = i_cmt
	        	cmtFrm.cmt.value = cmt
	        	
	        	cmtSubmit.value = '수정'
	        }

	        function clkCmtCancel() {
	        	cmtFrm.i_cmt.value = 0
	        	cmtFrm.cmt.value = ''
	        	cmtSubmit.value = '전송'
	        }
	        
	        function clkCmtDel(i_cmt) {
	        	if(confirm('삭제 하시겠습니까?')) {
	        		location.href = '/board/cmt?i_board=${data.i_board }&i_cmt=' + i_cmt
	        	}
	        }
	    </script>
	</body>
</html>