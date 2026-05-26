package egovframework.wzwg.module.ntt.module.scrap.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttCmmnService;
import egovframework.wzwg.module.ntt.module.scrap.service.ModuleNttScrapService;
import egovframework.wzwg.module.ntt.module.scrap.service.ModuleNttScrapVO;

@Controller
public class ModuleNttScrapController {

    /** ModuleNttScrapService */
    @Resource(name="ModuleNttScrapService")
    protected ModuleNttScrapService nttScrapService;
    
    /** ModuleNttService */
    @Resource(name="ModuleNttCmmnService")
    protected ModuleNttCmmnService nttService;
    
    
    /**
   	 * ㅁ 게시물 스크랩 등록 팝업
   	 * @param request
   	 * @param model
   	 * @return
   	 * @throws Exception
   	 */
   	@RequestMapping(value="/**/module/ntt/scrap/registNttScrapPopup.do")
   	public String registNttScrapPopup(
   			@ModelAttribute("paramVO") ModuleNttScrapVO paramVO
   			, HttpServletRequest request 
   			, ModelMap model
   		) throws Exception{
   		
   		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
   		if(loginVO != null){
   			paramVO.setUsrSeq(loginVO.getUsrSeq());
   		}
   		
   		List<ModuleNttScrapVO> scrapgroupList = nttScrapService.selectNttScrapgroupList(paramVO);
   		model.addAttribute("scrapgroupList", scrapgroupList);
   		
   		return "wzwg/module/ntt/module/scrap/registNttScrapPopup";
   	}
   	
   	/**
	 * 게시물 스크랩 그룹 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/scrap/selectNttScrapgroupListAjax.do")
    public ModelAndView selectNttScrapgroupList(
    		@ModelAttribute("paramVO") ModuleNttScrapVO paramVO
			, HttpServletRequest request 
			, ModelMap model
    	) throws Exception {
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
   		if(loginVO != null){
   			paramVO.setUsrSeq(loginVO.getUsrSeq());
   		}
   		
		List<ModuleNttScrapVO> scrapgroupList = nttScrapService.selectNttScrapgroupList(paramVO);
		
		return CmmAjaxUtil.getAjaxReturnList(scrapgroupList, "scrapgroupSeq", "groupNm", true);
    }
   	
	/**
   	 * ㅁ 게시물 스크랩 그룹 중복체크
   	 * @param request
   	 * @param model
   	 * @return
   	 * @throws Exception
   	 */
   	@RequestMapping(value="/**/module/ntt/scrap/selectNttScrapgroupDplctChkAjax.do")
   	public ModelAndView selectNttScrapgroupDplctChk(
   			@ModelAttribute("paramVO") ModuleNttScrapVO paramVO
   			, HttpServletRequest request 
   			, ModelMap model
   		) throws Exception{
   		
   		Integer result = 0;
   		
   		HttpSession session = request.getSession();
   		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
   		
   		if (loginVO != null) {
   			paramVO.setFrstRegisterId(loginVO.getUserId());
   		}
   		
   		result = nttScrapService.selectNttScrapgroupDplctChk(paramVO);
   				
   		if(result > 0){
   			return CmmAjaxUtil.getAjaxReturn("fail");
   		}else{
   			return CmmAjaxUtil.getAjaxReturn("success");
   		}
   		
   	}
   	
   	/**
   	 * ㅁ 게시물 스크랩 그룹 등록
   	 * @param request
   	 * @param model
   	 * @return
   	 * @throws Exception
   	 */
   	@RequestMapping(value="/**/module/ntt/scrap/registNttScrapgroupAjax.do")
   	public ModelAndView registNttScrapgroup(
   			@ModelAttribute("paramVO") ModuleNttScrapVO paramVO
   			, HttpServletRequest request 
   			, ModelMap model
   		) throws Exception{
   		
   		Integer result = 0;
   		
   		HttpSession session = request.getSession();
   		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
   		
   		if (loginVO != null) {
   			paramVO.setFrstRegisterId(loginVO.getUserId());
   		}
   		paramVO.setScrapgroupSeq(nttScrapService.selectNextNttScrapgroupSeq());
   		
   		result = nttScrapService.registNttScrapgroup(paramVO);
   				
   		if(result > 0){
   			return CmmAjaxUtil.getAjaxReturn("success");
   		}else{
   			return CmmAjaxUtil.getAjaxReturn("fail");
   		}
   		
   	}
   	
   	/**
   	 * ㅁ 게시물 스크랩 그룹 삭제
   	 * @param request
   	 * @param model
   	 * @return
   	 * @throws Exception
   	 */
   	@RequestMapping(value="/**/module/ntt/scrap/deleteNttScrapgroupAjax.do")
   	public ModelAndView deleteNttScrapgroup(
   			@ModelAttribute("paramVO") ModuleNttScrapVO paramVO
   			, HttpServletRequest request 
   			, ModelMap model
   		) throws Exception{
   		
   		Integer result = 0;
   		
   		HttpSession session = request.getSession();
   		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
   		
   		if (loginVO != null) {
   			paramVO.setLastUpdusrId(loginVO.getUserId());
   			paramVO.setUsrSeq(loginVO.getUsrSeq());
   		}
   		
   		result = nttScrapService.deleteNttScrapgroup(paramVO);
   				
   		if(result > 0){
   			return CmmAjaxUtil.getAjaxReturn("success");
   		}else{
   			return CmmAjaxUtil.getAjaxReturn("fail");
   		}
   		
   	}
   	
   	/**
   	 * ㅁ 게시물 스크랩 중복체크
   	 * @param request
   	 * @param model
   	 * @return
   	 * @throws Exception
   	 */
   	@RequestMapping(value="/**/module/ntt/scrap/selectNttScrapDplctChkAjax.do")
   	public ModelAndView selectNttScrapDplctChk(
   			@ModelAttribute("paramVO") ModuleNttScrapVO paramVO
   			, @RequestParam(value="nttSeq", required=false) String nttSeq
   			, HttpServletRequest request 
   			, ModelMap model
   		) throws Exception{
   		
   		Integer result = 0;
   		
   		HttpSession session = request.getSession();
   		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
   		
   		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
   		
   		paramVO.setSiteSeq(siteSeq);
   		if (loginVO != null) {
   			paramVO.setUsrSeq(loginVO.getUsrSeq());
   		}
   		paramVO.setNttSeq(nttSeq);
   		
   		result = nttScrapService.selectNttScrapDplctChk(paramVO);
   				
   		if(result > 0){
   			return CmmAjaxUtil.getAjaxReturn("fail");
   		}else{
   			return CmmAjaxUtil.getAjaxReturn("success");
   		}
   		
   	}
   	
    /**
   	 * ㅁ 게시물 스크랩 등록
   	 * @param request
   	 * @param model
   	 * @return
   	 * @throws Exception
   	 */
   	@RequestMapping(value="/**/module/ntt/scrap/registNttScrapAjax.do")
   	public ModelAndView registNttScrap(
   			@ModelAttribute("paramVO") ModuleNttScrapVO paramVO
   			, HttpServletRequest request 
   			, ModelMap model
   		) throws Exception{
   		
   		Integer result = 0;
   		
   		HttpSession session = request.getSession();
   		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
   		
		if (loginVO != null) {
			paramVO.setFrstRegisterId(loginVO.getUserId());
		}
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		paramVO.setScrapSeq(nttScrapService.selectNextNttScrapSeq());
   		
   		result = nttScrapService.registNttScrap(paramVO);
   				
   		if(result > 0){
   			return CmmAjaxUtil.getAjaxReturn("success");
   		}else{
   			return CmmAjaxUtil.getAjaxReturn("fail");
   		}
   		
   	}
   	
   	
   	
   	/**
   	 * ㅁ 게시물 스크랩 삭제
   	 * @param request
   	 * @param model
   	 * @return
   	 * @throws Exception
   	 */
   	@RequestMapping(value="/**/module/ntt/scrap/deleteNttScrapAjax.do")
   	public ModelAndView deleteNttScrap(
   			@ModelAttribute("paramVO") ModuleNttScrapVO paramVO
   			, HttpServletRequest request 
   			, ModelMap model
   		) throws Exception{
   		
   		int result = 0;
   		
   		HttpSession session = request.getSession();
   		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
   		
   		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
   		
   		// 현재 USRBBSSCRAP 에 USE_AT 필드 없어서 DELETE로 쿼리문 작성 
   		
   		if (loginVO != null) {
   			paramVO.setLastUpdusrId(loginVO.getUserId());
   			paramVO.setUsrSeq(loginVO.getUsrSeq());
   		}
   		paramVO.setSiteSeq(siteSeq);
   		
   		
   		if(paramVO.getCheckNttSeq() == null) {
   			result = nttScrapService.deleteNttScrap(paramVO);
   		}else {
   			result = nttScrapService.deleteCheckNttScrap(paramVO);
   		}
   				
   		if(result > 0){
   			return CmmAjaxUtil.getAjaxReturn("success");
   		}else{
   			return CmmAjaxUtil.getAjaxReturn("fail");
   		}
   		
   	}
	
}
