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

	@Override //ServletRequest req는 jsp에서 쓰는 req
	public void doFilter(ServletRequest req, ServletResponse resp,
			FilterChain chain) throws IOException, ServletException {
		
		long before = System.currentTimeMillis(); //시작 시간
		
		//작업 filter에서 
		chain.doFilter(req, resp);//목적지로 데이터 전송
		
		
		long after = System.currentTimeMillis(); //종료 시간
		
		String uri;
		
		if(req instanceof HttpServletRequest){
			//Servlet에서 쓰는 req > 형변환 작업한거다
			HttpServletRequest request = (HttpServletRequest)req;
			
			uri = request.getRequestURI();
			
			//전송시간 계산하기 (로그에 남기는 것)
			config.getServletContext().log(uri + " : " + (after-before) + "ms");
					
			//class가 움직이게 하려면 web.xml 찾아가기
			System.out.println(uri + " : " + (after-before) + "ms");
		}
		
	}

	@Override
	public void init(FilterConfig config) throws ServletException {
		
		//받을게 없어서 자신에게 받는걸로
		this.config = config;
		
	}
	
	
	
	
	
	
	

}
