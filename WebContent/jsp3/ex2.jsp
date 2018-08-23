<%@ page contentType="text/html; charset=UTF-8"%>
<% 
request.setCharacterEncoding("UTF-8");
%>

<%
	
	String userName = request.getParameter("userName");
	String userBirth = request.getParameter("userBirth");

	
	
	
	
	//session.setAttribute("sessionedName",userName);
	//session.setAttribute("sessionUedBirth", userBirth);




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
			alert("아이디입력!");
			f.userName.focus;
			return;
		}
		
		if(!f.userPwd.value){
			alert("비밀번호입력!");
			f.userBirth.focus;
			return;
		}
		
		f.submit();
		
	}



</script>


</head>
<body>

<!-- Submit은 action을 찾아간다 -->
<form action="ex3.jsp" method="post" name="myForm">

아이디 : <input type="text" name="userId" size="10"/><br/>
패스워드 : <input type="text" name="userPwd" size="10"/><br/>

<!-- session에 넣지않고 form에 넣는다 to send ex1_info into ex3.jsp  -->
<!-- ex1받은걸 자동으로 ex2에서 받아야하기때문에 value에 저 값을 넣어준다  -->
<!-- text 타입으로 하면 보이는건데 hidden 타입으로하면 있는데 안보인다 -->
<input type="hidden" name=userName value="<%=userName%>"><br/>
<input type="hidden" name=userBirth value="<%=userBirth%>"><br/>
<input type="button" value="가입" onclick="sendIt();"/>

</form>



</body>
</html>
