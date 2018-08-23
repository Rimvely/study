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

수 1 : <input type="text" name="su1"/><br/>
수 2 : <input type="text" name="su2"/><br/>
<input type="submit" value="결과"/><br/>

</form>

<br/><br/>
<c:if test="${!empty param.su1 }">

	<c:set var="result" value="1"/>
	
	<c:forEach var="a" begin="1" end="${param.su2 }" step="1">
	
	<c:set var="result" value="${result*param.su1 }"/>
	
		${param.su1 }^${a }=${result }<br/>
	
	</c:forEach>

</c:if>


<br/><br/>

<form action="" method="post">
	수 : <input type="text" name="su"/><br/>
	<input type="submit" value="결과"/><br/>
</form>

<c:if test="${!empty param.su }">

<c:choose>

	<c:when test="${param.su%3==0&&param.su%4==0 }">
		${param.su }은 3과 4의 배수
	</c:when>

	<c:when test="${param.su%3==0}">
		${param.su }은 3의 배수
	</c:when>
	
	<c:when test="${param.su%4==0 }">
		${param.su }은 4의 배수
	</c:when>
	
	<c:otherwise>
		${param.su }은 3과 4의 배수가 아님
	</c:otherwise>
	
</c:choose>


</c:if>












</body>
</html>
