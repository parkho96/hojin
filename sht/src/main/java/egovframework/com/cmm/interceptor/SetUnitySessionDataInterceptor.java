package egovframework.com.cmm.interceptor;
 
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoVO;
 
public class SetUnitySessionDataInterceptor implements HandlerInterceptor {
    
    
    @Resource(name="SysMngrSiteAdiInfoService")
    protected SysMngrSiteAdiInfoService siteAdiInfoService;
    
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
	    SysMngrSiteAdiInfoVO sysMngrSiteAdiInfoVO = new SysMngrSiteAdiInfoVO();
	    
	    sysMngrSiteAdiInfoVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
	    SysMngrSiteAdiInfoVO sysMngrSiteAdiInfo = siteAdiInfoService.selectSiteAdiInfoDetail(sysMngrSiteAdiInfoVO);
	    
	    if(sysMngrSiteAdiInfo == null) {
	    	CmmSessionUtil.setSessionValue(request, "rghtClickAt", "");
		} else {
			CmmSessionUtil.setSessionValue(request, "rghtClickAt", sysMngrSiteAdiInfo.getRghtClickAt());
	    }
	    
	    
	    return true; 
	}
}
