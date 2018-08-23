package com.guest;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DBconn;

import com.board.BoardDAO;
import com.board.BoardDTO;

public class GuestDAO {

	private Connection conn;
	
	//의존성 주입
	public GuestDAO(Connection conn){
		this.conn = conn;
	}
	
	//1. num 컬럼의 마지막 (번호)값
	public int getMaxNum(){
		
		int maxNum = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select nvl(max(num), 0) from guest";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next())
				maxNum = rs.getInt(1); //파생컬럼이라서 1을 쓴다
			
			rs.close();
			pstmt.close();	
			
		} catch (Exception e) {
			try {pstmt.close();} catch (Exception e2) {}
			try {DBconn.close();} catch (Exception e2) {}
		}
		
		return maxNum;	
		
	}
	
	//2. 입력
	//입력
		public int inserData(GuestDTO dto){
			
			int result = 0;
			
			PreparedStatement pstmt = null;
			String sql;
			
			try {
				
				sql = "insert into guest (num, name, email, homepage, "
						+ "content, created, ipAddr) ";
				sql += "values(?,?,?,?,?,sysdate,?)"; //카운트 기본값 0; 날짜 오늘날짜
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, dto.getNum());
				pstmt.setString(2, dto.getName());
				pstmt.setString(3, dto.getEmail());
				pstmt.setString(4, dto.getHomepage());
				pstmt.setString(5, dto.getContent());
				pstmt.setString(6, dto.getIpAddr());
				
				result = pstmt.executeUpdate();
				
				pstmt.close();
				
			} catch (Exception e) {
				try {pstmt.close();} catch (Exception e2) {}
				try {DBconn.close();} catch (Exception e2) {}
			}
			
			return result;
			
		}
	
		//3. 전체데이터 가져오기
		public List<GuestDTO> getLists(int start, int end){ //int start, int end
			
			List<GuestDTO> lists = new ArrayList<GuestDTO>();
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql;
			
			//(num, name, email, homepage, content, created, ipAddr)

			try {
				
				sql = "select * from ("; 
				sql += "select rownum rnum, data.* from ("; 
				sql += "select num, name, email, homepage, content, ";
				sql += "to_char(created, 'YYYY-MM-DD') created, ipAddr ";
				sql += "from guest order by num desc) data) "; 
				sql += "where rnum>=? and rnum<=?"; 
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, start); // add start
				pstmt.setInt(2, end); // add end
				
				rs = pstmt.executeQuery();
				
				//(num, name, email, homepage, content, created, ipAddr)
				while(rs.next()){
					
					GuestDTO dto = new GuestDTO();
					
					dto.setNum(rs.getInt("num"));
					dto.setName(rs.getString("name"));
					dto.setEmail(rs.getString("email"));
					dto.setHomepage(rs.getString("homepage"));
					dto.setContent(rs.getString("content"));
					dto.setCreated(rs.getString("created"));
					dto.setIpAddr(rs.getString("ipAddr"));
					
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
		
		//4. 전체 레코드의 갯수
		public int getDataCount(){
			
			int dataCount = 0;
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql;
			
			try {
				
				
				sql = "select nvl(count(*), 0) from guest ";
				
				pstmt = conn.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				if(rs.next())
					dataCount = rs.getInt(1);
				
				rs.close();
				pstmt.close();	
				
			} catch (Exception e) {
				try {pstmt.close();} catch (Exception e2) {}
				try {DBconn.close();} catch (Exception e2) {}
			}
			
			return dataCount;	
			
		}
		
		//5.삭제
		public int deleteData(int num){
			
			int result = 0;
			
			Connection conn = DBconn.getConnection();
			PreparedStatement pstmt = null;
			String sql;
			
			try {
				
				sql = "delete guest where num=?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, num);
				
				result = pstmt.executeUpdate();
				
				pstmt.close();
				
			} catch (Exception e) {
				try {pstmt.close();} catch (Exception e2) {}
				try {DBconn.close();} catch (Exception e2) {}
			}
			
			return result;
		}
}
