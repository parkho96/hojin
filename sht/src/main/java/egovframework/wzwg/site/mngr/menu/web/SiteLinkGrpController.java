package egovframework.wzwg.site.mngr.menu.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.menu.service.SiteLinkGrpInfoService;
import egovframework.wzwg.site.mngr.menu.service.SiteLinkGrpInfoVO;
import egovframework.wzwg.site.mngr.menu.service.SiteLinkInfoService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;

@Controller
public class SiteLinkGrpController {
    
    @Resource(name="LinkGrpInfoService")
    private SiteLinkGrpInfoService linkGrpInfoService;
    
    @Resource(name="LinkInfoService")
    private SiteLinkInfoService linkInfoService;
    
    @Resource(name="CmmCodeService")
    private CmmCodeService codeService;

    @RequestMapping(value={"/**/menu/linkGrp/selectLinkGrpList.do","/{siteKey}/**/menu/linkGrp/selectLinkGrpList.do"})
    public String selectLinkGrpList(
            @ModelAttribute("paramVO") SiteLinkGrpInfoVO paramVO
            , HttpServletRequest request
            , Model model
            ){
        
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
        paginationInfo.setPageSize(paramVO.getPageSize());
       
        paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
        paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        Integer totCnt = linkGrpInfoService.selectLinkGrpInfoListCnt(paramVO);
        paginationInfo.setTotalRecordCount(totCnt.intValue());
        
        /* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
        
        List<SiteLinkGrpInfoVO> resultList = linkGrpInfoService.selectLinkGrpInfoList(paramVO);
        
        model.addAttribute("resultList", resultList);
        model.addAttribute("totCnt", totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "wzwg/site/mngr/menu/linkGrp/linkGrpList";
    }

    @RequestMapping(value={"/**/menu/linkGrp/selectLinkGrpForm.do","/{siteKey}/**/menu/linkGrp/selectLinkGrpForm.do"})
    public String selectLinkGrpForm(
            @ModelAttribute("paramVO") SiteLinkGrpInfoVO paramVO
            , HttpServletRequest request
            , Model model
            ) throws Exception{
        
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        
        String linkGrpInfoSeq = StringUtils.defaultString(paramVO.getLinkGrpSeq());
        
        if (!"".equals(linkGrpInfoSeq)) {
            SiteLinkGrpInfoVO resultVO = linkGrpInfoService.selectLinkGrpInfoDetail(paramVO);

            model.addAttribute("resultVO", resultVO);
            
            List<SiteLinkGrpInfoVO> linkGrpList = linkInfoService.selectLinkInfoList(paramVO);
            
            model.addAttribute("linkGrpList", linkGrpList);
        } else {
            model.addAttribute("resultVO", new SiteLinkGrpInfoVO());
        }
        
        model.addAttribute("linkTyCodeList", codeService.selectCmmCodeList("HDFTRMENU_TY_CODE"));
        
        return "wzwg/site/mngr/menu/linkGrp/linkGrpForm";
    }

    @RequestMapping(value="/**/menu/linkGrp/registLinkGrpInfo.do")
    public String registLinkGrpInfo(
            @ModelAttribute("paramVO") SiteLinkGrpInfoVO paramVO
            , HttpServletRequest request
            , Model model
            ){
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
        
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        paramVO.setUserId(CmmSessionUtil.getSessionUserId());
        
        int result = linkGrpInfoService.registLinkGrpInfo(paramVO);
        
        if (result > 0) {
            model.addAttribute("retMsg", "success");
        } else {
            model.addAttribute("retMsg", "fail");
        }
        
        return "redirect:"+wzwgContext+CmmSessionUtil.getSessionMngrSitePrefix(request)+"/menu/linkGrp/selectLinkGrpList.do";
    }

    @RequestMapping(value="/**/menu/linkGrp/modifyLinkGrpInfo.do")
    public String modifyLinkGrpInfo(
            @ModelAttribute("paramVO") SiteLinkGrpInfoVO paramVO
            , HttpServletRequest request
            , Model model
            ){

		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        paramVO.setUserId(CmmSessionUtil.getSessionUserId());
        
        int result = linkGrpInfoService.modifyLinkGrpInfo(paramVO);
        
        if (result > 0) {
            model.addAttribute("retMsg", "success");
        } else {
            model.addAttribute("retMsg", "fail");
        }
        
        return "forward:"+wzwgContext+CmmSessionUtil.getSessionMngrSitePrefix(request)+"/menu/linkGrp/selectLinkGrpForm.do";
    }

    @RequestMapping(value="/**/menu/linkGrp/deleteLinkGrpInfo.do")
    public String deleteLinkGrpInfo(
            @ModelAttribute("paramVO") SiteLinkGrpInfoVO paramVO
            , HttpServletRequest request
            , Model model
            ){

		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        paramVO.setUserId(CmmSessionUtil.getSessionUserId());
        
        int result = linkGrpInfoService.deleteLinkGrpInfo(paramVO);
        
        if (result > 0) {
            model.addAttribute("retMsg", "success");
        } else {
            model.addAttribute("retMsg", "fail");
        }

        return "redirect:"+wzwgContext+CmmSessionUtil.getSessionMngrSitePrefix(request)+"/menu/linkGrp/selectLinkGrpList.do";
    }
	
}
