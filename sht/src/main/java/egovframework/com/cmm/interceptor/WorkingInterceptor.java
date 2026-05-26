package egovframework.com.cmm.interceptor;

import java.util.Iterator;
import java.util.Set;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.servlet.HandlerInterceptor;

import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.screen.service.SiteTemplateScreenService;
import egovframework.wzwg.site.mngr.screen.service.SiteTemplateScreenVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteOpertNtcService;

/**
 * 인증여부 체크 인터셉터
 * @author 공통서비스 개발팀 서준식
 * @since 2011.07.01
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2011.07.01  서준식          최초 생성 
 *  2011.09.07  서준식          인증이 필요없는 URL을 패스하는 로직 추가
 *  </pre>
 */

@Component("workInterceptor")
public class WorkingInterceptor implements HandlerInterceptor {

	private static final Log LOG = LogFactory.getLog(WorkingInterceptor.class.getName());
	
	private Set<String> pasageURL;
	
	public void setPasageURL(Set<String> pasageURL) {
		this.pasageURL = pasageURL;
	}
	 
    @Resource(name="SiteTemplateScreenService")
    private SiteTemplateScreenService siteTemplateScreenService;
    
    /** 사이트 작업관리 */
    @Resource(name="SysMngrSiteOpertNtcService")
    private SysMngrSiteOpertNtcService siteOpertNtcService;
    
	@Resource(name="SysMngrSiteInfoService")
	private SysMngrSiteInfoService siteInfoService;
		
	public boolean preHandle(
			HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception { 
				String retUrl  =request.getRequestURI(); //요청 URI
				if (getPasageUrlCheck(retUrl)) {  
				
				}else{
					if(!retUrl.startsWith("/subsite/")){
						String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
						//String realPath =request.getServletContext().getRealPath("/"); 
						SiteTemplateScreenVO siteTemplateScreenParam = new SiteTemplateScreenVO();
						
						/**도메인 SEQ */
						String domnSeq = CmmSessionUtil.getSessionDomnSeq(request);
						siteTemplateScreenParam.setSiteSeq(siteSeq);
						siteTemplateScreenParam.setDomnSeq(domnSeq);
						siteTemplateScreenParam.setUserId(CmmSessionUtil.getSessionUserId());
						if(siteTemplateScreenService.selectSiteTemplateScreenChk(siteTemplateScreenParam) <1){
							 response.sendRedirect("/working.do");
								return false;
						}
			 			
						SysMngrSiteInfoVO sysMngrSiteInfo    = new SysMngrSiteInfoVO();
		            	sysMngrSiteInfo.setSiteSeq(siteSeq);
		            	SysMngrSiteInfoVO sysMngrSiteInfoVO	 = siteInfoService.selectSiteInfoDetail(sysMngrSiteInfo);
		            	String srvtAt = sysMngrSiteInfoVO.getSrvcAt();
		            	// 사이트 작업관리 체크
		                Integer siteOpertntcCnt = siteOpertNtcService.selectConectCtrlSiteOpertntcChk(siteSeq);
		            	if(siteOpertntcCnt <1 && srvtAt.equals("N")){
		            		 response.sendRedirect("/working.do");
								return false;
		            	}
					} 
				} 
				return true;
	}
	
	/**
	private boolean urlPatternCheck(HttpServletRequest request) {
		
		String requestURI = request.getRequestURI(); //요청 URI

		boolean isPermittedURL = false; 
		
		for(Iterator<String> it = this.permittedURL.iterator(); it.hasNext();){
			String urlPattern = request.getContextPath() + (String) it.next();

			LOG.debug(requestURI + ", " + Pattern.matches(urlPattern, requestURI));
			if(Pattern.matches(urlPattern, requestURI)){// 정규표현식을 이용해서 요청 URI가 허용된 URL에 맞는지 점검함.
				isPermittedURL = true;
			}
		}
		
		return isPermittedURL;
	}
	
	**/
	private boolean getPasageUrlCheck(String callUrl) {

        AntPathMatcher m = new AntPathMatcher();
        
        for(Iterator<String> it = this.pasageURL.iterator(); it.hasNext();){
            String configUrl = (String)it.next();
            
            LOG.debug("* configUrl : " + configUrl + ", callUrl : " + callUrl);
            
            if (m.match(configUrl, callUrl)) {
                return true;
            }
        }
        
        return false;
    }

}
