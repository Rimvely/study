package com.svt;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.GenericServlet;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

public class Test1 extends GenericServlet {
	
	//��ü�� ũ�⶧���� �뷮�� �̸� Ȯ��
	private static final long serialVersionUID = 1L;

	
	//request, response �̸����� �Ʒ����� �ٲܼ� �ִ�
	@Override
	public void service(ServletRequest request, ServletResponse response)
			throws ServletException, IOException {
	
	//Client���� �˷��ش�. UTF-8�� �������߶��
	response.setContentType("text/html;charset=UTF-8");
	
	try {
		
		//Class�ȿ����� Servlet�� out�� ���尴ü�� �����������ʴ�.
		PrintWriter out = response.getWriter();
		out.print("<html>");//println�� �����̾�� ok, print�� ������ �־���Ѵ�.
		out.print("<head>");
		out.print("<title>");
		out.print("���� ���α׷�</title></head>");
		out.print("<body style='font-size: 12pt;'>");
		out.print("ȭ�� �������� ���������� JSP�� ���ϴ�");
		out.print("</body>");
		out.print("</html>");
		
	} catch (Exception e) {
		// TODO: handle exception
	}
		
		
		
		
		
		
		
		
		
		
	}

}