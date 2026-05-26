package egovframework.wzwg.sysMngr.siteMngr.siteGroup.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;
import egovframework.wzwg.sysMngr.siteMngr.siteGroup.service.SiteGroupService;
import egovframework.wzwg.sysMngr.siteMngr.siteGroup.service.SiteGroupVO;

/**
 * ㅁ 시스템 - 사이트그룹관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
@Controller
public class SiteGroupController {

    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

	@Resource(name="SiteGroupService")
	private SiteGroupService siteGroupService;
	
	/**
	 * ㅁ 시스템 - 사이트 그룹 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sysMngr/siteMngr/siteGroup/selectSiteGroupList.do")
	public String selectSiteGroupList(@ModelAttribute("paramVO") SiteGroupVO paramVO
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
		
		// 사이트 그룹 목록
		List<SiteGroupVO> resultList = siteGroupService.selectSiteGroupList(paramVO);
		
		// 사이트 그룹 목록
		Integer resultCnt = siteGroupService.selectSiteGroupListCnt(paramVO);
		
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
		
		return "wzwg/sysMngr/siteMngr/siteGroup/siteGroupList";
	}

	/**
	 * ㅁ 시스템 - 사이트 등록 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sysMngr/siteMngr/siteGroup/selectSiteGroupForm.do")
	public String selectSiteGroupForm(@ModelAttribute("paramVO") SiteGroupVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		
		// 수정일때 siteSeq 존재함
		String sitegrpSeq = StringUtils.defaultString(paramVO.getSitegrpSeq());
		
		if (!"".equals(sitegrpSeq)) {
			// 수정일경우 상세데이터 가져옴
			SiteGroupVO resultVO = siteGroupService.selectSiteGroupDetail(paramVO);

			// 2차 그룹 목록
			String upperGrpSeq = StringUtils.defaultString(resultVO.getSitegrpSeq());
			
			paramVO.setUpperGrpSeq(upperGrpSeq);

	        // 사이트 2차 그룹 목록
	        List<SiteGroupVO> resultList = siteGroupService.selectSiteGroupMlsfcList(paramVO);
			
			model.addAttribute("resultVO", resultVO);
            model.addAttribute("resultList", resultList);
		} else {
		    SiteGroupVO resultVO = new SiteGroupVO();
		    resultVO.setUpperGrpSeq(paramVO.getUpperGrpSeq());
		    
			model.addAttribute("resultVO", resultVO);
		}
		model.addAttribute("paramVO", paramVO);
		
		return "wzwg/sysMngr/siteMngr/siteGroup/siteGroupForm";
	}

	/**
	 * ㅁ 시스템 - 사이트 그룹 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sysMngr/siteMngr/siteGroup/registSiteGroup.do")
	public String registSiteGroup(@ModelAttribute("paramVO") SiteGroupVO paramVO
			, HttpServletRequest request
			, ModelMap model) throws Exception{
		
		paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
		paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
		
		// 사이트 그룹 등록
		siteGroupService.registSiteGroup(paramVO);

        String odr = StringUtils.defaultString(paramVO.getOdr());

		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
        if ("2".equals(odr)) {
            // 2차 수정 완료시 1차 상세보기로 보내려고 셋팅
            return "forward:"+wzwgContext+"/sysMngr/siteMngr/siteGroup/selectSiteGroupMlsfcForm.do";
        } else {
            return "redirect:"+wzwgContext+"/sysMngr/siteMngr/siteGroup/selectSiteGroupList.do";
        }
		
	}

	/**
	 * ㅁ 시스템 - 사이트 그룹 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sysMngr/siteMngr/siteGroup/modifySiteGroup.do")
	public String modifySiteGroup(@ModelAttribute("paramVO") SiteGroupVO paramVO
			, HttpServletRequest request
			, ModelMap model) throws Exception{
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		
		paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
		
		// 사이트 그룹 등록
		siteGroupService.modifySiteGroup(paramVO);
		
		String odr = StringUtils.defaultString(paramVO.getOdr());
		
		if ("2".equals(odr)) {
		    // 2차 수정 완료시 1차 상세보기로 보내려고 셋팅
            return "forward:"+wzwgContext+"/sysMngr/siteMngr/siteGroup/selectSiteGroupMlsfcForm.do";
		} else {
		    return "forward:"+wzwgContext+"/sysMngr/siteMngr/siteGroup/selectSiteGroupForm.do";
		}
		
	}

    /**
     * ㅁ 시스템 - 사이트 그룹 등록 폼
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/sysMngr/siteMngr/siteGroup/selectSiteGroupMlsfcForm.do")
    public String selectSiteGroupMlsfcForm(@ModelAttribute("paramVO") SiteGroupVO paramVO
            , HttpServletRequest request 
            , ModelMap model) throws Exception{

        // 2차 수정 완료시 1차 상세보기로 보내려고 셋팅
        paramVO.setSitegrpSeq(paramVO.getUpperGrpSeq());
    
        // 수정일경우 상세데이터 가져옴
        SiteGroupVO resultVO = siteGroupService.selectSiteGroupDetail(paramVO);

        // 2차 그룹 목록
        String upperGrpSeq = StringUtils.defaultString(resultVO.getSitegrpSeq());
        
        paramVO.setUpperGrpSeq(upperGrpSeq);

        // 사이트 2차 그룹 목록
        List<SiteGroupVO> resultList = siteGroupService.selectSiteGroupMlsfcList(paramVO);
        
        model.addAttribute("resultVO", resultVO);
        model.addAttribute("resultList", resultList);
        model.addAttribute("paramVO", paramVO);
        
        return "wzwg/sysMngr/siteMngr/siteGroup/siteGroupForm";
    }
    
    /**
     * ㅁ  시스템 - 사이트 그룹 목록(selectbox)
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/**/siteMngr/siteGroup/selectSiteGroupMlsfcAjax.do")
    public ModelAndView selectSiteGroupMlsfcAjax(
            @ModelAttribute("paramVO") SiteGroupVO paramVO
            , @RequestParam(value="searchBbsSeq", required=false) String searchBbsSeq
            , HttpServletRequest request
        ) throws Exception {
        
        List<SiteGroupVO> subospecList = siteGroupService.selectSiteGroupAjax(paramVO);
        
        return CmmAjaxUtil.getAjaxReturnList(subospecList, "sitegrpSeq", "groupNm", true);
    }
	
}
