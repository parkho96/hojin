package egovframework.wzwg.site.mngr.usrMngr.usrLog.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.sym.log.clg.service.EgovLoginLogService;
import egovframework.com.sym.log.clg.service.LoginLog;
import egovframework.wzwg.site.mngr.usrMngr.usrLog.service.SiteUsrLogService;
import egovframework.wzwg.site.mngr.usrMngr.usrLog.service.SiteUsrLogVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoVO;
import egovframework.wzwg.sysMngr.usrMngr.usrTy.service.SysMngrUsrTyService;

@Controller
public class SiteUsrLogController {
    
	@Resource(name="SysMngrUsrTyService")
	SysMngrUsrTyService sysMngrUsrTyService;
    
    @Resource(name="SiteUsrLogService")
    SiteUsrLogService siteUsrLogService;
    
    @Resource(name="SysMngrSiteInfoService")
	private SysMngrSiteInfoService siteInfoService;
    
    @Resource(name="CmmCodeService")
    private CmmCodeService codeService;
    
    @Resource(name="EgovLoginLogService")
	private EgovLoginLogService loginLogService;
    
	/**
	 * 사이트 사용자 그룹 리스트 조회
	 * @param siteUsrGroupVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/sysMngr/usrLog/selectSiteUsrLogList.do")
	public String selectSiteUsrLogList(
			@ModelAttribute("paramVO")SiteUsrLogVO paramVO
			, HttpServletRequest request
			, Model model 
			) throws Exception{
		 
		
		/** =================== paging 시작 ============================== */
		PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
        paginationInfo.setPageSize(paramVO.getPageSize());
       
        paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
        paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        int totCnt = siteUsrLogService.selectSiteUsrLogCnt(paramVO);
        paginationInfo.setTotalRecordCount(totCnt);
		
        /** =================== paging 끝 =============================== */
		
		List<SiteUsrLogVO> siteUsrLogList = siteUsrLogService.selectSiteUsrLogList(paramVO);
		
		SysMngrSiteInfoVO sysMngrSiteInfoVO = new SysMngrSiteInfoVO();
		
		sysMngrSiteInfoVO.setFirstIndex(0);
		sysMngrSiteInfoVO.setRecordCountPerPage(100000);
		List<SysMngrSiteInfoVO> siteInfoList = siteInfoService.selectSiteInfoList(sysMngrSiteInfoVO);
		List<CmmCodeVO> codeList = codeService.selectCmmCodeList("SITEUSR_LOG_CODE");
		
		/* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
		model.addAttribute("siteInfoList", siteInfoList);
		model.addAttribute("codeList", codeList);
		
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("siteUsrLogList", siteUsrLogList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "/wzwg/site/mngr/usrMngr/usrLog/SiteUsrLogList";
	}
	
	/**
	 * 사이트 관리자
	 * @param LoginLog
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/sysMngr/usrLog/selectSiteMngrLoginLogList.do")
	public String selectSiteMngrLoginLogList(
			@ModelAttribute("paramVO") LoginLog paramVO
			, HttpServletRequest request
			, Model model 
			) throws Exception{
		 
		
		/** =================== paging 시작 ============================== */
		PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
        paginationInfo.setPageSize(paramVO.getPageSize());
       
        paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
        paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        int totCnt = loginLogService.selectMngrLoginLogInfoCnt(paramVO);
        paginationInfo.setTotalRecordCount(totCnt);
		
        /** =================== paging 끝 =============================== */
		
		List<LoginLog> siteMngrLoginLogList = loginLogService.selectMngrLoginLogInfoList(paramVO);
		
		SysMngrSiteInfoVO sysMngrSiteInfoVO = new SysMngrSiteInfoVO();
		
		sysMngrSiteInfoVO.setFirstIndex(0);
		sysMngrSiteInfoVO.setRecordCountPerPage(100000);
		List<SysMngrSiteInfoVO> siteInfoList = siteInfoService.selectSiteInfoList(sysMngrSiteInfoVO);
		
		/* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
		
		model.addAttribute("siteInfoList", siteInfoList);
		model.addAttribute("mngrLoginlogList", siteMngrLoginLogList);
		
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "/wzwg/site/mngr/usrMngr/usrLog/siteMngrLoginLogList";
	}
}
