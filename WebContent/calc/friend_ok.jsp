<%@ page contentType="text/html; charset=UTF-8"%>
<% 
request.setCharacterEncoding("UTF-8");
%>

<%-- <%
	
	String chkIdtype[] = request.getParameterValues("chkIdtype");

	String str = "";
	if(chkIdtype!=null){
		
		for(String temp:chkIdtype)
			str += temp + " ";
	}



%> --%>


<jsp:useBean id="vo" class="com.calc.FriendVO" scope="page"/>
<jsp:setProperty property="*" name="vo"/>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

이름 : <%=vo.getUserName() %><br/>
나이 : <%=vo.getUserAge() %><br/>
성별 : <%=vo.getChkGender() %><br/>
이상형 : 

		<%
		/* String chkIdtype[] = request.getParameterValues("chkIdtype"); */
		String chkIdtype[] = vo.getChkIdtype();
		
		String str = "";
		
		if(chkIdtype!=null){
	
			for(String temp:chkIdtype)
		
			str += temp + " ";
		}
		%>
		
		<%=str %>





</body>
</html>
