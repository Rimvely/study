package com.svt;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.GenericServlet;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class Test1 extends GenericServlet {
	
	//객체가 크기때문에 용량을 미리 확보
	private static final long serialVersionUID = 1L;

	
	//request, response 이름들을 아래에서 바꿀수 있다
	@Override
	public void service(ServletRequest request, ServletResponse response)
			throws ServletException, IOException {
	
	//Client에게 알려준다. UTF-8로 보낼꺼야라고
	response.setContentType("text/html;charset=UTF-8");
	
	try {
		
		//Class안에서는 Servlet의 out의 내장객체를 가지고있지않다.
		PrintWriter out = response.getWriter();
		out.print("<html>");//println은 내용이없어도 ok, print는 내용이 있어야한다.
		out.print("<head>");
		out.print("<title>");
		out.print("예제 프로그램</title></head>");
		out.print("<body style='font-size: 12pt;'>");
		out.print("화면 디자인은 서블릿보다 JSP가 편하다");
		out.print("</body>");
		out.print("</html>");
		
	} catch (Exception e) {
		// TODO: handle exception
	}
		
		
		
		
		
		
		
		
		
		
	}

}
