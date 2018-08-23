<%@page import="java.util.Calendar"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
request.setCharacterEncoding("UTF-8");
%>

<%
/* JSP에선 html에 뿌릴 데이터를 만들어 놓는것  */
	Calendar cal = Calendar.getInstance();

	//오늘날짜
	int nowYear = cal.get(Calendar.YEAR);
	int nowMonth = cal.get(Calendar.MONTH)+1;//0-11이니까 +1)
	int nowDay = cal.get(Calendar.DAY_OF_MONTH);
	
	//클라이언트에서 넘어온 데이터(왼손으로 내가 받는거?)
	String strYear = request.getParameter("year");
	String strMonth = request.getParameter("month");
	
	//표시할 달력의 년,월
	/* 처음 실행할때는 값이 null(String)이니까 오늘날짜를 보여줘야함 
	그래서 nowMonth, nowYear*/
	int year = nowYear;
	int month = nowMonth;
	
	/* 1번이상 실행했을시에 오늘날짜가 들어간 년도를 덮어씌운다 */
	if(strYear!=null){
		year = Integer.parseInt(strYear);//client가 선택한 년도
		month = Integer.parseInt(strMonth);
	}
	
	int preYear = year;
	int preMonth = month-1;
	if(preMonth<1){
		preYear=year-1;
		preMonth=12;
	}
	
	int nextYear=year;
	int nextMonth=month+1;
	if(nextMonth>12){
		nextYear=year+1;
		nextMonth=1;
	}
	
	//표시할 달력 세팅 //(5를 보려면 4를 봐야하니까)
	cal.set(year,month-1, 1);
	int startDay = 1;
	int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	
	int week = cal.get(Calendar.DAY_OF_WEEK);
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">

function init() {

	var f = document.myForm;

	var now = new Date();
	var fyear = f.year;
	var nowYear = <%=year%>
	var startYear = nowYear - 5;
	
	for (i=0; i<11; i++) {
		fyear[i] = new Option(startYear, startYear);
		
		if (fyear[i].value == nowYear)
			fyear[i].selected = true; 
		startYear++;
	}

	var fmonth = f.month;
	for (i=0; i<12; i++)
		fmonth[i] = new Option(i+1, i+1);

	var nowMonth = <%=month%>;
	fmonth[nowMonth-1].selected = true;
	
}

function calendarChange() {
	var f = document.myForm;
	f.submit();
}

</script>



<style>
	body{
 		font-size: 12pt;
 		}
	
	td{
		font-size: 12pt;
	}


</style>
</head>
<body>

<table align="center" width="210" cellpadding="2" cellspacing="1">

<tr>
	<td align="center">
		<!-- <a href="calendar.jsp  -->
		<a href="calendar.jsp?year=<%=nowYear%>&month=<%=nowMonth%>">
		<img src="./image/today1.PNG">
		</a>
		<a href="calendar.jsp?year=<%=preYear%>&month=<%=preMonth%>">◀</a>
		<b>&nbsp;<%=year%>년&nbsp;<%=month%>월</b>
		<a href="calendar.jsp?year=<%=nextYear%>&month=<%=nextMonth%>">▶</a>
	</td>
</tr>
</table>

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

<!--  JSP 영역이니공백 넣으려고 i<week; -->

<%
	int newLine = 0;
	
	out.print("<tr height='20'>");
	
	for(int i=1; i<week; i++){
		out.print("<td bgcolor='#ffffff'>&nbsp</td>");
		newLine++;
	}
	
	for(int i=startDay; i<=endDay; i++){
		
		String fontColor = (newLine==0)?"red":(newLine==6)?"blue":"black";
		
		String bgColor = (nowYear==year)&&(nowMonth==month)&&(nowDay==i)?"#e6e4e6":"#ffffff";
		
		out.print("<td align='center' bgcolor='" + bgColor + "'><font color='" + fontColor +"'>" + i + "</font></td>");
		
		//<td align='center' bgcolor='#ffffff'>
		//<font color='red'>26</font></td>
		
		newLine++;
		
		if(newLine==7&&i!=endDay){
			out.print("<tr><tr height='20'>");
			newLine=0;
		}
		
	}
		while(newLine>0&&newLine<7){
			out.print("<td bgcolor='#ffffff'>&nbsp;</td>");
			newLine++;
		}
		out.print("</tr>");
	
%>
</table>







</body>
</html>
