package com.tld;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

public class TestTag extends TagSupport {
	
	private static final long serialVersionUID = 1L;
	
	@Override
	public int doStartTag() throws JspException {
	
		try {
			
			pageContext.getOut().print("<font color='blue'>");
			pageContext.getOut().print("<오늘은 금요일!!>");
			pageContext.getOut().print("</font>");
			
			
			
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		
		return SKIP_BODY;
		
	}

}
