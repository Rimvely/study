<%@page import="com.score.ScoreDTO"%>
<%@page import="com.score.ScoreDAO"%>
<%@page import="util.DBconn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<%
	String hak = request.getParameter("hak");

	Connection conn = DBconn.getConnection();

	ScoreDAO dao = new ScoreDAO(conn);
	
	ScoreDTO dto = dao.getReadData(hak);
	
	DBconn.close();
	
	if(dto==null){
		response.sendRedirect("list.jsp");
	}




%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>성적처리 수정화면</title>

<script type="text/javascript">

	function sendIt() {
		
		var f = document.myForm;
		
		if(!f.kor.value){
			alert("국어성적을 입력해주세요!");
			f.kor.focus();
			return;
		}
		
		//http://192.168.16.27:8080/study/score/write.jsp
		f.action = "<%=cp %>/score/update_ok.jsp";
		f.submit();
	}
	
</script>

<style type="text/css">

*{
	padding: 0px;
	margin: 0px;
}

body {
	font-size: 9pt;
}

td {
	font-size: 9pt;
}

.txtField{
	font-size: 9pt;
	border: 1px solid;
}

.btn{
	font-size: 9pt;
	background: #e6e6e6
}

</style>

</head>
<body>

<br/><br/>

<table width="500" cellpadding="0" cellspacing="3" align="center" bgcolor="#e4e4e4">
	<tr height="50">
		<td bgcolor="#ffffff" style="padding-left: 10px;">
		<b>성적처리 수정화면</b>
		</td>
	</tr>
</table>

<br/>

<form action="" name="myForm" method="post">

<table width="500" cellpadding="0" cellspacing="3" align="center">
	<tr height="2">
		<td colspan="2" bgcolor="#cccccc">
		</td>
	</tr>
	
	<tr>
		<td align="center" width="100" bgcolor="#e6e6e6">
		학번
		</td>
		<td style="padding-left: 5px;">
		<!-- DB에서 HAK은 VARCHAR2(10) -->
		<!-- 
		<input type="text" name="hak" value="< %=dto.getHak() %>" 
		size="10"	maxlength="7" class="txtField" readonly="readonly"/>
		 -->
		<%=dto.getHak() %>
		</td>
	</tr>
	
	<tr>
		<td align="center" width="100" bgcolor="#e6e6e6">
		이름
		</td>
		<td style="padding-left: 5px;">
		<%=dto.getName() %>
		</td>
	</tr>
		
	<tr>
		<td align="center" width="100" bgcolor="#e6e6e6">
		국어
		</td>
		<td style="padding-left: 5px;">
		<input type="text" name="kor" value="<%=dto.getKor() %>" size="20"	maxlength="3" class="txtField"/>
		</td>
	</tr>
	
	<tr>
		<td align="center" width="100" bgcolor="#e6e6e6">
		영어
		</td>
		<td style="padding-left: 5px;">
		<input type="text" name="eng" value="<%=dto.getEng() %>" size="20"	maxlength="3" class="txtField"/>
		</td>
	</tr>
	
	<tr>
		<td align="center" width="100" bgcolor="#e6e6e6">
		수학
		</td>
		<td style="padding-left: 5px;">
		<input type="text" name="mat" value="<%=dto.getMat() %>" size="20"	maxlength="3" class="txtField"/>
		</td>
	</tr>
	
	<tr height="2">
		<td colspan="2" bgcolor="#cccccc">
		</td>
	</tr>
	
	<tr height="35">
		<td align="center" colspan="2">
		
		<input type="hidden" name="hak" value="<%=dto.getHak() %>"/>
		
		<input type="button" class="btn" value="수정완료" onclick="sendIt();"/>
			
		<!-- 나갈때 list.jsp만 쓰면 안나가진다  javascript:location.href='< % =cp%>/score/list.jsp'; -->
		<input type="button" class="btn" value="수정취소" onclick="javascript:location.href='<%=cp%>/score/list.jsp';"/>
		
		
		</td>
	</tr>
		
	
</table> 

</form>



</body>
</html>
