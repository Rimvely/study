<%@ page contentType="text/html; charset=UTF-8"%>

<%
	/* 코딩을 받을때 깨지지 않게 하기 위해서  */
	request.setCharacterEncoding("UTF-8");	

	/* String su1 = request.getParameter("su1");
	String su2 = request.getParameter("su2");

	int s1 = Integer.parseInt(su1);
	int s2 = Integer.parseInt(su2); 
	
	
	4줄 코딩을 한번에 하는 방법*/
	int su1 = Integer.parseInt(request.getParameter("su1"));
	int su2 = Integer.parseInt(request.getParameter("su2"));
	String name = request.getParameter("name");
	
	
	int sum=0;
	
	sum=su1+su2;


%>









<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%=su1%>+<%=su2 %>=<%=sum %><br/>
이름:<%=name %><br/>





</body>
</html>
