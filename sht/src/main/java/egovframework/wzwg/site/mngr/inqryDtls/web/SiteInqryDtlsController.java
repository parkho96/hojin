package egovframework.wzwg.site.mngr.inqryDtls.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.inqryDtls.service.SiteInqryDtlsService;
import egovframework.wzwg.site.mngr.inqryDtls.service.SiteInqryDtlsVO;

@Controller
public class SiteInqryDtlsController {
    
    @Resource(name="SiteInqryDtlsService")
    private SiteInqryDtlsService inqryDtlsService;
    
	/**
	 * 사이트 문의내역 목록
	 */
	@RequestMapping(value={"/mngr/inqryDtls/selectSiteInqryDtlsList.do","/{siteKey}/mngr/inqryDtls/selectSiteInqryDtlsList.do"})
	public String selectSiteInqryDtlsList(
			@ModelAttribute("paramVO")SiteInqryDtlsVO paramVO
			, HttpServletRequest request
			, Model model ) {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		/** =================== paging 시작 ============================== */
		PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
        paginationInfo.setPageSize(paramVO.getPageSize());
       
        paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
        paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        int totCnt = inqryDtlsService.selectSiteInqryDtlsListCnt(paramVO);
        paginationInfo.setTotalRecordCount(totCnt);
		
        /* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
        /** =================== paging 끝 =============================== */
		
		List<SiteInqryDtlsVO> resultList = inqryDtlsService.selectSiteInqryDtlsList(paramVO);
		
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "/wzwg/site/mngr/inqryDtls/siteInqryDtlsList";
	}
	
	/**
     * 사이트 문의내역 상세보기
	 */
	@RequestMapping(value={"/mngr/inqryDtls/selectSiteInqryDtlsDetail.do","/{siteKey}/mngr/inqryDtls/selectSiteInqryDtlsDetail.do"})
	public String selectSiteInqryDtlsDetail(
			@ModelAttribute("paramVO")SiteInqryDtlsVO paramVO
			,HttpServletRequest request
			, Model model ) {
	    
	    paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
	    SiteInqryDtlsVO resultVO = inqryDtlsService.selectSiteInqryDtlsDetail(paramVO);
		model.addAttribute("resultVO", resultVO);
        
		return "/wzwg/site/mngr/inqryDtls/siteInqryDtlsDetail";
	}
	
	/**
     * 사이트 문의내역 삭제
	 * @return
	 */
	@RequestMapping(value= {"/mngr/inqryDtls/deleteSiteInqryDtls.do","/{siteKey}/mngr/inqryDtls/deleteSiteInqryDtls.do"})
	public ModelAndView deleteSiteInqryDtls(
			@ModelAttribute("paramVO")SiteInqryDtlsVO paramVO
			,HttpServletRequest request
			, Model model ) {
		
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
		
		int result = inqryDtlsService.deleteSiteInqryDtls(paramVO);
		
        return CmmAjaxUtil.getAjaxReturnCmmMap(result);
	}
	
}
