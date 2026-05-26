package egovframework.wzwg.module.onlineReqst.web;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.onlineReqst.service.ModuleOnlineReqstInfoService;
import egovframework.wzwg.module.onlineReqst.service.ModuleOnlineReqstInfoVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;

@Controller
public class ModuleOnlineReqstInfoController {
	
	@Resource(name="ModuleOnlineReqstInfoService")
	ModuleOnlineReqstInfoService moduleOnlineReqstInfoService;
	
	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;
	
    /**
	 * 온라인신청 메인
	 */
	@RequestMapping(value={"/module/onlineReqst/selectOnlineReqstInc.do","/{siteKey}/module/onlineReqst/selectOnlineReqstInc.do"})
	public String selectOnlineReqstInc(
			@ModelAttribute("paramVO") ModuleOnlineReqstInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{

		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		paramVO.setReqstSeq((String) request.getParameter("cntntsSeq"));

    	String reqUrl = request.getRequestURI();
    	String mngrAt = "N";

    	if(reqUrl.indexOf("/mngr/") > -1) {
    		if(reqUrl.indexOf("/mngr/screen/") == -1) {
    			mngrAt = "Y";
    		}
    	}
	
    	model.addAttribute("mngrAt", mngrAt);
		 
		return "wzwg/module/onlineReqst/onlineReqstInc"; 
	}	

}
