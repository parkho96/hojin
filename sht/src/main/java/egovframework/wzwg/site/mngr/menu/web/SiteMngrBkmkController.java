package egovframework.wzwg.site.mngr.menu.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.menu.service.SiteMngrBkmkService;
import egovframework.wzwg.site.mngr.menu.service.SiteMngrBkmkVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class SiteMngrBkmkController {
	
	@Resource(name="siteMngrBkmkService")
	private SiteMngrBkmkService siteMngrBkmkService; 
	
	@RequestMapping(value={"/mngr/menu/bkmk/selectSiteMngrBkmkList.do","/{siteKey}/mngr/menu/bkmk/selectSiteMngrBkmkList.do"})
	public String selectSiteMenuMngrList(
		@ModelAttribute("paramVO")SiteMngrBkmkVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		model.addAttribute("resultList", siteMngrBkmkService.selectSiteMngrBkmkList(paramVO));
		return "wzwg/site/mngr/menu/siteMngrBkmkList";
	}
	
	@RequestMapping(value={"/mngr/menu/bkmk/selectSiteMngrMenuListAjax.do","/{siteKey}/mngr/menu/bkmk/selectSiteMngrMenuListAjax.do"})
	public String selectSiteMngrMenuListAjax(
		@ModelAttribute("paramVO")SiteMngrBkmkVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		model.addAttribute("mngrMenuList", siteMngrBkmkService.selectSiteMngrMenuList(paramVO));
		return "wzwg/site/mngr/menu/siteMngrMenuList";
	}
	
	@RequestMapping(value={"/mngr/menu/bkmk/registSiteMngrBkmkAjax.do","/{siteKey}/mngr/menu/bkmk/registSiteMngrBkmkAjax.do"})
	public ModelAndView registSiteMngrBkmkAjax(
		@ModelAttribute("paramVO")SiteMngrBkmkVO paramVO
		, HttpServletRequest request  ) throws Exception {
		
		ModelAndView  model =new  ModelAndView();
		model.setViewName("jsonView"); 
		/** 사이트 시퀀스 */
		CmmLoginVO loginVO = CmmSessionUtil.getLoginVO();
		paramVO.setFrstRegisterId(loginVO.getUserId());
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		siteMngrBkmkService.registSiteMngrBkmk(paramVO);
		model.addObject("result", "success");
		return model;
	}
	
	@RequestMapping(value={"/mngr/menu/bkmk/deleteSiteMngrBkmkAjax.do","/{siteKey}/mngr/menu/bkmk/deleteSiteMngrBkmkAjax.do"})
	public ModelAndView deleteSiteMngrBkmkAjax(
		@ModelAttribute("paramVO")SiteMngrBkmkVO paramVO
		, HttpServletRequest request  ) throws Exception {
		
		ModelAndView  model =new  ModelAndView();
		model.setViewName("jsonView"); 
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		siteMngrBkmkService.deleteSiteMngrBkmk(paramVO);
		model.addObject("result", "success");
		return model;
	}
	
	@RequestMapping(value={"/mngr/cmm/decorators/leftMenu/selectMngrBkmkMenu.do","/{siteKey}/mngr/cmm/decorators/leftMenu/selectMngrBkmkMenu.do"})
	public String selectMngrBkmkMenu(
		@ModelAttribute("paramVO")SiteMngrBkmkVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		model.addAttribute("resultList", siteMngrBkmkService.selectSiteMngrBkmkList(paramVO));
		return "wzwg/cmm/decorators/leftMenu/mngrBkmkMenu";
	}
	  
}
