package egovframework.wzwg.cmm.mber.login.web;

import java.sql.SQLException;
import java.util.IllegalFormatException;
import java.util.List;
import java.util.Locale;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.interceptor.service.MngrAuthService;
import egovframework.com.cmm.interceptor.service.MngrAuthVO;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.sym.log.clg.service.EgovLoginLogService;
import egovframework.com.sym.log.clg.service.LoginLog;
import egovframework.com.utl.sim.service.EgovHttpSessionBindingListener;
import egovframework.wzwg.cmm.mber.cmm.service.CmmRecrtfcService;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginService;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.mber.myPage.service.CmmMyStplatAgreService;
import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSbscrbService;
import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSbscrbVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmReturnUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.cmm.util.snsAPI.service.GoogleAPIService;
import egovframework.wzwg.cmm.util.snsAPI.service.KakaoRestApiHelper;
import egovframework.wzwg.cmm.util.snsAPI.service.NaverAPIService;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuService;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuVO;
import egovframework.wzwg.site.mngr.screen.service.SiteTemplateScreenService;
import egovframework.wzwg.site.mngr.usrMngr.sbscrbCrtfcEstbs.service.SbscrbCrtfcEstbsService;
import egovframework.wzwg.site.mngr.usrMngr.sbscrbCrtfcEstbs.service.SbscrbCrtfcEstbsVO;
import egovframework.wzwg.site.mngr.usrMngr.usrLog.service.SiteUsrLogService;
import egovframework.wzwg.site.mngr.usrMngr.usrLog.service.SiteUsrLogVO;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoVO;
import egovframework.wzwg.sysMngr.usrPrefces.service.UsrPrefcesService;
import egovframework.wzwg.sysMngr.usrPrefces.service.UsrPrefcesVO;

@Controller
public class CmmLoginController {

	protected static final Log LOG = LogFactory.getLog(CmmLoginController.class);

	@Resource(name = "egovMessageSource")
	EgovMessageSource egovMessageSource;

	@Resource(name = "CmmLoginService")
	private CmmLoginService loginService;

	@Resource(name = "SiteTemplateScreenService")
	private SiteTemplateScreenService siteTemplateScreenService;

	@Resource(name = "UsrPrefcesService")
	private UsrPrefcesService usrPrefcesService;

	@Resource(name = "SysMngrSiteInfoService")
	private SysMngrSiteInfoService siteInfoService;

	@Resource(name = "SysMngrSiteAdiInfoService")
	private SysMngrSiteAdiInfoService siteAdiInfoService;

	@Resource(name = "SiteMenuService")
	private SiteMenuService siteMenuService;

	@Resource(name = "SbscrbCrtfcEstbsService")
	private SbscrbCrtfcEstbsService sbscrbCrtfcEstbsService;

	@Resource(name = "CmmRecrtfcService")
	private CmmRecrtfcService recrtfcService;

	@Resource(name = "CmmSbscrbService")
	private CmmSbscrbService cmmSbscrbService;

	@Resource(name = "CmmMyStplatAgreService")
	private CmmMyStplatAgreService cmmMyStplatAgreService;

	@Resource(name = "SiteUsrLogService")
	private SiteUsrLogService siteUsrLogService;

	@Resource(name = "NaverAPIService")
	private NaverAPIService naverAPIService;

	@Resource(name = "GoogleAPIService")
	private GoogleAPIService googleAPIService;

	@Autowired
	private HttpServletRequest hreq;

	@Resource(name = "EgovLoginLogService")
	private EgovLoginLogService loginLogService;

	@RequestMapping(value = { "/loginForm.do", "/{siteKey}/loginForm.do", "/adLoginForm.do",
			"/{siteKey}/loginForm.do" })
	public String mberLoginForm(
			@ModelAttribute("paramVO") CmmLoginVO paramVO, @ModelAttribute("sceVO") SbscrbCrtfcEstbsVO secVO,
			HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {

		model = recrtfcService.getCrtfcEstbsAndNiceModuleLogin(request, model, secVO);

		return "wzwg/cmm/mber/login/mberLoginForm";
	}

	@RequestMapping(value = { "/actionSnsLogin.do", "/{siteKey}/actionSnsLogin.do" })
	public ModelAndView actionSnsLogin(@ModelAttribute("loginVO") CmmLoginVO loginVO, HttpServletRequest request,
			HttpServletResponse response, ModelMap model)
			throws Exception {

		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		loginVO.setSiteSeq(siteSeq);

		CmmLoginVO resultVO = loginService.actionSnsLogin(loginVO);
		if (resultVO == null) {
			if (loginVO.getCrtfctSeCode() != null && loginVO.getCrtfctSeCode().equals("SC00000433")) {
				return CmmAjaxUtil.getAjaxReturn("snsNaverFail");
			}

			if (loginVO.getCrtfctSeCode() != null && loginVO.getCrtfctSeCode().equals("SC00000434")) {
				return CmmAjaxUtil.getAjaxReturn("snsKakaoFail");
			}

			if (loginVO.getCrtfctSeCode() != null && loginVO.getCrtfctSeCode().equals("SC00000436")) {
				return CmmAjaxUtil.getAjaxReturn("snsGoogleFail");
			}
		}
		return actionLoginProcess(resultVO, request, loginVO);
	}

	@RequestMapping(value = { "/actionLogin.do", "/{siteKey}/actionLogin.do" })
	public ModelAndView actionLogin(@ModelAttribute("loginVO") CmmLoginVO loginVO, HttpServletRequest request,
			HttpServletResponse response, ModelMap model)
			throws Exception {

		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		loginVO.setSiteSeq(siteSeq);
		String passFailCnt = EgovProperties.getProperty("pass.fail.cnt");
		;
		String passFailDiff = EgovProperties.getProperty("pass.fail.diff");
		;
		loginVO.setPassFailDiff(passFailCnt);
		loginVO.setPassFailCnt(passFailDiff);

		String passFailYn = loginService.selectPassFailYn(loginVO);

		if (passFailYn != null && passFailYn.equals("Y")) {
			return CmmAjaxUtil.getAjaxReturn("passFiveFail");
		}

		CmmLoginVO resultVO = loginService.actionLogin(loginVO);
		if (resultVO != null) {
			java.util.Enumeration params = request.getParameterNames();
			String usrlogParam = "";
			boolean bBadWord = false;
			while (params.hasMoreElements()) {
				String name = (String) params.nextElement();
				String value = dggb.util.StringUtils.nvl(request.getParameter(name), "");
				if (!name.equals("password")) {
					usrlogParam = usrlogParam + "&" + name + "=" + value;
				}
			}
			usrlogParam = usrlogParam.substring(1);
			SiteUsrLogVO siteUsrLogVO = new SiteUsrLogVO();
			siteUsrLogVO.setConectIp(request.getRemoteAddr());
			siteUsrLogVO.setFrstRegisterId(loginVO.getUserId());
			siteUsrLogVO.setLinkageAt("Y");
			siteUsrLogVO.setSiteSeq(siteSeq);
			siteUsrLogVO.setUsrChngCode("SC00000020");
			siteUsrLogVO.setUsrlogParam(usrlogParam);
			siteUsrLogVO.setUsrlogUrl(request.getRequestURI());
			siteUsrLogVO.setUsrlogUsrSeq(resultVO.getUsrSeq());
			siteUsrLogVO.setUsrSeq(resultVO.getUsrSeq());
			siteUsrLogService.insertSiteUsrLog(siteUsrLogVO);
		}
		return actionLoginProcess(resultVO, request, loginVO);
	}

	private ModelAndView actionLoginProcess(CmmLoginVO resultVO, HttpServletRequest request, CmmLoginVO loginVO)
			throws Exception {
		String uniqId = "";
		String ip = "";
		String siteId = "";
		String userTyId = "";
		String userId = loginVO.getUserId();

		ModelAndView returnFailModel;

		try {
			CmmSessionUtil.setSessionValue(request, "loginVO", null);

			RequestAttributes attributes = RequestContextHolder.getRequestAttributes();

			if (attributes != null) {
				attributes.removeAttribute("loginVO", RequestAttributes.SCOPE_SESSION);
				attributes.removeAttribute("SADMIN_AT", RequestAttributes.SCOPE_SESSION);
				attributes.removeAttribute("NADMIN_AT", RequestAttributes.SCOPE_SESSION);
				attributes.removeAttribute("SYSMNGR_AT", RequestAttributes.SCOPE_SESSION);
				attributes.removeAttribute("subSiteMngr", RequestAttributes.SCOPE_SESSION);
			}

			HttpSession session = request.getSession(true);
			if (resultVO != null) {
				loginService.modifyUsrPassFailLoginInit(resultVO);
				if (!"".equals(resultVO.getErrMsg())) {

					LoginLog loginLog = new LoginLog();
					loginLog.setLoginId(uniqId);
					loginLog.setLoginIp(ip);
					loginLog.setLoginMthd("I"); // 로그인:I, 로그아웃:O
					loginLog.setErrOccrrAt("Y");
					loginLog.setErrorCode(loginVO.getPassword());
					loginLog.setSiteId(CmmSessionUtil.getSessionSiteSeq(request));
					loginLog.setUserTyId(userTyId);
					loginLog.setUserId(userId);
					loginLogService.logInsertLoginLog(loginLog);
					return CmmAjaxUtil.getAjaxReturn(resultVO.getErrMsg());
				} else {

					boolean nAdminChk = (Globals.AUTH_NORMAL_ADMIN.equals(resultVO.getUsrtySeq())) ? true : false;
					if (nAdminChk) {

						if (attributes != null) {
							attributes.setAttribute("NADMIN_AT", nAdminChk, RequestAttributes.SCOPE_SESSION);
							attributes.setAttribute("SADMIN_AT", false, RequestAttributes.SCOPE_SESSION);
						}

						MngrAuthVO mngrAuthVO = new MngrAuthVO();
						mngrAuthVO.setSiteSeq(resultVO.getSiteSeq());
						mngrAuthVO.setUsrSeq(resultVO.getUsrSeq());
						List<MngrAuthVO> mngrAuthList = mngrAuthService.selectMngrConAuthUsr(mngrAuthVO);
						resultVO.setMngrAuthList(mngrAuthList);

						if (attributes != null) {
							attributes.setAttribute("NADMIN_AT", nAdminChk, RequestAttributes.SCOPE_SESSION);
							attributes.setAttribute("SADMIN_AT", false, RequestAttributes.SCOPE_SESSION);
						}

						SysMngrSiteInfoVO siteInfoVO = new SysMngrSiteInfoVO();
						siteInfoVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
						SysMngrSiteInfoVO siteInfo = siteInfoService.selectSiteInfoDetail(siteInfoVO);
						SiteMenuVO siteMenuVO = new SiteMenuVO();
						siteMenuVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
						String topLogo = siteMenuService.selectSiteTopLogo(siteMenuVO);

						request.getSession().setAttribute("loginVO", resultVO);

						if (attributes != null) {
							attributes.setAttribute("loginVO", resultVO, RequestAttributes.SCOPE_SESSION);
						}

						Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
						if (isAuthenticated.booleanValue()) {
							CmmLoginVO user = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
							uniqId = user.getUsrSeq();
							ip = request.getRemoteAddr();
							siteId = user.getSiteSeq();
							userTyId = user.getUsrtySeq();
							userId = user.getUserId();
						}

						LoginLog loginLog = new LoginLog();
						loginLog.setLoginId(uniqId);
						loginLog.setLoginIp(ip);
						loginLog.setLoginMthd("I"); // 로그인:I, 로그아웃:O
						loginLog.setErrOccrrAt("N");
						loginLog.setErrorCode("");
						loginLog.setSiteId(CmmSessionUtil.getSessionSiteSeq(request));
						loginLog.setUserTyId(userTyId);
						loginLog.setUserId(userId);
						loginLogService.logInsertLoginLog(loginLog);
						session.setAttribute("mngrSiteNm", siteInfo.getSiteFullNm());
						session.setAttribute("mngrTopLogo", topLogo);
					} else {

						request.getSession().setAttribute("loginVO", resultVO);

						if (attributes != null) {
							attributes.setAttribute("loginVO", resultVO, RequestAttributes.SCOPE_SESSION);
						}

						// 약관 가져오기
						SiteStplatInfoVO searchVO = new SiteStplatInfoVO();

						searchVO.setUsrSeq(resultVO.getUsrSeq());
						searchVO.setSiteSeq(resultVO.getSiteSeq());
						searchVO.setStplatTyCode(Globals.ESSNTL_STPLAT_CODE_USRJOIN);

						List<SiteStplatInfoVO> resultList = cmmSbscrbService.selectSiteStplatList(searchVO);

						// 비교
						if (resultList != null) {

							boolean chk = true;

							if (resultList.size() > 0) {
								chk = false;
							}

							if (!chk) {
								loginService.modifyUsrPassFailLoginInit(loginVO);
								Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
								if (isAuthenticated.booleanValue()) {
									CmmLoginVO user = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
									uniqId = user.getUsrSeq();
									ip = request.getRemoteAddr();
									siteId = user.getSiteSeq();
									userTyId = user.getUsrtySeq();
									userId = user.getUserId();
								}

								LoginLog loginLog = new LoginLog();
								loginLog.setLoginId(uniqId);
								loginLog.setLoginIp(ip);
								loginLog.setLoginMthd("I"); // 로그인:I, 로그아웃:O
								loginLog.setErrOccrrAt("N");
								loginLog.setErrorCode("");
								loginLog.setSiteId(CmmSessionUtil.getSessionSiteSeq(request));
								loginLog.setUserTyId(userTyId);
								loginLog.setUserId(userId);
								loginLogService.logInsertLoginLog(loginLog);
								// 재동의페이지
								return CmmAjaxUtil.getAjaxReturn("stplatupdt");
							}
						}

					}
					SysMngrSiteAdiInfoVO adiInfoVO = new SysMngrSiteAdiInfoVO();
					adiInfoVO.setSiteSeq(resultVO.getSiteSeq());
					if (siteAdiInfoService.selectSiteAdiInfoDetail(adiInfoVO).getDupLoginAt() != null
							&& siteAdiInfoService.selectSiteAdiInfoDetail(adiInfoVO).getDupLoginAt().equals("N")) {
						EgovHttpSessionBindingListener listener = new EgovHttpSessionBindingListener();
						request.getSession().setAttribute(resultVO.getUserId(), listener);
					}

					UsrPrefcesVO upVO = new UsrPrefcesVO();
					upVO.setUsrPrefeCode(Globals.UPDTESTBSDE_PRE_CODE);
					upVO.setUsrMngrestbsCode(Globals.UPDTESTBSDE_MNG_CODE);

					int estbsDe = usrPrefcesService.selectUpdtEstbsMonth(upVO);

					int pwUpdtDe = Integer.parseInt(resultVO.getPwUpdtDe());

					if ((pwUpdtDe - (estbsDe * 30)) > 0) {

						Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
						if (isAuthenticated.booleanValue()) {
							CmmLoginVO user = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
							uniqId = user.getUsrSeq();
							ip = request.getRemoteAddr();
							siteId = user.getSiteSeq();
							userTyId = user.getUsrtySeq();
							userId = user.getUserId();
						}

						LoginLog loginLog = new LoginLog();
						loginLog.setLoginId(uniqId);
						loginLog.setLoginIp(ip);
						loginLog.setLoginMthd("I"); // 로그인:I, 로그아웃:O
						loginLog.setErrOccrrAt("N");
						loginLog.setErrorCode("");
						loginLog.setSiteId(CmmSessionUtil.getSessionSiteSeq(request));
						loginLog.setUserTyId(userTyId);
						loginLog.setUserId(userId);
						loginLogService.logInsertLoginLog(loginLog);
						return CmmAjaxUtil.getAjaxReturn("pwupdt");
					} else {
						Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
						if (isAuthenticated.booleanValue()) {
							CmmLoginVO user = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
							uniqId = user.getUsrSeq();
							ip = request.getRemoteAddr();
							siteId = user.getSiteSeq();
							userTyId = user.getUsrtySeq();
							userId = user.getUserId();
						}

						LoginLog loginLog = new LoginLog();
						loginLog.setLoginId(uniqId);
						loginLog.setLoginIp(ip);
						loginLog.setLoginMthd("I"); // 로그인:I, 로그아웃:O
						loginLog.setErrOccrrAt("N");
						loginLog.setErrorCode("");
						loginLog.setSiteId(CmmSessionUtil.getSessionSiteSeq(request));
						loginLog.setUserTyId(userTyId);
						loginLog.setUserId(userId);
						loginLogService.logInsertLoginLog(loginLog);

						return CmmAjaxUtil.getAjaxReturn("success");
					}
				}
			} else {

				LoginLog loginLog = new LoginLog();
				loginLog.setLoginId(uniqId);
				loginLog.setLoginIp(ip);
				loginLog.setLoginMthd("I"); // 로그인:I, 로그아웃:O
				loginLog.setErrOccrrAt("Y");
				loginLog.setErrorCode(loginVO.getPassword());
				loginLog.setSiteId(CmmSessionUtil.getSessionSiteSeq(request));
				loginLog.setUserTyId(userTyId);
				loginLog.setUserId(userId);
				loginLogService.logInsertLoginLog(loginLog);
				loginService.modifyUsrPassFailLoginCnt(loginVO);
				return CmmAjaxUtil.getAjaxReturn("fail");
			}
		} catch (NullPointerException e) {
			LOG.error("NullPointerException", e);

			LoginLog loginLog = new LoginLog();
			loginLog.setLoginId(uniqId);
			loginLog.setLoginIp(ip);
			loginLog.setLoginMthd("I"); // 로그인:I, 로그아웃:O
			loginLog.setErrOccrrAt("Y");
			loginLog.setErrorCode(loginVO.getPassword());
			loginLog.setSiteId(CmmSessionUtil.getSessionSiteSeq(request));
			loginLog.setUserTyId(userTyId);
			loginLog.setUserId(userId);
			loginLogService.logInsertLoginLog(loginLog);
			returnFailModel = CmmAjaxUtil.getAjaxReturn("fail");
		} catch (NumberFormatException e) {
			LOG.error("NumberFormatException", e);
			LoginLog loginLog = new LoginLog();
			loginLog.setLoginId(uniqId);
			loginLog.setLoginIp(ip);
			loginLog.setLoginMthd("I"); // 로그인:I, 로그아웃:O
			loginLog.setErrOccrrAt("Y");
			loginLog.setErrorCode(loginVO.getPassword());
			loginLog.setSiteId(CmmSessionUtil.getSessionSiteSeq(request));
			loginLog.setUserTyId(userTyId);
			loginLog.setUserId(userId);
			loginLogService.logInsertLoginLog(loginLog);
			returnFailModel = CmmAjaxUtil.getAjaxReturn("fail");
		} catch (SQLException e) {
			LOG.error("SQLException", e);
			LoginLog loginLog = new LoginLog();
			loginLog.setLoginId(uniqId);
			loginLog.setLoginIp(ip);
			loginLog.setLoginMthd("I"); // 로그인:I, 로그아웃:O
			loginLog.setErrOccrrAt("Y");
			loginLog.setErrorCode(loginVO.getPassword());
			loginLog.setSiteId(CmmSessionUtil.getSessionSiteSeq(request));
			loginLog.setUserTyId(userTyId);
			loginLog.setUserId(userId);
			loginLogService.logInsertLoginLog(loginLog);
			returnFailModel = CmmAjaxUtil.getAjaxReturn("fail");
		} catch (IllegalFormatException e) {
			LOG.error("IllegalFormatException", e);
			LoginLog loginLog = new LoginLog();
			loginLog.setLoginId(uniqId);
			loginLog.setLoginIp(ip);
			loginLog.setLoginMthd("I"); // 로그인:I, 로그아웃:O
			loginLog.setErrOccrrAt("Y");
			loginLog.setErrorCode(loginVO.getPassword());
			loginLog.setSiteId(CmmSessionUtil.getSessionSiteSeq(request));
			loginLog.setUserTyId(userTyId);
			loginLog.setUserId(userId);
			loginLogService.logInsertLoginLog(loginLog);
			returnFailModel = CmmAjaxUtil.getAjaxReturn("fail");
		} catch (ArrayIndexOutOfBoundsException e) {
			LOG.error("ArrayIndexOutOfBoundsException", e);
			LoginLog loginLog = new LoginLog();
			loginLog.setLoginId(uniqId);
			loginLog.setLoginIp(ip);
			loginLog.setLoginMthd("I"); // 로그인:I, 로그아웃:O
			loginLog.setErrOccrrAt("Y");
			loginLog.setErrorCode(loginVO.getPassword());
			loginLog.setSiteId(CmmSessionUtil.getSessionSiteSeq(request));
			loginLog.setUserTyId(userTyId);
			loginLog.setUserId(userId);
			loginLogService.logInsertLoginLog(loginLog);
			returnFailModel = CmmAjaxUtil.getAjaxReturn("fail");
		}

		if (returnFailModel == null) {
			returnFailModel = CmmAjaxUtil.getAjaxReturn("fail");
		}
		return returnFailModel;
	}

	@RequestMapping(value = { "/searchIdForm.do", "/{siteKey}/searchIdForm.do" })
	public String searchIdFormTemplt(
			@ModelAttribute("paramVO") CmmLoginVO paramVO, @ModelAttribute("sceVO") SbscrbCrtfcEstbsVO secVO,
			HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {

		model = recrtfcService.getCrtfcEstbsAndNiceModuleLogin(request, model, secVO);

		return "wzwg/cmm/mber/login/searchIdForm";
	}

	@RequestMapping(value = { "/cmm/mber/search/searchId.do", "/{siteKey}/cmm/mber/search/searchId.do" })
	public String searchId(@ModelAttribute("loginVO") CmmLoginVO loginVO, HttpServletRequest request, ModelMap model)
			throws Exception {

		loginVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));

		List<CmmLoginVO> resultList = loginService.selectSearchUserId(loginVO);

		if (resultList != null) {

			model.addAttribute("resultList", resultList);
			return "wzwg/cmm/mber/login/searchIdResult";
		} else {
			model.addAttribute("resultInfo", egovMessageSource.getMessage("fail.common.idsearch"));
			return "egovframework/com/uat/uia/EgovIdPasswordResult";
		}
	}

	@RequestMapping(value = { "/searchPwForm.do", "/{siteKey}/searchPwForm.do" })
	public String searchPwForm(
			@ModelAttribute("paramVO") CmmLoginVO paramVO, @ModelAttribute("sceVO") SbscrbCrtfcEstbsVO secVO,
			HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {

		model = recrtfcService.getCrtfcEstbsAndNiceModuleLogin(request, model, secVO);

		return "wzwg/cmm/mber/login/searchPwForm";
	}

	@RequestMapping(value = "pwUpdtForm.do")
	public String pwUpdtForm(
			@ModelAttribute("paramVO") CmmLoginVO paramVO, HttpServletRequest request, HttpServletResponse response,
			ModelMap model)
			throws Exception {

		return "wzwg/cmm/mber/login/pwUpdtForm";
	}

	@RequestMapping(value = { "/cmm/mber/search/searchPwCrtfcForm.do",
			"/{siteKey}/cmm/mber/search/searchPwCrtfcForm.do" })
	public String searchPwResultAjax(
			@ModelAttribute("paramVO") CmmLoginVO paramVO, HttpServletRequest request, HttpServletResponse response,
			ModelMap model)
			throws Exception {
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);

		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));

		String usrSeq = loginService.selectSearchUsrInfoCheck(paramVO);

		if (usrSeq != null) {
			paramVO.setUsrSeq(usrSeq);
			model.addAttribute("paramVO", paramVO);

			return "wzwg/cmm/mber/login/searchPwCrtfcForm";
		} else {
			model.addAttribute("retMsg", "fail.common.crtfc.error");
			return "forward:" + wzwgContext + "/searchPwForm.do";
		}
	}

	@RequestMapping(value = { "/cmm/mber/search/modifyPwForm.do", "/{siteKey}/cmm/mber/search/modifyPwForm.do" })
	public String modifyPwForm(
			@ModelAttribute("paramVO") CmmLoginVO paramVO, HttpServletRequest request, HttpServletResponse response,
			ModelMap model)
			throws Exception {

		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));

		int resultCnt = loginService.selectSiteUsrCrtfcCnt(paramVO);

		if (resultCnt > 0) {
			resultCnt = loginService.modifyPwUpdt(paramVO);

			model.addAttribute("resultCnt", resultCnt);
		}

		return "wzwg/cmm/mber/login/searchPwResult";
	}

	@RequestMapping(value = { "/modifyPwUpdtDe.do", "/{siteKey}/modifyPwUpdtDe.do" })
	public ModelAndView modifyPwUpdtDe(@ModelAttribute("loginVO") CmmLoginVO loginVO, HttpServletRequest request,
			HttpServletResponse response, ModelMap model)
			throws Exception {

		loginVO.setUsrSeq(CmmSessionUtil.getLoginVO().getUsrSeq());
		loginVO.setUserId(CmmSessionUtil.getSessionUserId());

		int resultCnt = loginService.modifyPwUpdtDe(loginVO);

		java.util.Enumeration params = request.getParameterNames();
		String usrlogParam = "";
		boolean bBadWord = false;
		while (params.hasMoreElements()) {
			String name = (String) params.nextElement();
			String value = dggb.util.StringUtils.nvl(request.getParameter(name), "");
			if (!name.startsWith("password") && !name.startsWith("hTel") && !name.startsWith("phone")) {
				usrlogParam = usrlogParam + "&" + name + "=" + value;
			}
		}
		usrlogParam = usrlogParam.substring(1);
		CmmLoginVO resultVO2 = new CmmLoginVO();
		SiteUsrLogVO siteUsrLogVO = new SiteUsrLogVO();
		siteUsrLogVO.setConectIp(request.getRemoteAddr());
		siteUsrLogVO.setFrstRegisterId(loginVO.getUserId());
		siteUsrLogVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		siteUsrLogVO.setUsrChngCode("SC00000449");
		String usrSeq = loginVO.getUsrSeq();
		siteUsrLogVO.setUsrlogParam(usrlogParam);
		siteUsrLogVO.setUsrlogUrl(request.getRequestURI());
		siteUsrLogVO.setUsrlogUsrSeq(usrSeq);
		siteUsrLogVO.setUsrSeq(usrSeq);
		siteUsrLogService.insertSiteUsrLog(siteUsrLogVO);

		return CmmAjaxUtil.getAjaxReturnCmmMap(resultCnt);
	}

	@RequestMapping(value = { "/modifyPwUpdt.do", "/{siteKey}/modifyPwUpdt.do" })
	public ModelAndView modifyPwUpdt(@ModelAttribute("loginVO") CmmLoginVO loginVO, HttpServletRequest request,
			HttpServletResponse response, ModelMap model)
			throws Exception {

		loginVO.setUsrSeq(CmmSessionUtil.getLoginVO().getUsrSeq());
		loginVO.setUserId(CmmSessionUtil.getSessionUserId());

		int resultCnt = loginService.modifyPwUpdt(loginVO);

		return CmmAjaxUtil.getAjaxReturnCmmMap(resultCnt);
	}

	@RequestMapping(value = { "/cmm/mber/login/mngrLoginForm.do", "/mngrLoginForm.do",
			"/{siteKey}/cmm/mber/login/mngrLoginForm.do", "/{siteKey}/mngrLoginForm.do" })
	public String mngrLoginForm(HttpServletRequest request, HttpServletResponse response, ModelMap model)
			throws Exception {
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		SysMngrSiteInfoVO siteInfoVO = new SysMngrSiteInfoVO();
		siteInfoVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		SysMngrSiteInfoVO siteInfo = siteInfoService.selectSiteInfoDetail(siteInfoVO);
		SiteMenuVO siteMenuVO = new SiteMenuVO();
		siteMenuVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		String topLogo = siteMenuService.selectSiteTopLogo(siteMenuVO);
		String url = "wzwg/cmm/mber/login/mngrLoginForm";
		boolean sadminAt = CmmSessionUtil.getSessionBooleanValue(request, "SADMIN_AT");
		boolean nadminAt = CmmSessionUtil.getSessionBooleanValue(request, "NADMIN_AT");
		if (sadminAt) {
			if (CmmSessionUtil.getSessionSysMngrAt(request)) {
				url = "redirect:" + wzwgContext + "/sysMngr/selectDashboardMain.do";
			} else {
				url = "redirect:" + wzwgContext + "/mngr/selectDashboardMain.do";
			}

		} else if (nadminAt && !CmmSessionUtil.getSessionSysMngrAt(request)) {
			url = "redirect:" + wzwgContext + "/mngr/selectDashboardMain.do";
		}

		model.addAttribute("mngrTopLogo", topLogo);
		model.addAttribute("mngrSiteNm", siteInfo.getSiteFullNm());
		return url;
	}

	private String getCrtfcReturn(ModelMap model, String errMsg, String siteGubun) {

		model.addAttribute("message", egovMessageSource.getMessage(errMsg));

		if ("N".equals(siteGubun)) {
			return "forward:" + Globals.URL_PREFIX + "/loginForm.do";
		} else {
			return "forward:" + Globals.URL_PREFIX + "/cmm/mber/login/mngrLoginForm.do";
		}
	}

	private String getLoginFailReturn(ModelMap model) {

		model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));

		return "forward:" + Globals.URL_PREFIX + "/cmm/mber/login/mngrLoginForm.do";
	}

	@Resource(name = "MngrAuthService")
	private MngrAuthService mngrAuthService;

	@RequestMapping(value = "/**/cmm/mber/login/actionMngrLogin.do")
	public String actionMngrLogin(@ModelAttribute("loginVO") CmmLoginVO loginVO, HttpServletRequest request,
			HttpServletResponse response, HttpSession session, ModelMap model)
			throws Exception {
		String uniqId = "";
		String ip = request.getRemoteAddr();
		String siteId = "";
		String userTyId = "";
		String userId = loginVO.getUserId();

		try {

			String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);

			loginVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));

			CmmLoginVO bassUsrVO = loginService.actionUsrinfoChk(loginVO);

			String passFailCnt = EgovProperties.getProperty("pass.fail.cnt");
			;
			String passFailDiff = EgovProperties.getProperty("pass.fail.diff");
			;
			loginVO.setPassFailDiff(passFailCnt);
			loginVO.setPassFailCnt(passFailDiff);

			String passFailYn = loginService.selectPassFailYn(loginVO);

			if (passFailYn != null && passFailYn.equals("Y")) {
				// ;
				String sessionLang = CmmSessionUtil.getSessionValue(request, "LANG");
				String useLangCode = Globals.USE_LANG(sessionLang);
				String[] passFailStr = { passFailCnt, passFailDiff };
				model.addAttribute("message",
						egovMessageSource.getMessage("wzwg.cmm.cmmMsg.CMG036", passFailStr, new Locale(useLangCode)));
				wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(hreq);
				return "forward:" + wzwgContext + Globals.URL_PREFIX + "/cmm/mber/login/mngrLoginForm.do";
			}
			String siteGubun = "M";

			if (bassUsrVO != null) {

				if (!"".equals(bassUsrVO.getErrMsg())) {
					/* Authenticated */
					Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
					if (isAuthenticated.booleanValue()) {
						CmmLoginVO user = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
						uniqId = user.getUsrSeq();
						siteId = user.getSiteSeq();
						userTyId = user.getUsrtySeq();
					}
					LoginLog loginLog = new LoginLog();
					loginLog.setLoginId(uniqId);
					loginLog.setLoginIp(ip);
					loginLog.setLoginMthd("I"); // 로그인:I, 로그아웃:O
					loginLog.setErrOccrrAt("Y");
					loginLog.setErrorCode(loginVO.getPassword());
					loginLog.setSiteId(CmmSessionUtil.getSessionSiteSeq(request));
					loginLog.setUserTyId(userTyId);
					loginLog.setUserId(userId);
					loginLog.setConectTy("M");
					loginLogService.logInsertLoginLog(loginLog);
					loginService.modifyUsrPassFailLoginCnt(loginVO);
					return getCrtfcReturn(model, bassUsrVO.getErrMsg(), siteGubun);
				}

				boolean sAdminChk = (Globals.AUTH_SUPER_ADMIN.equals(bassUsrVO.getUsrtySeq())) ? true : false;

				RequestAttributes attributes = RequestContextHolder.getRequestAttributes();

				if (sAdminChk) {
					SysMngrSiteInfoVO siteInfoVO = new SysMngrSiteInfoVO();
					siteInfoVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
					SysMngrSiteInfoVO siteInfo = siteInfoService.selectSiteInfoDetail(siteInfoVO);
					SiteMenuVO siteMenuVO = new SiteMenuVO();
					siteMenuVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
					String topLogo = siteMenuService.selectSiteTopLogo(siteMenuVO);

					if (attributes != null) {
						attributes.setAttribute("SADMIN_AT", sAdminChk, RequestAttributes.SCOPE_SESSION);
						attributes.setAttribute("NADMIN_AT", false, RequestAttributes.SCOPE_SESSION);
					}

					request.getSession().setAttribute("loginVO", bassUsrVO);

					if (attributes != null) {
						attributes.setAttribute("loginVO", bassUsrVO, RequestAttributes.SCOPE_SESSION);
					}

					session.setAttribute("mngrSiteNm", siteInfo.getSiteFullNm());
					session.setAttribute("mngrTopLogo", topLogo);

					UsrPrefcesVO upVO = new UsrPrefcesVO();
					upVO.setUsrPrefeCode(Globals.DUPLOGIN_PRE_CODE);

					String dupLoginChk = usrPrefcesService.selectDupLoginChk(upVO);
					if (dupLoginChk.equals("N")) {
						EgovHttpSessionBindingListener listener = new EgovHttpSessionBindingListener();
						request.getSession().setAttribute(bassUsrVO.getUserId(), listener);
					}
					/* Authenticated */
					Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
					if (isAuthenticated.booleanValue()) {
						CmmLoginVO user = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
						uniqId = user.getUsrSeq();
						siteId = user.getSiteSeq();
						userTyId = user.getUsrtySeq();
					}

					LoginLog loginLog = new LoginLog();
					loginLog.setLoginId(uniqId);
					loginLog.setLoginIp(ip);
					loginLog.setLoginMthd("I"); // 로그인:I, 로그아웃:O
					loginLog.setErrOccrrAt("N");
					loginLog.setErrorCode("");
					loginLog.setSiteId(CmmSessionUtil.getSessionSiteSeq(request));
					loginLog.setUserTyId(userTyId);
					loginLog.setUserId(userId);
					loginLog.setConectTy("M");
					loginLogService.logInsertLoginLog(loginLog);
					loginService.modifyUsrPassFailLoginCnt(loginVO);
					return "redirect:" + wzwgContext + Globals.URL_PREFIX + "/cmm/mber/login/actionMngrMain.do";
				} else {

					boolean nAdminChk = (Globals.AUTH_NORMAL_ADMIN.equals(bassUsrVO.getUsrtySeq())) ? true : false;

					if (nAdminChk) {
						loginVO.setUsrSeq(bassUsrVO.getUsrSeq());

						CmmLoginVO siteUsrVO = loginService.selectSiteUsrinfo(loginVO);

						if (siteUsrVO != null) {

							if (!"".equals(siteUsrVO.getErrMsg())) {

								return getCrtfcReturn(model, siteUsrVO.getErrMsg(), siteGubun);
							}

							MngrAuthVO mngrAuthVO = new MngrAuthVO();
							mngrAuthVO.setSiteSeq(siteUsrVO.getSiteSeq());
							mngrAuthVO.setUsrSeq(siteUsrVO.getUsrSeq());
							List<MngrAuthVO> mngrAuthList = mngrAuthService.selectMngrConAuthUsr(mngrAuthVO);
							siteUsrVO.setMngrAuthList(mngrAuthList);

							if (attributes != null) {
								attributes.setAttribute("SADMIN_AT", false, RequestAttributes.SCOPE_SESSION);
								attributes.setAttribute("NADMIN_AT", nAdminChk, RequestAttributes.SCOPE_SESSION);
							}

							SysMngrSiteInfoVO siteInfoVO = new SysMngrSiteInfoVO();
							siteInfoVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
							SysMngrSiteInfoVO siteInfo = siteInfoService.selectSiteInfoDetail(siteInfoVO);
							SiteMenuVO siteMenuVO = new SiteMenuVO();
							siteMenuVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
							String topLogo = siteMenuService.selectSiteTopLogo(siteMenuVO);

							request.getSession().setAttribute("loginVO", siteUsrVO);

							if (attributes != null) {
								attributes.setAttribute("loginVO", siteUsrVO, RequestAttributes.SCOPE_SESSION);
							}

							session.setAttribute("mngrSiteNm", siteInfo.getSiteFullNm());
							session.setAttribute("mngrTopLogo", topLogo);

							UsrPrefcesVO upVO = new UsrPrefcesVO();
							upVO.setUsrPrefeCode(Globals.DUPLOGIN_PRE_CODE);
							String dupLoginChk = usrPrefcesService.selectDupLoginChk(upVO);
							if (dupLoginChk.equals("N")) {
								EgovHttpSessionBindingListener listener = new EgovHttpSessionBindingListener();
								request.getSession().setAttribute(siteUsrVO.getUserId(), listener);
							}
							Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
							if (isAuthenticated.booleanValue()) {
								CmmLoginVO user = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
								uniqId = user.getUsrSeq();
								siteId = user.getSiteSeq();
								userTyId = user.getUsrtySeq();
							}

							LoginLog loginLog = new LoginLog();
							loginLog.setLoginId(uniqId);
							loginLog.setLoginIp(ip);
							loginLog.setLoginMthd("I"); // 로그인:I, 로그아웃:O
							loginLog.setErrOccrrAt("N");
							loginLog.setErrorCode("");
							loginLog.setSiteId(CmmSessionUtil.getSessionSiteSeq(request));
							loginLog.setUserTyId(userTyId);
							loginLog.setUserId(userId);
							loginLog.setConectTy("M");
							loginLogService.logInsertLoginLog(loginLog);
							loginService.modifyUsrPassFailLoginInit(bassUsrVO);
							return "redirect:" + wzwgContext + Globals.URL_PREFIX + "/cmm/mber/login/actionMngrMain.do";
						} else {
							LoginLog loginLog = new LoginLog();
							loginLog.setLoginId(uniqId);
							loginLog.setLoginIp(ip);
							loginLog.setLoginMthd("I"); // 로그인:I, 로그아웃:O
							loginLog.setErrOccrrAt("Y");
							loginLog.setErrorCode(loginVO.getPassword());
							loginLog.setSiteId(CmmSessionUtil.getSessionSiteSeq(request));
							loginLog.setUserTyId(userTyId);
							loginLog.setUserId(userId);
							loginLog.setConectTy("M");
							loginLogService.logInsertLoginLog(loginLog);
							return getLoginFailReturn(model);
						}
					} else {
						LoginLog loginLog = new LoginLog();
						loginLog.setLoginId(uniqId);
						loginLog.setLoginIp(ip);
						loginLog.setLoginMthd("I"); // 로그인:I, 로그아웃:O
						loginLog.setErrOccrrAt("Y");
						loginLog.setErrorCode(loginVO.getPassword());
						loginLog.setSiteId(CmmSessionUtil.getSessionSiteSeq(request));
						loginLog.setUserTyId(userTyId);
						loginLog.setUserId(userId);
						loginLog.setConectTy("M");
						loginLogService.logInsertLoginLog(loginLog);
						return getLoginFailReturn(model);
					}
				}

			} else {
				LoginLog loginLog = new LoginLog();
				loginLog.setLoginId(uniqId);
				loginLog.setLoginIp(ip);
				loginLog.setLoginMthd("I"); // 로그인:I, 로그아웃:O
				loginLog.setErrOccrrAt("Y");
				loginLog.setErrorCode(loginVO.getPassword());
				loginLog.setSiteId(siteId);
				loginLog.setUserTyId(userTyId);
				loginLog.setUserId(CmmSessionUtil.getSessionSiteSeq(request));
				loginLog.setConectTy("M");
				loginLogService.logInsertLoginLog(loginLog);
				loginService.modifyUsrPassFailLoginCnt(loginVO);
				return getLoginFailReturn(model);
			}
		} catch (NullPointerException e) {
			LOG.error("NullPointerException", e);
		} catch (NumberFormatException e) {
			LOG.error("NumberFormatException", e);
		} catch (SQLException e) {
			LOG.error("SQLException", e);
		} catch (IllegalFormatException e) {
			LOG.error("IllegalFormatException", e);
		} catch (ArrayIndexOutOfBoundsException e) {
			LOG.error("ArrayIndexOutOfBoundsException", e);
		}
		LoginLog loginLog = new LoginLog();
		loginLog.setLoginId(uniqId);
		loginLog.setLoginIp(ip);
		loginLog.setLoginMthd("I"); // 로그인:I, 로그아웃:O
		loginLog.setErrOccrrAt("Y");
		loginLog.setErrorCode(loginVO.getPassword());
		loginLog.setSiteId(CmmSessionUtil.getSessionSiteSeq(request));
		loginLog.setUserTyId(userTyId);
		loginLog.setUserId(userId);
		loginLog.setConectTy("M");
		loginLogService.logInsertLoginLog(loginLog);
		return getLoginFailReturn(model);
	}

	@RequestMapping("/**/cmm/mber/login/actionMngrMain.do")
	public String actionMain(HttpServletRequest request, ModelMap model)
			throws Exception {

		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
		if (!isAuthenticated) {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "egovframework/com/uat/uia/EgovLoginUsr";
		}

		return CmmReturnUtil.returnMainPage(request);
	}

	@RequestMapping(value = { "/**/cmm/mber/login/actionMngrLogout.do", "/actionLogout.do",
			"/{siteKey}/actionLogout.do" })
	public String actionLogout(HttpSession session, HttpServletRequest request, ModelMap model)
			throws Exception {
		String retUrl = "";
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		String uniqId = "";
		String ip = request.getRemoteAddr();
		String siteId = CmmSessionUtil.getSessionSiteSeq(request);
		String userTyId = "";
		String userId = "";
		Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();

		boolean sAdminChk = false;
		boolean nAdminChk = false;

		if (isAuthenticated.booleanValue()) {
			CmmLoginVO user = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			uniqId = user.getUsrSeq();
			userTyId = user.getUsrtySeq();
			userId = user.getUserId();

			sAdminChk = (Globals.AUTH_SUPER_ADMIN.equals(user.getUsrtySeq())) ? true : false;
			nAdminChk = (Globals.AUTH_NORMAL_ADMIN.equals(user.getUsrtySeq())) ? true : false;
		}

		LoginLog loginLog = new LoginLog();
		loginLog.setLoginId(uniqId);
		loginLog.setLoginIp(ip);
		loginLog.setLoginMthd("O"); // 로그인:I, 로그아웃:O
		loginLog.setErrOccrrAt("N");
		loginLog.setErrorCode("");
		loginLog.setSiteId(siteId);
		loginLog.setUserTyId(userTyId);
		loginLog.setUserId(userId);
		if (sAdminChk || nAdminChk) {
			loginLog.setConectTy("M");
		}
		loginLogService.logInsertLoginLog(loginLog);
		try {
			CmmSessionUtil.setSessionValue(request, "loginVO", null);
			session.removeAttribute("loginVO");
			session.removeAttribute("SADMIN_AT");
			session.removeAttribute("NADMIN_AT");
			session.removeAttribute("SYSMNGR_AT");
			session.removeAttribute("subSiteMngr");
			session.invalidate();

			RequestAttributes attributes = RequestContextHolder.getRequestAttributes();

			if (attributes != null) {
				attributes.removeAttribute("loginVO", RequestAttributes.SCOPE_SESSION);
				attributes.removeAttribute("SADMIN_AT", RequestAttributes.SCOPE_SESSION);
				attributes.removeAttribute("NADMIN_AT", RequestAttributes.SCOPE_SESSION);
				attributes.removeAttribute("SYSMNGR_AT", RequestAttributes.SCOPE_SESSION);
				attributes.removeAttribute("subSiteMngr", RequestAttributes.SCOPE_SESSION);
			}

			retUrl = CmmReturnUtil.returnMainPage(request);
			String globalMainPage = "redirect:" + wzwgContext + Globals.MAIN_PAGE;
			if (globalMainPage.replaceAll("redirect:", "").indexOf(retUrl.replaceAll("redirect:", "")) > 1) {
				String referer = request.getHeader("referer");
				if (referer != null) {
					if (referer.indexOf("/module/cmnt/") > -1) {

					} else if (referer.indexOf("/cmm/mber/myPage/") > -1) {
						retUrl = "redirect:" + wzwgContext + "/loginForm.do";
					} else {
						String result = referer.replaceAll("(?i:https?://([^/]+)/.*)", "$1");
						result = referer.substring(referer.indexOf(result) + result.length());
						// referer 가 도메인으로 오면 해당부분은 삭제한다 2019.03.25 추가 조원권 //로그아웃을 외부 도메인에서 실행하지는 않을듯

						retUrl = "redirect:" + result;
					}
				}
			}
		} catch (NullPointerException e) {
			LOG.error("NullPointerException", e);
		} catch (NumberFormatException e) {
			LOG.error("NumberFormatException", e);
		} catch (IllegalFormatException e) {
			LOG.error("IllegalFormatException", e);
		} catch (ArrayIndexOutOfBoundsException e) {
			LOG.error("ArrayIndexOutOfBoundsException", e);
		}
		if (!wzwgContext.equals("") && retUrl.indexOf(wzwgContext) < 0) {
			retUrl = "redirect:" + wzwgContext + retUrl.replaceAll("redirect:", "");
		}
		return retUrl;
	}

	@RequestMapping(value = "/**/cmm/mber/login/selectUsrSnsCnfirm.do")
	public ModelAndView selectUsrSnsCnfirm(
			@RequestParam(value = "snsCrtfcId", required = false) String snsCrtfcId,
			@RequestParam(value = "snsCrtfcSe", required = false) String snsCrtfcSe, HttpServletRequest request,
			ModelMap model) throws Exception {

		CmmLoginVO loginVO = new CmmLoginVO();

		loginVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		loginVO.setSnsCrtfcId(snsCrtfcId);
		loginVO.setSnsCrtfcSe(snsCrtfcSe);

		String result = StringUtils.defaultString((String) loginService.selectUsrSnsCnfirm(loginVO));

		return CmmAjaxUtil.getAjaxReturn(result);
	}

	@RequestMapping(value = "/**/cmm/mber/login/naverCrtfcAjax.do")
	public String naverCrtfc(@ModelAttribute("paramVO") CmmSbscrbVO paramVO, HttpServletRequest request,
			HttpSession session, ModelMap model) throws Exception {

		// SecureRandom random = new SecureRandom();
		//
		// String state = new BigInteger(150, random).toString(32);
		//
		// model.addAttribute("naver_state", state);
		if (request.getParameter("code") != null && request.getParameter("state") != null) {
			String usrProfile = naverAPIService.getUserProfile(session, naverAPIService.getAccessToken(session,
					request.getParameter("code").toString(), request.getParameter("state").toString()));
			JSONParser jsonParser = new JSONParser();

			org.json.simple.JSONObject jsonObject = (org.json.simple.JSONObject) jsonParser.parse(usrProfile);
			String id = StringUtils
					.defaultString((String) ((org.json.simple.JSONObject) jsonObject.get("response")).get("id"));
			paramVO.setCrtfctSeCode("SC00000433");
			paramVO.setCrtfctDn(id);
			model.addAttribute("paramVO", paramVO);
		}

		return "wzwg/cmm/mber/login/callback/naverCrtfc";
	}

	@RequestMapping(value = "/**/cmm/mber/login/kakaoCrtfcAjax.do")
	public String kakaoCrtfc(@ModelAttribute("paramVO") CmmSbscrbVO paramVO, HttpServletRequest request,
			HttpSession session, ModelMap model) throws Exception {
		KakaoRestApiHelper kakaoApiHelper = new KakaoRestApiHelper();
		kakaoApiHelper.setAccessToken(kakaoApiHelper.getPushTokens(request.getParameter("code")));
		String usrProfile = kakaoApiHelper.me();
		JSONParser jsonParser = new JSONParser();

		org.json.simple.JSONObject jsonObject = (org.json.simple.JSONObject) jsonParser.parse(usrProfile);
		String id = StringUtils.defaultString(String.valueOf((Long) jsonObject.get("id")));
		paramVO.setCrtfctSeCode("SC00000434");
		paramVO.setCrtfctDn(id);

		String kakaoLoginYn = null;

		if (session.getAttribute("kakaoLoginYn") != null) {
			kakaoLoginYn = session.getAttribute("kakaoLoginYn").toString();
		}

		if (kakaoLoginYn != null && kakaoLoginYn.equals("N")) {
			String name = StringUtils.defaultString(
					(String) ((org.json.simple.JSONObject) jsonObject.get("properties")).get("nickname"));
			paramVO.setCrtfc_name(name);
		}
		model.addAttribute("kakaoLoginYn", kakaoLoginYn);
		session.removeAttribute("kakaoLoginYn");
		// SecureRandom random = new SecureRandom();
		//
		// String state = new BigInteger(150, random).toString(32);
		//
		// model.addAttribute("naver_state", state);

		return "wzwg/cmm/mber/login/callback/kakaoCrtfc";
	}

	@RequestMapping(value = "/**/cmm/mber/login/googleCrtfcAjax.do")
	public String googleCrtfc(@ModelAttribute("paramVO") CmmSbscrbVO paramVO, HttpServletRequest request,
			HttpSession session, ModelMap model, HttpServletResponse response) throws Exception {
		// String usrProfile =
		// googleAPIService.getUserProfile(googleAPIService.getAccessToken(request.getParameter("code").toString()));
		String usrProfile = googleAPIService.getUserProfile(request);

		JSONParser jsonParser = new JSONParser();

		org.json.simple.JSONObject jsonObject = (org.json.simple.JSONObject) jsonParser.parse(usrProfile);
		String id = StringUtils.defaultString((String) jsonObject.get("sub"));
		paramVO.setCrtfctSeCode("SC00000436");
		paramVO.setCrtfctDn(id);

		String googleLoginYn = null;

		if (session.getAttribute("googleLoginYn") != null) {
			googleLoginYn = session.getAttribute("googleLoginYn").toString();
		}

		if (googleLoginYn != null && googleLoginYn.equals("N")) {
			String name = StringUtils.defaultString((String) jsonObject.get("name"));
			paramVO.setCrtfc_name(name);
		}

		model.addAttribute("googleLoginYn", googleLoginYn);
		session.removeAttribute("googleLoginYn");

		return "wzwg/cmm/mber/login/callback/googleCrtfc";
	}

	// @RequestMapping(value="/searchIdResultAjax.do")
	// public String searchIdResultAjax(
	// @ModelAttribute("paramVO") CmmLoginVO paramVO
	// , HttpServletRequest request
	// , HttpServletResponse response
	// , ModelMap model)
	// throws Exception {
	//
	// CmmLoginVO resultVO = loginService.selectSearchUserId(paramVO);
	// model.addAttribute("resultVO", resultVO);
	//
	// return "wzwg/cmm/mber/login/searchIdResult";
	// }
}