package egovframework.wzwg.site.mngr.cmnt.web;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntCfgService;
import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntCfgVO;
import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;

@Controller
public class SiteCmntCfgController {
	
	@Resource(name="SiteCmntCfgService")
	private SiteCmntCfgService siteCmntCfgService;
	  
    
    @Resource(name="CmmCodeService")
    private CmmCodeService codeService;
    
	
	@Resource(name="SiteUsrGroupService")
	SiteUsrGroupService siteUsrGroupService;
      
    
    @RequestMapping(value={"/mngr/cmnt/config/selectCmntCfgForm.do","/{siteKey}/mngr/cmnt/config/selectCmntCfgForm.do"})
	public String selectCmntCfgForm (
		@ModelAttribute("paramVO") SiteCmntCfgVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		 SiteCmntCfgVO resultVO = siteCmntCfgService.selectSiteCmntCfg(paramVO);
		 
		
		model.addAttribute("usrgroupList", siteUsrGroupService.selectSiteUsrGroupCode(siteSeq));
    	model.addAttribute("estblCodeList", codeService.selectCodeInfoList("CMNT_ESTBL_CODE"));
    	model.addAttribute("appvlCodeList", codeService.selectCodeInfoList("CMNT_APPVL_CODE"));
    	model.addAttribute("resultVO",siteCmntCfgService.selectSiteCmntCfg(paramVO));
    	model.addAttribute("groupList",siteCmntCfgService.selectSiteCmntCfgroupList(paramVO));
		return "wzwg/site/mngr/cmnt/cmntCfgForm";
	}
    
    @RequestMapping(value= {"/mngr/cmnt/config/modifyCmntCfgForm.do","/{siteKey}/mngr/cmnt/config/modifyCmntCfgForm.do"})
   	public String modifyCmntCfgForm (
   		@ModelAttribute("paramVO") SiteCmntCfgVO paramVO
   		, HttpServletRequest request
   		, Model model ) throws Exception {
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
   		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
   		paramVO.setSiteSeq(siteSeq);
   		siteCmntCfgService.deleteSiteCmntCfgroup(paramVO); 
   		if(paramVO.getUsrgroupSeqArry() != null){
   		for(int i=0;i<paramVO.getUsrgroupSeqArry().length;i++){
   			paramVO.setUsrgroupSeq(paramVO.getUsrgroupSeqArry()[i]);
   			siteCmntCfgService.registSiteCmntCfgroup(paramVO);
   		}
   		}
   		siteCmntCfgService.modifySiteCmntCfg(paramVO);
   		return "redirect:"+wzwgContext+"/mngr/cmnt/config/selectCmntCfgForm.do";
   	}
}
