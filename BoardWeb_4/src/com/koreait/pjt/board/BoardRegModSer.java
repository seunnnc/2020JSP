package com.koreait.pjt.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.koreait.pjt.Const;
import com.koreait.pjt.MyUtils;
import com.koreait.pjt.ViewResolver;
import com.koreait.pjt.db.BoardDAO;
import com.koreait.pjt.vo.BoardVO;
import com.koreait.pjt.vo.UserVO;

@WebServlet("/board/regmod")
public class BoardRegModSer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	//화면띄우는 용도(등록창/수정창)
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		UserVO loginUser = MyUtils.getLoginUser(request);
		if(loginUser == null) {
			response.sendRedirect("/login");
			return;
		}
		
		String strI_board = request.getParameter("i_board");
		
		BoardVO param = new BoardVO();
		
		if(strI_board != null) {
			int i_board = MyUtils.parseStrToInt(strI_board);
			param.setI_board(i_board);
			request.setAttribute("data", BoardDAO.selBoard(param));
		}

		ViewResolver.forward("board/regmod", request, response);

	}

	//처리용(DB에 등록/수정)
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//UserVO loginUser = MyUtils.getLoginUser(request);

		HttpSession hs = request.getSession();
		UserVO vo = (UserVO) hs.getAttribute(Const.LOGIN_USER);
		
		//UserVO loginUser = MyUtils.getLoginUser(request);
		
		String strI_board = request.getParameter("i_board");
		
		String title = request.getParameter("title");
		String ctnt = request.getParameter("ctnt");
		int i_user = vo.getI_user();
				//request.getParameter("i_user");
		//int i_user = MyUtils.parseStrToInt(strI_user);

		System.out.println("title: " + title);
		System.out.println("ctnt: " + ctnt);
		System.out.println("i_user:" + i_user);

		BoardVO param = new BoardVO();

		param.setTitle(title);
		param.setCtnt(ctnt);
		param.setI_user(i_user);
		
		if("".equals(strI_board)) {				//등록
			int resultIns = BoardDAO.insBoard(param);
			System.out.println("resultIns : " + resultIns);
			
			if(resultIns == 1) {
				response.sendRedirect("list");
			} else {
				doGet(request, response);
			}
			
		} else {									//수정
			int i_board = MyUtils.parseStrToInt(strI_board);
			param.setI_board(i_board);
			int resultUpd = BoardDAO.updBoard(param);
			System.out.println("resultUpd : " + resultUpd);
			
			if(resultUpd == 1 ) {
				response.sendRedirect("detail?i_board=" + strI_board);
			}
			
		}
	}

}
