<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	//한글을 3바이트로 받아줘서 안깨지게해주는것
	request.setCharacterEncoding("UTF-8");
	
//	D:\Java\work\.metadata\.plugins
//  \org.eclipse.wst.server.core\tmp0\work
//  \Catalina\localhost\study\org\apache\jsp\score

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

<form action="<%=cp%>/ss1" method="post">
이름 : <input type="text" name="name"/><br/>
나이 : <input type="text" name="age"/><br/>
<input type="submit" value="확인"/><br/>
</form>





<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
</body>
</html>
