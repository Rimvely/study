<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	//한글을 3바이트로 받아줘서 안깨지게해주는것
	request.setCharacterEncoding("UTF-8");
//  cp = ~/study 까지 경로
	String cp = request.getContextPath();
%>

<%
	Cookie c1 = new Cookie("name", "hong");
	Cookie c2 = new Cookie("age", "30");
	Cookie c3 = new Cookie("addr", "seoul");
	Cookie c4 = new Cookie("tel", "010-1234-1234");
	
	//쿠키도 저장할때 유효기간이 있다
	c1.setMaxAge(0);//바로 지워짐
	c2.setMaxAge(-1);//끝까지 남음
	c3.setMaxAge(10);//10초후 삭제 
	
	c2.setPath("/"); //쿠키값을 어디서나 접근 가능
	c3.setPath("/board"); //board에서만 접근 가능
	
	response.addCookie(c1);
	response.addCookie(c2);
	response.addCookie(c3);
	response.addCookie(c4);





%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<a href="c4.jsp">확인</a>



<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
</body>
</html>
