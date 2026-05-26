package egovframework.wzwg.module.onlineReqst.mngr.web;

import java.util.Map;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.module.onlineReqst.mngr.service.MngrOnlineReqstNttService;
import egovframework.wzwg.module.onlineReqst.mngr.service.MngrOnlineReqstRceptService;
import egovframework.wzwg.module.onlineReqst.mngr.service.MngrOnlineReqstRceptVO;
import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;


@Controller
public class MngrOnlineReqstRecptController {
	
    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;	

    /** 공통코드 **/
    @Resource(name="CmmCodeService")
    protected CmmCodeService codeService;

	@Resource(name="egovMessageSource")
	protected EgovMessageSource egovMessageSource;
	
    @Resource(name="MngrOnlineReqstRceptService")
    protected MngrOnlineReqstRceptService mngrOnlineReqstRceptService;
    
    @Resource(name="MngrOnlineReqstNttService")
    protected MngrOnlineReqstNttService mngrOnlineReqstNttService;
    
	@Resource(name="SiteUsrGroupService")
	SiteUsrGroupService siteUsrGroupService;    
	
	/*
	 * 온라인신청접수 목록
	 */
    @RequestMapping(value={"/mngr/module/onlineReqst/selectOnlineReqstRceptListAjax.do","/{siteKey}/mngr/module/onlineReqst/selectOnlineReqstRceptListAjax.do"})
    public String selectOnlineReqstRceptList(
            @ModelAttribute("paramVO") MngrOnlineReqstRceptVO paramVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {
    	
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");

    	model.addAttribute("reqcscList", codeService.selectCmmCodeList("REQST_CS_CODE"));

    	PaginationInfo paginationInfo = new PaginationInfo();

    	if(paramVO.getPageUnit() > 0) {
    		paramVO.setPageUnit(paramVO.getPageUnit());
    	} else {
    		paramVO.setPageUnit(propertyService.getInt("pageUnit"));
    	}

		paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
		paginationInfo.setPageSize(paramVO.getPageSize());

		paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
		paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> map = mngrOnlineReqstRceptService.selectOnlineReqstRceptList(paramVO);
		int totCnt = Integer.parseInt((String)map.get("totCnt"));		
		
    	paginationInfo.setTotalRecordCount(totCnt);
    	
    	/* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
    	model.addAttribute("totCnt", totCnt);
    	model.addAttribute("resultList", map.get("resultList"));
    	model.addAttribute("paginationInfo", paginationInfo);
    	
        return "wzwg/module/onlineReqst/mngr/onlineReqstRceptList";
    }  	
	
	/*
	 * 온라인신청접수 삭제
	 */
	@RequestMapping(value={"/mngr/module/onlineReqst/deleteOnlineReqstRceptAjax.do", "/{siteKey}/mngr/module/onlineReqst/deleteOnlineReqstRceptAjax.do"})
	public ModelAndView deleteOnlineReqstRcept(
            @ModelAttribute("paramVO") MngrOnlineReqstRceptVO paramVO
            , HttpServletRequest request
            , ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		if(paramVO.getRceptSeqChkStr() == null){
			result = mngrOnlineReqstRceptService.deleteOnlineReqstRcept(paramVO);	
		}else{
			result = mngrOnlineReqstRceptService.deleteCheckOnlineReqstRcept(paramVO);
		}
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	} 
	
	/*
	 * 온라인신청접수 삭제
	 */
	@RequestMapping(value={"/mngr/module/onlineReqst/modifyOnlineReqstRceptAjax.do","/{siteKey}/mngr/module/onlineReqst/modifyOnlineReqstRceptAjax.do"})
	public ModelAndView modifyOnlineReqstRcept(
            @ModelAttribute("paramVO") MngrOnlineReqstRceptVO paramVO
            , HttpServletRequest request
            , ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}

		result = mngrOnlineReqstRceptService.modifyOnlineReqstRcept(paramVO);	

		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	} 	

    
}    