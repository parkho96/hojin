package egovframework.wzwg.sysMngr.siteMngr.siteInfo.web;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.screen.service.SiteTemplateScreenService;
import egovframework.wzwg.site.mngr.screen.service.SiteTemplateScreenVO;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;
import egovframework.wzwg.sysMngr.screenMngr.template.service.SysMngrTemplateService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteTemplateInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteTemplateInfoVO;

/**
 * ㅁ 시스템 - 사이트정보관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
@Controller
public class SysMngrSiteTemplateInfoController {
 

	@Resource(name="SysMngrSiteTemplateInfoService")
	private SysMngrSiteTemplateInfoService siteTemplateInfoService;
	
	@Resource(name="SysMngrTemplateService")
	private SysMngrTemplateService sysMngrTemplateService;
	
	@Resource(name="SiteTemplateScreenService")
    private SiteTemplateScreenService siteTemplateScreenService;
	
	 
 
	@RequestMapping(value="/**/siteMngr/siteInfo/selectSiteTemplateInfoForm.do")
	public String selectSiteTemplateInfoForm(
			@ModelAttribute("paramVO") SysMngrSiteTemplateInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		// 수정일때 siteSeq 존재함
		String siteSeq = StringUtils.defaultString(paramVO.getSiteSeq());
		paramVO.setSiteSeq(siteSeq);
		//paramVO.setSysmngrAt("Y");
		 
		String layoutSeCode = paramVO.getLayoutSeCode();
		SiteTemplateScreenVO screenVO = new SiteTemplateScreenVO();
		paramVO.setLayoutSeCode(layoutSeCode);
		screenVO.setLayoutSeCode(layoutSeCode);
		
		model.addAttribute("templtList", siteTemplateInfoService.selectTemplateList(paramVO));
		model.addAttribute("layoutList", siteTemplateScreenService.selectSiteTemplateLayoutScreenList(screenVO));
		paramVO.setSiteSeq("Y");
		model.addAttribute("templateCtgryCode", sysMngrTemplateService.selectTemplateCategoryScreenList(paramVO));
		paramVO.setSiteSeq(siteSeq);
		model.addAttribute("paramVO", paramVO);
		
		return "wzwg/sysMngr/siteMngr/siteInfo/siteTemplateInfoForm";
	}
	
	@RequestMapping(value="/**/siteMngr/siteInfo/registSiteTemplateInfo.do")
	public String registSiteTemplateInfo(
			@ModelAttribute("paramVO") SysMngrSiteTemplateInfoVO paramVO
			, HttpServletRequest request
			, ModelMap model
		) throws Exception{
		
		paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
		paramVO.setFrstRegisterIp(request.getRemoteAddr());
		
		// 사이트 정보 등록
		siteTemplateInfoService.registSiteTemplateInfo(paramVO);
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		
		return "forward:"+wzwgContext+CmmSessionUtil.getSessionMngrSitePrefix(request)+"/siteMngr/siteInfo/selectSiteTemplateInfoForm.do";
	}


}
