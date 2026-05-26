package egovframework.wzwg.cmm.wizmesh;

import java.io.IOException;
import java.util.IllegalFormatException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.jsp.JspException;
import jakarta.servlet.jsp.JspWriter;
import jakarta.servlet.jsp.tagext.TagSupport;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class DecoratorBody extends TagSupport {  

    private static final Log LOG = LogFactory.getLog(DecoratorBody.class.getName());
    
    @Override
    public int doStartTag() throws JspException {

        JspWriter out = pageContext.getOut(); 
        
        HttpServletRequest request = (HttpServletRequest)pageContext.getRequest(); 
        HttpServletResponse response = (HttpServletResponse)pageContext.getResponse();
       
        String pagePath =request.getAttribute("bodyInc").toString();
        
        try { 
           
            if (pagePath != null && !"".equals(pagePath)) {
                out.flush();

                LOG.debug("* pagePath : "+pagePath);
                LOG.error("* pagePath : "+pagePath);

                RequestDispatcher dispatcher = request.getRequestDispatcher(pagePath);
                
                if (dispatcher != null) {
                    dispatcher.include(request, response);
                } else {
                    LOG.error("RequestDispatcher is null for path: " + pagePath);
                }
            }
        } catch(NullPointerException e){
        	LOG.error("NullPointerException",e);
	   	}catch(NumberFormatException e){
	   		LOG.error("NumberFormatException",e);
	   	}catch(IllegalFormatException e){
	   		LOG.error("IllegalFormatException",e);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		LOG.error("ArrayIndexOutOfBoundsException",e);
	   	}catch(IOException e){
	   		LOG.error("IOException",e);
	   	} catch (ServletException e) {
	   		LOG.error("ServletException",e);
		}
        
        return SKIP_BODY; 
    } 

    public int doEndTag() throws JspException { 
        return EVAL_PAGE; 
    } 

}
