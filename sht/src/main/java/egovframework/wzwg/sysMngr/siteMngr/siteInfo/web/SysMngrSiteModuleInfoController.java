package egovframework.wzwg.sysMngr.siteMngr.siteInfo.web;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteModuleInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteModuleInfoVO;

/**
 * ㅁ 시스템 - 사이트정보관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
@Controller
public class SysMngrSiteModuleInfoController {
 

	@Resource(name="SysMngrSiteModuleInfoService")
	private SysMngrSiteModuleInfoService siteModuleInfoService;
	 
 
	@RequestMapping(value="/**/siteMngr/siteInfo/selectSiteModuleInfoForm.do")
	public String selectSiteModuleInfoForm(@ModelAttribute("paramVO") SysMngrSiteModuleInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		
		// 수정일때 siteSeq 존재함
		String siteSeq = StringUtils.defaultString(paramVO.getSiteSeq());
		paramVO.setSiteSeq(siteSeq);
		 
		model.addAttribute("resultList",siteModuleInfoService.selectSiteModuleInfoList(paramVO));
		model.addAttribute("paramVO", paramVO);
		
		return "wzwg/sysMngr/siteMngr/siteInfo/siteModuleInfoForm";
	}
	
	@RequestMapping(value="/**/siteMngr/siteInfo/registSiteModuleInfo.do")
	public String registSiteModuleInfo(@ModelAttribute("paramVO") SysMngrSiteModuleInfoVO paramVO
			, HttpServletRequest request
			, ModelMap model) throws Exception{
		
		paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
		paramVO.setFrstRegisterIp(request.getRemoteAddr());
		
		// 사이트 정보 등록
		siteModuleInfoService.registSiteModuleInfo(paramVO);
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		
		return "forward:"+wzwgContext+CmmSessionUtil.getSessionMngrSitePrefix(request)+"/siteMngr/siteInfo/selectSiteModuleInfoForm.do";
	}


}
