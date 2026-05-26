package egovframework.com.cmm.interceptor;
 
import java.util.Set;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import egovframework.wzwg.cmm.util.CmmSessionUtil;
 
/**
 * 사용자IP 체크 인터셉터
 * @author 유지보수팀 이기하
 * @since 2013.03.28
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일     수정자          수정내용
 *  ----------  --------    ---------------------------
 *  2013.03.28	이기하          최초 생성 
 *  </pre>
 */

public class SslInterceptor implements HandlerInterceptor {
    
    private Set<String> pasageURL;
    
    public void setPasageURL(Set<String> pasageURL) {
        this.pasageURL = pasageURL;
    }
 
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
	    String sslUseAt = CmmSessionUtil.getSessionValue(request, "SSL_USE_AT");
	    
	    if ("Y".equals(sslUseAt)) {

	  	    String nowUri = request.getRequestURI();
	          String url = request.getRequestURL().toString();
	      	String domain = request.getRequestURL().toString().replace(request.getRequestURI(),"");
	      	
	      	if(domain.indexOf("seoultech.ac.kr") >-1 ) {
	      		 
	      			if (url.indexOf("https://") > -1) {
	      				return true;
	      			} else {
	      				response.sendRedirect(url.replaceAll("http://", "https://"));
	      				return false;   
	      			} 
	      	}else {
	      		  return true;
	      	} 
	      	 
	    } else {
	        return true;
	    }
	}
}
