package egovframework.wzwg.sysMngr.opnsu.ntt.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.sysMngr.opnsu.bbs.service.OpnsuBbsCmmnService;
import egovframework.wzwg.sysMngr.opnsu.bbs.service.OpnsuBbsVO;
import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttCmmnService;
import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttVO;



@Controller
public class OpnsuNttCmmnController {


    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

    /** ModuleNttService */
    @Resource(name="OpnsuNttCmmnService")
    protected OpnsuNttCmmnService nttService;
    
    /** OpnsuBbsCmmnService */
    @Resource(name="OpnsuBbsCmmnService")
    protected OpnsuBbsCmmnService bbsCmmnService;

    
	/**
	 * ㅁ 게시물 - 말머리 수정 팝업
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/opnsu/ntt/cmmn/modifySubospecPopup.do")
	public String modifySubospecPopup(
			@ModelAttribute("paramVO") OpnsuNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		List<OpnsuBbsVO> subospecList = bbsCmmnService.selectBbsSubospecList(paramVO.getBbsSeq());	// 말머리 목록
		model.addAttribute("subospecList", subospecList);
		
		return "wzwg/sysMngr/opnsu/ntt/cmmn/subospecModifyPopup";
	}
	
	/**
	 * ㅁ 게시물 - 말머리 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/opnsu/ntt/cmmn/modifySubospecAjax.do")
	public ModelAndView modifySubospec(
			@ModelAttribute("paramVO") OpnsuNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		Integer result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		if (loginVO != null) paramVO.setLastUpdusrId(loginVO.getUserId());
		
		result = nttService.modifyCheckNttSubospec(paramVO);		// 수정
				
		if(result > 0){
    		return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ 게시물 - 게시물 작성자
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/opnsu/ntt/cmmn/selectNttNtcrIdAjax.do")
	public ModelAndView selectNttNtcrId(
			@ModelAttribute("paramVO") OpnsuNttVO paramVO
			, @RequestParam(value="nttSeq", required=false) String nttSeq
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
			String ntcrId = "";

			paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
			paramVO.setNttSeq(nttSeq);
			ntcrId = nttService.selectNttNtcrId(paramVO);

			return CmmAjaxUtil.getAjaxReturn(ntcrId);
	
	}

}
