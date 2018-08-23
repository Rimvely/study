<%@page import="com.score.ScoreDAO"%>
<%@page import="util.DBconn"%>
<%@page import="java.sql.Connection"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
request.setCharacterEncoding("UTF-8");
%>
<!-- Insert랑 update는 같다 -->
<!-- 데이터를 받는 코딩  -->

<jsp:useBean id="dto" class="com.score.ScoreDTO" scope="page"/>
<jsp:setProperty property="*" name="dto"/>

<!-- 데이터를 받은걸 dto에 보내서 넣어준다  -->
<%
	Connection conn = DBconn.getConnection();

	ScoreDAO dao = new ScoreDAO(conn);
	
	/* public int insertData(ScoreDTO dto) int값이니까
	
	1 = work - list 를 보여준다 제일 마지막에 들어온게 제일 위이다
	0 = does not work - 
	*/
	int result = dao.updateData(dto);
	
	DBconn.close();
	
	/* 잘 실행되면 redirect하라고 명령 */
	if(result!=0){
		response.sendRedirect("list.jsp");
	}

%>

<!-- if절이 실패하면 list로 안가지고 내려오기때문에 밑에다가 입력오류입력  -->

입력오류

