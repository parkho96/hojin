package egovframework.wzwg.module.cmnt.web;

import java.io.File;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;
import egovframework.wzwg.module.bbs.unity.service.ModuleBbsUnityBassInfoService;
import egovframework.wzwg.module.cmnt.service.CmntMenuAuthService;
import egovframework.wzwg.module.cmnt.service.CmntMenuAuthVO;
import egovframework.wzwg.module.cmnt.service.CmntMenuService;
import egovframework.wzwg.module.cmnt.service.CmntMenuVO;
import egovframework.wzwg.module.cmnt.service.CmntUserService;
import egovframework.wzwg.module.cmnt.service.CmntUserVO;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntCfgService;
import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntCfgVO;
import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntInfoService;
import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntInfoVO;
import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.usrMngr.usrInfo.service.SysMngrUsrInfoService;
import egovframework.wzwg.sysMngr.usrMngr.usrInfo.service.SysMngrUsrInfoVO;

@Controller
public class CmntInfoController { 
	
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
	@Resource(name="SiteCmntCfgService")
	private SiteCmntCfgService siteCmntCfgService;
	
	/** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name="SiteCmntInfoService")
	private SiteCmntInfoService siteCmntInfoService;
    
    @Resource(name="CmmCodeService")
    private CmmCodeService codeService;
    
    @Resource(name="SiteUsrGroupService")
	SiteUsrGroupService siteUsrGroupService;
    
    @Resource(name="SysMngrUsrInfoService")
	private SysMngrUsrInfoService usrInfoService;
    
    @Resource(name="CmntMenuService")
   	private CmntMenuService cmntMenuService;
    
    @Resource(name="ModuleBbsUnityBassInfoService")
   	private ModuleBbsUnityBassInfoService bbsUnityBassInfoService;
    
    @Resource(name="CmntMenuAuthService")
  	private CmntMenuAuthService cmntMenuAuthService;
    
    @Resource(name="CmntUserService")
	private CmntUserService cmntUserService;
  
    @Resource(name="ModuleUploadFileUtil")
    protected ModuleUploadFileUtil fileUtil;
	
    @Resource(name = "ModuleUploadFileService")
    protected ModuleUploadFileService fileService;
 
	@RequestMapping(value="/module/cmnt/selectCmntInc.do")
	public String selectCmntInc(
			@ModelAttribute("paramVO") SiteCmntCfgVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		model.addAttribute("groupList",siteCmntCfgService.selectSiteCmntCfgroupList(paramVO));
		return "wzwg/module/cmnt/cmntInc";
	}
	
	@RequestMapping(value={"/module/cmnt/selectCmntListAjax.do", "/{siteKey}/module/cmnt/selectCmntListAjax.do"})
	public String selectCmntListAjax(
			@ModelAttribute("paramVO") SiteCmntInfoVO paramVO
			,@ModelAttribute("cfgVO") SiteCmntCfgVO cfgVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		 
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		 
		paramVO.setPageUnit(propertyService.getInt("pageUnit"));
		paramVO.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(8);
		paginationInfo.setPageSize(paramVO.getPageSize());

		paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
		paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		paramVO.setCmntOpenCode("SC00000336");
		paramVO.setCmntApprovalCodeSearch("SC00000339");
		// 사이트 정보 목록
		int resultCnt = siteCmntInfoService.selectSiteCmntInfoCnt(paramVO);
		
		paginationInfo.setTotalRecordCount(resultCnt);
		SiteCmntCfgVO siteCmntCfgVO = new SiteCmntCfgVO();
		siteCmntCfgVO.setSiteSeq(siteSeq);
		
		/* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
		model.addAttribute("cmntCfgVO",siteCmntCfgService.selectSiteCmntCfg(siteCmntCfgVO));
		model.addAttribute("resultList", siteCmntInfoService.selectSiteCmntInfoList(paramVO));
		model.addAttribute("resultCnt", resultCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("paramVO", paramVO);
		cfgVO.setSiteSeq(siteSeq);
		model.addAttribute("groupList",siteCmntCfgService.selectSiteCmntCfgroupList(cfgVO));
		return "wzwg/module/cmnt/cmntList";
	}
	
	@RequestMapping(value= {"/module/cmnt/registCmntAjax.do","/{siteKey}/module/cmnt/registCmntAjax.do"})
	public String registCmntAjax(
			@ModelAttribute("paramVO") SiteCmntInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		 
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		model.addAttribute("cmntOpenCodeList", codeService.selectCodeInfoList("CMNT_OPEN_CODE"));
		
		return "wzwg/module/cmnt/cmntRegist";
	}
	 
	

    @RequestMapping(value="/**/cmnt/info/registCmntInfoAjax.do")
   	public ModelAndView registCmntInfoAjax (
   			@ModelAttribute("paramVO")SiteCmntInfoVO paramVO
   			, HttpServletRequest request 
   			, HttpServletResponse response
   			) throws Exception {
   			ModelAndView model = new ModelAndView();
   	    	model.setViewName("jsonView"); 
   		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
   		paramVO.setSiteSeq(siteSeq); 
   		String cmntSeq  = siteCmntInfoService.selectSiteCmntSeq(paramVO);
   		paramVO.setCmntSeq(cmntSeq);
   		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
   		paramVO.setFrstRegisterId(loginVO.getUserId());
   		siteCmntInfoService.registSiteCmntInfo(paramVO);
   		SiteCmntCfgVO siteCmntCfgVO = new SiteCmntCfgVO();
   		SiteCmntCfgVO siteCmntCfgResult = new SiteCmntCfgVO();
		siteCmntCfgVO.setSiteSeq(siteSeq);
		siteCmntCfgResult = siteCmntCfgService.selectSiteCmntCfg(siteCmntCfgVO);
		model.addObject("cmntAppvlCode", siteCmntCfgResult.getCmntAppvlCode());
		if(siteCmntCfgResult.getCmntAppvlCode().equals("SC00000335")){
   		paramVO.setCmntApprovalCode("SC00000339");
   		siteCmntInfoService.modifySiteCmntInfoApproval(paramVO);
		}
		CmntMenuAuthVO cmntMenuAuthVO = new CmntMenuAuthVO();
			
   		ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
   		moduleBbsVO.setBbsNm(egovMessageSource.getMessage("wzwg.cmm.word.notice02"));
   		moduleBbsVO.setBbsDc(egovMessageSource.getMessage("wzwg.cmm.word.notice02"));
   		moduleBbsVO.setListScrinCode("L");
   		moduleBbsVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
   		moduleBbsVO.setCmntUseAt("Y");
	   	String bbs_seq =bbsUnityBassInfoService.registBbsBassInfoInit(moduleBbsVO);
	   	CmntMenuVO cmntMenuVO = new CmntMenuVO();
	   	cmntMenuVO.setMenuSeq(cmntMenuService.selectCmntMenuSeq());
   		cmntMenuAuthVO.setMenuSeq(cmntMenuVO.getMenuSeq());
	   	cmntMenuVO.setBbsSeq(bbs_seq);
	   	cmntMenuVO.setMenuOrdr("1");
	   	cmntMenuVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
	   	cmntMenuVO.setSiteSeq(siteSeq);
	   	cmntMenuVO.setCmntSeq(String.valueOf(cmntSeq));
	   	cmntMenuVO.setMenuNm(egovMessageSource.getMessage("wzwg.cmm.word.notice02"));
	   	cmntMenuAuthVO.setSiteSeq(siteSeq);
	   	cmntMenuAuthVO.setCmntSeq(String.valueOf(cmntSeq));
		cmntMenuService.registCmntMenu(cmntMenuVO);
   		cmntMenuAuthVO.setApprvlCode("SC00000339");
   		cmntMenuAuthVO.setAuthSe("C");
   		cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO);
   		cmntMenuAuthVO.setApprvlCode("SC00000339");
   		cmntMenuAuthVO.setAuthSe("R");
   		cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO);
   		cmntMenuAuthVO.setApprvlCode("SC00000340");
   		cmntMenuAuthVO.setAuthSe("C");
   		cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO);
   		cmntMenuAuthVO.setApprvlCode("SC00000340");
   		cmntMenuAuthVO.setAuthSe("R");
   		cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO);
   		
   		return model;
   	}
    
	@RequestMapping(value= {"/module/cmnt/registCmntResultAjax.do","/{siteKey}/module/cmnt/registCmntResultAjax.do"})
	public String registCmntResultAjax(
			@ModelAttribute("paramVO") SiteCmntInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		 
		return "wzwg/module/cmnt/cmntRegistResult";
	}
	
	
	@RequestMapping(value= {"/module/cmnt/main/{cmntSeq}","/{siteKey}/module/cmnt/main/{cmntSeq}"})
	public String selectCmntMainTemplt(
			@PathVariable(value = "cmntSeq") String cmntSeq
			, HttpServletRequest request
			, HttpSession session
			, ModelMap model
		) throws Exception{
		/** 사이트 시퀀스 입력 */
		SiteCmntInfoVO paramVO = new SiteCmntInfoVO();
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		 if(session.getAttribute("cmntMngrAt") !=null){
			 session.removeAttribute("cmntMngrAt");
		 }
   		paramVO.setSiteSeq(siteSeq); 
   		paramVO.setCmntSeq(cmntSeq);
   		CmntMenuVO cmntMenuVO = new CmntMenuVO();
   		cmntMenuVO.setSiteSeq(siteSeq); 
   		cmntMenuVO.setCmntSeq(cmntSeq);
   		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		CmntUserVO cmntUserVO = new CmntUserVO();
		CmntUserVO cmntUser = new CmntUserVO();
		
   		cmntUserVO.setSiteSeq(siteSeq);
   		cmntUserVO.setCmntSeq(cmntSeq);
   		
   		if(loginVO == null || loginVO.getUsrSeq() == null){
   			cmntUserVO.setUsrSeq("0");
   		}else{
   			cmntUserVO.setUsrSeq(loginVO.getUsrSeq());
   		}
   		
   		cmntUserService.registCmntConn(cmntUserVO);
  // 		cmntUser = cmntUserService.selectCmntUser(cmntUserVO);
//   		if(session.getAttribute("cmntApprvlCode")!=null){
//   			session.removeAttribute("cmntApprvlCode");
//   		}
//   		if(cmntUser !=null){
//   			session.setAttribute("cmntApprvlCode", cmntUser.getApprvlCode());
//   		}
   		SiteCmntInfoVO	result = siteCmntInfoService.selectSiteCmntInfo(paramVO);
   		
   		if(loginVO != null) {
   			if (result.getCmntMngrSeq().equals(loginVO.getUsrSeq())){
   				session.setAttribute("cmntMngrAt", true);
   			}
   		}
   		model.addAttribute("cmntUserYn", cmntUserService.selectCmntUserChk(cmntUserVO) > 0 ? "Y":"N");
   		model.addAttribute("result", result);
   		model.addAttribute("menuList", cmntMenuService.selectCmntMenuList(cmntMenuVO));
   		model.addAttribute("groupList",siteCmntInfoService.selectSiteCmntInfoGroupList(paramVO));
		return "wzwg/module/cmnt/cmntMain";
	}
	
	
	@RequestMapping(value= {"/module/cmnt/mngr/{cmntSeq}","/{siteKey}/module/cmnt/mngr/{cmntSeq}"})
	public String selectCmntMngrTemplt(
			@PathVariable(value = "cmntSeq") String cmntSeq
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		/** 사이트 시퀀스 입력 */
		SiteCmntInfoVO paramVO = new SiteCmntInfoVO();
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
   		paramVO.setSiteSeq(siteSeq); 
   		paramVO.setCmntSeq(cmntSeq);
   		model.addAttribute("result", siteCmntInfoService.selectSiteCmntInfo(paramVO));
		return "wzwg/module/cmnt/cmntMngr";
	}
	
	@RequestMapping(value= {"/module/cmnt/mngr/cmntMngrBasicAjax.do","/{siteKey}/module/cmnt/mngr/cmntMngrBasicAjax.do"})
	public String cmntMngrBasicAjax(
			@ModelAttribute("paramVO") SiteCmntInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq); 
		model.addAttribute("result", siteCmntInfoService.selectSiteCmntInfo(paramVO));
		model.addAttribute("appvlCodeList", codeService.selectCodeInfoList("CMNT_APPVL_CODE"));
		model.addAttribute("usrgroupList", siteUsrGroupService.selectSiteUsrGroupCode(siteSeq));
		model.addAttribute("groupList",siteCmntInfoService.selectSiteCmntInfoGroupList(paramVO));
		return "wzwg/module/cmnt/cmntMngrBasic";
	}
	
	
	@RequestMapping(value= {"/cmnt/mngr/searchCmntMngrAjax.do","/{siteKey}/cmnt/mngr/searchCmntMngrAjax.do"})
	public String searchCmntMngrAjax(
			@ModelAttribute("paramVO") SysMngrUsrInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		 
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
   		paramVO.setSiteSeq(siteSeq); 
		/** =================== paging 시작 ============================== */
		PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(5);
        paginationInfo.setPageSize(5);
       
        paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
        paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        /** =================== paging 끝 =============================== */
        
		// 사이트 정보 카운트
		Integer usrInfoCnt = usrInfoService.selectUsrInfoListCnt(paramVO);
		
		// 사용자 정보 목록
		List<SysMngrUsrInfoVO> usrInfoList = usrInfoService.selectUsrInfoList(paramVO);
		
		paginationInfo.setTotalRecordCount(usrInfoCnt.intValue());
        
		model.addAttribute("usrInfoCnt", usrInfoCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("usrInfoList", usrInfoList);
		
		return "wzwg/module/cmnt/searchCmntMngr";
	}
	
	@RequestMapping(value="/**/cmnt/info/modifyCmntMngrSeqAjax.do")
   	public ModelAndView modifyCmntMngrSeqAjax (
   			@ModelAttribute("paramVO")SiteCmntInfoVO paramVO
   			, HttpServletRequest request 
   			, HttpServletResponse response
   			) throws Exception {
   			ModelAndView model = new ModelAndView();
   	    	model.setViewName("jsonView"); 
   		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
   		paramVO.setSiteSeq(siteSeq);  
   		siteCmntInfoService.modifySiteCmntInfoMngrSeq(paramVO);
   		return model;
   	}
	
	@RequestMapping(value= {"/cmnt/mngr/cmntIconPopAjax.do","/{siteKey}/cmnt/mngr/cmntIconPopAjax.do"})
	public String cmntIconPopAjax(
			@ModelAttribute("paramVO") SiteCmntInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		 
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
   		paramVO.setSiteSeq(siteSeq); 
        
		return "wzwg/module/cmnt/cmntMngrIconPop";
	}
	
	@RequestMapping(value="/**/cmnt/info/modifyCmntIconAjax.do")
   	public ModelAndView modifyCmntIconAjax (
   			@ModelAttribute("paramVO")SiteCmntInfoVO paramVO
   			, HttpServletRequest request 
   			, HttpServletResponse response
   			) throws Exception {
   			ModelAndView model = new ModelAndView();
   	    	model.setViewName("jsonView"); 
   		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
   		paramVO.setSiteSeq(siteSeq);  
   		siteCmntInfoService.modifySiteCmntInfoIconStre(paramVO);
   		return model;
   	}
	
	 @RequestMapping(value="/**/cmnt/info/uploadCmntIconAjax.do")
		public ModelAndView uploadCmntIconAjax(
				@ModelAttribute("paramVO")SiteCmntInfoVO paramVO
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
		             String storePathString = siteSeq + "/" + "cmnt" + "/icon/" + calendar.get(Calendar.YEAR)
		                     + "/" + ((calendar.get(Calendar.MONTH) + 1) < 10 ? "0"+(calendar.get(Calendar.MONTH) + 1):(calendar.get(Calendar.MONTH) + 1)) 
		                     + "/" + (calendar.get(Calendar.DATE) < 10 ? "0"+calendar.get(Calendar.DATE):calendar.get(Calendar.DATE)) + "/";
		             String filePathStr = "/upload/"+storePathString;
		             
		             storePathString = fileOrgPath+storePathString;
		             
		             String whiteFileExtStr = "";
		            whiteFileExtStr = EgovProperties.getProperty("Globals.WhiteFileExt");

		             
		    		 File saveFolder = new File(EgovWebUtil.filePathBlackList(storePathString));

		    	        if (!saveFolder.exists() || saveFolder.isFile()) {
		    	            saveFolder.mkdirs();
		    	        }
		    	        
		    	        
		    	        int index = (orginFileName == null) ? -1 : orginFileName.lastIndexOf(".");
		    	        if (index != -1) {
		    	        	String fileExt = orginFileName.substring(index + 1);
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
		    	        			fileUtil.deleteFile(EgovWebUtil.filePathBlackList(filePath)+"."+fileExt);
		    	        			return model;
		    	        		}
		    	        	}

		    	        	if(!result.isEmpty() || result.size() != 0){
		    	        		paramVO.setCmntIconStre(filePathStr+result.get(0).getStreFileNm()); 
		    	        	}
		    	        }
		    }
	 	     	       
			 siteCmntInfoService.modifySiteCmntInfoIconStre(paramVO);
			 model.addObject("cmntIconStre",paramVO.getCmntIconStre() );
			 return model;
		}
	
	@RequestMapping(value="/**/cmnt/info/modifyCmntAjax.do")
   	public ModelAndView modifyCmntAjax (
   			@ModelAttribute("paramVO")SiteCmntInfoVO paramVO
   			, HttpServletRequest request 
   			, HttpServletResponse response
   			) throws Exception {
   			ModelAndView model = new ModelAndView();
   	    	model.setViewName("jsonView"); 
   		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
   		paramVO.setSiteSeq(siteSeq);
   		siteCmntInfoService.deleteSiteCmntInfoGroup(paramVO); 
   		System.out.println("paramVO.getUsrgroupSeqArry() :"+paramVO.getUsrgroupSeqArry());
   		if(paramVO.getUsrgroupSeqArry() != null){
   		for(int i=0;i<paramVO.getUsrgroupSeqArry().length;i++){
   			paramVO.setUsrgroupSeq(paramVO.getUsrgroupSeqArry()[i]);
   			siteCmntInfoService.registSiteCmntCfgroup(paramVO);
   		}
   		}
   		siteCmntInfoService.modifySiteCmntInfoMngr(paramVO);
   		return model;
   	}
	
	@RequestMapping(value= {"/module/cmnt/mngr/cmntMngrProvisionAjax.do","/{siteKey}/module/cmnt/mngr/cmntMngrProvisionAjax.do"})
	public String cmntMngrProvisionAjax(
			@ModelAttribute("paramVO") SiteCmntInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq); 
		model.addAttribute("result", siteCmntInfoService.selectSiteCmntInfoProvision(paramVO));
		return "wzwg/module/cmnt/cmntMngrProvision";
	}
	
	@RequestMapping(value="/**/cmnt/info/modifyCmntProvisionAjax.do")
   	public ModelAndView modifyCmntProvisionAjax (
   			@ModelAttribute("paramVO")SiteCmntInfoVO paramVO
   			, HttpServletRequest request 
   			, HttpServletResponse response
   			) throws Exception {
   			ModelAndView model = new ModelAndView();
   	    	model.setViewName("jsonView"); 
   		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
   		paramVO.setSiteSeq(siteSeq);  
   		siteCmntInfoService.modifySiteCmntInfoProvision(paramVO);
   		return model;
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
	
	
}
