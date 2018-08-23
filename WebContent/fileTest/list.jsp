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

td {
	padding: 2pt;
	border-bottom: 0.1px solid #E0FFDB;
	

}

td.line {

	height: 0.1px;
	background-color: #C4DEFF;

}

</style>



</head>
<body>

<table border="0" cellpadding="0" cellspacing="0" align="center">
	<tr>
		<td height="100">
		</td>
	</tr>
	
	<tr>
		<td colspan="4" align="right" width="700" style="padding-right: 5pt">
			<input type="button" value="처음으로"
			 onclick="javascript:location.href='<%=cp%>/file/list.do';">&nbsp;
		
			<input type="button" value="글쓰기"
			 onclick="javascript:location.href='<%=cp%>/file/write.do';">&nbsp;
			 
			 <input type="button" value="돌아가기" 
			onclick="javascript:location.href='<%=cp %>';">
		</td>
	</tr>
	<tr>
		<td class="line" colspan="4"></td>
	</tr>
	<tr style="background-color: #2478FF;">
		<td width="100" align="center" >번호</td>
		<td width="200" align="left" style="padding-left: 10pt">제목</td>
		<td width="300" align="left" style="padding-left: 10pt">파일명</td>
		<td width="100" align="center">기타</td>
	</tr>
	
	<tr>
		<td class="line" colspan="4"></td>
	</tr>

<c:forEach var = "dto" items="${lists }">
	<tr>
		<td align="center">${dto.num }</td>
		<td>${dto.subject }</td>
		<td>
<%-- <a href="${downloadPath }?num=${dto.num}&pageNum=${pageNum}">
		${dto.saveFileName }</a> --%>
		<a href="${imagePath}/${dto.saveFileName }">
		<img src ="${imagePath}/${dto.saveFileName }" width="180" height="180">
		</a>
		</td>
		<td align="center" style="padding-right: 10pt">
		<input type="button" value="삭제" 
		onclick="javascript:location.href='${deletePath }?num=${dto.num }&pageNum=${pageNum }';">
		</td>
	</tr>
</c:forEach>
	
	<tr>
		<td class="line" colspan="4"></td>
	</tr>

	<tr>
		<td colspan="4" align="center">
			<c:if test="${dataCount != 0 }">
				${pageIndexList }
			</c:if>
			<c:if test="${dataCount == 0 }">
				등록된 게시물이 없습니다.
			</c:if>
		</td>
	</tr>
	
	<tr>
		<td class="line" colspan="4"></td>
	</tr>
		
</table>


</body>
</html>
