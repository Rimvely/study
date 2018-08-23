<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	//한글을 3바이트로 받아줘서 안깨지게해주는것
	request.setCharacterEncoding("UTF-8");
//  cp = ~/study 까지 경로
	String cp = request.getContextPath();
%>

<%

	//쿠키에 데이터를 저장
	//쿠키는 정보를 서버에 저장하지않고 클라이언트에 저장
	
	//name이라는 변수에 suzi를 저장
	Cookie c1 = new Cookie("name", "suzi");
	Cookie c2 = new Cookie("age", "25");
	Cookie c3 = new Cookie("addr", URLEncoder.encode("서울", "UTF-8"));
	
	//서버가 클라이언트에게 쿠키를 보냄 보내는 
	
	response.addCookie(c1);
	response.addCookie(c2);
	response.addCookie(c3);
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<a href="c2.jsp">쿠키</a>





<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
</body>
</html>
