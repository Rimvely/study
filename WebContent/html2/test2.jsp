<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<script type="text/javascript">
	function test1(color) {

		document.bgColor = color;

	}

	function idpwCheck() {

		var f = document.myForm;

		if (f.id.value == "") {
			alert("아이디를 입력하세요!");
			document.myForm.id.focus();
			return;
		}

		if (!f.pw.value) {
			alert("비밀번호를 입력하세요!");
			f.pw.focus();
			return;
		}

		alert("로그인 성공!!");
	}
</script>




<body>

	배경색 선택하기
	<br />
	<input type="radio" name="r1" value="white" checked="checked"
		onclick="test1('white');" />white

	<input type="radio" name="r1" value="red" onclick="test1('red');" />red

	<input type="radio" name="r1" value="blue" onclick="test1('blue');" />blue

	<input type="radio" name="r1" value="yellow" onclick="test1('yellow');" />yellow

	<br />
	<br />


	<br />
	<hr color="red" size="3" />
	<br />

	<form action="" name="myForm">
		<table style="font-size: 10pt; font-family: 돋움;" cellpadding="3">
			<tr>
				<td><b>아이디</b></td>
				<td><input type="text" name="id"
					style="width: 100pt; height: 13pt;" /></td>
				<td></td>
			</tr>

			<tr>
				<td><b>패스워드</b></td>
				<td><input type="password" name="pw"
					style="width: 100pt; height: 13pt;" /></td>
				<td>
					<!-- 				<a href="javascript:idpwCheck();"> <img
						src="../html1/image/btn_login.gif">
				</a> --> <input type="button" value="로그인" onClick="idpwCheck();" />

				</td>
			</tr>

			<tr>
				<td colspan="3" align="center"><input type="checkbox">아이디
					저장 <input type="checkbox" checked="checked">보안접속</td>
			</tr>

			<tr height="1">
				<td colspan="3" bgcolor="#dad6d7"></td>
			</tr>


		</table>
	</form>

	<br />
	<hr color="red" size="3" />
	<br />

</body>
</html>
