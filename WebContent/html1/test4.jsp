<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
/*head에 적용시키면 전체 페이지에 적용시킬수 있는것
TEXT/CSS를 적용
*/
body {
	font-size: 11pt; /*오로지 TEXT만 적용받음*/
}
/* .c1은 내맘대로 이름 붙인것 */
span.c1 {
	color: blue;
}

span.c2 {
	color: purple;
}
</style>
</head>
<body>

	<!-- CSS  -->

	<h3>CSS(Casccade Style Sheet)</h3>

	<font size="7">폰트 7사이즈</font>
	<br />

	<font style="font-size: 9pt">폰트 9사이즈</font>
	<br />
	<font style="font-size: 19pt">폰트 19사이즈</font>
	<br />
	<font style="font-size: 29pt">폰트 29사이즈</font>
	<br />
	<font style="font-size: 39pt">폰트 39사이즈</font>
	<br />
	<font style="font-size: 60pt">폰트 60사이즈</font>
	<br />

	<hr color="red" size="3" />

	<table>
		<tr>
			<td><font color="blue" size="4"> 코나 아이언맨 에디션은 마블 캐릭터를 적용한
					세계 최초의 양산차 모델이다. 마블과 현대차 디자이너의 협업을 통해 완성했다. 디자인은 영화 ‘아이언맨’에 등장하는
					아이언맨 수트에서 영감을 받았다.</font></td>

			<td><font color="blue" size="4"> 코나 아이언맨 에디션은 마블 캐릭터를 적용한
					세계 최초의 양산차 모델이다. 마블과 현대차 디자이너의 협업을 통해 완성했다. 디자인은 영화 ‘아이언맨’에 등장하는
					아이언맨 수트에서 영감을 받았다.</font></td>
		</tr>
	</table>

	<br />
	<hr color="red" size="3" />
	<br />


	<h3>
		<b>CSS 적용 Style</b>
	</h3>
	<table style="font-size: 10pt; color: blue">
		<tr>
			<td>코나 아이언맨 에디션은 마블 캐릭터를 적용한 세계 최초의 양산차 모델이다. 마블과 현대차 디자이너의 협업을
				통해 완성했다. 디자인은 영화 ‘아이언맨’에 등장하는 아이언맨 수트에서 영감을 받았다.</td>

			<td>코나 아이언맨 에디션은 마블 캐릭터를 적용한 세계 최초의 양산차 모델이다. 마블과 현대차 디자이너의 협업을
				통해 완성했다. 디자인은 영화 ‘아이언맨’에 등장하는 아이언맨 수트에서 영감을 받았다.</td>
		</tr>
	</table>

	<br />
	<hr color="red" size="3" />
	<br />

	<table style="font-size: 10pt; font-family: 돋움;" cellpadding="3">
		<tr>
			<td><b>아이디</b></td>
			<td><input type="text" style="width: 100pt; height: 13pt;" /></td>
			<td></td>
		</tr>

		<tr>
			<td><b>패스워드</b></td>
			<td><input type="password" style="width: 100pt; height: 13pt;" /></td>
			<td><img src="./image/btn_login.gif"></td>
		</tr>

		<tr>
			<td colspan="3" align="center"><input type="checkbox">아이디
				저장 <input type="checkbox" checked="checked">보안접속</td>
		</tr>

		<tr height="1">
			<td colspan="3" bgcolor="#dad6d7"></td>
		</tr>


	</table>

	<br />
	<hr color="red" size="3" />
	<br /> 코나
	<span class="c1">아이언맨</span> 에디션은
	<span class="c2">마블</span> 캐릭터를 적용한 세계 최초의 양산차 모델이다.
	<span class="c2">마블</span>과 현대차 디자이너의 협업을 통해 완성했다. 디자인은 영화 ‘
	<span class="c1">아이언맨</span>’에 등장하는
	<span class="c1">아이언맨</span> 수트에서 영감을 받았다.











































	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />


</body>
</html>