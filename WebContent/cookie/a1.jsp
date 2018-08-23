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
	Cookie c = new Cookie("productName1", URLEncoder.encode("냉장고", "UTF-8"));

	
	c.setMaxAge(15); //10초
	
	response.addCookie(c);


%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

잘 어는 냉장고<br/>
<img alt="" src="./image/냉장고.jpg"/><br/>
<a href="sharp.jsp">돌아가기</a>
























</body>
</html>
