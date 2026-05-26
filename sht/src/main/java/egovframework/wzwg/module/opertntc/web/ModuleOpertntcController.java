package egovframework.wzwg.module.opertntc.web;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteOpertNtcService;
import egovframework.wzwg.sysMngr.siteMngr.siteOpert.service.SysMngrSysOpertNtcService;
import egovframework.wzwg.sysMngr.siteMngr.siteOpert.service.SysMngrSysOpertNtcVO;

@Controller
public class ModuleOpertntcController {

    /** 시스템 작업관리 */
    @Resource(name="SysOpertNtcService")
    private SysMngrSysOpertNtcService sysOpertNtcService;
    
    /** 사이트 작업관리 */
    @Resource(name="SysMngrSiteOpertNtcService")
    private SysMngrSiteOpertNtcService siteOpertNtcService;

    /**
     * @Method Name : selectSiteOpertntcDetail
     * @Method 설명 : 시스템 작업 출력
     */
    @RequestMapping(value= {"/opertntc/selectSysOpertntcDetail.do","/{siteKey}/opertntc/selectSysOpertntcDetail.do"})
    public String selectSysOpertntcDetail(
            HttpServletRequest request
            , Model model ) {
        
        SysMngrSysOpertNtcVO sysOpertNtcVO = new SysMngrSysOpertNtcVO();

        sysOpertNtcVO.setSiteLclasGroup(CmmSessionUtil.getSessionValue(request, "SITE_LCLAS_GROUP"));
        sysOpertNtcVO.setSiteMlsfcGroup(CmmSessionUtil.getSessionValue(request, "SITE_MLSFC_GROUP"));
        
        SysMngrSysOpertNtcVO resultVO = sysOpertNtcService.selectConectCtrlSysOpertntc(sysOpertNtcVO);

        model.addAttribute("resultVO", resultVO);
        
        return "wzwg/module/opertntc/opertntcDetail";
    }
    
    /**
     * @Method Name : selectSiteOpertntcDetail
     * @Method 설명 : 사이트 작업 출력
     */
    @RequestMapping(value= {"/opertntc/selectSiteOpertntcDetail.do","/{siteKey}/opertntc/selectSiteOpertntcDetail.do"})
    public String selectSiteOpertntcDetail(
            HttpServletRequest request
            , Model model ) {

        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        
        SysMngrSiteInfoVO resultVO = siteOpertNtcService.selectConectCtrlSiteOpertntc(siteSeq);

        model.addAttribute("resultVO", resultVO);
        
        return "wzwg/module/opertntc/opertntcDetail";
    }
    
    @RequestMapping(value= {"/opertntc/selectSiteAblEnnc.do","/{siteKey}/opertntc/selectSiteAblEnnc.do"})
    public String selectSiteAblEnnc(
            HttpServletRequest request
            , Model model ) {

        return "wzwg/module/opertntc/ablEnncDetail";
    }
	
}
