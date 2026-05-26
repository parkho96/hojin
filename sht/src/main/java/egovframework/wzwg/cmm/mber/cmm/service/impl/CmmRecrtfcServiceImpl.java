package egovframework.wzwg.cmm.mber.cmm.service.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.cmmn.exception.EgovBizException;
import org.springframework.stereotype.Service;
import org.springframework.ui.ModelMap;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.wzwg.cmm.crtfc.CmmNiceCrtfcUtil;
import egovframework.wzwg.cmm.mber.cmm.service.CmmRecrtfcService;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.mber.login.service.impl.CmmLoginDAO;
import egovframework.wzwg.cmm.util.snsAPI.service.FacebookAPIService;
import egovframework.wzwg.cmm.util.snsAPI.service.GoogleAPIService;
import egovframework.wzwg.cmm.util.snsAPI.service.KakaoRestApiHelper;
import egovframework.wzwg.cmm.util.snsAPI.service.NaverAPIService;
import egovframework.wzwg.site.mngr.usrMngr.sbscrbCrtfcEstbs.service.SbscrbCrtfcEstbsService;
import egovframework.wzwg.site.mngr.usrMngr.sbscrbCrtfcEstbs.service.SbscrbCrtfcEstbsVO;
import egovframework.wzwg.sysMngr.siteMngr.snsKeyMngr.service.SnsKeyMngrService;
import egovframework.wzwg.sysMngr.siteMngr.snsKeyMngr.service.SnsKeyMngrVO;
import egovframework.wzwg.sysMngr.usrPrefces.service.UsrPrefcesVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("CmmRecrtfcService")
public class CmmRecrtfcServiceImpl extends EgovAbstractServiceImpl implements CmmRecrtfcService {

	@Resource(name = "egovMessageSource")
	private EgovMessageSource egovMessageSource;

	@Resource(name = "CmmRecrtfcDAO")
	private CmmRecrtfcDAO recrtfcDAO;

	@Resource(name = "CmmLoginDAO")
	private CmmLoginDAO loginDAO;

	@Resource(name = "SbscrbCrtfcEstbsService")
	private SbscrbCrtfcEstbsService sbscrbCrtfcEstbsService;

	@Resource(name = "NaverAPIService")
	private NaverAPIService naverAPIService;

	@Resource(name = "GoogleAPIService")
	private GoogleAPIService GoogleAPIService;

	@Resource(name = "FacebookAPIService")
	private FacebookAPIService facebookAPIService;

	@Resource(name = "SnsKeyMngrService")
	protected SnsKeyMngrService snsKeyMngrService;

	public ModelMap getCrtfcEstbsAndNiceModule(HttpServletRequest request, ModelMap model, SbscrbCrtfcEstbsVO secVO) {
		String grpcode = Globals.USR_CRTFC_PREFE;

		List<UsrPrefcesVO> crtfcEstbsList = sbscrbCrtfcEstbsService.selectCrtfcEstbsList(grpcode);

		model.addAttribute("crtfcEstbsList", crtfcEstbsList);

		List<SbscrbCrtfcEstbsVO> usrTyCrtfcList = sbscrbCrtfcEstbsService.selectSbscrbCrtfcEstbsByUsrTy(secVO);

		model.addAttribute("usrTyCrtfcList", usrTyCrtfcList);

		HashMap<String, String> niceCrtfcKeyMap = CmmNiceCrtfcUtil.getNiceCrtfcKey(request);

		model.addAttribute("niceCrtfcKeyMap", niceCrtfcKeyMap);

		HttpSession session = request.getSession();
		for (int i = 0; i < usrTyCrtfcList.size(); i++) {
			String snsTyCode = "";
			if (usrTyCrtfcList.get(i).getUcrtfcEstbsCode() != null) {
				snsTyCode = usrTyCrtfcList.get(i).getUcrtfcEstbsCode();
			}
			if (snsTyCode.equals("SC00000433")) {
				/* 네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출 */
				String naverAuthUrl = naverAPIService.getAuthorizationUrl(session);
				// 세션 또는 별도의 저장 공간에 상태 토큰을 저장
				model.addAttribute("naverAuthUrl", naverAuthUrl);
			}

			if (snsTyCode.equals("SC00000434")) {
				KakaoRestApiHelper kakaoApiHelper = new KakaoRestApiHelper();

				String siteUrl = request.getRequestURL().toString().replaceAll(request.getRequestURI(), "");
				siteUrl = siteUrl + "/cmm/mber/login/kakaoCrtfcAjax.do";
				SnsKeyMngrVO paramVO = new SnsKeyMngrVO();
				paramVO.setSnsTyCode("SC00000434");
				if (session.getAttribute("SITE_SEQ") != null) {
					paramVO.setSiteSeq(session.getAttribute("SITE_SEQ").toString());
				}

				try {
					SnsKeyMngrVO snsKeyMngrVO = snsKeyMngrService.selectSnsKeyMngr(paramVO);
					if (snsKeyMngrVO != null) {
						kakaoApiHelper.setClientId(snsKeyMngrVO.getClientId());
					}
				} catch (SQLException e) {
					log.error("SQLException", e);
				}
				session.setAttribute("kakaoLoginYn", "N");
				// 세션 또는 별도의 저장 공간에 상태 토큰을 저장
				model.addAttribute("kakaoAuthUrl", kakaoApiHelper.signup());
				model.addAttribute("kakaoClientId", kakaoApiHelper.getClientId());
				model.addAttribute("kakaoRedirectUrl", siteUrl);
			}

			if (snsTyCode.equals("SC00000436")) {
				/* 네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출 */
				String googleAuthUrl = GoogleAPIService.getAuthorizationUrl(session);
				// 세션 또는 별도의 저장 공간에 상태 토큰을 저장
				session.setAttribute("googleLoginYn", "N");
				model.addAttribute("googleAuthUrl", googleAuthUrl);
			}
		}

		//
		// /* 네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출 */
		// String googleAuthUrl = GoogleAPIService.getAuthorizationUrl(session);
		//
		// // 세션 또는 별도의 저장 공간에 상태 토큰을 저장
		// model.addAttribute("googleAuthUrl", googleAuthUrl);
		//
		// /* 네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출 */
		// String facebookAuthUrl = facebookAPIService.getAuthorizationUrl(session);
		//
		// // 세션 또는 별도의 저장 공간에 상태 토큰을 저장
		// model.addAttribute("facebookAuthUrl", facebookAuthUrl);
		//

		return model;
	}

	public ModelMap getCrtfcEstbsAndNiceModuleLogin(HttpServletRequest request, ModelMap model,
			SbscrbCrtfcEstbsVO secVO) {
		String grpcode = Globals.USR_CRTFC_PREFE;

		List<UsrPrefcesVO> crtfcEstbsList = sbscrbCrtfcEstbsService.selectCrtfcEstbsList(grpcode);

		model.addAttribute("crtfcEstbsList", crtfcEstbsList);

		// List<SbscrbCrtfcEstbsVO> usrTyCrtfcList =
		// sbscrbCrtfcEstbsService.selectSbscrbCrtfcEstbsByUsrTy(secVO);

		// model.addAttribute("usrTyCrtfcList", usrTyCrtfcList);

		HttpSession session = request.getSession();
		for (int i = 0; i < crtfcEstbsList.size(); i++) {
			String snsTyCode = "";
			if (crtfcEstbsList.get(i).getUsrMngrestbsCode() != null) {
				snsTyCode = crtfcEstbsList.get(i).getUsrMngrestbsCode();
			}

			if (snsTyCode.equals("SC00000306")) {
				/* 네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출 */
				HashMap<String, String> niceCrtfcKeyMap = CmmNiceCrtfcUtil.getNiceCrtfcKey(request);

				model.addAttribute("niceCrtfcKeyMap", niceCrtfcKeyMap);
			}

			if (snsTyCode.equals("SC00000433")) {
				/* 네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출 */
				String naverAuthUrl = naverAPIService.getAuthorizationUrl(session);
				// 세션 또는 별도의 저장 공간에 상태 토큰을 저장
				model.addAttribute("naverAuthUrl", naverAuthUrl);
			}

			if (snsTyCode.equals("SC00000434")) {
				KakaoRestApiHelper kakaoApiHelper = new KakaoRestApiHelper();

				String siteUrl = request.getRequestURL().toString().replaceAll(request.getRequestURI(), "");
				siteUrl = siteUrl + "/cmm/mber/login/kakaoCrtfcAjax.do";
				SnsKeyMngrVO paramVO = new SnsKeyMngrVO();
				paramVO.setSnsTyCode("SC00000434");

				if (session.getAttribute("SITE_SEQ") != null) {
					paramVO.setSiteSeq(session.getAttribute("SITE_SEQ").toString());
				}

				try {
					SnsKeyMngrVO snsKeyMngrVO = snsKeyMngrService.selectSnsKeyMngr(paramVO);
					if (snsKeyMngrVO != null) {
						kakaoApiHelper.setClientId(snsKeyMngrVO.getClientId());
					}
				} catch (SQLException e) {
					log.error("SQLException", e);
				}
				session.setAttribute("kakaoLoginYn", "Y");
				// 세션 또는 별도의 저장 공간에 상태 토큰을 저장
				model.addAttribute("kakaoAuthUrl", kakaoApiHelper.signup());
				model.addAttribute("kakaoClientId", kakaoApiHelper.getClientId());
				model.addAttribute("kakaoRedirectUrl", siteUrl);
			}

			if (snsTyCode.equals("SC00000436")) {
				/* 네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출 */
				String googleAuthUrl = GoogleAPIService.getAuthorizationUrl(session);
				session.setAttribute("googleLoginYn", "Y");
				// 세션 또는 별도의 저장 공간에 상태 토큰을 저장
				model.addAttribute("googleAuthUrl", googleAuthUrl);
			}
		}

		//
		// /* 네아로 인증 URL을 생성하기 위하여 getAuthorizationUrl을 호출 */
		// String facebookAuthUrl = facebookAPIService.getAuthorizationUrl(session);
		//
		// // 세션 또는 별도의 저장 공간에 상태 토큰을 저장
		// model.addAttribute("facebookAuthUrl", facebookAuthUrl);
		//

		return model;
	}

	public CmmLoginVO selectSiteUsrInfo(CmmLoginVO loginVO) throws Exception {

		String enpassword = EgovFileScrty.encryptPassword(loginVO.getPassword());
		loginVO.setPassword(enpassword);

		return loginDAO.actionLogin(loginVO);
	}

	public int updateRecrtfc(CmmLoginVO loginVO) throws Exception {

		int result = recrtfcDAO.modifyUsrSttusCode(loginVO);

		if (result > 0) {
			result = recrtfcDAO.modifySiteUsrSttusCode(loginVO);

			if (result < 1) {
				throw new EgovBizException();
			}
		}

		return result;
	}

	public String selectUserIdByCrtfctSeCd(String userId) throws Exception {
		return recrtfcDAO.selectUserIdByCrtfctSeCd(userId);
	}

	public int selectUsrCrtfctCnt(CmmLoginVO loginVO) throws Exception {
		return recrtfcDAO.selectUsrCrtfctCnt(loginVO);
	}
}
