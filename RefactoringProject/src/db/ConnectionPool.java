package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ConnectionPool {

	Connection con;
	DataSource ds;

	//커넥션풀 얻는 메서드
	public Connection getConnection() {
		try {
			Context initCtx = new InitialContext();
			ds = (DataSource) initCtx.lookup("java:comp/env/jdbc/promotion");
			con = ds.getConnection();
			con.setAutoCommit(true);	//오토커밋 true=on, false=off
		} catch (Exception e) {
			System.out.print("커넥션풀 생성 실패: ");
			e.printStackTrace();
		}
		return con;
	}

	//DAO메서드 실행 후 자원해제
	public void close(Connection con, PreparedStatement pstmt, ResultSet rs) {
			try {
				if (rs != null) {	//
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (con != null) {
					con.close();
				}
			} catch (Exception e) {
				System.out.print("자원해제 실패: ");
				e.printStackTrace();
			}
	}
}
