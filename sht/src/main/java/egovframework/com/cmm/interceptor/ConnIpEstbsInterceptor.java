package egovframework.com.cmm.interceptor;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoService;

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

@Component("connIpEstbsInterceptor")
public class ConnIpEstbsInterceptor implements HandlerInterceptor {

    @Resource(name="SysMngrSiteAdiInfoService")
    private SysMngrSiteAdiInfoService sysMngrSiteAdiInfoService;
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		// 관리자 설정 체크
		String connIp = sysMngrSiteAdiInfoService.selectSiteAdiInfoConnIp(siteSeq);
		String connIpEstbs = "";
		if (!"".equals(StringUtils.defaultString(connIp))) {
			connIpEstbs = StringUtils.defaultString(connIp).trim();
		}
		boolean connPerm = false;
		if (!"".equals(connIpEstbs)) {
			String[] ipEstbsArr = connIpEstbs.split(",");
			String reqIp = getClientIP(request);
	        AntPathMatcher m = new AntPathMatcher();
			for (int i=0; i<ipEstbsArr.length; i++) {
				if (m.match(ipEstbsArr[i], reqIp)) { 
					connPerm = true;
				}
			}	
		} else {
			connPerm = true;
		}
		if (!connPerm) {
			ModelAndView retModel = new ModelAndView();
//			retModel.addObject("errCd","fail.login.token");
//			retModel.setViewName("wzwg/cmm/errorStringMsgForward");
//			retModel.addObject("retUrl", "/index.do");
			retModel.setViewName("redirect:"+wzwgContext+"/index.do");
			throw new ModelAndViewDefiningException(retModel);
		}        
        return true; 
	}

    private String getClientIP(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");

        if (ip == null) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null) {
            ip = request.getHeader("HTTP_CLIENT_IP");
        }
        if (ip == null) {
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null) {
            ip = request.getRemoteAddr();
        }

        return ip;
    }
	
	 
}
