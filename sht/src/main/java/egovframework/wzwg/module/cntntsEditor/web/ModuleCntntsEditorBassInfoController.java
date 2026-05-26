package egovframework.wzwg.module.cntntsEditor.web;

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
import egovframework.wzwg.module.cntnts.service.ModuleCntntsBassInfoService;
import egovframework.wzwg.module.cntnts.service.ModuleCntntsVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeVO;
import egovframework.wzwg.sysMngr.cntntsMngr.cntntsTmplat.service.CntntsTmplatService;
import egovframework.wzwg.sysMngr.cntntsMngr.cntntsTmplat.service.CntntsTmplatVO;

@Controller
public class ModuleCntntsEditorBassInfoController {
	
	@Resource(name="ModuleCntntsBassInfoService")
	ModuleCntntsBassInfoService moduleCntntsBassInfoService;
	
	@Resource(name="CntntsTmplatService")
	CntntsTmplatService cntntsTmplatService;
	
	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;

	/** 
	 * 컨텐츠 리스트 조회(메인)
	 */
	@RequestMapping(value={"/**/module/cntntsEditor/selectModuleCntntsInc.do","/{siteKey}/**/module/cntntsEditor/selectModuleCntntsInc.do"})
	public String selectModuleCntntsInc(
			@ModelAttribute("paramVO") ModuleCntntsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		List<ModuleCntntsVO> moduleCntntsList = moduleCntntsBassInfoService.selectModuleCntntsList(paramVO);
		
    	if(paramVO.getCntntsSeq() == null && moduleCntntsList.size() > 0){
    		paramVO.setCntntsSeq(moduleCntntsList.get(0).getCntntsSeq());
    	}
		
		model.addAttribute("moduleCntntsList", moduleCntntsList);
		
		return "wzwg/module/cntntsEditor/cntntsEditorInc";
	}
	
	/** 
	 * 컨텐츠 기본정보 상세(폼)
	 */
	@RequestMapping(value={"/**/module/cntntsEditor/selectCntntsBassInfoDetailAjax.do", "/**/module/cntntsEditor/cntntsFormAjax.do"})
	public String registModuleCntntsFormAjax(
			@ModelAttribute("paramVO") ModuleCntntsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		ModuleCntntsVO cntntsBassInfoVO = new ModuleCntntsVO();
		cntntsBassInfoVO = moduleCntntsBassInfoService.selectCntntsBassInfoDetail(paramVO);

		/** 사용자 유형 리스트 조회(SYSCODE) */
		List<CmmCodeVO> codeList = codeService.selectCmmCodeList("TMPLAT_CL_CODE");
		model.addAttribute("codeList", codeList);

		if(cntntsBassInfoVO != null){
		    cntntsBassInfoVO.setSitecntntsSeq(paramVO.getSitecntntsSeq());
			model.addAttribute("resultVO", cntntsBassInfoVO);
		}else{
			model.addAttribute("resultVO", paramVO);
		}
		
		return "/wzwg/module/cntntsEditor/cntntsEditorBassForm";
	}
	
	/**
	 * 템플릿 리스트 조회(SELECT BOX에서 사용)
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/cntntsEditor/selectCntntsTmplatListAjax.do")
    public ModelAndView selectCntntsTmplatListAjax(
    		ModuleCntntsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
    	) throws Exception {
		
		/** 컨텐츠 템플릿 리스트 조회 */
		CntntsTmplatVO cntntsTmplatVO = new CntntsTmplatVO();
		cntntsTmplatVO.setRecordCountPerPage(10000);
		cntntsTmplatVO.setFirstIndex(0);
		cntntsTmplatVO.setCodeSeq(paramVO.getCodeSeq());
		List<CntntsTmplatVO> cntntsTmplatList = cntntsTmplatService.selectCntntsTmplatList(cntntsTmplatVO);
		/**--------------------------*/
		
		return CmmAjaxUtil.getAjaxReturnList(cntntsTmplatList, "tmplatSeq", "tmplatSj", true);
    }
	
	/**
	 * 템플릿 리스트 조회(텍스트 검색해서 사용)
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/cntntsEditor/selectCntntsTmplatListSearchAjax.do")
    public String selectCntntsTmplatListSearchAjax(
    		@ModelAttribute("paramVO") ModuleCntntsVO paramVO
    		, String target
			, HttpServletRequest request 
			, ModelMap model
    	) throws Exception {
		
		/** 컨텐츠 템플릿 리스트 조회 */
		CntntsTmplatVO cntntsTmplatVO = new CntntsTmplatVO();
		cntntsTmplatVO.setRecordCountPerPage(10000);
		cntntsTmplatVO.setFirstIndex(0);
		cntntsTmplatVO.setSearchCondition(paramVO.getSearchCondition());
		cntntsTmplatVO.setSearchKeyword(paramVO.getSearchKeyword());
		List<CntntsTmplatVO> resultList = cntntsTmplatService.selectCntntsTmplatList(cntntsTmplatVO);
		/**--------------------------*/
		model.addAttribute("resultList", resultList);
		
		if(target != null && target.equals("cnDetail")){
			return "/wzwg/module/cntntsEditor/cn/tmplatListPopup";
		}else{
			return "/wzwg/module/cntntsEditor/tmplatListPopup";
		}
    }
	
	/**
	 * 컨텐츠 기본정보 등록
	 */
	@RequestMapping(value="/**/module/cntntsEditor/registModuleCntntsAjax.do")
	public ModelAndView registModuleCntntsAjax(
			@ModelAttribute("paramVO") ModuleCntntsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setUserId(loginVO.getUserId());
		
		int registResult = moduleCntntsBassInfoService.registModuleCntntsAjax(paramVO);
		
		if(registResult > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * 컨텐츠 기본정보 수정
	 */
	@RequestMapping(value="/**/module/cntntsEditor/modifyModuleCntntsAjax.do")
	public ModelAndView modifyModuleCntntsAjax(
			@ModelAttribute("paramVO") ModuleCntntsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setUserId(loginVO.getUserId());
		
		int modifyResult = moduleCntntsBassInfoService.modifyModuleCntntsAjax(paramVO);
		
		if(modifyResult > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * 컨텐츠 템플릿정보 수정
	 */
	@RequestMapping(value="/**/module/cntntsEditor/modifyModuleCntntsTmplatAjax.do")
	public ModelAndView modifyModuleCntntsTmplatAjax(
			@ModelAttribute("paramVO") ModuleCntntsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
			) throws Exception{
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setUserId(loginVO.getUserId());
		
		int modifyResult = moduleCntntsBassInfoService.modifyModuleCntntsTmplatAjax(paramVO);
		
		if(modifyResult > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
}
