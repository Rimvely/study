<%@page import="util.DBCPConn"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="util.MyUtil"%>
<%@page import="com.board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.board.BoardDAO"%>
<%@page import="util.DBconn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<%
	Connection conn = DBCPConn.getConnection();
	BoardDAO dao = new BoardDAO(conn);

	MyUtil myUtil = new MyUtil();
	
	//client한테 넘어온 페이지 번호 (두번째 실행부터 42,54,63번 코딩으로 pageNum이 넘어옴)
	String pageNum = request.getParameter("pageNum");
	int currentPage = 1; //현재 표시되는 페이지 기본값
	
	//처음 실행시 null
	if(pageNum != null) 
		currentPage = Integer.parseInt(pageNum); //넘어온 pageNum(9)을 currentPage(9)에 넣음
	
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
	
	
	/* //전체 데이터 갯수 구하기
	int dataCount = dao.getDataCount();  */
	
	//전체 데이터 갯수 구하기
	int dataCount = dao.getDataCount(searchKey, searchValue); //전체 데이터 개수를 dataCount(34) 읽어옴
	
	//전체 데이터를 기준으로 총페이지수를 계산한다
	int numPerPage = 3; //한 페이지에 표시할 데이터 갯수
	int totalPage = myUtil.getPageCount(numPerPage, dataCount); //(3,34)값을 MyUtil 1번 메소드로 전송
	
	
	//삭제로 인해 전체 페이지수보다 표시할 페이지가 큰 경우 
	//표시할 페이지를 전체 페이지로
	
	if(currentPage > totalPage)  //데이터를 삭제해서 페이지가 줄었을 경우
		currentPage = totalPage; //12 = 12
		
	//데이터베이스에서 가져올 시작과 끝 위치
	int start = (currentPage-1) * numPerPage + 1;  //(9-1)*3+1 = 25
	int end = currentPage*numPerPage;           //(9*3) = 27
	
	/* //데이터베이스에서 해당페이지를 가져온다
	List<BoardDTO> lists = dao.getLists(start, end); //(25, 27)값을 BoardDAO로 넘겨줌 */
	
	List<BoardDTO> lists = dao.getLists(start, end, searchKey, searchValue);
	
	//검색----------------------------------------------
	String param = "";
	
	if(!searchValue.equals("")){
		
		param = "?searchKey=" + searchKey;
		/* param += "&searchValue=" + searchValue; */
		param += "&searchValue=" + URLEncoder.encode(searchValue, "UTF-8"); //밸류를 인코딩시켜서보낸다?
		
		/* currentPage = "?pageNum=" + currentPage; */
	}
	//검색----------------------------------------------
	
	/* //페이징 처리(MyUtil.java)
	String listUrl = "list.jsp" */
	
	String listUrl = "list.jsp" + param;
	String pageIndexList = myUtil.pageIndexList(currentPage, totalPage, listUrl);
			  									//(9,12,list.jsp)를 MyUtil로 넘김
			  									
	
	
	
	//article 주소정리
	String articleUrl = cp + "/board/article.jsp";
	
	//param이 "" 이면 검색을 하지않은거다												
	if(param.equals("")){
		articleUrl = articleUrl + "?pageNum=" + currentPage;   
	}else{
		articleUrl = articleUrl + param + "&pageNum=" + currentPage;
	}
												
												
	
	//DBconn.close();
	DBCPConn.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>게 시 판</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>

<link rel="stylesheet" href="<%=cp%>/board/css/style.css" type="text/css"/>
<link rel="stylesheet" href="<%=cp%>/board/css/list.css" type="text/css"/>

<script type="text/javascript">
	
	function sendIt() {
		
		var f = document.searchForm;
		
		f.action = "<%=cp%>/board/list.jsp?";
		f.submit();
	}



</script>


</head>

<body>
<div id="bbsList">
	<div id="bbsList_title">
	게 시 판(JSP)
	</div>

	<div id="bbsList_header">
		<div id="leftHeader">
		  <form name="searchForm" method="post" action="">
			<select name="searchKey" class="selectFiled">
				<option value="subject">제목</option>
				<option value="name">작성자</option>
				<option value="content">내용</option>
			</select>
			<input type="text" name="searchValue" class="textFiled"/>
			<input type="button" value=" 검 색 " class="btn2" 
			onclick="sendIt();"/>
		  </form>
		</div>
		<div id="rightHeader">
			<input type="button" value=" 글올리기 " class="btn2" 
			onclick="javascript:location.href='<%=cp%>/board/created.jsp?pageNum=<%=currentPage%>&<%=param%>';"/>
			<input type="button" class="btn2" value="돌아가기" 
			onclick="javascript:location.href='<%=cp %>/index.jsp';"/>
		</div>
	</div>
	<div id="bbsList_list">
		<div id="title">
			<dl>
				<dt class="num">번호</dt>
				<dt class="subject">제목</dt>
				<dt class="name">작성자</dt>
				<dt class="created">작성일</dt>
				<dt class="hitCount">조회수</dt>
			</dl>
		</div>
		<div id="lists">
		<!-- 자기가 집어넣은 데이터만큼 나온다 -->
		<%for(BoardDTO dto : lists){ %> 
			<dl>
				<dd class="num"><%=dto.getNum() %></dd>
				<dd class="subject">
				<a href="<%=articleUrl %>&num=<%=dto.getNum() %>">
				<%=dto.getSubject() %>
				</a>
				</dd>
				<dd class="name"><%=dto.getName() %></dd>
				<dd class="created"><%=dto.getCreated() %></dd>
				<dd class="hitCount"><%=dto.getHitCount() %></dd>
			</dl>
		<%} %>
		</div>
		<div id="footer">
			<p>
				<%if(dataCount != 0){ %>
					<%=pageIndexList %>
				<%}else{ %>
					등록된 게시물이 없습니다.
				<%} %>
			</p>
		</div>
	</div>
</div>
</body>

</html>