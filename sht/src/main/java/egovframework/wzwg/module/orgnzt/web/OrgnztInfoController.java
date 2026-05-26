package egovframework.wzwg.module.orgnzt.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmJsonAjaxResponser;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsCmmnService;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsCssVO;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;
import egovframework.wzwg.module.orgnzt.service.OrgnztInfoService;
import egovframework.wzwg.module.orgnzt.service.OrgnztInfoVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;

@Controller
public class OrgnztInfoController {
	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;
	
	/** 조직도 */
	@Resource(name="OrgnztInfoService")
	private OrgnztInfoService orgnztInfoService;
	
	/** 시도코드 */
	//@Resource(name="OrgCtrdService")
	//private OrgCtrdService orgCtrdService;
	
	/** ModuleBbsCmmnService */
    @Resource(name="ModuleBbsCmmnService")
    protected ModuleBbsCmmnService bbsCmmnService;
	
	
	
	/**
	 * 관리자 - 조직도 정보 조회
	 */
	@RequestMapping(value= {"/mngr/module/orgnztInfo/selectOrgnztInfo.do","/{siteKey}/mngr/module/orgnztInfo/selectOrgnztInfo.do"})
	public String selectOrgnztInfo(
			@ModelAttribute("paramVO") OrgnztInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		
		paramVO.setSiteSeq(siteSeq);

		
		ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
		moduleBbsVO.setSysmoduleSeq("10000000219");
		List<ModuleBbsCssVO> cssList = bbsCmmnService.selectSysmoduleBbsCssList(moduleBbsVO);
		model.addAttribute("cssList", cssList);
		
		OrgnztInfoVO orgnztEstbsVO = orgnztInfoService.selectOrgnztEstbs(paramVO);
		model.addAttribute("orgnztEstbsVO", orgnztEstbsVO);
		
		return "/wzwg/module/orgnztInfo/orgnztInfo";
	}
	
	
	/**
	 * 관리자 - 조직도 데이터 리스트
	 */
	@RequestMapping(value= {"/mngr/module/orgnztInfo/selectOrgnztInfoDataListAjax.do","/{siteKey}/mngr/module/orgnztInfo/selectOrgnztInfoDataListAjax.do"})
	public String selectOrgnztInfoDataListAjax(
			@ModelAttribute("paramVO") OrgnztInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
			) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		model.addAttribute("orgnztInfoList", orgnztInfoService.selectOrgnztInfoList(paramVO));
		
		return "/wzwg/module/orgnztInfo/orgnztInfoDataListAjax";
	}
	
	
	/**
	 * 관리자 - 조직도 등록 폼
	 */
	@RequestMapping(value= {"/mngr/module/orgnztInfo/selectOrgnztInfoRegistFrmAjax.do","/{siteKey}/mngr/module/orgnztInfo/selectOrgnztInfoRegistFrmAjax.do"})
	public String selectOrgnztInfoRegistFrm(
			@ModelAttribute("paramVO") OrgnztInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		model.addAttribute("orgnztInfoList", orgnztInfoService.selectOrgnztInfoList(paramVO));
		model.addAttribute("paramVO", paramVO);

		return "/wzwg/module/orgnztInfo/orgnztInfoRegistForm";
	}
	
	
	/**
	 * 관리자 - 조직도 등록
	 */
	@RequestMapping(value= {"/mngr/module/orgnztInfo/registOrgnztInfoAjax.do","/{siteKey}/mngr/module/orgnztInfo/registOrgnztInfoAjax.do"})
	public String registOrgnztInfoAjax(
			@ModelAttribute("paramVO") OrgnztInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setFrstRegisterId(loginVO.getUserId());
		
		
		int result = orgnztInfoService.registOrgnztInfoAjax(paramVO);
        
        if(result > 0){
            return CmmJsonAjaxResponser.getInstance().setResultCode("success").returnJsp(model);
        }else{
        	return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
        }
	}
	

	
	/**
	 * 관리자 - 조직도 수정 폼
	 */
	@RequestMapping(value= {"/mngr/module/orgnztInfo/selectOrgnztInfoModifyFrmAjax.do","/{siteKey}/mngr/module/orgnztInfo/selectOrgnztInfoModifyFrmAjax.do"})
	public String selectOrgnztInfoModifyFrm(
			@ModelAttribute("paramVO") OrgnztInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);

		model.addAttribute("orgnztInfoVO", orgnztInfoService.selectOrgnztInfo(paramVO));
		model.addAttribute("paramVO", paramVO);

		return "/wzwg/module/orgnztInfo/orgnztInfoModifyForm";
	}
	
	
	/**
	 * 관리자 - 조직도 수정 
	 */
	@RequestMapping(value= {"/mngr/module/orgnztInfo/modifyOrgnztInfoAjax.do","/{siteKey}/mngr/module/orgnztInfo/modifyOrgnztInfoAjax.do"})
	public String modifyOrgnztInfoAjax(
			@ModelAttribute("paramVO") OrgnztInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setLastUpdusrId(loginVO.getUserId());
		
		
		int result = orgnztInfoService.modifyOrgnztInfoAjax(paramVO);
        
        if(result > 0){
            return CmmJsonAjaxResponser.getInstance().setResultCode("success").returnJsp(model);
        }else{
        	return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
        }
	}
	
	/**
	 * 관리자 - 조직도 삭제 (그룹)
	 */
	@RequestMapping(value= {"/mngr/module/orgnztInfo/deleteOrgnztInfoAjax.do","/{siteKey}/mngr/module/orgnztInfo/deleteOrgnztInfoAjax.do"})
	public String deleteOrgnztInfoAjax(
			@ModelAttribute("paramVO") OrgnztInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setLastUpdusrId(loginVO.getUserId());
		
		int orgnztMemCnt = orgnztInfoService.selectOrgnztInfoMemCnt(paramVO);
		
		if(orgnztMemCnt > 0) {
			return CmmJsonAjaxResponser.getInstance().setResultCode("useMem").returnJsp(model);
		}
		
		int orgnztLowGrpCnt = orgnztInfoService.selectOrgnztInfoLowGrpCnt(paramVO);
		
		if(orgnztLowGrpCnt > 0) {
			return CmmJsonAjaxResponser.getInstance().setResultCode("useGrp").returnJsp(model);
		}
		
		int result = orgnztInfoService.deleteOrgnztInfoAjax(paramVO);
        
        if(result > 0){
            return CmmJsonAjaxResponser.getInstance().setResultCode("success").returnJsp(model);
        }else{
        	return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
        }
	}
	
	/**
	 * 관리자 - 조직도 데이터 순서변경
	 * @param command (prev:이전, next:다음)
	 */
	@RequestMapping(value= {"/mngr/module/orgnztInfo/modifyOrgnztInfoOrdrAjax.do","/{siteKey}/mngr/module/orgnztInfo/modifyOrgnztInfoOrdrAjax.do"})
	public String modifyOrgnztInfoOrdrAjax(
			@ModelAttribute("paramVO") OrgnztInfoVO paramVO
			, HttpServletRequest request
			, String command
			, ModelMap model
			) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		int result = 0;

		OrgnztInfoVO orgnztInfoVO = orgnztInfoService.selectOrgnztInfoOrdrInfo(paramVO);
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		if(command != null) {
			result = orgnztInfoService.modifyOrgnztInfoOrdrAjax(orgnztInfoVO, command);
		}
		
		String resultCode = "";
		
		if(result == -1){
			resultCode = "notOrderby";
		}else if(result == 2){
			resultCode = "update";
		}else{
			resultCode = "updateFail";
		}
		
		return CmmJsonAjaxResponser.getInstance().setResultCode(resultCode).returnJsp(model);
	}	
	
	
	
	/**
	 * 관리자 - 조직도 그룹 구성원 리스트  
	 */
	@RequestMapping(value= {"/mngr/module/orgnztInfo/selectOrgnztInfoMemListAjax.do","/{siteKey}/mngr/module/orgnztInfo/selectOrgnztInfoMemListAjax.do"})
	public String selectOrgnztInfoMemListAjax(
			@ModelAttribute("paramVO") OrgnztInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
			) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		if(paramVO.getOrgnztSeq() != null && String.valueOf(paramVO.getOrgnztSeq()).equals("") == false){	
			paramVO.setOrgnztAcctoSearchSel(paramVO.getOrgnztSeq());
		}
		
		model.addAttribute("orgnztInfoMemList", orgnztInfoService.selectOrgnztInfoMemList(paramVO));
		//model.addAttribute("orgnztInfoMemCtrdList", orgnztInfoService.selectOrgnztInfoMemCtrdList(paramVO));
		model.addAttribute("paramVO", paramVO);
		
		return "/wzwg/module/orgnztInfo/orgnztInfoMemListAjax";
	}
	
	
	/**
	 * 관리자 - 조직도 그룹 구성원 등록 폼  
	 */
	@RequestMapping(value= {"/mngr/module/orgnztInfo/selectOrgnztInfoMemRegistFrmAjax.do","/{siteKey}/mngr/module/orgnztInfo/selectOrgnztInfoMemRegistFrmAjax.do"})
	public String selectOrgnztInfoMemRegistFrm(
			@ModelAttribute("paramVO") OrgnztInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		model.addAttribute("orgnztInfoMemList", orgnztInfoService.selectOrgnztInfoMemList(paramVO));
		model.addAttribute("paramVO", paramVO);	

		return "/wzwg/module/orgnztInfo/orgnztInfoMemRegistForm";
	}
	
	
	/**
	 * 관리자 - 조직도 그룹 구성원 등록  
	 */
	@RequestMapping(value= {"/mngr/module/orgnztInfo/registOrgnztInfoMemAjax.do","/{siteKey}/mngr/module/orgnztInfo/registOrgnztInfoMemAjax.do"})
	public String registOrgnztInfoMemAjax(
			@ModelAttribute("paramVO") OrgnztInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setFrstRegisterId(loginVO.getUserId());
		
		int result = orgnztInfoService.registOrgnztInfoMemAjax(paramVO);
        
        if(result > 0){
            return CmmJsonAjaxResponser.getInstance().setResultCode("success").returnJsp(model);
        }else{
        	return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
        }
	}
	
	
	/**
	 * 관리자 - 조직도 그룹 구성원 수정 폼  
	 */
	@RequestMapping(value= {"/mngr/module/orgnztInfo/selectOrgnztInfoMemModifyFrmAjax.do","/{siteKey}/mngr/module/orgnztInfo/selectOrgnztInfoMemModifyFrmAjax.do"})
	public String selectOrgnztInfoMemModifyFrm(
			@ModelAttribute("paramVO") OrgnztInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		model.addAttribute("orgnztInfoVO", orgnztInfoService.selectOrgnztInfoMem(paramVO));
		model.addAttribute("paramVO", paramVO);

		return "/wzwg/module/orgnztInfo/orgnztInfoMemModifyForm";
		                    
	}
	
	
	/**
	 * 관리자 - 조직도 그룹 구성원 순서변경
	 * @param command (prev:이전, next:다음)
	 */
	@RequestMapping(value= {"/mngr/module/orgnztInfo/modifyOrgnztMemOrdrAjax.do","/{siteKey}/mngr/module/orgnztInfo/modifyOrgnztMemOrdrAjax.do"})
	public String modifyOrgMemOrdrAjax(
			@ModelAttribute("paramVO") OrgnztInfoVO paramVO
			, HttpServletRequest request
			, String command
			, ModelMap model
			) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		int result = 0;

		OrgnztInfoVO orgnztInfoVO = orgnztInfoService.selectOrgnztMemOrdrInfo(paramVO);
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		if(command != null) {
			result = orgnztInfoService.modifyOrgnztMemOrdrAjax(orgnztInfoVO, command);
		}
		
		String resultCode = "";
		
		if(result == -1){
			resultCode = "notOrderby";
		}else if(result == 2){
			resultCode = "update";
		}else{
			resultCode = "updateFail";
		}
		
		return CmmJsonAjaxResponser.getInstance().setResultCode(resultCode).setBodyData("orgnztInfoVO", orgnztInfoVO).returnJsp(model);
	}	
	
	
	/**
	 * 관리자 - 조직도 그룹 구성원 수정  
	 */
	@RequestMapping(value= {"/mngr/module/orgnztInfo/modifyOrgnztInfoMemAjax.do","/{siteKey}/mngr/module/orgnztInfo/modifyOrgnztInfoMemAjax.do"})
	public String modifyOrgnztInfoMemAjax(
			@ModelAttribute("paramVO") OrgnztInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setLastUpdusrId(loginVO.getUserId());
		
		int result = orgnztInfoService.modifyOrgnztInfoMemAjax(paramVO);
        
        if(result > 0){
            return CmmJsonAjaxResponser.getInstance().setResultCode("success").returnJsp(model);
        }else{
        	return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
        }
	}
	
	
	/**
	 * 관리자 - 조직도 그룹 구성원의 그룹 이동  
	 */
	@RequestMapping(value= {"/mngr/module/orgnztInfo/modifyOrgnztInfoMemDeptAjax.do","/{siteKey}/mngr/module/orgnztInfo/modifyOrgnztInfoMemDeptAjax.do"})
	public String modifyOrgnztInfoMemDeptAjax(
			@ModelAttribute("paramVO") OrgnztInfoVO paramVO
			, HttpServletRequest request
			, ModelMap model
		) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setLastUpdusrId(loginVO.getUserId());
		
		int result = orgnztInfoService.modifyOrgnztInfoMemDeptAjax(paramVO);
		
		if(result > 0){
			return CmmJsonAjaxResponser.getInstance().setResultCode("success").returnJsp(model);
		}else{
			return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
		}
		
	}
	
	/**
	 * 관리자 - 조직도 그룹 구성원 리스트 reload
	 */
	@RequestMapping(value= {"/mngr/module/orgnztInfo/selectOrgnztInfoAjax.do","/{siteKey}/mngr/module/orgnztInfo/selectOrgnztInfoAjax.do"})
	public ModelAndView selectOrgnztInfoAjax(
			@ModelAttribute("paramVO") OrgnztInfoVO paramVO
			, HttpServletRequest request
			, String command
			, ModelMap model
			) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		ModelAndView mav= new ModelAndView();
		mav.addObject("orgnztInfoVO", orgnztInfoService.selectOrgnztInfo(paramVO));
	    mav.setViewName("jsonView");
	  
	    return mav;
	}	
	
	
	/**
	 * 관리자 - 조직도 그룹 구성원 삭제  
	 */
	@RequestMapping(value= {"/mngr/module/orgnztInfo/deleteOrgnztInfoMem.do","/{siteKey}/mngr/module/orgnztInfo/deleteOrgnztInfoMem.do"})
	public String modifyOrgnztInfoMem(
			@ModelAttribute("paramVO") OrgnztInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setLastUpdusrId(loginVO.getUserId());
		
		int result = orgnztInfoService.deleteOrgnztInfoMem(paramVO);
        
        if(result > 0){
            return CmmJsonAjaxResponser.getInstance().setResultCode("success").returnJsp(model);
        }else{
        	return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
        }
	}
	
	/**
	 * 관리자 - 조직도 디자인 저장
	 */
	@RequestMapping(value="/**/module/orgnztInfo/registOrgnztEstbsAjax.do")
	public String registSideQuickStbsAjax(
    		@ModelAttribute("paramVO")OrgnztInfoVO paramVO
    		, HttpServletRequest request
    		, Model model ) throws Exception {
    	
    	/** 사이트 시퀀스 */
    	String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
    	CmmLoginVO loginVO = (CmmLoginVO) request.getSession().getAttribute("loginVO");
    	paramVO.setSiteSeq(siteSeq);
    	
    	if (loginVO != null) {
    		paramVO.setFrstRegisterId(loginVO.getUserId());
    		paramVO.setLastUpdusrId(loginVO.getUserId());
    	}
    	
    	OrgnztInfoVO checkOrgnztVO = orgnztInfoService.selectOrgnztEstbs(paramVO);
    	int result = -1;
    	if(checkOrgnztVO == null) {
    		result = orgnztInfoService.registOrgnztEstbs(paramVO);
    	}else {
    		result = orgnztInfoService.modifyOrgnztEstbs(paramVO);
    	}
    	
    	String resultCode = "";
    	String orgnztEstbsSeq = "";
    	if(result > 0){
    		resultCode = "success";
    	}else{
    		resultCode = "fail";
    	}
    	
    
    	return CmmJsonAjaxResponser.getInstance().setResultCode(resultCode).setBodyData("orgnztEstbsSeq", orgnztEstbsSeq).returnJsp(model);
	 }
	
	
	/**
	 * 사용자 - 조직도 화면 조회
	 */
	@RequestMapping(value= {"/module/orgnztInfo/selectOrgnztUsrInfo.do","/{siteKey}/module/orgnztInfo/selectOrgnztUsrInfo.do"})
	public String selectOrgUsrInfo(
			@ModelAttribute("paramVO") OrgnztInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		model.addAttribute("orgnztInfoList",  orgnztInfoService.selectOrgnztInfoList(paramVO));
		model.addAttribute("paramVO", paramVO);
		
		OrgnztInfoVO orgnztEstbsVO = orgnztInfoService.selectOrgnztEstbs(paramVO);
		model.addAttribute("orgnztEstbsVO", orgnztEstbsVO);
		
		return "/wzwg/module/orgnztInfo/orgnztUsrInfo";
	}
		
	
	/**
	 * 사용자 - 조직도 그룹 구성원 리스트
	 */
	@RequestMapping(value= {"/module/orgnztInfo/selectOrgUsrInfoMemListAjax.do","/{siteKey}/module/orgnztInfo/selectOrgUsrInfoMemListAjax.do"})
	public String selectOrgUsrInfoMemListAjax(
			@ModelAttribute("paramVO") OrgnztInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
			) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		String orgDcKr = "";
		
		if(paramVO.getOrgnztSeq() != null && String.valueOf(paramVO.getOrgnztSeq()).equals("") == false){	
			OrgnztInfoVO orgnztInfoVO = orgnztInfoService.selectOrgnztInfoOrdrInfo(paramVO);
			orgDcKr = orgnztInfoVO.getOrgnztDcKr();
			paramVO.setOrgnztAcctoSearchSel(paramVO.getOrgnztSeq());

		}else{
			orgDcKr = "";
			paramVO.setOrgnztTySe("allTySe");
		}
		
		model.addAttribute("orgnztInfoMemList", orgnztInfoService.selectOrgnztInfoMemList(paramVO));
		//model.addAttribute("orgnztInfoMemCtrdList", orgnztInfoService.selectOrgnztInfoMemCtrdList(paramVO));
		model.addAttribute("paramVO", paramVO);
		

		return CmmJsonAjaxResponser.getInstance()
				.setResultCode("success")
				.setBodyData("orgDcKr", orgDcKr)
				.setResultJsp("orgUsrInfoMemListAjax", "/wzwg/module/orgnztInfo/orgnztUsrInfoMemListAjax")
				.returnJsp(model);
	}
	

	
    
}
