<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	//한글을 3바이트로 받아줘서 안깨지게해주는것
	request.setCharacterEncoding("UTF-8");
//  cp = ~/study 까지 경로
	String cp = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<c:set var="url" value="gugudan.jsp"/>
<c:import url="${url }" var="box">
	<c:param name="dan" value="5"/>
</c:import>
<c:out value="${box }" escapeXml="false"/>

<br/><br/>

<c:set var="url" value="https://www.daum.net"/>
<c:import url="${url }" var="box2"/>
<c:out value="${url }"/>
<br/>
<hr/>
<c:out value="${box2 }" escapeXml="false"/>



</body>
</html>
