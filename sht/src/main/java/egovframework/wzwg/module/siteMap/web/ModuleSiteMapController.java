package egovframework.wzwg.module.siteMap.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuService;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuVO;

@Controller
public class ModuleSiteMapController {

	@Resource(name="SiteMenuService")
	private SiteMenuService siteMenuService;
	
	/**
	 * 사이트맵 리스트조회
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value= {"/module/siteMap/selectSiteMapList.do","/{siteKey}/module/siteMap/selectSiteMapList.do"})
	public String selectSiteMapList( 
			@ModelAttribute("paramVO") SiteMenuVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception{

		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		List<SiteMenuVO> menuList = siteMenuService.selectSiteMenuList(paramVO);
		
		model.addAttribute("menuList", menuList);
		
		return "wzwg/module/siteMap/siteMapList";
	}
	
}
