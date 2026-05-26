package egovframework.wzwg.module.ntt.simp.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsCmmnService;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;
import egovframework.wzwg.module.bbs.simp.service.ModuleBbsSimpBassInfoService;
import egovframework.wzwg.module.ntt.simp.service.ModuleNttSimpDataManageService;
import egovframework.wzwg.module.ntt.simp.service.ModuleNttSimpVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthService;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;

@Controller
public class ModuleNttSimpDataManageController {

    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
    
    /** ModuleNttSimpDataManageService */
    @Resource(name="ModuleNttSimpDataManageService")
    protected ModuleNttSimpDataManageService nttSimpDataManageService;
    
    /** ModuleBbsCmmnService */
    @Resource(name="ModuleBbsCmmnService")
    protected ModuleBbsCmmnService bbsCmmnService;;
    
    /** CntntsAuthService */
    @Resource(name="CntntsAuthService")
    protected CntntsAuthService cntntsAuthService;	  
    
    /** ModuleBbsSimpBassInfoService */
    @Resource(name="ModuleBbsSimpBassInfoService")
    protected ModuleBbsSimpBassInfoService bbsSimpBassInfoService;    
	
    /**
	 * ㅁ 간단게시판 - 데이터관리 - 입력폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/simp/selectNttFormAjax.do")
	public String selectNttForm(
			@ModelAttribute("paramVO") ModuleNttSimpVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		List<CntntsInfoVO> bbsList = bbsCmmnService.selectBbsList(paramVO.getSiteSeq());
    	
    	if(paramVO.getBbsSeq() == null && bbsList.size() > 0){
    		paramVO.setBbsSeq(bbsList.get(0).getCntntsSeq());
    	}
    	
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		ModuleBbsVO resultVO = new ModuleBbsVO();
		
		resultVO.setBbsSeq(paramVO.getBbsSeq());
		
		// 게시판 기본정보
		resultVO = bbsSimpBassInfoService.selectBbsBassInfoDetail(resultVO);

		model.addAttribute("resultVO", 			resultVO);		
		
		// 게시판 권한
		CntntsAuthVO cntntsAuthVO = new CntntsAuthVO();
		cntntsAuthVO.setSitecntntsSeq(paramVO.getSitecntntsSeq());
		cntntsAuthVO.setSiteSeq(paramVO.getSiteSeq());

		if(loginVO != null){
			cntntsAuthVO.setUsrSeq(loginVO.getUsrSeq());
		} else {
			cntntsAuthVO.setUsrSeq("0");
		}		

		CntntsAuthVO nttAuthVO = cntntsAuthService.selectCntntsAuthForNtt(cntntsAuthVO);    	
		
		model.addAttribute("nttAuthVO", 		nttAuthVO);	
		
    	model.addAttribute("bbsList", bbsList);

		model.addAttribute("editorEstbsSe", EgovProperties.getProperty("Globals.editorEstbs"));
    	
		return "wzwg/module/ntt/simp/nttForm"; 
	}
	
	/**
	 * ㅁ 간단게시판 - 데이터관리 - 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/simp/selectNttSimpListAjax.do")
	public String selectNttList(
			@ModelAttribute("paramVO") ModuleNttSimpVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{

    	// 목록
		List<ModuleNttSimpVO> resultList = nttSimpDataManageService.selectNttSimpList(paramVO);
		
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		// 게시판 권한
		CntntsAuthVO cntntsAuthVO = new CntntsAuthVO();
		cntntsAuthVO.setSitecntntsSeq(paramVO.getSitecntntsSeq());
		cntntsAuthVO.setSiteSeq(paramVO.getSiteSeq());
		
		if(loginVO != null){
			cntntsAuthVO.setUsrSeq(loginVO.getUsrSeq());
		} else {
			cntntsAuthVO.setUsrSeq("0");
		}		

		CntntsAuthVO nttAuthVO = cntntsAuthService.selectCntntsAuthForNtt(cntntsAuthVO);		
		
		model.addAttribute("nttAuthVO", nttAuthVO);			
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("editorEstbsSe", EgovProperties.getProperty("Globals.editorEstbs"));
		
		return "wzwg/module/ntt/simp/nttList"; 
	}
	
	/**
	 * ㅁ 간단게시판 - 데이터관리 - 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/simp/registNttSimpInfoAjax.do")
	public ModelAndView registNttSimpInfo(
			@ModelAttribute("paramVO") ModuleNttSimpVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setNtcrId(loginVO.getUserId());
			paramVO.setNtcrSeq(loginVO.getUsrSeq());
			paramVO.setNtcrNm(loginVO.getUserNm());
		}
		
		result = nttSimpDataManageService.registNttSimpInfo(paramVO);	// 저장
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
		
	}
	
	/**
	 * ㅁ 간단게시판 - 데이터관리 - 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/simp/modifyNttSimpInfoAjax.do")
	public ModelAndView modifyNttSimpInfo(
			@ModelAttribute("paramVO") ModuleNttSimpVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
			paramVO.setNtcrSeq(loginVO.getUsrSeq());
		}
		
		result = nttSimpDataManageService.modifyNttSimpInfo(paramVO);	// 수정
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
		
	}
	
	/**
	 * ㅁ 간단게시판 - 데이터관리 - 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/simp/deleteNttSimpInfoAjax.do")
	public ModelAndView deleteNttSimpInfo(
			@ModelAttribute("paramVO") ModuleNttSimpVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
			paramVO.setNtcrSeq(loginVO.getUsrSeq());
		}
		
		if(paramVO.getCheckSimpnttSeq() == null){
			result = nttSimpDataManageService.deleteNttSimpInfo(paramVO);			// 삭제
		}else{
			result = nttSimpDataManageService.deleteCheckNttSimpInfo(paramVO);	// 체크박스 목록 삭제
		}		
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ 간단게시판 - 휴지통 - 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/simp/selectNttRecycleListAjax.do")
	public String selectNttRecycleList(
			@ModelAttribute("paramVO") ModuleNttSimpVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		paramVO.setPageUnit(propertyService.getInt("pageUnit"));
		paramVO.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
		paginationInfo.setPageSize(paramVO.getPageSize());

		paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
		paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		ModuleBbsVO resultVO = new ModuleBbsVO();
		
		resultVO.setBbsSeq(paramVO.getBbsSeq());
		
		// 게시판 기본정보
		resultVO = bbsSimpBassInfoService.selectBbsBassInfoDetail(resultVO);
		
		model.addAttribute("resultVO", resultVO);		

    	// 목록
		List<ModuleNttSimpVO> resultList = nttSimpDataManageService.selectNttSimpRecycleList(paramVO);
		
		// 목록 총 갯수
		Integer resultCnt = nttSimpDataManageService.selectNttSimpRecycleListTotCnt(paramVO);
		
		paginationInfo.setTotalRecordCount(resultCnt.intValue());
		
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		// 게시판 권한
		CntntsAuthVO cntntsAuthVO = new CntntsAuthVO();
		cntntsAuthVO.setCntntsSeq(paramVO.getSitecntntsSeq());
		cntntsAuthVO.setSiteSeq(paramVO.getSiteSeq());
		
		if(loginVO != null){
			cntntsAuthVO.setUsrSeq(loginVO.getUsrSeq());
		} else {
			cntntsAuthVO.setUsrSeq("0");
		}		

		CntntsAuthVO nttAuthVO = cntntsAuthService.selectCntntsAuthForNtt(cntntsAuthVO);		
		
		model.addAttribute("nttAuthVO", nttAuthVO);			
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt",  resultCnt);
		model.addAttribute("paginationInfo", 	paginationInfo);
		
		return "wzwg/module/ntt/simp/nttRecycleList"; 
	}	
	
	/**
	 * ㅁ 휴지통 - 복원
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/simp/modifyNttRecycleAjax.do")
	public ModelAndView modifyNttRecycle(
			@ModelAttribute("paramVO") ModuleNttSimpVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
			paramVO.setNtcrSeq(loginVO.getUsrSeq());
		}
		
		if(paramVO.getCheckSimpnttSeq() == null){
			result = nttSimpDataManageService.modifyNttSimpRecycle(paramVO);			// 복원
		}else{
			result = nttSimpDataManageService.modifyCheckNttSimpRecycle(paramVO);	// 체크박스 목록 복원
		}
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}	
	
	/**
	 * ㅁ 휴지통 - 선택삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/simp/deleteSimpNttAjax.do")
	public ModelAndView deleteSimpNtt(
			@ModelAttribute("paramVO") ModuleNttSimpVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if(loginVO == null){
			paramVO.setBbsSeq("0");
		}		
		
		paramVO.setDelSe("");
		result = nttSimpDataManageService.deleteSiteSimpNtt(paramVO);

		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}	
	
	/**
	 * ㅁ 휴지통 - 전체삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/simp/deleteSimpNttAllAjax.do")
	public ModelAndView deleteSimpNttAll(
			@ModelAttribute("paramVO") ModuleNttSimpVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if(loginVO == null){
			paramVO.setBbsSeq("0");
		}		
		
		paramVO.setDelSe("ALL");
		result = nttSimpDataManageService.deleteSiteSimpNtt(paramVO);

		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}	
}
