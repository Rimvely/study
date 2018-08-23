<%@page import="com.register.NaverDAO"%>
<%@page import="com.score.ScoreDAO"%>
<%@page import="util.DBconn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
request.setCharacterEncoding("UTF-8");
%>
<!-- ACTION  -->
<jsp:useBean id="dto" class="com.register.NaverDTO" scope="page"/>
<jsp:setProperty property="*" name="dto"/>

<%
	
	Connection conn = DBconn.getConnection();
	
	NaverDAO dao = new NaverDAO(conn);
	
	int result = dao.insertData(dto);
	
	DBconn.close();
	
	if(result!=0){
		response.sendRedirect("registerList.jsp");
	}
	
	
%>
<!-- if절이 실패하면 list로 안가지고 
내려오기때문에 밑에다가 입력오류입력  -->

입력오류
