package egovframework.wzwg.site.mngr.screen.web;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileFilter;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.IllegalFormatException;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.psl.dataaccess.util.EgovMap;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UrlPathHelper;

import dggb.util.DateUtils;
import dggb.util.FileUtils;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.pageCallCtrl.service.PageCallCtrlService;
import egovframework.wzwg.cmm.pageCallCtrl.service.PageCallCtrlVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.cmm.util.ScreenUtilFileFilter;
import egovframework.wzwg.cmm.util.SecurePathValidator;
import egovframework.wzwg.module.banner.service.ModuleBannerInfoService;
import egovframework.wzwg.module.banner.service.ModuleBannerInfoVO;
import egovframework.wzwg.module.popup.service.ModulePopupInfoService;
import egovframework.wzwg.module.popup.service.ModulePopupInfoVO;
import egovframework.wzwg.module.schdul.service.ModuleSchdulBassInfoService;
import egovframework.wzwg.module.schdul.service.ModuleSchdulBassInfoVO;
import egovframework.wzwg.module.scrin.service.ScrinCntntsService;
import egovframework.wzwg.module.scrin.service.ScrinMenuVO;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuVO;
import egovframework.wzwg.site.mngr.screen.service.SiteLayoutService;
import egovframework.wzwg.site.mngr.screen.service.SiteLayoutVO;
import egovframework.wzwg.site.mngr.screen.service.SiteScreenService;
import egovframework.wzwg.site.mngr.screen.service.SiteScreenVO;
import egovframework.wzwg.site.mngr.screen.service.SiteTemplateLayoutService;
import egovframework.wzwg.site.mngr.screen.service.SiteTemplateLayoutVO;
import egovframework.wzwg.site.mngr.screen.service.SiteTemplateScreenService;
import egovframework.wzwg.site.mngr.screen.service.SiteTemplateScreenVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;
import egovframework.wzwg.sysMngr.screenMngr.template.service.SysMngrTemplateService;
import egovframework.wzwg.sysMngr.screenMngr.template.service.SysMngrTemplateVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class SiteScreenController {
	
	@Resource(name="SiteScreenService")
	private SiteScreenService siteScreenService;
	 
	/** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
	
	@Resource(name="SysMngrTemplateService")
	private SysMngrTemplateService sysMngrTemplateService;
	
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
    
    @Resource(name="SiteTemplateLayoutService")
    private SiteTemplateLayoutService siteTemplateLayoutService;
    
    @Resource(name="SiteLayoutService")
    private SiteLayoutService siteLayoutService;
    
    @Resource(name="CmmCodeService")
    private CmmCodeService codeService;
    
	@Resource(name="ModulePopupInfoService")
	ModulePopupInfoService modulePopupInfoService;
	

    @Resource(name="ModuleBannerInfoService")
    public ModuleBannerInfoService bannerInfoService;
    
    @Resource(name="SysMngrSiteAdiInfoService")
    public SysMngrSiteAdiInfoService sysMngrSiteAdiInfoService;
    
    @Resource(name="ModuleSchdulBassInfoService")
    private ModuleSchdulBassInfoService schdulService;
    
    @RequestMapping(value="/**/siteInfo/scrinBannerJsonAjax.do")
	 public ModelAndView scrinBannerJsonAjax (
	    		@ModelAttribute("paramVO") ModuleBannerInfoVO paramVO
	        , HttpServletRequest request ) throws Exception {
	    
	        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
	        
	        paramVO.setSiteSeq(siteSeq); 
	        
	        SysMngrSiteAdiInfoVO sysMngrSiteAdiInfoVO = new SysMngrSiteAdiInfoVO();
	        sysMngrSiteAdiInfoVO.setSiteSeq(siteSeq);
	        SysMngrSiteAdiInfoVO SysMngrSiteAdiInfo = new SysMngrSiteAdiInfoVO();
	        SysMngrSiteAdiInfo = sysMngrSiteAdiInfoService.selectSiteAdiInfoDetail(sysMngrSiteAdiInfoVO);
	        // 컨텐츠 데이터를 가져옴
	     //   List<SiteHdftrMenuVO> resultList = siteHdftrMenuService.selectSiteHdftrMenuList(paramVO);
	        paramVO.setBannerLclCode(SysMngrSiteAdiInfo.getSiteLclasGroup());
	        paramVO.setBannerMclCode(SysMngrSiteAdiInfo.getSiteMlsfcGroup());
	        // 컨텐츠 데이터를 가져옴
	     //   List<SiteHdftrMenuVO> resultList = siteHdftrMenuService.selectSiteHdftrMenuList(paramVO);

	        ModelAndView model = new ModelAndView();
	    
	        model.setViewName("jsonView");
	        
	        // 컨텐츠 데이터를 JSON 변환하여 넘김
	        model.addObject("bannerList", bannerInfoService.selectModuleMainBannerList(paramVO));
	        
	        return model;
	    }
    
	@RequestMapping(value="/**/siteInfo/scrinPopupJsonAjax.do")
	 public ModelAndView scrinPopupJsonAjax (
	    		@ModelAttribute("paramVO") ModulePopupInfoVO paramVO
	        , HttpServletRequest request ) throws Exception {
	    
	        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
	        
	        paramVO.setSiteSeq(siteSeq); 
	        
	        SysMngrSiteAdiInfoVO sysMngrSiteAdiInfoVO = new SysMngrSiteAdiInfoVO();
	        sysMngrSiteAdiInfoVO.setSiteSeq(siteSeq);
	        SysMngrSiteAdiInfoVO SysMngrSiteAdiInfo = new SysMngrSiteAdiInfoVO();
	        SysMngrSiteAdiInfo = sysMngrSiteAdiInfoService.selectSiteAdiInfoDetail(sysMngrSiteAdiInfoVO);
	        // 컨텐츠 데이터를 가져옴
	     //   List<SiteHdftrMenuVO> resultList = siteHdftrMenuService.selectSiteHdftrMenuList(paramVO);
	        paramVO.setLcalsCode(SysMngrSiteAdiInfo.getSiteLclasGroup());
	        paramVO.setMlsfcCode(SysMngrSiteAdiInfo.getSiteMlsfcGroup());
	        ModelAndView model = new ModelAndView();
	    
	        model.setViewName("jsonView");
	        
	        // 컨텐츠 데이터를 JSON 변환하여 넘김
	        model.addObject("popupList", modulePopupInfoService.selectModuleMainPopupList(paramVO));
	        
	        return model;
	    }
	
	
	
	@RequestMapping(value="/**/siteInfo/scrinPopupSliderAjax.do")
	public String scrinPopupSliderAjax(
			@ModelAttribute("paramVO") ModulePopupInfoVO paramVO
	        , HttpServletRequest request  
	        , Model model ) throws Exception {
		try{

	        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
	        
	        paramVO.setSiteSeq(siteSeq); 
	        
	        SysMngrSiteAdiInfoVO sysMngrSiteAdiInfoVO = new SysMngrSiteAdiInfoVO();
	        sysMngrSiteAdiInfoVO.setSiteSeq(siteSeq);
	        SysMngrSiteAdiInfoVO SysMngrSiteAdiInfo = new SysMngrSiteAdiInfoVO();
	        SysMngrSiteAdiInfo = sysMngrSiteAdiInfoService.selectSiteAdiInfoDetail(sysMngrSiteAdiInfoVO);
	        // 컨텐츠 데이터를 가져옴
	     //   List<SiteHdftrMenuVO> resultList = siteHdftrMenuService.selectSiteHdftrMenuList(paramVO);
	        paramVO.setLcalsCode(SysMngrSiteAdiInfo.getSiteLclasGroup());
	        paramVO.setMlsfcCode(SysMngrSiteAdiInfo.getSiteMlsfcGroup());
			 	model.addAttribute("popupList", modulePopupInfoService.selectModuleMainPopupList(paramVO));
		}catch(NullPointerException e){
	       	 log.error("NullPointerException",e);
	   	}catch(NumberFormatException e){
	   		log.error("NumberFormatException",e);
	   	}catch(IllegalFormatException e){
	   		log.error("IllegalFormatException",e);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		log.error("ArrayIndexOutOfBoundsException",e);
	   	}catch(SQLException e){
	   		log.error("SQLException",e);
	   	}
		
		return "wzwg/module/popup/popupMainSlider";
	}
	
    /**
	 * 사이트 메뉴 정보 조회
	 * @param siteMenuVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value= {"/mngr/screen/selectSiteScreenTempltListAjax.do","/{siteKey}/mngr/screen/selectSiteScreenTempltListAjax.do"})
	public String selectSiteScreenTempltListAjax(
		@ModelAttribute("paramVO")SysMngrTemplateVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		paramVO.setPageUnit(propertyService.getInt("pageUnit"));
		paramVO.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(9);
		paginationInfo.setPageSize(paramVO.getPageSize());

		paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
		paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		paramVO.setExpsrAt("Y");
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		paramVO.setDomnSeq(CmmSessionUtil.getSessionDomnSeq(request));
		
		// 사이트 정보 목록
		int resultCnt = sysMngrTemplateService.selectTemplateScreenCnt(paramVO);
		
		paginationInfo.setTotalRecordCount(resultCnt);
		
		/* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
		
		
		model.addAttribute("templtList", sysMngrTemplateService.selectTemplateScreenList(paramVO));
		model.addAttribute("templateLclCode", codeService.selectCmmCodeList("TEMPLATE_LCL_CODE"));
		model.addAttribute("templateMclCode", codeService.selectCmmCodeList("TEMPLATE_MCL_CODE"));
		model.addAttribute("resultCnt", resultCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("paramVO", paramVO);
 
		return "wzwg/site/mngr/screen/siteScreenTempltList";
	}
	
	
	@RequestMapping(value= {"/mngr/screen/selectSiteScreenTempltInfoAjax.do","/{siteKey}/mngr/screen/selectSiteScreenTempltInfoAjax.do"})
	public String selectSiteScreenTempltInfoAjax(
		@ModelAttribute("paramVO")SysMngrTemplateVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		try{
				
			 	model.addAttribute("templtVO", sysMngrTemplateService.selectTemplateScreen(paramVO));
		}catch(NullPointerException e){
	       	 log.error("NullPointerException",e);
	   	}catch(NumberFormatException e){
	   		log.error("NumberFormatException",e);
	   	}catch(IllegalFormatException e){
	   		log.error("IllegalFormatException",e);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		log.error("ArrayIndexOutOfBoundsException",e);
	   	}catch(SQLException e){
	   		log.error("SQLException",e);
	   	}
		
		return "wzwg/site/mngr/screen/siteScreenTempltInfo";
	}
	
	@RequestMapping(value={"/mngr/screen/selectSiteScreenTempltMain.do","/{siteKey}/mngr/screen/selectSiteScreenTempltMain.do"})
	public String selectSiteScreenTempltMain(
		@ModelAttribute("paramVO")SiteTemplateScreenVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		String domnSeq = CmmSessionUtil.getSessionDomnSeq(request);
		paramVO.setSiteSeq(siteSeq);
		paramVO.setDomnSeq(domnSeq); 
		//siteScreenVO.setSiteSeq(siteSeq);
//		String realPath =request.getServletContext().getRealPath("/");
	//	Map<String, Object> siteMenuList = siteScreenService.selectSiteMenuMngrList(siteScreenVO);
/**		
		String siteTempltStr =realPath+EgovProperties.getProperty("defaultTempltFolderstorePath");
		File siteTempltDir = new File(siteTempltStr);
		File[] fileList = siteTempltDir.listFiles(); 
		ArrayList fileDirList = new ArrayList();
		for(int i =0;i<fileList.length;i++){
			File dir = fileList[i];
			HashMap<String,String> map = new HashMap<String,String>();
			if(dir.isDirectory()){
				map.put("dirName", dir.getName());
				map.put("dirPath", dir.getPath());
				map.put("dirUrl", "/"+EgovProperties.getProperty("defaultTempltFolderstorePath"));
				fileDirList.add(map);
			}
		}
		**/
		SysMngrTemplateVO sysMngrTemplateVO = new SysMngrTemplateVO();
		sysMngrTemplateVO.setExpsrAt("Y");
		sysMngrTemplateVO.setSiteSeq(siteSeq);
		
		model.addAttribute("templtVO", siteTemplateScreenService.selectSiteTemplateScreen(paramVO));
		model.addAttribute("layoutList", siteTemplateScreenService.selectSiteTemplateLayoutScreenList(paramVO));
		model.addAttribute("templateCtgryCode", sysMngrTemplateService.selectTemplateCategoryScreenList(sysMngrTemplateVO));
		
		return "wzwg/site/mngr/screen/siteScreenTempltMain";
	}
	
	/**
	 * 사이트 메뉴 정보 조회
	 * @param siteMenuVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value= {"/mngr/screen/selectSiteScreenIndexMngr.do","/{stieKey}/mngr/screen/selectSiteScreenIndexMngr.do"})
	public String selectSiteScreenIndexMngr(
		@ModelAttribute("paramVO")SiteScreenVO siteScreenVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		String retUrl = "wzwg/site/mngr/screen/siteScreenMngr";
		try{
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteScreenVO.setSiteSeq(siteSeq);
		String realPath =request.getServletContext().getRealPath("/");
	//	Map<String, Object> siteMenuList = siteScreenService.selectSiteMenuMngrList(siteScreenVO);
		String siteDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request);
		File siteDir = new File(siteDirStr);
		if(!siteDir.exists()){
			if(!siteDir.mkdirs()) {
				log.info("directory not make");
			}
		}
		
		SiteTemplateScreenVO siteTemplateScreenParam = new SiteTemplateScreenVO();
		
		/**도메인 SEQ */
		String domnSeq = CmmSessionUtil.getSessionDomnSeq(request);
		siteTemplateScreenParam.setSiteSeq(siteSeq);
		siteTemplateScreenParam.setDomnSeq(domnSeq);
		siteTemplateScreenParam.setUserId(CmmSessionUtil.getSessionUserId());
		
		SiteTemplateScreenVO siteTemplateScreenVO = siteTemplateScreenService.selectSiteTemplateScreen(siteTemplateScreenParam);
		if(siteTemplateScreenVO.getTemplateNcnm().equals("drag")){
			retUrl = "wzwg/site/mngr/screen/siteScreenDragMngr";
		}
		
		File indexFile = new File(siteDirStr+"/index.jsp");
		if(!indexFile.exists()){
			FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+EgovProperties.getProperty("defaultTempltJsp")), indexFile);
		}
		
		File topFile = new File(siteDirStr+"/topMenu.jsp");
		
		File footerFile = new File(siteDirStr+"/footerMenu.jsp");
		if(!topFile.exists()){
			FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"topMenu.jsp"), topFile);
		}
		if(!footerFile.exists()){
			FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"footerMenu.jsp"), footerFile);
		}
		
		ArrayList<String> indexList = new ArrayList<String>();
		String backDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/backup";

		String siteCssDirStr =realPath+"site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/css";
		File siteCssDir = new File(siteCssDirStr);
			if(!siteCssDir.exists()){
				if(!siteCssDir.mkdirs()) {
					log.info("directory not make");
				}
				FileUtils.copyDir(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"css"), siteCssDir);
			}
		   
	
		ScrinMenuVO scrinMenuVO = new ScrinMenuVO();
		scrinMenuVO.setSiteSeq(siteSeq);
		model.addAttribute("moduleSGC0000027",siteScreenService.selectModuleMenuList("10000000003", CmmSessionUtil.getSessionSiteSeq(request)));
		model.addAttribute("module10000000104",siteScreenService.selectModuleMenuList("10000000104", CmmSessionUtil.getSessionSiteSeq(request)));
		model.addAttribute("module10000000204",siteScreenService.selectModuleMenuList("10000000204", CmmSessionUtil.getSessionSiteSeq(request)));
		model.addAttribute("module10000000213",siteScreenService.selectModuleMenuList("10000000213", CmmSessionUtil.getSessionSiteSeq(request)));
		model.addAttribute("module10000000218",siteScreenService.selectModuleMenuList("10000000218", CmmSessionUtil.getSessionSiteSeq(request)));
		model.addAttribute("backupIndexList", siteScreenService.selectTemplateBackupInfoList(siteScreenVO));
		model.addAttribute("moduleList",siteScreenService.selectModuleList("SGC0000021", CmmSessionUtil.getSessionSiteSeq(request)));
		model.addAttribute("firstNttMenuSeq", siteScreenService.selectFirstNttMenuSeq(scrinMenuVO));
		model.addAttribute("siteTemplateScreenVO",siteTemplateScreenVO);
		model.addAttribute("siteScreenVO", siteScreenVO);
		if("".equals(siteScreenVO.getBackup())){
				if(siteScreenVO.getTempYn() !=null && !siteScreenVO.getTempYn().equals("") && siteScreenVO.getTempYn().equals("Y")){
					model.addAttribute("url", "/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/temp/index.jsp");
				}else{
					model.addAttribute("url", "/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/index.jsp");
				}
			model.addAttribute("topUrl", "/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/topMenu.do");
			model.addAttribute("footerUrl", "/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/footerMenu.jsp");
		}else{
			siteScreenVO.setTmpbakupSeq(siteScreenVO.getBackup());
			SiteScreenVO siteScreen =siteScreenService.selectTemplateBackupInfo(siteScreenVO);
			model.addAttribute("url", "/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/backup/"+siteScreen.getIndexFileNm());
			model.addAttribute("topUrl", "/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/topMenu.do");
			model.addAttribute("footerUrl", "/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/backup/"+siteScreen.getLptmenuFileNm());
		}
		}catch(NullPointerException e){
	       	 log.error("NullPointerException",e);
	   	}catch(NumberFormatException e){
	   		log.error("NumberFormatException",e);
	   	}catch(IllegalFormatException e){
	   		log.error("IllegalFormatException",e);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		log.error("ArrayIndexOutOfBoundsException",e);
	   	}catch(SQLException e){
	   		log.error("SQLException",e);
	   	}catch(IOException e){
	   		log.error("IOException",e);
	   	}
		return retUrl;
	}
	
	/**
	 * 최종 저장 편집 템플릿 사용자 홈페이지로 적용하기
	 * @param siteMenuVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value= {"/mngr/screen/changeSiteScreenTemplt.do","/{siteKey}/mngr/screen/changeSiteScreenTemplt.do"})
	public String changeSiteScreenTemplt(
		@ModelAttribute("paramVO")SiteTemplateScreenVO paramVO
		, SysMngrTemplateVO sysMngrTemplateVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		/**도메인 SEQ */
		String domnSeq = CmmSessionUtil.getSessionDomnSeq(request);
		
		// 경로에 사용되는 seq 값 검증
		if (!SecurePathValidator.isValidNumericPath(siteSeq) || 
		    !SecurePathValidator.isValidNumericPath(domnSeq) ||
		    !SecurePathValidator.isValidNumericPath(paramVO.getTemplateSeq())) {
		    throw new IOException("Invalid Path Input");
		}
		
		paramVO.setSiteSeq(siteSeq);
		paramVO.setDomnSeq(domnSeq);
		paramVO.setUserId(CmmSessionUtil.getSessionUserId());
		if(siteTemplateScreenService.selectSiteTemplateScreenChk(paramVO) < 1){
    		siteTemplateScreenService.registSiteTemplateScreen(paramVO);
		}else{
			siteTemplateScreenService.modifySiteTemplateScreen(paramVO);
		}

		String realPath = request.getSession().getServletContext().getRealPath("/");
		String siteTemplateDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+paramVO.getTemplateSeq();
		String siteTemplateCssDirStr =realPath+"site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+paramVO.getTemplateSeq()+"/css";
		File siteTemplateDir = new File(EgovWebUtil.filePathBlackList(siteTemplateDirStr));
		File siteTemplateCssDir = new File(EgovWebUtil.filePathBlackList(siteTemplateCssDirStr));
		String siteCssDirStr =realPath+"site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/css";
		File siteCssDir = new File(siteCssDirStr);
		if(siteTemplateDir.exists()){
			String siteDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request);
			File siteDir = new File(siteDirStr);
			// TOCTOU 방지를 위한 synchronized 블록
			synchronized(this) {
				if(siteDir.exists()){
					try {
						if(!siteDir.delete()) {
							log.info("directory not delete");
						}
					} catch (SecurityException e) {
						log.error("site/siteseq dir delete Exception", e);
					}
				}
			}
		
			if(!siteDir.exists()){
				if(!siteDir.mkdirs()) {
					log.info("directory not make");
				}
			}
			String siteDirTempStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/temp";
			File siteTempDir = new File(siteDirTempStr);
			if(siteTempDir.exists()){
				FileUtils.deleteDir(siteTempDir); 
			}
			/* moo0506 서브페이지가 개별로 만들어지는데 sub_{링크번호}.jsp 가 있으면 신규 템플릿으로 덮어 씌우는게 아니라 기존것을 사용하기 때문에 미리 삭제해준다*/
			/* 템플릿에 미리 변경되어 있는 파일이 있을경우 복사되기 때문에 기존것들은 삭제한다 */
			File []siteFiles = siteDir.listFiles();
			if(siteFiles !=null) {
			// TOCTOU 방지를 위한 synchronized 블록
			synchronized(this) {
				for (File subFile : siteFiles) {
					if(subFile.getName().indexOf("sub_") >= 0){
						if(!subFile.delete()) {
							log.info("subFile not delete");
						}
					}
				}	
			}
		}
			FileUtils.copyDir(siteTemplateDir, siteDir);
			FileUtils.copyDir(siteTemplateCssDir, siteCssDir);
			
			
		}else{
		SiteTemplateScreenVO siteTemplateScreenVO = siteTemplateScreenService.selectSiteTemplateScreen(paramVO);
	//	Map<String, Object> siteMenuList = siteScreenService.selectSiteMenuMngrList(siteScreenVO);
		String siteDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request);
		File siteDir = new File(siteDirStr);
		// TOCTOU 방지를 위한 synchronized 블록
		synchronized(this) {
			if(siteDir.exists()){
				try {
					if(!siteDir.delete()) {
						log.info("directory not delete");
					}
				} catch (SecurityException e) {
					log.error("site/siteseq dir delete Exception", e);
				}
			}
		}
		if(!siteDir.exists()){
			if(!siteDir.mkdirs()) {
				log.info("directory not make");
			}
		}
		String siteDirTempStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/temp";
		File siteTempDir = new File(siteDirTempStr);
		if(siteTempDir.exists()){
			FileUtils.deleteDir(siteTempDir); 
		}
	
		if(!siteCssDir.exists()){
			if(!siteCssDir.mkdirs()) {
				log.info("directory not make");
			}
		}
		
		File[] subFileList = siteDir.listFiles();
		if(subFileList != null) {
		// TOCTOU 방지를 위한 synchronized 블록
		synchronized(this) {
			for(int i =0;i<subFileList.length;i++){
				File subFile = subFileList[i];
				if(subFile.getName().startsWith("sub_")){
					if(!subFile.delete()){
						log.info("file not delete");
					}
				}
				
			}
		}
		}
        File templtFile = new File(siteDirStr+File.separator+"templat.jsp");
        /*
        if(templtFile.exists()){
            templtFile.delete();
        }
        FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"templat.jsp"), templtFile);
        */
        
        // template.jsp 파일도 서브페이지 편집화면에서 컨트롤이 되도록 변경하므로 삭제하지 않고 없을경우 복사하도록 변경
        if(templtFile.exists() == false){
        	FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"templat.jsp"), templtFile);
        }
        
        File subusrFile = new File(siteDirStr+File.separator+"usrSub.jsp");
        /*
        if(subusrFile.exists()){
            subusrFile.delete();
        }
        FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"usrSub.jsp"), subusrFile);
        */
        
        // usrSub.jsp 파일도 서브페이지 편집화면에서 컨트롤이 되도록 변경하므로 삭제하지 않고 없을경우 복사하도록 변경
        if(subusrFile.exists() == false){
        	FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"usrSub.jsp"), subusrFile);
        }

            
		File indexFile = new File(siteDirStr+"/index.jsp");
		if(indexFile.exists()){
			if(!indexFile.delete()){
				log.info("file not delete");
			}
		}
		FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+EgovProperties.getProperty("defaultTempltJsp")), indexFile);		
		File topFile = new File(siteDirStr+"/topMenu.jsp");
		
		File footerFile = new File(siteDirStr+"/footerMenu.jsp");
		if(topFile.exists()){
			if(!topFile.delete()){
				log.info("file not delete");
			}
		}
		FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"topMenu.jsp"), topFile);
		if(footerFile.exists()){
			if(!footerFile.delete()){
				log.info("file not delete");
			}
		}
		FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"footerMenu.jsp"), footerFile);
		
		 
		
		File subHeadFile = new File(siteDirStr+"/subHead.jsp");
		if(subHeadFile.exists()){
			if(!subHeadFile.delete()){
				log.info("file not delete");
			}
			
		}  
		FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"subHead.jsp"), subHeadFile);

		File leftFile = new File(siteDirStr+"/leftMenu.jsp");
		if(leftFile.exists()){
			if(!leftFile.delete()){
				log.info("file not delete");
			}
		}  
		
		FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"leftMenu.jsp"), leftFile);
		
		 
		
	
		FileUtils.copyDir(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"css"), siteCssDir);
		
		ArrayList<String> indexList = new ArrayList<String>();
		String backDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/backup";
		File backupDir = new File(backDirStr);
		if(backupDir.exists()){
		File[] indexFiles=	backupDir.listFiles(new FileFilter(){
				public boolean accept(File f){
					return f.getName().startsWith("index");
				}
			});
		if(indexFiles != null) {
		  Arrays.sort(indexFiles, new Comparator() {
			   public int compare(Object arg0, Object arg1) {
			    File file1 = (File)arg0;
			    File file2 = (File)arg1;
			    return file1.getName().compareToIgnoreCase(file2.getName());
			   }
			  });
		  for(int i =0;i<indexFiles.length;i++){
			  indexList.add(indexFiles[i].getName());
			  Collections.sort(indexList, Collections.reverseOrder());
		  }
		}
		}
		ScrinMenuVO scrinMenuVO = new ScrinMenuVO();
		scrinMenuVO.setSiteSeq(siteSeq); 
		}
		
		sysMngrTemplateVO.setSiteSeq(siteSeq);
		sysMngrTemplateVO.setDomnSeq(domnSeq);
		sysMngrTemplateVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId()); 
		sysMngrTemplateVO.setFrstRegistIp(request.getRemoteAddr());
		 sysMngrTemplateService.registTemplatereflct(sysMngrTemplateVO);
			String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		
//		return "redirect:/mngr/screen/selectSiteScreenTempltMain.do";
		return "redirect:"+wzwgContext+"/mngr/screen/selectSiteScreenTempIndexMngr.do?templateSeq="+sysMngrTemplateVO.getTemplateSeq();
	}
	
	
	@RequestMapping(value= {"/mngr/screen/changeTempSiteScreenTemplt.do","/{siteKey}/mngr/screen/changeTempSiteScreenTemplt.do"})
	public String changeTempSiteScreenTemplt(
		@ModelAttribute("paramVO")SysMngrTemplateVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		/**도메인 SEQ */
		String domnSeq = CmmSessionUtil.getSessionDomnSeq(request);
		paramVO.setSiteSeq(siteSeq);
		paramVO.setDomnSeq(domnSeq);
		paramVO.setUserId(CmmSessionUtil.getSessionUserId()); 
		SysMngrTemplateVO sysMngrTemplateVO = sysMngrTemplateService.selectTemplateScreen(paramVO);
		String realPath =request.getServletContext().getRealPath("/");
	//	Map<String, Object> siteMenuList = siteScreenService.selectSiteMenuMngrList(siteScreenVO);
		String siteDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request);
		//String siteCssDirStr =realPath+"site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/css_temp";
		File siteDir = new File(siteDirStr);
		if(!siteDir.exists()){
			if(!siteDir.mkdirs()) {
				log.info("directory not make");
			}
		}
		 
		//File siteCssDir = new File(siteCssDirStr);
		//if(!siteCssDir.exists()){
		//	siteCssDir.mkdirs();
		//}
		
		/**
		File[] subFileList = siteDir.listFiles();
		for(int i =0;i<subFileList.length;i++){
			File subFile = subFileList[i];
			if(subFile.getName().startsWith("sub_")){
				subFile.delete();
			}
			
		}
		**/
		 File templtFile = new File(siteDirStr+File.separator+"templat_temp.jsp");
	        // TOCTOU 방지를 위한 synchronized 블록
	        synchronized(this) {
		        if(templtFile.exists()){
		        	try {
		        		if(!templtFile.delete()) {
		        			log.info("directory not delete");
		        		}
					} catch (SecurityException e) {
						log.error("siteDirStr templat_temp file SecurityException", e);
					}
		        	
		        }
	        }
         //FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"templat.jsp"), templtFile);
	     
	        
	        // todo template.jsp 파일도 서브페이지 편집화면에서 컨트롤이 되도록 변경하므로 삭제하지 않고 없을경우 복사하도록 변경
	        //if(templtFile.exists() == false){
	        //	FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"templat.jsp"), templtFile);
	        //}
	        
         File subusrFile = new File(siteDirStr+File.separator+"usrSub.jsp");
         /*
         if(subusrFile.exists()){
             subusrFile.delete();
         }
         FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"usrSub.jsp"), subusrFile);
         */
         // usrSub.jsp 파일도 서브페이지 편집화면에서 컨트롤이 되도록 변경하므로 삭제하지 않고 없을경우 복사하도록 변경
         if(subusrFile.exists() == false){
         	FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"usrSub.jsp"), subusrFile);
         }
         
         
		File indexFile = new File(siteDirStr+"/index_temp.jsp");
		// TOCTOU 방지를 위한 synchronized 블록
		synchronized(this) {
			if(indexFile.exists()){
				try {
					if(!indexFile.delete()) {
						log.info("directory not delete");
					}
				} catch (SecurityException e) {
					log.error("siteDirStr index_temp file SecurityException", e);
				}
			}
		}
		FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+EgovProperties.getProperty("defaultTempltJsp")), indexFile);		
		File topFile = new File(siteDirStr+"/topMenu_temp.jsp.jsp");
		
		File footerFile = new File(siteDirStr+"/footerMenu_temp.jsp");
		if(topFile.exists()){
			if(!topFile.delete()) {
				log.info("directory not delete");
			}
		}
		FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"topMenu.jsp"), topFile);
		if(footerFile.exists()){
			if(!footerFile.delete()) {
				log.info("directory not delete");
			}
		}
		FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"footerMenu.jsp"), footerFile);
		
		 
		
		File subHeadFile = new File(siteDirStr+"/subHead_temp.jsp");
		if(subHeadFile.exists()){
			if(!subHeadFile.delete()) {
				log.info("directory not delete");
			}
			
		}  
		FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"subHead.jsp"), subHeadFile);

		File leftFile = new File(siteDirStr+"/leftMenu_temp.jsp");
		if(leftFile.exists()){
			if(!leftFile.delete()) {
				log.info("directory not delete");
			}
		}  
		
		FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"leftMenu.jsp"), leftFile);
		
		 
		
		//if(siteCssDir.exists()){
		//	FileUtils.deleteDir(siteCssDir);
        //}
		//FileUtils.copyDir(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"css"), siteCssDir);
		 
		ScrinMenuVO scrinMenuVO = new ScrinMenuVO();
		scrinMenuVO.setSiteSeq(siteSeq); 
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		 
		return "redirect:"+wzwgContext+"/mngr/screen/selectSiteScreenTempltMain.do";
	}
	
	@RequestMapping(value= {"/mngr/screen/selectSiteScreenMobileIndexMngr.do","/{siteKey}/mngr/screen/selectSiteScreenMobileIndexMngr.do"})
	public String selectSiteScreenMobileIndexMngr(
		@ModelAttribute("paramVO")SiteScreenVO siteScreenVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		try{
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteScreenVO.setSiteSeq(siteSeq);
		String realPath =request.getServletContext().getRealPath("/");
	//	Map<String, Object> siteMenuList = siteScreenService.selectSiteMenuMngrList(siteScreenVO);
		String siteDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request);
		File siteDir = new File(siteDirStr);
		if(!siteDir.exists()){
			if(!siteDir.mkdirs()) {
				log.info("directory not make");
			}
		}
		File indexFile = new File(siteDirStr+"/index.jsp");
		
		File indexMobileFile = new File(siteDirStr+"/mIndex.jsp");
		if(!indexMobileFile.exists()){
			FileUtils.copyFile(indexFile, indexMobileFile);
		}
		
		File topFile = new File(siteDirStr+"/topMenu.jsp");
		
		File footerFile = new File(siteDirStr+"/footerMenu.jsp");
		if(!topFile.exists()){
			FileUtils.copyFile(new File(realPath+EgovProperties.getProperty("defaultTempltstorePath")+"topMenu.jsp"), topFile);
		}
		if(!footerFile.exists()){
			FileUtils.copyFile(new File(realPath+EgovProperties.getProperty("defaultTempltstorePath")+"footerMenu.jsp"), footerFile);
		}
		
		ArrayList<String> indexList = new ArrayList<String>();
		String backDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/backup";
		File backupDir = new File(backDirStr);
		if(backupDir.exists()){
		File[] indexFiles=	backupDir.listFiles(new FileFilter(){
				public boolean accept(File f){
					return f.getName().startsWith("index");
				}
			});
		if(indexFiles !=null) {
		  Arrays.sort(indexFiles, new Comparator() {
			   public int compare(Object arg0, Object arg1) {
			    File file1 = (File)arg0;
			    File file2 = (File)arg1;
			    return file1.getName().compareToIgnoreCase(file2.getName());
			   }
			  });
		  for(int i =0;i<indexFiles.length;i++){
			  indexList.add(indexFiles[i].getName());
			  Collections.sort(indexList, Collections.reverseOrder());
		  }
		}
		}
		ScrinMenuVO scrinMenuVO = new ScrinMenuVO();
		scrinMenuVO.setSiteSeq(siteSeq);
		model.addAttribute("moduleSGC0000027",siteScreenService.selectModuleMenuList("10000000003", CmmSessionUtil.getSessionSiteSeq(request)));
		model.addAttribute("module10000000104",siteScreenService.selectModuleMenuList("10000000104", CmmSessionUtil.getSessionSiteSeq(request)));
		model.addAttribute("module10000000204",siteScreenService.selectModuleMenuList("10000000204", CmmSessionUtil.getSessionSiteSeq(request)));
		model.addAttribute("module10000000213",siteScreenService.selectModuleMenuList("10000000213", CmmSessionUtil.getSessionSiteSeq(request)));
		model.addAttribute("backupIndexList", indexList);
		model.addAttribute("moduleList",siteScreenService.selectModuleList("SGC0000021", CmmSessionUtil.getSessionSiteSeq(request)));
		model.addAttribute("firstNttMenuSeq", siteScreenService.selectFirstNttMenuSeq(scrinMenuVO));
		if("".equals(siteScreenVO.getBackup())){
			model.addAttribute("url", "/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/mIndex.jsp");
			model.addAttribute("topUrl", "/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/topMenu.do");
			model.addAttribute("footerUrl", "/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/footerMenu.jsp");
		}else{
			model.addAttribute("url", "/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/backup/"+siteScreenVO.getBackup());
			model.addAttribute("topUrl", "/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/topMenu.do");
			model.addAttribute("footerUrl", "/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/footerMenu.jsp");
		}
		}catch(NullPointerException e){
	       	 log.error("NullPointerException",e);
	   	}catch(NumberFormatException e){
	   		log.error("NumberFormatException",e);
	   	}catch(IllegalFormatException e){
	   		log.error("IllegalFormatException",e);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		log.error("ArrayIndexOutOfBoundsException",e);
	   	}catch(SQLException e){
	   		log.error("SQLException",e);
	   	}catch(IOException e){
	   		log.error("IOException",e);
	   	}
		return "wzwg/site/mngr/screen/siteScreenMobileMngr";
	}
	
	/**
	 * 사이트 메뉴 정보 조회
	 * @param siteMenuVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value= {"/mngr/screen/siteScreenSave.do","/{siteKey}/mngr/screen/siteScreenSave.do"})
	public String siteScreenSave(
		@ModelAttribute("paramVO")SiteScreenVO siteScreenVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteScreenVO.setSiteSeq(siteSeq);
		String realPath =request.getServletContext().getRealPath("/");
		String siteDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request);
		String backDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/backup";
		
		String cssDirStr =realPath+"site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/css";
		FileInputStream  fis = null;
		InputStreamReader isr = null;
		BufferedReader br = null;
		FileWriter fw = null;
		FileWriter writer = null;
		BufferedWriter bw = null;
		try {
		File siteDir = new File(siteDirStr);
		File backDir = new File(backDirStr);
		if(!siteDir.exists()){
			if(!siteDir.mkdirs()) {
				log.info("directory not make");
			}
		}
		File indexFile = new File(siteDirStr+"/index.jsp");
		File topFile = new File(siteDirStr+"/topMenu.jsp");
		File footerFile = new File(siteDirStr+"/footerMenu.jsp");
        File cssHeadmenu00 = new File(cssDirStr+"/headmenu00.css");
        File cssHeadmenu01 = new File(cssDirStr+"/headmenu01.css");
        File cssHeadmenu02 = new File(cssDirStr+"/headmenu02.css");
		if(!backDir.exists()){
			if(!backDir.mkdirs()) {
				log.info("directory not make");
			}
		}
		
		String currYear = DateUtils.getCurrentDate("yyyy");
		String currMonth = DateUtils.getCurrentDate("MM");
		String currDay = DateUtils.getCurrentDate("dd");
		String currHour = DateUtils.getCurrentDate("HH");
		String currMinute = DateUtils.getCurrentDate("mm");
		String currSec = DateUtils.getCurrentDate("ss");
		String currTime = currYear+currMonth+currDay+currHour+currMinute+currSec;
		String backupNm = currYear+egovMessageSource.getMessage("wzwg.cmm.word.yy")+currMonth+egovMessageSource.getMessage("wzwg.cmm.word.mon01")+currDay+egovMessageSource.getMessage("wzwg.cmm.word.de")+currHour+egovMessageSource.getMessage("wzwg.cmm.word.hour")+currMinute+egovMessageSource.getMessage("wzwg.cmm.word.minute")+currSec+egovMessageSource.getMessage("wzwg.cmm.word.second02");
		
		if(indexFile.exists()){
			FileUtils.copyFile(indexFile, new File(backDirStr+"/index_"+currTime+".jsp"));
		}
		
		if(topFile.exists()){
			FileUtils.copyFile(topFile, new File(backDirStr+"/topMenu_"+currTime+".jsp"));
		}
		
		fis = new FileInputStream(new File(backDirStr+"/topMenu_"+currTime+".jsp"));
		isr = 		new InputStreamReader(fis);
		br = new BufferedReader(isr);

		String line;
		String dummy="";
		SiteTemplateScreenVO siteTemplateScreenParam = new SiteTemplateScreenVO();
		
		/**도메인 SEQ */
		String domnSeq = CmmSessionUtil.getSessionDomnSeq(request);
		siteTemplateScreenParam.setSiteSeq(siteSeq);
		siteTemplateScreenParam.setDomnSeq(domnSeq);
		siteTemplateScreenParam.setUserId(CmmSessionUtil.getSessionUserId());
		SiteTemplateScreenVO siteTemplateScreenVO = siteTemplateScreenService.selectSiteTemplateScreen(siteTemplateScreenParam);
		String cssUrl = "/"+siteTemplateScreenVO.getTemplateStreCours()+"css/headmenu00.css";
		try {
			// TOCTOU 방지를 위한 synchronized 블록
			synchronized(this) {
				while((line = br.readLine())!=null) {
					if(line.indexOf("id=\"headmenu\"")>-1){
						dummy += (line.replaceAll("href=\"(.*?)\"", "href=\""+cssUrl+" \"") + "\r\n" );
					}else{
						dummy += (line + "\r\n" );
					}
					
				}
			}
		} catch (IOException e) {
			log.error("backDirStr topMenu_ file IOException", e);
		}

		fw = new FileWriter(new File(backDirStr+"/topMenu_"+currTime+".jsp"));
		fw.write(dummy);			
		//bw.close();
		fw.close();
		br.close();
	
		
		
		if(footerFile.exists()){
			FileUtils.copyFile(footerFile, new File(backDirStr+"/footerMenu_"+currTime+".jsp"));
		}
		siteScreenVO.setBackupNm(backupNm);
		siteScreenVO.setIndexFileNm("index_"+currTime+".jsp");
		siteScreenVO.setUpendmenuFileNm("topMenu_"+currTime+".jsp");
		siteScreenVO.setLptmenuFileNm("footerMenu_"+currTime+".jsp");
		siteScreenService.registTemplateBackupInfo(siteScreenVO);
		if(!"".equals(siteScreenVO.getTopMenuSe())){
			if("1".equals(siteScreenVO.getTopMenuSe())){
				if(cssHeadmenu00.exists()){
					if(!cssHeadmenu00.delete()) {
						log.info("directory not delete");
					}
				}
				FileUtils.copyFile(cssHeadmenu01, cssHeadmenu00);
			}
			
			if("2".equals(siteScreenVO.getTopMenuSe())){
				if(cssHeadmenu00.exists()){
					if(!cssHeadmenu00.delete()) {
						log.info("directory not delete");
					}
				}
				FileUtils.copyFile(cssHeadmenu02, cssHeadmenu00);
			}
		}
		/**
		FileWriter topWriter = new FileWriter(topFile);
		BufferedWriter topBw = new BufferedWriter(topWriter);
		topBw.write("<%@ page language=\"java\" contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>"); 
		topBw.newLine();
		topBw.write(siteScreenVO.getTopContents());	
		topBw.newLine(); 
		topBw.close();
		topWriter.close();
		
		
		FileWriter footerWriter = new FileWriter(footerFile);
		BufferedWriter footerBw = new BufferedWriter(footerWriter);
		footerBw.write("<%@ page language=\"java\" contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>"); 
		footerBw.newLine();
		footerBw.write(siteScreenVO.getFooterContents());	
		footerBw.newLine(); 
		footerBw.close();
		footerWriter.close();
		**/
		  writer = new FileWriter(indexFile);
		  bw = new BufferedWriter(writer);
		bw.write("<%@ page language=\"java\" contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>");
		bw.newLine();
       	bw.write("<%@ include file=\"/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp\" %>");
       	bw.newLine();
       	bw.write("<c:import url=\""+"/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/topMenu.do\"></c:import>");
		bw.newLine();
       	bw.write(siteScreenVO.getContents());	
		bw.newLine(); 
		bw.write("<c:import url=\""+"${footerUrl}\"></c:import>");
		bw.newLine();
		bw.close();
		writer.close(); 
		if(siteScreenVO.getBackup() !=null && !siteScreenVO.getBackup().equals("")){
			siteScreenVO.setTmpbakupSeq(siteScreenVO.getBackup());
			SiteScreenVO siteScreen =siteScreenService.selectTemplateBackupInfo(siteScreenVO);
			System.out.println("siteScreen.getLptmenuFileNm() : "+siteScreen.getLptmenuFileNm());
			FileUtils.copyFile(new File(backDirStr+"/"+siteScreen.getLptmenuFileNm()), footerFile);
			FileUtils.copyFile(new File(backDirStr+"/"+siteScreen.getUpendmenuFileNm()), topFile);
		}
		}catch (IOException e) {
			// TODO: handle exception
			log.error("IOException",e);
		}finally {
			  if(fw != null) try { fw.close(); } catch(IOException e) {log.error("IOException",e);}
			    if(br != null) try { br.close(); } catch(IOException e) {log.error("IOException",e);}
			    if(fis != null) try { fis.close(); } catch(IOException e) {log.error("IOException",e);}
			    if(isr != null) try { isr.close(); } catch(IOException e) {log.error("IOException",e);}
			    if(bw != null) try { bw.close(); } catch(IOException e) {log.error("IOException",e);}
			    if(writer != null) try { writer.close(); } catch(IOException e) {log.error("IOException",e);}   
			 
		 
		}

		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		return "redirect:"+wzwgContext+"/mngr/screen/selectSiteScreenIndexMngr.do";
	}
	
	
	
	/**
	 * 사이트 메뉴 정보 조회
	 * @param siteMenuVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value= {"/mngr/screen/siteScreenTempIndexSave.do","/{siteKey}/mngr/screen/siteScreenTempIndexSave.do"})
	public String siteScreenTempIndexSave(
		@ModelAttribute("paramVO")SiteScreenVO siteScreenVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteScreenVO.setSiteSeq(siteSeq);
		String realPath =request.getServletContext().getRealPath("/");
		String siteDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/temp";
		String backDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/temp/backup";
		
		String cssDirStr =realPath+"site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/temp/css";
		
		File siteDir = new File(siteDirStr);
		File backDir = new File(backDirStr);
		if(!siteDir.exists()){
			if(!siteDir.mkdirs()) {
				log.info("directory not make");
			}
		}
		File indexFile = new File(siteDirStr+"/index.jsp");
		File topFile = new File(siteDirStr+"/topMenu.jsp");
		File footerFile = new File(siteDirStr+"/footerMenu.jsp");
        File cssHeadmenu00 = new File(cssDirStr+"/headmenu00.css");
        File cssHeadmenu01 = new File(cssDirStr+"/headmenu01.css");
        File cssHeadmenu02 = new File(cssDirStr+"/headmenu02.css");
		if(!backDir.exists()){
			if(!backDir.mkdirs()) {
				log.info("directory not make");
			}
		}
		
		if(indexFile.exists()){
			FileUtils.copyFile(indexFile, new File(backDirStr+"/index_"+DateUtils.getCurrentDate("yyyyMMddHHmmss")+".jsp"));
		}
		if(!"".equals(siteScreenVO.getTopMenuSe())){
			if("1".equals(siteScreenVO.getTopMenuSe())){
				// TOCTOU 방지를 위한 synchronized 블록
				synchronized(this) {
					if(cssHeadmenu00.exists()){
						
						try {
							if(!cssHeadmenu00.delete()) {
								log.info("directory not delete");
							}
						} catch (SecurityException e) {
							log.error("backDirStr index_ file SecurityException" , e);
						}
					}
				}
				FileUtils.copyFile(cssHeadmenu01, cssHeadmenu00);
			}
			
			if("2".equals(siteScreenVO.getTopMenuSe())){
				// TOCTOU 방지를 위한 synchronized 블록
				synchronized(this) {
					if(cssHeadmenu00.exists()){
						if(!cssHeadmenu00.delete()) {
							log.info("directory not make");
						}
					}
				}
				FileUtils.copyFile(cssHeadmenu02, cssHeadmenu00);
			}
		}
		/**
		FileWriter topWriter = new FileWriter(topFile);
		BufferedWriter topBw = new BufferedWriter(topWriter);
		topBw.write("<%@ page language=\"java\" contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>"); 
		topBw.newLine();
		topBw.write(siteScreenVO.getTopContents());	
		topBw.newLine(); 
		topBw.close();
		topWriter.close();
		
		
		FileWriter footerWriter = new FileWriter(footerFile);
		BufferedWriter footerBw = new BufferedWriter(footerWriter);
		footerBw.write("<%@ page language=\"java\" contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>"); 
		footerBw.newLine();
		footerBw.write(siteScreenVO.getFooterContents());	
		footerBw.newLine(); 
		footerBw.close();
		footerWriter.close();
		**/
		FileWriter writer =null;
		BufferedWriter bw = null;
		try {
			  writer = new FileWriter(indexFile);
			  bw = new BufferedWriter(writer);
		bw.write("<%@ page language=\"java\" contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>");
		bw.newLine();
       	bw.write("<%@ include file=\"/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp\" %>");
       	bw.newLine();
       	bw.write("<c:import url=\""+"/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/topMenu.do\"></c:import>");
		bw.newLine();
       	bw.write(siteScreenVO.getContents());	
		bw.newLine(); 
		bw.write("<c:import url=\""+"${footerUrl}\"></c:import>");
		bw.newLine();
		bw.close();
		writer.close(); 
		}catch (IOException e) {
			// TODO: handle exception
			log.error("IOException",e);
		}finally {
			if(bw != null) try { bw.close(); } catch(IOException e) {log.error("IOException",e);}
		    if(writer != null) try { writer.close(); } catch(IOException e) {log.error("IOException",e);}
		}
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		return "redirect:"+wzwgContext+"/mngr/screen/selectSiteScreenIndexMngr.do?tempYn=Y";
	}
	
	
	
	@RequestMapping(value= {"/mngr/screen/selectSiteScreenTemplateInitMngr.do","/{siteKey}/mngr/screen/selectSiteScreenTemplateInitMngr.do"})
	public String selectSiteScreenTemplateInitMngr(
		@ModelAttribute("paramVO")SiteScreenVO siteScreenVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		try{
			/** 사이트 시퀀스 */
			String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
			
			// 경로에 사용되는 seq 값 검증
			if (!SecurePathValidator.isValidNumericPath(siteSeq) || 
			    !SecurePathValidator.isValidNumericPath(siteScreenVO.getTemplateSeq())) {
			    throw new IOException("Invalid Path Input");
			}
			
			siteScreenVO.setSiteSeq(siteSeq);
			String realPath = request.getSession().getServletContext().getRealPath("/");
		//	Map<String, Object> siteMenuList = siteScreenService.selectSiteMenuMngrList(siteScreenVO);
			String siteDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+siteScreenVO.getTemplateSeq();
			File siteDir = new File(EgovWebUtil.filePathBlackList(siteDirStr));
			if(!siteDir.exists()){
				if(!siteDir.mkdirs()) {
					log.info("directory not make");
				}
			}
			
			SysMngrTemplateVO paramVO = new SysMngrTemplateVO();
			 
			paramVO.setTemplateSeq(siteScreenVO.getTemplateSeq());
			SysMngrTemplateVO sysMngrTemplateVO = sysMngrTemplateService.selectTemplateScreen(paramVO);
			
			// DB에서 가져온 템플릿 seq 값 검증
			if (!SecurePathValidator.isValidNumericPath(sysMngrTemplateVO.getTemplateSeq())) {
			    throw new IOException("Invalid Template Seq from DB");
			}
			
			String backDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+siteScreenVO.getTemplateSeq()+"/backup";
			File backDir = new File(EgovWebUtil.filePathBlackList(backDirStr));
			
			if(backDir.exists() == false) {if(!backDir.mkdirs()) {
				log.info("directory not make");
			}}
			
			String currYear = DateUtils.getCurrentDate("yyyy");
			String currMonth = DateUtils.getCurrentDate("MM");
			String currDay = DateUtils.getCurrentDate("dd");
			String currHour = DateUtils.getCurrentDate("HH");
			String currMinute = DateUtils.getCurrentDate("mm");
			String currSec = DateUtils.getCurrentDate("ss");
			String currTime = currYear+currMonth+currDay+currHour+currMinute+currSec;
			String backupNm = currYear+"년 "+currMonth+"월 "+currDay+"일 "+currHour+"시 "+currMinute+"분 "+currSec+"초";
		
			boolean isDBSave = false;
			siteScreenVO.setBackupNm(backupNm);
			
			File indexFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+"/index.jsp"));
			try {
				// TOCTOU 방지를 위한 synchronized 블록
				synchronized(this) {
					if(indexFile.exists()){
						//지우고 덮어씌우지 말고 백업을 하자 2019.01.18 조원권
						String bkIndexFileNm = "index_"+currTime+".jsp";
						FileUtils.copyFile(indexFile, new File(EgovWebUtil.filePathBlackList(backDirStr + "/" + bkIndexFileNm)));
						siteScreenVO.setIndexFileNm(bkIndexFileNm);
						if(!indexFile.delete()) {
							log.info("file not delete");
						}
						isDBSave = true;
					}
				}
			} catch (SecurityException e) {
				log.error("siteDirStr/index file SecurityException" , e);
			}
			FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+EgovProperties.getProperty("defaultTempltJsp")), indexFile);
	
			
			File topFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+"/topMenu.jsp"));
			try {
				// TOCTOU 방지를 위한 synchronized 블록
				synchronized(this) {
					if(topFile.exists()){
						//지우고 덮어씌우지 말고 백업을 하자 2019.01.18 조원권
						String bkTopFileNm = "topMenu_"+currTime+".jsp";
						FileUtils.copyFile(topFile, new File(EgovWebUtil.filePathBlackList(backDirStr + "/" + bkTopFileNm)));
						siteScreenVO.setUpendmenuFileNm(bkTopFileNm);
						if(!topFile.delete()) {
							log.info("file not delete");
						}
					}
				}
			} catch (SecurityException e) {
				log.error("siteDirStr/topMenu file SecurityException" , e);
			}
			
			FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"topMenu.jsp"), topFile);
			
			
			File footerFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+"/footerMenu.jsp"));
			// TOCTOU 취약점 방지를 위한 동기화 처리
			synchronized (this) {
				if(footerFile.exists()){
					//지우고 덮어씌우지 말고 백업을 하자 2019.01.18 조원권
					String bkFootFileNm = "footerMenu_"+currTime+".jsp";
					FileUtils.copyFile(footerFile, new File(EgovWebUtil.filePathBlackList(backDirStr + "/" + bkFootFileNm)));
					siteScreenVO.setLptmenuFileNm(bkFootFileNm);
					if(!footerFile.delete()) {
						log.info("file not delete");
					}
				}
				FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"footerMenu.jsp"), footerFile);
			}
			
			
			File templtFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+File.separator+"templat.jsp")); 
			/*
			if(templtFile.exists()){
				templtFile.delete();
			}
			FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"templat.jsp"), templtFile);
		*/
			// template.jsp 파일도 서브페이지 편집화면에서 컨트롤이 되도록 변경하므로 삭제하지 않고 없을경우 복사하도록 변경
	        if(templtFile.exists() == false){
	        	FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"templat.jsp"), templtFile);
	        }
			
		    File subusrFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+File.separator+"usrSub.jsp"));
		    /*
		    if(subusrFile.exists()){
		        subusrFile.delete();
		    }
		    FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"usrSub.jsp"), subusrFile);
		    */
		    // usrSub.jsp 파일도 서브페이지 편집화면에서 컨트롤이 되도록 변경하므로 삭제하지 않고 없을경우 복사하도록 변경
	        if(subusrFile.exists() == false){
	         	FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"usrSub.jsp"), subusrFile);
	        }
		    
			File subHeadFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+"/subHead.jsp")); 
			// TOCTOU 취약점 방지를 위한 동기화 처리
			synchronized (this) {
				if(subHeadFile.exists()){
					if(!subHeadFile.delete()) {
						log.info("file not delete");
					}
				}
				FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"subHead.jsp"), subHeadFile);
			}
	
			
			File leftFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+"/leftMenu.jsp")); 
			// TOCTOU 취약점 방지를 위한 동기화 처리
			synchronized (this) {
				if(leftFile.exists()){
					if(!leftFile.delete()) {
						log.info("file not delete");
					}
				}
				FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"leftMenu.jsp"), leftFile);
			}
			
			
			if(isDBSave){
				siteScreenService.registTemplateBackupInfo(siteScreenVO);
			}
		
		
		}catch(NullPointerException e){
	       	 log.error("NullPointerException",e);
	   	}catch(NumberFormatException e){
	   		log.error("NumberFormatException",e);
	   	}catch(IllegalFormatException e){
	   		log.error("IllegalFormatException",e);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		log.error("ArrayIndexOutOfBoundsException",e);
	   	}catch(SQLException e){
	   		log.error("SQLException",e);
	   	}catch(IOException e){
	   		log.error("IOException",e);
	   	}
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		return "redirect:"+wzwgContext+"/mngr/screen/selectSiteScreenTempIndexMngr.do?templateSeq="+siteScreenVO.getTemplateSeq();
	}
	
	@RequestMapping(value= {"/mngr/screen/siteScreenMobileSave.do","/{siteKey}/mngr/screen/siteScreenMobileSave.do"})
	public String siteScreenMobileSave(
		@ModelAttribute("paramVO")SiteScreenVO siteScreenVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteScreenVO.setSiteSeq(siteSeq);
		String realPath =request.getServletContext().getRealPath("/");
		String siteDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request);
		String backDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/backup";
		File siteDir = new File(siteDirStr);
		File backDir = new File(backDirStr);
		if(!siteDir.exists()){
			if(!siteDir.mkdirs()) {
				log.info("directory not make");
			}
		}
		File indexFile = new File(siteDirStr+"/mIndex.jsp");
		File topFile = new File(siteDirStr+"/topMenu.jsp");
		File footerFile = new File(siteDirStr+"/footerMenu.jsp");

		if(!backDir.exists()){
			if(!backDir.mkdirs()) {
				log.info("directory not make");
			}
		}
		
		if(indexFile.exists()){
			FileUtils.copyFile(indexFile, new File(backDirStr+"/mIndex_"+DateUtils.getCurrentDate("yyyyMMddHHmmss")+".jsp"));
		} 
		/**
		FileWriter topWriter = new FileWriter(topFile);
		BufferedWriter topBw = new BufferedWriter(topWriter);
		topBw.write("<%@ page language=\"java\" contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>"); 
		topBw.newLine();
		topBw.write(siteScreenVO.getTopContents());	
		topBw.newLine(); 
		topBw.close();
		topWriter.close();
		
		FileWriter footerWriter = new FileWriter(footerFile);
		BufferedWriter footerBw = new BufferedWriter(footerWriter);
		footerBw.write("<%@ page language=\"java\" contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>"); 
		footerBw.newLine();
		footerBw.write(siteScreenVO.getFooterContents());	
		footerBw.newLine(); 
		footerBw.close();
		footerWriter.close();
		**/
		FileWriter writer = null;
		BufferedWriter bw = null;
		try {
		  writer = new FileWriter(indexFile);
		  bw = new BufferedWriter(writer);
		bw.write("<%@ page language=\"java\" contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>");
		bw.newLine();
       	bw.write("<%@ include file=\"/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp\" %>");
       	bw.newLine();
       	bw.write("<c:import url=\""+"/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/topMenu.do\"></c:import>");
		bw.newLine();
       	bw.write(siteScreenVO.getContents());	
		bw.newLine(); 
		bw.write("<c:import url=\""+"/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/footerMenu.jsp\"></c:import>");
		bw.newLine();
		bw.close();
		writer.close(); 
		}catch (IOException e) {
			// TODO: handle exception
			log.error("IOException",e);
		}finally {
			if(bw != null) try { bw.close(); } catch(IOException e) {log.error("IOException",e);}
		    if(writer != null) try { writer.close(); } catch(IOException e) {log.error("IOException",e);}
		}
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		return "redirect:"+wzwgContext+"/mngr/screen/selectSiteScreenMobileIndexMngr.do";
	}

    /**
     * ㅁ RESTFUL 서브페이지 목록 호출 제어
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/**/mngr/screen/subList/{menuSeq}")
    public String selectSubListPageCallCtrl(@PathVariable(value = "menuSeq") String menuSeq
    		, String templateSeq
    		, SysMngrTemplateVO sysMngrTemplateVO
            , HttpServletRequest request
            , Model model) throws Exception {

       
        
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        
        // 경로에 사용되는 seq 값 검증
        if (!SecurePathValidator.isValidNumericPath(siteSeq) || 
            !SecurePathValidator.isValidNumericPath(menuSeq) ||
            (templateSeq != null && !templateSeq.equals("") && !SecurePathValidator.isValidNumericPath(templateSeq))) {
            throw new IOException("Invalid Path Input");
        }

        String realPath = request.getSession().getServletContext().getRealPath("/");
        String siteDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+templateSeq;
		File siteDir = new File(EgovWebUtil.filePathBlackList(siteDirStr));
		if(!siteDir.exists()){
			if(!siteDir.mkdirs()) {
				log.info("directory not make");
			}
		}
		
		SiteTemplateScreenVO siteTemplateScreenParam = new SiteTemplateScreenVO();
		
		/**도메인 SEQ */
		String domnSeq = CmmSessionUtil.getSessionDomnSeq(request);
		siteTemplateScreenParam.setSiteSeq(siteSeq);
		siteTemplateScreenParam.setDomnSeq(domnSeq);
		siteTemplateScreenParam.setUserId(CmmSessionUtil.getSessionUserId());
		
		SiteTemplateScreenVO siteTemplateScreenVO = null;
		
		if(templateSeq == null || templateSeq.equals("")) {
			siteTemplateScreenVO = siteTemplateScreenService.selectSiteTemplateScreen(siteTemplateScreenParam);
			
		}else {
			SysMngrTemplateVO resultMngrTemplateVO = sysMngrTemplateService.selectTemplateScreen(sysMngrTemplateVO);
			
			// DB에서 가져온 템플릿 seq 값 검증
			if (!SecurePathValidator.isValidNumericPath(resultMngrTemplateVO.getTemplateSeq())) {
			    throw new IOException("Invalid Template Seq from DB");
			}
			
			siteTemplateScreenVO = new SiteTemplateScreenVO();
			siteTemplateScreenVO.setTemplateStreCours(resultMngrTemplateVO.getTemplateStreCours());
		}
		
		File subFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+"/sub_"+menuSeq+".jsp"));
		if(!subFile.exists()){
			FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"sub.jsp"), subFile);
		}
		

        File templtFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+File.separator+"templat.jsp"));
        /*
        if(!templtFile.exists()){
            FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"templat.jsp"), templtFile);
        }
        */
        // template.jsp 파일도 서브페이지 편집화면에서 컨트롤이 되도록 변경하므로 삭제하지 않고 없을경우 복사하도록 변경
        if(templtFile.exists() == false){
        	FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"templat.jsp"), templtFile);
        }

        File subusrFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+File.separator+"usrSub.jsp"));
        /*
        if(subusrFile.exists()){
            subusrFile.delete();
        }
        FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"usrSub.jsp"), subusrFile);
        */
        // usrSub.jsp 파일도 서브페이지 편집화면에서 컨트롤이 되도록 변경하므로 삭제하지 않고 없을경우 복사하도록 변경
        if(subusrFile.exists() == false){
        	FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"usrSub.jsp"), subusrFile);
        }
        
		File subHeadFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+"/subHead.jsp"));
		if(!subHeadFile.exists()){
			FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"subHead.jsp"), subHeadFile);
		}  
		

		File leftFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+"/leftMenu.jsp"));
		if(!leftFile.exists()){
			FileUtils.copyFile(new File(realPath+siteTemplateScreenVO.getTemplateStreCours()+"leftMenu.jsp"), leftFile);
		}  
	        PageCallCtrlVO  pageVO = new PageCallCtrlVO();
	        
	        
	        
	        pageVO.setSiteSeq(siteSeq);
	        pageVO.setMenuSeq(menuSeq);
			model.addAttribute("menuSeq", menuSeq);
			model.addAttribute("siteSeq", siteSeq);
			model.addAttribute("menuNm", pageCallCtrlService.selectMenuSeqByMenuNm(pageVO));
	        model.addAttribute("menuDc", pageCallCtrlService.selectMenuSeqByMenuDc(pageVO));
	        model.addAttribute("menuPath", pageCallCtrlService.selectMenuSeqByMenuPath(pageVO));
	        model.addAttribute("menuPathSeq", pageCallCtrlService.selectMenuSeqByMenuPathSeq(pageVO));
		
	        String wzwgContextPath = CmmSysParameterSetUtil.getUrlWzwgContext(request);
	        model.addAttribute("url", wzwgContextPath + "/mngr/subList/"+menuSeq);
        return "wzwg/site/mngr/screen/siteScreenSubMngr";
    }
    
    
    /**
     * ㅁ RESTFUL 서브페이지 목록 호출 제어
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    //@RequestMapping("/**/mngr/{templateSeq}/screen/subList/{menuSeq}")
    //public String selectTempSubListPageCallCtrl(@PathVariable(value = "menuSeq") String menuSeq
    //		, @PathVariable(value = "templateSeq") String templateSeq
    //        , HttpServletRequest request
    //        , Model model) throws Exception {
    //
    //   
    //    
    //    String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
    //    
    //
    //    String realPath =request.getServletContext().getRealPath("/");
    //    String siteDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+templateSeq;
	//	File siteDir = new File(siteDirStr);
	//	if(!siteDir.exists()){
	//		if(!siteDir.mkdirs()) {
	//			log.info("directory not make");
	//		}
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
	//	FileInputStream fis = null;
	//	InputStreamReader isr = null;
	//	BufferedReader br = null;
	//	FileWriter fw = null;
	//	try{
	//	paramVO.setTemplateSeq(templateSeq);
	//	SysMngrTemplateVO sysMngrTemplateVO = sysMngrTemplateService.selectTemplateScreen(paramVO);
	//	File subFile = new File(siteDirStr+"/sub_"+menuSeq+".jsp");
	//	if(!subFile.exists()){
	//		FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"sub.jsp"), subFile);
	//		fis =new FileInputStream(subFile);
	//		isr = new InputStreamReader(fis);
	//		  br = new BufferedReader(isr);
    //
    //
	//		String line;
	//		String dummy="";
    //
	//		while((line = br.readLine())!=null) {
	//			if(line.indexOf("subHead.jsp")>-1){
	//			 dummy += (line.replaceAll("/subHead.jsp", "/"+templateSeq+"/subHead.jsp") + "\r\n" );	
	//			}else{
	//			dummy += (line + "\r\n" );
	//			}
	//			
    //
	//		}
    //
	//		  fw = new FileWriter(subFile);
	//		fw.write(dummy);			
	//		//bw.close();
	//		fw.close();
	//		br.close();
	//	}
	//	
    //
    //    File templtFile = new File(siteDirStr+File.separator+"templat.jsp");
    //    /*
    //    if(!templtFile.exists()){
    //        FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"templat.jsp"), templtFile);
    //    }
    //    */
    //    // template.jsp 파일도 서브페이지 편집화면에서 컨트롤이 되도록 변경하므로 삭제하지 않고 없을경우 복사하도록 변경
    //    if(templtFile.exists() == false){
    //    	FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"templat.jsp"), templtFile);
    //    }
    //
    //    File subusrFile = new File(siteDirStr+File.separator+"usrSub.jsp");
    //    /*
    //    if(subusrFile.exists()){
    //        subusrFile.delete();
    //    }
    //    FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"usrSub.jsp"), subusrFile);
    //    */
    //    // usrSub.jsp 파일도 서브페이지 편집화면에서 컨트롤이 되도록 변경하므로 삭제하지 않고 없을경우 복사하도록 변경
    //    if(subusrFile.exists() == false){
    //    	FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"usrSub.jsp"), subusrFile);
    //    }
    //    
	//	File subHeadFile = new File(siteDirStr+"/subHead.jsp");
	//	if(!subHeadFile.exists()){
	//		FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"subHead.jsp"), subHeadFile);
	//	}  
	//	
    //
	//	File leftFile = new File(siteDirStr+"/leftMenu.jsp");
	//	if(!leftFile.exists()){
	//		FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"leftMenu.jsp"), leftFile);
	//	}  
	//        PageCallCtrlVO  pageVO = new PageCallCtrlVO();
	//        
	//        
	//        
	//        pageVO.setSiteSeq(siteSeq);
	//        pageVO.setMenuSeq(menuSeq);
	//		model.addAttribute("menuSeq", menuSeq);
	//		model.addAttribute("templateSeq", templateSeq);
	//		model.addAttribute("siteSeq", siteSeq);
	//	 model.addAttribute("menuNm", pageCallCtrlService.selectMenuSeqByMenuNm(pageVO));
	//        model.addAttribute("menuDc", pageCallCtrlService.selectMenuSeqByMenuDc(pageVO));
	//        model.addAttribute("menuPath", pageCallCtrlService.selectMenuSeqByMenuPath(pageVO));
	//        model.addAttribute("menuPathSeq", pageCallCtrlService.selectMenuSeqByMenuPathSeq(pageVO));
	//	
	//	model.addAttribute("url", "/mngr/"+templateSeq+"/subList/screen/"+menuSeq);
	//	}catch (IOException e) {
	//		// TODO: handle exception
	//		log.error("IOException",e);
	//	}finally {
	//		if(fw != null) try { fw.close(); } catch(IOException e) {log.error("IOException",e);}
	//	    if(br != null) try { br.close(); } catch(IOException e) {log.error("IOException",e);}
	//	    if(fis != null) try { fis.close(); } catch(IOException e) {log.error("IOException",e);}
	//	    if(isr != null) try { isr.close(); } catch(IOException e) {log.error("IOException",e);}
	//	  
	//	}
    //    return "wzwg/site/mngr/screen/siteScreenSubMngr";
    //}
	
    /**
	 * 사이트 메뉴 정보 조회
	 * @param siteMenuVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value= {"/mngr/screen/siteScreenSubSave.do","/{siteKey}/mngr/screen/siteScreenSubSave.do"})
	public String siteScreenSubSave(
		@ModelAttribute("paramVO")SiteScreenVO siteScreenVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		
		// 경로에 사용되는 seq 값 검증
		if (!SecurePathValidator.isValidNumericPath(siteSeq) || 
		    !SecurePathValidator.isValidNumericPath(siteScreenVO.getMenuSeq())) {
		    throw new IOException("Invalid Path Input");
		}
		
		siteScreenVO.setSiteSeq(siteSeq);
		String realPath = request.getSession().getServletContext().getRealPath("/");
		String siteDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request);
		String backDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/backup";
		File siteDir = new File(siteDirStr);
		File backDir = new File(backDirStr);
		if(!siteDir.exists()){
			if(!siteDir.mkdirs()) {
				log.info("directory not make");
			}
		}
		File subFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+"/sub_"+siteScreenVO.getMenuSeq()+".jsp"));
		File topFile = new File(siteDirStr+"/topMenu.jsp");
		File footerFile = new File(siteDirStr+"/footerMenu.jsp");
		
		File leftFile = new File(siteDirStr+"/leftMenu.jsp");

		if(!backDir.exists()){
			if(!backDir.mkdirs()) {
				log.info("directory not make");
			}
		}
		
		if(subFile.exists()){
			FileUtils.copyFile(subFile, new File(EgovWebUtil.filePathBlackList(backDirStr+"/sub_"+siteScreenVO.getMenuSeq()+DateUtils.getCurrentDate("yyyyMMddHHmmss")+".jsp")));
		}
		
		
		Document doc = Jsoup.parse(subFile, "UTF-8");
		//if(doc.hasClass("topSubImgOrign")){
		Elements topSubImgEle = doc.getElementsByClass("topSubImgOrign");
		topSubImgEle.after(siteScreenVO.getTopSubImgSource());
		topSubImgEle.remove(); 
		//}
		
	
	//	if(doc.hasClass("btnSubImgOrign")){
		Elements btnSubImgEle = doc.getElementsByClass("btnSubImgOrign");
 
		btnSubImgEle.after(siteScreenVO.getTopSubImgSource());
		btnSubImgEle.remove(); 
	//	}
		FileWriter subWriter = null;
		BufferedWriter subBw = null;
		try {
		  subWriter = new FileWriter(subFile);
		  subBw = new BufferedWriter(subWriter);
		subBw.write(doc.html().replaceAll("&gt;",">").replaceAll("&lt;","<").replaceAll("\n","\r"));  
		 if(subBw != null) try { subBw.close(); } catch(IOException e) {log.error("IOException",e);}
			if(subWriter != null) try { subWriter.close(); } catch(IOException e) {log.error("IOException",e);}
		
		/**
		FileWriter topWriter = new FileWriter(topFile);
		BufferedWriter topBw = new BufferedWriter(topWriter);
		topBw.write("<%@ page language=\"java\" contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>"); 
		topBw.newLine();
		topBw.write(siteScreenVO.getTopContents());	
		topBw.newLine(); 
		topBw.close();
		topWriter.close();
		
		FileWriter footerWriter = new FileWriter(footerFile);
		BufferedWriter footerBw = new BufferedWriter(footerWriter);
		footerBw.write("<%@ page language=\"java\" contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>"); 
		footerBw.newLine();
		footerBw.write(siteScreenVO.getFooterContents());	
		footerBw.newLine(); 
		footerBw.close();
		footerWriter.close();
		
		FileWriter writer = new FileWriter(subFile);
		BufferedWriter bw = new BufferedWriter(writer);
		bw.write("<%@ page language=\"java\" contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>");
		bw.newLine();
       	bw.write("<%@ include file=\"/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp\" %>");
       	bw.newLine();
       	bw.write("<c:import url=\""+"/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/subHead.jsp\"></c:import>");
       	bw.newLine();
       	bw.write("<c:import url=\""+"/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/topMenu.do\"></c:import>");
		bw.newLine();
       	bw.write(siteScreenVO.getContents().replaceAll("<div id=\"leftWrap\"></div>", "<c:import url=\""+"/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/leftMenu.jsp\"></c:import>"));	
		bw.newLine(); 
		bw.write("<c:import url=\""+"/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/footerMenu.jsp\"></c:import>");
		bw.newLine();
		bw.close();
		writer.close();
		**/ 
		}catch (IOException e) {
			// TODO: handle exception
			log.error("IOException",e);
		}finally {
		    if(subBw != null) try { subBw.close(); } catch(IOException e) {log.error("IOException",e);}
			if(subWriter != null) try { subWriter.close(); } catch(IOException e) {log.error("IOException",e);}
		}
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		return "redirect:"+wzwgContext+"/mngr/screen/subList/"+siteScreenVO.getMenuSeq();
	}
	
	/**
	 * 사이트 메뉴 정보 조회
	 * @param siteMenuVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value= {"/mngr/screen/siteScreenTemplateSubSave.do","/{siteKey}/mngr/screen/siteScreenTemplateSubSave.do"})
	public String siteScreenTemplateSubSave(
		@ModelAttribute("paramVO")SiteScreenVO siteScreenVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		FileWriter subWriter = null;
		BufferedWriter subBw = null;
		FileWriter usrSubWriter = null;
		BufferedWriter usrSubBw = null;
		FileInputStream	sampleFis = null;
		InputStreamReader sampleIsr =null;
		BufferedReader  sampleBr =null;
		FileWriter templatWriter = null;
		BufferedWriter templatBw = null;
		
		FileInputStream templatSampleFis = null;
		InputStreamReader	templatSamplelIsr = null;
		BufferedReader templatSampleBr = null;
		try{
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		
		// 경로에 사용되는 seq 값 검증
		if (!SecurePathValidator.isValidNumericPath(siteSeq) || 
		    !SecurePathValidator.isValidNumericPath(siteScreenVO.getTemplateSeq()) ||
		    !SecurePathValidator.isValidNumericPath(siteScreenVO.getMenuSeq())) {
		    throw new IOException("Invalid Path Input");
		}
		
		siteScreenVO.setSiteSeq(siteSeq);
		String realPath = request.getSession().getServletContext().getRealPath("/");
		String siteDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+siteScreenVO.getTemplateSeq();
		String backDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+siteScreenVO.getTemplateSeq()+"/backup";
		File siteDir = new File(EgovWebUtil.filePathBlackList(siteDirStr));
		File backDir = new File(EgovWebUtil.filePathBlackList(backDirStr));
		if(!siteDir.exists()){
			if(!siteDir.mkdirs()) {
				 throw new IOException("Directory creation Failed ");
			}
		}
		// 서브편집화면 진입시 이미 생성되어 있음
		File subFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+"/sub_"+siteScreenVO.getMenuSeq()+".jsp"));
		//File topFile = new File(siteDirStr+"/topMenu.jsp");
		//File footerFile = new File(siteDirStr+"/footerMenu.jsp");
		
		//File leftFile = new File(siteDirStr+"/leftMenu.jsp");

		if(!backDir.exists()){
			if(!backDir.mkdirs()) {
				 throw new IOException("Directory creation Failed ");
			}
		}
		
		if(subFile.exists()){
			FileUtils.copyFile(subFile, new File(EgovWebUtil.filePathBlackList(backDirStr+"/sub_"+siteScreenVO.getMenuSeq()+ "_" +DateUtils.getCurrentDate("yyyyMMddHHmmss")+".jsp")));
		}
		
		
		Document doc = Jsoup.parse(subFile, "UTF-8");
		//if(doc.hasClass("topSubImgOrign")){
		Elements topSubImgEle = doc.getElementsByClass("topSubImgOrign");
		topSubImgEle.after(siteScreenVO.getTopSubImgSource());
		topSubImgEle.remove(); 
		//}
		
	
	
		
		String subHtml = doc.html();
		subHtml = subHtml.replaceAll("<html>", "");
		subHtml = subHtml.replaceAll("</html>", "");
		subHtml = subHtml.replaceAll("<head>", "");
		subHtml = subHtml.replaceAll("</head>", "");
		subHtml = subHtml.replaceAll("<body>", "");
		subHtml = subHtml.replaceAll("</body>", "");
		subHtml = subHtml.replaceAll("&gt;",">").replaceAll("&lt;","<").replaceAll("\n","\r");
		subHtml = subHtml.replaceAll("<c:foreach","<c:forEach").replaceAll("</c:foreach","</c:forEach").replaceAll("varstatus=", "varStatus=");
		
		// 작업파일을 만들어 변경된 내용을 기록함
		File subWorkFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+"/sub_wrok_"+siteScreenVO.getMenuSeq()+".jsp"));
		  subWriter = new FileWriter(subWorkFile);
		  subBw = new BufferedWriter(subWriter);
		subBw.write(subHtml);  
		//System.out.println(doc.html("body"));
		if(subBw != null) try { subBw.close(); } catch(IOException e) {log.error("IOException",e);}
		 if(subWriter != null) try { subWriter.close(); } catch(IOException e) {log.error("IOException",e);}
		
		/* 변경내용 저장 이후 지정된 서브메뉴 시퀀스 대로 파일 복사 */
		String[] subMenuSeqs = siteScreenVO.getSubMenuSeqs() != null ? siteScreenVO.getSubMenuSeqs().split(",") : new String[0];
		
		for (String menuSeq : subMenuSeqs) {
			
			File copySubFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+"/sub_"+menuSeq+".jsp"));
			
			if(copySubFile.exists()){
				FileUtils.copyFile(copySubFile, new File(EgovWebUtil.filePathBlackList(backDirStr+"/sub_"+menuSeq + "_" +DateUtils.getCurrentDate("yyyyMMddHHmmss")+".jsp")));
			}
			
			// 작업파일을 원본으로 시퀀스별 파일 복사
			FileUtils.copyFile(subWorkFile, copySubFile);
		}
		
		
		// 완료후 작업파일 삭제 - TOCTOU 방지를 위한 synchronized 블록
		synchronized(this) {
			boolean subWorkfileDelRlt = false;
			if(subWorkFile.exists()) {
				subWorkfileDelRlt = subWorkFile.delete();
			}
			
			if(!subWorkfileDelRlt) {
				log.info("subWorkFile not delete");
			}
		}
		
		// 공용파일 변경값이 있을경우 usrSub.jsp파일을 변경해준다
		if("Y".equals(siteScreenVO.getUsrSubEdit())) {
			File usrSubSampleFile = new File(realPath+"/sample/template/include/usrSubSample.jsp"); 
			
			sampleFis =new FileInputStream(usrSubSampleFile);
			sampleIsr = new InputStreamReader(sampleFis);
			sampleBr = new BufferedReader(sampleIsr);
			  
			
			File usrSubFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+"/usrSub.jsp"));
			
			// TOCTOU 방지를 위한 synchronized 블록
			synchronized(this) {
				if(usrSubFile.exists()){
					FileUtils.copyFile(usrSubFile, new File(EgovWebUtil.filePathBlackList(backDirStr+"/usrSub_"+DateUtils.getCurrentDate("yyyyMMddHHmmss")+".jsp")));
					if(!usrSubFile.delete()) {
						log.info("directory not delete");
					}
				}
			
			  	usrSubWriter = new FileWriter(usrSubFile);
			  	usrSubBw = new BufferedWriter(usrSubWriter);
			
				String line = "";
				while((line = sampleBr.readLine())!=null) {
					//String str = sampleBr.readLine();
					if(line.indexOf("{editSource}") > -1) {
						line = siteScreenVO.getTopSubImgSource();
					}
					usrSubBw.write(line+"\n");
					//System.out.print(line+"\n");
				}
			}
			
			//System.out.println(doc.html("body"));
			usrSubBw.flush(); usrSubBw.close();	usrSubWriter.close(); sampleBr.close();
			
			
			
			// 공용파일 변경값이 있을경우 templat.jsp파일도 변경해준다 
			
			File templatSampleFile = new File(realPath+"/sample/template/include/templatSample.jsp");
			templatSampleFis = new FileInputStream(templatSampleFile);
			templatSamplelIsr  = new InputStreamReader(templatSampleFis) ;
			templatSampleBr = new BufferedReader(templatSamplelIsr);
			
			File templatFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+"/templat.jsp"));
			
			// TOCTOU 취약점 방지를 위한 동기화 처리
			synchronized (this) {
				if(templatFile.exists()){
					FileUtils.copyFile(templatFile, new File(EgovWebUtil.filePathBlackList(backDirStr+"/templat_"+DateUtils.getCurrentDate("yyyyMMddHHmmss")+".jsp")));
					if(!templatFile.delete()) {
						log.info("directory not delete");
					}
					
				}
				
				templatWriter = new FileWriter(templatFile);
				templatBw = new BufferedWriter(templatWriter);
			}
			
			String line2 = "";
			while((line2 = templatSampleBr.readLine())!=null) {
				//String str = sampleBr.readLine();
				if(line2.indexOf("{editSource}") > -1) {
					line2 = siteScreenVO.getTopSubImgSource();
				}
				templatBw.write(line2+"\n");
				//System.out.print(line+"\n");
			}
			
			//System.out.println(doc.html("body"));
			templatBw.flush(); templatBw.close(); templatWriter.close(); templatSampleBr.close();
			
		}
		
		
		/**
		FileWriter topWriter = new FileWriter(topFile);
		BufferedWriter topBw = new BufferedWriter(topWriter);
		topBw.write("<%@ page language=\"java\" contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>"); 
		topBw.newLine();
		topBw.write(siteScreenVO.getTopContents());	
		topBw.newLine(); 
		topBw.close();
		topWriter.close();
		
		FileWriter footerWriter = new FileWriter(footerFile);
		BufferedWriter footerBw = new BufferedWriter(footerWriter);
		footerBw.write("<%@ page language=\"java\" contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>"); 
		footerBw.newLine();
		footerBw.write(siteScreenVO.getFooterContents());	
		footerBw.newLine(); 
		footerBw.close();
		footerWriter.close();
		
		FileWriter writer = new FileWriter(subFile);
		BufferedWriter bw = new BufferedWriter(writer);
		bw.write("<%@ page language=\"java\" contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>");
		bw.newLine();
       	bw.write("<%@ include file=\"/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp\" %>");
       	bw.newLine();
       	bw.write("<c:import url=\""+"/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/subHead.jsp\"></c:import>");
       	bw.newLine();
       	bw.write("<c:import url=\""+"/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/topMenu.do\"></c:import>");
		bw.newLine();
       	bw.write(siteScreenVO.getContents().replaceAll("<div id=\"leftWrap\"></div>", "<c:import url=\""+"/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/leftMenu.jsp\"></c:import>"));	
		bw.newLine(); 
		bw.write("<c:import url=\""+"/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/footerMenu.jsp\"></c:import>");
		bw.newLine();
		bw.close();
		writer.close();
		**/ 
		}catch(NullPointerException e){
	       	 log.error("NullPointerException",e);
	   	}catch(NumberFormatException e){
	   		log.error("NumberFormatException",e);
	   	}catch(IllegalFormatException e){
	   		log.error("IllegalFormatException",e);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		log.error("ArrayIndexOutOfBoundsException",e);
	   	}catch(FileNotFoundException e){
	   		log.error("FileNotFoundException",e);
	   	}catch(IOException e){
	   		log.error("IOException",e);
	   	}finally {
	   	  if(subBw != null) try { subBw.close(); } catch(IOException e) {log.error("IOException",e);}
		    if(subWriter != null) try { subWriter.close(); } catch(IOException e) {log.error("IOException",e);}
		    if(usrSubWriter != null) try { usrSubWriter.close(); } catch(IOException e) {log.error("IOException",e);}
		    if(usrSubBw != null) try { usrSubBw.close(); } catch(IOException e) {log.error("IOException",e);}
		    if(sampleFis != null) try { sampleFis.close(); } catch(IOException e) {log.error("IOException",e);}
		    if(sampleIsr != null) try { sampleIsr.close(); } catch(IOException e) {log.error("IOException",e);}
		    if(sampleBr != null) try { sampleBr.close(); } catch(IOException e) {log.error("IOException",e);}
		    if(templatWriter != null) try { templatWriter.close(); } catch(IOException e) {log.error("IOException",e);}
		    if(templatBw != null) try { templatBw.close(); } catch(IOException e) {log.error("IOException",e);}
	 
		    if(templatSampleFis != null) try { templatSampleFis.close(); } catch(IOException e) {log.error("IOException",e);}
		    if(templatSamplelIsr != null) try { templatSamplelIsr.close(); } catch(IOException e) {log.error("IOException",e);}
		    if(templatSampleBr != null) try { templatSampleBr.close(); } catch(IOException e) {log.error("IOException",e);}
		 
	 
		}
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
//		return "redirect:/mngr/"+siteScreenVO.getTemplateSeq()+"/screen/subList/"+siteScreenVO.getMenuSeq()+"?templateSeq="+siteScreenVO.getTemplateSeq();
		return "redirect:"+wzwgContext+"/mngr/screen/subList/"+siteScreenVO.getMenuSeq()+"?templateSeq="+siteScreenVO.getTemplateSeq();
	}
	
	
	
	
	@RequestMapping(value= {"/mngr/screen/selectSiteLayoutTempltAjax.do","/{siteKey}/mngr/screen/selectSiteLayoutTempltAjax.do"})
	public String selectSiteLayoutTempltAjax(
		@ModelAttribute("paramVO")SiteTemplateLayoutVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
			 	model.addAttribute("templateLayoutList", siteTemplateLayoutService.selectSiteTemplateLayoutList(paramVO));
			 	paramVO.setLayoutSe("C");
			 	paramVO.setTemplateSeq("");
			 	model.addAttribute("commLayoutList", siteTemplateLayoutService.selectSiteTemplateLayoutList(paramVO));
		return "wzwg/site/mngr/screen/siteLayoutTempltInfo";
	}
	
	@RequestMapping(value="/**/screen/selectSiteMvpLayoutAjax.do")
	public String selectSiteMvpLayoutAjax(
		@ModelAttribute("paramVO")SiteLayoutVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
//				paramVO.setLayoutSe("O");
//			 	model.addAttribute("layoutList", siteLayoutService.selectSiteLayoutList(paramVO));
		
			 	return "wzwg/site/mngr/screen/siteMvpLayout";
	}
	
	@RequestMapping(value="/**/screen/selectSiteLayoutAjax.do")
	public String selectSiteLayoutAjax(
		@ModelAttribute("paramVO")SiteLayoutVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
//				paramVO.setLayoutSe("O");
//			 	model.addAttribute("layoutList", siteLayoutService.selectSiteLayoutList(paramVO));
		
			 	return "wzwg/site/mngr/screen/siteLayout";
	}
	
	@RequestMapping(value="/**/screen/selectLayoutContentsPopupAjax.do")
	public String selectLayoutContentsPopupAjax(
			@ModelAttribute("paramVO")SiteLayoutVO paramVO
			, HttpServletRequest request
			, Model model ) throws Exception {
		
		//paramVO.setCategory("board");
		if("100".equals(paramVO.getWidth())){
			paramVO.setHeight("");
		}
		List<SiteLayoutVO> contentsList = siteLayoutService.selectLayoutContentsList(paramVO);
		model.addAttribute("contentsList", contentsList);
		
		if("100".equals(paramVO.getWidth())){
			paramVO.setHeight("M");
		}
		model.addAttribute("paramVO", paramVO);
		return "wzwg/site/mngr/screen/siteLayoutContentsPopup";
	}
	
	@RequestMapping(value= {"/mngr/screen/selectSiteLayoutBlankLineAjax.do","/{siteKey}/mngr/screen/selectSiteLayoutBlankLineAjax.do"})
	public String selectSiteLayoutBlankLineAjax(
		@ModelAttribute("paramVO")SiteLayoutVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
			paramVO.setLayoutSe("B");
			model.addAttribute("blankList", siteLayoutService.selectSiteLayoutList(paramVO));
			paramVO.setLayoutSe("L");
			model.addAttribute("lineList", siteLayoutService.selectSiteLayoutList(paramVO));
			model.addAttribute("paramVO",paramVO);
		return "wzwg/site/mngr/screen/siteLayoutBlankLine";
	}
	
	@RequestMapping(value= {"/mngr/screen/selectSiteLayoutInfoAjax.do","/{siteKey}/mngr/screen/selectSiteLayoutInfoAjax.do"})
	public String selectSiteLayoutInfoAjax(
		@ModelAttribute("paramVO")SiteLayoutVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
			 	model.addAttribute("layout", siteLayoutService.selectSiteLayout(paramVO));
			 	 
		return "wzwg/site/mngr/screen/siteLayoutInfo";
	}
	
	@RequestMapping(value= {"/mngr/screen/siteTxtContentsInfoAjax.do","/{siteKey}/mngr/screen/siteTxtContentsInfoAjax.do"})
	public String siteTxtContentsInfoAjax(
		@ModelAttribute("paramVO")SiteTemplateLayoutVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		return "wzwg/site/mngr/screen/siteTxtContentsInfo";
	}
	
	
	@RequestMapping(value= {"/mngr/screen/uploadSiteQuickBannerAjax.do","/{siteKey}/mngr/screen/uploadSiteQuickBannerAjax.do"})
	public ModelAndView uploadSiteQuickBannerAjax(
			@ModelAttribute("paramVO")SiteTemplateScreenVO paramVO
			, HttpServletRequest request
   			, HttpServletResponse response
   			, MultipartHttpServletRequest multiRequest
   			) throws Exception {
   			ModelAndView model = new ModelAndView();
   	    	model.setViewName("jsonView"); 
		
	 String siteSeq =CmmSessionUtil.getSessionSiteSeq(request);
    	/** 사이트시퀀스 입력 */
		paramVO.setSiteSeq(siteSeq);
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setFrstRegisterId(loginVO.getUserId());
		
		
		List<ModuleUploadFileVO> resultList = null;
	    
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
        Calendar calendar = Calendar.getInstance();
	    Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	    List<ModuleUploadFileVO> result  = new ArrayList<ModuleUploadFileVO>();
	    ModuleUploadFileVO fvo;
 	    while (itr.hasNext()) {
	    	Entry<String, MultipartFile> entry = itr.next();
	    	MultipartFile file;
	    	
	    	
	             
	             file = entry.getValue();
	             String orginFileName = file.getOriginalFilename();
	             String name = file.getName();
	             String fileOrgPath=request.getServletContext().getRealPath("")+"/upload/";
	             String storePathString = siteSeq + "/" + "layout" + "/icon/" + calendar.get(Calendar.YEAR)
	                     + "/" + ((calendar.get(Calendar.MONTH) + 1) < 10 ? "0"+(calendar.get(Calendar.MONTH) + 1):(calendar.get(Calendar.MONTH) + 1)) 
	                     + "/" + (calendar.get(Calendar.DATE) < 10 ? "0"+calendar.get(Calendar.DATE):calendar.get(Calendar.DATE)) + "/";
	             String filePathStr = "/upload/"+storePathString;
	             
	             storePathString = fileOrgPath+storePathString;
	             
	             String whiteFileExtStr = "";
	            whiteFileExtStr = EgovProperties.getProperty("Globals.WhiteFileExt");

	             
	    		 File saveFolder = new File(EgovWebUtil.filePathBlackList(storePathString));

	    	        if (!saveFolder.exists() || saveFolder.isFile()) {
	    	        	if(saveFolder.mkdirs()) {
	    					log.info("directory not make");
	    				}
	    	        }
	    	        
	    	        
	    	        int index = -1;
	    	        String fileExt = "";
	    	        if (orginFileName != null) {
	    	            index = orginFileName.lastIndexOf(".");
	    	            if (index != -1) {
	    	                fileExt = orginFileName.substring(index + 1);
	    	            }
	    	        }
	                String newName = "ICO_" + getTimeStamp()+"."+fileExt;
	                long _size = file.getSize();

	                if (!"".equals(orginFileName)) {
	                    
	                   String filePath = (storePathString + "/" + newName);

	                    if(whiteFileExtStr.indexOf(fileExt.toLowerCase().trim()) > -1) {
	                        file.transferTo(new File(EgovWebUtil.filePathBlackList(""+filePath)));
	                        fvo = new ModuleUploadFileVO();
	                        fvo.setFileExtsn(fileExt);
	                        fvo.setFileStreCours(storePathString);
	                        fvo.setOrignlFileNm(orginFileName);
	                        fvo.setStreFileNm(newName);
	                        fvo.setFileMg(Long.toString(_size));
	                        fvo.setName(name);
	                        
	                        result.add(fvo);
	            
	                    } else {
	                        ModuleUploadFileUtil.deleteFile(EgovWebUtil.filePathBlackList(filePath)+"."+fileExt);
	                        return model;
	                    }
	                }
	                
	    		if(!result.isEmpty() || result.size() != 0){
	    			paramVO.setThumbUrl(filePathStr+result.get(0).getStreFileNm()); 
	    		}	    		
	    }
 	     	       
		 model.addObject("paramVO",paramVO);
		return model;
	}
	
	@RequestMapping(value= {"/mngr/screen/selectSiteQuickBannerAjax.do","/{siteKey}/mngr/screen/selectSiteQuickBannerAjax.do"})
	public String selectSiteQuickBannerAjax(
		@ModelAttribute("paramVO")SiteTemplateScreenVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		/**도메인 SEQ */
		String domnSeq = CmmSessionUtil.getSessionDomnSeq(request);
		paramVO.setSiteSeq(siteSeq);
		paramVO.setDomnSeq(domnSeq);
		paramVO.setUserId(CmmSessionUtil.getSessionUserId());
		
		SiteTemplateScreenVO siteTemplateScreenVO = siteTemplateScreenService.selectSiteTemplateScreen(paramVO);
		
		String realPath =request.getServletContext().getRealPath("/");
		String tempBannerDirStr =realPath+siteTemplateScreenVO.getTemplateStreCours()+"img/icon";
		File tempBannerDir = new File(tempBannerDirStr);
		File[] tempBannerFiles=	tempBannerDir.listFiles();
		if(tempBannerFiles != null) {
	    Arrays.sort(tempBannerFiles, new Comparator() {
		   public int compare(Object arg0, Object arg1) {
		    File file1 = (File)arg0;
		    File file2 = (File)arg1;
		    return file1.getName().compareToIgnoreCase(file2.getName());
		   }
		});
		  ArrayList<String> tempBannerList = new ArrayList<String>();
		  for(int i =0;i<tempBannerFiles.length;i++){
			  tempBannerList.add(tempBannerFiles[i].getName());
			 // Collections.sort(bannerList, Collections.);
		  }
		  
		  
		  String commBannerDirStr =realPath+"sample/img/icon";
			File commBannerDir = new File(commBannerDirStr);
			File[] commBannerFiles=	commBannerDir.listFiles();
			if(commBannerFiles != null) {
		    Arrays.sort(commBannerFiles, new Comparator() {
			   public int compare(Object arg0, Object arg1) {
			    File file1 = (File)arg0;
			    File file2 = (File)arg1;
			    return file1.getName().compareToIgnoreCase(file2.getName());
			   }
			});
		    if(commBannerFiles != null) {
			  ArrayList<String> commBannerList = new ArrayList<String>();
			  for(int i =0;i<commBannerFiles.length;i++){
				  commBannerList.add(commBannerFiles[i].getName());
				 // Collections.sort(bannerList, Collections.);
			  }
		  model.addAttribute("tempBannerDirStr", "/"+siteTemplateScreenVO.getTemplateStreCours()+"img/icon");
		  model.addAttribute("tempBannerList", tempBannerList);
		  model.addAttribute("commBannerDirStr", "/sample/img/icon");
		  model.addAttribute("commBannerList", commBannerList);
		}
			}
		}
		return "wzwg/site/mngr/screen/siteQuickBannerInfo";
	}
	
	@RequestMapping(value= {"/mngr/screen/registSiteLayoutTempltAjax.do","/{siteKey}/mngr/screen/registSiteLayoutTempltAjax.do"})
	public ModelAndView registSiteLayoutTempltAjax(
		@ModelAttribute("paramVO")SiteTemplateLayoutVO paramVO
		, HttpServletRequest request
		) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		siteTemplateLayoutService.registSiteTemplateLayout(paramVO);
    	ModelAndView model = new ModelAndView();
    	model.setViewName("jsonView");
        model.addObject("paramVO", paramVO);
		
		return model;
	}	
	
	
	/**
	 * 템플릿 파일 편집
	 * @param siteMenuVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/screen/selectSiteScreenTempIndexMngr.do","/{siteKey}/mngr/screen/selectSiteScreenTempIndexMngr.do"})
	public String selectSiteScreenTempIndexMngr(
		@ModelAttribute("paramVO")SiteScreenVO siteScreenVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		String retUrl = "wzwg/site/mngr/screen/siteScreenTempMngr";
		try{
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		
		// 경로에 사용되는 seq 값 검증
		if (!SecurePathValidator.isValidNumericPath(siteSeq) || 
		    !SecurePathValidator.isValidNumericPath(siteScreenVO.getTemplateSeq())) {
		    throw new IOException("Invalid Path Input");
		}
		
		siteScreenVO.setSiteSeq(siteSeq);
		String realPath = request.getSession().getServletContext().getRealPath("/");
		Map<String, Object> siteMenuList = siteScreenService.selectSiteMenuMngrList(siteScreenVO);
		model.addAttribute("menuList", siteMenuList.get("MENU_LIST"));
		String siteDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+siteScreenVO.getTemplateSeq();
		File siteDir = new File(EgovWebUtil.filePathBlackList(siteDirStr));
		if(!siteDir.exists()){
			if(!siteDir.mkdirs()) {
				log.info("directory not make");
			}
		}
		
		SysMngrTemplateVO paramVO = new SysMngrTemplateVO();
		 
		paramVO.setTemplateSeq(siteScreenVO.getTemplateSeq());
		SysMngrTemplateVO sysMngrTemplateVO = sysMngrTemplateService.selectTemplateScreen(paramVO);
		
		// DB에서 가져온 템플릿 seq 값 검증
		if (!SecurePathValidator.isValidNumericPath(sysMngrTemplateVO.getTemplateSeq())) {
		    throw new IOException("Invalid Template Seq from DB");
		}
	/**
		if(sysMngrTemplateVO.getTemplateNcnm().equals("drag")){
			retUrl = "wzwg/site/mngr/screen/siteScreenDragMngr";
		}
		**/
		File indexFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+"/index.jsp"));
		if(!indexFile.exists()){
			FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+EgovProperties.getProperty("defaultTempltJsp")), indexFile);
		}
		
		File topFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+"/topMenu.jsp"));
		
		File footerFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+"/footerMenu.jsp"));
		if(!topFile.exists()){
			FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"topMenu.jsp"), topFile);
			/*BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(topFile)));

			String line;
			String dummy="";

			while((line = br.readLine())!=null) {
				if(line.indexOf("id=\"headmenu\"")>-1){
				 dummy += (line.replaceAll("/css/headmenu", "/"+siteScreenVO.getTemplateSeq()+"/css/headmenu") + "\r\n" );	
				}else{
				dummy += (line + "\r\n" );
				}
				

			}

			FileWriter fw = new FileWriter(topFile);
			fw.write(dummy);			
			//bw.close();
			fw.close();
			br.close();*/
		}
		
		
		
		
		
		if(!footerFile.exists()){
			FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"footerMenu.jsp"), footerFile);
		}
		
		File siteSeqFooterFile = new File(realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/footerMenu.jsp");
		if(!siteSeqFooterFile.exists()){
			FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"footerMenu.jsp"), siteSeqFooterFile);
		}
		
	File templtFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+File.separator+"templat.jsp")); 
	/*
	if(!templtFile.exists()){
       FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"templat.jsp"), templtFile);
	}
	*/
	// template.jsp 파일도 서브페이지 편집화면에서 컨트롤이 되도록 변경하므로 삭제하지 않고 없을경우 복사하도록 변경
    if(templtFile.exists() == false){
    	FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"templat.jsp"), templtFile);
    }

    File subusrFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+File.separator+"usrSub.jsp"));
    /*
    if(subusrFile.exists()){
        subusrFile.delete();
    }
    FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"usrSub.jsp"), subusrFile);
    */
    // usrSub.jsp 파일도 서브페이지 편집화면에서 컨트롤이 되도록 변경하므로 삭제하지 않고 없을경우 복사하도록 변경
    if(subusrFile.exists() == false){
    	FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"usrSub.jsp"), subusrFile);
    }
    
    
	 File subHeadFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+"/subHead.jsp")); 
	 
	 if(!subHeadFile.exists()){
		FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"subHead.jsp"), subHeadFile);
	 }
		File leftFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+"/leftMenu.jsp")); 
		if(!leftFile.exists()){
		FileUtils.copyFile(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"leftMenu.jsp"), leftFile);
		}
		ArrayList<String> indexList = new ArrayList<String>();
		String backDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+siteScreenVO.getTemplateSeq()+"/backup";
		File backupDir = new File(EgovWebUtil.filePathBlackList(backDirStr));
 
		String siteCssDirStr =realPath+"site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+siteScreenVO.getTemplateSeq()+"/css";
		File siteCssDir = new File(EgovWebUtil.filePathBlackList(siteCssDirStr));
			if(!siteCssDir.exists()){
				if(!siteCssDir.mkdirs()) {
					log.info("directory not make");
				}
				FileUtils.copyDir(new File(realPath+sysMngrTemplateVO.getTemplateStreCours()+"css"), siteCssDir);
			}
		   
	
		ScrinMenuVO scrinMenuVO = new ScrinMenuVO();
		scrinMenuVO.setSiteSeq(siteSeq);
		model.addAttribute("moduleSGC0000027",siteScreenService.selectModuleMenuList("10000000003", CmmSessionUtil.getSessionSiteSeq(request)));
		model.addAttribute("module10000000104",siteScreenService.selectModuleMenuList("10000000104", CmmSessionUtil.getSessionSiteSeq(request)));
		model.addAttribute("module10000000204",siteScreenService.selectModuleMenuList("10000000204", CmmSessionUtil.getSessionSiteSeq(request)));
		model.addAttribute("module10000000213",siteScreenService.selectModuleMenuList("10000000213", CmmSessionUtil.getSessionSiteSeq(request)));
		model.addAttribute("module10000000218",siteScreenService.selectModuleMenuList("10000000218", CmmSessionUtil.getSessionSiteSeq(request)));
		model.addAttribute("backupIndexList", siteScreenService.selectTemplateBackupInfoList(siteScreenVO));
		model.addAttribute("moduleList",siteScreenService.selectModuleList("SGC0000021", CmmSessionUtil.getSessionSiteSeq(request)));
		model.addAttribute("firstNttMenuSeq", siteScreenService.selectFirstNttMenuSeq(scrinMenuVO));
		model.addAttribute("siteTemplateScreenVO",sysMngrTemplateVO);
		if("".equals(siteScreenVO.getBackup())){
			model.addAttribute("url", "/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+siteScreenVO.getTemplateSeq()+"/index.jsp");
			model.addAttribute("topUrl", "/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/topMenu.do");
			model.addAttribute("footerUrl", "/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+siteScreenVO.getTemplateSeq()+"/footerMenu.jsp");
		}else{
			siteScreenVO.setTmpbakupSeq(siteScreenVO.getBackup());
			SiteScreenVO siteScreen =siteScreenService.selectTemplateBackupInfo(siteScreenVO);
			model.addAttribute("url", "/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+siteScreenVO.getTemplateSeq()+"/backup/"+siteScreen.getIndexFileNm());
			model.addAttribute("topUrl", "/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/topMenu.do");
			model.addAttribute("footerUrl", "/WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+siteScreenVO.getTemplateSeq()+"/backup/"+siteScreen.getLptmenuFileNm());
		}
		}catch(NullPointerException e){
	       	 log.error("NullPointerException",e);
	   	}catch(NumberFormatException e){
	   		log.error("NumberFormatException",e);
	   	}catch(IllegalFormatException e){
	   		log.error("IllegalFormatException",e);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		log.error("ArrayIndexOutOfBoundsException",e);
	   	}catch(FileNotFoundException e){
	   		log.error("FileNotFoundException",e);
	   	}catch(IOException e){
	   		log.error("IOException",e);
	   	}catch(SQLException e){
	   		log.error("SQLException",e);
	   	}
		return retUrl;
	}
	
	
	/**
	 * 템플릿 파일 저장
	 * @param siteMenuVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/screen/siteScreenTempSave.do","/mngr/screen/siteScreenTempSaveAjax.do","/{siteKey}/mngr/screen/siteScreenTempSave.do","/{siteKey}/mngr/screen/siteScreenTempSaveAjax.do"})
	public String siteScreenTempSave(
		@ModelAttribute("paramVO")SiteScreenVO siteScreenVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		
		// 경로에 사용되는 seq 값 검증
		if (!SecurePathValidator.isValidNumericPath(siteSeq) || 
		    !SecurePathValidator.isValidNumericPath(siteScreenVO.getTemplateSeq())) {
		    throw new IOException("Invalid Path Input");
		}
		
		siteScreenVO.setSiteSeq(siteSeq);
		String realPath = request.getSession().getServletContext().getRealPath("/");
		String siteDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+siteScreenVO.getTemplateSeq();
		String backDirStr =realPath+"WEB-INF/jsp/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+siteScreenVO.getTemplateSeq()+"/backup";
		
//		String cssDirStr =realPath+"site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/"+siteScreenVO.getTemplateSeq()+"/css";
		
		/** 웹 방화벽 이슈로 base64 decoding 처리 */
//		siteScreenVO.setContents(new String(Base64.getDecoder().decode(siteScreenVO.getContents()), "UTF-8"));
//		siteScreenVO.setTopContents(new String(Base64.getDecoder().decode(siteScreenVO.getTopContents()), "UTF-8"));
//		siteScreenVO.setFooterContents(new String(Base64.getDecoder().decode(siteScreenVO.getFooterContents()), "UTF-8"));
//		siteScreenVO.setHeadCss(new String(Base64.getDecoder().decode(siteScreenVO.getHeadCss()), "UTF-8"));
//		siteScreenVO.setFootCss(new String(Base64.getDecoder().decode(siteScreenVO.getFootCss()), "UTF-8"));
//		siteScreenVO.setSubCss(new String(Base64.getDecoder().decode(siteScreenVO.getSubCss()), "UTF-8"));
//		siteScreenVO.setHeadMenuCss(new String(Base64.getDecoder().decode(siteScreenVO.getHeadMenuCss()), "UTF-8"));
//		siteScreenVO.setHeadMenuData(new String(Base64.getDecoder().decode(siteScreenVO.getHeadMenuData()), "UTF-8"));
		if (siteScreenVO != null) {
			String decrypted;
			
			if(siteScreenVO.getContents() != null) {
				decrypted = EgovFileScrty.decrypt(siteScreenVO.getContents(), "wizwig");
			    if (decrypted != null) { siteScreenVO.setContents(decrypted); }	
			}
		    
		    if(siteScreenVO.getTopContents() != null) {
			    decrypted = EgovFileScrty.decrypt(siteScreenVO.getTopContents(), "wizwig");
			    if (decrypted != null) { siteScreenVO.setTopContents(decrypted); }		    	
		    }
		    
		    if(siteScreenVO.getFooterContents() != null) {
		    	decrypted = EgovFileScrty.decrypt(siteScreenVO.getFooterContents(), "wizwig");
			    if (decrypted != null) { siteScreenVO.setFooterContents(decrypted); }
		    }
		    
		    if(siteScreenVO.getHeadCss() != null) {
			    decrypted = EgovFileScrty.decrypt(siteScreenVO.getHeadCss(), "wizwig");
			    if (decrypted != null) { siteScreenVO.setHeadCss(decrypted); }
		    }
		    
		    if(siteScreenVO.getFootCss() != null) {
			    decrypted = EgovFileScrty.decrypt(siteScreenVO.getFootCss(), "wizwig");
			    if (decrypted != null) { siteScreenVO.setFootCss(decrypted); }
		    }
		    
		    if(siteScreenVO.getSubCss() != null) {
			    decrypted = EgovFileScrty.decrypt(siteScreenVO.getSubCss(), "wizwig");
			    if (decrypted != null) { siteScreenVO.setSubCss(decrypted); }
		    }
		    
		    if(siteScreenVO.getHeadMenuCss() != null) {
			    decrypted = EgovFileScrty.decrypt(siteScreenVO.getHeadMenuCss(), "wizwig");
			    if (decrypted != null) { siteScreenVO.setHeadMenuCss(decrypted); }
		    }
		    
		    if(siteScreenVO.getHeadMenuData() != null) {
			    decrypted = EgovFileScrty.decrypt(siteScreenVO.getHeadMenuData(), "wizwig");
			    if (decrypted != null) { siteScreenVO.setHeadMenuData(decrypted); }
		    }
		}
		
		File siteDir = new File(EgovWebUtil.filePathBlackList(siteDirStr));
		File backDir = new File(EgovWebUtil.filePathBlackList(backDirStr));
		if(!siteDir.exists()){
			if(!siteDir.mkdirs()) {
				log.info("directory not make");
			}
		}
		File indexFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+"/index.jsp"));
		File topFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+"/topMenu.jsp"));
		File footerFile = new File(EgovWebUtil.filePathBlackList(siteDirStr+"/footerMenu.jsp"));
//        File cssHeadmenu00 = new File(cssDirStr+"/headmenu00.css");
//        File cssHeadmenu01 = new File(cssDirStr+"/headmenu01.css");
//        File cssHeadmenu02 = new File(cssDirStr+"/headmenu02.css");
		if(!backDir.exists()){
			if(!backDir.mkdirs()) {
				log.info("directory not make");
			}
		}
		

		String currYear = DateUtils.getCurrentDate("yyyy");
		String currMonth = DateUtils.getCurrentDate("MM");
		String currDay = DateUtils.getCurrentDate("dd");
		String currHour = DateUtils.getCurrentDate("HH");
		String currMinute = DateUtils.getCurrentDate("mm");
		String currSec = DateUtils.getCurrentDate("ss");
		String currTime = currYear+currMonth+currDay+currHour+currMinute+currSec;
		String backupNm = currYear+"년 "+currMonth+"월 "+currDay+"일 "+currHour+"시 "+currMinute+"분 "+currSec+"초";
		
		if(indexFile.exists()){
			FileUtils.copyFile(indexFile, new File(EgovWebUtil.filePathBlackList(backDirStr+"/index_"+currTime+".jsp")));
		}
		
		if(topFile.exists()){
			FileUtils.copyFile(topFile, new File(EgovWebUtil.filePathBlackList(backDirStr+"/topMenu_"+currTime+".jsp")));
		}
		
		FileWriter fw = null;
		FileInputStream fis = null;
		InputStreamReader isr = null;
		BufferedReader br = null;
		try {
			// TOCTOU 방지를 위한 synchronized 블록
			synchronized(this) {
				File targetFile = new File(EgovWebUtil.filePathBlackList(backDirStr+"/topMenu_"+currTime+".jsp"));
				if(targetFile.exists()) {
					fis = new FileInputStream(targetFile);
					isr = new InputStreamReader(fis);
					br = new BufferedReader(isr);
					
					String line;
					String dummy="";
					SiteTemplateScreenVO siteTemplateScreenParam = new SiteTemplateScreenVO();
					
					/**도메인 SEQ */
					String domnSeq = CmmSessionUtil.getSessionDomnSeq(request);
					siteTemplateScreenParam.setSiteSeq(siteSeq);
					siteTemplateScreenParam.setDomnSeq(domnSeq);
					siteTemplateScreenParam.setUserId(CmmSessionUtil.getSessionUserId());
					
					while((line = br.readLine())!=null) {
						
						if(line.indexOf("<style")>-1){
							break;
						}
						
						if(line.indexOf("id=\"headmenu\"")>-1){
							dummy +=siteScreenVO.getHeadCss()+ "\r\n";
						}else if(line.indexOf("id=\"footmenu\"")>-1){
							dummy +=siteScreenVO.getFootCss()+ "\r\n";
						}else if(line.indexOf("id=\"submenu\"")>-1){
							dummy +=siteScreenVO.getSubCss()+ "\r\n";
						}else{
							dummy += (line + "\r\n" );
						}
						
					}
					
					dummy += "<style id=\"headMenuStyle\">\r\n";
					dummy += StringUtils.defaultString(siteScreenVO.getHeadMenuCss()).replaceAll("&gt;", ">")+ "\r\n";
					dummy += "</style>\r\n";
			
					dummy += "<script> menuCss = " + StringUtils.defaultString(siteScreenVO.getHeadMenuData()).replaceAll("&quot;", "\"") + "</script>\r\n";
					fw = new FileWriter(topFile);
					fw.write(dummy);
				}
			}			
			//bw.close();
		}catch (IOException e) {
			// TODO: handle exception
			log.error("IOException",e);
		}finally {
			  if(fw != null) try { fw.close(); } catch(IOException e) {log.error("IOException",e);}
			    if(br != null) try { br.close(); } catch(IOException e) {log.error("IOException",e);}
			    if(fis != null) try { fis.close(); } catch(IOException e) {log.error("IOException",e);}
			    if(isr != null) try { isr.close(); } catch(IOException e) {log.error("IOException",e);}
		}	
		
		
		if(footerFile.exists()){
			FileUtils.copyFile(footerFile, new File(EgovWebUtil.filePathBlackList(backDirStr+"/footerMenu_"+currTime+".jsp")));
		}
		siteScreenVO.setBackupNm(backupNm);
		siteScreenVO.setIndexFileNm("index_"+currTime+".jsp");
		siteScreenVO.setUpendmenuFileNm("topMenu_"+currTime+".jsp");
		siteScreenVO.setLptmenuFileNm("footerMenu_"+currTime+".jsp");
		siteScreenService.registTemplateBackupInfo(siteScreenVO);
		/*if(!siteScreenVO.getTopMenuSe().equals("")){
			if(siteScreenVO.getTopMenuSe().equals("1")){
				if(cssHeadmenu00.exists()){
					cssHeadmenu00.delete();
				}
				FileUtils.copyFile(cssHeadmenu01, cssHeadmenu00);
			}
			
			if(siteScreenVO.getTopMenuSe().equals("2")){
				if(cssHeadmenu00.exists()){
					cssHeadmenu00.delete();
				}
				FileUtils.copyFile(cssHeadmenu02, cssHeadmenu00);
			}
		}*/
		 
		FileWriter writer = null;
		BufferedWriter bw = null;
		try {
			writer = new FileWriter(indexFile);
			bw = new BufferedWriter(writer);
		bw.write("<%@ page language=\"java\" contentType=\"text/html; charset=utf-8\" pageEncoding=\"utf-8\"%>");
		bw.newLine();
       	bw.write("<%@ include file=\"/WEB-INF/jsp/wzwg/cmm/include/incTaglibs.jsp\" %>");
       	bw.newLine();
//       	bw.write("<c:import url=\""+"/site/"+CmmSessionUtil.getSessionSiteSeq(request)+"/topMenu.do\"></c:import>");
//       	bw.write("<c:import url=\"/site/${sessionScope.SITE_SEQ}/topMenu.do\"></c:import>");
       	bw.write("<c:choose>                                                                                                       "); bw.newLine();
	    bw.write("	<c:when test=\"${subPrefix eq '/subMngr' or subPrefix eq '/subsite' }\">                                         "); bw.newLine();
	    bw.write("		<c:import url=\"/subsite/${subsiteKey}/topMenu.do\"></c:import>                                              "); bw.newLine();
	    bw.write("	</c:when>                                                                                                      "); bw.newLine();
	    bw.write("	<c:otherwise>                                                                                                  "); bw.newLine();
	    bw.write("		<c:import url=\"/site/${sessionScope.SITE_SEQ}/topMenu.do\"></c:import>                                      "); bw.newLine();
	    bw.write("	</c:otherwise>                                                                                                 "); bw.newLine();
	    bw.write("</c:choose>                                                                                                      "); bw.newLine();
		bw.newLine();
       	bw.write(siteScreenVO.getContents());	
		bw.newLine(); 
		bw.write("<c:import url=\""+"${footerUrl}\"></c:import>");
		bw.newLine();
		}catch (IOException e) {
			// TODO: handle exception
			log.error("IOException",e);
		}finally {
		    if(bw != null) try { bw.close(); } catch(IOException e) {log.error("IOException",e);}
		    if(writer != null) try { writer.close(); } catch(IOException e) {log.error("IOException",e);}
		}
		String servletPath = new UrlPathHelper().getOriginatingServletPath(request);
		
		if(servletPath.indexOf("siteScreenTempSaveAjax") > 0){
			Map<String, String> ajaxResponse = new HashMap<String, String>();
			ajaxResponse.put("result", "success");
			model.addAttribute("ajaxResponse", ajaxResponse);
			return "wzwg/webModule/json";
		}else{
			String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
			return "redirect:"+wzwgContext+"/mngr/screen/selectSiteScreenTempIndexMngr.do?templateSeq="+siteScreenVO.getTemplateSeq();
			
		}
	}

//	/**
//	 * 
//	 * @param paramVO
//	 * @param request
//	 * @param model
//	 * @return
//	 * @throws Exception
//	 * @author moo0506
//	 */
//	@RequestMapping(value="/mngr/screen/selectSiteScreenTempltHeadmenuAjax.do")
//	public String selectSiteScreenTempltHeadmenuAjax(
//			@ModelAttribute("paramVO")SysMngrTemplateVO paramVO
//			, HttpServletRequest request
//			, Model model ) throws Exception {
//		try{
//			
//			
//			@SuppressWarnings("deprecation")
//			String realPath = request.getServletContext().getRealPath("/");
////			System.out.println(realPath);	
////			System.out.println(paramVO.getTemplateStreCours());
//			
//			
//			/** 
//			 * 2018.07.12 헤드메뉴 통합으로 인한 수정 
//			 * 
//			 * SC00000369 = basic
//			 * SC00000370 = left
//			 * SC00000371 = wide
//			 * SC00000398 = compound
//			 *  */
//			//String cssPathName = "css/";
//			String headmenuPath = "sample/templatehead/";
//			String templatLayoutNm = "";
//			if(("SC00000370").equals(paramVO.getLayoutSeCode())){
//				templatLayoutNm = "left/";
//			}else if(("SC00000371").equals(paramVO.getLayoutSeCode())){
//				templatLayoutNm = "wide/";
//			}else if(("SC00000398").equals(paramVO.getLayoutSeCode())){
//				templatLayoutNm = "compound/";
//			}else{
//				templatLayoutNm = "basic/";
//			}
//			//String cssPath = realPath + paramVO.getTemplateStreCours() + cssPathName;
//			String cssPath = realPath + headmenuPath + templatLayoutNm;
//			File cssDir = new File(cssPath);
//			
////			System.out.println(cssDir.getPath());
////			System.out.println(cssDir.exists());
//			
//			if(cssDir.exists() && cssDir.isDirectory()){
//				
//				File resources[] = cssDir.listFiles(new FilenameFilter() {
//					
//					@Override
//					public boolean accept(File dir, String name) {
////						System.out.println(name);
//						if(name.equals("headmenu00.css") == false && name.indexOf("headmenu") > -1 && FilenameUtils.getExtension(name).equals("css")){
//							return true;
//						}else{
//							return false;
//						}
//					}
//				});
//				
//				Arrays.sort(resources);
//				
//				List<File> headMenuList = (List<File>)Arrays.asList(resources);
//				List<Map<String, String>> resultList = new ArrayList<Map<String, String>>();
//				
//				for (File file : headMenuList) {
//					//System.out.println(cssPathName + FilenameUtils.getBaseName(file.getPath()));
//					Map<String, String> item = new HashMap<String, String>();
//					/** 2018.07.12 - 수정 */
//					//item.put("path", cssPathName + FilenameUtils.getBaseName(file.getPath()));
//					item.put("path", templatLayoutNm + FilenameUtils.getBaseName(file.getPath()));
//					item.put("fileName", FilenameUtils.getBaseName(file.getPath()));
//					resultList.add(item);
//				}
//				//System.out.println(headMenuList);
//				
//				model.addAttribute("headList", resultList);
//				model.addAttribute("paramVO", paramVO);
//			}
//		}catch(NullPointerException e){
//  	 log.error("NullPointerException",e);
//	}catch(NumberFormatException e){
//		log.error("NumberFormatException",e);
//	}catch(IllegalFormatException e){
//		log.error("IllegalFormatException",e);
//	}catch(ArrayIndexOutOfBoundsException e){
//		log.error("ArrayIndexOutOfBoundsException",e);
//	}catch(FileNotFoundException e){
//		log.error("FileNotFoundException",e);
//	}
//		
//		return "wzwg/site/mngr/screen/siteScreenTempltHeadmenu";
//	}
	
	
	/**
	 * 
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 * @author moo0506
	 * @since 2018.09.04
	 */
	@RequestMapping(value="/**/screen/selectSiteScreenTempltHeadmenuAjax.do")
	public String selectSiteScreenTempltHeadmenuAjax(
		@ModelAttribute("paramVO")SysMngrTemplateVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		try{
			
			
			@SuppressWarnings("deprecation")
			String realPath = request.getServletContext().getRealPath("/");
			//String cssPathName = "css/";
			/* 헤더메뉴 CSS 세팅 */
			String headmenuPath = "sample/templatestyle/head/";
			String headmenuType = StringUtils.defaultString(paramVO.getHeadMenuType(), "basic") + "/";
			
			List<Map<String, String>> headList = addCssNamePathList(null, realPath, headmenuPath + headmenuType, "", "css");
				
			model.addAttribute("headList", headList);
			
			/* 헤드메뉴 css명으로 basic/wide 분리 */
			List<Map<String, String>> headListBasic = new ArrayList<Map<String, String>>();
			List<Map<String, String>> headListWide = new ArrayList<Map<String, String>>();
			
			for (Map<String, String> head : headList) {
				if(head.get("fileName").indexOf("wide") >= 0) {
					headListWide.add(head);
				}else {
					headListBasic.add(head);
				}
			}
			model.addAttribute("headListBasic", headListBasic);
			model.addAttribute("headListWide", headListWide);
			
			/* 푸터메뉴 CSS 세팅 */
			String footmenuPath = "sample/templatestyle/foot/";
			String footmenuType = StringUtils.defaultString(paramVO.getFootMenuType(), "basic") + "/";
			
			List<Map<String, String>> footList = addCssNamePathList(null, realPath, footmenuPath + footmenuType, "", "css");
				
			model.addAttribute("footList", footList);
			
			/* 서브메뉴 CSS 세팅 */
			String submenuPath = "sample/templatestyle/sub/";
			//String submenuType = StringUtils.defaultString(paramVO.getSubMenuType(), "basic") + "/";
			
			List<Map<String, String>> subList = addCssNamePathList(null, realPath, submenuPath + "basic/", "", "css");
			
			model.addAttribute("subList", subList);
			/* 서브메뉴 와이드 CSS 세팅 추가 2019.04.17 조원권 */
			List<Map<String, String>> subWideList = addCssNamePathList(null, realPath, submenuPath + "wide/", "", "css");
			
			model.addAttribute("subWideList", subWideList);
			
			
			
			
			model.addAttribute("paramVO", paramVO);
		
		}catch(NullPointerException e){
	       	 log.error("NullPointerException",e);
	   	}catch(NumberFormatException e){
	   		log.error("NumberFormatException",e);
	   	}catch(IllegalFormatException e){
	   		log.error("IllegalFormatException",e);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		log.error("ArrayIndexOutOfBoundsException",e);
	   	}
		
		return "wzwg/site/mngr/screen/siteScreenTempltHeadmenu";
	}
	
	
	private List<Map<String, String>> addCssNamePathList(List<Map<String, String>> resultList, String realPath, String cssPath, String fileNameRule, String fileExtension){
		
		if(resultList == null){
			resultList = new ArrayList<Map<String, String>>();
		}
	
		try {
			File cssDir = new File(realPath + cssPath);
			
//			System.out.println(cssDir.getPath());
//			System.out.println(cssDir.exists());
			if(cssDir.exists() && cssDir.isDirectory()){
				ScreenUtilFileFilter cssFilter = new ScreenUtilFileFilter(fileNameRule, fileExtension);
				File resources[] = cssDir.listFiles(cssFilter);
				List<File> cssFileList =null;
				if(resources != null) {
				 cssFileList = (List<File>)Arrays.asList(resources);
				}
				if(cssFileList != null) {
				Collections.sort(cssFileList);
				Collections.reverse(cssFileList);
				for (File file : cssFileList) {
					//System.out.println(cssPathName + FilenameUtils.getBaseName(file.getPath()));
					Map<String, String> item = new HashMap<String, String>();
					item.put("path", cssPath + FilenameUtils.getBaseName(file.getPath()));
					item.put("fileName", FilenameUtils.getBaseName(file.getPath()));
					resultList.add(item);
				}
				//System.out.println(headMenuList);
				}
			}
		} catch(NullPointerException e){
	       	 log.error("NullPointerException",e);
	   	}catch(NumberFormatException e){
	   		log.error("NumberFormatException",e);
	   	}catch(IllegalFormatException e){
	   		log.error("IllegalFormatException",e);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		log.error("ArrayIndexOutOfBoundsException",e);
	   	}
		
		
		return resultList;
	}
	
	private static String getTimeStamp() {

		String rtnStr = null;

		// 문자열로 변환하기 위한 패턴 설정(년도-월-일 시:분:초:초(자정이후 초))
		String pattern = "yyyyMMddhhmmssSSS";

		    SimpleDateFormat sdfCurrent = new SimpleDateFormat(pattern, Locale.KOREA);
		    Timestamp ts = new Timestamp(System.currentTimeMillis());

		    rtnStr = sdfCurrent.format(ts.getTime());

		return rtnStr;
	    }
	
	@RequestMapping(value="/**/module/schdul/bassInfo/calMonDataJson.do")
    public ModelAndView selectCalMonDataJson (
        @ModelAttribute("paramVO") ModuleSchdulBassInfoVO paramVO
        , HttpServletRequest request ) throws Exception {
    
       
        if(paramVO.getSearchYYYYMM()==null || paramVO.getSearchYYYYMM().equals("")){
        	paramVO.setSearchYYYYMM(DateUtils.getCurrentDate("yyyyMM"));
        }
        
        // 컨텐츠 데이터를 가져옴
        List<EgovMap> cntntsData = schdulService.selectCalMonList(paramVO);

        ModelAndView model = new ModelAndView();
    
        model.setViewName("jsonView");
            DateFormat df = new SimpleDateFormat("yyyyMMdd");
            Date date = df.parse(paramVO.getSearchYYYYMM()+"01");
            // 날짜 더하기 
            Calendar cal = Calendar.getInstance();
            cal.setTime(date); 
            int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
            cal.add(Calendar.MONTH, 1);
            
         String nextMonth = df.format(cal.getTime());
         cal.setTime(date); 
         cal.add(Calendar.MONTH, -1);
         String preMonth = df.format(cal.getTime());
         
        
        // 컨텐츠 데이터를 JSON 변환하여 넘김
        model.addObject("calData", cntntsData);
        model.addObject("searchYYYY", paramVO.getSearchYYYYMM().substring(0, 4)); 
        model.addObject("searchMM",  paramVO.getSearchYYYYMM().substring(4));
        model.addObject("today", DateUtils.getCurrentDate("yyyyMMdd"));
        model.addObject("preMonth", preMonth.substring(0, 6));
        model.addObject("nextMonth", nextMonth.substring(0, 6));
        model.addObject("lastDay", lastDay);
        
        return model;
    }
	
	
	@RequestMapping(value="/**/module/schdul/bassInfo/calDataJson.do")
    public ModelAndView selectCalDataJson (
        @ModelAttribute("paramVO") ModuleSchdulBassInfoVO paramVO
        , HttpServletRequest request ) throws Exception {
    
       
        if(paramVO.getSearchYYYYMM()==null || paramVO.getSearchYYYYMM().equals("")){
        	paramVO.setSearchYYYYMM(DateUtils.getCurrentDate("yyyyMM"));
        }
        
        // 컨텐츠 데이터를 가져옴
        List<EgovMap> cntntsData = schdulService.selectCalList(paramVO);

        ModelAndView model = new ModelAndView();
    
        model.setViewName("jsonView");
            DateFormat df = new SimpleDateFormat("yyyyMMdd");
            Date date = df.parse(paramVO.getSearchYYYYMM()+"01");
            // 날짜 더하기 
            Calendar cal = Calendar.getInstance();
            cal.setTime(date); 
            int lastDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);
            cal.add(Calendar.MONTH, 1);
         String nextMonth = df.format(cal.getTime());
         cal.setTime(date); 
         cal.add(Calendar.MONTH, -1);
         String preMonth = df.format(cal.getTime());
         
        
        // 컨텐츠 데이터를 JSON 변환하여 넘김
        model.addObject("calData", cntntsData);
        model.addObject("searchYYYY", paramVO.getSearchYYYYMM().substring(0, 4)); 
        model.addObject("searchMM",  paramVO.getSearchYYYYMM().substring(4));
        model.addObject("today", DateUtils.getCurrentDate("yyyyMMdd"));
        model.addObject("preMonth", preMonth.substring(0, 6));
        model.addObject("nextMonth", nextMonth.substring(0, 6));
        model.addObject("lastDay", lastDay);
        
        return model;
    }
	
	
	@RequestMapping(value= {"/mngr/screen/selectSiteScreenFrameMngr.do","/{siteKey}/mngr/screen/selectSiteScreenFrameMngr.do"})
	public String selectSiteScreenFrameMngr(
			@ModelAttribute("paramVO")SiteScreenVO siteScreenVO
			, HttpServletRequest request
			, Model model ) throws Exception {
		
			
		return "wzwg/site/mngr/screen/siteScreenTempltFrame";
	}
	
	@RequestMapping(value= {"/mngr/screen/selectSaveSubPageListAjax.do","/{siteKey}/mngr/screen/selectSaveSubPageListAjax.do"})
	public String selectSaveSubPageListAjax(
			@ModelAttribute("paramVO")SiteScreenVO siteScreenVO
			, HttpServletRequest request
			, Model model ) throws Exception {
		
		siteScreenVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		//String realPath =request.getServletContext().getRealPath("/");
		Map<String, Object> siteMenuList = siteScreenService.selectSiteMenuMngrList(siteScreenVO);
		model.addAttribute("menuList", siteMenuList.get("MENU_LIST"));
		
		return "wzwg/site/mngr/screen/saveSubPageList";
	}
	
	@RequestMapping(value= {"/mngr/screen/selectModuleMenuList.do","/{siteKey}/mngr/screen/selectModuleMenuList.do"})
	public String selectModuleMenuList(
			@ModelAttribute("paramVO")SiteScreenVO siteScreenVO
			, HttpServletRequest request, Model model) throws Exception {
		
		siteScreenVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		String paramSysmoduleSeq = StringUtils.defaultString(siteScreenVO.getSysmoduleSeq());
		
		List<SiteMenuVO> siteMenuList = new ArrayList<>();
		
		if(("SGC0000027").equals(paramSysmoduleSeq)) {
			siteScreenVO.setSysmoduleSeq("10000000003"); // 통합게시판
			List<SiteMenuVO> boardList = siteScreenService.selectModuleMenuList(siteScreenVO);
			siteScreenVO.setSysmoduleSeq("10000000218"); // 링크게시판
			List<SiteMenuVO> linkList = siteScreenService.selectModuleMenuList(siteScreenVO);
			siteScreenVO.setSysmoduleSeq("10000000237"); // 이미지게시판
			List<SiteMenuVO> imageList = siteScreenService.selectModuleMenuList(siteScreenVO);
			
			siteMenuList.addAll(boardList);
			siteMenuList.addAll(linkList);
			siteMenuList.addAll(imageList);
			
			//중복제거를 위해 맵에 넣음
			Map<String, SiteMenuVO> menuMap = new LinkedHashMap<>();
			
			for (SiteMenuVO siteMenuVO : siteMenuList) {
				menuMap.put(siteMenuVO.getMenuSeq(), siteMenuVO);
			}
			
			List<SiteMenuVO> resultList = new ArrayList<>();
			
			//맵을 다시 리스트로 만듬
			Iterator<String> i = menuMap.keySet().iterator();
			while(i.hasNext()) {
				String key = i.next();
				resultList.add(menuMap.get(key));
			}
			siteMenuList = resultList;
			
			
		}else {
			siteMenuList = siteScreenService.selectModuleMenuList(siteScreenVO);
		}
		
		model.addAttribute("moduleMenuList", siteMenuList);
		
		/* 탭컨텐츠에 연결된 게시판 목록 불러오기 */
		List<SiteScreenVO> tabMenuModuleList = null; 
		if(("SGC0000027").equals(paramSysmoduleSeq)) {
			siteScreenVO.setSysmoduleSeq(null);
			tabMenuModuleList = siteScreenService.selectTabMenuModuleList(siteScreenVO); 
		}else {
			tabMenuModuleList = siteScreenService.selectTabMenuModuleList(siteScreenVO);
		}
		
		
		Map<String, SiteScreenVO> tabMenuGrpMap = new LinkedHashMap<>();
		List<SiteScreenVO> tabMenuGrpList = new ArrayList<SiteScreenVO>();
		
		for (SiteScreenVO clBbsModuleVO : tabMenuModuleList) {
			tabMenuGrpMap.put(clBbsModuleVO.getBbsSeq(), clBbsModuleVO);//그룹의 중복제거를 위해 맵으로 만듬
		}
		
		//맵을 다시 리스트로 만듬
		Iterator<String> i = tabMenuGrpMap.keySet().iterator();
		while(i.hasNext()) {
			String key = i.next();
			tabMenuGrpList.add(tabMenuGrpMap.get(key));
		}
		model.addAttribute("tabMenuModuleList", tabMenuModuleList);//실제목록
		model.addAttribute("tabMenuGrpList", tabMenuGrpList);//그룹용 목록  BBS_SEQ로 그룹핑됨
		
		
		return "/wzwg/site/mngr/screen/siteScreenModuleMenuList";
	}
	
}
