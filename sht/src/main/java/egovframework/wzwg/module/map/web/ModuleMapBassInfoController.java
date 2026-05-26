package egovframework.wzwg.module.map.web;

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
import egovframework.wzwg.module.map.service.ModuleMapBassInfoService;
import egovframework.wzwg.module.map.service.ModuleMapVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeVO;
import egovframework.wzwg.sysMngr.cntntsMngr.cntntsTmplat.service.CntntsTmplatService;

@Controller
public class ModuleMapBassInfoController {
	
	@Resource(name="ModuleMapBassInfoService")
	ModuleMapBassInfoService moduleMapBassInfoService;
	
	@Resource(name="CntntsTmplatService")
	CntntsTmplatService cntntsTmplatService;
	
	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;
	
	/** 
	 * 컨텐츠 리스트 조회(메인)
	 */
	@RequestMapping(value={"/**/module/map/selectMapInc.do","/{siteKey}/**/module/map/selectMapInc.do"})
	public String selectMapInc(
			@ModelAttribute("paramVO") ModuleMapVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		List<ModuleMapVO> moduleMapList = moduleMapBassInfoService.selectModuleMapList(paramVO);
		
    	if(paramVO.getMapinfoSeq() == null && moduleMapList.size() > 0){
    		paramVO.setMapinfoSeq(moduleMapList.get(0).getMapinfoSeq());
    	}
		
		model.addAttribute("moduleMapList", moduleMapList);
		
		return "wzwg/module/map/mapInc";
	}
	
	/** 
	 * 컨텐츠 기본정보 상세(폼)
	 */
	@RequestMapping(value={"/**/module/map/selectMapBassInfoDetailAjax.do", "/**/module/map/mapinfoFormAjax.do"})
	public String selectMapBassInfoDetailAjax(
			@ModelAttribute("paramVO") ModuleMapVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		ModuleMapVO mapBassInfoVO = new ModuleMapVO();
		mapBassInfoVO = moduleMapBassInfoService.selectMapBassInfoDetail(paramVO);

		/** 사용자 유형 리스트 조회(SYSCODE) */
		List<CmmCodeVO> codeList = codeService.selectCmmCodeList("TMPLAT_CL_CODE");
		model.addAttribute("codeList", codeList);
		
		if(mapBassInfoVO != null){
		    mapBassInfoVO.setMapinfoSeq(paramVO.getMapinfoSeq());
		    mapBassInfoVO.setSitecntntsSeq(paramVO.getSitecntntsSeq()); 
		    model.addAttribute("resultVO", mapBassInfoVO);
		}else{
			model.addAttribute("resultVO", paramVO);
		}
		
		return "/wzwg/module/map/mapBassForm";
	} 
	
	/**
	 * 컨텐츠 기본정보 등록
	 */
	@RequestMapping(value="/**/module/map/registModuleMapInfoAjax.do")
	public ModelAndView registModuleMapInfoAjax(
			@ModelAttribute("paramVO") ModuleMapVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setUserId(loginVO.getUserId());
		
		int registResult = moduleMapBassInfoService.registModuleMapAjax(paramVO);
		
		if(registResult > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * 컨텐츠 기본정보 수정
	 */
	@RequestMapping(value="/**/module/map/modifyModuleMapInfoAjax.do")
	public ModelAndView modifyModuleMapAjax(
			@ModelAttribute("paramVO") ModuleMapVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setUserId(loginVO.getUserId());
		
		int modifyResult = moduleMapBassInfoService.modifyModuleMapAjax(paramVO);
		
		if(modifyResult > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
}
