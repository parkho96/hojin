package egovframework.wzwg.module.beffatPlbc.web;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmJsonAjaxResponser;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.beffatPlbc.service.ModuleBeffatPlbcService;
import egovframework.wzwg.module.beffatPlbc.service.ModuleBeffatPlbcVO;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;

/**
 * 사전정보 공표
 * @author wizwig_cwk
 *
 */
@Controller
public class ModuleBeffatPlbcController {
	@Resource(name="ModuleUploadFileUtil")
    protected ModuleUploadFileUtil fileUtil;
	
	@Resource(name = "ModuleUploadFileService")
    protected ModuleUploadFileService fileService;
	
	@Resource(name="ModuleBeffatPlbcService")
	private ModuleBeffatPlbcService moduleBeffatPlbcService;
	/**
	 * 사용자 - 사전정보 공표
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/**/module/beffatPlbc/selectBeffatPlbc.do","/{siteKey}/module/beffatPlbc/selectBeffatPlbc.do"})
	public String selectBeffatPlbc(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		paramVO.setQkMenuYn("Y");//퀵메뉴 목록조회
		paramVO.setSrchExpsrYn("Y");//비노출 필터
		List<ModuleBeffatPlbcVO> beffatPlbcQkMenuList = moduleBeffatPlbcService.selectBeffatPlbcMainList(paramVO);
		model.addAttribute("beffatPlbcQkMenuList", beffatPlbcQkMenuList);
		
		List<ModuleBeffatPlbcVO> catrgoryList = moduleBeffatPlbcService.selectCtgryList(paramVO);
		model.addAttribute("catrgoryList", catrgoryList);
		
		return "wzwg/module/beffatPlbc/beffatPlbc";
	}
	
	/**
	 * 사용지 - 사전정보 공표 메인 데이터 목록
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/**/module/beffatPlbc/selectBeffatPlbcUsrListItemAjax.do","/{siteKey}/module/beffatPlbc/selectBeffatPlbcUsrListItemAjax.do"})
	public String selectBeffatPlbcUsrListItemAjax(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		paramVO.setSrchExpsrYn("Y");//사용자 비공개 데이터 필터
		
		List<ModuleBeffatPlbcVO> beffatPlbcList = moduleBeffatPlbcService.selectBeffatPlbcMainList(paramVO);
		model.addAttribute("beffatPlbcList", beffatPlbcList);
		
		
		return "wzwg/module/beffatPlbc/beffatPlbcListItem";
	}
	
	/**
	 * 사용자 - 사전정보 공표 서브목록
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/**/module/beffatPlbc/selectBeffatPlbcUsrSubListAjax.do","/{siteKey}/module/beffatPlbc/selectBeffatPlbcUsrSubListAjax.do"})
	public String selectBeffatPlbcUsrSubListAjax(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		ModuleBeffatPlbcVO beffatPlbcVO = moduleBeffatPlbcService.selectBeffatPlbcMainData(paramVO);
		model.addAttribute("beffatPlbcVO", beffatPlbcVO);
		
		
		String totalCount = moduleBeffatPlbcService.selectBeffatPlbcSubTotalCount(paramVO);
		if(totalCount == null) {
			totalCount = "0";
		}
		
		/* 페이지네이션 */
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(5);
		paginationInfo.setPageSize(paramVO.getPageSize());
		paginationInfo.setTotalRecordCount(Integer.parseInt(totalCount));

		paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
		paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		model.addAttribute("paginationInfo", 	paginationInfo);
		
		
		
		paramVO.setSrchExpsrYn("Y");
		List<ModuleBeffatPlbcVO> beffatPlbcSubList = moduleBeffatPlbcService.selectBeffatPlbcSubList(paramVO);
		model.addAttribute("beffatPlbcSubList", beffatPlbcSubList);
		
		
		/* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
		
		return "wzwg/module/beffatPlbc/beffatPlbcSubList";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 관리자 - 사전정보 공표 기본화면 호출
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/module/beffatPlbc/selectBeffatPlbcInc.do","/{siteKey}/mngr/module/beffatPlbc/selectBeffatPlbcInc.do"})
	public String selectBeffatPlbcInc(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setFrstRegisterId(loginVO.getUserId());
		paramVO.setLastUpdusrId(loginVO.getUserId());
		moduleBeffatPlbcService.initCtgryList(paramVO);
		
		return "wzwg/module/beffatPlbc/mngr/beffatPlbcInc";
	}
	
	/**
	 * 관리자 - 사전정보 공표 카테고리 목록
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/module/beffatPlbc/selectBeffatPlbcCategoryListAjax.do","/{siteKey}/mngr/module/beffatPlbc/selectBeffatPlbcCategoryListAjax.do"})
	public String selectBeffatPlbcCategoryListAjax(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		List<ModuleBeffatPlbcVO> catrgoryList = moduleBeffatPlbcService.selectCtgryList(paramVO);
		model.addAttribute("catrgoryList", catrgoryList);
		
		return "wzwg/module/beffatPlbc/mngr/beffatPlbcCategoryList";
	}
	
	/**
	 * 관리자 - 사전정보 공표 카테고리 등록폼
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/module/beffatPlbc/selectBeffatPlbcCategoryRegFrmAjax.do","/{siteKey}/mngr/module/beffatPlbc/selectBeffatPlbcCategoryRegFrmAjax.do"})
	public String selectBeffatPlbcCategoryRegFrmAjax(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		if(paramVO.getCtgryCd() != null && paramVO.getCtgryCd().equals("") == false) {
			ModuleBeffatPlbcVO categoryVO = moduleBeffatPlbcService.selectCtgryData(paramVO);
			model.addAttribute("categoryVO", categoryVO);
		}
		
		
		
		return "wzwg/module/beffatPlbc/mngr/beffatPlbcCategoryRegFrm";
	}
	
	/**
	 * 관리자 - 사전정보 공표 카테고리 등록 프로세스
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/module/beffatPlbc/registBeffatPlbcCategoryAjax.do","/{siteKey}/mngr/module/beffatPlbc/registBeffatPlbcCategoryAjax.do"})
	public String registBeffatPlbcCategoryAjax(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, MultipartHttpServletRequest multiRequest
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setFrstRegisterId(loginVO.getUserId());
		
		List<ModuleUploadFileVO> resultList = null;
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    
	    Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	    
 	    while (itr.hasNext()) {
	    	Entry<String, MultipartFile> entry = itr.next();
	    	Map<String, MultipartFile> file = new HashMap<String, MultipartFile>();
	    	
	    	file.put(entry.getKey(), entry.getValue());
	    	
	    	if (!file.isEmpty()) {
	    		
                resultList = fileUtil.parseFileInf(file, "BP_", 0, "Globals.filePopupPath", "Globals.WhiteImgFileExt", multiRequest, "bp", null, CmmSessionUtil.getSessionSiteSeq(request));

	    		if(!resultList.isEmpty() || resultList.size() != 0){
	    			paramVO.setStorFileId(fileService.insertFileInfs(resultList));
	    		}	    		
	    	}
	    }
		
		
		int result = moduleBeffatPlbcService.registCtgryList(paramVO);
		
		String msg = "fail";
		
		if(result > 0) {
			msg = "success";
		}
		
		return CmmJsonAjaxResponser.getInstance().setResultCode(msg).returnJsp(model);
	}
	
	/**
	 * 관리자 - 사전정보 공표 카테고리 수정 프로세스
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/**/module/beffatPlbc/modifyBeffatPlbcCategoryAjax.do","/{siteKey}/mngr/module/beffatPlbc/modifyBeffatPlbcCategoryAjax.do"})
	public String modifyBeffatPlbcCategoryAjax(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, MultipartHttpServletRequest multiRequest
			, HttpServletRequest request
			, Model model
			) throws Exception {
			
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setFrstRegisterId(loginVO.getUserId());
		
		List<ModuleUploadFileVO> resultList = null;
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		
		while (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
			Map<String, MultipartFile> file = new HashMap<String, MultipartFile>();
			
			file.put(entry.getKey(), entry.getValue());
			
			if (!file.isEmpty()) {
				
				resultList = fileUtil.parseFileInf(file, "BP_", 0, "Globals.filePopupPath", "Globals.WhiteImgFileExt", multiRequest, "bp", null, CmmSessionUtil.getSessionSiteSeq(request));
				
				if(!resultList.isEmpty() || resultList.size() != 0){
					paramVO.setStorFileId(fileService.insertFileInfs(resultList));
				}	    		
			}
		}
		
		
		int result = moduleBeffatPlbcService.modifyCtgryList(paramVO);
		
		String msg = "fail";
		
		if(result > 0) {
			msg = "success";
		}
		
		return CmmJsonAjaxResponser.getInstance().setResultCode(msg).returnJsp(model);
		
	}
	
	/**
	 * 관리자 - 사전정보 공표 카테고리 순서변경
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/module/beffatPlbc/ModifyBeffatPlbcCategoryOrdrAjax.do","/{siteKey}/mngr/module/beffatPlbc/ModifyBeffatPlbcCategoryOrdrAjax.do"})
	public String ModifyBeffatPlbcCategoryOrdrAjax(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		//ModuleBeffatPlbcVO categoryVO = kModuleBeffatPlbcService.selectCtgryData(paramVO);
		
		int result = 0;
		String ordr = "";
		
		if(paramVO != null && paramVO.getOrdr() != null && !"".equals(paramVO.getOrdr())) {
			ordr = paramVO.getOrdr();
			CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			if (loginVO != null) {
				paramVO.setFrstRegisterId(loginVO.getUserId());
				paramVO.setLastUpdusrId(loginVO.getUserId());
			}
		}
		
		if("D".equals(ordr)) {
			result = moduleBeffatPlbcService.modifyCtgrySortDown(paramVO);
		}
		if("U".equals(ordr)) {
			result = moduleBeffatPlbcService.modifyCtgrySortUp(paramVO);
		}
		
		String resultCode = "fail";
		String msgCd = "";
		if(result == -1) {
			msgCd = "001";
		}else if(result == 2) {
			resultCode = "success";
		}
		
		return CmmJsonAjaxResponser.getInstance().setResultCode(resultCode).setResultMsg(msgCd).returnJsp(model);
	}
	
	/**
	 * 관리자 - 사전정보 공표 카테고리 삭제
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/module/beffatPlbc/deleteBeffatPlbcCategoryAjax.do","/{siteKey}/mngr/module/beffatPlbc/deleteBeffatPlbcCategoryAjax.do"})
	public String deleteBeffatPlbcCategoryAjax(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		//ModuleBeffatPlbcVO categoryVO = kModuleBeffatPlbcService.selectCtgryData(paramVO);
		
		int result = 0;
		paramVO.setUseYn("N");
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setFrstRegisterId(loginVO.getUserId());
		paramVO.setLastUpdusrId(loginVO.getUserId());
		
		result = moduleBeffatPlbcService.deleteCtgryData(paramVO);
		
		String resultCode = "fail";
		if(result > -1) {
			resultCode = "success";
		}
		
		return CmmJsonAjaxResponser.getInstance().setResultCode(resultCode).returnJsp(model);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 관리자 - 사전정보 공표 데이터화면
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/module/beffatPlbc/selectBeffatPlbcListAjax.do","/{siteKey}/mngr/module/beffatPlbc/selectBeffatPlbcListAjax.do"})
	public String selectBeffatPlbcListAjax(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		List<ModuleBeffatPlbcVO> beffatPlbcList = moduleBeffatPlbcService.selectBeffatPlbcMainList(paramVO);
		model.addAttribute("beffatPlbcList", beffatPlbcList);
		
		paramVO.setQkMenuYn("Y");//퀵메뉴 목록조회
		List<ModuleBeffatPlbcVO> beffatPlbcQkMenuList = moduleBeffatPlbcService.selectBeffatPlbcMainList(paramVO);
		model.addAttribute("beffatPlbcQkMenuList", beffatPlbcQkMenuList);
		
		List<ModuleBeffatPlbcVO> catrgoryList = moduleBeffatPlbcService.selectCtgryList(paramVO);
		model.addAttribute("catrgoryList", catrgoryList);
		
		
		return "wzwg/module/beffatPlbc/mngr/beffatPlbcList";
	}
	
	/**
	 * 관리자 - 사전정보 공표 메인 데이터 목록
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/module/beffatPlbc/selectBeffatPlbcListItemAjax.do","/{siteKey}/mngr/module/beffatPlbc/selectBeffatPlbcListItemAjax.do"})
	public String selectBeffatPlbcListItemAjax(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		List<ModuleBeffatPlbcVO> beffatPlbcList = moduleBeffatPlbcService.selectBeffatPlbcMainList(paramVO);
		model.addAttribute("beffatPlbcList", beffatPlbcList);
		
		
		return "wzwg/module/beffatPlbc/mngr/beffatPlbcListItem";
	}
	
	/**
	 * 관리자 - 사전정보 공표 데이터화면 즐겨찾기 목록
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/module/beffatPlbc/selectBeffatPlbcQkMenuListAjax.do","/{siteKey}/mngr/module/beffatPlbc/selectBeffatPlbcQkMenuListAjax.do"})
	public String selectBeffatPlbcQkMenuListAjax(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		paramVO.setQkMenuYn("Y");//퀵메뉴 목록조회
		paramVO.setSrchExpsrYn("Y");//관리자도 사용중인것만 노출
		List<ModuleBeffatPlbcVO> beffatPlbcQkMenuList = moduleBeffatPlbcService.selectBeffatPlbcMainList(paramVO);
		model.addAttribute("beffatPlbcQkMenuList", beffatPlbcQkMenuList);
		
		
		return "wzwg/module/beffatPlbc/mngr/beffatPlbcQkMenuList";
	}
	
	
	/**
	 * 관리자 - 사전정보 공표 메인 데이터 등록폼 (수정폼 포함)
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/module/beffatPlbc/selectBeffatPlbcMainRegFrmAjax.do","/{siteKey}/mngr/module/beffatPlbc/selectBeffatPlbcMainRegFrmAjax.do"})
	public String selectBeffatPlbcMainRegFrmAjax(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		List<ModuleBeffatPlbcVO> catrgoryList = moduleBeffatPlbcService.selectCtgryList(paramVO);
		model.addAttribute("catrgoryList", catrgoryList);
		
		String pblcSn = paramVO.getPblcSn();
		if(pblcSn != null && pblcSn.equals("") == false) {
			ModuleBeffatPlbcVO beffatPlbcVO = moduleBeffatPlbcService.selectBeffatPlbcMainData(paramVO);
			model.addAttribute("beffatPlbcVO", beffatPlbcVO);
		}
		
		
		return "wzwg/module/beffatPlbc/mngr/beffatPlbcMainRegFrm";
	}
	
	/**
	 * 관리자 - 사전정보 공표 메인 데이터 등록 프로세스
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/module/beffatPlbc/registBeffatPlbcMainDataAjax.do","/{siteKey}/mngr/module/beffatPlbc/registBeffatPlbcMainDataAjax.do"})
	public String registBeffatPlbcMainDataAjax(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setFrstRegisterId(loginVO.getUserId());
		
		
		int result = moduleBeffatPlbcService.registBeffatPlbcData(paramVO);
		
		String msg = "fail";
		
		if(result > 0) {
			msg = "success";
		}
		
		return CmmJsonAjaxResponser.getInstance().setResultCode(msg).returnJsp(model);
	}
	
	/**
	 * 관리자 - 사전정보 공표 메인 데이터 수정 프로세스
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/module/beffatPlbc/modifyBeffatPlbcMainDataAjax.do","/{siteKey}/mngr/module/beffatPlbc/modifyBeffatPlbcMainDataAjax.do"})
	public String modifyBeffatPlbcMainDataAjax(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setFrstRegisterId(loginVO.getUserId());
		paramVO.setLastUpdusrId(loginVO.getUserId());
		
		
		int result = moduleBeffatPlbcService.modifyBeffatPlbcMainData(paramVO);
		
		String msg = "fail";
		
		if(result > 0) {
			msg = "success";
		}
		
		return CmmJsonAjaxResponser.getInstance().setResultCode(msg).returnJsp(model);
	}
	
	/**
	 * 관리자 - 사전정보 공표 메인 데이터 삭제 프로세스
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/module/beffatPlbc/deleteBeffatPlbcMainDataAjax.do","/{siteKey}/mngr/module/beffatPlbc/deleteBeffatPlbcMainDataAjax.do"})
	public String deleteBeffatPlbcMainDataAjax(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setFrstRegisterId(loginVO.getUserId());
		paramVO.setLastUpdusrId(loginVO.getUserId());
		
		
		int result = moduleBeffatPlbcService.deleteBeffatPlbcMainData(paramVO);
		
		String msg = "fail";
		
		if(result > 0) {
			msg = "success";
		}
		
		return CmmJsonAjaxResponser.getInstance().setResultCode(msg).returnJsp(model);
	}
	
	
	/**
	 * 관리자 - 사전정보 공표 메인 데이터 퀵메뉴 등록/해제 프로세스
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/module/beffatPlbc/modifyBeffatPlbcQkMenuAjax.do","/{siteKey}/mngr/module/beffatPlbc/modifyBeffatPlbcQkMenuAjax.do"})
	public String modifyBeffatPlbcQkMenuAjax(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setFrstRegisterId(loginVO.getUserId());
		paramVO.setLastUpdusrId(loginVO.getUserId());
		
		String command = "";
		if(paramVO.getFrmTy() != null && paramVO.getFrmTy().equals("") == false) {
			command = paramVO.getFrmTy();
		}
		
		int result = 0;
		if(paramVO.getQkMenuYnArrStr() != null && paramVO.getQkMenuYnArrStr().equals("") == false) {
			String []qkMenuPblcSn = paramVO.getQkMenuYnArrStr().split(",");
			
			for (int i = 0; i < qkMenuPblcSn.length; i++) {
				if(command.equals("R")) {
					//등록
					paramVO.setQkMenuYn("Y");
				}
				if(command.equals("D")) {
					//삭제
					paramVO.setQkMenuYn("N");
				}
				
				paramVO.setPblcSn(qkMenuPblcSn[i]);
				result += moduleBeffatPlbcService.modifyBeffatPlbcMainQkMenu(paramVO);
			}
		}
		
		
		String msg = "fail";
		
		if(result > 0) {
			msg = "success";
		}
		
		return CmmJsonAjaxResponser.getInstance().setResultCode(msg).setBodyData("updateCnt", result).returnJsp(model);
	}
	
	/**
	 * 관리자 - 사전정보 공표 메인 데이터 순서변경
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/module/beffatPlbc/ModifyBeffatPlbcMainOrdrAjax.do","/{siteKey}/mngr/module/beffatPlbc/ModifyBeffatPlbcMainOrdrAjax.do"})
	public String ModifyBeffatPlbcMainOrdrAjax(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		//ModuleBeffatPlbcVO categoryVO = kModuleBeffatPlbcService.selectCtgryData(paramVO);
		
		int result = 0;
		String ordr = "";
		
		if(paramVO != null && paramVO.getOrdr() != null && !("".equals(paramVO.getOrdr()))) {
			ordr = paramVO.getOrdr();
			CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
			if (loginVO != null) {
				paramVO.setFrstRegisterId(loginVO.getUserId());
				paramVO.setLastUpdusrId(loginVO.getUserId());
			}
		}
		
		if("D".equals(ordr)) {
			result = moduleBeffatPlbcService.modifyBeffatPlbcMainSortDown(paramVO);
		}
		if("U".equals(ordr)) {
			result = moduleBeffatPlbcService.modifyBeffatPlbcMainSortUp(paramVO);
		}
		
		String resultCode = "fail";
		String msgCd = "";
		if(result == -1) {
			msgCd = "001";
		}else if(result == 2) {
			resultCode = "success";
		}
		
		return CmmJsonAjaxResponser.getInstance().setResultCode(resultCode).setResultMsg(msgCd).returnJsp(model);
	}
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 관리자 - 사전정보 공표 서브목록
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/module/beffatPlbc/selectBeffatPlbcSubListAjax.do","/{siteKey}/mngr/module/beffatPlbc/selectBeffatPlbcSubListAjax.do"})
	public String selectBeffatPlbcSubListAjax(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		String totalCount = moduleBeffatPlbcService.selectBeffatPlbcSubTotalCount(paramVO);
		if(totalCount == null) {
			totalCount = "0";
		}
		
		/* 페이지네이션 */
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(5);
		paginationInfo.setPageSize(paramVO.getPageSize());
		paginationInfo.setTotalRecordCount(Integer.parseInt(totalCount));

		paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
		paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		model.addAttribute("paginationInfo", 	paginationInfo);
		
		
		
		List<ModuleBeffatPlbcVO> beffatPlbcSubList = moduleBeffatPlbcService.selectBeffatPlbcSubList(paramVO);
		model.addAttribute("beffatPlbcSubList", beffatPlbcSubList);
		
		
		
		
		return "wzwg/module/beffatPlbc/mngr/beffatPlbcSubList";
	}
	
	/**
	 * 관리자 - 사전정보 공표 서브 데이터 등록폼 
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/module/beffatPlbc/selectBeffatPlbcSubRegFrmAjax.do","/{siteKey}/mngr/module/beffatPlbc/selectBeffatPlbcSubRegFrmAjax.do"})
	public String selectBeffatPlbcSubRegFrmAjax(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		String pblcSn = paramVO.getPblcSn(); 
		
		if(pblcSn != null && pblcSn.equals("") == false) {
			ModuleBeffatPlbcVO plbcMainVO = moduleBeffatPlbcService.selectBeffatPlbcMainData(paramVO);
			model.addAttribute("plbcMainVO", plbcMainVO);
		}
		
		String listSn = paramVO.getListSn();
		if(listSn != null && listSn.equals("") == false) {
			ModuleBeffatPlbcVO plbcSubVO = moduleBeffatPlbcService.selectBeffatPlbcSubData(paramVO);
			model.addAttribute("plbcSubVO", plbcSubVO);
		}
				
		
		return "wzwg/module/beffatPlbc/mngr/beffatPlbcSubRegFrm";
	}
	
	/**
	 * 관리자 - 사전정보 공표 서브 데이터 등록 프로세스
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/module/beffatPlbc/registBeffatPlbcSubDataAjax.do","/{siteKey}/mngr/module/beffatPlbc/registBeffatPlbcSubDataAjax.do"})
	public String registBeffatPlbcSubDataAjax(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, MultipartHttpServletRequest multiRequest
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setFrstRegisterId(loginVO.getUserId());
		
		List<ModuleUploadFileVO> resultList = null;
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		if (!files.isEmpty()) {
			
			resultList = fileUtil.parseFileInf(files, "BPD_", 0, "Globals.filePopupPath", "Globals.WhiteImgFileExt", multiRequest, "bpd", null, CmmSessionUtil.getSessionSiteSeq(request));

    		if(!resultList.isEmpty() || resultList.size() != 0){
    			paramVO.setStorFileId(fileService.insertFileInfs(resultList));
    		}	
		}
		
		int result = moduleBeffatPlbcService.registBeffatPlbcSubData(paramVO);
		
		String msg = "fail";
		
		if(result > 0) {
			msg = "success";
		}
		
		return CmmJsonAjaxResponser.getInstance().setResultCode(msg).returnJsp(model);
	}
	
	/**
	 * 관리자 - 사전정보 공표 서브 데이터 등록 프로세스
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/module/beffatPlbc/modifyBeffatPlbcSubDataAjax.do","/{siteKey}/mngr/module/beffatPlbc/modifyBeffatPlbcSubDataAjax.do"})
	public String modifyBeffatPlbcSubDataAjax(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, MultipartHttpServletRequest multiRequest
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setFrstRegisterId(loginVO.getUserId());
		paramVO.setLastUpdusrId(loginVO.getUserId());
		
		String atchFileId = StringUtils.defaultString(paramVO.getStorFileId());
		
		List<ModuleUploadFileVO> resultList = null;
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		if (!files.isEmpty()) {
			if ("".equals(atchFileId)) {
				resultList = fileUtil.parseFileInf(files, "BPD_", 0, "Globals.filePopupPath", "Globals.WhiteImgFileExt", multiRequest, "bpd", null, CmmSessionUtil.getSessionSiteSeq(request));
				
				if(!resultList.isEmpty() || resultList.size() != 0){
					paramVO.setStorFileId(fileService.insertFileInfs(resultList));
				}	
			}else {
				ModuleUploadFileVO fvo = new ModuleUploadFileVO();
			    fvo.setAtchFileId(atchFileId);
			    int cnt = fileService.getMaxFileSN(fvo);
			    
			    List<ModuleUploadFileVO> _result = fileUtil.parseFileInf(files, "BPD_", cnt, "Globals.fileStorePath", "Globals.WhiteImgFileExt", multiRequest, "bpd", atchFileId, siteSeq);
			    fileService.updateFileInfs(_result);
			}
			
		}
		
		int result = moduleBeffatPlbcService.modifyBeffatPlbcSubData(paramVO);
		
		String msg = "fail";
		
		if(result > 0) {
			msg = "success";
		}
		
		return CmmJsonAjaxResponser.getInstance().setResultCode(msg).returnJsp(model);
	}
	
	
	/**
	 * 관리자 - 사전정보 공표 서브 데이터 삭제 프로세스
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/module/beffatPlbc/deleteBeffatPlbcSubDataAjax.do","/{siteKey}/mngr/module/beffatPlbc/deleteBeffatPlbcSubDataAjax.do"})
	public String deleteBeffatPlbcSubDataAjax(
			@ModelAttribute("paramVO")ModuleBeffatPlbcVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setFrstRegisterId(loginVO.getUserId());
		paramVO.setLastUpdusrId(loginVO.getUserId());
		
		
		int result = moduleBeffatPlbcService.deleteBeffatPlbcSubData(paramVO);
		
		String msg = "fail";
		
		if(result > 0) {
			msg = "success";
		}
		
		return CmmJsonAjaxResponser.getInstance().setResultCode(msg).returnJsp(model);
	}
}
