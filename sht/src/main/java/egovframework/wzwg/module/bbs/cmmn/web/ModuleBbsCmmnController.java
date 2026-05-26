package egovframework.wzwg.module.bbs.cmmn.web;

import java.sql.SQLException;
import java.util.IllegalFormatException;
import java.util.List;

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
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsCmmnService;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsCssVO;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoService;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ModuleBbsCmmnController {


    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

    /** ModuleBbsCmmnService */
    @Resource(name="ModuleBbsCmmnService")
    protected ModuleBbsCmmnService bbsCmmnService;
    
    @Resource(name="CntntsInfoService")
	private CntntsInfoService cntntsInfoService;
    
	/**
	 * ㅁ  게시판 공통 - 말머리 목록(list)
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/bbs/cmmn/selectBbsSubospecListAjax.do")
	public String selectBbsSubospecList(
			@ModelAttribute("paramVO") ModuleBbsVO paramVO
			, @RequestParam(value="param_bbsSeq", required=false) String bbsSeq
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		if(bbsSeq != null){
			paramVO.setBbsSeq(bbsSeq);
		}
		
		List<ModuleBbsVO> subospecList = bbsCmmnService.selectBbsSubospecList(paramVO.getBbsSeq());	// 말머리 목록
		
		model.addAttribute("subospecList", subospecList);
		
		return "wzwg/module/bbs/cmmn/subospecList";
	}
	
	/**
	 * ㅁ  게시판 공통 - 말머리 목록(selectbox)
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/bbs/cmmn/selectBbsSubospecSelectListAjax.do")
	public String selectBbsSubospecSelectList(
			@ModelAttribute("paramVO") ModuleBbsVO paramVO
			, @RequestParam(value="param_bbsSeq", required=false) String bbsSeq
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		if(bbsSeq != null){
			paramVO.setBbsSeq(bbsSeq);
		}
		
		List<ModuleBbsVO> subospecList = bbsCmmnService.selectBbsSubospecList(paramVO.getBbsSeq());	// 말머리 목록
		
		model.addAttribute("subospecList", subospecList);
		
		return "wzwg/module/bbs/cmmn/subospecSelectList";
	}
	
	/**
	 * ㅁ  게시판 공통 - 말머리 목록(selectbox)
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/bbs/cmmn/selectBbsSubospecSelectMakeListAjax.do")
    public ModelAndView selectBbsSubospecSelectMakeList(
    		@ModelAttribute("paramVO") ModuleBbsVO paramVO
    		, @RequestParam(value="searchBbsSeq", required=false) String searchBbsSeq
    		, HttpServletRequest request
    	) throws Exception {
    	
		List<ModuleBbsVO> subospecList = bbsCmmnService.selectBbsSubospecList(searchBbsSeq);
		
		return CmmAjaxUtil.getAjaxReturnList(subospecList, "subospecSeq", "subospecSj", true);
    }
	
	/**
	 * ㅁ  게시판 공통 - 말머리 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/bbs/cmmn/registBbsSubospecAjax.do")
	public ModelAndView registBbsSubospec(
			@ModelAttribute("paramVO") ModuleBbsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if(loginVO != null && loginVO.getUserId() != null) {
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
	@RequestMapping(value="/**/module/bbs/cmmn/modifyBbsSubospecAjax.do")
	public ModelAndView modifyBbsSubospec(
			@ModelAttribute("paramVO") ModuleBbsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if(loginVO != null && loginVO.getUserId() != null) {
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
	@RequestMapping(value="/**/module/bbs/cmmn/deleteBbsSubospecAjax.do")
	public ModelAndView deleteBbsSubospec(
			@ModelAttribute("paramVO") ModuleBbsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");

		if(loginVO != null && loginVO.getUserId() != null) {		
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		result = bbsCmmnService.deleteBbsSubospec(paramVO);	// 삭제
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	
	/**
	 * ㅁ 게시판 공통 - CSS 팝업
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/module/bbs/cmmn/selectCssListPopup.do"})
	public String selectCssListPopup(
			@ModelAttribute("paramVO") ModuleBbsVO paramVO
			, ModuleBbsCssVO moduleBbsCssVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		try{
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));

		moduleBbsCssVO = bbsCmmnService.selectBbsCssSeq(paramVO);
		
		paramVO.setCssSeq(moduleBbsCssVO.getCssSeq());
		
    	List<ModuleBbsCssVO> bbsCssList = bbsCmmnService.selectBbsCssList(paramVO);
  
		model.addAttribute("bbsCssList", bbsCssList);
		
//		moduleBbsCssVO = bbsCmmnService.selectBbsCssDetail(moduleBbsCssVO);
//		model.addAttribute("moduleBbsCssVO", moduleBbsCssVO);
		
		//bbsCss 정보는 맨처음 호출시 sysmodule_seq 가 없기 때문에 컨텐츠 정보에서 가져오도록 변경함 2020.07.03 cwk
		CntntsInfoVO cntntsInfoVO = new CntntsInfoVO();
		cntntsInfoVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		cntntsInfoVO.setSearchCntntsSeq(paramVO.getSitecntntsSeq());
		cntntsInfoVO = cntntsInfoService.selectCntntsBassInfo(cntntsInfoVO);
		model.addAttribute("cntntsInfoVO", cntntsInfoVO);
		
		}catch(NullPointerException e){
			log.error("NullPointerException",e);
		}catch(NumberFormatException e){
			log.error("NumberFormatException",e);
		}catch(IllegalFormatException e){
			log.error("IllegalFormatException",e);
		}catch(SQLException e){
			log.error("SQLException",e);
		}
		return "wzwg/module/bbs/cmmn/cssListPopup"; 
	}   	
	
	/**
	 * ㅁ 게시판 공통 - CSS 팝업
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/module/bbs/cmmn/selectSysmoduleCssListPopup.do"})
	public String selectSysmoduleCssListPopup(
			@ModelAttribute("paramVO") ModuleBbsVO paramVO
			, ModuleBbsCssVO moduleBbsCssVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		try{
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));

		moduleBbsCssVO = bbsCmmnService.selectBbsCssSeq(paramVO);
		
		paramVO.setCssSeq(moduleBbsCssVO.getCssSeq());
		
    	List<ModuleBbsCssVO> bbsCssList = bbsCmmnService.selectSysmoduleBbsCssList(paramVO);
  
		model.addAttribute("bbsCssList", bbsCssList);
		}catch(NullPointerException e){
			log.error("NullPointerException",e);
		}catch(NumberFormatException e){
			log.error("NumberFormatException",e);
		}catch(IllegalFormatException e){
			log.error("IllegalFormatException",e);
		}catch(SQLException e){
			log.error("SQLException",e);
		}
		return "wzwg/module/bbs/cmmn/cssListPopup"; 
	}   	
	
	/**
	 * ㅁ 게시판 공통 - CSS 미리보기
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/bbs/cmmn/selectCssPrevewPopup.do")
	public String selectCssPrevewPopup(
			@ModelAttribute("paramVO")ModuleBbsCssVO moduleBbsCssVO
			, HttpServletRequest request
			, ModelMap model
		) throws Exception{
		
		moduleBbsCssVO = bbsCmmnService.selectBbsCssDetail(moduleBbsCssVO);
		model.addAttribute("moduleBbsCssVO", moduleBbsCssVO);
		
		return "wzwg/module/bbs/cmmn/cssPrevewPopup";
	}	
	
	/**
	 * ㅁ  게시판 공통 - 게시판 CSS정보 저장
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/bbs/cmmn/modifyBbsCssSeqAjax.do")
	public ModelAndView modifyBbsCssSeqAjax(
			@ModelAttribute("paramVO") ModuleBbsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");

		if(loginVO != null && loginVO.getUserId() != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		result = bbsCmmnService.modifyBbsCssSeq(paramVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}	
	
	/**
	 * ㅁ 게시판 공통 - CSS 정보 Ajax
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/bbs/cmmn/selectCssInfoAjax.do")
	public String selectCssInfoAjax(
			@ModelAttribute("paramVO") ModuleBbsVO paramVO
			, HttpServletRequest request
			, ModelMap model
		) throws Exception{
		
		ModuleBbsCssVO moduleBbsCssVO = new ModuleBbsCssVO();
		
		moduleBbsCssVO = bbsCmmnService.selectBbsCssSeq(paramVO);

		if(moduleBbsCssVO != null) {
			moduleBbsCssVO = bbsCmmnService.selectBbsCssDetail(moduleBbsCssVO);
			model.addAttribute("moduleBbsCssVO", moduleBbsCssVO);
		} else {
			model.addAttribute("moduleBbsCssVO", null);
		}

		return "wzwg/module/bbs/cmmn/cssInfoAjax";
	}	
	
	/**
	 * ㅁ 게시판 공통 - 적용된 CSS 정보 Ajax
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/bbs/cmmn/selectChangeCssInfoAjax.do")
	public ModelAndView selectChangeCssInfoAjax(
			@ModelAttribute("paramVO") ModuleBbsVO paramVO
			, HttpServletRequest request
			, ModelMap model
		) throws Exception{
		
		ModuleBbsCssVO moduleBbsCssVO = new ModuleBbsCssVO();
		
		moduleBbsCssVO = bbsCmmnService.selectBbsCssSeq(paramVO);
		
		if(moduleBbsCssVO != null) {
			moduleBbsCssVO = bbsCmmnService.selectBbsCssDetail(moduleBbsCssVO);
			
			String cssPath = moduleBbsCssVO.getCssPath() + "/" + moduleBbsCssVO.getCssFileNm();
			
			return CmmAjaxUtil.getAjaxReturn(cssPath);
		} else {
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
		
	}	
	
}
