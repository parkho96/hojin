package egovframework.wzwg.cmm.conectCtrl.web;

import java.net.InetAddress;
import java.util.IllegalFormatException;
import java.util.Iterator;
import java.util.Locale;
import java.util.Set;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Component;
import org.springframework.util.AntPathMatcher;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.util.UrlPathHelper;
import org.springframework.web.servlet.HandlerInterceptor;

import dggb.util.DateUtils;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.conectCtrl.service.ConectCtrlService;
import egovframework.wzwg.cmm.conectCtrl.service.RequestAcqsDataVO;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmReturnUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.cmm.util.LicenseUtil;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuService;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuVO;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteOpertNtcService;
import egovframework.wzwg.sysMngr.siteMngr.siteOpert.service.SysMngrSysOpertNtcService;
import egovframework.wzwg.sysMngr.siteMngr.siteOpert.service.SysMngrSysOpertNtcVO;
import egovframework.wzwg.sysMngr.usrPrefces.service.UsrPrefcesService;
import egovframework.wzwg.sysMngr.usrPrefces.service.UsrPrefcesVO;

@Component("ConectCtrlInterceptor")
public class ConectCtrlInterceptor implements HandlerInterceptor {
    
    protected final static Log LOG = LogFactory.getLog(ConectCtrlInterceptor.class);

    @Resource(name="ConectCtrlService")
    private ConectCtrlService conectCtrlService;

    @Resource(name="SysOpertNtcService")
    private SysMngrSysOpertNtcService sysOpertNtcService;

    @Resource(name="SysMngrSiteOpertNtcService")
    private SysMngrSiteOpertNtcService siteOpertNtcService;
    
    @Resource(name="SiteMenuService")
    private SiteMenuService siteMenuService;
    
    /** 환경설정 코드 **/
    @Resource(name="UsrPrefcesService")
	UsrPrefcesService usrPrefcesService;
    
    @Resource(name="SysMngrSiteAdiInfoService")
    private SysMngrSiteAdiInfoService siteAdiInfoService;
    
    private Set<String> pasageURL;
    
    public void setPasageURL(Set<String> pasageURL) {
        this.pasageURL = pasageURL;
    }
    
    @Resource(name="localeResolver")
    private LocaleResolver localeResolver;

    @Override
    public boolean preHandle(HttpServletRequest request,
            HttpServletResponse response, Object handler) throws Exception {
        try {
            
        String siteUrl = request.getServerName();
        
        UrlPathHelper urlPathHelper = new UrlPathHelper();
       	String   reqUrl  = urlPathHelper.getOriginatingRequestUri(request);
       	 ;
       	 String oldSiteSeq = CmmSessionUtil.getSessionSiteSeq(request); 
       	 
         if(reqUrl.indexOf("WEB-INF") > -1 || reqUrl.indexOf("null") > -1 || reqUrl.indexOf("cmm/mber/") > -1 ) {
         	/*if(reqUrl.indexOf("/cmm/mber/sbscrb/selectSbscrbUsrTy.do") >-1) {
         		return true;	
         	}*/
         	
         }
         	
         String siteKey ="";  
         if(reqUrl.split("/").length >1) {  
         if(!reqUrl.split("/")[1].endsWith(".do")) {
        	 siteKey = reqUrl.split("/")[1];
         } 
       } 
         
        if(siteKey.equals("module") || siteKey.equals("mngr") || siteKey.equals("subList") || siteKey.equals("sysMngr") || siteKey.equals("cmm")) {
        	 siteKey = "";
        }
        String[] imprtySiteKeyArr = Globals.IMPRTY_SITEKEY.split(",");
		
		for(String str:imprtySiteKeyArr) {
			if((str).equals(siteKey)) {
				 siteKey = "";
			}
		} 
        RequestAcqsDataVO radVO = conectCtrlService.baseSiteInfoCheck(request, siteUrl,siteKey);
        
        CmmSessionUtil.setSessionValue(request, "siteKey",radVO.getSiteKey());
        String ablEnncAt = StringUtils.defaultString(radVO.getAblEnncAt());
        
        String wzwgContext =CmmSysParameterSetUtil.getUrlWzwgContext(request);
        if (!(reqUrl.indexOf("/opertntc/selectSiteAblEnnc.do") > -1) && "Y".equals(ablEnncAt)) {
            radVO.setRetUrl(wzwgContext+"/opertntc/selectSiteAblEnnc.do");
            return CmmReturnUtil.getSendRedirect(request, response, radVO);
        }
        
        String sessionLang = CmmSessionUtil.getSessionValue(request, "LANG");
        
        String selLang = StringUtils.defaultString(request.getParameter("lang"));
        
        if ("".equals(sessionLang)) {
            selLang = ("".equals(selLang))? StringUtils.defaultString(radVO.getUseLangCode()):selLang;
            CmmSessionUtil.setSessionValue(request, "LANG", selLang);
        } else {
            
            if (!"".equals(selLang) && !sessionLang.equals(selLang)) {
                CmmSessionUtil.setSessionValue(request, "LANG", selLang);
            } else {
                selLang = sessionLang;
            }
        }
        
        if (reqUrl.indexOf("/subList/") > -1 || reqUrl.indexOf("/index.do") > -1) {
            selLang = radVO.getUseLangCode();
            CmmSessionUtil.setSessionValue(request, "LANG", selLang);
        }
        
        String useLangCode = Globals.USE_LANG(selLang);
        localeResolver.setLocale(request, response, new Locale(useLangCode));
        
        String licenseInfo = LicenseUtil.getLicenseInfo(request);
        String licenseIp =licenseInfo.split("wizwig")[0];
        String licenseDate =licenseInfo.split("wizwig")[1];
        String licenseCnt =licenseInfo.split("wizwig")[2];
       
        String retUrl = StringUtils.defaultString(radVO.getRetUrl());
        if (!"".equals(retUrl)) {
            return CmmReturnUtil.getSendRedirect(request, response, radVO);
        }
        SiteMenuVO paramVO = new SiteMenuVO();
        paramVO.setSiteSeq(radVO.getSiteSeq()); 
    	 
        SysMngrSiteAdiInfoVO sysMngrSiteAdiInfoVO = new SysMngrSiteAdiInfoVO();
        sysMngrSiteAdiInfoVO.setSiteSeq(radVO.getSiteSeq()); 
        SysMngrSiteAdiInfoVO sysMngrSiteAdiInfo =siteAdiInfoService.selectSiteAdiInfoDetail(sysMngrSiteAdiInfoVO);
       
        if(sysMngrSiteAdiInfo == null){
            CmmSessionUtil.setSessionValue(request, "iconSImagePath", "");	
        }else{
            CmmSessionUtil.setSessionValue(request, "iconSImagePath", sysMngrSiteAdiInfo.getIconSImagePath());
            CmmSessionUtil.setSessionValue(request, "topLogoReplcText", sysMngrSiteAdiInfo.getLogoTImageReplcText());
            CmmSessionUtil.setSessionValue(request, "footerLogoReplcText", sysMngrSiteAdiInfo.getLogoFImageReplcText());
        }
        
        CmmSessionUtil.setSessionValue(request, "usrTopLogo", StringUtils.defaultString(siteMenuService.selectSiteTopLogo(paramVO)));
        CmmSessionUtil.setSessionValue(request, "licenseSiteCnt", "1000");
        CmmSessionUtil.setSessionValue(request, "langCode", useLangCode);
        CmmSessionUtil.setSessionSiteSeq(request, radVO.getSiteSeq());
        CmmSessionUtil.setSessionSiteNm(request, radVO.getSiteNm());
        CmmSessionUtil.setSessionDomnSeq(request, radVO.getDomnSeq());
        CmmSessionUtil.setSessionValue(request, "asscNo", radVO.getAsscNo());
        CmmSessionUtil.setSessionValue(request, "useLangCode", selLang);
        CmmSessionUtil.setSessionValue(request, "SYSMNGR_AT", radVO.getSysSiteAt());
        CmmSessionUtil.setSessionValue(request, "SITE_LCLAS_GROUP", radVO.getSiteLclasGroup());
        CmmSessionUtil.setSessionValue(request, "SITE_MLSFC_GROUP", radVO.getSiteMlsfcGroup());
        CmmSessionUtil.setSessionValue(request, "SSL_USE_AT", radVO.getSslUseAt());
        
        if(!oldSiteSeq.equals("") && !radVO.getSiteSeq().equals(oldSiteSeq)) {
        	CmmSessionUtil.setSessionValue(request, "transSiteYn", "Y");
        }else {
        	CmmSessionUtil.setSessionValue(request, "transSiteYn", "N");
        }
        
        String NMBER_AUTHOR = CmmSessionUtil.getSessionValue(request, "NMBER_AUTHOR");

        if (getPasageUrlCheck(reqUrl)) {
            return true;
        } else if ("R".equals(NMBER_AUTHOR) || "W".equals(NMBER_AUTHOR)) {
            return true;
        } else {
        	 if(!licenseIp.equals("999.999.999.999")){
             	InetAddress local;
             	    local = InetAddress.getLocalHost();
             	    String ip = local.getHostAddress();
             	    if(!ip.equals(licenseIp)){
             	    	radVO.setRetUrl("/licenseFail.do");
             	      return CmmReturnUtil.getSendRedirect(request, response, radVO);
             	    }
             }
             
             if(!licenseDate.equals("9999.99.99")){
             String 	currentDate =  DateUtils.getCurrentDate("yyyy.MM.dd");
                   if(currentDate.compareTo(licenseDate) >0){
                 	  radVO.setRetUrl("/licenseFail.do");
                       return CmmReturnUtil.getSendRedirect(request, response, radVO);
     	        }
             }
             
            Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
            CmmLoginVO  loginVO = (CmmLoginVO)EgovUserDetailsHelper.getAuthenticatedUser();

            if (isAuthenticated) {
                
                if (!radVO.getSiteSeq().equals(loginVO.getSiteSeq())) {
                    CmmReturnUtil.returnMainPage(request);
                }
            }
            
            if ( reqUrl.indexOf("/sysMngr/") >-1 || (reqUrl.indexOf("/mngr/")>-1 && reqUrl.indexOf("/cmnt/")<0)  || reqUrl.indexOf("/subMngr/")>-1 ) {
                  if (!(isAuthenticated && CmmSessionUtil.getSessionBooleanValue(request, "NADMIN_AT")) && !CmmSessionUtil.getSessionBooleanValue(request, "SADMIN_AT")  && !CmmSessionUtil.getSessionValue(request, "subSiteMngr").equals("Y")  ) {
                      radVO.setRetUrl(wzwgContext+"/cmm/mber/login/mngrLoginForm.do");
                      return CmmReturnUtil.getSendRedirect(request, response, radVO);
                  } 
                
	                /* 관리자 로그인 유지시간 체크 2019.03.21 조원권 */
	                UsrPrefcesVO usrPreFcesdVO = new UsrPrefcesVO();
	              	usrPreFcesdVO.setUsrPrefeCode(Globals.SESSINTVL_PRE_CODE);
	              	
	              	String intervalTime = String.valueOf(usrPrefcesService.selectSessionInterval(usrPreFcesdVO));
	              	if(intervalTime == null || intervalTime.equals("") || intervalTime.toLowerCase().equals("null")){
	              		intervalTime = "0";
	              	}
	              	
	                request.setAttribute("sessintvl", intervalTime);
            } else {
                
                SysMngrSysOpertNtcVO sysOpertNtcVO = new SysMngrSysOpertNtcVO();
                
                sysOpertNtcVO.setSiteLclasGroup(CmmSessionUtil.getSessionValue(request, "SITE_LCLAS_GROUP"));
                sysOpertNtcVO.setSiteMlsfcGroup(CmmSessionUtil.getSessionValue(request, "SITE_MLSFC_GROUP"));
                
                Integer sysOpertntcCnt = sysOpertNtcService.selectConectCtrlSysOpertntcChk(sysOpertNtcVO);
                
                if (sysOpertntcCnt > 0) {
                    radVO.setRetUrl(wzwgContext+"/opertntc/selectSysOpertntcDetail.do");
                    return CmmReturnUtil.getSendRedirect(request, response, radVO);
                }
                
                Integer siteOpertntcCnt = siteOpertNtcService.selectConectCtrlSiteOpertntcChk(radVO.getSiteSeq());
                
                if (siteOpertntcCnt > 0) {
                    radVO.setRetUrl(wzwgContext+"/opertntc/selectSiteOpertntcDetail.do");
                    return CmmReturnUtil.getSendRedirect(request, response, radVO);
                }
            }
        }
        
        return true;
        }  catch(NullPointerException e){
			LOG.error("NullPointerException",e);
    	}catch(NumberFormatException e){
    		LOG.error("NumberFormatException",e);
    	}catch(IllegalFormatException e){
    		LOG.error("IllegalFormatException",e);
    	}catch(ArrayIndexOutOfBoundsException e){
    		LOG.error("ArrayIndexOutOfBoundsException",e);
    	}   
        return false;
    }
    
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
