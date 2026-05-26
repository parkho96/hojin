package egovframework.wzwg.sysMngr.siteMngr.siteStplat.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeVO;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoVO;

/**
 * ㅁ 시스템 - 사이트약관정보관리
 * ㅁ DC   
 * - 시스템관리자가 각 사이트 약관정보을 관리
 * - 전체 시스템에서 사용할 약관정보 관리
 * @author HyoJuNiRaNe
 *
 */
@Controller
public class SiteStplatInfoController {

    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
	
	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;

	@Resource(name="SiteStplatInfoService")
	private SiteStplatInfoService siteStplatInfoService;

    /**
     * 약관정보유형코드
     * @return 코드 목록
     * @throws Exception 
     */
    @ModelAttribute("stplatInfoTyCodeList")
    public List<CmmCodeVO> getStplatInfoTyCodeList() throws Exception {
    	
    	String grpCode = "STPLAT_TY_CODE";
    	
    	List<CmmCodeVO> resultCodeLIst = codeService.selectCmmCodeList(grpCode);
    	
        return resultCodeLIst;
    }

	/**
	 * ㅁ 시스템 - 사이트 약관정보 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/siteMngr/siteStplat/info/selectStplatInfoList.do","/{siteKey}/**/siteMngr/siteStplat/info/selectStplatInfoList.do"})
	public String selectSiteStplatInfoList(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
        
        String siteSeq = StringUtils.defaultString(paramVO.getSiteSeq());
        
        // 시스템 관리자 - 사이트 관리자에 따른 사이트SEQ 설정
        if ("".equals(siteSeq)) {
            
            if (!CmmSessionUtil.getSessionSysMngrAt(request)) {
                siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
                
                paramVO.setSiteSeq(siteSeq);
            }
        } else {
            model.addAttribute("siteSeq", paramVO.getSiteSeq());   
        }

		paramVO.setPageUnit(propertyService.getInt("pageUnit"));
		paramVO.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
		paginationInfo.setPageSize(paramVO.getPageSize());

		paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
		paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		// 사이트 약관정보 목록
		List<SiteStplatInfoVO> resultList = siteStplatInfoService.selectSiteStplatInfoList(paramVO);
		
		// 사이트 약관정보 목록
		Integer resultCnt = siteStplatInfoService.selectSiteStplatInfoListCnt(paramVO);
		
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
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "wzwg/sysMngr/siteMngr/siteStplat/info/stplatInfoList";
	}

	/**
	 * ㅁ 시스템 - 사이트 등록 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/siteMngr/siteStplat/info/selectStplatInfoForm.do","/{siteKey}/**/siteMngr/siteStplat/info/selectStplatInfoForm.do"})
	public String selectSiteStplatInfoForm(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		
		return "wzwg/sysMngr/siteMngr/siteStplat/info/stplatInfoForm";
	}

	/**
	 * ㅁ 시스템 - 사이트 약관정보 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/siteStplat/info/registStplatInfoAjax.do")
	public ModelAndView registSiteStplatInfoAjax(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
			, HttpServletRequest request
			, ModelMap model) throws Exception{
		
		String siteSeq = StringUtils.defaultString(paramVO.getSiteSeq());
		
		paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
		paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
		
        // 시스템 관리자 - 사이트 관리자에 따른 사이트SEQ 설정
		if ("".equals(siteSeq)) {
		    
		    if (!CmmSessionUtil.getSessionSysMngrAt(request)) {
		        siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		        
		        paramVO.setSiteSeq(siteSeq);
		    }
		} else {
	        model.addAttribute("siteSeq", paramVO.getSiteSeq());   
		}
		
        // 사이트 약관정보 등록
        int result = siteStplatInfoService.registSiteStplatInfo(paramVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}

	}

	/**
	 * ㅁ 시스템 - 사이트 약관정보상세
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/siteMngr/siteStplat/info/selectStplatInfoDetail.do","/{siteKey}/**/siteMngr/siteStplat/info/selectStplatInfoDetail.do"})
	public String selectSiteStplatInfoDetail(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{

		// 상세데이터 가져옴
		SiteStplatInfoVO resultVO = siteStplatInfoService.selectSiteStplatInfoDetail(paramVO);

		model.addAttribute("resultVO", resultVO);
		
		return "wzwg/sysMngr/siteMngr/siteStplat/info/stplatInfoDetail";
	}

	/**
	 * ㅁ 시스템 - 사이트 약관정보 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/siteStplat/info/modifyStplatInfoAjax.do")
	public ModelAndView modifySiteStplatInfoAjax(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
			, HttpServletRequest request
			, ModelMap model) throws Exception{
		
		paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());

        // 사이트 약관정보 등록
        int result = siteStplatInfoService.modifySiteStplatInfo(paramVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ 시스템 - 사이트 약관정보 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/siteStplat/info/deleteStplatInfoAjax.do")
	public ModelAndView deleteSiteStplatInfoAjax(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
			, HttpServletRequest request
			, ModelMap model) throws Exception{
		
		paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());

        // 사이트 약관정보 등록
        int result = siteStplatInfoService.deleteSiteStplatInfo(paramVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
		
	
}
