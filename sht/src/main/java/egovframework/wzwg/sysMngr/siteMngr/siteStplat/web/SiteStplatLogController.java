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
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatLogService;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatLogVO;

/**
 * ㅁ 시스템 - 사이트약관정보관리
 * ㅁ DC   
 * - 시스템관리자가 각 사이트 약관정보을 관리
 * - 전체 시스템에서 사용할 약관정보 관리
 * @author HyoJuNiRaNe
 *
 */
@Controller
public class SiteStplatLogController {

    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
	
	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;

	@Resource(name="SiteStplatLogService")
	private SiteStplatLogService siteStplatLogService;

    @RequestMapping(value="/**/siteMngr/siteStplat/log/selectStplatLogList.do")
    public String selectSiteStplatInfoList(@ModelAttribute("paramVO") SiteStplatLogVO paramVO
            , HttpServletRequest request 
            , ModelMap model) throws Exception{
        
        String siteSeq = StringUtils.defaultString(paramVO.getSiteSeq());
        
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
        List<SiteStplatLogVO> resultList = siteStplatLogService.selectSiteStplatLogList(paramVO);
        
        // 사이트 약관정보 목록
        Integer resultCnt = siteStplatLogService.selectSiteStplatLogListCnt(paramVO);
        
        paginationInfo.setTotalRecordCount(resultCnt.intValue());
        
        model.addAttribute("resultList", resultList);
        model.addAttribute("resultCnt", resultCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "wzwg/sysMngr/siteMngr/siteStplat/log/stplatLogList";
    }

    @RequestMapping(value="/**/siteMngr/siteStplat/log/selectStplatLogDetailPopup.do")
    public String selectSiteStplatInfoDetail(@ModelAttribute("paramVO") SiteStplatLogVO paramVO
            , HttpServletRequest request 
            , ModelMap model) throws Exception{
        
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);

        // 사이트 약관정보 목록
        List<SiteStplatLogVO> resultList = siteStplatLogService.selectSiteStplatLog(paramVO);
        
        model.addAttribute("resultList", resultList);
        
        return "wzwg/sysMngr/siteMngr/siteStplat/log/stplatLogDetail";
    }

    @RequestMapping(value="/**/siteMngr/siteStplat/log/deleteSiteStplatLog.do")
    public ModelAndView deleteSiteStplatLog(@ModelAttribute("paramVO") SiteStplatLogVO paramVO
            , HttpServletRequest request) throws Exception{
        
        int result = siteStplatLogService.deleteSiteStplatLog(paramVO);
        
        return CmmAjaxUtil.getAjaxReturnCmmMap(result);
    }
}
