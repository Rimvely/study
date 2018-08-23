<%@page import="java.net.URLDecoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
request.setCharacterEncoding("UTF-8");
%>

<%
	String eng = request.getParameter("eng");
	String korean = request.getParameter("kor");
	
	String kor = URLDecoder.decode(korean, "UTF-8");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

Being foward value<br/>

eng : <%=eng %><br/>
kor : <%=kor %><br/>



</body>
</html>
