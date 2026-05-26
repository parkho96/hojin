package egovframework.wzwg.module.api.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.api.service.ModuleApiService;
import egovframework.wzwg.module.api.service.ModuleApiVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeVO;

@Controller
public class ModuleApiController {
	
	@Resource(name="ModuleApiService")
	ModuleApiService moduleApiService;

	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;
	
	/**
	 * API관리 -> API 리스트 조회
	 * @param moduleApiVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/**/module/api/selectModuleApiList.do")
	public String selectModuleApiList(
			@ModelAttribute("paramVO")ModuleApiVO moduleApiVO
			, HttpServletRequest request
			, Model model
			){

		moduleApiVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		/** =================== paging 시작 ============================== */
		PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(moduleApiVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(moduleApiVO.getPageUnit());
        paginationInfo.setPageSize(moduleApiVO.getPageSize());
       
        moduleApiVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        moduleApiVO.setLastIndex(paginationInfo.getLastRecordIndex());
        moduleApiVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        Integer totCnt = moduleApiService.selectModuleApiTotCnt(moduleApiVO);
        paginationInfo.setTotalRecordCount(totCnt.intValue());
        
        /** =================== paging 끝 =============================== */

		List<ModuleApiVO> resultList = moduleApiService.selectModuleApiList(moduleApiVO);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "wzwg/module/api/apiList";
	}
	
	/**
	 * API관리 -> API 등록/수정 폼
	 * @param moduleApiVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/**/module/api/selectModuleApiForm.do")
	public String selectModuleApiForm(
			@ModelAttribute("paramVO")ModuleApiVO moduleApiVO
			, HttpServletRequest request
			, Model model
			) throws Exception{

		moduleApiVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));

		if(!("").equals(moduleApiVO.getApiSeq()) && null != moduleApiVO){
			ModuleApiVO resultVO =  moduleApiService.selectModuleApiDetail(moduleApiVO);
			model.addAttribute("resultVO", resultVO);
		}else{
			model.addAttribute("resultVO", new ModuleApiVO());
		}

		CmmCodeVO cmmCodeVO = new CmmCodeVO();
		cmmCodeVO.setGrpcode("API_GRP_CODE");
		if(moduleApiVO != null) {
			cmmCodeVO.setCode(moduleApiVO.getApiSeCode());
		}
		CmmCodeVO codeVO = codeService.selectCodeInfo(cmmCodeVO);
		
		model.addAttribute("codeVO", codeVO);
		
		return "wzwg/module/api/apiForm";
	}

	/**
	 * API관리 -> API 등록
	 * @param moduleApiVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/**/module/api/registModuleApiAjax.do")
	public ModelAndView registModuleApiAjax(
			@ModelAttribute("paramVO")ModuleApiVO moduleApiVO
			, HttpServletRequest request
			, Model model
			){
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		moduleApiVO.setUserId(loginVO.getUserId());

		moduleApiVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		int result = moduleApiService.registModuleApi(moduleApiVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	
	/**
	 * API관리 -> API수정
	 * @param moduleApiVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/**/module/api/modifyModuleApiAjax.do")
	public ModelAndView modifyModuleApiAjax(
			@ModelAttribute("paramVO")ModuleApiVO moduleApiVO
			, HttpServletRequest request
			, Model model
			){

		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		moduleApiVO.setUserId(loginVO.getUserId());

		int result = moduleApiService.modifyModuleApi(moduleApiVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * API관리 -> API 삭제
	 * @param moduleApiVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/**/module/api/deleteModuleApiAjax.do")
	public ModelAndView deleteModuleApiAjax(
			@ModelAttribute("paramVO")ModuleApiVO moduleApiVO
			, HttpServletRequest request
			, Model model
			){
		
		int result = moduleApiService.deleteModuleApi(moduleApiVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * 네이버지도 API -> 사용자 페이지 (임시페이지)
	 * @param moduleApiVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value= {"/selectMapDetail.do","/{siteKey}/selectMapDetail.do"})
	public String selectMapDetail(
			@ModelAttribute("paramVO")ModuleApiVO moduleApiVO
			, HttpServletRequest request
			, Model model
			) throws Exception{
		
		moduleApiVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		moduleApiVO.setApiSeCode("SC00000374");
		
		ModuleApiVO resultVO = moduleApiService.selectMapDetail(moduleApiVO);
		
		if(null != resultVO && !("").equals(resultVO.getApiSeq())){
			model.addAttribute("resultVO", resultVO);
		}else{
			model.addAttribute("resultVO", new ModuleApiVO());
		}
		
		return "wzwg/module/api/mapDetail";
	}
	
}
