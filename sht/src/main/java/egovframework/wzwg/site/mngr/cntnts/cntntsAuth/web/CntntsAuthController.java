package egovframework.wzwg.site.mngr.cntnts.cntntsAuth.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthService;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthVO;

@Controller
public class CntntsAuthController {
    
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

    @Resource(name="CntntsAuthService")
    protected CntntsAuthService cntntsAuthService;
    
    @RequestMapping(value="/**/cntnts/cntntsAuth/selectCntntsAuthListAjax.do")
    public String selectCntntsAuthList (
        @ModelAttribute("paramVO") CntntsAuthVO paramVO
        , HttpServletRequest request
        , Model model ) throws Exception {
        
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        
        paramVO.setSiteSeq(siteSeq);
        
        String baseUsrgroupSeq = Globals.BASE_SITE_USRGROUPSEQ;

        String[] baseUsrgroupArr = baseUsrgroupSeq.split(":");
        
        paramVO.setNmbrUsrGroupSeq(baseUsrgroupArr);
        
        List<CntntsAuthVO> resultList = cntntsAuthService.selectCntntsAuthList(paramVO);
        
        CntntsAuthVO writeAuthVO =   cntntsAuthService.selectWriteAuthAt(paramVO);
        
        model.addAttribute("baseUsrgroupSeq", baseUsrgroupSeq);
        model.addAttribute("paramVO", paramVO);
        model.addAttribute("writeAuthAt", writeAuthVO.getWriteAuthAt());
        
        model.addAttribute("resultList", resultList);
        
        return "wzwg/site/mngr/cntnts/cntntsAuth/cntntsAuthList";
    }
    
    @RequestMapping(value="/**/cntnts/cntntsAuth/registCntntsAuth.do")
    public ModelAndView registCntntsAuth (
        @ModelAttribute("paramVO") CntntsAuthVO paramVO
        , HttpServletRequest request
        , Model model ) throws Exception {
        
        paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
        
        int retVal = cntntsAuthService.registCntntsAuth(paramVO);
        
        return CmmAjaxUtil.getAjaxReturnCmmMap(retVal);
    }
    
}
