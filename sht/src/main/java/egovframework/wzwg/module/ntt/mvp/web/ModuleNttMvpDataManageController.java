package egovframework.wzwg.module.ntt.mvp.web;

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

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.Globals;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.cmm.util.CmmXssUtil;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsCmmnService;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;
import egovframework.wzwg.module.bbs.mvp.service.ModuleBbsMvpBassInfoService;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttCmmnService;
import egovframework.wzwg.module.ntt.mvp.service.ModuleNttMvpDataManageService;
import egovframework.wzwg.module.ntt.mvp.service.ModuleNttMvpVO;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthService;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;

@Controller
public class ModuleNttMvpDataManageController {


	/** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    /** ModuleNttService */
    @Resource(name="ModuleNttCmmnService")
    protected ModuleNttCmmnService nttCmmnService;
    
    /** ModuleNttService */
    @Resource(name="ModuleNttMvpDataManageService")
    protected ModuleNttMvpDataManageService nttMvpService;
    
    /** ModuleBbsCmmnService */
    @Resource(name="ModuleBbsCmmnService")
    protected ModuleBbsCmmnService bbsCmmnService;
    
    /** ModuleBbsMvpBassInfoService */
    @Resource(name="ModuleBbsMvpBassInfoService")
    protected ModuleBbsMvpBassInfoService bbsMvpBassInfoService;
    
    @Resource(name="ModuleUploadFileUtil")
    protected ModuleUploadFileUtil fileUtil;
	
    @Resource(name = "ModuleUploadFileService")
    protected ModuleUploadFileService fileService;

    /** CntntsAuthService */
    @Resource(name="CntntsAuthService")
    protected CntntsAuthService cntntsAuthService;	
	
	/**
	 * ㅁ 동영상게시물 - 데이터관리 - 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/mvp/selectNttMvpListAjax.do")
	public String selectNttMvpList(
			@ModelAttribute("paramVO") ModuleNttMvpVO paramVO
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
		resultVO = bbsMvpBassInfoService.selectBbsBassInfoDetail(resultVO);
		
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
		
		// 목록
		List<ModuleNttMvpVO> resultList = nttMvpService.selectNttMvpList(paramVO);
		
		// 목록 총 갯수
		Integer resultCnt = nttMvpService.selectNttMvpListTotCnt(paramVO);
		
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
		model.addAttribute("nttAuthVO", 		nttCmmnService.selectCntntsAuthForNtt(request, paramVO.getMenuSeq()));
		model.addAttribute("resultList", 		resultList);
		model.addAttribute("resultCnt", 		resultCnt);
		model.addAttribute("subospecList", 		subospecList);
		model.addAttribute("subospecListCnt", 	subospecListCnt);
		model.addAttribute("paginationInfo", 	paginationInfo);
			
		return "wzwg/module/ntt/mvp/nttList";
		
	}
	
	/**
	 * ㅁ 동영상게시물 - 데이터관리 - 상세보기
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/mvp/selectNttMvpDetailAjax.do")
	public String selectNttMvpDetail(
			@ModelAttribute("paramVO") ModuleNttMvpVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
		
		moduleBbsVO.setBbsSeq(paramVO.getBbsSeq());
		
		// 게시판 기본정보
		moduleBbsVO = bbsMvpBassInfoService.selectBbsBassInfoDetail(moduleBbsVO);
		
		model.addAttribute("moduleBbsVO", 			moduleBbsVO);		
		
		// 조회수 증가
		nttMvpService.modifyNttMvpInqireCnt(paramVO);
				
		ModuleNttMvpVO resultVO = nttMvpService.selectNttMvpDetail(paramVO);
		
		model.addAttribute("nttAuthVO", nttCmmnService.selectCntntsAuthForNtt(request, paramVO.getMenuSeq()));		
		
		if(resultVO != null){
			model.addAttribute("resultVO", resultVO);
			
			if(resultVO.getMvpCap() == null ){
				resultVO.setMvpCap(""); // 자막없을때 방어코팅 추가 2019.02.15 조원권
			}
			int mvpCapLen = resultVO.getMvpCap().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "").length();
			model.addAttribute("mvpCapLen", mvpCapLen);
			
		}else{
			model.addAttribute("resultVO", paramVO);
		}

		model.addAttribute("fileEstbsSe", EgovProperties.getProperty("Globals.fileEstbs"));	
		
		return "wzwg/module/ntt/mvp/nttDetail";
	}
		
	/**
	 * ㅁ 통합게시물 - 데이터관리 - 등록 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/mvp/registNttMvpFormAjax.do")
	public String registNttMvpForm(
			@ModelAttribute("paramVO") ModuleNttMvpVO paramVO
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
			return "forward:"+wzwgContext + Globals.URL_PREFIX + "/module/ntt/mvp/selectNttMvpListAjax.do";
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

		model.addAttribute("nttAuthVO", nttAuthVO);		
		model.addAttribute("fileEstbsSe", EgovProperties.getProperty("Globals.fileEstbs"));	
		model.addAttribute("editorEstbsSe", EgovProperties.getProperty("Globals.editorEstbs"));
		
		return "wzwg/module/ntt/mvp/nttRegist"; 
	}
	
	/**
	 * ㅁ 통합게시물 - 데이터관리 - 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/mvp/registNttMvpInfoAjax.do")
	public ModelAndView registNttMvpInfo(
			@ModelAttribute("paramVO") ModuleNttMvpVO paramVO
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
				resultList = fileUtil.parseFileInf(files, "NTT_", 0, "Globals.fileStorePath", "Globals.WhiteFileExt", multiRequest, "ntt", null, siteSeq);
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
			paramVO.setNtcrId(loginVO.getUserId());
			paramVO.setNtcrNm(loginVO.getUserNm());
			paramVO.setUsrSeq(loginVO.getUsrSeq());
			paramVO.setNtcrSeq(loginVO.getUsrSeq());
		}
		paramVO.setMvpnttSeq(nttMvpService.selectNextMvpnttSeq(paramVO));
		paramVO.setAtchFileId(atchFileId);
		paramVO.setNttSj(CmmXssUtil.unscript(paramVO.getNttSj()));
		paramVO.setNttCn(CmmXssUtil.unscript(paramVO.getNttCn()));
		
		if(paramVO.getMvpUrl() != null){
			if(paramVO.getMvpUrl().indexOf("=") > -1){
				paramVO.setMvpKey(paramVO.getMvpUrl().substring(paramVO.getMvpUrl().lastIndexOf("=") + 1));
			}else{
				paramVO.setMvpKey(paramVO.getMvpUrl().substring(paramVO.getMvpUrl().lastIndexOf("/") + 1));
			}
		}
		
		result = nttMvpService.registNttMvpInfo(paramVO);	// 저장
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn(paramVO.getMvpnttSeq());
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ 통합게시물 - 데이터관리 - 수정 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/mvp/modifyNttMvpFormAjax.do")
	public String modifyNttMvpForm(
			@ModelAttribute("paramVO") ModuleNttMvpVO paramVO
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
			return "forward:"+wzwgContext + Globals.URL_PREFIX + "/module/ntt/mvp/selectNttMvpListAjax.do";
		}
		
		List<CntntsInfoVO> bbsList = bbsCmmnService.selectBbsList(paramVO.getSiteSeq());
    	model.addAttribute("bbsList", bbsList);
    	
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
    	ModuleNttMvpVO resultVO = nttMvpService.selectNttMvpDetail(paramVO);
		
		if(resultVO != null && loginVO != null){
			
			if(!mngrAt && !loginVO.getUsrSeq().equals(resultVO.getNtcrSeq())){
				model.addAttribute("authorMessage", egovMessageSource.getMessage("wzwg.cmm.msg.MSG084"));
				return "forward:"+wzwgContext + Globals.URL_PREFIX + "/module/ntt/mvp/selectNttMvpListAjax.do";
			}
			
			model.addAttribute("resultVO", resultVO);			
			paramVO.setUsrSeq(loginVO.getUsrSeq());
			
		}else{
			model.addAttribute("resultVO", paramVO);
		}
		
		model.addAttribute("fileEstbsSe", EgovProperties.getProperty("Globals.fileEstbs"));	
		model.addAttribute("editorEstbsSe", EgovProperties.getProperty("Globals.editorEstbs"));
		model.addAttribute("nttAuthVO", nttAuthVO);
		
		return "wzwg/module/ntt/mvp/nttModify"; 
	}
	
	/**
	 * ㅁ 통합게시물 - 데이터관리 - 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/mvp/modifyNttMvpInfoAjax.do")
	public ModelAndView modifyNttMvpInfo(
			@ModelAttribute("paramVO") ModuleNttMvpVO paramVO
			, final MultipartHttpServletRequest multiRequest
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		/* 권한체크 */
		
		boolean chkPostOener = nttCmmnService.checkOwnerMvpPost(request, paramVO);
		
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
					//List<ModuleUploadFileVO> file_result = fileUtil.parseFileInf(files, "NTT_", 0, atchFileId, "");
					List<ModuleUploadFileVO> file_result = fileUtil.parseFileInf(files, "NTT_", 0, "Globals.fileStorePath", "Globals.WhiteFileExt", multiRequest, "ntt", atchFileId, siteSeq);
					atchFileId = fileService.insertFileInfs(file_result);
					paramVO.setAtchFileId(atchFileId);
				} else {
					ModuleUploadFileVO fvo = new ModuleUploadFileVO();
					fvo.setAtchFileId(atchFileId);
					int cnt = fileService.getMaxFileSN(fvo);
					//List<ModuleUploadFileVO> _result = fileUtil.parseFileInf(files, "NTT_", cnt, atchFileId, "");
					List<ModuleUploadFileVO> _result = fileUtil.parseFileInf(files, "NTT_", cnt, "Globals.fileStorePath", "Globals.WhiteFileExt", multiRequest, "ntt", atchFileId, siteSeq);
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
		
		if(paramVO.getMvpUrl() != null){
			if(paramVO.getMvpUrl().indexOf("=") > -1){
				paramVO.setMvpKey(paramVO.getMvpUrl().substring(paramVO.getMvpUrl().lastIndexOf("=") + 1));
			}else{
				paramVO.setMvpKey(paramVO.getMvpUrl().substring(paramVO.getMvpUrl().lastIndexOf("/") + 1));
			}
		}
		
		result = nttMvpService.modifyNttMvpInfo(paramVO);	// 수정
		
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
	@RequestMapping(value="/**/module/ntt/mvp/deleteNttMvpInfoAjax.do")
	public ModelAndView deleteNttMvpInfo(
			@ModelAttribute("paramVO") ModuleNttMvpVO paramVO
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
			
			boolean chkPostOener = nttCmmnService.checkOwnerMvpPost(request, paramVO);
			
			if(chkPostOener == false) {
				return CmmAjaxUtil.getAjaxReturn("authFail");
			}
			
			result = nttMvpService.deleteNttMvpInfo(paramVO);			// 삭제
		}else{
			result = nttMvpService.deleteCheckNttMvpInfo(paramVO);	// 체크박스 목록 삭제
		}
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ 통합게시물 - 휴지통 - 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/mvp/selectNttMvpRecycleListAjax.do")
	public String selectNttMvpRecycleList(
			@ModelAttribute("paramVO") ModuleNttMvpVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setUsrSeq(loginVO.getUsrSeq());
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
		resultVO = bbsMvpBassInfoService.selectBbsBassInfoDetail(resultVO);
		
		model.addAttribute("resultVO", 			resultVO);
		
		// 목록
		List<ModuleNttMvpVO> resultList = nttMvpService.selectNttMvpRecycleList(paramVO);
		
		// 목록 총 갯수
		Integer resultCnt = nttMvpService.selectNttMvpRecycleListTotCnt(paramVO);
		
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
			
		return "wzwg/module/ntt/mvp/nttRecycleList";
		
	}	
	
	/**
	 * ㅁ 휴지통 - 복원
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/mvp/modifyNttMvpRecycleAjax.do")
	public ModelAndView modifyNttMvpRecycle(
			@ModelAttribute("paramVO") ModuleNttMvpVO paramVO
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
			result = nttMvpService.modifyNttMvpRecycle(paramVO);			// 복원
		}else{
			result = nttMvpService.modifyCheckNttMvpRecycle(paramVO);	// 체크박스 목록 복원
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
	@RequestMapping(value="/**/module/ntt/mvp/deleteNttMvpAjax.do")
	public ModelAndView deleteNttMvp(
			@ModelAttribute("paramVO") ModuleNttMvpVO paramVO
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
		result = nttMvpService.deleteSiteNttMvp(paramVO);

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
	@RequestMapping(value="/**/module/ntt/mvp/deleteNttMvpAllAjax.do")
	public ModelAndView deleteNttMvpAll(
			@ModelAttribute("paramVO") ModuleNttMvpVO paramVO
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
		result = nttMvpService.deleteSiteNttMvp(paramVO);

		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}	
	
}
