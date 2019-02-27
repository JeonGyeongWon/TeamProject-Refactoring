package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;

import org.apache.tomcat.jni.Pool;

import db.ConnectionPool;
import dto.UserManagementDTO;
import together.ActionForward;
import controller.UserManagementController;

public class UserManagementDAO {

	ConnectionPool cp;
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;

	public UserManagementDAO() {
		cp = new ConnectionPool(); // 각 메서드에서 반드시 con = cp.getConnection(); 해서
									// DB에 접속할 것.
	}

	// 회원가입
	public int insertMember(UserManagementDTO umdto) {
		int result = 0;		//회원가입 여부를 판단하기 위해 리턴할 result변수
		try {
			con = cp.getConnection();
			String sql = "insert into users (user_email,user_pass,user_nickname,user_birth,user_gender,user_point,user_phone,user_level,bestcount)"
					+ " values (?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, umdto.getUser_email());
			pstmt.setString(2, umdto.getUser_pass());
			pstmt.setString(3, umdto.getUser_nickname());
			pstmt.setString(4, umdto.getUser_birth());
			pstmt.setString(5, umdto.getUser_gender());
			pstmt.setInt(6, 0);
			pstmt.setString(7, "");
			pstmt.setInt(8, 1);
			pstmt.setInt(9, 0);
			result = pstmt.executeUpdate(); // 회원가입 성공 하면 1을 리턴 실패시 0을 리턴
			// 만약에 회원가입에 성공 하면 true리턴
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			cp.close(con, pstmt, rs);
		}
		return result;
	} // insertMember() 끝

	// 로그인
	public int userLogin(String user_email, String user_pass) {
		int result = -1;
		try {
			con = cp.getConnection();
			String sql = "select user_no, user_pass"
					+ " from users"
					+ " where user_email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_email);
			rs = pstmt.executeQuery();
			if (rs.next()) {											//사용자가 입력한 user_email값이 DB에 존재할 때
				if ((rs.getString("user_pass")).equals(user_pass)) {	//사용자가 입력한 user_pass값이 select문의 검색값과 일치할 때	
					result = 1;	//로그인 성공
					
				} else {												//사용자가 입력한 user_pass값이 select문의 검색값과 일치하지 않을 때
					result = 0;	//로그인 실패: user_email 일치, user_pass 불일치
				}
			} else {													//사용자가 입력한 user_email값이 DB에 존재하지 않을 때
				result = -1;	//로그인 실패: user_email 불일치
			}
		} catch (SQLException e) {
			System.out.print("userLogin()메서드 내부 오류: ");
			e.printStackTrace();
		} finally {
			cp.close(con, pstmt, rs);	//자원해제
		}
		return result;
	} // userLogin() 끝

	// 회원정보수정을 위한 유저정보 검색
	public UserManagementDTO getUserInfo(String user_email) {
		UserManagementDTO umdto = null;		//getUserInfoAction으로 리턴해야하기 때문에, UserManagementDTO객체를 담을 변수(umdto)를 선언한다.
		try {
			con = cp.getConnection();
			String sql = "select user_no, user_pass, user_nickname, user_birth, user_gender, user_point, user_phone, user_level, bestcount"
					+ " from users"
					+ " where user_email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_email);
			rs = pstmt.executeQuery();
			if (rs.next()) {											//검색 결과가 있을 때
				umdto = new UserManagementDTO();						//결과값을 저장할 UserManagementDTO객체를 생성해 변수(umdto)에 저장한다.
				umdto.setUser_no(rs.getInt("user_no"));
				umdto.setUser_pass(rs.getString("user_pass"));
				umdto.setUser_nickname(rs.getString("user_nickname"));
				umdto.setUser_birth(rs.getString("user_birth"));
				umdto.setUser_gender(rs.getString("user_gender"));
				umdto.setUser_point(rs.getInt("user_point"));
				umdto.setUser_phone(rs.getString("user_phone"));
				umdto.setUser_level(rs.getInt("user_level"));
				umdto.setBestcount(rs.getInt("bestcount"));
			}
		} catch (Exception e) {
			System.out.print("getUserInfo()메서드 내부 오류: ");
			e.printStackTrace();
		} finally {
			cp.close(con, pstmt, rs);
		}
		return umdto;													//검색 결과값을 저장한 UserManagementDTO객체(umdto)를 리턴한다. 
	} // getUserInfo() 끝

	// 회원정보수정
	public int editUserInfo(UserManagementDTO umdto) {	//수정된 회원정보를 담은 UserManagementDTO객체를 parameter값으로 받는다.
		int result = 0;									//회원정보 수정 성공 여부를 판단하기 위해 리턴할 result변수
		String user_email = umdto.getUser_email();
		String user_pass = umdto.getUser_pass();
		String user_nickname = umdto.getUser_nickname();
		String user_birth = umdto.getUser_birth();
		String user_gender = umdto.getUser_gender();
		// String user_phone = umdto.getUser_phone();
		try {
			con = cp.getConnection();
			String sql = "update users"
					+ " set user_pass=?, user_nickname=?, user_birth=?, user_gender=?"
					+ " where user_email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_pass);
			pstmt.setString(2, user_nickname);
			pstmt.setString(3, user_birth);
			pstmt.setString(4, user_gender);
			pstmt.setString(5, user_email);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.print("editUserInfo()메서드 내부 오류: ");
			e.printStackTrace();
		} finally {
			cp.close(con, pstmt, rs);
		}
		return result;
	}

	// 아이디 중복체크
	public int JoinCheck(String user_email) {

		int check = 0;

		try {
			con = cp.getConnection();
			String sql = "select * from users"
					+ " where user_email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_email);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				check = 0;
			} else {
				check = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			cp.close(con, pstmt, rs);
		}
		return check;
	} // JoinCheck() 끝

	// 비밀번호 찾기
	public String findPw(String user_nickname, String user_email) {

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String findPw = null;

		try {
			String sql = "select user_pass from users"
					+ " where user_nickname=? and user_email=?";

			con = cp.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_nickname);
			pstmt.setString(2, user_email);

			rs = pstmt.executeQuery();

			if (rs.next())
				findPw = rs.getString("user_pass");

		} catch (Exception sql) {
			throw new RuntimeException(sql.getMessage());
		} finally {
			cp.close(con, pstmt, rs);
		}
		return findPw;
	}

	public void updateUserPhoneNumber(String user_email, String user_phone) {
		
		String sql = "update users set user_phone = ? where user_email = ?";
		try{
			con =cp.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, user_phone);
			pstmt.setString(2, user_email);
			pstmt.executeUpdate();
		}catch(Exception e){
			e.getMessage();
		}finally{
			cp.close(con, pstmt, rs);
		}
		
	}
}
