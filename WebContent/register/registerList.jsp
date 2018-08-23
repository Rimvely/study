<%@page import="com.register.NaverDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.register.NaverDAO"%>
<%@page import="util.DBconn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	//한글을 3바이트로 받아줘서 안깨지게해주는것
	request.setCharacterEncoding("UTF-8");
	
//	D:\Java\work\.metadata\.plugins
//  \org.eclipse.wst.server.core\tmp0\work
//  \Catalina\localhost\study\org\apache\jsp\score

//  cp = ~/study 까지 경로
	String cp = request.getContextPath();

	Connection conn = DBconn.getConnection();
	
	NaverDAO dao = new NaverDAO(conn);
	
	List<NaverDTO> lists = dao.getList();
	
	DBconn.close();

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

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

.btn{
	font-size: 9pt;
	background: #e6e6e6
}

</style>

</head>
<body>

<br/><br/>

<table width="900" cellpadding="0" cellspacing="3" align="center" bgcolor="e4e4e4">
	<tr height="50">
		<td bgcolor="#ffffff" style="padding-left: 10px;">
		<b>회원정보 리스트</b>
		</td>
	</tr>
</table>
<br/>

<table width="800" cellpadding="0" cellspacing="3" align="center">
	<tr height="35">
		<td align="right">
		<input type="button" class="btn" value="등록하기" 
		onclick="javascript:location.href='<%=cp %>/register/register.jsp';"/>
		</td>
	</tr>
</table>

<table width="900" cellpadding="0" cellspacing="1" align="center" bgcolor="#cccccc">
	<tr height="30">
		<td align="center" bgcolor="#e6e6e6" width="80">이름</td>
		<td align="center" bgcolor="#e6e6e6" width="80">아이디</td>
		<td align="center" bgcolor="#e6e6e6" width="100">별명</td>
		<td align="center" bgcolor="#e6e6e6" width="100">비밀번호</td>
		<td align="center" bgcolor="#e6e6e6" width="200">질문</td>
		<td align="center" bgcolor="#e6e6e6" width="60">답</td>
		<td align="center" bgcolor="#e6e6e6" width="150">이메일</td>
		<td align="center" bgcolor="#e6e6e6" width="100">전화번호</td>
		<td align="center" bgcolor="#e6e6e6" width="130">수정 및 삭제</td>
	</tr>

	<%for(NaverDTO dto : lists){%>
	<tr height="30">
		<td align="center" bgcolor="#ffffff"><%=dto.getUserName() %></td>
		<td align="center" bgcolor="#ffffff"><%=dto.getUserId() %></td>
		<td align="center" bgcolor="#ffffff"><%=dto.getUserNick() %></td>
		<td align="center" bgcolor="#ffffff"><%=dto.getUserPw1() %></td>
<%-- 		<%if(dto.getAnswer1().equals("직접입력")){ %>
		<%=dto.getAnswer2() %>
		<%}else {%>
		<%=dto.getAnswer1() %>
		<%} %> --%>
		<td align="center" bgcolor="#ffffff"><%=dto.getAnswer1() %></td>
		<td align="center" bgcolor="#ffffff"><%=dto.getAnswer2() %></td>
		<td align="center" bgcolor="#ffffff"><%=dto.getEmail1() %>@<%=dto.getEmail2() %></td>
		<td align="center" bgcolor="#ffffff"><%=dto.getTel1() %>-<%=dto.getTel2() %>-<%=dto.getTel3() %></td>
		<td align="center" bgcolor="#ffffff">
		<a href="<%=cp%>/register/register_update.jsp?userId=<%=dto.getUserId() %>">수정</a> 
		<a href="<%=cp%>/register/register_delete_ok.jsp?userId=<%=dto.getUserId() %>">삭제</a>
		</td>
	</tr>
	<%} %>
	
	
	
	
</table>


</body>
</html>
