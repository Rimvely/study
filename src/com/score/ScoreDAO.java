package com.score;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import util.DBconn;

public class ScoreDAO {
	//DAO�� �� ���� Conn���־���ϰ� DAO��ü������ �����ؾ��Ѵ�
	
	
	
	//�ݵ�� DB�� ã�ư��� ��ΰ� �ʿ��ϴ�
	//�ڹٿ��� DB�� ��������ִ� �����ڸ� ��� �׸��� Connection
	
	//Drive Manager -> conn
	//Conn -> Statement
	//Stmt -> Query ����
	
	//�ݵ�� Conn�� �����ڰ� �־���ϴϱ� Conn ������ ������
	
	//<<<<<<<<<<<<<<<<<<<<<< ������ ���� >>>>>>>>>>>>>>>>>>>>>
	private Connection conn;
	
	public ScoreDAO(Connection conn){
		this.conn = conn;
	}
	
	
	//�Է�(write.jsp, write_ok.jsp ��Ȯ���� _ok�� �����ϴϱ� �ű⼭����)
	public int insertData(ScoreDTO dto){
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "insert into score (hak, name, kor, eng, mat) ";
			sql += "values (?,?,?,?,?)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getHak());
			pstmt.setString(2, dto.getName());
			pstmt.setInt(3, dto.getKor());
			pstmt.setInt(4, dto.getEng());
			pstmt.setInt(5, dto.getMat());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			

		}catch (Exception e) {
			System.out.println(e.toString());
			//���� Error ó��
			try {pstmt.close();} catch (Exception e2) {
				System.out.println(e2.toString());
			}
			try {DBconn.close();} catch (Exception e2) {
				System.out.println(e2.toString());
			}
		}
	
		return result;
		
	}
	
	//2.������ ��������(list.jsp)
	public List<ScoreDTO> getList(){
		
		List<ScoreDTO> lists = new ArrayList<ScoreDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql ="select hak, name, kor, eng, mat, ";
			sql +="(kor+eng+mat) tot, (kor+eng+mat)/3 avg, ";
			sql +="rank() over(order by (kor+eng+mat) desc) rank ";
			sql +="from score";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				ScoreDTO dto = new ScoreDTO();
				
				dto.setHak(rs.getString("hak"));
				dto.setName(rs.getString("name"));
				dto.setKor(rs.getInt("kor"));
				dto.setEng(rs.getInt("eng"));
				dto.setMat(rs.getInt("mat"));
				dto.setTot(rs.getInt("tot"));
				dto.setAvg(rs.getInt("avg"));
				dto.setRank(rs.getInt("rank"));
				
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
	
	
	
	
	//2.������ ��������(list.jsp) with page
	public List<ScoreDTO> getList(int start, int end){
		
		List<ScoreDTO> lists = new ArrayList<ScoreDTO>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {

			sql = "select * from (";
			sql +="select rownum rnum, data.* from (";
			sql +="select hak, name, kor, eng, mat, "; 
			sql +="(kor+eng+mat) tot, (kor+eng+mat)/3 avg, ";
			sql +="rank() over(order by (kor+eng+mat) desc) rank ";
			sql +="from score) data) ";
			sql +="where rnum>=? and rnum<=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				
				ScoreDTO dto = new ScoreDTO();
				
				dto.setHak(rs.getString("hak"));
				dto.setName(rs.getString("name"));
				dto.setKor(rs.getInt("kor"));
				dto.setEng(rs.getInt("eng"));
				dto.setMat(rs.getInt("mat"));
				dto.setTot(rs.getInt("tot"));
				dto.setAvg(rs.getInt("avg"));
				dto.setRank(rs.getInt("rank"));
				
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
	public int getDataCount(){
		
		int dataCount = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			
			sql = "select nvl(count(*), 0) from score ";
			
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
		
	}
	
	//3.������ ������ ��������
	public ScoreDTO getReadData(String hak) {
		
		ScoreDTO dto = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql;
		
		try {
			
			sql = "select hak,name, kor, eng, mat ";
			sql += "from score where hak=?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, hak);
			
			rs = pstmt.executeQuery();
			
			if (rs.next())	{
				
				dto = new ScoreDTO();
				
				dto.setHak(rs.getString("hak"));
				dto.setName(rs.getString("name"));
				dto.setKor(rs.getInt("kor"));
				dto.setEng(rs.getInt("eng"));
				dto.setMat(rs.getInt("mat"));
				
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e) {
			try {pstmt.close();} catch (Exception e2) {}
			try {DBconn.close();} catch (Exception e2) {}
		}
		
		return dto;
	}
	
	
	
	//����(update_ok.jsp ���� update ����)
	public int updateData(ScoreDTO dto){
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "update score set kor=?, eng=?, mat=? ";
			sql += "where hak=?";
			
			pstmt =conn.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getKor());
			pstmt.setInt(2, dto.getEng());
			pstmt.setInt(3, dto.getMat());
			pstmt.setString(4, dto.getHak());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
			
			
		} catch (Exception e) {
			//System.out.println(e.toString());
			//���� Error ó��
			try {pstmt.close();} catch (Exception e2) {}
			try {DBconn.close();} catch (Exception e2) {}
		}
	
		return result;
		
	}
	
	//����(delete_ok.jsp)
	public int deleteData(String hak) {
		
		int result = 0;
		
		Connection conn = DBconn.getConnection();
		PreparedStatement pstmt = null;
		String sql;
		
		try {
			
			sql = "delete score where hak =?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, hak);
			
			result = pstmt.executeUpdate();
			
			pstmt.close();

		} catch (Exception e) {
			try {pstmt.close();} catch (Exception e2) {}
			try {DBconn.close();} catch (Exception e2) {}
		}
		
		return result;
	}
	
	
}
