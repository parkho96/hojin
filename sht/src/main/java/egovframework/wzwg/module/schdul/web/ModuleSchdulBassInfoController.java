package egovframework.wzwg.module.schdul.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import dggb.util.DateUtils;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.popup.service.ModulePopupInfoService;
import egovframework.wzwg.module.schdul.service.ModuleSchdulBassInfoService;
import egovframework.wzwg.module.schdul.service.ModuleSchdulBassInfoVO;
import egovframework.wzwg.module.schdul.service.ModuleSchdulCssVO;
import egovframework.wzwg.module.scrin.service.ScrinCntntsService;
import egovframework.wzwg.module.scrin.service.ScrinCntntsVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoService;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeVO;
import net.sf.json.JSONObject;

@Controller
public class ModuleSchdulBassInfoController {


    /** EgovPropertyService */
    @Resource(name="propertiesService")
    private EgovPropertyService propertyService;

    /** ModuleBbsCmmnService */
    @Resource(name="ModuleSchdulBassInfoService")
    private ModuleSchdulBassInfoService schdulService;
    
    @Resource(name="CntntsInfoService")
    private CntntsInfoService cntntsInfoService; 
    
    @Resource(name="ModulePopupInfoService")
	ModulePopupInfoService modulePopupInfoService;
    
    @Resource(name="CmmCodeService")
    CmmCodeService cmmCodeService;
    
    /** 화면 컨텐츠 **/
    @Resource(name="ScrinCntntsService")
    private ScrinCntntsService scrinCntntsService;
    
    /**
	 * ㅁ 통합게시판 - 메인
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/module/schdul/unity/selectSchdulInc.do","/{siteKey}/**/module/schdul/unity/selectSchdulInc.do"})
	public String selectBbsInc(
			@ModelAttribute("paramVO") ModuleSchdulBassInfoVO paramVO
			, @RequestParam(value="cntntsSeq", required=false) String cntntsSeq
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		paramVO.setSchdulSeq(cntntsSeq);
    	
		//일정정보 목록 조회
		List<CntntsInfoVO> schdulBassInfoList = schdulService.selectSchdulBassInfoList(paramVO);
		
    	model.addAttribute("schdulList", schdulBassInfoList);
    	model.addAttribute("paramVO", paramVO);
    	
		return "wzwg/module/schdul/unity/schdulInc"; 
	}
    
	/**
	 * ㅁ  일정 - 목록(list)
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/module/schdul/selectSchdulBassInfoAjax.do", "/**/module/schdul/schdulFormAjax.do"})
	public String selectSchdulBassInfoList(
			@ModelAttribute("paramVO") ModuleSchdulBassInfoVO paramVO
			, @RequestParam(value="schdulSeq", required=false) String schdulSeq
			, @RequestParam(value="cntntsSeq", required=false) String cntntsSeq
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		if(schdulSeq != null){
			paramVO.setSchdulSeq(schdulSeq);
			
			//일정기본정보 상세 조회
			ModuleSchdulBassInfoVO schdulBassInfoDetail = schdulService.selectSchdulBassInfoDetail(paramVO);
			model.addAttribute("resultVO", schdulBassInfoDetail);
			
			model.addAttribute("state", "modify");
		} else {
			
			String newSchdulSeq = schdulService.selectSchdulNextSeq();
			
			model.addAttribute("newSchdulSeq", newSchdulSeq);
			model.addAttribute("resultVO", paramVO);
			model.addAttribute("state", "regist");
		}
		
		//일정정보 목록 조회
		List<CntntsInfoVO> schdulBassInfoList = schdulService.selectSchdulBassInfoList(paramVO);
		model.addAttribute("schdulBassInfoList", schdulBassInfoList);
		
		List<CmmCodeVO> ctgryColorList = cmmCodeService.selectCmmCodeList("COM_COLOR_CODE");
		model.addAttribute("ctgryColorList", ctgryColorList);
		
		return "wzwg/module/schdul/bassInfo/schdulForm";
	}
	
	
	/**
	 * ㅁ  일정 - 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/schdul/registSchdulAjax.do")
	public ModelAndView registSchdul(
			@ModelAttribute("paramVO") ModuleSchdulBassInfoVO paramVO
			, @ModelAttribute("cntntsInfoVO") CntntsInfoVO cntntsInfoVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setFrstRegisterId(loginVO.getUserId());
		}
		
		//일정 등록
		result = schdulService.registSchdulBassInfo(paramVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
		
	}
	
	/**
	 * ㅁ  일정 - 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/schdul/modifySchdulAjax.do")
	public ModelAndView modifySchdul(
			@ModelAttribute("paramVO") ModuleSchdulBassInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		result = schdulService.modifySchdulBassInfo(paramVO);	// 수정
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ  일정 - 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/schdul/deleteSchdulAjax.do")
	public ModelAndView deleteSchdul(
			@ModelAttribute("paramVO") ModuleSchdulBassInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		result = schdulService.deleteSchdulBassInfo(paramVO);	// 삭제
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ 일정 - CSS 상세
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/schdul/selectSchdulCssInfoDetailAjax.do")
	public String selectSchdulCssInfoDetailAjax(
			@ModelAttribute("paramVO") ModuleSchdulBassInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		String cssSeq = schdulService.selectSchdulCssSeq(paramVO);
		
		if(cssSeq != null && !("").equals(cssSeq)){
			ModuleSchdulCssVO schdulCssVO = new ModuleSchdulCssVO();
			schdulCssVO.setCssSeq(cssSeq);
			schdulCssVO = schdulService.selectSchdulCssDetail(schdulCssVO);
			model.addAttribute("schdulCssVO", schdulCssVO);
		}else{
			model.addAttribute("schdulCssVO", null);
		}
		
		return "wzwg/module/schdul/bassInfo/cssInfoAjax";
	}
	
	/**
	 * ㅁ 일정 - CSS 리스트
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/schdul/selectSchdulCssListAjax.do")
	public String selectSchdulCssListAjax (
			@ModelAttribute("paramVO") ModuleSchdulBassInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		List<ModuleSchdulCssVO> resultList = schdulService.selectSchdulCssList(paramVO);
		model.addAttribute("resultList", resultList);
		
		return "wzwg/module/schdul/bassInfo/cssListPopup";
	}
	
	/**
	 * ㅁ 일정 - CSS 정보 수정
	 * @param paramVO
	 * @param cntntsInfoVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/schdul/modifySchdulCssAjax.do")
	public ModelAndView modifySchdulCssAjax(
			@ModelAttribute("paramVO") ModuleSchdulBassInfoVO paramVO
			, @ModelAttribute("cntntsInfoVO") CntntsInfoVO cntntsInfoVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		result = schdulService.modifySchdulCss(paramVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ  일정 모듈연결 - 생성된 모듈 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/schdul/bassInfo/selectModuleListAjax.do")
    public ModelAndView selectModuleListAjax(
    		@ModelAttribute("resultVO") ModuleSchdulBassInfoVO resultVO
    		, HttpServletRequest request
    	) throws Exception {

		resultVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		List<ModuleSchdulBassInfoVO> connModuleList = schdulService.selectModuleList(resultVO);
		
		return CmmAjaxUtil.getAjaxReturnList(connModuleList, "sitecntntsSeq", "cntntsNm", true);
    }
	
	/**
	 * ㅁ  일정 모듈연결 - 생성된 모듈 연결
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/schdul/bassInfo/registSchdulConnModuleListAjax.do")
    public ModelAndView registSchdulConnModuleListAjax(
    		@ModelAttribute("resultVO") ModuleSchdulBassInfoVO resultVO
    		, HttpServletRequest request
    	) throws Exception {

		int result = 0;
		
		resultVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		resultVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
		
		result = schdulService.registConnModuleList(resultVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
		
    }
	
	/**
	 * ㅁ  일정 모듈연결 - 연결된 모듈 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/schdul/bassInfo/selectConnModuleListAjax.do")
    public String selectConnModuleListAjax(
    		@ModelAttribute("resultVO") ModuleSchdulBassInfoVO resultVO
    		, @RequestParam(value="param_schdulSeq", required=false) String schdulSeq
    		, HttpServletRequest request
    		, ModelMap model
    	) throws Exception {

		if(schdulSeq != null){
			resultVO.setSchdulSeq(schdulSeq);
		}
		
		resultVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		List<ModuleSchdulBassInfoVO> connModuleList = schdulService.selectConnModuleList(resultVO);
		model.addAttribute("connModuleList", connModuleList);
		
		return "wzwg/module/schdul/bassInfo/connModuleList";
    }
	
	/**
	 * ㅁ  일정 모듈연결 - 연결된 모듈 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/schdul/bassInfo/deleteSchdulConnModuleAjax.do")
    public ModelAndView deleteSchdulConnModuleAjax(
    		@ModelAttribute("resultVO") ModuleSchdulBassInfoVO resultVO
    		, HttpServletRequest request
    	) throws Exception {

		int result = 0;
		
		resultVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		result = schdulService.deleteConnModule(resultVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
		
    }
	
	 @RequestMapping(value="/**/module/schdul/bassInfo/scrinCntntsJson.do")
	    public ModelAndView selectScrinCntntsJson (
	        @ModelAttribute("paramVO") ModuleSchdulBassInfoVO paramVO
	        , HttpServletRequest request ) throws Exception {
	    
		 	ModelAndView model = new ModelAndView();
		    
	        model.setViewName("jsonView");
	        
	        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
	        
	        paramVO.setSiteSeq(siteSeq);
	        
	        ScrinCntntsVO scrinCntntsVO = new ScrinCntntsVO();
	        scrinCntntsVO.setSiteSeq(siteSeq);
	        scrinCntntsVO.setMenuSeq(paramVO.getMenuSeq());
	        scrinCntntsVO.setSitecntntsSeq(paramVO.getSitecntntsSeq());//menuSeq 와 배타적 관계(현재 tabmenu 모듈에서 호출시 사용 2022.07.20)
	        // 컨텐츠 정보를 가져옴
	        ScrinCntntsVO cntntsInfo = scrinCntntsService.selectSitecntntsSeqByModuleInfo(scrinCntntsVO); 
	        
	        String parentModule = StringUtils.defaultString(request.getParameter("parentModule")); 
	        // 탭메뉴 매핑정보를 가져옴
	        if(parentModule.equals("tabMenu")) {
	        	scrinCntntsVO.setBbsSeq(StringUtils.defaultString(request.getParameter("bbsSeq")));
	        	scrinCntntsVO.setNttSeq(StringUtils.defaultString(request.getParameter("nttSeq")));
	        	ScrinCntntsVO tabMenuInfo = scrinCntntsService.selectScrinTabMenuInfo(scrinCntntsVO);
	        	model.addObject("tabMenuInfo", tabMenuInfo);
	        	
	        }
	        paramVO.setSchdulSeq(cntntsInfo.getCntntsSeq());
	        paramVO.setSiteSeq(siteSeq);
	        if(paramVO.getSearchYYYYMM()==null || paramVO.getSearchYYYYMM().equals("")){
	        	paramVO.setSearchYYYYMM(DateUtils.getCurrentDate("yyyyMM"));
	        }
	        
	        // 컨텐츠 데이터를 가져옴
	        List<ModuleSchdulBassInfoVO> cntntsData = schdulService.selectSchdulMainScrinCntnts(paramVO);
	        List<ModuleSchdulBassInfoVO> cntntsDataMonth = schdulService.selectSchdulMainScrinCntntsToMonth(paramVO);

	        
	        
	        // 컨텐츠 데이터를 JSON 변환하여 넘김
	        model.addObject("cntntsData", cntntsData);
	        model.addObject("cntntsDataMonth", cntntsDataMonth);
	        model.addObject("cntntsInfo", JSONObject.fromObject(cntntsInfo));
	        
	        return model;
	    }
	
}
