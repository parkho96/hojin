package egovframework.wzwg.cmm.pageCallCtrl.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.InputStreamReader;
import java.util.HashMap;
import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.JsonProcessingException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;

import dggb.util.FileUtils;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.pageCallCtrl.service.PageCallCtrlService;
import egovframework.wzwg.cmm.pageCallCtrl.service.PageCallCtrlVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.cmm.util.snsAPI.service.FacebookAPIService;
import egovframework.wzwg.cmm.util.snsAPI.service.GoogleAPIService;
import egovframework.wzwg.cmm.util.snsAPI.service.KakaoRestApiHelper;
import egovframework.wzwg.cmm.util.snsAPI.service.NaverAPIService;
import egovframework.wzwg.module.scrin.service.ScrinCntntsService;
import egovframework.wzwg.module.scrin.service.ScrinCntntsVO;
import egovframework.wzwg.site.mngr.screen.service.SiteTemplateScreenService;
import egovframework.wzwg.site.mngr.screen.service.SiteTemplateScreenVO;
import egovframework.wzwg.sysMngr.screenMngr.template.service.SysMngrTemplateService;
import egovframework.wzwg.sysMngr.screenMngr.template.service.SysMngrTemplateVO;

@Controller
public class PageCallCtrlController {
    
    /** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    /** 화면 컨텐츠 **/
    @Resource(name="PageCallCtrlService")
    private PageCallCtrlService pageCallCtrlService;
    
    /** 화면 컨텐츠 **/
    @Resource(name="ScrinCntntsService")
    private ScrinCntntsService scrinCntntsService;
    
    @Resource(name="SiteTemplateScreenService")
    private SiteTemplateScreenService siteTemplateScreenService;
    
    @Resource(name="SysMngrTemplateService")
	private SysMngrTemplateService sysMngrTemplateService;
    
    @Resource(name="NaverAPIService")
    private NaverAPIService naverAPIService;
    
    @Resource(name="GoogleAPIService")
    private GoogleAPIService GoogleAPIService;
    
    @Resource(name="FacebookAPIService")
    private FacebookAPIService facebookAPIService;

    private static KakaoRestApiHelper kakaoApiHelper = new KakaoRestApiHelper();
    
    private static final ObjectMapper mapper = new ObjectMapper();

    /**
     * ㅁ RESTFUL 단축 URL
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value= {"/{menuTySe}/{cntntsSeq}","/{siteKey}/{menuTySe}/{cntntsSeq}"})
    public String selectPageCallCtrl(@PathVariable(value = "cntntsSeq") String cntntsSeq
            , @PathVariable(value = "menuTySe") String menuTySe
            , HttpServletRequest request
            , Model model) throws Exception {

        ScrinCntntsVO paramVO = new ScrinCntntsVO();
        
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        String sitecntntsSeq = (String)request.getAttribute("sitecntntsSeq");
        
        paramVO.setSiteSeq(siteSeq);
        paramVO.setSitecntntsSeq(sitecntntsSeq);
        
        // 컨텐츠 정보를 가져옴
        ScrinCntntsVO cntntsInfo = scrinCntntsService.selectSitecntntsSeqByModuleInfo(paramVO);
        
        // 컨텐츠 데이터를 가져옴
        List cntntsData = scrinCntntsService.selectScrinCntntsList(cntntsInfo);

        // 컨텐츠 데이터를 JSON 변환하여 넘김
        model.addAttribute("cntntsData", cntntsData);
        //model.addAttribute("cntntsInfo", JSONObject.fromObject(cntntsInfo));
        model.addAttribute("cntntsInfo", mapper.writeValueAsString(cntntsInfo));
        
        return "wzwg/cmm/pageCallCtrl/pageCallCtrlMain";
    }
    
    /**
     * ㅁ RESTFUL 서브페이지 목록 호출 제어
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value={"/subList/{menuSeq}","/{siteKey}/subList/{menuSeq}"})
    public String selectSubListPageCallCtrl(@PathVariable(value = "menuSeq") String menuSeq
            , HttpServletRequest request
            , HttpSession session
            , Model model) throws Exception {
    		try{
//        PageCallCtrlVO paramVO = new PageCallCtrlVO(); 
        
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        
//        paramVO.setSiteSeq(siteSeq);
//        paramVO.setMenuSeq(menuSeq);
        
        // 메뉴에 매핑된 모듈을 알수있는 SEQ 값을 가져온다
//        String sitecntntsSeq = pageCallCtrlService.selectMenuSeqBySiteCntntsSeq(paramVO);
        String sitecntntsSeq = (String)request.getAttribute("sitecntntsSeq");
        String url = "/WEB-INF/jsp/wzwg/module/test.jsp";
        ScrinCntntsVO scrinVO = new ScrinCntntsVO();
        PageCallCtrlVO  pageVO = new PageCallCtrlVO();
        
        scrinVO.setSiteSeq(siteSeq);
        scrinVO.setSitecntntsSeq(sitecntntsSeq);
        scrinVO.setMenuSeq(menuSeq);
        
        pageVO.setSiteSeq(siteSeq);
        pageVO.setMenuSeq(menuSeq);

        
        if(session.getAttribute("menuSeq") != null){
        	session.removeAttribute("menuSeq");
        }
        session.setAttribute("menuSeq", menuSeq);
        
    	String menuLinkUrl ="";
        // sitecntntsSeq 없으면 에러
        if ("".equals(StringUtils.defaultString(sitecntntsSeq))) {
            // 패키지 클래스가 존재하지 않을때 에러
        	menuLinkUrl =pageCallCtrlService.selectMenuSeqByMenuLinkUrl(pageVO);
        	if(menuLinkUrl.equals("")){
            model.addAttribute("message", egovMessageSource.getMessage("authCtrl.err01"));
            model.addAttribute("retUrl", "/index.do");
            
            return "dggb/cmm/retPage/errorMsgForward";
        	}else{
        		url = menuLinkUrl;
        	}
        }
        
        ScrinCntntsVO cntntsInfo = null;
        if(menuLinkUrl.equals("")){
        // 컨텐츠 정보를 가져옴
        cntntsInfo = scrinCntntsService.selectSitecntntsSeqByModuleInfo(scrinVO);
        
        // 컨텐츠 데이터를 가져옴
        Object cntntsData = scrinCntntsService.selectScrinCntntsObject(cntntsInfo);

        // 컨텐츠 데이터를 JSON 변환하여 넘김
        model.addAttribute("cntntsData", cntntsData);
        model.addAttribute("cntntsInfo", cntntsInfo);
        }
        model.addAttribute("menuSeq", menuSeq);
        model.addAttribute("menuNm", pageCallCtrlService.selectMenuSeqByMenuNm(pageVO));
        model.addAttribute("menuDc", pageCallCtrlService.selectMenuSeqByMenuDc(pageVO));
        model.addAttribute("menuPath", pageCallCtrlService.selectMenuSeqByMenuPath(pageVO));
        model.addAttribute("menuPathSeq", pageCallCtrlService.selectMenuSeqByMenuPathSeq(pageVO));
        
        String realPath =request.getServletContext().getRealPath("")+"/";
        String siteDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request);
		File siteDir = new File(siteDirStr);
		if(!siteDir.exists()){
			siteDir.mkdirs();
		}
		
		SiteTemplateScreenVO siteTemplateScreenParam = new SiteTemplateScreenVO();
		
		/**도메인 SEQ */
		String domnSeq = CmmSessionUtil.getSessionDomnSeq(request);
		siteTemplateScreenParam.setSiteSeq(siteSeq);
		siteTemplateScreenParam.setDomnSeq(domnSeq);
		siteTemplateScreenParam.setUserId(CmmSessionUtil.getSessionUserId());
		
		SiteTemplateScreenVO siteTemplateScreenVO = siteTemplateScreenService.selectSiteTemplateScreen(siteTemplateScreenParam);
		File subFile = new File(siteDirStr+"/sub_"+menuSeq+".jsp");
		if(!subFile.exists()){
			FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"sub.jsp"), subFile);
		}
		

        File templtFile = new File(siteDirStr+File.separator+"templat.jsp");
        if(!templtFile.exists()){
            FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"templat.jsp"), templtFile);
        }
		
		File subHeadFile = new File(siteDirStr+"/subHead.jsp");
		if(!subHeadFile.exists()){
			FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"subHead.jsp"), subHeadFile);
		}  
		

		File leftFile = new File(siteDirStr+"/leftMenu.jsp");
		if(!leftFile.exists()){
			FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"leftMenu.jsp"), leftFile);
		}  
		
		
		
        // 자동으로 받아옴...나중에...
    
		 if(menuLinkUrl.equals("")){
        // 컨텐츠 모듈일떄...
	        if (Globals.CNTNTS_MODULE_SEQ.equals(cntntsInfo.getModuleTyCode())) {
	        	url = "/WEB-INF/jsp/wzwg/module/cmm/cntntsView.jsp";
	        }
	        
	        // 게시판 모듈일떄...
	        if (Globals.BBS_MODULE_TY_CODE.equals(cntntsInfo.getModuleTyCode())) {
	        	String pckagePath = "/" + cntntsInfo.getPckagePath();
	        	String cntntsSeq = cntntsInfo.getCntntsSeq();
	        	url = pckagePath + "/selectBbsInc.do?cntntsSeq=" + cntntsSeq + "&menuSeq=" + menuSeq+"&sitecntntsSeq="+sitecntntsSeq;
	        }
	        
	        // 일반 모듈일떄...
	        if (Globals.NOMAL_MODULE_TY_CODE.equals(cntntsInfo.getModuleTyCode())) {
	        	String usrPageUrl = cntntsInfo.getUsrPageUrl();
	        	String pckagePath = "/" + cntntsInfo.getPckagePath();
	        	String cntntsSeq = cntntsInfo.getCntntsSeq();
	        	url = "/" + usrPageUrl + "?cntntsSeq=" + cntntsSeq + "&menuSeq=" + menuSeq+"&sitecntntsSeq="+sitecntntsSeq;
	        	//url = pckagePath + "/selectSchdulInc.do?menuSeq=" + menuSeq;
	        }
	        
	        if (Globals.SCHDUL_MODULE_TY_CODE.equals(cntntsInfo.getModuleTyCode())) {
	        	String usrPageUrl = cntntsInfo.getUsrPageUrl();
	        	String pckagePath = "/" + cntntsInfo.getPckagePath();
	        	url = "/" + usrPageUrl + "?menuSeq=" + menuSeq+"&sitecntntsSeq="+sitecntntsSeq;
	        	//url = pckagePath + "/selectSchdulInc.do?menuSeq=" + menuSeq;
	        } 
		 }
        model.addAttribute("url", url);
    		}catch(Exception e){
    			e.printStackTrace();
    		}
        return "site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/sub_"+menuSeq;
    }
    
    //@RequestMapping(value={"/mngr/{templateSeq}/subList/{menuSeq}","/{siteKey}/mngr/{templateSeq}/subList/{menuSeq}"})
    //public String selectTemplateSubListPageCallCtrl(@PathVariable(value = "menuSeq") String menuSeq
    //		, @PathVariable(value = "templateSeq") String templateSeq
    //        , HttpServletRequest request
    //        , HttpSession session
    //        , Model model) throws Exception {
    //		try{
//  //      PageCallCtrlVO paramVO = new PageCallCtrlVO(); 
    //    
    //    String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
    //    
//  //      paramVO.setSiteSeq(siteSeq);
//  //      paramVO.setMenuSeq(menuSeq);
    //    
    //    // 메뉴에 매핑된 모듈을 알수있는 SEQ 값을 가져온다
//  //      String sitecntntsSeq = pageCallCtrlService.selectMenuSeqBySiteCntntsSeq(paramVO);
    //    String sitecntntsSeq = (String)request.getAttribute("sitecntntsSeq");
    //    String url = "/WEB-INF/jsp/wzwg/module/test.jsp";
    //    ScrinCntntsVO scrinVO = new ScrinCntntsVO();
    //    PageCallCtrlVO  pageVO = new PageCallCtrlVO();
    //    
    //    scrinVO.setSiteSeq(siteSeq);
    //    scrinVO.setSitecntntsSeq(sitecntntsSeq);
    //    scrinVO.setMenuSeq(menuSeq);
    //    
    //    pageVO.setSiteSeq(siteSeq);
    //    pageVO.setMenuSeq(menuSeq);
    //
    //    
    //    if(session.getAttribute("menuSeq") != null){
    //    	session.removeAttribute("menuSeq");
    //    }
    //    session.setAttribute("menuSeq", menuSeq);
    //    
    //	String menuLinkUrl ="";
    //    // sitecntntsSeq 없으면 에러
    //    if ("".equals(StringUtils.defaultString(sitecntntsSeq))) {
    //        // 패키지 클래스가 존재하지 않을때 에러
    //    	menuLinkUrl =pageCallCtrlService.selectMenuSeqByMenuLinkUrl(pageVO);
    //    	if(menuLinkUrl.equals("")){
    //        model.addAttribute("message", egovMessageSource.getMessage("authCtrl.err01"));
    //        model.addAttribute("retUrl", "/index.do");
    //        
    //        return "dggb/cmm/retPage/errorMsgForward";
    //    	}else{
    //    		url = menuLinkUrl;
    //    	}
    //    }
    //
    //    
    //    
    //    ScrinCntntsVO cntntsInfo = null;
    //    if(menuLinkUrl.equals("")){
    //    // 컨텐츠 정보를 가져옴
    //      cntntsInfo = scrinCntntsService.selectSitecntntsSeqByModuleInfo(scrinVO);
    //      
    //    
    //    // 컨텐츠 데이터를 가져옴
    //    Object cntntsData = scrinCntntsService.selectScrinCntntsObject(cntntsInfo);
    //
    //    // 컨텐츠 데이터를 JSON 변환하여 넘김
    //    model.addAttribute("cntntsData", cntntsData);
    //    model.addAttribute("cntntsInfo", cntntsInfo);
    //    }
    //    model.addAttribute("menuSeq", menuSeq);
    //    model.addAttribute("menuNm", pageCallCtrlService.selectMenuSeqByMenuNm(pageVO));
    //    model.addAttribute("menuDc", pageCallCtrlService.selectMenuSeqByMenuDc(pageVO));
    //    model.addAttribute("menuPath", pageCallCtrlService.selectMenuSeqByMenuPath(pageVO));
    //    model.addAttribute("menuPathSeq", pageCallCtrlService.selectMenuSeqByMenuPathSeq(pageVO));
    //    
    //    String realPath =request.getRealPath("")+"/";
    //    String siteDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+templateSeq;
	//	File siteDir = new File(siteDirStr);
	//	if(!siteDir.exists()){
	//		siteDir.mkdirs();
	//	}
	//	
	//	SiteTemplateScreenVO siteTemplateScreenParam = new SiteTemplateScreenVO();
	//	
	//	/**도메인 SEQ */
	//	String domnSeq = CmmSessionUtil.getSessionDomnSeq(request);
	//	siteTemplateScreenParam.setSiteSeq(siteSeq);
	//	siteTemplateScreenParam.setDomnSeq(domnSeq);
	//	siteTemplateScreenParam.setUserId(CmmSessionUtil.getSessionUserId());
	//	
	//	SysMngrTemplateVO paramVO = new SysMngrTemplateVO();
	//	 
	//	paramVO.setTemplateSeq(templateSeq);
	//	SysMngrTemplateVO sysMngrTemplateVO = sysMngrTemplateService.selectTemplateScreen(paramVO);
	//	File subFile = new File(siteDirStr+"/sub_"+menuSeq+".jsp");
	//	if(!subFile.exists()){
	//		FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"sub.jsp"), subFile);
	//	}
	//	
    //
	//	File leftFile = new File(siteDirStr+"/leftMenu.jsp");
	//	if(!leftFile.exists()){
	//		FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"leftMenu.jsp"), leftFile);
	//	}  
	//	
	//	
	//	
    //    // 자동으로 받아옴...나중에...
    //
	//	 if(menuLinkUrl.equals("")){
	//	        // 컨텐츠 모듈일떄...
	//		        if (Globals.CNTNTS_MODULE_SEQ.equals(cntntsInfo.getModuleTyCode())) {
	//		        	url = "/WEB-INF/jsp/wzwg/module/cmm/cntntsView.jsp";
	//		        }
	//		        
	//		        // 게시판 모듈일떄...
	//		        if (Globals.BBS_MODULE_TY_CODE.equals(cntntsInfo.getModuleTyCode())) {
	//		        	String pckagePath = "/" + cntntsInfo.getPckagePath();
	//		        	String cntntsSeq = cntntsInfo.getCntntsSeq();
	//		        	url = pckagePath + "/selectBbsInc.do?cntntsSeq=" + cntntsSeq + "&menuSeq=" + menuSeq+"&sitecntntsSeq="+sitecntntsSeq;
	//		        }
	//		        
	//		        // 일반 모듈일떄...
	//		        if (Globals.NOMAL_MODULE_TY_CODE.equals(cntntsInfo.getModuleTyCode())) {
	//		        	String usrPageUrl = cntntsInfo.getUsrPageUrl();
	//		        	String pckagePath = "/" + cntntsInfo.getPckagePath();
	//		        	String cntntsSeq = cntntsInfo.getCntntsSeq();
	//		        	url = "/" + usrPageUrl + "?cntntsSeq=" + cntntsSeq + "&menuSeq=" + menuSeq+"&sitecntntsSeq="+sitecntntsSeq;
	//		        	//url = pckagePath + "/selectSchdulInc.do?menuSeq=" + menuSeq;
	//		        }
	//		        
	//		        if (Globals.SCHDUL_MODULE_TY_CODE.equals(cntntsInfo.getModuleTyCode())) {
	//		        	String usrPageUrl = cntntsInfo.getUsrPageUrl();
	//		        	String pckagePath = "/" + cntntsInfo.getPckagePath();
	//		        	url = "/" + usrPageUrl + "?menuSeq=" + menuSeq+"&sitecntntsSeq="+sitecntntsSeq;
	//		        	//url = pckagePath + "/selectSchdulInc.do?menuSeq=" + menuSeq;
	//		        } 
	//			 }
    //    model.addAttribute("url", url);
    //		}catch(Exception e){
    //			e.printStackTrace();
    //		}
    //    return "site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+templateSeq+"/sub_"+menuSeq;
    //}
   
    
    @RequestMapping(value={"/mngr/subList/{menuSeq}","/{siteKey}/mngr/subList/{menuSeq}"})
    public String selectMngrSubListPageCallCtrl(@PathVariable(value = "menuSeq") String menuSeq
    		, String templateSeq
            , HttpServletRequest request
            , HttpSession session
            , Model model) throws Exception {
    		try{
//        PageCallCtrlVO paramVO = new PageCallCtrlVO(); 
        
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        
//        paramVO.setSiteSeq(siteSeq);
//        paramVO.setMenuSeq(menuSeq);
        
        // 메뉴에 매핑된 모듈을 알수있는 SEQ 값을 가져온다
//        String sitecntntsSeq = pageCallCtrlService.selectMenuSeqBySiteCntntsSeq(paramVO);
     //   String sitecntntsSeq = (String)request.getAttribute("sitecntntsSeq");
        String url = "/WEB-INF/jsp/wzwg/module/moduleArea.jsp";
      
        String realPath =request.getServletContext().getRealPath("")+"/";
        String siteDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request);
        if(StringUtils.isEmpty(templateSeq) == false){
        	siteDirStr = siteDirStr + "/"+templateSeq;
        }
		File siteDir = new File(siteDirStr);
		if(!siteDir.exists()){
			siteDir.mkdirs();
		}
		
		SiteTemplateScreenVO siteTemplateScreenParam = new SiteTemplateScreenVO();
		
		/**도메인 SEQ */
		String domnSeq = CmmSessionUtil.getSessionDomnSeq(request);
		siteTemplateScreenParam.setSiteSeq(siteSeq);
		siteTemplateScreenParam.setDomnSeq(domnSeq);
		siteTemplateScreenParam.setUserId(CmmSessionUtil.getSessionUserId());
		
		SiteTemplateScreenVO siteTemplateScreenVO = siteTemplateScreenService.selectSiteTemplateScreen(siteTemplateScreenParam);
		File subFile = new File(siteDirStr+"/sub_"+menuSeq+".jsp");
		if(!subFile.exists()){
			FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"sub.jsp"), subFile);
		}
		

        File templtFile = new File(siteDirStr+File.separator+"templat.jsp");
        if(!templtFile.exists()){
            FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"templat.jsp"), templtFile);
        }
		
		File subHeadFile = new File(siteDirStr+"/subHead.jsp");
		if(!subHeadFile.exists()){
			FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"subHead.jsp"), subHeadFile);
		}  
		

		File leftFile = new File(siteDirStr+"/leftMenu.jsp");
		if(!leftFile.exists()){
			FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"leftMenu.jsp"), leftFile);
		}  
		
        model.addAttribute("url", url);
    		}catch(Exception e){
    			e.printStackTrace();
    		}
    	
    	if(StringUtils.isEmpty(templateSeq) == false){
    		return "site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+templateSeq+"/sub_"+menuSeq;
    	}else{
    		return "site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/sub_"+menuSeq;
    	}
    }
    
    @RequestMapping(value={"/mngr/{templateSeq}/subList/screen/{menuSeq}","/{siteKey}/mngr/{templateSeq}/subList/screen/{menuSeq}"})
    public String selectMngrTempSubListPageCallCtrl(@PathVariable(value = "menuSeq") String menuSeq
    		, @PathVariable(value = "templateSeq") String templateSeq
            , HttpServletRequest request
            , HttpSession session
            , Model model) throws Exception {
    		try{
//        PageCallCtrlVO paramVO = new PageCallCtrlVO(); 
        
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        
//        paramVO.setSiteSeq(siteSeq);
//        paramVO.setMenuSeq(menuSeq);
        
        // 메뉴에 매핑된 모듈을 알수있는 SEQ 값을 가져온다
//        String sitecntntsSeq = pageCallCtrlService.selectMenuSeqBySiteCntntsSeq(paramVO);
     //   String sitecntntsSeq = (String)request.getAttribute("sitecntntsSeq");
        String url = "/WEB-INF/jsp/wzwg/module/moduleArea.jsp";
      
        String realPath =request.getServletContext().getRealPath("")+"/";
        String siteDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+templateSeq;
		File siteDir = new File(siteDirStr);
		if(!siteDir.exists()){
			siteDir.mkdirs();
		}
		
		SiteTemplateScreenVO siteTemplateScreenParam = new SiteTemplateScreenVO();
		
		/**도메인 SEQ */
		String domnSeq = CmmSessionUtil.getSessionDomnSeq(request);
		siteTemplateScreenParam.setSiteSeq(siteSeq);
		siteTemplateScreenParam.setDomnSeq(domnSeq);
		siteTemplateScreenParam.setUserId(CmmSessionUtil.getSessionUserId());
		
		SysMngrTemplateVO paramVO = new SysMngrTemplateVO();
		 
		paramVO.setTemplateSeq(templateSeq);
		SysMngrTemplateVO sysMngrTemplateVO = sysMngrTemplateService.selectTemplateScreen(paramVO);
		File subFile = new File(siteDirStr+"/sub_"+menuSeq+".jsp");
		if(!subFile.exists()){
			FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"sub.jsp"), subFile);
			BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(subFile)));

			String line;
			String dummy="";

			while((line = br.readLine())!=null) {
				if(line.indexOf("subHead.jsp")>-1){
				 dummy += (line.replaceAll("/subHead.jsp", "/"+templateSeq+"/subHead.jsp") + "\r\n" );	
				}else{
				dummy += (line + "\r\n" );
				}
				

			}

			FileWriter fw = new FileWriter(subFile);
			fw.write(dummy);			
			//bw.close();
			fw.close();
			br.close();
		}
		

        File templtFile = new File(siteDirStr+File.separator+"templat.jsp");
        if(!templtFile.exists()){
            FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"templat.jsp"), templtFile);
        }
		
		File subHeadFile = new File(siteDirStr+"/subHead.jsp");
		if(!subHeadFile.exists()){
			FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"subHead.jsp"), subHeadFile);
		}  
		

		File leftFile = new File(siteDirStr+"/leftMenu.jsp");
		if(!leftFile.exists()){
			FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"leftMenu.jsp"), leftFile);
		}  
		
        model.addAttribute("url", url);
    		}catch(Exception e){
    			e.printStackTrace();
    		}
        return "site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+templateSeq+"/sub_"+menuSeq;
    }

    @RequestMapping(value= {"/sns/{callSe}/{crtfctSeCode}","/{siteKey}/sns/{callSe}/{crtfctSeCode}"})
    public String actionSnsLogin(@ModelAttribute("loginVO") CmmLoginVO loginVO
            , @RequestParam(value="code", required=false) String code
            , @RequestParam(value="state", required=false) String state
            , @RequestParam(value="oauth_token", required=false) String oauth_token
            , @PathVariable(value="crtfctSeCode") String crtfctSeCode
            , @PathVariable(value="callSe") String callSe
            , HttpSession session
            , HttpServletRequest request
            , HttpServletResponse response
            , ModelMap model) throws Exception{
        
        String apiResult = "";
        
        HashMap<String, String> getSnsData = new HashMap<String, String>();
        
        try {
            if ("crtfc".equals(callSe)) {
                
                if ("SC00000433".equals(crtfctSeCode)) {
                    // 네이버
                    OAuth2AccessToken oauthToken = naverAPIService.getAccessToken(session, code, state);
                    apiResult = naverAPIService.getUserProfile(session, oauthToken);
    
                    getSnsData = getJsonObjectByCrtfcProfile(apiResult, "response", "id", "name", "email");
                } else if ("SC00000436".equals(crtfctSeCode)) {
                    // 구글
                	   //OAuth2AccessToken accessToken = GoogleAPIService.getAccessToken(code);
                       apiResult = GoogleAPIService.getUserProfile(request);
    
                    getSnsData = getJsonObjectByCrtfcProfile(apiResult, null, "id", "displayName", null);
                } else if ("SC00000437".equals(crtfctSeCode)) {
                    // 페이스북
                    OAuth2AccessToken accessToken = facebookAPIService.getAccessToken(code);
                    apiResult = facebookAPIService.getUserProfile(accessToken);
                    
                    getSnsData = getJsonObjectByCrtfcProfile(apiResult, null, "id", "name", null);
                }
            } else if ("login".equals(callSe)) {
    
                // 카카오
                if ("SC00000434".equals(crtfctSeCode)) {
                    
                    String token = kakaoApiHelper.getPushTokens(code);
                    
                    kakaoApiHelper.setAccessToken(token);
                    
                    apiResult = kakaoApiHelper.me();
                    
                    getSnsData = getJsonObjectByCrtfcProfile(apiResult, null, "id", null, "kaccount_email");
                    
                    String name = (String)getJsonObjectByCrtfcProfile(apiResult, "properties", null, "nickname", null).get("name");
                    
                    getSnsData.put("crtfc_name", name);
                }
            } else {
                
            }
            
            getSnsData.put("apiResult", apiResult);
            getSnsData.put("crtfcSns", crtfctSeCode);
            
            if (!"".equals(StringUtils.defaultString(getSnsData.get("crtfctDn")))) {
                model.addAttribute("snsCrtfcMap", getSnsData);
            } else {
                model.addAttribute("snsCrtfcMap", new HashMap<String, String>());
                model.addAttribute("message", egovMessageSource.getMessage("fail.common.crtfc.error"));
            }
            
        } catch (Exception e) {
            model.addAttribute("message", egovMessageSource.getMessage("fail.common.crtfc.error"));
            e.printStackTrace();
        }

        return "wzwg/cmm/mber/sbscrb/sbscrbUsrCrtfcSnsResult";
    }
    
    private HashMap<String, String> getJsonObjectByCrtfcProfile(String response, String profileTag, String id, String name, String email) {

        HashMap<String, String> retMap = new HashMap<>();
        String retId = "";
        String retName = "";
        String retEmail = "";

        try {
            if (StringUtils.isEmpty(response)) return retMap;

            // 1. JSON 파싱
            JsonNode rootNode = mapper.readTree(response);
            
            // 2. 작업 대상 노드(Target) 결정
            // profileTag가 있으면 해당 하위 노드 탐색, 없으면 rootNode 사용
            JsonNode targetNode = rootNode;
            if (StringUtils.isNotEmpty(profileTag) && rootNode.has(profileTag)) {
                targetNode = rootNode.path(profileTag);
            }

            // 3. 데이터 추출 (isMissingNode를 통해 안전하게 접근)
            if (!targetNode.isMissingNode() && !targetNode.isNull()) {
                
                // ID 추출 (getJsonObjectById 메서드 활용)
                retId = getJsonObjectById(targetNode, id, null);
                
                // Name 추출
                if (StringUtils.isNotEmpty(name)) {
                    retName = targetNode.path(name).asText();
                }
                
                // Email 추출
                if (StringUtils.isNotEmpty(email)) {
                    retEmail = targetNode.path(email).asText();
                }
            }

        } catch (JsonProcessingException e) {
            // eGovFrame 로거를 사용하여 에러를 기록하세요.
            e.printStackTrace();
        }

        retMap.put("crtfctDn", retId);
        retMap.put("crtfc_name", retName);
        retMap.put("crtfc_email", retEmail);

        return retMap;
    }

    /**
     * ID 기반 데이터 추출 메서드
     */
    private String getJsonObjectById(JsonNode jsonNode, String id, HashMap responseMap) {
        if (StringUtils.isEmpty(id)) {
            return "";
        }

        // 1. responseMap(HashMap)이 우선순위일 경우 처리
        if (responseMap != null) {
            Object value = responseMap.get(id);
            return (value == null) ? "" : String.valueOf(value);
        } 

        // 2. JsonNode에서 데이터 추출
        if (jsonNode != null) {
            // path()는 해당 키가 없어도 MissingNode를 반환하여 NPE를 방지합니다.
            // asText("")는 값이 숫자(Long)든 문자열이든 상관없이 String으로 변환하며, 없으면 "" 반환
            return jsonNode.path(id).asText();
        }

        return "";
    }
}
