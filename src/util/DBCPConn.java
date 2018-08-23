package util;

import java.sql.Connection;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

//DBCP(Database Connection Pool)
//데이터베이스와 연결된 커넥션을 미리 만들어서
//pool 속에 저장해 두고 있다가 필요할때 
//커넥션을 pool에서 가져가 쓰고 다시 pool에 반환하는 방법



public class DBCPConn {

	private static Connection conn = null;
	
	public static Connection getConnection(){
		
		if(conn==null){
			
			try {
				
				//이름과 객체를 바인딩
				Context ctx = new InitialContext();
				
				//web.xml에서 환경설정 찾음
				Context evt = (Context)ctx.lookup("java:/comp/env");
				DataSource ds = (DataSource)evt.lookup("jdbc/myOracle");
				
				conn = ds.getConnection();
	
			} catch (Exception e) {
				System.out.println(e.toString());
			}
		}
		return conn;
		
	}
	
	public static void close() {
		
		if(conn!=null){
			
			try {
				
				if(!conn.isClosed())
					conn.close();
				
			} catch (Exception e) {
				System.out.println(e.toString());
			}
		}
		
		conn=null;

	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
