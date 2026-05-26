package egovframework.wzwg.module.ntt.faq.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.cmm.util.CmmXssUtil;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsCmmnService;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;
import egovframework.wzwg.module.bbs.faq.service.ModuleBbsFaqBassInfoService;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttCmmnService;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;
import egovframework.wzwg.module.ntt.faq.service.ModuleNttFaqDataManageService;
import egovframework.wzwg.module.ntt.module.tag.service.ModuleNttTagService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.module.upload.fileMngr.service.ModuleUploadFileMngrService;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthService;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;

@Controller
public class ModuleNttFaqDataManageController {


    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

    /** ModuleNttService */
    @Resource(name="ModuleNttCmmnService")
    protected ModuleNttCmmnService nttCmmnService;
    
    /** ModuleNttService */
    @Resource(name="ModuleNttFaqDataManageService")
    protected ModuleNttFaqDataManageService nttFaqService;
    
    /** ModuleBbsCmmnService */
    @Resource(name="ModuleBbsCmmnService")
    protected ModuleBbsCmmnService bbsCmmnService;
    
    /** ModuleBbsFaqBassInfoService */
    @Resource(name="ModuleBbsFaqBassInfoService")
    protected ModuleBbsFaqBassInfoService bbsFaqBassInfoService;
    
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

	/**
	 * ㅁ FAQ게시물 - 데이터관리 - 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/faq/selectNttListAjax.do")
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
		resultVO = bbsFaqBassInfoService.selectBbsBassInfoDetail(resultVO);

		paramVO.setPageUnit(propertyService.getInt("pageUnit"));
		paramVO.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
		paginationInfo.setPageSize(paramVO.getPageSize());

		paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
		paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		// 목록
		List<ModuleNttVO> resultList = nttFaqService.selectNttList(paramVO);
		
		// 목록 총 갯수
		Integer resultCnt = nttFaqService.selectNttListTotCnt(paramVO);
		
		// 말머리 여부
		List<ModuleBbsVO> subospecList = bbsCmmnService.selectBbsSubospecList(paramVO.getBbsSeq());
		Integer subospecListCnt = 0;
		
		if(subospecList != null){
			subospecListCnt = subospecList.size();
		}
		
		paginationInfo.setTotalRecordCount(resultCnt.intValue());
		
		/* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
		model.addAttribute("resultVO",			resultVO);
		model.addAttribute("resultList", 		resultList);
		model.addAttribute("resultCnt", 		resultCnt);
		model.addAttribute("subospecList", 		subospecList);
		model.addAttribute("subospecListCnt", 	subospecListCnt);
		model.addAttribute("paginationInfo", 	paginationInfo);
		model.addAttribute("fileEstbsSe", 		EgovProperties.getProperty("Globals.fileEstbs"));
			
		return "wzwg/module/ntt/faq/nttList";
		
	}
		
	/**
	 * ㅁ FAQ게시물 - 데이터관리 - 상세보기
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/faq/selectNttDetailAjax.do")
	public String selectNttDetail(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
		
		moduleBbsVO.setBbsSeq(paramVO.getBbsSeq());
		
		// 게시판 기본정보
		moduleBbsVO = bbsFaqBassInfoService.selectBbsBassInfoDetail(moduleBbsVO);
		
		model.addAttribute("moduleBbsVO", 			moduleBbsVO);	
		
		// 조회수 증가
		nttCmmnService.modifyNttInqireCnt(paramVO);
				
		ModuleNttVO resultVO = nttCmmnService.selectNttDetail(paramVO);
		
		if(resultVO != null){
			model.addAttribute("resultVO", resultVO);
		}else{
			model.addAttribute("resultVO", paramVO);
		}
		
		model.addAttribute("fileEstbsSe", EgovProperties.getProperty("Globals.fileEstbs"));
		
		return "wzwg/module/ntt/faq/nttDetail"; 
	}
	
	/**
	 * ㅁ FAQ게시물 - 데이터관리 - 등록 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/faq/registNttFormAjax.do")
	public String registNttForm(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		if(paramVO == null || paramVO.getBbsSeq() == null || paramVO.getBbsSeq().equals("")) {
			model.addAttribute("message", "authCtrl.err01");
            model.addAttribute("retUrl", "/index.do");
            return "wzwg/cmm/errorMsgForward";
		}
		
		List<CntntsInfoVO> bbsList = bbsCmmnService.selectBbsList(paramVO.getSiteSeq());
    	model.addAttribute("bbsList", bbsList);
    	
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setUsrSeq(loginVO.getUsrSeq());
		}
		
		String formCn = nttCmmnService.selectNttFormCn(paramVO.getBbsSeq());
		
		if(formCn != null){
			paramVO.setNttCn(formCn);
		}

		model.addAttribute("fileEstbsSe", EgovProperties.getProperty("Globals.fileEstbs"));
		model.addAttribute("editorEstbsSe", EgovProperties.getProperty("Globals.editorEstbs"));
		
		return "wzwg/module/ntt/faq/nttRegist"; 
	}
	
	/**
	 * ㅁ FAQ게시물 - 데이터관리 - 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/faq/registNttInfoAjax.do")
	public ModelAndView registNttInfo(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		
		List<ModuleUploadFileVO> resultList = new ArrayList<ModuleUploadFileVO>();
		String atchFileId = "";
	    
		if("Y".equals(paramVO.getAtchFilePosblAt())){
			
			String fileEstbsSe = EgovProperties.getProperty("Globals.fileEstbs");
					
			if("B".equals(fileEstbsSe)){
				
				MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
				final Map<String, MultipartFile> files = multiRequest.getFileMap();
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
			    }
			}
			
			if("C".equals(fileEstbsSe) && paramVO.getUploadedFilesInfo() != null && paramVO.getUploadedFilesInfo().length() > 0){
		    	resultList = fileUtil.parseFileInfJson(paramVO.getUploadedFilesInfo(), null, 0);
		    	atchFileId = fileService.insertFileInfs(resultList);
			}
		}
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setNtcrSeq(loginVO.getUsrSeq());
			paramVO.setNtcrId(loginVO.getUserId());
			paramVO.setNtcrNm(loginVO.getUserNm());
			paramVO.setUsrSeq(loginVO.getUsrSeq());
		}
		paramVO.setNttSeq(nttCmmnService.selectNextNttSeq(paramVO));
		paramVO.setAtchFileId(atchFileId);
		paramVO.setNttSj(CmmXssUtil.unscript(paramVO.getNttSj()));
		paramVO.setNttCn(CmmXssUtil.unscript(paramVO.getNttCn()));
		
		result = nttCmmnService.registNttInfo(paramVO);	// 저장
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn(paramVO.getNttSeq());
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ FAQ게시물 - 데이터관리 - 수정 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/faq/modifyNttFormAjax.do")
	public String modifyNttForm(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		if(paramVO == null || paramVO.getBbsSeq() == null || paramVO.getBbsSeq().equals("")) {
			model.addAttribute("message", "authCtrl.err01");
            model.addAttribute("retUrl", "/index.do");
            return "wzwg/cmm/errorMsgForward";
		}
		
		List<CntntsInfoVO> bbsList = bbsCmmnService.selectBbsList(paramVO.getSiteSeq());
    	model.addAttribute("bbsList", bbsList);
    	
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
    	ModuleNttVO resultVO = nttCmmnService.selectNttDetail(paramVO);
		
		if(resultVO != null){
			model.addAttribute("resultVO", resultVO);			
			
			if (loginVO != null) {
				paramVO.setUsrSeq(loginVO.getUsrSeq());
			}
		}else{
			model.addAttribute("resultVO", paramVO);
		}
		
		model.addAttribute("fileEstbsSe", EgovProperties.getProperty("Globals.fileEstbs"));
		model.addAttribute("editorEstbsSe", EgovProperties.getProperty("Globals.editorEstbs"));
		
		return "wzwg/module/ntt/faq/nttModify"; 
	}
	
	/**
	 * ㅁ FAQ게시물 - 데이터관리 - 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/faq/modifyNttInfoAjax.do")
	public ModelAndView modifyNttInfo(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		
		String atchFileId = StringUtils.defaultString(paramVO.getAtchFileId());
		
		if("Y".equals(paramVO.getAtchFilePosblAt())){
			
			String fileEstbsSe = EgovProperties.getProperty("Globals.fileEstbs");
			
			if("B".equals(fileEstbsSe)){
				
				MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
				final Map<String, MultipartFile> files = multiRequest.getFileMap();
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
					}
			    }
			}
			
			if("C".equals(fileEstbsSe) && paramVO.getUploadedFilesInfo() != null && paramVO.getUploadedFilesInfo().length() > 0){
				
				if ("".equals(atchFileId)) {
					List<ModuleUploadFileVO> file_result = fileUtil.parseFileInfJson(paramVO.getUploadedFilesInfo(), atchFileId, 0);
			    	atchFileId = fileService.insertFileInfs(file_result);
			    	paramVO.setAtchFileId(atchFileId);
				}else{
					ModuleUploadFileVO fvo = new ModuleUploadFileVO();
				    fvo.setAtchFileId(atchFileId);
				    int cnt = fileService.getMaxFileSN(fvo);
				    
				    fileUtil.parseDeleteFileInfJson(paramVO.getModifiedFilesInfo());
				    
					List<ModuleUploadFileVO> _result = fileUtil.parseFileInfJson(paramVO.getUploadedFilesInfo(), atchFileId, cnt);
			    	fileService.updateFileInfs(_result);
				}
				
			}
		}
	    
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setUsrSeq(loginVO.getUsrSeq());
			paramVO.setLastUpdusrId(loginVO.getUserId());
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
	 * ㅁ FAQ게시물 - 데이터관리 - 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/faq/deleteNttInfoAjax.do")
	public ModelAndView deleteNttInfo(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		if(paramVO.getCheckNttSeq() == null){
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
	@RequestMapping(value="/**/module/ntt/faq/selectNttRecycleListAjax.do")
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
		resultVO = bbsFaqBassInfoService.selectBbsBassInfoDetail(resultVO);
		
		model.addAttribute("resultVO", 			resultVO);

		// 목록
		List<ModuleNttVO> resultList = nttFaqService.selectNttRecycleList(paramVO);
		
		// 목록 총 갯수
		Integer resultCnt = nttFaqService.selectNttRecycleListTotCnt(paramVO);
		
		// 말머리 여부
		List<ModuleBbsVO> subospecList = bbsCmmnService.selectBbsSubospecList(paramVO.getBbsSeq());
		Integer subospecListCnt = 0;
		
		if(subospecList != null){
			subospecListCnt = subospecList.size();
		}
		
		paginationInfo.setTotalRecordCount(resultCnt.intValue());
		
		model.addAttribute("resultList", 		resultList);
		model.addAttribute("resultCnt", 		resultCnt);
		model.addAttribute("subospecList", 		subospecList);
		model.addAttribute("subospecListCnt", 	subospecListCnt);
		model.addAttribute("paginationInfo", 	paginationInfo);
			
		return "wzwg/module/ntt/faq/nttRecycleList";
		
	}	

	/**
	 * ㅁ 휴지통 - 복원
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/faq/modifyNttRecycleAjax.do")
	public ModelAndView modifyNttRecycle(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
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
	 * ㅁ 휴지통 - 선택삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/faq/deleteNttAjax.do")
	public ModelAndView deleteNtt(
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
	@RequestMapping(value="/**/module/ntt/faq/deleteNttAllAjax.do")
	public ModelAndView deleteNttAll(
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
	
}
