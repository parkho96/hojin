package egovframework.wzwg.module.onlineReqst.mngr.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.onlineReqst.mngr.service.MngrOnlineReqstInfoService;
import egovframework.wzwg.module.onlineReqst.mngr.service.MngrOnlineReqstInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;

@Controller
public class MngrOnlineReqstInfoController {
	
	@Resource(name="MngrOnlineReqstInfoService")
	MngrOnlineReqstInfoService mngrOnlineReqstInfoService;
	
	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;
	
    /**
	 * 온라인신청 메인
	 */
	@RequestMapping(value={"/mngr/module/onlineReqst/selectOnlineReqstInc.do","/{siteKey}/mngr/module/onlineReqst/selectOnlineReqstInc.do"})
	public String selectOnlineReqstInc(
			@ModelAttribute("paramVO") MngrOnlineReqstInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
    	List<CntntsInfoVO> resultList = mngrOnlineReqstInfoService.selectOnlineReqstInfoList(paramVO);

		paramVO.setReqstSeq((String) request.getParameter("cntntsSeq"));
		
		model.addAttribute("onlineReqstInfoList", resultList);
    	
    	String reqUrl = request.getRequestURI();
    	String mngrAt = "N";

    	if(reqUrl.indexOf("/mngr/") > -1) {
    		if(reqUrl.indexOf("/mngr/screen/") == -1) {
    			mngrAt = "Y";
    		}
    	}
	
    	model.addAttribute("mngrAt", mngrAt);
		 
		return "wzwg/module/onlineReqst/mngr/onlineReqstInc"; 
	}	
	
	/** 
	 * 온라인신청 기본정보 상세(폼)
	 */
	@RequestMapping(value={"/**/mngr/module/onlineReqst/selectOnlineReqstInfoFormAjax.do", "/**/mngr/module/onlineReqst/reqstFormAjax.do","/**/sysMngr/module/onlineReqst/selectOnlineReqstInfoFormAjax.do", "/**/sysMngr/module/onlineReqst/reqstFormAjax.do"})
	public String registOnlineReqstInfoFormAjax(
			@ModelAttribute("paramVO") MngrOnlineReqstInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		MngrOnlineReqstInfoVO resultVO = new MngrOnlineReqstInfoVO();

		resultVO = mngrOnlineReqstInfoService.selectOnlineReqstInfoDetail(paramVO);

		if(resultVO != null){
			resultVO.setSitecntntsSeq(paramVO.getSitecntntsSeq());
			model.addAttribute("resultVO", resultVO);
		}else{
			model.addAttribute("resultVO", paramVO);
		}
		
		return "wzwg/module/onlineReqst/mngr/onlineReqstInfoForm"; 
	}
		

	   /**
     * 온라인신청 정보 등록
     */
    @RequestMapping(value="/**/module/onlineReqst/registOnlineReqstInfoAjax.do")
    public ModelAndView registOnlineReqstInfo(
            @ModelAttribute("paramVO") MngrOnlineReqstInfoVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{
        
        int result = 0;
        
        HttpSession session = request.getSession();
        CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
        
        if (loginVO != null) {
        	paramVO.setFrstRegisterId(loginVO.getUserId());
        }
        
        result = mngrOnlineReqstInfoService.registOnlineReqstInfo(paramVO);

        if(result > 0){
            return CmmAjaxUtil.getAjaxReturn("success");
        }else{
            return CmmAjaxUtil.getAjaxReturn("fail");
        }
    }	    

    /**
     * 온라인신청 정보 수정
     */
	@RequestMapping(value="/**/module/onlineReqst/modifyOnlineReqstInfoAjax.do")
	public ModelAndView modifyOnlineReqstInfo(
			@ModelAttribute("paramVO") MngrOnlineReqstInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		result = mngrOnlineReqstInfoService.modifyOnlineReqstInfo(paramVO);
        
        if(result > 0){
            return CmmAjaxUtil.getAjaxReturn("success");
        }else{
            return CmmAjaxUtil.getAjaxReturn("fail");
        }
	}
	
}
