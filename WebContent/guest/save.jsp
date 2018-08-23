<%@page import="com.guest.GuestDAO"%>
<%@page import="util.DBconn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<jsp:useBean id="dto" class="com.guest.GuestDTO" scope="page"/>
<jsp:setProperty property="*" name="dto"/>

<%
	String pageNum = request.getParameter("pageNum");

	Connection conn = DBconn.getConnection();

	GuestDAO dao = new GuestDAO(conn);
	
	//게시물 등록할때 마다 +1
	int maxNum = dao.getMaxNum();
	dto.setNum(maxNum + 1); 
	
	dto.setIpAddr(request.getRemoteAddr());

	dao.inserData(dto);
	
	DBconn.close();
	
	response.sendRedirect(cp+"/guest/guest.jsp?pageNum="+pageNum);



%>

<!-- if절이 실패하면 list로 안가지고 내려오기때문에 밑에다가 입력오류입력  -->

입력오류
