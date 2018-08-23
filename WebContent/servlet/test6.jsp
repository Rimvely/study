<%@page import="com.svt.MyData"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<% 
	
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();
%>

<%
	List<MyData> lists = new ArrayList<MyData>();

	MyData ob;

	ob = new MyData("길동무", 25);
	lists.add(ob);
	ob = new MyData("무기력", 26);
	lists.add(ob);
	ob = new MyData("역발상", 28);
	lists.add(ob);
	ob = new MyData("상승세", 22);
	lists.add(ob);
	ob = new MyData("세무서", 35);
	lists.add(ob);
	
	request.setAttribute("lists", lists);

%>
<jsp:forward page="result.jsp"/>









