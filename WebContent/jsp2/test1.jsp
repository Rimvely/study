<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page buffer="1kb" autoFlush="true"%>
<% 
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 웹페이지도 사이즈가 있다.
	 맨위에
     page buffer="1kb" autoFlush="true"
     기본값 autoFlush="true" 이 트루다
     autoFlush="false"로 하면 에러 발생
-->

<% for(int i=1; i<=1000; i++){ %>
		1234
	<%} %>








</body>
</html>
