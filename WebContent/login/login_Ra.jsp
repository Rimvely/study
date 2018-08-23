<%@ page contentType="text/html; charset=UTF-8"%>
<% 
request.setCharacterEncoding("UTF-8");
%>
<!-- login_ok.jsp에서 set된걸 get하기  -->
<% 
	String userId = (String)session.getAttribute("userBox");
	/* session에 데이터를 보관할 시간 5초
	session.setMaxInactiveInterval(5);
	*/
	//session.setMaxInactiveInterval(5);
%>





<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	function sendIt() {
		var f = document.myForm;
		
		if(!f.userId.value){
			alert("아이디를 입력하세요!")
			f.userId.focus();
			return;
		}
		
		if(!f.userPwd.value){
			alert("비밀번호를 입력하세요!")
			f.userPwd.focus();
			return;
		}
		
		//f.action = "login_ok.jsp";
		f.submit();
	}


</script>



</head>
<body>

<table border="1" width="600" align="center" style="font-size: 9pt;" cellpadding="3">
	<tr height="20">
		<td colspan="2" align="right">
		| 게시판 |>
		
		<!-- 여기는 html영역이라서 < % % > 넣는다.  -->
		<%if(userId==null){%>
		일정관리	
		<%}else{ %>
		<a href="schedule.jsp">일정관리</a>
		<%} %>
		
		|
		</td>
	</tr>

	<tr height="400">
		<td width="100" valign="top">
			
		<%if(userId==null){%>
			<form action="login_ok.jsp" method="post" name="myForm">
			
				아이디:<input type="text" name="userId" size="10"/><br/>
				패스워드:<input type="password" name="userPwd" size="10"><br/>
		
				<input type="button" value="로그인" onclick="sendIt();"/>
			</form>
		<%}else{ %>
		<%=userId %>님 방가방가!<br/><br/>
		
		<a href="logout.jsp">로그아웃</a>
		
		
		<%} %>
		</td>
		
		<td valign="middle" align= "center">
			<b>로그인하면 새로운 세상이 보입니다!!</b>
		</td>
	</tr>

</table>















<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
</body>
</html>
