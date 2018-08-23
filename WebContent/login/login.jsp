<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%//POST 방식에서 한글깨짐을 방지
	request.setCharacterEncoding("UTF-8");
	
	String userId = (String)session.getAttribute("userBox");
	
	session.setMaxInactiveInterval(20*60);//20분
	
	
	
	//------------------------------------------
	//달력 관련 jsp
	
	Calendar cal = Calendar.getInstance();
	
	
	
	//오늘날짜
	int nowYear = cal.get(Calendar.YEAR);
	int nowMonth = cal.get(Calendar.MONTH)+1;
	int nowDay = cal.get(Calendar.DAY_OF_MONTH);
	
	
	//클라이언트에서 넘어온 데이터
	//action에서 자신의 파일이름을 사용하여 데이터를 자신이 받고수정하여 다시 보내는 형식
    //String(클래스)이기때문에 초기값 null;
	String strYear = request.getParameter("Year");
	String strMonth = request.getParameter("Month");
	
	//표시할 달력의 년, 월
	int year = nowYear;//초기화
	int month = nowMonth;
	
	if(strYear != null){	
		year = Integer.parseInt(strYear);//클라이언트가 선택한 년도
	}
	
	if(strMonth != null){
		month = Integer.parseInt(strMonth);//클라이언트가 선택한 월
	}
	
	//표시할 달력 셋팅
	
	cal.set(year, month-1,1);
	int startDay = 1;
	int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	int week = cal.get(Calendar.DAY_OF_WEEK);
	//-------------------------------------------------
	
	
	
%>

	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

	function sendIt() {
		var f = document.myForm;
		
		if(!f.userId.value){
			alert("아이디를 입력하세요");
			f.userId.focus();
			return;
		}
		
		if(!f.userPwd.value){
			alert("패스워드를 입력하세요");
			f.userPwd.focus();
			return;
		}
		
		f.submit();
		
	}
	
	
	function selYear() {
		var f = document.selection;
		f.submit();
	}
	
	function selMonth() {
		var f = document.selection;
		f.submit();
	}
	
	
	

</script>
</head>
<body style="font-size: 9pt">

<table border="1" width="600" align="center" style="font-size: 9pt">
	<tr>
		<td colspan="1" align="right">
			
		</td>
		<td>
			|게시판|
			<%
				if(userId==null){
					out.write("일정관리");
				}else{
			
					out.write("<a href='schedule.jsp'>일정관리</a>");
			 
				}
			%>
		</td>
	</tr>
	
	<tr height="400">
		<td width="100" valign="top">
			<%if(userId==null){%>
				<form action="login_ok.jsp" method="post" name="myForm" >
					아이디: <input type="text" name="userId" size="10"><br/>
					패스워드: <input type="password" name="userPwd" size="10"><br/>
					<input type="button" value="로그인" onclick="sendIt();"/>
				</form>
			<%}else{%>
				<%=userId %>님 로그인<br/>
				<a href="logout.jsp">로그아웃</a>
			<%
			}
			%>
			
		</td>
		<td valign="middle" align="center">
		
			<%if(userId==null){%>
				<b>로그인하면 새로운 세상이 보입니다!</b>
			<%}else{%>
			
			<!-- 달력  -->
			
			<form action="login.jsp" name="selection">
				<table width="210" cellpadding="2" cellspacing="1" align="center">
					<tr>
						<td align="center" style="padding-left: 0">
							<select onchange="selYear();" name="Year" >

							<%	
								int j = -5;
								while(j<=5){
							%>		
							<%	
								int n = 1;
							
								if(j==0){
							%>
								<option value="<%=year+j%>" selected="selected"><%=year+j%></option>
							<% 
								}else{
							%>
								<option value="<%=year+j%>"><%=year+j%></option>
							<% 
								}
							
								j +=n;
							%>
							
							<% 		
								}
							%>
					
							</select>
				
							<b>&nbsp;<%=year %>년</b>
							
							<select onchange="selMonth();" name="Month">
					
							<%
								for(int i = 1;i<=12;i++){
							%>		
								<%
									if(i==month){
								%>
									<option value="<%=i%>" selected="selected"><%=i%></option>
								<% 
									}else{
								%>
									<option value="<%=i%>"><%=i%></option>
								<% 
									}
								%>
							
							<% 		
								}
							%>
				
						</select>
							&nbsp;<b><%=month %>월</b>
						</td>
					</tr>
				</table>
			</form>
	
			<table align="center" width="210" cellpadding="0" cellspacing="1" bgcolor="#cccccc">
				<tr>
					<td bgcolor="#e6e4e6" align="center"><font color="red">일</font></td>
					<td bgcolor="#e6e4e6" align="center">월</td>
					<td bgcolor="#e6e4e6" align="center">화</td>
					<td bgcolor="#e6e4e6" align="center">수</td>
					<td bgcolor="#e6e4e6" align="center">목</td>
					<td bgcolor="#e6e4e6" align="center">금</td>
					<td bgcolor="#e6e4e6" align="center"><font color="blue">토</font></td>
				</tr>
	

			<%
				int newLine = 0;
				out.print("<tr height = '20'>");
				for(int i=1; i<week;i++){//week: 1~7
					out.print("<td bgcolor = '#ffffff'>&nbsp;</td>");
					newLine++;
				}
	
				for(int i = startDay;i<=endDay; i++){
					String fontColor = (newLine==0) ? "red" : (newLine==6) ? "blue":"black";
					String bgColor = (nowYear==year)&&(nowMonth==month)&&(nowDay==i)? "#e6e4e6" : "#ffffff";
		
					out.print("<td align = 'center' bgcolor='" +bgColor+"'><font color='"+fontColor +"'>"+i+"</font></td>");
		
					newLine++;
		
					if(newLine==7&&i!=endDay){
						out.print("</tr><tr height = '20'>");
						newLine=0;
					}
		
				}
	
				while(newLine>0 && newLine<7){
					out.print("<td bgcolor='#ffffff'>&nbsp;</td>");
					newLine++;
				}
				out.print("</tr>");
	
	
				%>
			</table>

			<%
			}
			%>
			<!-- 달력 끝 -->
		</td>
	</tr>
	
</table>
	
</body>
</html>