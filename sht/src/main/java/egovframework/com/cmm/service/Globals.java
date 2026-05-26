package egovframework.com.cmm.service;

/**
 * Class Name : Globals.java
 * Description : 시스템 구동 시 프로퍼티를 통해 사용될 전역변수를 정의한다.
 * Modification Information
 * 
 * 수정일 수정자 수정내용
 * ------- -------- ---------------------------
 * 2009.01.19 박지욱 최초 생성
 * 
 * @author 공통 서비스 개발팀 박지욱
 * @since 2009. 01. 19
 * @version 1.0
 * @see
 * 
 */

public class Globals {
	public static final String ORIGIN_FILE_NM = "originalFileName";
	public static final String FILE_EXT = "fileExtension";
	public static final String FILE_SIZE = "fileSize";
	public static final String UPLOAD_FILE_NM = "uploadFileName";
	public static final String FILE_PATH = "filePath";

	public static final String OS_TYPE = EgovProperties.getProperty("Globals.OsType");
	public static final String DB_TYPE = EgovProperties.getProperty("Globals.DbType");
	public static final String MAIN_PAGE = EgovProperties.getProperty("Globals.MainPage");
	public static final String MNGR_MAIN_PAGE = EgovProperties.getProperty("Globals.MngrMainPage");
	public static final String URL_PREFIX = EgovProperties.getProperty("Globals.urlPrefix");
	public static final String PREFIX = EgovProperties.getProperty("Globals.prefix");
	public static final String SYSMNGR_PREFIX = EgovProperties.getProperty("Globals.sysMngrPrefix");
	public static final String MNGR_PREFIX = EgovProperties.getProperty("Globals.mngrPrefix");
	public static final String USR_STTUS_CRTFC_CODE = EgovProperties.getProperty("Globals.usrSttusCrtfcCode");
	public static final String USR_STTUS_QUIT_CODE = EgovProperties.getProperty("Globals.usrSttusQuitCode");
	public static final String USR_STTUS_STOP_CODE = EgovProperties.getProperty("Globals.usrSttusStopCode");
	public static final String BBS_MODULE_TY_CODE = EgovProperties.getProperty("Globals.bbsModuleTyCode");
	public static final String NOMAL_MODULE_TY_CODE = EgovProperties.getProperty("Globals.nomalModuleTyCode");
	public static final String SCHDUL_MODULE_TY_CODE = EgovProperties.getProperty("Globals.schdulModuleTyCode");
	public static final String API_MODULE_TY_CODE = EgovProperties.getProperty("Globals.apiModuleTyCode");
	public static final String BBS_FORM_USE_BBS_SEQ = EgovProperties.getProperty("Globals.bbsFormUseBbsSeq");

	public static final String LOCAL_IP = EgovProperties.getProperty("Globals.LocalIp");
	public static final String BASE_SITE_URL = EgovProperties.getProperty("Globals.basSiteUrl");
	public static final String BASE_MODULE_SEQ = EgovProperties.getProperty("Globals.bass.module.seq");
	public static final String BASE_MODULE_CMNT_SEQ = EgovProperties.getProperty("Globals.cmnt.module.seq");
	public static final String BASE_MODULE_CUSTOM_SEQ = EgovProperties.getProperty("Globals.custom.module.seq");
	public static final String CNTNTS_MODULE_SEQ = EgovProperties.getProperty("Globals.cntntsModuleTyCode");
	public static final int API_REGIST_CNT = Integer.parseInt(EgovProperties.getProperty("Globals.API.regist.cnt"));
	public static final String POPUP_TY_CD_TMPLAT = EgovProperties.getProperty("Globals.popupTyCode.tmplat");
	public static final String ESSNTL_STPLAT_CODE = EgovProperties.getProperty("Globals.essntlStplatTyCode");
	public static final String ESSNTL_STPLAT_CODE_USRJOIN = EgovProperties.getProperty("Globals.stplatTyCode.usrJoin");
	public static final String ESSNTL_STPLAT_CODE_SITESTPLAT = EgovProperties
			.getProperty("Globals.stplatTyCode.siteStplat");
	public static final String USR_LOGINFORM_URL = EgovProperties.getProperty("Globals.usrLoginFormUrl");
	public static final String AUTH_SUPER_ADMIN = EgovProperties.getProperty("Globals.login.auth.superAdmin");
	public static final String SUPER_SITE_SEQ = EgovProperties.getProperty("Globals.suber.siteSeq");
	public static final String HOMEADMIN_SITE_URL = EgovProperties.getProperty("Globals.homeadmin.siteSeq");
	public static final String AUTH_NORMAL_ADMIN = EgovProperties.getProperty("Globals.login.auth.normalAdmin");
	public static final String NMBR_SITE_USRGROUPSEQ = EgovProperties.getProperty("Globals.nmbr.site.usrGroupSeq");
	public static final String BASE_SITE_USRGROUPSEQ = EgovProperties.getProperty("Globals.base.site.usrGroupSeq");
	public static final String BASE_SITE_USRGROUPSEQ_AUTHORSE = EgovProperties
			.getProperty("Globals.base.site.usrGroupSeq.authorSe");
	public static final String UPDTESTBSDE_PRE_CODE = EgovProperties.getProperty("Globals.updtEstbsDe.prefeCode");
	public static final String UPDTESTBSDE_MNG_CODE = EgovProperties.getProperty("Globals.updtEstbsDe.mngrestbsCode");
	public static final String DUPLOGIN_PRE_CODE = EgovProperties.getProperty("Globals.dupLogin.prefeCode");
	public static final String SESSINTVL_PRE_CODE = EgovProperties.getProperty("Globals.sessIntvl.prefeCode");
	public static final String EXCEL_DOMN_SE_CODE = EgovProperties.getProperty("Globals.domnSeCode");
	public static final String EXCEL_USE_LANG_CODE = EgovProperties.getProperty("Globals.useLangCode");
	public static final String USR_QUIT_JOIN = EgovProperties.getProperty("Globals.quit.join");
	public static final String CMNT_APPVL_CODE = EgovProperties.getProperty("Globals.cmnt.appvlCode");
	public static final String CMNT_OPEN_CODE = EgovProperties.getProperty("Globals.cmnt.openCode");
	public static final String THUMB_BASE_WIDTH = EgovProperties.getProperty("Globals.thumb.base.width");
	public static final String USR_CRTFC_PREFE = EgovProperties.getProperty("Globals.usrCrtfcPrefeCode");
	public static final String CRTFC_SITE_CODE = EgovProperties.getProperty("Globals.crtfc.sSiteCode");
	public static final String CRTFC_SITE_PW = EgovProperties.getProperty("Globals.crtfc.sSitePassword");
	public static final String CRTFC_REQ_NUM = EgovProperties.getProperty("Globals.crtfc.sRequestNumber");
	public static final String CRTFC_ESTBS_PASS = EgovProperties.getProperty("Globals.crtfc.estbs.pass");
	public static final String USR_REENTRN_DAY = EgovProperties.getProperty("Globals.usrReentrance.day");
	public static final String USR_RE_CRTFC = EgovProperties.getProperty("Globals.usrReCrtfc");
	public static final String USE_LANG_DEFAULT = EgovProperties.getProperty("lang.default");
	public static final String CNTNTS_PAGEADI_USEAT = EgovProperties.getProperty("Globals.cntnts.pageadi.useat");

	public static String USE_LANG(String langCode) {
		return ("".equals(langCode)) ? EgovProperties.getProperty("lang." + USE_LANG_DEFAULT)
				: EgovProperties.getProperty("lang." + langCode);
	}

	public static final String REPRSNT_SITEKEY = EgovProperties.getProperty("reprsnt.siteKey");
	public static final String IMPRTY_SITEKEY = EgovProperties.getProperty("Globals.imprty.siteKey");
	public static final String OPENAPI_HOLIDAYKEY = EgovProperties.getProperty("Globals.openApi.holidayKey");
}