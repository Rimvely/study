package com.tld;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

public class MySum extends TagSupport {

	private static final long serialVersionUID = 1L;

		private String su;
		private String defaultValue;
		
		public void setSu(String su){
			this.su = su;
		}
		
		public void setDefault(String defaultValue){
			
			this.defaultValue = defaultValue;
		}
		
		@Override
		public int doEndTag() throws JspException {
		
			su = null;
			defaultValue = null;
			
			return EVAL_PAGE;
			
			
		}
		
		@Override
		public int doStartTag() throws JspException {
		
			JspWriter out = pageContext.getOut();
			
			try {
				
				String value = su;
				
				if(value==null){
					value = defaultValue;
				}
				
				//인수가 없을때
				if(value==null||value.equals(""))
					value = "0";
				
				int s = 0;
				
				for(int i=1; i<=Integer.parseInt(value); i++){
					s += i;
					
					
				}
				out.print(s);
				
				
			} catch (Exception e) {
				System.out.println(e.toString());
			}
			
			return SKIP_BODY;

		}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
