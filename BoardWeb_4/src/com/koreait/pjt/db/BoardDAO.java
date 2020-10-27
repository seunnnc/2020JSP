package com.koreait.pjt.db;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import com.koreait.pjt.vo.BoardVO;
import com.sun.org.apache.xalan.internal.xsltc.compiler.Template;

public class BoardDAO {

//==================================insert==================================	

	public static int insBoard(BoardVO param) {

		String sql = " INSERT INTO t_board4"
				+ " (i_board, title, ctnt, i_user) "
				+ " values "
				+ " (seq_board4.nextval, ?, ?, ?) "; 

		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {

			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setNString(1, param.getTitle());
				ps.setNString(2, param.getCtnt());
				ps.setInt(3, param.getI_user());
			}
		});

	}
	
	public static int insLike(BoardVO param) {
		String sql = " INSERT INTO t_board4_like "
				+ " (i_board, i_user)"
				+ " VALUES "
				+ " (?, ?) ";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			
			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getI_board());
				ps.setInt(2, param.getI_user());
			}
		});
	}

//==================================select==================================

	public static List<BoardVO> selBoardList(BoardVO param) {

		List<BoardVO> list = new ArrayList();	//final 주소값 변경이 불가, 추가 삭제 가능

		String sql = " SELECT C.* FROM "
				+ " ( "
				+ " SELECT ROWNUM as rnum, C.* FROM"
				+ " ( "
				+ " SELECT A.i_board, A.title, A.hits, B.nm, A.r_dt, A.m_dt "
				+ " FROM t_board4 A "
				+ " INNER JOIN t_user B "
				+ " ON A.i_user = B.i_user "
				+ " ORDER BY i_board DESC "
				+ " ) C "
				+ " WHERE ROWNUM <= ?"
				+ " ) C "
				+ " WHERE C.rnum > ? ";

		int result = JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {

			@Override
			public void prepared(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.geteIdx());
				ps.setInt(2, param.getsIdx());
			}

			@Override
			public int executeQuery(ResultSet rs) throws SQLException {
				while(rs.next()) {
					int i_board = rs.getInt("i_board");
					String title = rs.getNString("title");
					int hits = rs.getInt("hits");
					String nm = rs.getNString("nm");
					String r_dt = rs.getNString("r_dt");
					String m_dt = rs.getNString("m_dt");

					BoardVO vo = new BoardVO();
					vo.setI_board(i_board);
					vo.setTitle(title);
					vo.setHits(hits);
					vo.setNm(nm);
					vo.setR_dt(r_dt);
					vo.setM_dt(m_dt);

					list.add(vo);
				}
				return 1;
			}
		});

		return list;

	}

	public static BoardVO selBoard(final BoardVO param) {
		final BoardVO vo = new BoardVO();
		vo.setI_board(param.getI_board());	//값을 알고 있기 때문에 
		
		String sql = " SELECT A.i_board, A.title, B.nm "
				+ " , decode(C.i_user, null, 0, 1) as yn_like"
				+ " , (select count(i_board) from t_board4_like where i_board= ?) as like_count "
				+ " , A.i_user, TO_CHAR(A.r_dt, 'YYYY/MM/DD HH24:MI') as r_dt"
				+ " , TO_CHAR(A.m_dt, 'YYYY/MM/DD HH24:MI') as m_dt"
				+ " , A.hits, A.ctnt "
				+ " FROM t_board4 A "
				+ " INNER JOIN t_user B "
				+ " ON A.i_user = B.i_user "
				+ " LEFT JOIN t_board4_like C "
				+ " ON A.i_board = C.i_board "
				+ " AND C.i_user = ? "
				+ " WHERE A.i_board = ? ";

		JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {
			
			@Override
			public void prepared(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getI_board());
				ps.setInt(2, param.getI_user());
				ps.setInt(3, param.getI_board());
			}
			
			@Override
			public int executeQuery(ResultSet rs) throws SQLException {
				
				if(rs.next()) {
					vo.setI_user(rs.getInt("i_user"));	//작성자 i_user
					vo.setTitle(rs.getNString("title"));
					vo.setNm(rs.getNString("nm"));
					vo.setR_dt(rs.getNString("r_dt"));
					vo.setM_dt(rs.getNString("m_dt"));
					vo.setHits(rs.getInt("hits"));
					vo.setCtnt(rs.getNString("ctnt"));
					vo.setYn_like(rs.getInt("yn_like"));
					vo.setLike_count(rs.getInt("like_count"));
				}
				
				return 1;

			}
		});
		return vo;

	}
	
	public static int selPagingCnt(final BoardVO param) {
		
		String sql = " SELECT CEIL(count(i_board) / ?) FROM t_board4 ";
		
		return JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {
			
			@Override
			public void prepared(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getRecord_cnt());
			}
			
			@Override
			public int executeQuery(ResultSet rs) throws SQLException {
				if(rs.next()) {
					return rs.getInt(1);
				}
				return 0;
			}
		});
	}
	

//==================================update==================================

	public static int updBoard(final BoardVO param) {
		
		String sql = " UPDATE t_board4 SET "
				+ " m_dt = SYSDATE, title = ?, ctnt = ? "
				+ " WHERE i_board = ? AND i_user = ?"; 
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			
			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setString(1, param.getTitle());
				ps.setNString(2, param.getCtnt());
				ps.setInt(3, param.getI_board());
				ps.setInt(4, param.getI_user());
			}
		});
		
	}
	
	public static int addHits(int i_board) {
		String sql = " UPDATE t_board4 SET "
				+ " hits = nvl(hits,0) + 1 "
				+ " WHERE i_board = ? ";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			
			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, i_board);
			}
		});
	}

//==================================delete==================================
	
	public static int delBoard(final BoardVO param) {
		
		String sql = " DELETE FROM t_board4 "
				+ " WHERE i_board = ? and i_user = ? ";
		
		return  JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			
			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getI_board());
				ps.setInt(2, param.getI_user());
			}
			
		});
		
	}
	
	public static int delLike(BoardVO param) {
		String sql = " DELETE FROM t_board4_like "
				+ " WHERE i_board = ? and i_user = ? ";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			
			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getI_board());
				ps.setInt(2, param.getI_user());
			}
		});
		
	}
	
}
