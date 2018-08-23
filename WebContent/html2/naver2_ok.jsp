<%@ page contentType="text/html; charset=UTF-8"%>
<% 
request.setCharacterEncoding("UTF-8");
%>

<%
	//int값 받을땐 
	//int su1 = Integer.parseInt(request.getParameter("su1"));
	String userName = request.getParameter("userName");
	String userId = request.getParameter("userId");
	String userNick = request.getParameter("userNick");
	String userPw1 = request.getParameter("userPw1");
	String userPw2 = request.getParameter("userPw2");
	String answer1 = request.getParameter("answer1");
	String answer2 = request.getParameter("answer2");
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");
	String tel1 = request.getParameter("tel1");
	String tel2 = request.getParameter("tel2");
	String tel3 = request.getParameter("tel3");


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

이름 : <%=userName %><br/>
아이디 : <%=userId %><br/>
별명 : <%=userNick %><br/>
비밀번호 : <%=userPw1 %><br/>
비밀번호 찾기
질문 : <%=answer1 %><br/>
답변 : <%=answer2 %><br/>
이메일 : <%=email1%>@<%=email2 %><br/>
전화번호 : <%=tel1 %>-<%=tel2 %>-<%=tel3 %><br/>





</body>
</html>
