<%@ page contentType="text/html; charset=UTF-8"%>
<% 
request.setCharacterEncoding("UTF-8");
%>

<%
	int width = Integer.parseInt(request.getParameter("width"));
	int height = Integer.parseInt(request.getParameter("height"));

	int n = 0;
%>









<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	
<table border=1 cellpadding="0" cellspacing="0" width="600pt">
<!-- JSP in html = < % % > -->
<!-- html in JSP = out.print();    -->
<%
	for(int i=1; i<=width; i++){
		out.print("<tr>");
		for(int j=1; j<=height; j++){
			n++;
%>
	<td width="50"><%=n %></td>
<%		
		}
%>
	</tr>
<%
	}
%>
	
	
	
	
</table>






</body>
</html>
