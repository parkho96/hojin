package egovframework.wzwg.sysMngr.siteMngr.siteInfo.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

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
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteDomnService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteDomnVO;

/**
 * ㅁ 시스템 - 사이트도메인관리
 * ㅁ DC   
 * - 사이트 도메인 관리
 * @author HyoJuNiRaNe
 *
 */
@Controller
public class SysMngrSiteDomnController {

    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
	
	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;

	@Resource(name="SysMngrSiteDomnService")
	private SysMngrSiteDomnService siteDomnService;

    /**
     * 도메인구분코드
     * @return 코드 목록
     * @throws Exception 
     */
    @ModelAttribute("domnSeCodeList")
    public List<CmmCodeVO> getSiteClCodeList() throws Exception {
    	
    	String grpCode = "DOMN_SE_CODE";
    	
    	List<CmmCodeVO> resultCodeLIst = codeService.selectCmmCodeList(grpCode);
    	
        return resultCodeLIst;
    }

    /**
     * 사용언어코드
     * @return 코드 목록
     * @throws Exception 
     */
    @ModelAttribute("useLangCodeList")
    public List<CmmCodeVO> getUseLangCodeList() throws Exception {
    	
    	String grpCode = "USE_LANG_CODE";
    	
    	List<CmmCodeVO> resultCodeLIst = codeService.selectCmmCodeList(grpCode);
    	
        return resultCodeLIst;
    }
	
	/**
	 * ㅁ 시스템 - 사이트 정보 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/siteMngr/siteInfo/selectSiteDomnList.do","/${siteSeq}/**/siteMngr/siteInfo/selectSiteDomnList.do"})
	public String selectSiteInfoList(@ModelAttribute("paramVO") SysMngrSiteDomnVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{

		paramVO.setPageUnit(propertyService.getInt("pageUnit"));
		paramVO.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
		paginationInfo.setPageSize(paramVO.getPageSize());

		paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
		paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		// 사이트 정보 목록
		List<SysMngrSiteDomnVO> resultList = siteDomnService.selectSiteDomnList(paramVO);
		
		// 사이트 정보 목록
		Integer resultCnt = siteDomnService.selectSiteDomnListCnt(paramVO);
		
		paginationInfo.setTotalRecordCount(resultCnt.intValue());
		
		// 수정일경우 상세데이터 가져옴
		SysMngrSiteDomnVO resultVO = siteDomnService.selectSiteDomnDetail(paramVO);
		resultVO = (resultVO != null)? resultVO: new SysMngrSiteDomnVO();
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", resultCnt);
		model.addAttribute("resultVO", resultVO);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "wzwg/sysMngr/siteMngr/siteInfo/siteDomnList";
	}

	/**
	 * ㅁ 시스템 - 사이트 도메인 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/siteInfo/registSiteDomn.do")
	public String registSiteDomn(@ModelAttribute("paramVO") SysMngrSiteDomnVO paramVO
			, HttpServletRequest request
			, ModelMap model) throws Exception{
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);

		// 사이트 도메인 등록
		siteDomnService.registSiteDomn(paramVO);
		
		return "forward:"+wzwgContext+CmmSessionUtil.getSessionMngrSitePrefix(request)+"/siteMngr/siteInfo/selectSiteDomnList.do";
	}

	/**
	 * ㅁ 시스템 - 사이트 도메인 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/siteInfo/deleteSiteDomn.do")
	public String deleteSiteDomn(@ModelAttribute("paramVO") SysMngrSiteDomnVO paramVO
			, HttpServletRequest request
			, ModelMap model) throws Exception{
		
		paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
		
		// 사이트 도메인 등록
		siteDomnService.deleteSiteDomn(paramVO);
		
		return "forward:"+CmmSessionUtil.getSessionMngrSitePrefix(request)+"/siteMngr/siteInfo/selectSiteDomnList.do";
	}

	/**
	 * ㅁ 시스템 - 사이트 대표 도메인 설정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/siteInfo/modifySiteReprsntDomnAjax.do")
	public ModelAndView registSiteReprsntDomn(@ModelAttribute("paramVO") SysMngrSiteDomnVO paramVO
			, HttpServletRequest request
			, ModelMap model) throws Exception{
		
		paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
		
		int result = siteDomnService.modifySiteReprsntDomn(paramVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	

	/**
	 * ㅁ 시스템 - 사이트 도메인 중복체크
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/siteInfo/selectSiteDomnDplctChkAjax.do")
	public ModelAndView selectSiteDomnDplctChkAjax(@ModelAttribute("paramVO") SysMngrSiteDomnVO paramVO
			, HttpServletRequest request
			, ModelMap model) throws Exception{
		
		
		paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
		
		int result = siteDomnService.selectSiteDomnDplctChk(paramVO);
		
		if(result < 1){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
}
