package com.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DBconn;

public class BoardDAO {

	private Connection conn;
	
	//������ ����
	public BoardDAO(Connection conn){
		this.conn = conn;
	}
	
	//num�� ������ ��ȣ
	public int getMaxNum(){
		
		int maxNum = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select nvl(max(num), 0) from board";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next())
				maxNum = rs.getInt(1); //�Ļ��÷��̶� 1�� ����
			
			rs.close();
			pstmt.close();	
			
		} catch (Exception e) {
			try {pstmt.close();} catch (Exception e2) {}
			try {DBconn.close();} catch (Exception e2) {}
		}
		
		return maxNum;	
		
	}
	
	//�Է�
	public int inserData(BoardDTO dto){
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "insert into board (num, name, pwd, email, "
					+ "subject, content, ipAddr, hitCount, created) ";
			sql += "values(?,?,?,?,?,?,?,0,sysdate)"; //ī��Ʈ �⺻�� 0; ��¥ ���ó�¥
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getNum());
			pstmt.setString(2, dto.getName());
			pstmt.setString(3, dto.getPwd());
			pstmt.setString(4, dto.getEmail());
			pstmt.setString(5, dto.getSubject());
			pstmt.setString(6, dto.getContent());
			pstmt.setString(7, dto.getIpAddr());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e) {
			try {pstmt.close();} catch (Exception e2) {}
			try {DBconn.close();} catch (Exception e2) {}
		}
		
		return result;
		
	}
	
/*	//��ü������ //������
	public List<BoardDTO> getLists(int start, int end){ //int start, int end
		
		List<BoardDTO> lists = new ArrayList<BoardDTO>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select * from ("; //�߰�
			sql += "select rownum rnum, data.* from ("; //�߰�
			sql += "select num, name, subject, hitCount, ";
			sql += "to_char(created, 'YYYY-MM-DD') created ";
			sql += "from board order by num desc) data) "; // ) data> �߰�
			sql += "where rnum>=? and rnum<=?"; //�߰�
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, start); // add start
			pstmt.setInt(2, end); // add end
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				BoardDTO dto = new BoardDTO();
				
				dto.setNum(rs.getInt("num"));
				dto.setName(rs.getString("name"));
				dto.setSubject(rs.getString("subject"));
				dto.setHitCount(rs.getInt("hitCount"));
				dto.setCreated(rs.getString("created"));
				
				lists.add(dto);
				
			}
			
			pstmt.close();
			rs.close();
			
		} catch (Exception e) {
			try {pstmt.close();} catch (Exception e2) {}
			try {DBconn.close();} catch (Exception e2) {}
		}
		
		return lists;
		
	}*/
	
	//��ü������ with �˻�
		public List<BoardDTO> getLists(int start, int end, String searchKey, String searchValue){ //int start, int end
			
			List<BoardDTO> lists = new ArrayList<BoardDTO>();
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql;
			
			try {
				//searchKey="subject"&searchValue like "%suzi"%"
				//searchKey �� 3������ �ϳ��� ������ ���� �׷��� ?�� 1���̴�
				
				searchValue = "%" + searchValue + "%";
				
				
				sql = "select * from ("; 
				sql +="select rownum rnum, data.* from ("; 
				sql +="select num, name, subject, hitCount, ";
				sql +="to_char(created, 'YYYY-MM-DD') created ";
				sql +="from board where " + searchKey + " like ? ";
				sql +="order by num desc) data) "; 
				sql +="where rnum>=? and rnum<=?"; 
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, searchValue); //add searchValue
				pstmt.setInt(2, start); 
				pstmt.setInt(3, end);
				
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					
					BoardDTO dto = new BoardDTO();
					
					dto.setNum(rs.getInt("num"));
					dto.setName(rs.getString("name"));
					dto.setSubject(rs.getString("subject"));
					dto.setHitCount(rs.getInt("hitCount"));
					dto.setCreated(rs.getString("created"));
					
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
		
		//��ü ������ ���� ���ϱ�  //������
/*		public int getDataCount(){
			
			int dataCount = 0;
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql;
			
			try {
				
				
				sql = "select nvl(count(*), 0) from board ";
				
				pstmt = conn.prepareStatement(sql);
				
				rs = pstmt.executeQuery();
				
				if(rs.next())
					dataCount = rs.getInt(1); //�Ļ��÷��̶� 1�� ����
				
				rs.close();
				pstmt.close();	
				
			} catch (Exception e) {
				try {pstmt.close();} catch (Exception e2) {}
				try {DBconn.close();} catch (Exception e2) {}
			}
			
			return dataCount;	
			
		}*/
	
	//��ü ������ ���� ���ϱ�
		public int getDataCount(String searchKey, String searchValue){
			
			int dataCount = 0;
			
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql;
			
			try {
				
				searchValue = "%" + searchValue + "%";
				
				sql = "select nvl(count(*), 0) from board ";
				sql += "where " + searchKey + " like ?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, searchValue);
				
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
	
	//�Ѱ��� ������ �б�
		public BoardDTO getReadData(int num){
			
			BoardDTO dto = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String sql;
			
			try {
				
				sql = "select num, name, pwd, email, subject, content, ";
				sql += "ipAddr, hitCount, created ";
				sql += "from board where num=?";
				
				//pstmt �� conn�� �����
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, num);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					
					dto = new BoardDTO();
					
					dto.setNum(rs.getInt("num"));
					dto.setName(rs.getString("name"));
					dto.setPwd(rs.getString("pwd"));
					dto.setEmail(rs.getString("email"));
					dto.setSubject(rs.getString("subject"));
					dto.setContent(rs.getString("content"));
					dto.setIpAddr(rs.getString("ipAddr"));
					dto.setHitCount(rs.getInt("hitCount"));
					dto.setCreated(rs.getString("created"));
					
				}
				
				rs.close();
				pstmt.close();
				
				
			} catch (Exception e) {
				try {pstmt.close();} catch (Exception e2) {}
				try {DBconn.close();} catch (Exception e2) {}
			}
			
			return dto;
			
		}
	
		//��ȸ�� ����
		public int updateHitCount(int num){
			
			int result = 0;
			
			PreparedStatement pstmt = null;
			String sql;
			
			try {
				
				sql = "update board set hitCount=hitCount+1 ";
				sql += "where num=?";
				
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
	
		//����
		public int updateData(BoardDTO dto){
			
			int result = 0;
			
			PreparedStatement pstmt = null;
			String sql;
			
			try {
				
				sql = "update board set name=?, pwd=?, email=?, subject=?, content=? ";
				sql +="where num=?";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, dto.getName());
				pstmt.setString(2, dto.getPwd());
				pstmt.setString(3, dto.getEmail());
				pstmt.setString(4, dto.getSubject());
				pstmt.setString(5, dto.getContent());
				pstmt.setInt(6, dto.getNum());
				
				result = pstmt.executeUpdate();
				
				pstmt.close();
	
			} catch (Exception e) {
				try {pstmt.close();} catch (Exception e2) {}
				try {DBconn.close();} catch (Exception e2) {}
			}
			
			return result;
		
		}
	
		//����
		public int deleteData(int num){
			
			int result = 0;
			
			Connection conn = DBconn.getConnection();
			PreparedStatement pstmt = null;
			String sql;
			
			try {
				
				sql = "delete board where num=?";
				
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
