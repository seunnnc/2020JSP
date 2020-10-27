package com.koreait.pjt.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.koreait.pjt.MyUtils;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.BoardCmtDAO;
import com.koreait.pjt.vo.BoardCmtVO;
import com.koreait.pjt.vo.UserVO;

@WebServlet("/board/cmt")
public class BoardCmtSer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//댓글 삭제
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int i_cmt = MyUtils.getIntParameter(request, "i_cmt");
		
		UserVO loginUser = MyUtils.getLoginUser(request);

		if(loginUser == null) {
			response.sendRedirect("/login");
			return;
		}
		
		String strI_board = request.getParameter("i_board");
		
		BoardCmtVO param = new BoardCmtVO();
		param.setI_cmt(i_cmt);
		param.setI_user(loginUser.getI_user());
		
		System.out.println("i_cmt: "+ param.getI_cmt());
		System.out.println("i_user: "+ param.getI_user());
		
		int result = BoardCmtDAO.delCmt(param);
		System.out.println("result : " + result);
		
		response.sendRedirect("/board/detail?i_board=" + strI_board);
		
	}

	//댓글 등록, 수정
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		UserVO loginUser = MyUtils.getLoginUser(request);

		if(loginUser == null) {
			response.sendRedirect("/login");
			return;
		}
		
		String strI_board = request.getParameter("i_board");
		String strI_cmt = request.getParameter("i_cmt");
		String cmt = request.getParameter("cmt");
		
		int i_board = MyUtils.parseStrToInt(strI_board);
		int i_cmt = MyUtils.parseStrToInt(strI_cmt);
		
		System.out.println("cmt: " + cmt);
		
		BoardCmtVO param = new BoardCmtVO();
		
		param.setI_user(loginUser.getI_user());
		param.setCmt(cmt);
		
		System.out.println("댓글 등록!");

		switch(strI_cmt) {
		case "0":	//등록
			param.setI_board(i_board);
			BoardCmtDAO.insCmt(param);
			break;
		default:	//수정
			param.setI_cmt(i_cmt);
			BoardCmtDAO.updCmt(param);
			break;
		}
		
		response.sendRedirect("detail?i_board=" + strI_board);
		
	}

}
