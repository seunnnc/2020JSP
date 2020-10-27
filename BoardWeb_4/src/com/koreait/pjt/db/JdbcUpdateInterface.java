package com.koreait.pjt.db;

import java.sql.PreparedStatement;
import java.sql.SQLException;

//interface 부모역할만 함, 구현 해줘야함, 선언부만 있고 내용 없기 떄문에 객체화 할 수 없음
//abstract가지고 있으면  => 객체화 막아줌 
public interface JdbcUpdateInterface {
	//public, abstract 생략해도 자동으로 넣어줌
	//public abstract int update(PreparedStatement ps) throws SQLException;
	void update(PreparedStatement ps) throws SQLException;
}
