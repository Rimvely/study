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

<link rel="stylesheet" href="<%=cp %>/member/css/style.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp %>/member/css/created.css" type="text/css"/>

<script type="text/javascript" src="<%=cp %>/member/js/util.js"></script>
<script type="text/javascript">

	function sendIt() {
		
		var f = document.myForm;
		
/* 		str = f.userId.value;
		str = str.trim();
		if(!str){
			alert("아이디를 입력하세요!");
			f.userId.focus();
			return;
		}
		f.userId.value = str; */
		
		str = f.userPwd.value;
		str = str.trim();
		if(!str){
			alert("비밀번호를 입력하세요!");
			f.userPwd.focus();
			return;
		}
		f.userPwd.value = str;
		
/* 		str = f.userName.value;
		str = str.trim();
		if(!str){
			alert("이름을 입력하세요!");
			f.userName.focus();
			return;
		}
		f.userName.value = str; */
		
		str = f.userBirth.value;
		str = str.trim();
		if(!str){
			alert("생년월일을 입력하세요!");
			f.userBirth.focus();
			return;
		}
		f.userBirth.value = str;
		
		
		str = f.userTel.value;
		str = str.trim();
		if(!str){
			alert("전화번호를 입력하세요!");
			f.userTel.focus();
			return;
		}
		f.userTel.value = str;
		
		f.action = "<%=cp %>/join/update_ok.do";
		f.submit();
		
		
	}

</script>

</head>
<body>

<div id="bbs">
	<div id="bbs_title">
	회원정보 수정
	</div>
	
	<form action="" method="post" name="myForm">
	<div id="bbsCreated">
	
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>아&nbsp;이&nbsp;디</dt>
				<dd>
				${dto.userId }
				<input type="hidden" name="userId" value="${dto.userId }" size="35" maxlength="20" class="boxTF"/>
				</dd>
			</dl>
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>패스워드</dt>
				<dd>
				<input type="password" name="userPwd" value="${dto.userPwd }" size="35" maxlength="20" class="boxTF"/>
				</dd>
			</dl>
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름</dt>
				<dd>
				${dto.userName }
				<input type="hidden" name="userName" value="${dto.userName }" size="35" maxlength="20" class="boxTF"/>
				</dd>
			</dl>
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>생&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;일</dt>
				<dd>
				<input type="text" name="userBirth" size="35" value="${dto.userBirth }" maxlength="50" class="boxTF"/> <b>예) 1977-01-01</b>
				</dd>
			</dl>
		</div>
		
		<div class="bbsCreated_bottomLine">
			<dl>
				<dt>전&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;화</dt>
				<dd>
				<input type="text" name="userTel" size="35" value="${dto.userTel }" maxlength="50" class="boxTF"/>
				</dd>
			</dl>
		</div>
		
	</div>
	
	<div id="bbsCreated_footer">
	<input type="button" value=" 수정하기 " class="btn2"
		onclick="sendIt();"/>
		
	<input type="button" value=" 작성취소 " class="btn2"
		onclick="javascript:location.href='<%=cp %>';"/>
	
	</div>

	</form>




</div>














</body>
</html>
