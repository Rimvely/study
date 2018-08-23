package com.register;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DBconn;

public class NaverDAO {

	private Connection conn;
	
	public NaverDAO(Connection conn){
		this.conn = conn;
	}
	
	//1.데이터 입력(register.jsp, register_ok.jsp)
	public int insertData(NaverDTO dto){
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "insert into register (userName, userId, userNick, userPw1, answer1, "
					+ "answer2, email1, email2, tel1, tel2, tel3) ";
			sql += "values (?,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUserName());
			pstmt.setString(2, dto.getUserId());
			pstmt.setString(3, dto.getUserNick());
			pstmt.setString(4, dto.getUserPw1());
			pstmt.setString(5, dto.getAnswer1());
			pstmt.setString(6, dto.getAnswer2());
			pstmt.setString(7, dto.getEmail1());
			pstmt.setString(8, dto.getEmail2());
			pstmt.setString(9, dto.getTel1());
			pstmt.setString(10, dto.getTel2());
			pstmt.setString(11, dto.getTel3());

			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			try {pstmt.close();} catch (Exception e2) {}
			try {DBconn.close();} catch (Exception e2) {}
		}
		
		return result;
	}
	
	//데이터 가져오기(registerList.jsp)
	public List<NaverDTO> getList(){
		
		List<NaverDTO> lists = new ArrayList<NaverDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select userName, userId, userNick, userPw1, answer1, answer2, "
					+ "email1, email2, tel1, tel2, tel3 ";
			sql += "from register";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				NaverDTO dto = new NaverDTO();
				
				dto.setUserName(rs.getString("userName"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserNick(rs.getString("userNick"));
				dto.setUserPw1(rs.getString("userPw1"));
				dto.setAnswer1(rs.getString("answer1"));
				dto.setAnswer2(rs.getString("answer2"));
				dto.setEmail1(rs.getString("email1"));
				dto.setEmail2(rs.getString("email2"));
				dto.setTel1(rs.getString("tel1"));
				dto.setTel2(rs.getString("tel2"));
				dto.setTel3(rs.getString("tel3"));
				
				lists.add(dto);
			}
			
			pstmt.close();
			rs.close();
			
			
			
		} catch (Exception e) {
			try {pstmt.close();} catch (Exception e2) {}
			try {DBconn.close();} catch (Exception e2) {}
		}
		
		return lists;
		
		
	}
	
	//3.수정할 데이터 가져오기
	public NaverDTO getReadData(String userId) {
		
		NaverDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select userName, userId, userNick, userPw1, answer1, answer2, "
					+ "email1, email2, tel1, tel2, tel3 ";
			sql += "from register where userId=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				
				dto = new NaverDTO();
				
				dto.setUserName(rs.getString("userName"));
				dto.setUserId(rs.getString("userId"));
				dto.setUserNick(rs.getString("userNick"));
				dto.setUserPw1(rs.getString("userPw1"));
				dto.setAnswer1(rs.getString("answer1"));
				dto.setAnswer2(rs.getString("answer2"));
				dto.setEmail1(rs.getString("email1"));
				dto.setEmail2(rs.getString("email2"));
				dto.setTel1(rs.getString("tel1"));
				dto.setTel2(rs.getString("tel2"));
				dto.setTel3(rs.getString("tel3"));
				
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			try {pstmt.close();} catch (Exception e2) {}
			try {DBconn.close();} catch (Exception e2) {}
		}
		
		return dto;
	}
	
	//수정(update_ok.jsp 에서 update 실행)
	public int updateData(NaverDTO dto){
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "update register set userNick=?, userPw1=?, answer1=?, answer2=?, email1=?, "
					+ "email2=?, tel1=?, tel2=? tel3=? ";
			sql += "where userId=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getUserNick());
			pstmt.setString(2, dto.getUserPw1());
			pstmt.setString(3, dto.getAnswer1());
			pstmt.setString(4, dto.getAnswer2());
			pstmt.setString(5, dto.getEmail1());
			pstmt.setString(6, dto.getEmail2());
			pstmt.setString(7, dto.getTel1());
			pstmt.setString(8, dto.getTel2());
			pstmt.setString(9, dto.getTel3());
			pstmt.setString(10, dto.getUserId());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			try {pstmt.close();} catch (Exception e2) {}
			try {DBconn.close();} catch (Exception e2) {}
		}
		
		return result;
		
	}
	
	//삭제(delete_ok.jsp)
	public int deleteData(String userId) {
		
		int result = 0;
		
		Connection conn = DBconn.getConnection();
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "delete register where userId=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			try {pstmt.close();} catch (Exception e2) {}
			try {DBconn.close();} catch (Exception e2) {}
		}
		
		return result;
	}
	
	
}
