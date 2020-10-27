<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <title>리스트</title>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
         <style>
            * {
                font-family: "Noto Sans KR", sans-serif;
            }
            *:focus {
                outline: none;
            }
            body {
                background-color: #fcfefe;
            }
            .container {
                width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }
            #usr-color {
                color: #9aa688;
                font-weight: bold;
            }
            table {
                width: 800px;
                margin: 70px auto 18px auto;
                border: 0.5px solid #331606;
                border-collapse: collapse;
            }
            thead {
            	color: #331606;
            }
            #no {
            	color: red;
            }
            tr,
            td {
                text-align: center;
                padding: 7px;
            }
            th {
                text-align: center;
                padding: 7px;
                border-bottom: 0.5px solid #331606;
            }
            .itemRow:hover {
                background: #e3e4d6;
                cursor: pointer;
            }
            #logout {
                width: 70px;
                height: 25px;
                background-color: #babc99;
                text-align: center;
                border: none;
                padding: 1px;
                color: #331606;
                border-radius: 5px;
                text-decoration: none;
                font-size: 0.9em;
                font-weight: bold;
            }
            #write { 
                width: 85px;
                background-color: #babc99;
                text-align: center;
                border: none;
                padding: 8px;
                color: #331606;
                border-radius: 10px;
                margin-left: 200px;
                font-weight: bold;
                text-decoration: none;
            } 
            .fontCenter {
            	text-align: center;
            }
            #pageNum {
            	text-decoration: none;
            	color: #331606;
            	font-size: 1.1em;
            }
            .pageSelected {
            	color: #babc99; 
            	font-weight: bold; 
            }
			.pagingFont {
				font-size: 1.2m;
			}
			a {
				text-decoration: none;
				color: #331606;
			}
			.pagingFont:not(:first-child) {
				margin: 5px;
			}
			.fontCenter a {
				width: 7px;
				height: 7px;
			}
        </style>
    </head>
    <body>
        <div class="container">
            <div class="usr-name">
                <span id="usr-color">${loginUser.nm}</span>님 환영합니다
                <a href="/logout"><button id="logout">로그아웃</button></a>
            </div>
            <div>
            	<form id="selFrm" action="/board/list" method="get">
            		<input type="hidden" name="page" value="${param.page == null? 1 : param.page}">
            		레코드수
            		<select name="record_cnt" onchange="changeRecordCnt()">
	            		<c:forEach begin="10" end="30" step="10" var="item">
	            			<c:choose>
	            				<c:when test="${param.record_cnt == item || (param.record_cnt == null && item == 10)}">
	            					<option value="${item }" selected>${item }개</option>
	            				</c:when>
	            				<c:otherwise>
	            					<option value="${item }">${item }개</option>
	            				</c:otherwise>
	            			</c:choose>
	            		</c:forEach>
            		</select>
            	</form>
            </div>
            <table>
	            <thead>
	                <tr>
	                    <th>No</th>
	                    <th>제목</th>
	                    <th>조회수</th>
	                    <th>작성자</th>
	                    <th>작성일</th>
	                </tr>
                </thead>
                <c:forEach items="${list}" var="item">
                    <tr class="itemRow" onclick="moveToDetail(${item.i_board})">
                        <td>${item.i_board}</td>
                        <td>${item.title}</td>
                        <td>${item.hits}</td>
                        <td>${item.nm}</td>
                        <td>${item.r_dt == item.m_dt ? item.r_dt : item.m_dt}</td>
                    </tr>
                </c:forEach>
            </table>
            <div class="fontCenter">
            	<a href="/board/list?page=1">
					<i class="fas fa-angle-double-left"></i>
				</a>
				<c:forEach begin="1" end="${pagingCnt }" var="item">
					<c:choose>
						<c:when test="${param.page == item || (param.page == null && item == 1)}">
							<span class="pagingFont pageSelected">${item}</span>
						</c:when>
						<c:otherwise>
							<span class="pagingFont">
								<a href="/board/list?page=${item}">${item}</a>
							</span>
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<a href="/board/list?page=${pagingCnt}">
					<i class="fas fa-angle-double-right"></i>
				</a>
			</div>
            <div>
                <a href="regmod"><button id="write">글작성</button></a>
            </div>
        </div>
        <script>
        	function changeRecordCnt() {
        		selFrm.submit()
        	}
            function moveToDetail(i_board) {
                location.href = '/board/detail?i_board=' + i_board;
            }
            
        </script>
    </body>
</html>