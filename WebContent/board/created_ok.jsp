<%@page import="java.net.URLEncoder"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.board.BoardDAO"%>
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
%>

<jsp:useBean id="dto" class="com.board.BoardDTO" scope="page"/>
<jsp:setProperty property="*" name="dto"/>

<%
	String pageNum = request.getParameter("pageNum");

	Connection conn = DBconn.getConnection();

	BoardDAO dao = new BoardDAO(conn);
	
	int maxNum = dao.getMaxNum();
	
	//2개의 빈 데이터에를 만들어주는 식
	dto.setNum(maxNum + 1); 
	dto.setIpAddr(request.getRemoteAddr());
	
	dao.inserData(dto);

	//검색-----------------------------------------------------
	String searchKey = request.getParameter("searchKey");
	String searchValue = request.getParameter("searchValue"); //인코딩된걸 받아와서 밑에서 디코딩
		
	if(searchKey != null){ 
		//요청정보 전송방식 request.getMethod()
		if(request.getMethod().equalsIgnoreCase("GET")){
			searchValue = URLDecoder.decode(searchValue, "UTF-8");
		}
		
	}else{
		searchKey = "subject";
		searchValue = "";
	}

	//검색-----------------------------------------------------

	//검색----------------------------------------------
	String param = "";
	if(searchValue!=null || !searchValue.equals("")){
		
		param = "&searchKey=" + searchKey;
		param += "&searchValue=" +
			URLEncoder.encode(searchValue, "UTF-8");

	}
	
	DBconn.close();
	
	//cp and pageNum are Variable, they do not need " "

	response.sendRedirect(cp+"/board/list.jsp?pageNum="+pageNum+param);


%>

<!-- if절이 실패하면 list로 안가지고 내려오기때문에 밑에다가 입력오류입력  -->

입력오류
