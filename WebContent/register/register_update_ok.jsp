<%@page import="com.register.NaverDAO"%>
<%@page import="util.DBconn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	//한글을 3바이트로 받아줘서 안깨지게해주는것
	request.setCharacterEncoding("UTF-8");
	
//	D:\Java\work\.metadata\.plugins
//  \org.eclipse.wst.server.core\tmp0\work
//  \Catalina\localhost\study\org\apache\jsp\score

//  cp = ~/study 까지 경로
	String cp = request.getContextPath();
%>

<jsp:useBean id="dto" class="com.register.NaverDTO" scope="page"/>
<jsp:setProperty property="*" name="dto"/>

<%
	Connection conn = DBconn.getConnection();

	NaverDAO dao = new NaverDAO(conn);
	
	int result = dao.updateData(dto);
	
	DBconn.close();
	
	if(result!=0){
		response.sendRedirect("registerList.jsp");
	}

%>


<!-- if절이 실패하면 list로 안가지고 내려오기때문에 밑에다가 입력오류입력  -->

입력오류

