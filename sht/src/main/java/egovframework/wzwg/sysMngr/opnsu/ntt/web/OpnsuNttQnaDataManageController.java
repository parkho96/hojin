package egovframework.wzwg.sysMngr.opnsu.ntt.web;

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
import egovframework.wzwg.module.ntt.module.tag.service.ModuleNttTagVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.sysMngr.opnsu.bbs.service.OpnsuBbsCmmnService;
import egovframework.wzwg.sysMngr.opnsu.bbs.service.OpnsuBbsQnaBassInfoService;
import egovframework.wzwg.sysMngr.opnsu.bbs.service.OpnsuBbsVO;
import egovframework.wzwg.sysMngr.opnsu.file.service.OpnsuFileMngrService;
import egovframework.wzwg.sysMngr.opnsu.file.service.OpnsuFileMngrUtil;
import egovframework.wzwg.sysMngr.opnsu.file.service.OpnsuFileVO;
import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttCmmnService;
import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttQnaDataManageService;
import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttQnaReplyService;
import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttVO;

@Controller
public class OpnsuNttQnaDataManageController {


    /** EgovPropertyService */
    @Resource(name="propertiesService")	
    protected EgovPropertyService propertyService;

    /** ModuleNttService */
    @Resource(name="OpnsuNttCmmnService")
    protected OpnsuNttCmmnService nttCmmnService;
    
    /** OpnsuNttQnaDataManageService */
    @Resource(name="OpnsuNttQnaDataManageService")
    protected OpnsuNttQnaDataManageService nttQnaService;
    
    /** OpnsuNttQnaReplyService */
    @Resource(name="OpnsuNttQnaReplyService")
    protected OpnsuNttQnaReplyService nttQnaReplyService;
    
    /** OpnsuBbsCmmnService */
    @Resource(name="OpnsuBbsCmmnService")
    protected OpnsuBbsCmmnService bbsCmmnService;;

    /** OpnsuBbsQnaBassInfoService */
    @Resource(name="OpnsuBbsQnaBassInfoService")
    protected OpnsuBbsQnaBassInfoService bbsQnaBassInfoService;
    
    @Resource(name="OpnsuFileMngrService")
	public OpnsuFileMngrService fileService;
	
	@Resource(name = "OpnsuFileMngrUtil")
    private OpnsuFileMngrUtil fileUtil;
	
	/**
	 * ㅁ 질의응답게시판 - 데이터관리 - 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/opnsu/ntt/qna/selectNttListAjax.do")
	public String selectNttList(
			@ModelAttribute("paramVO") OpnsuNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		List<CntntsInfoVO> bbsList = bbsCmmnService.selectBbsList(paramVO.getSiteSeq());
    	
    	if(paramVO.getBbsSeq() == null && bbsList.size() > 0){
    		paramVO.setBbsSeq(bbsList.get(0).getCntntsSeq());
    	}
    	
    	model.addAttribute("bbsList", bbsList);
    	
    	String reqUrl = request.getRequestURI();	
    	
    	if(paramVO.getBbsSeq() != null && paramVO.getBbsSeq().equals("10000000003") && reqUrl.indexOf("/sysMngr/") > -1) {
    		paramVO.setSiteSeq("");
    	}  	
    	
    	if(paramVO.getPageUnit() > 0) {
    		paramVO.setPageUnit(paramVO.getPageUnit());
    	} else {
    		paramVO.setPageUnit(propertyService.getInt("pageUnit"));
    	}
    	
		paramVO.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
		paginationInfo.setPageSize(paramVO.getPageSize());

		paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
		paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		paramVO.setFaqTabAt("N");
		
		// FAQ 목록
		List<OpnsuNttVO> noticeList = null;
			
		// 첫번째 페이지 && 검색조건이 없을 경우
		if(paramVO.getPageIndex() == 1 && "".equals(paramVO.getSearchCondition())){
			noticeList = nttQnaService.selectNttNoticeList(paramVO);
		}
		
		model.addAttribute("noticeList", noticeList);
		
		// 목록
		List<OpnsuNttVO> resultList = nttQnaService.selectNttList(paramVO);
		
		// 목록 총 갯수
		Integer resultCnt = nttQnaService.selectNttListTotCnt(paramVO);
		
		// 말머리 여부
		List<OpnsuBbsVO> subospecList = bbsCmmnService.selectBbsSubospecList(paramVO.getBbsSeq());
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
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", resultCnt);
		model.addAttribute("subospecList", 		subospecList);
		model.addAttribute("subospecListCnt", 	subospecListCnt);		
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "wzwg/sysMngr/opnsu/ntt/qna/nttList"; 
	}

	/**
	 * ㅁ 질의응답게시판 - 데이터관리 - 상단걸기 등록 / 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/opnsu/ntt/qna/modifyNttNoticeAjax.do")
	public ModelAndView modifyNttNotice(
			@ModelAttribute("paramVO") OpnsuNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
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
	@RequestMapping(value="/**/opnsu/ntt/qna/modifyNttFaqAjax.do")
	public ModelAndView modifyNttFaq(
			@ModelAttribute("paramVO") OpnsuNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
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
	@RequestMapping(value="/**/opnsu/ntt/qna/selectNttDetailAjax.do")
	public String selectNttDetail(
			@ModelAttribute("paramVO") OpnsuNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		OpnsuBbsVO moduleBbsVO = new OpnsuBbsVO();
		
		moduleBbsVO.setBbsSeq(paramVO.getBbsSeq());
		
		// 게시판 기본정보
		moduleBbsVO = bbsQnaBassInfoService.selectBbsBassInfoDetail(moduleBbsVO);
		
		model.addAttribute("moduleBbsVO", 	moduleBbsVO);
		
		// 조회수 증가
		nttCmmnService.modifyNttInqireCnt(paramVO);
				
		OpnsuNttVO resultVO = nttCmmnService.selectNttDetail(paramVO);

		if(resultVO != null){
			
			OpnsuNttVO choiceResult = nttQnaReplyService.selectNttReplyChoice(paramVO);
			
			model.addAttribute("choiceResult", choiceResult);
			
			model.addAttribute("resultVO", resultVO);
		
		}else{
			model.addAttribute("resultVO", paramVO);
		}
		
		model.addAttribute("fileEstbsSe", 	EgovProperties.getProperty("Globals.fileEstbs"));
		
		return "wzwg/sysMngr/opnsu/ntt/qna/nttDetail"; 
	}
	
	/**
	 * ㅁ 질의응답게시판 - 데이터관리 - 등록 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/opnsu/ntt/qna/registNttFormAjax.do")
	public String registNttForm(
			@ModelAttribute("paramVO") OpnsuNttVO paramVO
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
		
		model.addAttribute("fileEstbsSe", 	EgovProperties.getProperty("Globals.fileEstbs"));
		model.addAttribute("editorEstbsSe", EgovProperties.getProperty("Globals.editorEstbs"));

		return "wzwg/sysMngr/opnsu/ntt/qna/nttRegist"; 
	}
	
	/**
	 * ㅁ 질의응답게시판 - 데이터관리 - 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/opnsu/ntt/qna/registNttInfoAjax.do")
	public ModelAndView registNttInfo(
			@ModelAttribute("paramVO") OpnsuNttVO paramVO
			, final MultipartHttpServletRequest multiRequest
			, HttpServletRequest request
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		
		List<OpnsuFileVO> resultList = null;
		String atchFileId = "";
	    
	    final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    if (!files.isEmpty()) {
	    	//resultList = fileUtil.parseFileInf(files, "NTT_", 0, "", "");
	    	resultList = fileUtil.parseFileInf(files, "OPNSU_", 0, "Globals.fileStorePath", "Globals.WhiteFileExt", multiRequest, "ntt", null, siteSeq);
			atchFileId = fileService.insertFileInfs(resultList);
	    }
	    
		HttpSession session = multiRequest.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setNtcrId(loginVO.getUserId());
			paramVO.setNtcrNm(loginVO.getUserNm());
			paramVO.setNtcrSeq(loginVO.getUsrSeq());
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
	@RequestMapping(value="/**/opnsu/ntt/qna/modifyNttFormAjax.do")
	public String modifyNttForm(
			@ModelAttribute("paramVO") OpnsuNttVO paramVO
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
		
    	OpnsuNttVO resultVO = nttCmmnService.selectNttDetail(paramVO);
		
		if(resultVO != null){
			model.addAttribute("resultVO", resultVO);
			
			ModuleNttTagVO tagVO = new ModuleNttTagVO();
			tagVO.setSiteSeq(paramVO.getSiteSeq());
			tagVO.setNttSeq(paramVO.getNttSeq());
			if (loginVO != null) {
				tagVO.setUsrSeq(loginVO.getUsrSeq());
				
				paramVO.setUsrSeq(loginVO.getUsrSeq());
			}
			
		}else{
			model.addAttribute("resultVO", paramVO);
		}
		
		model.addAttribute("fileEstbsSe", 	EgovProperties.getProperty("Globals.fileEstbs"));
		model.addAttribute("editorEstbsSe", EgovProperties.getProperty("Globals.editorEstbs"));
		
		return "wzwg/sysMngr/opnsu/ntt/qna/nttModify"; 
	}
	
	/**
	 * ㅁ 질의응답게시판 - 데이터관리 - 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/opnsu/ntt/qna/modifyNttInfoAjax.do")
	public ModelAndView modifyNttInfo(
			@ModelAttribute("paramVO") OpnsuNttVO paramVO
			, final MultipartHttpServletRequest multiRequest
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		
		String atchFileId = StringUtils.defaultString(paramVO.getAtchFileId());
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		
	    if (!files.isEmpty()) {
			if ("".equals(atchFileId)) {
			    List<OpnsuFileVO> file_result = fileUtil.parseFileInf(files, "OPNSU_", 0, "Globals.fileStorePath", "Globals.WhiteFileExt", multiRequest, "ntt", atchFileId, siteSeq);
			    atchFileId = fileService.insertFileInfs(file_result);
			    paramVO.setAtchFileId(atchFileId);
			} else {
				OpnsuFileVO fvo = new OpnsuFileVO();
			    fvo.setAtchFileId(atchFileId);
			    int cnt = fileService.getMaxFileSN(fvo);
			    List<OpnsuFileVO> _result = fileUtil.parseFileInf(files, "OPNSU_", cnt, "Globals.fileStorePath", "Globals.WhiteFileExt", multiRequest, "ntt", atchFileId, siteSeq);
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
	@RequestMapping(value="/**/opnsu/ntt/qna/deleteNttInfoAjax.do")
	public ModelAndView deleteNttInfo(
			@ModelAttribute("paramVO") OpnsuNttVO paramVO
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
	
	
}
