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

<form action="" method="post">

단 : <input type="text" name="dan"/><br/>
<input type="submit" value="결과"/><br/><br/>

</form>

<table border="1" >
<c:if test="${!empty param.dan }">

		<c:forEach var="i" begin="1" end="9" step="1">
		<tr>
		<td width="80" align="center">	${param.dan } * ${i } = ${param.dan * i }</td>
		</tr>
		</c:forEach>
	
</c:if>
</table>




















</body>
</html>
