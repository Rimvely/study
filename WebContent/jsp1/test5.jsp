<%@ page contentType="text/html; charset=UTF-8"%>
<% 
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<form action="test5_ok.jsp" method="post">

이름 : <input type="text" name="name"/><br/>

메모 : <br/>
<textarea rows="5" cols="30" name="memo"></textarea><br/>

이상형 : <br/>
<input type="checkbox" name="type" value="웃는여자">웃는여자<br/>
<input type="checkbox" name="type" value="청순한여자">청순한여자<br/>
<input type="checkbox" name="type" value="긴머리">긴머리<br/>
<input type="checkbox" name="type" value="여자라면">여자라면...<br/>

전공 : <br/>
<select name="major">
	<option value="컴공">컴공</option>
	<option value="수학">수학</option>
	<option value="영문">영문</option>
	<option value="OA">OA</option>
</select>
<br/><br/>

취미 : <br/>
<select name="hb" size="4" multiple="multiple">
	<option value="게임">게임</option>
	<option value="운동">운동</option>
	<option value="영화">영화</option>
	<option value="음악">음악</option>
</select>
<br/><br/>








<input type="submit" value="전송"/>

</form>




</body>
</html>
