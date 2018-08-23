<%@ page contentType="text/html; charset=UTF-8"%>
<% 
request.setCharacterEncoding("UTF-8");
%>

<%

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	function sendIt() {
		
		var f = document.myForm;
		
		if(!f.userName.value){
			alert("이름입력!");
			f.userName.focus;
			return;
		}
		
		if(!f.userBirth.value){
			alert("생일입력!");
			f.userBirth.focus;
			return;
		}
		
		f.submit();
		
	}



</script>


</head>
<body>

<!-- Submit은 action을 찾아간다 -->
<form action="ex2.jsp" method="post" name="myForm">

이름 : <input type="text" name="userName" size="10"/><br/>
생일 : <input type="text" name="userBirth" size="10"/><br/>
<input type="button" value="다음" onclick="sendIt();"/>

</form>



</body>
</html>
