package com.koreait.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.board.db.BoardDAO;
import com.koreait.board.vo.BoardVO;

//Servlet은 로직 담당, jsp는 화면, 뷰 담당

@WebServlet("/boardList")
public class BoardListSer extends HttpServlet {
	private static final long serialVersionUID = 1L;	//절대 삭제하면 안됨

	//기본생성자 - 클래스명과 이름이 같고 리턴타입이 없음
//    public BoardListSer() {
//        super();
//    }

	//doGet : 화면 띄우는 담당
    //요청request, 응답response
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<BoardVO> list = BoardDAO.selBoardList();
		request.setAttribute("data", list);
		
		//DbCon.close(con, ps, rs);
		
		//DbCon.close(con, ps);
		
		//SendRedirect 응답과 동시에 request, response소멸 RequestDispatcher request, response 주소값 가지고 전달
		//SendRedirect는 doGet, doPost상관 없이 무조건 get방식으로 날아감
		//getRequestDispatcher doGet에서 날리면 get방식 doPost에서 날리면 post방식
		//WEB-INF아래에 jsp아래에 있는 것이 보안상 뛰어남
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/boardList.jsp");
		rd.forward(request, response);
		
	}

	//doPost : 데이터 전송
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
