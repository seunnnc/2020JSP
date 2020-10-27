package com.koreait.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.board.common.Utils;
import com.koreait.board.db.BoardDAO;
import com.koreait.board.vo.BoardVO;

@WebServlet("/boardDetail")
public class BoardDetailser extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String strI_board = request.getParameter("i_board");
		
		int i_board = Utils.parseStrToInt(strI_board, 0);
		
		if(i_board == 0) {
			response.sendRedirect("/boardList");
			return;
		}
		
		BoardVO param = new BoardVO();
		param.setI_board(i_board);
		
//		BoardVO data = BoardDAO.selBoard(param);	//DB로 값받기
		request.setAttribute("data", BoardDAO.selBoard(param));
		
//		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/view/boardDetail.jsp");
//		rd.forward(request, response);
		
		String jsp = "/WEB-INF/view/boardDetail.jsp";
		request.getRequestDispatcher(jsp).forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

}
