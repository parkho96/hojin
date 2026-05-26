package egovframework.wzwg.module.drctns.web;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.drctns.service.ModuleDirectionsVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoVO;

@Controller
public class ModuleDirectionsController {

	@Resource(name="SysMngrSiteInfoService")
	private SysMngrSiteInfoService siteInfoService;
	
	/**
	 * 찾아오시는길 - 사용자
	 * 
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value= {"/selectModuleDirectionsDetail.do","/{siteKey}/selectModuleDirectionsDetail.do"})
	public String selectModuleDirectionsDetail(
			@ModelAttribute("paramVO")ModuleDirectionsVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception{
		
		
		SysMngrSiteInfoVO siteInfoVO = new SysMngrSiteInfoVO();
		siteInfoVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		SysMngrSiteInfoVO resultVO = siteInfoService.selectSiteInfoDetail(siteInfoVO);
		
		model.addAttribute("resultVO", resultVO);
		
		return "/wzwg/module/drctns/directionsDetail";
	}
	
}
