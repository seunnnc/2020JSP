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

@WebServlet("/boardMod")
public class BoardMod extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String strI_board = request.getParameter("i_board");

		int i_board = Utils.parseStrToInt(strI_board);

		if(i_board == 0) {
			response.sendRedirect("/boardList");
			return;
		}

		BoardVO param = new BoardVO();
		param.setI_board(i_board);
		request.setAttribute("data", BoardDAO.selBoard(param));

		String jsp = "/WEB-INF/view/boardRegmod.jsp";
		request.getRequestDispatcher(jsp).forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String strI_board = request.getParameter("i_board");
		String title = request.getParameter("title");
		String ctnt = request.getParameter("ctnt");
		
		int i_board = Utils.parseStrToInt(strI_board);
		
		System.out.println("title : " + title);
		System.out.println("ctnt : " + ctnt);
		System.out.println("i_board : " + strI_board);
		
		BoardVO param = new BoardVO();
		
		param.setTitle(title);
		param.setCtnt(ctnt);
		param.setI_board(i_board);
		
		int result = BoardDAO.updBoard(param);
		System.out.println("result : " + result);
		
		response.sendRedirect("/boardDetail?i_board=" + strI_board);
		
	}

}
