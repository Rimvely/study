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
<title>회원 탈퇴</title>

<link rel="stylesheet" href="<%=cp %>/member/css/style.css" type="text/css"/>

<script type="text/javascript">
	
	function sendIt() {
		
		var f = document.myForm;
		
		if(!f.userId.value){
			alert("아이디를 입력하세요!");
			f.userId.focus();
			return;
		}
		
		if(!f.userPwd.value){
			alert("비밀번호를 입력하세요!");
			f.userTel.focus();
			return;
		}
		
		f.action = "<%=cp %>/join/delete_ok.do";
		f.submit();
		
	}

</script>

</head>
<body>

<br/><br/>

<form action="" method="post" name="myForm">

<table border="0" align="center" cellpadding="0" cellspacing="0" width="350">

	<tr height="2">
		<td colspan="2" bgcolor="#cccccc"></td>
	</tr>
	
	<tr height="30">
		<td colspan="2" align="center">
		<b>회원정보 삭제</b>
		</td>
	</tr>
	
	<tr height="2">
		<td colspan="2" bgcolor="#cccccc"></td>
	</tr>
	
	<tr height="25">
		<td width="80" bgcolor="#e6e6e6" align="center">
		아이디
		</td>
		<td width="200" style="padding-left: 5px">
		<input type="text" name="userId" value="${sessionScope.customInfo.userId }" readonly="readonly"  maxlength="10" size="15"
		style="width: 100px; height: 20px;"/>
		</td>
	</tr>
		
	<tr height="2">
		<td colspan="2" bgcolor="#cccccc"></td>
	</tr>
	
		<tr height="25">
		<td width="80" bgcolor="#e6e6e6" align="center">
		비밀번호
		</td>
		<td width="120" style="padding-left: 5px">
		<input type="password" name="userPwd" maxlength="10" size="15"
		style="width: 100px; height: 20px;"/> <b>예) 010-1111-1111</b>
		</td>
		
	<tr height="2">
		<td colspan="2" bgcolor="#cccccc"></td>
	</tr>
		
	<tr>
		<td colspan="2" align="center">
		<input type="button" value="삭제" class="btn2"
		onclick="sendIt();"/>
				<input type="button" value="취소" class="btn2"
		onclick="javascript:location.href='<%=cp %>';"/>
		</td>
	</tr>
	
	
	<tr height="30">
		<td colspan="2" align="center">
		<font color="red"><b>${message }</b></font>
		</td>
	</tr>	
		<c:choose>
			<c:when test="${message ne null }">
	<tr>
				<td colspan="2" align="center">
					<input type="button" value="메인" class="btn2"
					onclick="javascript:location.href='<%=cp %>';"/>
				</tr>
	<tr>
			</c:when>
		</c:choose>
	


</table>

</form>




</body>
</html>
