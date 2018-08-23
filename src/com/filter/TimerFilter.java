package com.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class TimerFilter implements Filter {
	
	private FilterConfig config;

	@Override
	public void destroy() {
		
		
		
	}

	@Override //ServletRequest req�� jsp���� ���� req
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		
		long before = System.currentTimeMillis(); //���� �ð�
		
		//�۾� filter���� 
		chain.doFilter(req, resp);//�������� ������ ����
		
		
		long after = System.currentTimeMillis(); //���� �ð�
		
		String uri;
		
		if(req instanceof HttpServletRequest){
			//Servlet���� ���� req > ����ȯ �۾��ѰŴ�
			HttpServletRequest request = (HttpServletRequest)req;
			
			uri = request.getRequestURI();
			
			//���۽ð� ����ϱ� (�α׿� ����� ��)
			config.getServletContext().log(uri + " : " + (after-before) + "ms");
					
			//class�� �����̰� �Ϸ��� web.xml ã�ư���
			System.out.println(uri + " : " + (after-before) + "ms");
		}
		
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		
		//������ ��� �ڽſ��� �޴°ɷ�
		this.config = config;
		
	}
	
	
	
	
	
	
	

}
