<%@ page contentType="text/html; charset=UTF-8"%>
<% 
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<!-- form에 Name을 썻을시에 작동시키는것 -->
<script type="text/javascript">

	function sendIt() {
		
		var f = document.myForm;
		
		f.submit();
	}


</script>

</head>

<body>

<form action="friend_ok.jsp" method="post" name="myForm">

이름 : <input type="text" name = "userName"/><br/>

나이 : <input type="text" name = "userAge"/><br/>

성별 : <input type="radio" value ="남" name ="chkGender"/>남&nbsp;
		<input type="radio" value ="여" name ="chkGender"/>여<br/>

이상형 : <input type="checkbox" value ="청순" name ="chkIdtype"/>청순&nbsp;
			<input type="checkbox" value ="가련" name ="chkIdtype"/>가련&nbsp;
			<input type="checkbox" value="섹시" name ="chkIdtype"/>섹시<br/>
			
<input type="button" value="등록" onclick="sendIt();"/>

</form>




</body>
</html>
