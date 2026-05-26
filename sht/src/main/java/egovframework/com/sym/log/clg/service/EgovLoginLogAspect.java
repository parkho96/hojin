package egovframework.com.sym.log.clg.service;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;

/**
 * @Class Name : EgovLoginLogAspect.java
 * @Description : 시스템 로그 생성을 위한 ASPECT 클래스
 * @Modification Information
 *
 *    수정일         수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 11.   이삼섭         최초생성
 *    2011. 7. 01.   이기하         패키지 분리(sym.log -> sym.log.clg)
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 11.
 * @version
 * @see
 *
 */
public class EgovLoginLogAspect {
	
	@Resource(name="EgovLoginLogService")
	private EgovLoginLogService loginLogService;
	
	   @Autowired
		private HttpServletRequest request;

	/**
	 * 로그인 로그정보를 생성한다.
	 * EgovLoginController.actionMain Method
	 * 
	 * @param 
	 * @return void
	 * @throws Exception 
	 */
	public void logLogin() throws Throwable {
		
		String uniqId = "";
		String ip = "";
		String siteId ="";
		String userTyId ="";
		/* Authenticated  */
        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(isAuthenticated.booleanValue()) {
			CmmLoginVO user = (CmmLoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
			uniqId = user.getUsrSeq();
			ip = request.getRemoteAddr();
			siteId =  CmmSessionUtil.getSessionSiteSeq(request);
			userTyId = user.getUsrtySeq();
    	}
    	LoginLog loginLog = new LoginLog();
    	loginLog.setLoginId(uniqId);
        loginLog.setLoginIp(ip);
        loginLog.setLoginMthd("I"); // 로그인:I, 로그아웃:O
        loginLog.setErrOccrrAt("N");
        loginLog.setErrorCode("");
        loginLog.setSiteId(siteId);
        loginLog.setUserTyId(userTyId);
        loginLogService.logInsertLoginLog(loginLog);

	}
	
	/**
	 * 로그아웃 로그정보를 생성한다.
	 * EgovLoginController.actionLogout Method
	 * 
	 * @param 
	 * @return void
	 * @throws Exception 
	 */
	public void logLogout() throws Throwable {
		
		String uniqId = "";
		String ip = "";
		String siteId ="";
		String userTyId ="";

		/* Authenticated  */
        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
    	if(isAuthenticated.booleanValue()) {
			CmmLoginVO user = (CmmLoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
			uniqId = user.getUsrSeq();
			ip = request.getRemoteAddr();
			siteId = user.getSiteSeq();
			userTyId = user.getUsrtySeq();
    	}

    	LoginLog loginLog = new LoginLog();
    	loginLog.setLoginId(uniqId);
        loginLog.setLoginIp(ip);
        loginLog.setLoginMthd("O"); // 로그인:I, 로그아웃:O
        loginLog.setErrOccrrAt("N");
        loginLog.setErrorCode("");
        loginLog.setSiteId(siteId);
        loginLog.setUserTyId(userTyId);
        loginLogService.logInsertLoginLog(loginLog);
	}
	
}
