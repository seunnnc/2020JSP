package com.koreait.pjt.db;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.koreait.pjt.vo.BoardCmtDomain;
import com.koreait.pjt.vo.BoardCmtVO;

public class BoardCmtDAO {

//==================================insert==================================
	
	public static int insCmt(BoardCmtVO param) {
		
		String sql = " INSERT INTO t_board4_cmt "
				+ " (i_cmt, i_board, i_user, cmt) "
				+ " VALUES "
				+ " (seq_board4_cmt.nextval, ?, ?, ?) ";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			
			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getI_board());
				ps.setInt(2, param.getI_user());
				ps.setNString(3, param.getCmt());
			}
		});
	}
	
//==================================select==================================
	
	public static List<BoardCmtDomain> selCmtList(int i_board) {
		
		 List<BoardCmtDomain> list = new ArrayList();
		 
		 String sql = " SELECT A.i_cmt, A.i_user, A.cmt"
		 		+ ", TO_CHAR(A.r_dt, 'YYYY/MM/DD HH24:MI') as r_dt"
		 		+ ", TO_CHAR(A.m_dt, 'YYYY/MM/DD HH24:MI') as m_dt, B.nm"
		 		+ " FROM t_board4_cmt A "
		 		+ " INNER JOIN t_user B "
		 		+ " ON A.i_user = B.i_user "
		 		+ " WHERE i_board = ? "
		 		+ " ORDER BY A.i_cmt ";
		
		 int result =  JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {
			
			@Override
			public void prepared(PreparedStatement ps) throws SQLException {
				ps.setInt(1, i_board);
			}
			
			@Override
			public int executeQuery(ResultSet rs) throws SQLException {
				
				while(rs.next()) {
					BoardCmtDomain vo = new BoardCmtDomain();
					vo.setI_cmt(rs.getInt("i_cmt"));
					vo.setI_user(rs.getInt("i_user"));
					vo.setCmt(rs.getNString("cmt"));
					vo.setR_dt(rs.getNString("r_dt"));
					vo.setM_dt(rs.getNString("m_dt"));
					vo.setNm(rs.getNString("nm"));
					
					list.add(vo);
				}
				return 1;
			}
		});
		
		return list;
		 
	}
	
//==================================update==================================
	
	public static int updCmt(BoardCmtVO param) {
		
		String sql = " 	UPDATE t_board4_cmt "
				+ " SET cmt = ?"
				+ ", m_dt = SYSDATE "
				+ " WHERE i_cmt = ? AND i_user = ? ";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			
			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setNString(1, param.getCmt());
				ps.setInt(2, param.getI_cmt());
				ps.setInt(3, param.getI_user());
			}
		});
		
	}
	
//==================================delete==================================
	
	public static int delCmt(BoardCmtVO param) {
		
		String sql = " DELETE FROM t_board4_cmt "
				+ " WHERE i_cmt = ? AND i_user = ? ";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			
			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getI_cmt());
				ps.setInt(2, param.getI_user());
			}
		});
		
	}
}
