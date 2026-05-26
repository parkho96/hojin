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
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrInfoVO;
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrItmCstdyService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeVO;

@Controller
public class ModuleOnlineQustnrItmCstdyController {

	@Resource(name="ModuleOnlineQustnrItmCstdyService")
	ModuleOnlineQustnrItmCstdyService onlineQustnrItmCstdyService;
	
	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;

	/**
	 * @throws Exception 
	 * @Method Name : selectOnlineQustnrItmCstdyList
	 * @Method 설명 : 내 문항에 저장된 리스트 조회
	 * @작성일 : 2019. 7. 8.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/mngr/module/onlineQustnr/selectOnlineQustnrItmCstdyListAjax.do","/{siteKey}/mngr/module/onlineQustnr/selectOnlineQustnrItmCstdyListAjax.do"})
	public String selectOnlineQustnrItmCstdyList(
			@ModelAttribute("paramVO")ModuleOnlineQustnrInfoVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception{

		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setUsrSeq(loginVO.getUsrSeq());
		
		/** =================== paging 시작 ============================== */
		PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
        paginationInfo.setPageSize(paramVO.getPageSize());
        
        paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
        paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        Integer totCnt = onlineQustnrItmCstdyService.selectOnlineQustnrItmCstdyTotCnt(paramVO);
        
        paginationInfo.setTotalRecordCount(totCnt.intValue());
        
        /* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
        /** =================== paging 끝 =============================== */
        
		List<CmmCodeVO> codeList = codeService.selectCmmCodeList("QESITM_TY_CODE");

		List<ModuleOnlineQustnrInfoVO> resultList = onlineQustnrItmCstdyService.selectOnlineQustnrItmCstdyList(paramVO);
		
		model.addAttribute("codeList", codeList);
		model.addAttribute("resultList", resultList);

		model.addAttribute("totCnt", totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "wzwg/module/onlineQustnr/qustnrItmCstdyList";
	}

	/**
	 * @Method Name : registOnlineQustnrItmCstdy
	 * @Method 설명 : 내 문항에 등록
	 * @작성일 : 2019. 7. 8.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/mngr/module/onlineQustnr/registOnlineQustnrItmCstdyAjax.do","/{siteKey}/mngr/module/onlineQustnr/registOnlineQustnrItmCstdyAjax.do"})
	public ModelAndView registOnlineQustnrItmCstdy(
			@ModelAttribute("paramVO")ModuleOnlineQustnrInfoVO paramVO
			, HttpServletRequest request
			, Model model
			){
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setUsrSeq(loginVO.getUsrSeq());
		
		int result = onlineQustnrItmCstdyService.registOnlineQustnrItmCstdy(paramVO);
		
		return CmmAjaxUtil.getAjaxReturn(String.valueOf(result));
		
	}

	/**
	 * @Method Name : deleteOnlineQustnrItmCstdyArr
	 * @Method 설명 : 내 문항에서 삭제
	 * @작성일 : 2019. 7. 8.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/mngr/module/onlineQustnr/deleteOnlineQustnrItmCstdyArrAjax.do","/{siteKey}/mngr/module/onlineQustnr/deleteOnlineQustnrItmCstdyArrAjax.do"})
	public ModelAndView deleteOnlineQustnrItmCstdyArr(
			@ModelAttribute("paramVO")ModuleOnlineQustnrInfoVO paramVO
			, HttpServletRequest request
			, Model model
			){
		
		int result = onlineQustnrItmCstdyService.deleteOnlineQustnrItmCstdyArr(paramVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}

	/**
	 * @Method Name : registOnlineQustnrItmCstdyNowQustnr
	 * @Method 설명 : 내 문항 -> 현재 설문에 저장
	 * @작성일 : 2019. 7. 8.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/mngr/module/onlineQustnr/registOnlineQustnrItmCstdyNowQustnrAjax.do","/{siteKey}/mngr/module/onlineQustnr/registOnlineQustnrItmCstdyNowQustnrAjax.do"})
	public ModelAndView registOnlineQustnrItmCstdyNowQustnr(
			@ModelAttribute("paramVO")ModuleOnlineQustnrInfoVO paramVO
			, HttpServletRequest request
			, Model model
			){
		
		paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
		
		int result = onlineQustnrItmCstdyService.registOnlineQustnrItmCstdyNowQustnr(paramVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
}
