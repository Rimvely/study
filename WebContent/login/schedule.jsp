<%@ page contentType="text/html; charset=UTF-8"%>
<% 
request.setCharacterEncoding("UTF-8");
%>
<!-- session id 정보를 받을때도 명령어를 쳐야한다 -->
<% 
	String sID = session.getId();
	int sTime = session.getMaxInactiveInterval();

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<h3>일정관리</h3>

<!-- session id 정보  -->
Session아이디 : <%=sID %><br/>
Session유효시간 : <%=sTime %>

<a href="login.jsp"><br/><br/>돌아가기</a>









<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
</body>
</html>
