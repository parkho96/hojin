package egovframework.wzwg.module.mngr.web;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;

@Controller
public class ModuleMngrChargerController {


    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

	
	/**
	 * ㅁ 통합 게시판 - 담당자 - 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/bbs/unity/mngr/selectUnityBbsChargerList.do")
	public String selectUnityBbsChargerList(
			@ModelAttribute("paramVO") ModuleBbsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		return "wzwg/module/bbs/unity/mngr/bbsDataManageList"; 
	}
	
}
