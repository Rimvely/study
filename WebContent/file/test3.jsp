<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
	//파일 경로
	//String root = request.getRealPath("/");
	String root = pageContext.getServletContext().getRealPath("/");

	//저장되는 폴더와 위치 file.separator = "/" 이다
	String path = root + File.separator + "pds" + File.separator + "saveData";

	//저장 폴더가 없으면 생성 dir 뜻 = directory
	File dir = new File(path);
	if(!dir.exists()){
		dir.mkdirs();
	}
	
	String encType = "UTF-8";
	int maxFileSize = 10*1024*1024;//10m
	
	try{
		
		//파일 전송 코딩은 한줄
		MultipartRequest mr = 
		new MultipartRequest(request,path,maxFileSize,encType,new DefaultFileRenamePolicy());
		
		
		//DB에 저장할 파일 정보를 추출
		out.print("제목 : " + mr.getParameter("subject") + "<br/>");
		out.print("서버에 저장된 파일명 : " + mr.getFilesystemName("upload") + "<br/>");
		out.print("업로드한 파일명 : " + mr.getOriginalFileName("upload") + "<br/>");
		out.print("파일 타입 : " + mr.getContentType("upload") + "<br/>");
		
		File f = mr.getFile("upload");
		if(f!=null){
			out.print("파일길이 : " + f.length() + "<br/>");
		}
		
		
		
		
		
		
		
		
		
		
		
		
	}catch (Exception e){
		System.out.print(e.toString());
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

업로드 성공!!



<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
<br/><br/><br/><br/><br/><br/>
</body>
</html>
