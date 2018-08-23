<%@page import="com.guest.GuestDAO"%>
<%@page import="util.DBconn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	
	request.setCharacterEncoding("UTF-8");

	String cp = request.getContextPath();
%>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");	

	Connection conn = DBconn.getConnection();

	GuestDAO dao = new GuestDAO(conn);
	
	int result = dao.deleteData(num);
	
	DBconn.close();
	
	if(result!=0){
		response.sendRedirect(cp+"/guest/guest.jsp?pageNum="+pageNum);
	}




%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>





<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
</body>
</html>
