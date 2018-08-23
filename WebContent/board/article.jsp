<%@page import="java.net.URLDecoder"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="com.board.BoardDTO"%>
<%@page import="com.board.BoardDAO"%>
<%@page import="util.DBconn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");

	Connection conn = DBconn.getConnection();
	BoardDAO dao = new BoardDAO(conn);
	
	//조회수 증가
	dao.updateHitCount(num);
	
	//글 가져오기 (list에서 받는입장 num생성불가능, 그래서 num을 list에서 받아와)
	
	BoardDTO dto = dao.getReadData(num); //dto에는 한명의 데이터가 들어가있다
	
	if(dto==null){
		response.sendRedirect("list.jsp");
	}

	//검색-----------------------------------------------------
	String searchKey = request.getParameter("searchKey");
	String searchValue = request.getParameter("searchValue"); //인코딩된걸 받아와서 밑에서 디코딩
		
	if(searchKey != null){ 
		//요청정보 전송방식 request.getMethod()
		if(request.getMethod().equalsIgnoreCase("GET")){
			searchValue =URLDecoder.decode(searchValue, "UTF-8");
		}
		
	}else{
		searchKey = "subject";
		searchValue = "";
	}
	
	//검색-----------------------------------------------------

	
	//글 라인수 글을 가져와서 엔터의 갯수를 세면 글 라인수가 생성
	int lineSu = dto.getContent().split("\n").length;
	
	//엔터를 <br/>로 변경 (ex) i = i + <br/>
	dto.setContent(dto.getContent().replaceAll("\n", "<br/>"));
	
	//검색----------------------------------------------
	String param = "";
	if(searchValue!=null || !searchValue.equals("")){
		
		param = "&searchKey=" + searchKey;
		param += "&searchValue=" +
			URLEncoder.encode(searchValue, "UTF-8");
	
	}
	
	DBconn.close();

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>게 시 판</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<link rel="stylesheet" href="<%=cp%>/board/css/style.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/board/css/article.css" type="text/css"/>

</head>

<body>

<div id="bbs">
	<div id="bbs_title">
	게 시 판
	</div>
	<div id="bbsArticle">
		<div id="bbsArticle_header">
			<%=dto.getSubject() %>
		</div>
		<div class="bbsArticle_bottomLine">
			<dl>
				<dt>작성자</dt>
				<dd><%=dto.getName() %></dd>
				<dt>줄수</dt>
				<dd><%=lineSu %></dd><!-- 변수니까 lineSu, not dto.lineSu  -->
			</dl>
		</div>
		<div class="bbsArticle_bottomLine">
			<dl>
				<dt>등록일</dt>
				<dd><%=dto.getCreated() %></dd>
				<dt>조회수</dt>
				<dd><%=dto.getHitCount() %></dd>
			</dl>
		</div>
		<div id="bbsArticle_content">
			<table width="600" border="0">
			<tr><td style="padding: 20px 80px 20px 62px;" valign="top" height="200">
			<%=dto.getContent() %>
			</td></tr>
			</table>
		</div>
		
	</div>
	<div class="bbsArticle_noLine" style="text-align:right">
		    From : <%=dto.getIpAddr() %>
	</div>
	<div id="bbsArticle_footer">
		<div id="leftFooter">
               <input type="button" value=" 수정 " class="btn2" 
               onclick="javascript:location.href='<%=cp%>/board/update.jsp?num=<%=num%>&pageNum=<%=pageNum%><%=param%>';"/>
               <input type="button" value=" 삭제 " class="btn2" 
               onclick="javascript:location.href='<%=cp%>/board/delete_ok.jsp?num=<%=num%>&pageNum=<%=pageNum%><%=param%>';"/>
		</div>
		<div id="rightFooter">
               <input type="button" value=" 리스트 " class="btn2" 
               onclick="javascript:location.href='<%=cp%>/board/list.jsp?pageNum=<%=pageNum%><%=param%>';"/>
		</div>
	</div>

</div>

<br/>&nbsp;<br/>
</body>

</html>