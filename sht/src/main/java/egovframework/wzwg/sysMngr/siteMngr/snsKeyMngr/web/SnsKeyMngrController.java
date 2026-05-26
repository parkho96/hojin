package egovframework.wzwg.sysMngr.siteMngr.snsKeyMngr.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.sysMngr.siteMngr.snsKeyMngr.service.SnsKeyMngrService;
import egovframework.wzwg.sysMngr.siteMngr.snsKeyMngr.service.SnsKeyMngrVO;

@Controller
public class SnsKeyMngrController {
    
    @Resource(name="SnsKeyMngrService")
    protected SnsKeyMngrService snsKeyMngrService;

    @RequestMapping(value={"/**/siteMngr/snsKeyMngr/selectSnsKeyMngr.do","/{siteKey}/**/siteMngr/snsKeyMngr/selectSnsKeyMngr.do"})
    public String selectSnsKeyMngr(@ModelAttribute("paramVO") SnsKeyMngrVO paramVO
            , HttpServletRequest request 
            , ModelMap model) throws Exception{

        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        
        List<SnsKeyMngrVO> resultList = snsKeyMngrService.selectSnsKeyMngrList(paramVO);
        
        model.addAttribute("resultList", resultList);

        return "wzwg/sysMngr/siteMngr/snsKeyMngr/snsKeyMngrDetail";
    }

    @RequestMapping(value="/**/siteMngr/snsKeyMngr/registSnsKeyMngrAjax.do")
    public ModelAndView registSnsKeyMngrAjax(@ModelAttribute("paramVO") SnsKeyMngrVO paramVO
            , HttpServletRequest request
            , ModelMap model) throws Exception{
        
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
        
        int result = snsKeyMngrService.registSnsKeyMngr(paramVO);
        
        return CmmAjaxUtil.getAjaxReturnCmmMap(result);
    }
}
