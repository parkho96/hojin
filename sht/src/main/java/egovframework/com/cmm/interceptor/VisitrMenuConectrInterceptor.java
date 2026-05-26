package egovframework.com.cmm.interceptor;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.interceptor.service.VisitrMenuStatsService;
import egovframework.com.cmm.interceptor.service.VisitrMenuStatsVO;
import egovframework.wzwg.cmm.util.CmmMenuNoUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;

 
@Component("visitrMenuInterceptor")
public class VisitrMenuConectrInterceptor implements HandlerInterceptor {
 
	@Resource(name = "VisitrMenuStatsService")
	VisitrMenuStatsService visitrMenuStatsService;

	      
		public void postHandle(
			HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView)
			throws Exception {
			
		 HttpSession session = request.getSession(true);
		  String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		     String getUrl = request.getRequestURI();
		     VisitrMenuStatsVO visitrMenuStatsVO = new VisitrMenuStatsVO();
		    
		     String requestURI = request.getRequestURI();
		     if(requestURI.startsWith("/sysMngr/")
		    		 || requestURI.startsWith("/message")  
		 			|| requestURI.startsWith("/dggb/module/image/")
		 			|| requestURI.indexOf("actionLogin.do")>-1
		 			|| requestURI.startsWith("/errorForward.do")
		 			|| requestURI.startsWith("/indexModule.do")
		 			|| requestURI.startsWith("/uat/uia/egovLoginUsr.do") 			
		 			|| requestURI.indexOf("/login/LoingForm.do")>-1
		 			|| requestURI.indexOf("/login/loginForm.do")>-1
		 			|| requestURI.indexOf("/login/mberLoginForm.do")>-1
		 			|| requestURI.indexOf("logout.do")>-1
		 			|| requestURI.indexOf("login.do")>-1
		 			|| requestURI.startsWith("/dggb/cmm/mber/mberSbscrb/")
		 			|| requestURI.startsWith("/dggb/cmm/mber/mberInfo/")
		 			|| requestURI.indexOf("Popup")>-1
		 			|| requestURI.startsWith("/dggb/module/onlineQustnr/registQustnrResponseIem")
		 			|| requestURI.startsWith("/dggb/mngr/cmm/actionLogin.do")
		 			|| requestURI.indexOf("/selectImageView.do")>-1
		 			|| requestURI.indexOf("/actionLogout.do")>-1
		 			|| requestURI.indexOf("/selectThumbImageView.do")>-1){ 
		     }else{
		    	  	String userAgentStr = request.getHeader("user-agent");
		    	  	String os ="";
		    	  	if(userAgentStr.toUpperCase().indexOf("WINDOWS") != -1) {
		        		os = "PC";
		        	} else if(userAgentStr.toUpperCase().indexOf("ANDROID") != -1) {
		        		os = "MOBILE";
		        	} else if(userAgentStr.toUpperCase().indexOf("IPAD") != -1) {
		        		os = "MOBILE";
		        	} else if(userAgentStr.toUpperCase().indexOf("IPHONE") != -1) {
		        		os = "MOBILE";
		        	} else if(userAgentStr.toUpperCase().indexOf("MAC") != -1) {
		        		os = "PC";
		        	} else {
		        		os = "PC";
		        	}
		    	  	 visitrMenuStatsVO.setSiteSeq(siteSeq);
		    	 visitrMenuStatsVO.setDeviceSeCode(os);
		     if(requestURI.startsWith("/index.do")){
		    	 if(os.equals("PC")){
		    		 visitrMenuStatsVO.setMenuNo("1");
		    	 }else if(os.equals("MOBILE")){
		    		 visitrMenuStatsVO.setMenuNo("3");	 
		    	 }
		     }else if(requestURI.startsWith("/cmnt")){
		    	 if(os.equals("PC")){
		    		 visitrMenuStatsVO.setMenuNo("2");
		    	 }else if(os.equals("MOBILE")){
		    		 visitrMenuStatsVO.setMenuNo("4");	 
		    	 }
		     }else{
			   String menuId = CmmMenuNoUtil.getUrlByMenuNo(request);
			   if(menuId.equals("")){
				   visitrMenuStatsVO.setMenuNo("0");
			   }else{
				   visitrMenuStatsVO.setMenuNo(menuId);
			   }
		     }
		     
		     
			     if(!"".equals(StringUtils.defaultString(visitrMenuStatsVO.getSiteSeq()))) {
			    	 visitrMenuStatsService.registSiteMenuConect(visitrMenuStatsVO);
			     }
		     
		     }
		//dggbCmntConectrService.logDggbCmntConectr(cmntconectrVO); 
	}

}
