<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	//한글을 3바이트로 받아줘서 안깨지게해주는것
	request.setCharacterEncoding("UTF-8");
//  cp = ~/study 까지 경로
	String cp = request.getContextPath();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">

.bgimg {
    border: 0;
    padding: 0; 
    min-height: 100%;
    background-position: center;
    background-size: cover;
}

table {
	
	border: 0px solid white;
	padding: 0;

}

td {
	width: 200;
}



</style>

</head>
<body background="../sung/image/nightview.jpg" class="bgimg">

<form action="<%=cp %>/file/write_ok.do" method="post"
enctype="multipart/form-data">

<table border="0" align="center">
	<tr>
		<td height="100">
		</td>
	</tr>
	<tr>
		<td>
			<font color="#ffffff">제목 </font> <input type="text" name="subject"/>
		</td>
	</tr>
	<tr>
		<td>
			<font color="#ffffff">파일 </font> <input type="file" name="upload" align="right">
		</td>
	</tr>
	<tr>
		<td align="right">	
			<input type="submit" value="완료"/>
		</td>
	</tr>



</table>
</form>


</body>
</html>
