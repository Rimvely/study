<%@ page contentType="text/html; charset=UTF-8"%>
<% 
request.setCharacterEncoding("UTF-8");
%>

<%
	int n=0;

	String count = (String)application.getAttribute("count");
	
	if(count!=null)
		n = Integer.parseInt(count);
	
	n++;
	
	application.setAttribute("appCount",Integer.toString(n));
	
	//실제 접속자의 주소
	String realPath = application.getRealPath("/");
	application.log("접속자 :" + request.getRemoteAddr());


%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

총 접속자 수 : <%=n %><br/>
총 서버 실제 경로 : <%=realPath %>





</body>
</html>
