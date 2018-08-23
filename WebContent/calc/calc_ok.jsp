<%@page import="com.calc.Calc"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<%
	int su1 = Integer.parseInt(request.getParameter("su1"));
	int su2 = Integer.parseInt(request.getParameter("su2"));
	String oper = request.getParameter("oper");
	
	/* 	switch(oper){
	 case "+":
	 result = su1 + su2;
	 case "-":
	 result = su1 - su2;
	 case "*":
	 result = su1 * su2;
	 case "/":
	 result = su1 / su2;
	
	 str = String.format("%d %s %d = %d", su1, oper, su2, result);
	 } */
	 
		/* Java Recources -> src > com.calc > Calc.java  */
		/* Calc로 import */
		
		/* 객채 생성후에 값 넣기 */
//		Calc ob = new Calc();
		
//		ob.setSu1(su1);
//		ob.setSu2(su2);
//		ob.setOper(oper);
		
		/* 그다음에 호출 */
//		String str = ob.result();
		/* ob.result()안에 return str;이 있기 때문에  */
%>

<!-- 콩이 나왔다? 그럼 객체를 생성한거다 -->
<!-- 절대 page를 넘어가면안되 그래서 범위를 정해준다 -->
<jsp:useBean id="ob" class="com.calc.Calc" scope="page"/>
<jsp:setProperty property="*" name="ob"/>
<%-- <jsp:setProperty property="su1" name="ob" value= "<%=su1 %>"/>
<jsp:setProperty property="su2" name="ob" value= "<%=su2 %>"/>
<jsp:setProperty property="oper" name="ob" value="<%=oper %>"/> --%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<!-- 연산결과 뿌리기  -->


	결과 :
	<!-- < % = str % >  -->
	<%=ob.result()%>



</body>
</html>
