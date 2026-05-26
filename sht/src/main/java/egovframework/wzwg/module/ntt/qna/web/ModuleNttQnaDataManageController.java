package egovframework.wzwg.module.ntt.qna.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.Globals;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.cmm.util.CmmXssUtil;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsCmmnService;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;
import egovframework.wzwg.module.bbs.qna.service.ModuleBbsQnaBassInfoService;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttCmmnService;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;
import egovframework.wzwg.module.ntt.module.tag.service.ModuleNttTagService;
import egovframework.wzwg.module.ntt.module.tag.service.ModuleNttTagVO;
import egovframework.wzwg.module.ntt.qna.service.ModuleNttQnaDataManageService;
import egovframework.wzwg.module.ntt.qna.service.ModuleNttQnaReplyService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.module.upload.fileMngr.service.ModuleUploadFileMngrService;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthService;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ModuleNttQnaDataManageController {

    /** EgovPropertyService */
    @Resource(name="propertiesService")	
    protected EgovPropertyService propertyService;

    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    /** ModuleNttService */
    @Resource(name="ModuleNttCmmnService")
    protected ModuleNttCmmnService nttCmmnService;
    
    /** ModuleNttQnaDataManageService */
    @Resource(name="ModuleNttQnaDataManageService")
    protected ModuleNttQnaDataManageService nttQnaService;
    
    /** ModuleNttQnaReplyService */
    @Resource(name="ModuleNttQnaReplyService")
    protected ModuleNttQnaReplyService nttQnaReplyService;
    
    /** ModuleBbsCmmnService */
    @Resource(name="ModuleBbsCmmnService")
    protected ModuleBbsCmmnService bbsCmmnService;;
    
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
    
    /** ModuleBbsQnaBassInfoService */
    @Resource(name="ModuleBbsQnaBassInfoService")
    protected ModuleBbsQnaBassInfoService bbsQnaBassInfoService;    

    @Resource(name="ModuleUploadFileMngrService")
	private ModuleUploadFileMngrService moduleUploadFileMngrService;

	/**
	 * ㅁ 질의응답게시판 - 데이터관리 - 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/qna/selectNttListAjax.do")
	public String selectNttList(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		List<CntntsInfoVO> bbsList = bbsCmmnService.selectBbsList(paramVO.getSiteSeq());
    	
    	if(paramVO.getBbsSeq() == null && bbsList.size() > 0){
    		paramVO.setBbsSeq(bbsList.get(0).getCntntsSeq());
    	}
    	
    	model.addAttribute("bbsList", bbsList);
    	
    	ModuleBbsVO resultVO = new ModuleBbsVO();
		
		resultVO.setBbsSeq(paramVO.getBbsSeq());
		
		// 게시판 기본정보
		resultVO = bbsQnaBassInfoService.selectBbsBassInfoDetail(resultVO);

		model.addAttribute("resultVO", 			resultVO);		
		
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
		
		paramVO.setFaqTabAt("N");
		
		// 목록
		List<ModuleNttVO> resultList = nttQnaService.selectNttList(paramVO);
		
		// 목록 총 갯수
		Integer resultCnt = nttQnaService.selectNttListTotCnt(paramVO);
		
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
		model.addAttribute("nttAuthVO", nttCmmnService.selectCntntsAuthForNtt(request, paramVO.getMenuSeq()));		
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", resultCnt);
		model.addAttribute("subospecList", subospecList);
		model.addAttribute("subospecListCnt", subospecListCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "wzwg/module/ntt/qna/nttList"; 
	}
	
	/**
	 * ㅁ 질의응답게시판 - 데이터관리 - 자주묻는질문목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/qna/selectNttFaqListAjax.do")
	public String selectNttFaqList(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		List<CntntsInfoVO> bbsList = bbsCmmnService.selectBbsList(paramVO.getSiteSeq());
    	
    	if(paramVO.getBbsSeq() == null && bbsList.size() > 0){
    		paramVO.setBbsSeq(bbsList.get(0).getCntntsSeq());
    	}
    	
    	model.addAttribute("bbsList", bbsList);
    	
    	ModuleBbsVO resultVO = new ModuleBbsVO();
    	
    	resultVO.setBbsSeq(paramVO.getBbsSeq());
    	
    	// 게시판 기본정보
    	resultVO = bbsQnaBassInfoService.selectBbsBassInfoDetail(resultVO);
    	
    	model.addAttribute("resultVO", 			resultVO);
    	
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
		
		paramVO.setFaqTabAt("Y");
		
		// 목록
		List<ModuleNttVO> resultList = nttQnaService.selectNttList(paramVO);
		
		// 목록 총 갯수
		Integer resultCnt = nttQnaService.selectNttListTotCnt(paramVO);
		
		paginationInfo.setTotalRecordCount(resultCnt.intValue());
		
		/* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
		model.addAttribute("nttAuthVO", nttCmmnService.selectCntntsAuthForNtt(request, paramVO.getMenuSeq()));			
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", resultCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "wzwg/module/ntt/qna/nttFaqList"; 
	}
	
	/**
	 * ㅁ 질의응답게시판 - 데이터관리 - 상단걸기 등록 / 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/qna/modifyNttNoticeAjax.do")
	public ModelAndView modifyNttNotice(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if(loginVO != null){
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		result = nttQnaService.modifyNttNotice(paramVO);	// 상단걸기 등록/삭제
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
		
	}
	
	/**
	 * ㅁ 질의응답게시판 - 데이터관리 - 자주묻는질문 등록/제외
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/qna/modifyNttFaqAjax.do")
	public ModelAndView modifyNttFaq(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if(loginVO != null){
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}

		result = nttQnaService.modifyNttFaq(paramVO);	// 자주묻는질문 등록/제외
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}

	/**
	 * ㅁ 질의응답게시판 - 데이터관리 - 상세보기
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/qna/selectNttDetailAjax.do")
	public String selectNttDetail(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
		
		moduleBbsVO.setBbsSeq(paramVO.getBbsSeq());
		
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		
		// 게시판 기본정보
		moduleBbsVO = bbsQnaBassInfoService.selectBbsBassInfoDetail(moduleBbsVO);	
		
		model.addAttribute("moduleBbsVO", 			moduleBbsVO);
		
		// 조회수 증가
		nttCmmnService.modifyNttInqireCnt(paramVO);
				
		ModuleNttVO resultVO = nttCmmnService.selectNttDetail(paramVO);
		
		model.addAttribute("nttAuthVO", nttCmmnService.selectCntntsAuthForNtt(request, paramVO.getMenuSeq()));			
		
		boolean sadminAt =  CmmSessionUtil.getSessionBooleanValue(request, "SADMIN_AT");
	    boolean nadminAt =  CmmSessionUtil.getSessionBooleanValue(request, "NADMIN_AT");
	    boolean mngrAt = nttCmmnService.sessionMngrAuthForNtt(request);
	    
        //    log.debug("##### [selectNttDetailAjax resultVO] {}", resultVO);
		if(resultVO != null){
			
			ModuleNttVO choiceResult = nttQnaReplyService.selectNttReplyChoice(paramVO);
			
			model.addAttribute("choiceResult", choiceResult);
			
			model.addAttribute("resultVO", resultVO);
		
			ModuleNttTagVO tagVO = new ModuleNttTagVO();
			tagVO.setSiteSeq(paramVO.getSiteSeq());
			tagVO.setNttSeq(paramVO.getNttSeq());
			
			/* 비밀글 권한 처리 */
			if(resultVO.getSecretAt() != null && resultVO.getSecretAt().equals("Y")) {
				HttpSession session = request.getSession();
				CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
				if(loginVO == null) {
					model.addAttribute("msg", egovMessageSource.getMessage("wzwg.cmm.msg.MSG499"));
		            model.addAttribute("retUrl", wzwgContext+"/index.do");

		            return "wzwg/cmm/errorStringForward"; 
				}
				if((!loginVO.getUserId().equals(resultVO.getNtcrId()))) {
					if((!loginVO.getUserId().equals(resultVO.getParntsNtcrId()))) {
					if(!sadminAt && !nadminAt && !mngrAt) {
					       model.addAttribute("msg", egovMessageSource.getMessage("wzwg.cmm.msg.MSG499"));
				            model.addAttribute("retUrl", wzwgContext+"/index.do");

				            return "wzwg/cmm/errorStringForward"; 
					}
					}
				}
			}
			
			List<ModuleNttTagVO> tagList = nttTagService.selectNttTagList(tagVO);
			model.addAttribute("tagList", tagList);
		}else{
			model.addAttribute("resultVO", paramVO);
		}
		
		model.addAttribute("fileEstbsSe", EgovProperties.getProperty("Globals.fileEstbs"));
		
		return "wzwg/module/ntt/qna/nttDetail"; 
	}
	
	/**
	 * ㅁ 질의응답게시판 - 데이터관리 - 등록 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/qna/registNttFormAjax.do")
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
		
		CntntsAuthVO nttAuthVO = nttCmmnService.selectCntntsAuthForNtt(request, paramVO.getMenuSeq());
		boolean mngrAt = nttCmmnService.sessionMngrAuthForNtt(request);
		
		if(!mngrAt && !"W".equals(nttAuthVO.getAuthorSe())){
			model.addAttribute("authorMessage", egovMessageSource.getMessage("wzwg.cmm.msg.MSG084"));
			return "forward:"+wzwgContext + Globals.URL_PREFIX + "/module/ntt/qna/selectNttListAjax.do";
		}
		
		List<CntntsInfoVO> bbsList = bbsCmmnService.selectBbsList(paramVO.getSiteSeq());
    	model.addAttribute("bbsList", bbsList);
    	
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if(loginVO != null){
			paramVO.setUsrSeq(loginVO.getUsrSeq());
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
		if(loginVO != null){
			tagVO.setUsrSeq(loginVO.getUsrSeq());
		}
		
		// 나의 태그 목록
		List<ModuleNttTagVO> myTagList = nttTagService.selectNttUsrTagList(tagVO);
		model.addAttribute("myTagList", myTagList);
		
		model.addAttribute("nttAuthVO", nttAuthVO);	
		model.addAttribute("fileEstbsSe", EgovProperties.getProperty("Globals.fileEstbs"));		
		model.addAttribute("editorEstbsSe", EgovProperties.getProperty("Globals.editorEstbs"));
		
		return "wzwg/module/ntt/qna/nttRegist"; 
	}
	
	/**
	 * ㅁ 질의응답게시판 - 데이터관리 - 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/qna/registNttInfoAjax.do")
	public ModelAndView registNttInfo(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, final MultipartHttpServletRequest multiRequest
			, HttpServletRequest request
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		
		List<ModuleUploadFileVO> resultList = new ArrayList<ModuleUploadFileVO>();
		String atchFileId = "";
		
		String fileEstbsSe = EgovProperties.getProperty("Globals.fileEstbs");
				
		if("B".equals(fileEstbsSe)){
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			if (!files.isEmpty()) {
				//resultList = fileUtil.parseFileInf(files, "NTT_", 0, "", "");

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
    
		HttpSession session = multiRequest.getSession();
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
	 * ㅁ 질의응답게시판 - 데이터관리 - 수정 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/qna/modifyNttFormAjax.do")
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
		
		if(!mngrAt && !"W".equals(nttAuthVO.getAuthorSe())){
			model.addAttribute("authorMessage", egovMessageSource.getMessage("wzwg.cmm.msg.MSG084"));
			return "forward:"+wzwgContext + Globals.URL_PREFIX + "/module/ntt/qna/selectNttListAjax.do";
		}
		
		List<CntntsInfoVO> bbsList = bbsCmmnService.selectBbsList(paramVO.getSiteSeq());
    	model.addAttribute("bbsList", bbsList);
    	
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
    	ModuleNttVO resultVO = nttCmmnService.selectNttDetail(paramVO);
		
		model.addAttribute("nttAuthVO", nttAuthVO);	    	
		
		if(resultVO != null && loginVO != null){

			if(!mngrAt && !loginVO.getUserId().equals(resultVO.getNtcrId())){
				model.addAttribute("authorMessage", egovMessageSource.getMessage("wzwg.cmm.msg.MSG084"));
				return "forward:"+wzwgContext + Globals.URL_PREFIX + "/module/ntt/qna/selectNttListAjax.do";
			}
			
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
			
			model.addAttribute("resultVO", resultVO);			
			
				paramVO.setUsrSeq(loginVO.getUsrSeq());
			
			// 임시게시물 목록
	    	Integer tmprnttListCnt = nttCmmnService.selectTmprnttListTotCnt(paramVO);
	    	model.addAttribute("tmprnttListCnt", tmprnttListCnt);

			// 나의 태그 목록
			List<ModuleNttTagVO> myTagList = nttTagService.selectNttUsrTagList(tagVO);
			model.addAttribute("myTagList", myTagList);
			
		}else{
			model.addAttribute("resultVO", paramVO);
		}
		
		model.addAttribute("fileEstbsSe", EgovProperties.getProperty("Globals.fileEstbs"));	
		model.addAttribute("editorEstbsSe", EgovProperties.getProperty("Globals.editorEstbs"));
		
		return "wzwg/module/ntt/qna/nttModify"; 
	}
	
	/**
	 * ㅁ 질의응답게시판 - 데이터관리 - 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/qna/modifyNttInfoAjax.do")
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
		
		String fileEstbsSe = EgovProperties.getProperty("Globals.fileEstbs");
		
		if("B".equals(fileEstbsSe)){
			
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			if (!files.isEmpty()) {
				if ("".equals(atchFileId)) {
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
					
					//List<ModuleUploadFileVO> file_result = fileUtil.parseFileInf(files, "NTT_", 0, atchFileId, "");
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
	    
		HttpSession session = multiRequest.getSession();
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
	 * ㅁ 질의응답게시판 - 데이터관리 - 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/qna/deleteNttInfoAjax.do")
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
	 * ㅁ 질의응답게시판 - 휴지통 - 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/qna/selectNttRecycleListAjax.do")
	public String selectNttRecycleList(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
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
		
		paramVO.setFaqTabAt("N");
		
		ModuleBbsVO resultVO = new ModuleBbsVO();
		
		resultVO.setBbsSeq(paramVO.getBbsSeq());
		
		// 게시판 기본정보
		resultVO = bbsQnaBassInfoService.selectBbsBassInfoDetail(resultVO);

		model.addAttribute("resultVO", 			resultVO);		
		
		// 목록
		List<ModuleNttVO> resultList = nttQnaService.selectNttRecycleList(paramVO);
		
		// 목록 총 갯수
		Integer resultCnt = nttQnaService.selectNttRecycleListTotCnt(paramVO);
		
		paginationInfo.setTotalRecordCount(resultCnt.intValue());
		
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		// 게시판 권한
		CntntsAuthVO cntntsAuthVO = new CntntsAuthVO();
		cntntsAuthVO.setCntntsSeq(paramVO.getBbsSeq());
		cntntsAuthVO.setSiteSeq(paramVO.getSiteSeq());

		if(loginVO != null){
			cntntsAuthVO.setUsrSeq(loginVO.getUsrSeq());
		} else {
			cntntsAuthVO.setUsrSeq("0");
		}		

		CntntsAuthVO nttAuthVO = cntntsAuthService.selectCntntsAuthForNtt(cntntsAuthVO);		
		
		model.addAttribute("nttAuthVO", 		nttAuthVO);		
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", resultCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "wzwg/module/ntt/qna/nttRecycleList"; 
	}	

	/**
	 * ㅁ 휴지통 - 복원
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/qna/modifyNttRecycleAjax.do")
	public ModelAndView modifyNttRecycle(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		paramVO.setLastUpdusrId(loginVO != null ? loginVO.getUserId() : "");
		
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
	@RequestMapping(value="/**/module/ntt/qna/deleteNttAjax.do")
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
	@RequestMapping(value="/**/module/ntt/qna/deleteNttAllAjax.do")
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
