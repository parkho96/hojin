package egovframework.wzwg.sysMngr.opnsu.bbs.web;

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
import egovframework.wzwg.sysMngr.opnsu.bbs.service.OpnsuBbsCmmnService;
import egovframework.wzwg.sysMngr.opnsu.bbs.service.OpnsuBbsVO;


@Controller
public class OpnsuBbsCmmnController {


    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

    /** OpnsuBbsCmmnService */
    @Resource(name="OpnsuBbsCmmnService")
    protected OpnsuBbsCmmnService bbsCmmnService;
    
	/**
	 * ㅁ  게시판 공통 - 말머리 목록(list)
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/opnsu/bbs/cmmn/selectBbsSubospecListAjax.do")
	public String selectBbsSubospecList(
			@ModelAttribute("paramVO") OpnsuBbsVO paramVO
			, @RequestParam(value="param_bbsSeq", required=false) String bbsSeq
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		if(bbsSeq != null){
			paramVO.setBbsSeq(bbsSeq);
		}
		
		List<OpnsuBbsVO> subospecList = bbsCmmnService.selectBbsSubospecList(paramVO.getBbsSeq());	// 말머리 목록
		
		model.addAttribute("subospecList", subospecList);
		
		return "wzwg/sysMngr/opnsu/bbs/cmmn/subospecList";
	}
	
	/**
	 * ㅁ  게시판 공통 - 말머리 목록(selectbox)
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/opnsu/bbs/cmmn/selectBbsSubospecSelectListAjax.do")
	public String selectBbsSubospecSelectList(
			@ModelAttribute("paramVO") OpnsuBbsVO paramVO
			, @RequestParam(value="param_bbsSeq", required=false) String bbsSeq
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		if(bbsSeq != null){
			paramVO.setBbsSeq(bbsSeq);
		}
		
		List<OpnsuBbsVO> subospecList = bbsCmmnService.selectBbsSubospecList(paramVO.getBbsSeq());	// 말머리 목록
		
		model.addAttribute("subospecList", subospecList);
		
		return "wzwg/sysMngr/opnsu/bbs/cmmn/subospecSelectList";
	}
	
	/**
	 * ㅁ  게시판 공통 - 말머리 목록(selectbox)
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/opnsu/bbs/cmmn/selectBbsSubospecSelectMakeListAjax.do")
    public ModelAndView selectBbsSubospecSelectMakeList(
    		@ModelAttribute("paramVO") OpnsuBbsVO paramVO
    		, @RequestParam(value="searchBbsSeq", required=false) String searchBbsSeq
    		, HttpServletRequest request
    	) throws Exception {
    	
		List<OpnsuBbsVO> subospecList = bbsCmmnService.selectBbsSubospecList(searchBbsSeq);
		
		return CmmAjaxUtil.getAjaxReturnList(subospecList, "subospecSeq", "subospecSj", true);
    }
	
	/**
	 * ㅁ  게시판 공통 - 말머리 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/opnsu/bbs/cmmn/registBbsSubospecAjax.do")
	public ModelAndView registBbsSubospec(
			@ModelAttribute("paramVO") OpnsuBbsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setFrstRegisterId(loginVO.getUserId());
		}
		
		result = bbsCmmnService.registBbsSubospec(paramVO);	// 등록
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ  게시판 공통 - 말머리 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/opnsu/bbs/cmmn/modifyBbsSubospecAjax.do")
	public ModelAndView modifyBbsSubospec(
			@ModelAttribute("paramVO") OpnsuBbsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		result = bbsCmmnService.modifyBbsSubospec(paramVO);	// 수정
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ  게시판 공통 - 말머리 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/opnsu/bbs/cmmn/deleteBbsSubospecAjax.do")
	public ModelAndView deleteBbsSubospec(
			@ModelAttribute("paramVO") OpnsuBbsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		result = bbsCmmnService.deleteBbsSubospec(paramVO);	// 삭제
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
}
