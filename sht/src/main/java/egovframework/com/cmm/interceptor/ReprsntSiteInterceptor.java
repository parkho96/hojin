package egovframework.com.cmm.interceptor;
 
import java.io.IOException;
import java.net.URLEncoder;
import java.util.Set;

import org.springframework.web.servlet.HandlerInterceptor;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.cmm.util.Punycode;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoVO;
 
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

public class ReprsntSiteInterceptor implements HandlerInterceptor {
    
    private Set<String> pasageURL;
    
    @Resource(name="SysMngrSiteInfoService")
    protected SysMngrSiteInfoService sysMngrSiteInfoService;
    
    public void setPasageURL(Set<String> pasageURL) {
        this.pasageURL = pasageURL;
    }
 
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
	    SysMngrSiteInfoVO paramVO = new SysMngrSiteInfoVO();
	    SysMngrSiteInfoVO resultVO = new SysMngrSiteInfoVO();
	    paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
	    resultVO = sysMngrSiteInfoService.selectSiteInfoDetail(paramVO);

	    //UrlPathHelper urlPathHelper = new UrlPathHelper();
	    //String   nowUri  = urlPathHelper.getOriginatingRequestUri(request);
	    
	    String siteUrl = request.getServerName();
	    String url = request.getRequestURL().toString();
	    String uri = request.getRequestURI().toString();
	    

        if (siteUrl.indexOf("xn--") > -1) {
        	
        	String chk = "";
        	String punyUrl = siteUrl.replace("xn--", "");
        	
        	if(siteUrl.indexOf(".xn--") > -1) {
        		chk = siteUrl.substring(0, siteUrl.indexOf(".xn--")+1) ;
        		punyUrl = punyUrl.replace(chk, "");
        	}
        	
        	String domn = "";
        	
        	if (punyUrl.indexOf(".") > -1) {
        		domn = punyUrl.substring(punyUrl.indexOf("."), punyUrl.length());
        		punyUrl = punyUrl.substring(0, punyUrl.indexOf("."));

        		punyUrl = Punycode.decode(punyUrl);
        	}
        	
        	siteUrl = chk+punyUrl+domn;
        	
        }
	    
	    if(uri.indexOf(".jsp") > -1) {
	    	return true;
	    }
    	
	    if(resultVO != null && resultVO.getSiteUrl() != null) {     
	    if(!siteUrl.equals(resultVO.getSiteUrl())) { 
	    	
	    	String browser = getBrowser(request);
	    	
	    	String encodedSiteUrl = null;
	    	
	    	if (browser.equals("MSIE")) {
	    		encodedSiteUrl = URLEncoder.encode(resultVO.getSiteUrl(), "UTF-8").replaceAll("\\+", "%20");
	    	} else if (browser.equals("Firefox")) {
	    		encodedSiteUrl = new String(resultVO.getSiteUrl().getBytes("UTF-8"), "8859_1");
	    	} else if (browser.equals("Opera")) {
	    		encodedSiteUrl = new String(resultVO.getSiteUrl().getBytes("UTF-8"), "8859_1");
	    	} else if (browser.equals("Chrome")) {
	    	    StringBuffer sb = new StringBuffer();
	    	    for (int i = 0; i < resultVO.getSiteUrl().length(); i++) {
	    		char c = resultVO.getSiteUrl().charAt(i);
	    		if (c > '~') {
	    		    sb.append(URLEncoder.encode("" + c, "UTF-8"));
	    		} else {
	    		    sb.append(c);
	    		}
	    	    }
	    	    encodedSiteUrl = sb.toString() ;
	    	} else {
	    	    throw new IOException("Not supported browser");
	    	}
	    	
	    	
	    	String replaceUri ="";
	    	if(url.indexOf("/subList") >-1) {
	    		if(resultVO.getSiteUrl().indexOf("/")>-1 && url.indexOf(resultVO.getSiteKey()) >-1) {
	    			return true;
	    		}
	        	if(!uri.startsWith("/subList")) {
	        		replaceUri = uri.substring(uri.indexOf("/", 1));
	        		response.sendRedirect(url.replaceAll(request.getServerName(), encodedSiteUrl).replaceAll(uri,"")+replaceUri);
	        	}else {
	        		replaceUri = uri;
	        		response.sendRedirect(url.replaceAll(request.getServerName(), encodedSiteUrl).replaceAll(uri,"")+replaceUri);
	        	}
	        }else {
	        	if(resultVO.getSiteUrl().indexOf("/")>-1 && url.indexOf(resultVO.getSiteKey()) >-1) {
	        		return true;
	        	}
	        	if(!("/").equals(uri)) {
	        		response.sendRedirect(url.replaceAll(request.getServerName(), encodedSiteUrl).replaceAll(uri,"")+"/index.do");
	        	}else {
	        		response.sendRedirect(url.replaceAll(request.getServerName(), encodedSiteUrl)+"index.do");
	        	}
	        }
	    	return false;
	    }else {
	    	if(resultVO.getSiteKey() != null && resultVO.getSiteUrl().indexOf(resultVO.getSiteKey()) < 0 
	    			&& url.indexOf(resultVO.getSiteKey()) > -1 && !("").equals(resultVO.getSiteKey())) {
	    		
	    		response.sendRedirect(url.replaceAll(request.getServerName(), resultVO.getSiteUrl()).replaceAll("/"+resultVO.getSiteKey(), ""));
	        	return false;
	    	} 
	    }
	    }
	    return true; 
	}
	
	private String getBrowser(HttpServletRequest request) {
        String header = request.getHeader("User-Agent");
        
        if(header != null) {        	        	
	        if (header.indexOf("Trident") > -1) {
	            return "MSIE";
	        } else if(header.indexOf("MSIE") > -1) {
	            return "MSIE";
	        } else if (header.indexOf("Chrome") > -1) {
	            return "Chrome";
	        } else if (header.indexOf("Opera") > -1) {
	            return "Opera";
	        } else if (header.indexOf("Firefox") > -1) {
	        	return "Firefox";
	        }        
        } 
        
        return "";                
    }
}
