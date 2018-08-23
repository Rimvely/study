<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>


<!-- id 중복체크소스바꾸기 check -->
<script type="text/javascript">

	/* blank Check  */
	 function blankCheck() {

		var f = document.myForm;

		if (f.userName.value == "") {
			alert("이름을 입력하세요!");
			document.myForm.userName.focus();
			return;
		}

		if (!f.userId.value) {
			alert("아이디를 입력하세요!");
			f.userId.focus();
			return;
			
			
		}
		
		if (!f.userNick.value) {
			alert("별명을 입력하세요!");
			f.userNick.focus();
			return;
			
			
		}
		
		if (!f.userPw1.value) {
			alert("비밀번호를 입력하세요!");
			f.userPw1.focus();
			return;
			
			
		}
		
		if (!f.userPw2.value) {
			alert("비밀번호 확인을 입력하세요!");
			f.userPw2.focus();
			return;
			
			
		}
		
		if (f.userPw1.value != f.userPw2.value){
			alert("비밀번호가 일치하지 않습니다. 다시 입력해 주세요!");
			f.userPw2.focus();
			return;
		}
		
		if (!f.sel1.value) {
			alert("원하시는 질문을 고르시거나 직접 입력하세요!");
			f.sel1.focus();
			return;
			
			
		}
		
		if (!f.answer1.value) {
			alert("질문을 입력하세요!");
			f.answer1.focus();
			return;
			
			
		}
		
		if (!f.answer2.value) {
			alert("답변을 입력하세요!");
			f.answer2.focus();
			return;
			
			
		}
		
		if (!f.email1.value) {
			alert("이메일을 입력하세요!");
			f.email1.focus();
			return;
			
			
		}
		
		if (!f.email2.value) {
			alert("이메일 @뒷 주소를 고르시거나 직접 입력하세요!");
			f.sel2.focus();
			return;
			
		}
		
		if (!f.sel2.value) {
			alert("주소를 고르시거나 직접 입력하세요!");
			f.sel2.focus();
			return;
			
			
		}
		
		if (!f.tel1.value) {
			alert("앞 번호를 선택하세요!");
			f.tel1.focus();
			return;
			
			
		}
		
		if (!f.tel2.value) {
			alert("가운데 번호들을 입력하세요!");
			f.tel2.focus();
			return;
			
			
		}
		
		if (!f.tel3.value) {
			alert("마지막 번호들을 입력하세요!");
			f.tel3.focus();
			return;
			
			
		}

		f.action = "naver2_ok.jsp";
		f.submit();
	}
	
	/* Email check */
	function emailCheck() {
		
		var f = document.myForm;
		
		var clength = f.sel2.options.length;
		
		var cval = f.sel2.selectedIndex;
		
		f.email2.value = "";
		
		if (cval == (clength -1)) {
			f.email2.readOnly = false;
		} else {
			f.email2.value = f.sel2.options[cval].value;
			f.email2.readOnly = true;
		}
	}
	
	/* answer check  */
	function answerCheck() {
		
		var f = document.myForm;
		
		var clength = f.sel1.options.length;
		
		var cval = f.sel1.selectedIndex;
		
		f.answer1.value = "";
		
		if (cval == (clength -1)) {
			
			f.answer1.readOnly = false;
		} else {
			f.answer1.value = f.sel1.options[cval].value;
			f.answer1.readOnly = true;
		}
		
	}
	/* number만 입력되게 */
 	function onlyNum() {
 		
		if((event.keyCode<48 || event.keyCode>57) 
				&& (event.keyCode<12592 || event.keyCode>12687)){
			event.returnValue = false;
		}
	}
 	
  	function emailCB() {
 		
 		var f = document.myForm;
 		
		if(f.emailCB.checked == true){
			f.email1.value="";
			f.sel2.readOnly = true;
			f.email1.readOnly = true;
			f.email2.readOnly = true;
		} else
			f.email1.readOnly=false;
			
		return;
	}
 	
 	/* 이메일 등록안함 체크박스 */
 	function emailCheck1() {
	
	var f= document.myForm;
	
	if(f.eCheck.checked){	
		f.email1.value ="";
		f.sel1.value="";
		f.email1.readOnly=true;
		f.sel1.readOnly=true;
	}else{
		f.email1.readOnly=false;
	}
}
</script>

<style type="text/css">

/* td border bottom  */
td.bgcolor {
	background-color: #F9F9F9;
	width: 110pt;
}

table.bg_color {
	background-color: #F9F9F9;
}

table.setWidth1 {
	width: 627pt;
}

table.setWidth2 {
	width: 600pt;
}

input[readonly] {
 background-color: #dddddd;
 
}
</style>


</head>
<body>

	<!-- 회원정보입력 및 개인정보취급 방침 -->

	
<form action="" name="myForm" method="post">
		<table class="setWidth1" border="0" height="100pt" cellspacing="0">

			<tr>
				<td
					style="border-bottom: 1px solid #EAEAEA; font-size: 13pt; font-family: 돋움;"><b>회원정보입력</b></td>
			</tr>

			<tr>
				<td
					style="border-top: 1px solid #EAEAEA; font-size: 9pt; font-family: 돋움; color: #A6A6A6; letter-spacing: 0px">
					<b>회원정보는 개인정보취급방침에 따라 안전하게 보호되며 회원님의 명백한 동의 없이 공개 또는 제3자에게 제공되지
						않습니다.</b> &nbsp;<font
					style="font-size: 9pt; font-family: 돋움; color: #005367"><u>개인정보취급방침</u></font>
				</td>
			</tr>

			<tr>
				<td style="border-bottom: 1px solid #EAEAEA; font-size: 9pt;"
					align="right"
					style="font-size: 9pt; font-family: 돋움; color:#A6A6A6; letter-spacing: 0px">
					<img src="../html1/image/navercheck.jpg">표시 필수입력사항
		</table>


		<table class="setWidth2" border="0" cellspacing="0">

			<!-- 이름 -->
			<tr>
				<td class="bgcolor"
					style="border-bottom: 1px solid #EAEAEA; border-top: 1px solid #EAEAEA; border-right: 1px solid #EAEAEA; font-size: 9pt; font-family: 돋움; letter-spacing: 0px">
					<img src="../html1/image/navercheck.jpg"><b>이름</b>
				</td>
				<td style="border-bottom: 1px solid #EAEAEA; border-top: 1px solid #EAEAEA;">
					<input name="userName" type="text">
				</td>
			</tr>

			<!-- 아이디 -->
			<tr>
				<td class="bgcolor"
					style="border-right: 1px solid #EAEAEA; font-size: 9pt; font-family: 돋움; letter-spacing: 0px">
					<img src="../html1/image/navercheck.jpg"><b>아이디</b>
				</td>
				<td style="font-size: 9pt; font-family: 돋움; letter-spacing: 0px">
					<input name="userId" type="text" name="id">@naver.com 
					 <img src="../html1/image/naverDuplicate.jpg">
				
				</td>
			</tr>

			<tr>
				<td class="bgcolor"
					style="border-bottom: 1px solid #EAEAEA; border-right: 1px solid #EAEAEA;">
				</td>
				<td style="border-bottom: 1px solid #EAEAEA; padding-top: -5pt;">
					<font
					style="font-size: 9pt; font-family: 돋움; color: #B1B1B1; letter-spacing: 0px">
						입력하신 아이디로 네이버 이메일 주소가 생성됩니다.</font>
				</td>
			</tr>

			<!-- 별명 -->
			<tr>
				<td class="bgcolor"
					style="border-bottom: 1px solid #EAEAEA; border-right: 1px solid #EAEAEA; font-size: 9pt; font-family: 돋움; letter-spacing: 0px">
					<img src="../html1/image/navercheck.jpg"><b>별명</b>
				</td>
				<td style="border-bottom: 1px solid #EAEAEA;">
				<input name="userNick" type="text"></td>
			</tr>

			<!-- 비밀번호 -->
			<tr>
				<td class="bgcolor"
					style="border-bottom: 1px solid #EAEAEA; border-right: 1px solid #EAEAEA; font-size: 9pt; font-family: 돋움; letter-spacing: 0px">
					<img src="../html1/image/navercheck.jpg"><b>비밀번호</b>
				</td>
				<td style="border-bottom: 1px solid #EAEAEA;">
					<input name="userPw1" type="password"> <font
					style="font-size: 9pt; font-family: 돋움; color: #005367"> <u>비밀번호
							도움말</u></font></td>
			</tr>
			<!-- 비밀번호 확인  -->
			<tr>
				<td class="bgcolor"
					style="border-bottom: 1px solid #EAEAEA; border-right: 1px solid #EAEAEA; font-size: 9pt; font-family: 돋움; letter-spacing: 0px">
					<img src="../html1/image/navercheck.jpg"><b>비밀번호 확인</b>
				</td>
				<td style="border-bottom: 1px solid #EAEAEA;">
					<input name="userPw2" type="password"></td>
			</tr>

			<!-- 비밀번호 발급수단 -->
			<tr>
				<td class="bgcolor"
					style="border-right: 1px solid #EAEAEA; font-size: 9pt; font-family: 돋움; letter-spacing: 0px">
					<img src="../html1/image/navercheck.jpg"><b>비밀번호 발급 수단</b>
				</td>

				<td
					style="padding: 10pt; font-size: 9pt; font-family: 돋움; color: #CEA73D; letter-spacing: 0px">
					아래 항목은 아이디확인, 임시비밀번호를 발급 시 반드시 필요한 정보입니다.<br /> 정확한 정보를 입력한 후 꼭 기억해
					주세요.
				</td>
			</tr>

			<tr>
				<td class="bgcolor"></td>
				<td style="border-bottom: 1px solid #EAEAEA;" align="center">
					<!-- 1.비밀번호 질문·답 -->
					<table class="bg_color" border="0" width="680pt"
						style="font-size: 9pt; font-family: 돋움; color: #000000; 돋움; letter-spacing: 0px;"
						cellspacing="0" cellpadding="3">
	
						<tr>
							<td><b>&nbsp;&nbsp;1.비밀번호 질문·답</b></td>
						</tr>
	
						<tr style="padding: 10px;">
							<td>
	
							&nbsp;&nbsp;질문 
							<select
								style="width: 460pt; height: 15pt" name="sel1"
								onchange="answerCheck();">
									<option value="">선택하세요</option>
									<option value="가장 기억에 남는 장소는?">가장 기억에 남는 장소는?</option>
									<option value="가장 기억에 남는 영화는?">가장 기억에 남는 영화는?</option>
									<option value="직접입력">직접입력</option>
							</select>
						
							</td>
						</tr>
	
						<tr>
							<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
							<input type="text" name="answer1" readonly="readonly"
								style="padding: 1px; width: 455pt;" />
							</td>
						</tr>
	
						<tr>
							<td>&nbsp;&nbsp;답변 <input type="text" name="answer2"
								style="width: 457pt;">
							</td>
						</tr>
	
						<!-- 2. 이메일 주소  -->
						<tr>
							<td><b>&nbsp;&nbsp;2.이메일 주소</b></td>
						</tr>
						<tr>
							<td>
							&nbsp;&nbsp;<input type="text" name="email1"
								style="width: 80pt;" /> @ <input type="text" name="email2"
								readonly="readonly" /> <select name="sel2"
								onchange="emailCheck();">
									<option value="">선택하세요</option>
									<option value="naver.com">네이버</option>
									<option value="hanmail.net">다음</option>
									<option value="gmail.com">구글</option>
									<option value="yahoo.co.kr">야후</option>
									<option value="">직접입력</option>

							</select> <input name="emailCB" type="checkbox" onclick="emailCB();">등록 안함
	
							</td>
						</tr>

						<!-- 3.휴대폰 번호 -->
						<tr>
							<td><b>&nbsp;&nbsp;3. 휴대폰 번호</b></td>
						</tr>
						<tr>
							<td>&nbsp;&nbsp;<select name="tel1" style="width: 80pt;">
									<option value="">선택</option>
									<option value="010">010</option>
									<option value="011">011</option>
									<option value="070">070</option>
							</select> <input type="text" name="tel2" onkeypress="onlyNum();"
								style="width: 80pt;" /> - <input type="text" name="tel3"
								onkeypress="onlyNum();" style="width: 80pt;" /> <input
								name="telCB" type="checkbox" onclick="telCB();" >등록 안함
							</td>
						</tr>

					</table>
				</td>
			</tr>
			<!-- 소식지 수신 -->
			<tr style="font-size: 9pt; font-family: 돋움; letter-spacing: 0px">
				<td class="bgcolor"
					style="border-top: 1px solid #EAEAEA; border-bottom: 1px solid #EAEAEA; border-right: 1px solid #EAEAEA;">
					&nbsp;&nbsp;<b>소식지 수신</b>
				</td>
				<td style="border-bottom: 1px solid #EAEAEA;"><input
					type="checkbox">네이버 메일로 네이버 소식지를 수신합니다.</td>
			</tr>

			<!-- 확인 이미지 -->
			<tr align="center">
				<td
					style="border-bottom: 1px solid #EAEAEA; border-top: 1px solid #EAEAEA;"
					height="80pt" colspan="2">
						<a href="javascript:blankCheck();">
							<img src="../html1/image/naveryes.jpg">
						</a>
				</td>
					
			</tr>

			<!-- 마지막 배너  -->
			<tr align="center">
				<td height="80pt" colspan="2"><img
					src="../html1/image/naverbottom.jpg" width="820pt"></td>
			</tr>




		</table>
</form>
	




</body>
</html>
