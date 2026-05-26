package egovframework.wzwg.module.ntt.custom.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.fcc.service.EgovMailUtil;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.cmm.util.CmmXssUtil;
import egovframework.wzwg.cmm.util.JacksonMapperUtil;
import egovframework.wzwg.cmm.util.SecureAES256;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsCmmnService;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;
import egovframework.wzwg.module.bbs.custom.service.ModuleBbsCustomBassInfoService;
import egovframework.wzwg.module.bbs.custom.service.ModuleBbsCustomVO;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttCmmnService;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;
import egovframework.wzwg.module.ntt.module.tag.service.ModuleNttTagService;
import egovframework.wzwg.module.ntt.module.tag.service.ModuleNttTagVO;
import egovframework.wzwg.module.ntt.unity.service.ModuleNttUnityDataManageService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.module.upload.fileMngr.service.ModuleUploadFileMngrService;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthService;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;

@Controller
public class ModuleNttCustomDataManageController {


    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    /** ModuleNttService */
    @Resource(name="ModuleNttCmmnService")
    protected ModuleNttCmmnService nttCmmnService;
    
    /** ModuleNttService */
    @Resource(name="ModuleNttUnityDataManageService")
    protected ModuleNttUnityDataManageService nttUnityService;
    
    /** ModuleBbsCmmnService */
    @Resource(name="ModuleBbsCmmnService")
    protected ModuleBbsCmmnService bbsCmmnService;
    
    /** ModuleBbsCustomBassInfoService */
    @Resource(name="ModuleBbsCustomBassInfoService")
    protected ModuleBbsCustomBassInfoService bbsCustomBassInfoService;
    
    /** ModuleNttTagService */
    @Resource(name="ModuleNttTagService")
    protected ModuleNttTagService nttTagService;
    
    @Resource(name="ModuleUploadFileUtil")
    protected ModuleUploadFileUtil fileUtil;
	
    @Resource(name = "ModuleUploadFileService")
    protected ModuleUploadFileService fileService;

    /** CntntsAuthService */
    @Resource(name="CntntsAuthService")
    protected CntntsAuthService cntntsAuthService;	

    @Resource(name="ModuleUploadFileMngrService")
	private ModuleUploadFileMngrService moduleUploadFileMngrService;

    private final String secureKey = EgovProperties.getProperty("secure.aes256.key");
	
	/**
	 * ㅁ 통합게시물 - 데이터관리 - 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/custom/selectNttListAjax.do")
	public String selectNttList(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");

		if(loginVO != null){
			paramVO.setUsrSeq(loginVO.getUsrSeq());
		} else {
			paramVO.setUsrSeq("0");
		}		
		
		List<CntntsInfoVO> bbsList = bbsCmmnService.selectBbsList(paramVO.getSiteSeq());
    	
    	if(paramVO.getBbsSeq() == null && bbsList.size() > 0){
    		paramVO.setBbsSeq(bbsList.get(0).getCntntsSeq());
    	}
    	
    	model.addAttribute("bbsList", bbsList);
    	
    	ModuleBbsVO resultVO = new ModuleBbsVO();
		
		resultVO.setBbsSeq(paramVO.getBbsSeq());
		
		// 게시판 기본정보
		resultVO = bbsCustomBassInfoService.selectBbsBassInfoDetail(resultVO);
		
    	List<String> countList = new ArrayList<String>();
		
		int listCountUnit = paramVO.getPageUnit();
		int countMax = 0;
		
		if("Y".equals(StringUtils.defaultString(resultVO.getListCountAt()))){
			listCountUnit = Integer.parseInt(resultVO.getListCountUnit());
			
			countMax = listCountUnit * 10;
			
			for(int i = listCountUnit; i <= countMax; i++){
				if(i % listCountUnit == 0){
					countList.add(Integer.toString(i));
				}
			}
		}
		
		model.addAttribute("countList", countList);
		model.addAttribute("resultVO", 	resultVO);
		
		paramVO.setPageUnit(propertyService.getInt("pageUnit"));
		paramVO.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();
		
		int pageUnit = listCountUnit;
		
		if(!"".equals(StringUtils.defaultString(paramVO.getListCount()))){
			pageUnit = Integer.parseInt(paramVO.getListCount());
		}else{
			paramVO.setListCount(Integer.toString(pageUnit));
		}

		paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(pageUnit);
		paginationInfo.setPageSize(paramVO.getPageSize());

		paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
		paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		String returnPage = "";
		
		if(resultVO != null){
			
			if("B".equals(resultVO.getListScrinCode())){	returnPage = "nttBlogList";		}	// 블로그형
			if("W".equals(resultVO.getListScrinCode())){	returnPage = "nttWebzineList";	}	// 웹진형
			if("I".equals(resultVO.getListScrinCode())){	returnPage = "nttImageList";	}	// 이미지형
			if("L".equals(resultVO.getListScrinCode())){	returnPage = "nttList";			}	// 목록형
			
			paramVO.setListScrinCode(resultVO.getListScrinCode());
			
		}else{
			returnPage = "nttList";
		}
		
		// 목록
		List<ModuleNttVO> resultList = nttUnityService.selectNttList(paramVO);
		
		// 목록 총 갯수
		Integer resultCnt = nttUnityService.selectNttListTotCnt(paramVO);
		
		// 말머리 여부
		List<ModuleBbsVO> subospecList = bbsCmmnService.selectBbsSubospecList(paramVO.getBbsSeq());
		Integer subospecListCnt = 0;
		
		if(subospecList != null){
			subospecListCnt = subospecList.size();
		}
		
		paginationInfo.setTotalRecordCount(resultCnt.intValue());
		
		/* 커스텀 기능 조회 */
		ModuleBbsVO funcVO = bbsCustomBassInfoService.selectBbsCustomFunctionDetail(resultVO);
		model.addAttribute("funcVO", funcVO);
		
		/* 커스텀 필드 조회 */
		Map<String, String> fieldVO = new HashMap<String, String>();
		fieldVO.put("siteSeq", CmmSessionUtil.getSessionSiteSeq(request));
		if(resultVO != null) {
			fieldVO.put("bbsSeq", resultVO.getBbsSeq());
		}
		List<ModuleBbsCustomVO> fieldList = bbsCustomBassInfoService.selectBbsBassInfoCustomFieldList(fieldVO);
		model.addAttribute("fieldList", fieldList);
		
		List<String> dimListFields = new ArrayList<String>();
		
		for (ModuleBbsCustomVO bbsCustomVO : fieldList) {
			if(bbsCustomVO.getListAt().equalsIgnoreCase("Y") == false){
				dimListFields.add(bbsCustomVO.getFieldId());
			}
		}
		
		// 목록에 포함되지 않는 필드를 제거해준 리스트
		List<ModuleNttVO> resultList2 = new ArrayList<ModuleNttVO>();
		for(int i=0;i <resultList.size();i++){
			ModuleNttVO moduleNtt = new ModuleNttVO();
			moduleNtt = resultList.get(i);
			String nttCn = moduleNtt.getNttCn();
			ObjectMapper m = new ObjectMapper();
			Map<String, Object> map = new HashMap<String, Object>();
			map = m.readValue(nttCn, new TypeReference<Map<String,Object>>() {} );
			
			for (String filedKey : dimListFields) {
				if(!filedKey.equals("password")){
				map.put(filedKey, "");
				}
			}
			
			String convertNttCn = m.writeValueAsString(map);
			moduleNtt.setNttCn(convertNttCn);
			
			resultList2.add(moduleNtt);
			
		}
		
		/* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
		model.addAttribute("nttAuthVO", 		nttCmmnService.selectCntntsAuthForNtt(request, paramVO.getMenuSeq()));
//		model.addAttribute("resultList", 		resultList);
		model.addAttribute("resultList", 		resultList2);
		model.addAttribute("resultCnt", 		resultCnt);
		model.addAttribute("subospecList", 		subospecList);
		model.addAttribute("subospecListCnt", 	subospecListCnt);
		model.addAttribute("paginationInfo", 	paginationInfo);
			
		
		
		return "wzwg/module/ntt/custom/" + returnPage;
		
	}
	
	/**
	 * ㅁ 통합게시물 - 데이터관리 - 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/custom/selectNttExcelAjax.do")
	public String selectNttExcel(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");

		if(loginVO != null){
			paramVO.setUsrSeq(loginVO.getUsrSeq());
		} else {
			paramVO.setUsrSeq("0");
		}		
		
		List<CntntsInfoVO> bbsList = bbsCmmnService.selectBbsList(paramVO.getSiteSeq());
    	
    	if(paramVO.getBbsSeq() == null && bbsList.size() > 0){
    		paramVO.setBbsSeq(bbsList.get(0).getCntntsSeq());
    	}
    	
    	model.addAttribute("bbsList", bbsList);
    	
    	ModuleBbsVO resultVO = new ModuleBbsVO();
		
		resultVO.setBbsSeq(paramVO.getBbsSeq());
		
		// 게시판 기본정보
		resultVO = bbsCustomBassInfoService.selectBbsBassInfoDetail(resultVO);
		
    	List<String> countList = new ArrayList<String>();
		
		model.addAttribute("countList", countList);
		model.addAttribute("resultVO", 	resultVO);
		
		paramVO.setPageUnit(100000);
		paramVO.setPageSize(100000);

		PaginationInfo paginationInfo = new PaginationInfo();
		
		 

		paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(100000);
		paginationInfo.setPageSize(paramVO.getPageSize());

		paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
		paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		
		String returnPage = "";
		
		 
			returnPage = "nttExcel"; 
		// 목록
		List<ModuleNttVO> resultList = nttUnityService.selectNttList(paramVO);
		
		// 목록 총 갯수
		Integer resultCnt = nttUnityService.selectNttListTotCnt(paramVO);
		
		// 말머리 여부
		List<ModuleBbsVO> subospecList = bbsCmmnService.selectBbsSubospecList(paramVO.getBbsSeq());
		Integer subospecListCnt = 0;
		
		if(subospecList != null){
			subospecListCnt = subospecList.size();
		}
		
		paginationInfo.setTotalRecordCount(resultCnt.intValue());
		
		/* 커스텀 기능 조회 */
		ModuleBbsVO funcVO = bbsCustomBassInfoService.selectBbsCustomFunctionDetail(resultVO);
		model.addAttribute("funcVO", funcVO);
		
		/* 커스텀 필드 조회 */
		Map<String, String> fieldVO = new HashMap<String, String>();
		fieldVO.put("siteSeq", CmmSessionUtil.getSessionSiteSeq(request));
		fieldVO.put("bbsSeq", resultVO.getBbsSeq());
		List<ModuleBbsCustomVO> fieldList = bbsCustomBassInfoService.selectBbsBassInfoCustomFieldList(fieldVO);
		model.addAttribute("fieldList", fieldList);
		
		List<String> dimListFields = new ArrayList<String>();
		
		for (ModuleBbsCustomVO bbsCustomVO : fieldList) {
			if(bbsCustomVO.getListAt().equalsIgnoreCase("Y") == false){
				dimListFields.add(bbsCustomVO.getFieldId());
			}
		}
		
		// 목록에 포함되지 않는 필드를 제거해준 리스트
		List<ModuleNttVO> resultList2 = new ArrayList<ModuleNttVO>();
		for(int i=0;i <resultList.size();i++){
			ModuleNttVO moduleNtt = new ModuleNttVO();
			moduleNtt = resultList.get(i);
			String nttCn = moduleNtt.getNttCn();
			ObjectMapper m = new ObjectMapper();
			Map<String, Object> map = new HashMap<String, Object>();
			map = m.readValue(nttCn, new TypeReference<Map<String,Object>>() {} );
			
			for (String filedKey : dimListFields) {
				if(!filedKey.equals("password")){
				map.put(filedKey, "");
				}
			}
			
			String convertNttCn = m.writeValueAsString(map);
			moduleNtt.setNttCn(convertNttCn);
			
			resultList2.add(moduleNtt);
			
		}
		
		model.addAttribute("nttAuthVO", 		nttCmmnService.selectCntntsAuthForNtt(request, paramVO.getMenuSeq()));
		
//		model.addAttribute("resultList", 		resultList);
		model.addAttribute("resultList", 		resultList2);
		model.addAttribute("resultCnt", 		resultCnt);
		model.addAttribute("subospecList", 		subospecList);
		model.addAttribute("subospecListCnt", 	subospecListCnt);
		model.addAttribute("paginationInfo", 	paginationInfo);
			
		
		
		return "wzwg/module/ntt/custom/" + returnPage;
		
	}
		
	/**
	 * ㅁ 통합게시물 - 데이터관리 - 상세보기
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/custom/selectNttDetailAjax.do")
	public String selectNttDetail(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
		
		moduleBbsVO.setBbsSeq(paramVO.getBbsSeq());
		
		// 게시판 기본정보
		moduleBbsVO = bbsCustomBassInfoService.selectBbsBassInfoDetail(moduleBbsVO);
		
		// 커스텀게시판 펑션
		ModuleBbsVO funcVO = bbsCustomBassInfoService.selectBbsCustomFunctionDetail(moduleBbsVO);
		
		model.addAttribute("moduleBbsVO", 			moduleBbsVO);	
		
		// 조회수 증가
		nttCmmnService.modifyNttInqireCnt(paramVO);
				
		ModuleNttVO resultVO = nttCmmnService.selectNttDetail(paramVO);
		
		Map<String, Object> nttCnMap = JacksonMapperUtil.convertJsonToMap(resultVO.getNttCn());
		
		/**
		 * 목록에서 바로 상세뷰로 스크립트를 실행 시킬 경우의 보안 방어 코딩 추가
		 * 2019.03.15 조원권
		 */
		if( (CmmSessionUtil.getSessionBooleanValue(request, "SADMIN_AT") || CmmSessionUtil.getSessionBooleanValue(request, "NADMIN_AT") || CmmSessionUtil.getSessionBooleanValue(request, "CNTNTS_ADMIN_AT")) == false){
			if(funcVO.getNolognAt().equals("Y")){
				//비로그인 게시판을 경우 비밀번호를 확인한다
				String paramPWEnc = SecureAES256.encryptP(secureKey, paramVO.getPassword());
				String bbsPW = String.valueOf(nttCnMap.get("password"));
				
				if(paramPWEnc.equals(bbsPW)){
					//암호화한 비밀번호가 저장된 비밀번호와 같으면 파라미터 비밀번호를 암호화된 비밀번호로 변경해준다
					paramVO.setPassword(paramPWEnc);
				}
				/*
				 * 첫게시물 등록후에는 암호화된 비밀번호가 넘어오므로 파라미터 비밀번호를 바로 비교해서 맞으면 정상적으로 통과 시킨다
				 */
				if(paramVO.getPassword().equals(bbsPW) == false){
					return "wzwg/module/ntt/custom/nttDetailFail"; 
				}
			}
			
		} 
		
		model.addAttribute("nttAuthVO", nttCmmnService.selectCntntsAuthForNtt(request, paramVO.getMenuSeq()));		
		
		if(resultVO != null){
			model.addAttribute("resultVO", resultVO);
			
			ModuleNttTagVO tagVO = new ModuleNttTagVO();
			tagVO.setSiteSeq(paramVO.getSiteSeq());
			tagVO.setNttSeq(paramVO.getNttSeq());
			
			if("I".equals(resultVO.getListScrinCode())) {
				ModuleUploadFileVO FileVO = new ModuleUploadFileVO();
	        	
	        	FileVO.setAtchFileId(resultVO.getAtchFileId());
	        	
	        	List<ModuleUploadFileVO> imageList = fileService.selectFileInfs(FileVO);
	    		model.addAttribute("imageList", imageList);
	    		
	    		return "wzwg/module/ntt/custom/nttImageDetail"; 
			}
			
			List<ModuleNttTagVO> tagList = nttTagService.selectNttTagList(tagVO);
			model.addAttribute("tagList", tagList);
			
			/** 2019.03.07 atchFileList 조회 */
			ModuleUploadFileVO fileVO = new ModuleUploadFileVO();
			fileVO.setAtchFileId(resultVO.getAtchFileId());
	    	List<ModuleUploadFileVO> atchFileList = fileService.selectFileInfs(fileVO);
	    	model.addAttribute("atchFileList", atchFileList);

			
		}else{
			model.addAttribute("resultVO", paramVO);
		}
		
		/* 리플내용을 불러올땐 커스텀정보를 넣지 않는다 */
		String parntsNttSeq = paramVO.getParntsNttSeq();
		if(parntsNttSeq == null || parntsNttSeq.equals("")){
			/* 커스텀 필드 조회 */
			Map<String, String> fieldVO = new HashMap<String, String>();
			fieldVO.put("siteSeq", CmmSessionUtil.getSessionSiteSeq(request));
			if(resultVO != null) {
				fieldVO.put("bbsSeq", resultVO.getBbsSeq());
			}
				List<ModuleBbsCustomVO> fieldList = bbsCustomBassInfoService.selectBbsBassInfoCustomFieldList(fieldVO);
				model.addAttribute("fieldList", fieldList);
			
			//System.out.println("resultVO.getNttCn() :" +resultVO.getNttCn());
			/* 커스텀 데이터 맵으로 변환*/
			if(resultVO != null) {
			Map<String, String> customData = bbsCustomBassInfoService.getCustomContentsToMap(resultVO.getNttCn());
			model.addAttribute("customData",customData);
			}
		}
		
		model.addAttribute("fileEstbsSe", 	EgovProperties.getProperty("Globals.fileEstbs"));
		
		return "wzwg/module/ntt/custom/nttDetail"; 
	}
	
	
	/**
	 * ㅁ 통합게시물 - 데이터관리 - 등록 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/custom/registNttFormAjax.do")
	public String registNttForm(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		
		if(paramVO == null || paramVO.getBbsSeq() == null || paramVO.getBbsSeq().equals("")) {
			model.addAttribute("message", "authCtrl.err01");
            model.addAttribute("retUrl", "/index.do");
            return "wzwg/cmm/errorMsgForward";
		}
		
		/* 커스텀 기능 조회 */
		ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
		moduleBbsVO.setBbsSeq(paramVO.getBbsSeq());
		ModuleBbsVO funcVO = bbsCustomBassInfoService.selectBbsCustomFunctionDetail(moduleBbsVO);
		model.addAttribute("funcVO", funcVO);
		
		CntntsAuthVO nttAuthVO = nttCmmnService.selectCntntsAuthForNtt(request, paramVO.getMenuSeq());
		boolean mngrAt = nttCmmnService.sessionMngrAuthForNtt(request);

		/* 커스텀 게시판 비회원 권한부터 체크함 */
		if(funcVO.getNolognAt().equals("N")) {
			if(!mngrAt && !"W".equals(nttAuthVO.getAuthorSe())){
				model.addAttribute("authorMessage", egovMessageSource.getMessage("wzwg.cmm.msg.MSG084"));
				return "forward:"+wzwgContext + Globals.URL_PREFIX + "/module/ntt/custom/selectNttListAjax.do";
			}
		}
		
		List<CntntsInfoVO> bbsList = bbsCmmnService.selectBbsList(paramVO.getSiteSeq());
    	model.addAttribute("bbsList", bbsList);
    	
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if(loginVO != null){
			paramVO.setUsrSeq(loginVO.getUsrSeq());
		} else {
			paramVO.setUsrSeq("0");
			loginVO = new CmmLoginVO();
			loginVO.setUsrSeq("0");
		}	
		
		String formCn = nttCmmnService.selectNttFormCn(paramVO.getBbsSeq());
		
		if(formCn != null){
			paramVO.setNttCn(formCn);
		}
		
    	// 임시게시물 목록
    	Integer tmprnttListCnt = nttCmmnService.selectTmprnttListTotCnt(paramVO);
    	model.addAttribute("tmprnttListCnt", tmprnttListCnt);
		
    	ModuleNttTagVO tagVO = new ModuleNttTagVO();
		tagVO.setSiteSeq(paramVO.getSiteSeq());
		tagVO.setUsrSeq(loginVO.getUsrSeq());
		
		// 나의 태그 목록
		List<ModuleNttTagVO> myTagList = nttTagService.selectNttUsrTagList(tagVO);
		model.addAttribute("myTagList", myTagList);
		
		
		
		/* 커스텀 필드 조회 */
		Map<String, String> fieldVO = new HashMap<String, String>();
		fieldVO.put("siteSeq", CmmSessionUtil.getSessionSiteSeq(request));
		fieldVO.put("bbsSeq", paramVO.getBbsSeq());
		List<ModuleBbsCustomVO> fieldList = bbsCustomBassInfoService.selectBbsBassInfoCustomFieldList(fieldVO);
		model.addAttribute("fieldList", fieldList);
		
		ModuleUploadFileVO fileVO = new ModuleUploadFileVO();
		fileVO.setSiteSeq(paramVO.getSiteSeq());
		fileVO.setSitecntntsSeq(paramVO.getSitecntntsSeq());
		fileVO.setCntntsSeq(paramVO.getBbsSeq());

		List<ModuleUploadFileVO> fileList = moduleUploadFileMngrService.selectEstbsExtsnList(fileVO);
		
		ModuleBbsVO resultVO = new ModuleBbsVO();
		
		resultVO.setBbsSeq(paramVO.getBbsSeq());
		
		model.addAttribute("fileList", fileList);
		model.addAttribute("resultVO", bbsCustomBassInfoService.selectBbsBassInfoDetail(resultVO));
		model.addAttribute("nttAuthVO", nttAuthVO);	
		model.addAttribute("fileEstbsSe", 	EgovProperties.getProperty("Globals.fileEstbs"));
		model.addAttribute("editorEstbsSe", EgovProperties.getProperty("Globals.editorEstbs"));
		
		return "wzwg/module/ntt/custom/nttRegist"; 
	}
	
	/**
	 * ㅁ 통합게시물 - 데이터관리 - 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/custom/registNttInfoAjax.do")
	public ModelAndView registNttInfo(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, final MultipartHttpServletRequest multiRequest
			, HttpServletRequest request
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		
		//List<ModuleUploadFileVO> resultList = null;
		//String atchFileId = "";
	    
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    /* json 데이터를 만들기 위해서 파일별로 구별하기위해 파라미터 name 별로 atchFileId를 구별한다 */
	    Map<String, String> fileIdMap = new HashMap<String, String>(); 
	    
	    List<ModuleUploadFileVO> resultList = null;
		String atchFileId = "";
	    
	    if (!files.isEmpty()) {

	    	ModuleUploadFileVO fileVO = new ModuleUploadFileVO();
	    	fileVO.setSiteSeq(paramVO.getSiteSeq());
	    	fileVO.setSitecntntsSeq(paramVO.getSitecntntsSeq());
	    	fileVO.setCntntsSeq(paramVO.getBbsSeq());
	    	
	    	String fileExtsnList = "";
			List<ModuleUploadFileVO> fileCodeList = moduleUploadFileMngrService.selectEstbsExtsnList(fileVO);
			
			for(int i=0; i<fileCodeList.size(); i++){
				fileExtsnList += fileCodeList.get(i).getFileEstbsExtsn();
				if(i+1 != fileCodeList.size()){ fileExtsnList += ",";	}
			}
			
	    	resultList = fileUtil.parseFileInf(files, "NTT_", 0, "Globals.fileStorePath", fileExtsnList, multiRequest, "ntt", null, siteSeq);
			atchFileId = fileService.insertFileInfs(resultList);
			for(int i=0;i<resultList.size();i++){
				fileIdMap.put(resultList.get(i).getName(), resultList.get(i).getFileSn());
			}
	    }
	    
	    
	    /*
	    if (!files.isEmpty()) {
	    	//resultList = fileUtil.parseFileInf(files, "NTT_", 0, "", "");
	    	resultList = fileUtil.parseFileInf(files, "NTT_", 0, "Globals.fileStorePath", "Globals.WhiteFileExt", multiRequest, "ntt", null, siteSeq);
			atchFileId = fileService.insertFileInfs(resultList);
	    }
	    */
	    /* 커스텀 기능 조회 */
	    ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
	    moduleBbsVO.setBbsSeq(paramVO.getBbsSeq());
		ModuleBbsVO funcVO = bbsCustomBassInfoService.selectBbsCustomFunctionDetail(moduleBbsVO);
		//model.addAttribute("funcVO", funcVO);
		
		HttpSession session = multiRequest.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");

		if(funcVO != null && funcVO.getNolognAt().equals("Y") && loginVO == null){
			paramVO.setNtcrSeq("0");
			paramVO.setUsrSeq("0");
			paramVO.setNtcrId(egovMessageSource.getMessage("wzwg.cmm.word.noMber"));
			paramVO.setNtcrNm(egovMessageSource.getMessage("wzwg.cmm.word.noMber"));
			
		}else{
			if (loginVO != null) { // Sparrow 대응용 한번 더 체크
				paramVO.setNtcrSeq(loginVO.getUsrSeq());
				paramVO.setUsrSeq(loginVO.getUsrSeq());
				paramVO.setNtcrId(loginVO.getUserId());
				paramVO.setNtcrNm(loginVO.getUserNm());
			}
		}
		paramVO.setNttSeq(nttCmmnService.selectNextNttSeq(paramVO));

		/* 리플내용을 저장할땐 커스텀정보를 넣지 않는다 */
		String parntsNttSeq = paramVO.getParntsNttSeq();
		if(parntsNttSeq == null || parntsNttSeq.equals("")){
			/* 커스텀 데이터 처리를 위해 입련된 값을 모두 JSON으로 합침 */
			String customJson = bbsCustomBassInfoService.getCustomJsonContents(siteSeq, paramVO.getBbsSeq(), paramVO.getNttSeq(),fileIdMap, request);
			
			//System.out.println(customJson);
			paramVO.setNttCn(customJson); // 컨텐츠 내용에 json 데이터를 넣는다
		}
		
		paramVO.setNttSj(CmmXssUtil.unscript(paramVO.getNttSj()));
		paramVO.setNttCn(CmmXssUtil.unscript(paramVO.getNttCn()));
		paramVO.setAtchFileId(atchFileId);
		result = nttCmmnService.registNttInfo(paramVO);	// 저장
		
		if(funcVO != null && funcVO.getUsrScrinTy().equals("W")){
			ModuleBbsVO bbsVO = new ModuleBbsVO();
			bbsVO.setBbsSeq(paramVO.getBbsSeq());
			bbsVO.setSiteSeq(siteSeq);
			ModuleBbsVO  resultVO = bbsCustomBassInfoService.selectBbsBassInfoDetail(bbsVO);
			if(resultVO.getReciveEmail() != null &&  !resultVO.getReciveEmail().equals("")){
			Map<String, String> fieldVO = new HashMap<String, String>();
			fieldVO.put("siteSeq", CmmSessionUtil.getSessionSiteSeq(request));
			fieldVO.put("bbsSeq", paramVO.getBbsSeq());
			List<ModuleBbsCustomVO> fieldList = bbsCustomBassInfoService.selectBbsBassInfoCustomFieldList(fieldVO);
			model.addAttribute("fieldList", fieldList);
			
			//System.out.println("resultVO.getNttCn() :" +resultVO.getNttCn());
			/* 커스텀 데이터 맵으로 변환*/
			Map<String, String> customData = bbsCustomBassInfoService.getCustomContentsToMap(paramVO.getNttCn());
			
			String content="<html><head></head><body><table border='1' style='width:800px'>";
			for(int i=0;i<fieldList.size();i++){
				if(!fieldList.get(i).getFieldTy().equals("password") && !fieldList.get(i).getFieldTy().equals("file") && !fieldList.get(i).getFieldTy().equals("image")){
					if(fieldList.get(i).getFieldTy().equals("tel")){
						content +="<tr><th style='width:30%;background-color:gray;color:white'>"+fieldList.get(i).getFieldNm()+"</th><td>"+ SecureAES256.decryptP(secureKey, customData.get(fieldList.get(i).getFieldId()))+"</td></tr>";
					}else{
						content +="<tr><th style='width:30%;background-color:gray;color:white'>"+fieldList.get(i).getFieldNm()+"</th><td>"+customData.get(fieldList.get(i).getFieldId())+"</td></tr>";
					}
				}
			}
			
				  content +="</table></body></html>";		   
			EgovMailUtil mail = new EgovMailUtil();
			mail.mailSend(resultVO.getReciveEmail(), resultVO.getBbsNm(), content, multiRequest);
			}
		}
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn(paramVO.getNttSeq());
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ 통합게시물 - 데이터관리 - 답글 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/custom/selectNttReplyFormAjax.do")
	public String selectNttReplyForm(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		
		CntntsAuthVO nttAuthVO = nttCmmnService.selectCntntsAuthForNtt(request, paramVO.getMenuSeq());
		boolean mngrAt = nttCmmnService.sessionMngrAuthForNtt(request);

		if(!mngrAt && !"W".equals(nttAuthVO.getAuthorSe())){
			model.addAttribute("authorMessage", egovMessageSource.getMessage("wzwg.cmm.msg.MSG084"));
			return "forward:"+wzwgContext + Globals.URL_PREFIX + "/module/ntt/custom/selectNttListAjax.do";
		}
		
		List<CntntsInfoVO> bbsList = bbsCmmnService.selectBbsList(paramVO.getSiteSeq());
    	model.addAttribute("bbsList", bbsList);
    	
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
    	ModuleNttVO resultVO = nttCmmnService.selectNttDetail(paramVO);
		
		if(resultVO != null){
			if (!mngrAt && (loginVO == null || !Objects.equals(loginVO.getUserId(), resultVO.getNtcrId()))) {
				model.addAttribute("authorMessage", egovMessageSource.getMessage("wzwg.cmm.msg.MSG084"));
				return "forward:"+wzwgContext + Globals.URL_PREFIX + "/module/ntt/custom/selectNttListAjax.do";
			}
			
			ModuleNttTagVO tagVO = new ModuleNttTagVO();
			tagVO.setSiteSeq(paramVO.getSiteSeq());
			tagVO.setNttSeq(paramVO.getNttSeq());
			if(loginVO != null) {
				tagVO.setUsrSeq(loginVO.getUsrSeq());
				paramVO.setUsrSeq(loginVO.getUsrSeq());
			}
			
			// 등록된 태그 목록
			List<ModuleNttTagVO> tagList = nttTagService.selectNttTagList(tagVO);
			
			if(tagList.size() > 0){
				String tagArr = "";
				
				for(int i = 0; i < tagList.size(); i++) {
					tagArr += tagList.get(i).getTagNm() + ",";
				}
				
				resultVO.setTagArr(tagArr.substring(0, tagArr.length() - 1));
			}
			
			model.addAttribute("resultVO", resultVO);			
			
			// 임시게시물 목록
	    	Integer tmprnttListCnt = nttCmmnService.selectTmprnttListTotCnt(paramVO);
	    	model.addAttribute("tmprnttListCnt", tmprnttListCnt);
	    	
			// 나의 태그 목록
			List<ModuleNttTagVO> myTagList = nttTagService.selectNttUsrTagList(tagVO);
			model.addAttribute("myTagList", myTagList);
			
		}else{
			model.addAttribute("resultVO", paramVO);
		}
		
		model.addAttribute("nttAuthVO", nttAuthVO);
		model.addAttribute("fileEstbsSe", 	EgovProperties.getProperty("Globals.fileEstbs"));
		model.addAttribute("editorEstbsSe", EgovProperties.getProperty("Globals.editorEstbs"));
		
		return "wzwg/module/ntt/custom/nttReply"; 
	}
	
	/**
	 * ㅁ 통합게시물 - 데이터관리 - 수정 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/custom/modifyNttFormAjax.do")
	public String modifyNttForm(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{

		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		if(paramVO == null || paramVO.getBbsSeq() == null || paramVO.getBbsSeq().equals("")) {
			model.addAttribute("message", "authCtrl.err01");
            model.addAttribute("retUrl", "/index.do");
            return "wzwg/cmm/errorMsgForward";
		}
		
		CntntsAuthVO nttAuthVO = nttCmmnService.selectCntntsAuthForNtt(request, paramVO.getMenuSeq());
		boolean mngrAt = nttCmmnService.sessionMngrAuthForNtt(request);
		
		/* 커스텀 기능 조회 */
		ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
		moduleBbsVO.setBbsSeq(paramVO.getBbsSeq());
		ModuleBbsVO funcVO = bbsCustomBassInfoService.selectBbsCustomFunctionDetail(moduleBbsVO);
		model.addAttribute("funcVO", funcVO);
		
		if(!mngrAt && !"W".equals(nttAuthVO.getAuthorSe()) && !funcVO.getNolognAt().equals("Y")){
			model.addAttribute("authorMessage", egovMessageSource.getMessage("wzwg.cmm.msg.MSG084"));
			return "forward:"+ wzwgContext + Globals.URL_PREFIX + "/module/ntt/custom/selectNttListAjax.do";
		}
		
		List<CntntsInfoVO> bbsList = bbsCmmnService.selectBbsList(paramVO.getSiteSeq());
    	model.addAttribute("bbsList", bbsList);
    	
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
    	ModuleNttVO resultVO = nttCmmnService.selectNttDetail(paramVO);
    	
    	
    	
		if(resultVO != null) {
			
				if(loginVO != null) {
					if(!mngrAt && !loginVO.getUserId().equals(resultVO.getNtcrId())){
						model.addAttribute("authorMessage", egovMessageSource.getMessage("wzwg.cmm.msg.MSG084"));
						return "forward:"+wzwgContext + Globals.URL_PREFIX + "/module/ntt/custom/selectNttListAjax.do";
					}
				}else {
					if(!resultVO.getNtcrId().equals("비회원")) {
						model.addAttribute("authorMessage", egovMessageSource.getMessage("wzwg.cmm.msg.MSG084"));
						return "forward:"+wzwgContext + Globals.URL_PREFIX + "/module/ntt/custom/selectNttListAjax.do";
					}
				}
			
			
			/*
			ModuleNttTagVO tagVO = new ModuleNttTagVO();
			tagVO.setSiteSeq(paramVO.getSiteSeq());
			tagVO.setNttSeq(paramVO.getNttSeq());
			tagVO.setUsrSeq(loginVO.getUsrSeq());
			
			// 등록된 태그 목록
			List<ModuleNttTagVO> tagList = nttTagService.selectNttTagList(tagVO);
			
			if(tagList.size() > 0){
				String tagArr = "";
				
				for(int i = 0; i < tagList.size(); i++) {
					tagArr += tagList.get(i).getTagNm() + ",";
				}
				
				resultVO.setTagArr(tagArr.substring(0, tagArr.length() - 1));
			}
			*/
				
			/** 2019.03.07 atchFileList 조회 */
			ModuleUploadFileVO fileVO = new ModuleUploadFileVO();
			fileVO.setAtchFileId(resultVO.getAtchFileId());
	    	List<ModuleUploadFileVO> atchFileList = fileService.selectFileInfs(fileVO);
	    	model.addAttribute("atchFileList", atchFileList);

			model.addAttribute("resultVO", resultVO);			
			
			
			/*
			paramVO.setUsrSeq(loginVO.getUsrSeq());
			
			// 임시게시물 목록
	    	Integer tmprnttListCnt = nttCmmnService.selectTmprnttListTotCnt(paramVO);
	    	model.addAttribute("tmprnttListCnt", tmprnttListCnt);
	    	
			// 나의 태그 목록
			List<ModuleNttTagVO> myTagList = nttTagService.selectNttUsrTagList(tagVO);
			model.addAttribute("myTagList", myTagList);
			*/
			
			
	    	/* 리플내용을 불러올땐 커스텀정보를 넣지 않는다 */
			String parntsNttSeq = paramVO.getParntsNttSeq();
			if(parntsNttSeq == null || parntsNttSeq.equals("")){
				/* 커스텀 필드 조회 */
				Map<String, String> fieldVO = new HashMap<String, String>();
				fieldVO.put("siteSeq", CmmSessionUtil.getSessionSiteSeq(request));
				fieldVO.put("bbsSeq", resultVO.getBbsSeq());
				List<ModuleBbsCustomVO> fieldList = bbsCustomBassInfoService.selectBbsBassInfoCustomFieldList(fieldVO);
				model.addAttribute("fieldList", fieldList);
				/* 커스텀 데이터 맵으로 변환*/
				Map<String, String> customData = bbsCustomBassInfoService.getCustomContentsToMap(resultVO.getNttCn());
				model.addAttribute("customData",customData);
			}
			
		}else{
			model.addAttribute("resultVO", paramVO);
		}
		
		ModuleUploadFileVO fileVO = new ModuleUploadFileVO();
		fileVO.setSiteSeq(paramVO.getSiteSeq());
		fileVO.setSitecntntsSeq(paramVO.getSitecntntsSeq());
		fileVO.setCntntsSeq(paramVO.getBbsSeq());

		List<ModuleUploadFileVO> fileList = moduleUploadFileMngrService.selectEstbsExtsnList(fileVO);
		
		model.addAttribute("fileList", fileList);
		model.addAttribute("nttAuthVO", nttAuthVO);
		model.addAttribute("fileEstbsSe", 	EgovProperties.getProperty("Globals.fileEstbs"));
		model.addAttribute("editorEstbsSe", EgovProperties.getProperty("Globals.editorEstbs"));
		
		return "wzwg/module/ntt/custom/nttModify"; 
	}
	
	/**
	 * ㅁ 통합게시물 - 데이터관리 - 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/custom/modifyNttInfoAjax.do")
	public ModelAndView modifyNttInfo(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, final MultipartHttpServletRequest multiRequest
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		
		/* 권한체크 */
		
		boolean chkPostOener = nttCmmnService.checkOwnerPost(request, paramVO);
		
		if(chkPostOener == false) {
			return CmmAjaxUtil.getAjaxReturn("authFail");
		}
		
		
		
		int result = 0;
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);

		String atchFileId = StringUtils.defaultString(paramVO.getAtchFileId());
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		Map<String, String> fileIdMap = new HashMap<String, String>();
		
	    if (!files.isEmpty()) {
			if ("".equals(atchFileId)) {
			    //List<ModuleUploadFileVO> file_result = fileUtil.parseFileInf(files, "NTT_", 0, atchFileId, "");
		    	
				ModuleUploadFileVO fileVO = new ModuleUploadFileVO();
		    	fileVO.setSiteSeq(paramVO.getSiteSeq());
		    	fileVO.setSitecntntsSeq(paramVO.getSitecntntsSeq());
		    	fileVO.setCntntsSeq(paramVO.getBbsSeq());
		    	
		    	String fileExtsnList = "";
				List<ModuleUploadFileVO> fileCodeList = moduleUploadFileMngrService.selectEstbsExtsnList(fileVO);
				
				for(int i=0; i<fileCodeList.size(); i++){
					fileExtsnList += fileCodeList.get(i).getFileEstbsExtsn();
					if(i+1 != fileCodeList.size()){ fileExtsnList += ",";	}
				}
				
			    List<ModuleUploadFileVO> file_result = fileUtil.parseFileInf(files, "NTT_", 0, "Globals.fileStorePath", fileExtsnList, multiRequest, "ntt", atchFileId, siteSeq);
			    atchFileId = fileService.insertFileInfs(file_result);
			    paramVO.setAtchFileId(atchFileId);
			    
			    for(int i=0; i<file_result.size(); i++){
			    	fileIdMap.put(file_result.get(i).getName(), file_result.get(i).getFileSn());
			    }
			} else {
				ModuleUploadFileVO fvo = new ModuleUploadFileVO();
			    fvo.setAtchFileId(atchFileId);
			    int cnt = fileService.getMaxFileSN(fvo);
			    
		    	ModuleUploadFileVO fileVO = new ModuleUploadFileVO();
		    	fileVO.setSiteSeq(paramVO.getSiteSeq());
		    	fileVO.setSitecntntsSeq(paramVO.getSitecntntsSeq());
		    	fileVO.setCntntsSeq(paramVO.getBbsSeq());
		    	
		    	String fileExtsnList = "";
				List<ModuleUploadFileVO> fileCodeList = moduleUploadFileMngrService.selectEstbsExtsnList(fileVO);
				
				for(int i=0; i<fileCodeList.size(); i++){
					fileExtsnList += fileCodeList.get(i).getFileEstbsExtsn();
					if(i+1 != fileCodeList.size()){ fileExtsnList += ",";	}
				}
				
			    //List<ModuleUploadFileVO> _result = fileUtil.parseFileInf(files, "NTT_", cnt, atchFileId, "");
			    List<ModuleUploadFileVO> _result = fileUtil.parseFileInf(files, "NTT_", cnt, "Globals.fileStorePath", fileExtsnList, multiRequest, "ntt", atchFileId, siteSeq);
			    fileService.updateFileInfs(_result);
			    
			    for(int i=0; i<_result.size(); i++){
			    	fileIdMap.put(_result.get(i).getName(), _result.get(i).getFileSn());
			    }
			}
	    }
	    
		HttpSession session = multiRequest.getSession();
		
		/* 커스텀 기능 조회 */
	    ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
	    moduleBbsVO.setBbsSeq(paramVO.getBbsSeq());
		ModuleBbsVO funcVO = bbsCustomBassInfoService.selectBbsCustomFunctionDetail(moduleBbsVO);
		
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if(funcVO != null && funcVO.getNolognAt().equals("Y") && loginVO == null){
			
			paramVO.setNtcrId("비회원");
			paramVO.setNtcrNm("비회원");
			paramVO.setUsrSeq("0");
			//paramVO.setNttSeq(nttCmmnService.selectNextNttSeq(paramVO));
			paramVO.setLastUpdusrId("비회원");
			
		} else if (loginVO != null) {
				paramVO.setNtcrId(loginVO.getUserId());
				paramVO.setNtcrNm(loginVO.getUserNm());
				paramVO.setUsrSeq(loginVO.getUsrSeq());
				//paramVO.setNttSeq(nttCmmnService.selectNextNttSeq(paramVO));
				paramVO.setLastUpdusrId(loginVO.getUserId());
				//paramVO.setAtchFileId(atchFileId);
		}

		//paramVO.setUsrSeq(loginVO.getUsrSeq());
		//paramVO.setLastUpdusrId(loginVO.getUserId());
		
		/* 리플내용을 저장할땐 커스텀정보를 넣지 않는다 */
		String parntsNttSeq = paramVO.getParntsNttSeq();
		if(parntsNttSeq == null || parntsNttSeq.equals("")){
			/* 커스텀 데이터 처리를 위해 입련된 값을 모두 JSON으로 합침 */
			String customJson = bbsCustomBassInfoService.getCustomJsonContents(siteSeq, paramVO.getBbsSeq(), paramVO.getNttSeq(), fileIdMap, request);
			
			//System.out.println(customJson);
			paramVO.setNttCn(customJson); // 컨텐츠 내용에 json 데이터를 넣는다
		}
		
		paramVO.setNttSj(CmmXssUtil.unscript(paramVO.getNttSj()));
		paramVO.setNttCn(CmmXssUtil.unscript(paramVO.getNttCn()));
		
		result = nttCmmnService.modifyNttInfo(paramVO);	// 수정
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ 통합게시물 - 데이터관리 - 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/custom/deleteNttInfoAjax.do")
	public ModelAndView deleteNttInfo(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO == null) {
	        return CmmAjaxUtil.getAjaxReturn("authFail");
	    }
		
		paramVO.setLastUpdusrId(loginVO.getUserId());
		
		if(paramVO.getCheckNttSeq() == null){
			/* 권한체크 */
			
			boolean chkPostOener = nttCmmnService.checkOwnerPost(request, paramVO);
			
			if(chkPostOener == false) {
				return CmmAjaxUtil.getAjaxReturn("authFail");
			}
			
			result = nttCmmnService.deleteNttInfo(paramVO);			// 삭제
		}else{
			result = nttCmmnService.deleteCheckNttInfo(paramVO);	// 체크박스 목록 삭제
		}
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ 휴지통 - 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/custom/selectNttRecycleListAjax.do")
	public String selectNttRecycleList(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");

		if(loginVO != null){
			paramVO.setUsrSeq(loginVO.getUsrSeq());
		} else {
			paramVO.setUsrSeq("0");
		}		
		
		List<CntntsInfoVO> bbsList = bbsCmmnService.selectBbsList(paramVO.getSiteSeq());
    	
    	if(paramVO.getBbsSeq() == null && bbsList.size() > 0){
    		paramVO.setBbsSeq(bbsList.get(0).getCntntsSeq());
    	}
    	
    	model.addAttribute("bbsList", bbsList);
    	
		paramVO.setPageUnit(propertyService.getInt("pageUnit"));
		paramVO.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
		paginationInfo.setPageSize(paramVO.getPageSize());

		paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
		paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		ModuleBbsVO resultVO = new ModuleBbsVO();
		
		resultVO.setBbsSeq(paramVO.getBbsSeq());
		
		// 게시판 기본정보
		resultVO = bbsCustomBassInfoService.selectBbsBassInfoDetail(resultVO);
		
		model.addAttribute("resultVO", 			resultVO);
		
		String returnPage = "";
		
		if(resultVO != null){
			
			if("B".equals(resultVO.getListScrinCode())){	returnPage = "nttRecycleList";		}	// 블로그형
			if("W".equals(resultVO.getListScrinCode())){	returnPage = "nttRecycleList";	}	// 웹진형
			if("I".equals(resultVO.getListScrinCode())){	returnPage = "nttImageRecycleList";	}	// 이미지형
			if("L".equals(resultVO.getListScrinCode())){	returnPage = "nttRecycleList";			}	// 목록형
			
			paramVO.setListScrinCode(resultVO.getListScrinCode());
			
		}else{
			returnPage = "nttRecycleList";
		}

		// 목록
		List<ModuleNttVO> resultList = nttUnityService.selectNttRecycleList(paramVO);
		
		// 목록 총 갯수
		Integer resultCnt = nttUnityService.selectNttRecycleListTotCnt(paramVO);
		
		// 말머리 여부
		List<ModuleBbsVO> subospecList = bbsCmmnService.selectBbsSubospecList(paramVO.getBbsSeq());
		Integer subospecListCnt = 0;
		
		if(subospecList != null){
			subospecListCnt = subospecList.size();
		}
		
		paginationInfo.setTotalRecordCount(resultCnt.intValue());
		
		model.addAttribute("nttAuthVO", 		nttCmmnService.selectCntntsAuthForNtt(request, paramVO.getMenuSeq()));
		
		model.addAttribute("resultList", 		resultList);
		model.addAttribute("resultCnt", 		resultCnt);
		model.addAttribute("subospecList", 		subospecList);
		model.addAttribute("subospecListCnt", 	subospecListCnt);
		model.addAttribute("paginationInfo", 	paginationInfo);
			
		return "wzwg/module/ntt/custom/" + returnPage;
		
	}	

	/**
	 * ㅁ 휴지통 - 복원
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/custom/modifyNttRecycleAjax.do")
	public ModelAndView modifyNttRecycle(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO == null) {
	        return CmmAjaxUtil.getAjaxReturn("authFail");
	    }
		
		paramVO.setLastUpdusrId(loginVO.getUserId());
		
		if(paramVO.getCheckNttSeq() == null){
			result = nttCmmnService.modifyNttRecycle(paramVO);			// 복원
		}else{
			result = nttCmmnService.modifyCheckNttRecycle(paramVO);	// 체크박스 목록 복원
		}
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ 커스텀 게시판 필드 암호화 호출
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/custom/selectEncryptFieldAjax.do")
	public String selectEncryptFieldAjax(String name, HttpServletRequest request , Model model) throws Exception{
		
		String []srcs = request.getParameterValues(name);
		List<String> dataList = new ArrayList<String>();
		
		if (srcs != null) {
			for (String src : srcs) {
				String data = SecureAES256.encryptP(secureKey, src);
				dataList.add(data);
			}
		}
		
		Map<String, Object> ajaxResponse = new HashMap<String, Object>();
		ajaxResponse.put("result", "success");
		ajaxResponse.put("dataList", dataList);
		model.addAttribute("ajaxResponse", ajaxResponse);
		return "wzwg/webModule/json";
	}
	
	/**
	 * ㅁ 커스텀 게시판 필드 암호화 호출
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/custom/selectDecryptFieldAjax.do")
	public String selectDecryptFieldAjax(String name, HttpServletRequest request , Model model) throws Exception{
		
		String []srcs = request.getParameterValues(name);
		List<String> dataList = new ArrayList<String>();

		if (srcs != null) {
			for (String src : srcs) {
				String data = SecureAES256.decryptP(secureKey, src);
				dataList.add(data);
			}
		}
		
		Map<String, Object> ajaxResponse = new HashMap<String, Object>();
		ajaxResponse.put("result", "success");
		ajaxResponse.put("dataList", dataList);
		model.addAttribute("ajaxResponse", ajaxResponse);
		return "wzwg/webModule/json";
	}
	
	
	/** 2019.02.27 - 신규개발(hskim) start */

	/**
	 * ㅁ 휴지통 - 선택삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/custom/deleteCustomNttAjax.do")
	public ModelAndView deleteCustomNttAjax(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if(loginVO == null){
			paramVO.setBbsSeq("0");
		}		
		
		paramVO.setDelSe("");
		result = nttCmmnService.deleteSiteNtt(paramVO);

		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}	
	
	/**
	 * ㅁ 휴지통 - 전체삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/custom/deleteCustomNttAllAjax.do")
	public ModelAndView deleteCustomNttAllAjax(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if(loginVO == null){
			paramVO.setBbsSeq("0");
		}		
		
		paramVO.setDelSe("ALL");
		result = nttCmmnService.deleteSiteNtt(paramVO);

		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}	
	
	/** 2019.02.27 - 신규개발(hskim) End */

}
