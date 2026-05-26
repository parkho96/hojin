package egovframework.wzwg.sysMngr.siteMngr.siteOpert.web;

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
import egovframework.wzwg.sysMngr.siteMngr.siteGroup.service.SiteGroupService;
import egovframework.wzwg.sysMngr.siteMngr.siteGroup.service.SiteGroupVO;
import egovframework.wzwg.sysMngr.siteMngr.siteOpert.service.SysMngrSysOpertNtcService;
import egovframework.wzwg.sysMngr.siteMngr.siteOpert.service.SysMngrSysOpertNtcVO;

@Controller
public class SysMngrSysOpertNtcController {
	
	@Resource(name="SysOpertNtcService")
	SysMngrSysOpertNtcService sysOpertNtcService;
	
    @Resource(name="SiteGroupService")
    private SiteGroupService siteGroupService;

	/**
	 * @Method Name : selectSysOpertNtcList
	 * @Method 설명 : 작업알림 리스트 조회
	 *
	 * @param sysOpertNtcVO
	 * @param request
	 * @param model
	 * @return
	 *
	 * @변경이력 : 
	 */
	@RequestMapping(value="/sysMngr/siteMngr/siteOpert/selectSysOpertNtcList.do")
	public String selectSysOpertNtcList(
			@ModelAttribute("paramVO")SysMngrSysOpertNtcVO sysOpertNtcVO
			, HttpServletRequest request
			, Model model
		){

		/** =================== paging 시작 ============================== */
		PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(sysOpertNtcVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(sysOpertNtcVO.getPageUnit());
        paginationInfo.setPageSize(sysOpertNtcVO.getPageSize());
        
        sysOpertNtcVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        sysOpertNtcVO.setLastIndex(paginationInfo.getLastRecordIndex());
        sysOpertNtcVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        Integer totCnt = sysOpertNtcService.selectSysOpertNtcTotCnt(sysOpertNtcVO);
        paginationInfo.setTotalRecordCount(totCnt.intValue());
        
        /* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
        /** =================== paging 끝 =============================== */

		List<SysMngrSysOpertNtcVO> resultList = sysOpertNtcService.selectSysOpertNtcList(sysOpertNtcVO);
		
		model.addAttribute("resultList", resultList);

		model.addAttribute("totCnt", totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "wzwg/sysMngr/siteMngr/siteOpert/opertList";
	}
	
	/**
	 * @Method Name : selectSysOpertNtcForm
	 * @Method 설명 : 작업알림 등록/수정 폼
	 *
	 * @param sysOpertNtcVO
	 * @param request
	 * @param model
	 * @return
	 *
	 * @변경이력 : 
	 */
	@RequestMapping(value="/sysMngr/siteMngr/siteOpert/selectSysOpertNtcForm.do")
	public String selectSysOpertNtcForm(
			@ModelAttribute("paramVO")SysMngrSysOpertNtcVO sysOpertNtcVO
			, HttpServletRequest request
			, Model model
		) throws Exception{
		
		/** 사이트 대분류(1차분류) 리스트 */
        SiteGroupVO paramVO = new SiteGroupVO();
        paramVO.setOdr("1");
        List<SiteGroupVO> siteLclasGroupList = siteGroupService.selectSiteGroupAjax(paramVO);
        model.addAttribute("siteLclasGroupList", siteLclasGroupList);
		
		if(!("").equals(sysOpertNtcVO.getSysopertSeq())){
			SysMngrSysOpertNtcVO resultVO = sysOpertNtcService.selectSysOpertNtcDetail(sysOpertNtcVO);
			
			model.addAttribute("resultVO", resultVO);
		}
		
		return "wzwg/sysMngr/siteMngr/siteOpert/opertForm";
	}
	
	/**
	 * @Method Name : registSysOpertNtcAjax
	 * @Method 설명 : 작업알림 등록
	 *
	 * @param sysOpertNtcVO
	 * @param request
	 * @param model
	 * @return
	 *
	 * @변경이력 : 
	 */
	@RequestMapping(value="/sysMngr/siteMngr/siteOpert/registSysOpertNtcAjax.do")
	public ModelAndView registSysOpertNtcAjax(
			@ModelAttribute("paramVO")SysMngrSysOpertNtcVO sysOpertNtcVO
			, HttpServletRequest request
			, Model model
		){
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		sysOpertNtcVO.setUserId(loginVO.getUserId());
		
		int result = sysOpertNtcService.registSysOpertNtc(sysOpertNtcVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * @Method Name : modifySysOpertNtcAjax
	 * @Method 설명 : 작업알림 수정
	 *
	 * @param sysOpertNtcVO
	 * @param request
	 * @param model
	 * @return
	 *
	 * @변경이력 : 
	 */
	@RequestMapping(value="/sysMngr/siteMngr/siteOpert/modifySysOpertNtcAjax.do")
	public ModelAndView modifySysOpertNtcAjax(
			@ModelAttribute("paramVO")SysMngrSysOpertNtcVO sysOpertNtcVO
			, HttpServletRequest request
			, Model model
		){

		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		sysOpertNtcVO.setUserId(loginVO.getUserId());
		
		int result = sysOpertNtcService.modifySysOpertNtc(sysOpertNtcVO);

		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}

	/**
	 * @Method Name : deleteSysOpertNtcAjax
	 * @Method 설명 : 작업알림 삭제
	 *
	 * @param sysOpertNtcVO
	 * @param request
	 * @param model
	 * @return
	 *
	 * @변경이력 : 
	 */
	@RequestMapping(value="/sysMngr/siteMngr/siteOpert/deleteSysOpertNtcAjax.do")
	public ModelAndView deleteSysOpertNtcAjax(
			@ModelAttribute("paramVO")SysMngrSysOpertNtcVO sysOpertNtcVO
			, HttpServletRequest request
			, Model model
		){

		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		sysOpertNtcVO.setUserId(loginVO.getUserId());
		
		int result = sysOpertNtcService.deleteSysOpertNtc(sysOpertNtcVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}

	/**
	 * @Method Name : deleteSysOpertNtcArrAjax
	 * @Method 설명 : 작업알림 체크박스 삭제
	 *
	 * @param sysOpertNtcVO
	 * @param request
	 * @param model
	 * @return
	 *
	 * @변경이력 : 
	 */
	@RequestMapping(value="/sysMngr/siteMngr/siteOpert/deleteSysOpertNtcArrAjax.do")
	public ModelAndView deleteSysOpertNtcArrAjax(
			@ModelAttribute("paramVO")SysMngrSysOpertNtcVO sysOpertNtcVO
			, HttpServletRequest request
			, Model model
		){

		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		sysOpertNtcVO.setUserId(loginVO.getUserId());
		
		int result = sysOpertNtcService.deleteSysOpertNtcArr(sysOpertNtcVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
}