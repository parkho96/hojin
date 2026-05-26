package egovframework.com.cmm.interceptor;

import java.io.IOException;
import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.cmm.util.CmmWizmeshUtil;
import egovframework.wzwg.site.mngr.menu.service.SiteMngrMenuService;
import egovframework.wzwg.site.mngr.menu.service.SiteMngrMenuVO;

 
@Component("wizmeshInterceptor")
public class WizmeshInterceptor implements HandlerInterceptor {

    private static final Log LOG = LogFactory.getLog(WizmeshInterceptor.class.getName());
    
    @Resource(name="CmmWizmeshUtil")
    private CmmWizmeshUtil cmmWizmeshUtil;
    
    @Resource(name="siteMngrMenuService")
	private SiteMngrMenuService siteMngrMenuService;
    

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        //return super.preHandle(request, response, handler);
		return true;
	}

	@Override
    public void postHandle(HttpServletRequest request,
                           HttpServletResponse response, Object handler,
                           ModelAndView modelAndView) throws Exception {

	    try {
	    	String ajaxAt = StringUtils.defaultString(request.getHeader("x-requested-with")).toString();
	    	if(ajaxAt.equals("XMLHttpRequest")) {
	    	} else {
	    		if (modelAndView != null) {
			        String callPage = StringUtils.defaultString(modelAndView.getViewName());
			    	
		            if (callPage.indexOf("forward:") < 0 && callPage.indexOf("redirect:") < 0 ) {
		                
		                String reqUrl = StringUtils.defaultString(request.getRequestURI().toString());
		                
		                if (reqUrl.toLowerCase().indexOf(".ico") < 0 
		                        && reqUrl.toLowerCase().indexOf(".jpg") < 0
		                        && reqUrl.toLowerCase().indexOf(".png") < 0
		                        && reqUrl.toLowerCase().indexOf(".js") < 0
		                        && reqUrl.toLowerCase().indexOf(".css") < 0
		                        && reqUrl.toLowerCase().indexOf(".woff2") < 0) {
		                    
		                    String pagePath = cmmWizmeshUtil.getPagePath("E", reqUrl);
		                    System.out.println("pagePath1 : "+pagePath);
		                    
		                    if ("".equals(pagePath)) {
		                        pagePath = cmmWizmeshUtil.getPagePath("S", reqUrl);
		                        System.out.println("pagePath2 : "+pagePath);
		                        if (!"".equals(pagePath)) {
		                            pagePath = pagePath.replaceAll("%siteSeq%", CmmSessionUtil.getSessionSiteSeq(request));
		                            
		                            if (pagePath.indexOf("/WEB-INF/") < 0) {
		                                modelAndView.addObject("bodyInc", "/WEB-INF/jsp/"+callPage+".jsp");
		                            } else {
		                                modelAndView.addObject("bodyInc", "");
		                            }
		                            
		//                            modelAndView.addObject("bodyInc", "/WEB-INF/jsp/"+callPage+".jsp");
		                            if(CmmSessionUtil.getLoginVO() != null) {
		                            String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		                            
		                            String usrSeq = CmmSessionUtil.getLoginVO().getUsrSeq();
		                            boolean sadminAt =  CmmSessionUtil.getSessionBooleanValue(request, "SADMIN_AT");
		                            
		                            SiteMngrMenuVO siteMngrMenuVO = new SiteMngrMenuVO();
		                            siteMngrMenuVO.setSiteSeq(siteSeq);
		                            siteMngrMenuVO.setUsrSeq(usrSeq); 
		                            if(sadminAt) {
		                            	siteMngrMenuVO.setSysmngrAt("Y");
		                            }else {
		                            	siteMngrMenuVO.setSysmngrAt("N");
		                            }
		                            
		                            List<SiteMngrMenuVO> menuMngrList = siteMngrMenuService.selectSiteMenuLeftList(siteMngrMenuVO);
		                    		
		                            request.setAttribute("menuMngrList", menuMngrList);
		                            }
		                            modelAndView.setViewName(pagePath);
		
		                        }
		                    }
		                }
		            }
	    		}
	    	}
	    }catch (NullPointerException e) {	
	    	LOG.error("NullPointerException",e);
		}catch (NumberFormatException e) {
			LOG.error("NumberFormatException",e);
		}catch (ArrayIndexOutOfBoundsException e) {
			LOG.error("ArrayIndexOutOfBoundsException",e);
		}catch (IOException e) {
			LOG.error("IOException",e);
		}
    }

}
