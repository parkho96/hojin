package egovframework.wzwg.module.calc.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.calc.service.ModuleCalcBassInfoService;
import egovframework.wzwg.module.calc.service.ModuleCalcVO;
import egovframework.wzwg.sysMngr.cntntsMngr.cntntsTmplat.service.CntntsTmplatService;

@Controller
public class ModuleCalcBassInfoController {
	
	@Resource(name="ModuleCalcBassInfoService")
	ModuleCalcBassInfoService moduleCalcBassInfoService;
	
	@Resource(name="CntntsTmplatService")
	CntntsTmplatService cntntsTmplatService;
	
	/** 
	 * 금융계산기 리스트 조회(메인)
	 */
	@RequestMapping(value="/**/module/calc/selectCalcInc.do")
	public String selectCalcInc(
			@ModelAttribute("paramVO") ModuleCalcVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		List<ModuleCalcVO> moduleCalcList = moduleCalcBassInfoService.selectModuleCalcList(paramVO);
		
    	if(paramVO.getCalcinfoSeq() == null && moduleCalcList.size() > 0){
    		paramVO.setCalcinfoSeq(moduleCalcList.get(0).getCalcinfoSeq());
    	}
		
		model.addAttribute("moduleCalcList", moduleCalcList);
		
		return "wzwg/module/calc/calcInc";
	}
	
	/** 
	 * 금융계산기 기본정보 상세(폼)
	 */
	@RequestMapping(value={"/**/module/calc/selectCalcBassInfoDetailAjax.do", "/**/module/calc/calcFormAjax.do"})
	public String selectCalcBassInfoDetailAjax(
			@ModelAttribute("paramVO") ModuleCalcVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		//paramVO.setCalcinfoSeq(paramVO.getCntntsSeq());
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		ModuleCalcVO calcBassInfoVO = new ModuleCalcVO();
		calcBassInfoVO = moduleCalcBassInfoService.selectCalcBassInfoDetail(paramVO);

		
		if(calcBassInfoVO != null){
		    calcBassInfoVO.setCalcinfoSeq(paramVO.getCalcinfoSeq());
			model.addAttribute("resultVO", calcBassInfoVO);
		}else{
			model.addAttribute("resultVO", paramVO);
		}
		
		return "/wzwg/module/calc/calcBassForm";
	} 
	
	/**
	 * 금융계산기 기본정보 등록
	 */
	@RequestMapping(value="/**/module/calc/registModuleCalcInfoAjax.do")
	public ModelAndView registModuleCalcInfoAjax(
			@ModelAttribute("paramVO") ModuleCalcVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setUserId(loginVO.getUserId());
		
		int registResult = moduleCalcBassInfoService.registModuleCalcAjax(paramVO);
		
		if(registResult > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * 금융계산기 기본정보 수정
	 */
	@RequestMapping(value="/**/module/calc/modifyModuleCalcInfoAjax.do")
	public ModelAndView modifyModuleCalcAjax(
			@ModelAttribute("paramVO") ModuleCalcVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setUserId(loginVO.getUserId());
		
		int modifyResult = moduleCalcBassInfoService.modifyModuleCalcAjax(paramVO);
		
		if(modifyResult > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
}
