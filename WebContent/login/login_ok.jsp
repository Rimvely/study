<%@ page contentType="text/html; charset=UTF-8"%>
<% 
request.setCharacterEncoding("UTF-8");
%>

<%

	String userId = request.getParameter("userId");
	String userPwd = request.getParameter("userPwd");
	
	if(userId.equals("rimi")&&userPwd.equals("811")){
		/*session에 띄워야겠지
		  "userId 호에 userId를 태운다"	
		*/
		session.setAttribute("userBox", userId);
		
		/*  
		response.sendRedirect가 실행되니까 밑에 실행이 안된다
		*/
		response.sendRedirect("login.jsp");
	}
%>

아이디나 패스워드가 틀립니다!

<a href="login.jsp"><br/>돌아가기</a>


</html>
