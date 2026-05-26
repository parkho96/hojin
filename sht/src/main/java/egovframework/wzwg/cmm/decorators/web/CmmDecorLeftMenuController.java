package egovframework.wzwg.cmm.decorators.web;

import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoService;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.site.mngr.menu.service.SiteMngrMenuService;
import egovframework.wzwg.site.mngr.menu.service.SiteMngrMenuVO;

@Controller
public class CmmDecorLeftMenuController {
    
    @Resource(name="CntntsInfoService")
    private CntntsInfoService cntntsInfoService;
    
	@Resource(name="siteMngrMenuService")
	private SiteMngrMenuService siteMngrMenuService;
    
    @RequestMapping(value= {"/{siteKey}/cmm/decorators/leftMenu/selectCntntsMngr.do","/cmm/decorators/leftMenu/selectCntntsMngr.do"})
    public String selectCntntsMngr(
            HttpServletRequest request 
            , ModelMap model) throws Exception {
        
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        
        List<CntntsInfoVO> resultList = cntntsInfoService.selectCntntsInfoAllList(siteSeq);
        
        model.addAttribute("decoLeftMenu", resultList);
        
        return "wzwg/cmm/decorators/leftMenu/cntntsMngr";
    }
    
    @RequestMapping(value= {"/{siteKey}/cmm/decorators/leftMenu/selectMngrMenu.do","/cmm/decorators/leftMenu/selectMngrMenu.do"})
    public String selectMngrMenu(
            HttpServletRequest request 
            , ModelMap model) throws Exception {
        
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        
        String usrSeq = CmmSessionUtil.getLoginVO().getUsrSeq();
        boolean sadminAt =  CmmSessionUtil.getSessionBooleanValue(request, "SADMIN_AT");
        
        SiteMngrMenuVO siteMngrMenuVO = new SiteMngrMenuVO();
        siteMngrMenuVO.setSiteSeq(siteSeq);
        siteMngrMenuVO.setUsrSeq(usrSeq); 
        if(sadminAt) {
        	siteMngrMenuVO.setSysmngrAt("Y");
        }else {
        	siteMngrMenuVO.setSysmngrAt("N");
        }
 
        Map<String, Object> siteMenuList = siteMngrMenuService.selectSiteMenuMngrLeftList(siteMngrMenuVO);
		
		model.addAttribute("resultList", siteMenuList);
        
        return "wzwg/cmm/decorators/leftMenu/mngrMenu";
    }
}
