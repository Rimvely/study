<%@page import="com.sun.org.apache.xalan.internal.xsltc.compiler.sym"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.mail.sendMail"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<% 
	//한글을 3바이트로 받아줘서 안깨지게해주는것
	request.setCharacterEncoding("UTF-8");
//  cp = ~/study 까지 경로
	String cp = request.getContextPath();
%>

<%
	String root = getServletContext().getRealPath("/");
	String path = root + File.separator + "pds" + File.separator + "mailFile";
	
	//이 경로에 파일이없으면 만들어라
	File f = new File(path);
	if(!f.exists()){
		f.mkdirs();
	}
	
	String encType = "UTF-8";
	int maxSize = 10*1024*1024;
	
	sendMail mail = new sendMail();
	
	MultipartRequest mr = new MultipartRequest(request, path, maxSize, encType, new DefaultFileRenamePolicy());
	
	mail.setSenderName(mr.getParameter("senderName"));
	mail.setSenderEmail(mr.getParameter("senderEmail"));
	mail.setReceiverEmail(mr.getParameter("receiverEmail"));
	mail.setSubject(mr.getParameter("subject"));
	mail.setContent(mr.getParameter("content"));
	
	String fileName = mr.getOriginalFileName("fileName");
	
	if(fileName != null && !fileName.equals("")){
		
		String fileFullPath = path + File.separator + fileName;
		
		mail.setFileFullPath(fileFullPath);
		mail.setOriginalFileName(mr.getOriginalFileName("fileName"));
		
	}
	
	mail.sendMail();
	
	System.out.println("메일 전송 완료!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	



%>




<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>





</body>
</html>
