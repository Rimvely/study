<%@ page contentType="text/html; charset=UTF-8"%>
<% 
request.setCharacterEncoding("UTF-8");
%>

<%
	/* userBox 배안에 있는 Rimi를 지워라 
	   변수 안에 Data 삭제 */
	session.removeAttribute("userBox");

	/* 배도 지워라 변수삭제  */
	session.invalidate();
	
	/* session을 지웠으니까 null을 줬는데 null일때 자료를 보여주는데
	   < % % > 했잖아. 그거 확인해봐
	*/
	response.sendRedirect("login.jsp");




%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>









<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
</body>
</html>
