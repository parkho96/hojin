package egovframework.wzwg.cmm.wizmesh;

import java.io.IOException;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.JspWriter;
import jakarta.servlet.jsp.tagext.TagSupport;

public class DecoratorHead extends TagSupport {  
	 public int doStartTag() throws JspException { 
	        JspWriter out = pageContext.getOut(); 
	        HttpServletRequest request = 
	            (HttpServletRequest)pageContext.getRequest(); 
	        try { 
	            out.println(""); 
	            
	        } catch (IOException e) { 
	            throw new JspException(e); 
	        } 
	       	       return SKIP_BODY; 
	    } 

	    

	    public int doEndTag() throws JspException { 
	        return EVAL_PAGE; 
	    } 
	 
}
