<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>


<%
	String eng = "test";
	String kor = "테스트";
	
	/* jsp:foward에선 한글은 무조건 깨진다 그래서 압축해서보낸다  */
	String korean = URLEncoder.encode(kor, "UTF-8");





%>

<jsp:forward page="f2.jsp">
	<jsp:param value="<%=eng %>" name="eng"/>
	<jsp:param value="<%=korean %>" name="kor"/>
</jsp:forward>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>







</body>
</html>
