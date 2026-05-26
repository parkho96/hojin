package egovframework.wzwg.module.onlineQustnr.web;

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
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrIemVO;
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrInfoService;
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrInfoVO;
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrQesitmService;
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrQesitmVO;
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrRespondService;
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrRespondVO;

@Controller
public class ModuleOnlineQustnrRespondController {

	/** 설문 서비스 */
	@Resource(name="ModuleOnlineQustnrInfoService")
	ModuleOnlineQustnrInfoService onlineQustnrInfoService;
	
	/** 설문 항목 서비스 */
	@Resource(name="ModuleOnlineQustnrQesitmService")
	ModuleOnlineQustnrQesitmService onlineQustnrQesitmService;
	
	/** 설문 답변 서비스 */
	@Resource(name="ModuleOnlineQustnrRespondService")
	ModuleOnlineQustnrRespondService onlineQustnrRespondService;
	
	/**
	 * @Method Name : selectOnlineQustnrRespondInc
	 * @Method 설명 : 온라인설문(사용자) 초기 화면
	 * @작성일 : 2019. 7. 9.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/module/onlineQustnr/selectOnlineQustnrRespondInc.do","/{siteKey}/module/onlineQustnr/selectOnlineQustnrRespondInc.do"})
	public String selectOnlineQustnrRespondInc(
			@ModelAttribute("paramVO")ModuleOnlineQustnrRespondVO paramVO
			, HttpServletRequest request
			, Model model
			){
		
		return "wzwg/module/onlineQustnr/qustnrRespondInc";
	}
	
	/**
	 * @Method Name : selectOnlineQustnrRespondList
	 * @Method 설명 : 온라인설문(사용자) 리스트 조회
	 * @작성일 : 2019. 7. 9.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/module/onlineQustnr/selectOnlineQustnrRespondListAjax.do","/{siteKey}/module/onlineQustnr/selectOnlineQustnrRespondListAjax.do"})
	public String selectOnlineQustnrRespondList(
			@ModelAttribute("paramVO")ModuleOnlineQustnrRespondVO paramVO
			, HttpServletRequest request
			, Model model
			){

		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));

		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		if (loginVO != null) {
			paramVO.setUsrSeq(loginVO.getUsrSeq());
		}

		/** =================== paging 시작 ============================== */
		PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
        paginationInfo.setPageSize(paramVO.getPageSize());
        
        paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
        paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        Integer totCnt = onlineQustnrRespondService.selectQustnrInfoTotCnt(paramVO);
        paginationInfo.setTotalRecordCount(totCnt.intValue());
        
        /* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
        /** =================== paging 끝 =============================== */

		List<ModuleOnlineQustnrRespondVO> resultList = onlineQustnrRespondService.selectOnlineQustnrList(paramVO);
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", resultList);
		
		return "wzwg/module/onlineQustnr/qustnrRespondList";
	}
	
	/**
	 * @Method Name : selectOnlineQustnrRespondForm
	 * @Method 설명 : 온라인설문(사용자) 등록 폼
	 * @작성일 : 2019. 7. 9.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/module/onlineQustnr/selectOnlineQustnrRespondFormPopup.do","/{siteKey}/module/onlineQustnr/selectOnlineQustnrRespondFormPopup.do"})
	public String selectOnlineQustnrRespondFormPopup(
			@ModelAttribute("paramVO")ModuleOnlineQustnrRespondVO paramVO
			, HttpServletRequest request
			, Model model
			){
		
		ModuleOnlineQustnrInfoVO infoVO = new ModuleOnlineQustnrInfoVO();
		infoVO.setQustnrSeq(paramVO.getQustnrSeq());
		ModuleOnlineQustnrInfoVO resultVO = onlineQustnrInfoService.selectOnlineQustnrInfoDetail(infoVO);
		
		ModuleOnlineQustnrQesitmVO qesitmVO = new ModuleOnlineQustnrQesitmVO();
		qesitmVO.setQustnrSeq(paramVO.getQustnrSeq());
		List<ModuleOnlineQustnrQesitmVO> resultList = onlineQustnrQesitmService.selectOnlineQustnrQesitmList(qesitmVO);
		
		model.addAttribute("resultVO", resultVO);
		model.addAttribute("resultList", resultList);
		
		return "wzwg/module/onlineQustnr/qustnrRespondForm";
	}

	/**
	 * @Method Name : selectOnlineQustnrRespondFormIemList
	 * @Method 설명 : 온라인설문(사용자) 항목 리스트 조회
	 * @작성일 : 2019. 7. 9.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/module/onlineQustnr/selectOnlineQustnrRespondFormIemListAjax.do","/{siteKey}/module/onlineQustnr/selectOnlineQustnrRespondFormIemListAjax.do"})
	public String selectOnlineQustnrRespondFormIemList(
			@ModelAttribute("paramVO")ModuleOnlineQustnrIemVO paramVO
			, HttpServletRequest request
			, Model model
			){
		
		List<ModuleOnlineQustnrIemVO> iemList = onlineQustnrQesitmService.selectOnlineQustnrIemList(paramVO);
		model.addAttribute("iemList", iemList);
		
		return "wzwg/module/onlineQustnr/qustnrRespondFormAjax";
	}
	
	
	/**
	 * @Method Name : registOnlineQustnrRespond
	 * @Method 설명 : 온라인설문(사용자) 답변 등록
	 * @작성일 : 2019. 7. 9.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/module/onlineQustnr/registOnlineQustnrRespondAjax.do","/{siteKey}/module/onlineQustnr/registOnlineQustnrRespondAjax.do"})
	public ModelAndView registOnlineQustnrRespond(
			@ModelAttribute("paramVO")ModuleOnlineQustnrRespondVO paramVO
			, HttpServletRequest request
			, Model model
			){
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setIp(loginVO.getIp());
		paramVO.setUsrSeq(loginVO.getUsrSeq());
		
		int result = onlineQustnrRespondService.registOnlineQustnrRespond(paramVO);

		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	
}
