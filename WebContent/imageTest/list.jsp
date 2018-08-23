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

<link rel="stylesheet" href="<%=cp%>/imageTest/data/style.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/imageTest/data/created.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/imageTest/data/list.css" type="text/css"/>
<style type="text/css">



</style>

</head>
<body>


<div align="center">

<table border="0" style="width: 600px;" align="center">
	<tr>
		<td id="bbs_title" colspan="2" align="center">
			이미지 게시판
		</td>
	</tr>
	<tr>
		<td colspan="2" height="5">
		</td>
	</tr>
	
	<tr>
		<td class=boxTF align="left" width="500">
			Total ${dataCount } articles, ${totalPage } pages / Now page is ${pageNum }
		</td>
		<td align="center" >
			<input type="button" value="게시물 등록" 
			onclick="javascript:location.href='<%=cp%>/image/write.do'">
		</td>
	</tr>
	<tr>
</table>


	
<c:set var = "i" value ="1"></c:set>
	<table border="0" style="width: 600px;" align="center">
		<c:forEach var="dto" items="${lists }"> 
			<c:if test="${i % 3 == 1}">
			<tr>
			</c:if>
			
				<td align="center">
					<a href="${imagePath }/${dto.saveFileName }">
					<img src="${imagePath }/${dto.saveFileName }" width="180" height="180" /></a><br/> 
					${dto.subject } 
					<a href="${deletePath }?num=${dto.num }&pageNum=${pageNum }">삭제</a> 
				</td> 	
					
			<c:if test="${i% 3 == 0}">
			</tr>
			</c:if>				
					
				
			<c:set var = "i" value ="${i+1 }"></c:set>
		</c:forEach>
			<tr>
				
				<td colspan="3" align="center">
					<c:if test="${dataCount != 0 }">
					${pageIndexList }
					</c:if>
					<c:if test="${dataCount == 0 }">
					등록된 게시물이 없습니다.
					</c:if>
				</td>
			</tr>
			
<%-- 나머지까지 공백 넣는 것
 	<c:if test="${i>0||n%3!=0 }">
		<c:forEach var="i" begin="${i%3+1 }" end="3" step="1">
			<td>&nbsp;</td>
		</c:forEach>
	</c:if>
	
	<c:if test="${i!=0 }">
			</tr>
		</c:if> --%>
	</table>
</div>	
	

	

	














</body>
</html>
