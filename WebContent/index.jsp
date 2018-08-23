<%@page import="com.join.CustomInfo"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<%
	/* Session의 정보를 가져와야한다 */
	/* EL을 사용안할때 */
	//CustomInfo info = (CustomInfo)session.getAttribute("customInfo");



%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style>
body, html { 
    margin: 0;
    padding: 0;
    height: 100%;
}

.bounding-box {
  background-repeat: no-repeat;
  background-size: contain;
  border: 0;
  padding: 0;
  size: cover;
  heigt: auto;
  width: 410px;
  position: center;
  margin: 0;

}

.bgimg {
    border: 0;
    padding: 0; 
    min-height: 100%;
    background-position: center;
    background-size: cover;
}

/* 1.hover-moving-box는 가장 바깥의 파란색 배경 상자입니다. */
.hover-moving-box {
  width:100%;
  height:200px;
  position:relative;
  color: #ffffff;
  border: 1px solid rgb(0,0,0,0);"
}

/* 2. box는 캐릭터 이미지를 담고 있는 상자입니다. */
/* 3. 이 상자에는 transition이라는 속성이 설정되어 있습니다. */
.hover-moving-box .box {
  width: 100px;
  height: 100px;
  color:#fff;
  text-align:center;
  position: absolute;
  top:20px;
  left:2%;
  transition: all 1s ease;

}

/* 4.:hover, 즉 마우스오버를 하면 80%만큼 이동을 합니다. */
.hover-moving-box:hover .box {
  left:80%;
  transform: rotateY(180deg);
}


</style>





</head>
<body background="sung/image/nightview.jpg" class="bgimg">

<table border="1" height="300" align="center" style="vertical-align: middle; border: 1px solid rgb(0,0,0,0);" width="700" cellpadding="3" cellspacing="0">
	
	<tr>
		<td colspan="2" height="100">
	</tr>
	
	<tr>
		<c:choose>
			<c:when test="${empty sessionScope.customInfo.userId }">
	<td align="center" style="vertical-align: bottom;">
				<font color="#FFFFFF"><b>로그인하면 새로운 세상이 보입니다</b></font><br/><br/>
	</td>
	<td rowspan="3" width="350" valign="middle" align="center" style="padding: 0">
	<img src="sung/image/puppy.jpg" class="bounding-box">
	</td>
	
			</c:when>
		<c:otherwise>
				
			<td align="right" bgcolor="#FFFFB4">
			<font color="#4374D9">${sessionScope.customInfo.userName }</font> 님 로그인
			</td>
			<td rowspan="3" width="350" valign="middle" align="center" style="padding: 0">
			<img src="sung/image/puppy.jpg" class="bounding-box">
			</td>
					
		</c:otherwise>
		</c:choose>
	</tr>
		
	<tr>
		<c:choose>
			<c:when test="${empty sessionScope.customInfo.userId }">
	<td bgcolor="#FFE8FF">
				1.성적처리(JSP)<br/>
				2.성적처리(Servlet)<br/>
				3.게시판(JSP)<br/>
				4.게시판(JDBC)<br/>
				5.<a href="<%=cp %>/sboard/list.do">게시판(Servlet)</a><br/>
				6.게시판(Upload_download_delete)
				7.게시판(Image Board)
	</td>
			</c:when>
			<c:otherwise>
	<td bgcolor="#FFE8FF">
				1.<a href="<%=cp %>/score/list.jsp">성적처리(JSP)</a><br/>
				2.<a href="<%=cp %>/sscore/list.do">성적처리(Servlet)</a><br/>
				3.<a href="<%=cp %>/board/list.jsp">게시판(JSP)</a><br/>
				4.<a href="<%=cp %>/guest/guest.jsp">게시판(JDBC)</a><br/>
				5.<a href="<%=cp %>/sboard/list.do">게시판(Servlet)</a><br/>
				6.<a href="<%=cp %>/file/list.do">게시판(Upload_download_delete)</a><br/>
				7.<a href="<%=cp %>/image/list.do">게시판(Image Board)</a>
	</td>
			</c:otherwise>
		</c:choose>
				
	
	</tr>
				
	<tr>		
		<c:choose>
			<c:when test="${empty sessionScope.customInfo.userId }">
	<td bgcolor="#FFB4B4">
				<a href="<%=cp %>/join/created.do">회원가입</a><br/>
				<a href="<%=cp %>/join/login.do">로그인</a><br/>
	</td>
			</c:when>
			<c:otherwise>
	<td bgcolor="#FFB4B4" align="center">
				<a href="<%=cp %>/join/update.do">정보수정</a> &nbsp;
				<a href="<%=cp %>/join/delete.do">회원탈퇴</a> &nbsp;
				<a href="<%=cp %>/join/logout.do">로그아웃</a><br/>
				
	</td>
			</c:otherwise>
		</c:choose>		
	</tr>
	<tr style="border: 1px solid rgb(0,0,0,0);">
		<td colspan="2" height="200" style="border: 1px solid rgb(0,0,0,0);">
	<div class="hover-moving-box">
 		<!--  2. box는 캐릭터 이미지를 담고 있는 상자입니다.  -->
 		 <div class="box">
  		<!--  3. 이미지를 불러옵니다.   -->
   		 <img src="http://report.stibee.com/images/report2016/main-email@2x.png" width="164">
  		</div>
	</div>
		
		
		
		</td>
	</tr>
	
</table>


		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		

</body>
</html>