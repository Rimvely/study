<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<%
	/*  EL(Expression Language)
		표현언어
		null 에 관대하고 데이터 형변활을 자동으로
	*/
	
	/* RESULT에다가 넣는다
	   이걸 밑에서 받아보겟다
	*/
	request.setAttribute("result", "테스트");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- action을 생략하면 자기자신을 호출 -->
<form action="" method="post">

수 : 1 <input type="text" name="su1"/><br/>
수 : 2 <input type="text" name="su2"/><br/>
<input type="submit" value="결과"/><br/>

</form>

<br/><br/>
결과 : ${param.su1 + param.su2 }<br/>
${param.su1 }은 ${param.su1%2==0?"짝수":"홀수"}<br/>

${result }<br/>
</body>
</html>
