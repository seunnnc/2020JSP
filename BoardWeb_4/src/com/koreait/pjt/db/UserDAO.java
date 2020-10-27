package com.koreait.pjt.db;

import java.sql.*;

import com.koreait.pjt.vo.UserLoginHistoryVO;
import com.koreait.pjt.vo.UserVO;

public class UserDAO {

//==================================insert==================================

	public static int insUserLoginHistory(UserLoginHistoryVO param) {
		
		String sql = " INSERT INTO t_user_loginhistory "
				+ " (i_history, i_user, ip_addr, os, browser) "
				+ " VALUES "
				+ " (seq_loginhistory.nextval, ?, ?, ?, ?) ";
		
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			
			@Override
			public void update(PreparedStatement ps) throws SQLException {
				ps.setInt(1, param.getI_user());
				ps.setNString(2, param.getIp_addr());
				ps.setNString(3, param.getOs());
				ps.setNString(4, param.getBrowser());
			}
		});
		
	}
	
	public static int insUser(UserVO param) {

		String sql = " INSERT INTO t_user "
				+ " (i_user, user_id, user_pw, nm, e_mail) "
				+ " VALUES "
				+ " (seq_user.nextval, ?, ?, ?, ?) ";

		//자바 콜백함수 구현 - 관점지향 프로그래밍
		//new JdbcUpdateInterface() {} implements 해준섯이다
		return JdbcTemplate.executeUpdate(sql, new JdbcUpdateInterface() {
			@Override
			public void update(PreparedStatement ps) throws SQLException{
				ps.setNString(1, param.getUser_id());
				ps.setNString(2, param.getUser_pw());
				ps.setNString(3, param.getNm());
				ps.setNString(4, param.getEmail());
			}
		});
	}

//==================================select==================================	

	//0:에러발생, 1:성공, 2:비밀번호 틀림 , 3:아이디 없음
	public static int login(UserVO param) {

		String sql = " SELECT i_user, user_pw, nm "
				+ " FROM t_user "
				+ " WHERE user_id = ? ";

		return JdbcTemplate.executeQuery(sql, new JdbcSelectInterface() {

			@Override
			public void prepared(PreparedStatement ps) throws SQLException {
				ps.setNString(1, param.getUser_id());
			}

			@Override
			public int executeQuery(ResultSet rs) throws SQLException {
				if(rs.next()) {
					String dbPw = rs.getNString("user_pw");	//db 비밀번호
					if(dbPw.equals(param.getUser_pw())) {	//로그인 성공
						int i_user = rs.getInt("i_user");
						String nm = rs.getNString("nm");
						param.setUser_pw(null);
						param.setI_user(i_user);
						param.setNm(nm);
						return 1;
					} else {	//비밀번호 틀림
						return 2;
					}
				} else {	//아이디 없음
					return 3;
				}
			}
		});
	}

//==================================update==================================	



//==================================delete==================================	



}
