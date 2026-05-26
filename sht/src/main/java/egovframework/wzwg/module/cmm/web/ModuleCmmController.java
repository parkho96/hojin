package egovframework.wzwg.module.cmm.web;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmJsonAjaxResponser;
import egovframework.wzwg.module.cmm.service.MdCmmAddformService;
import egovframework.wzwg.module.cmm.service.MdCmmAddformVO;

@Controller
public class ModuleCmmController {

	@Resource(name="MdCmmAddformService")
	MdCmmAddformService mdCmmAddformService;
	
	/**
	 * ㅁ SNS 공유 팝업
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/cmm/snsCnrs/selectSnsCnrsPopup.do")
	public String selectSnsCnrs(
			@RequestParam(value="param_menuSeq", required=false) String param_menuSeq
			, @RequestParam(value="param_nttSeq", required=false) String param_nttSeq
			, @RequestParam(value="param_mvpnttSeq", required=false) String param_mvpnttSeq
			, @RequestParam(value="param_nttSj", required=false) String param_nttSj
			, @RequestParam(value="param_mobileAt", required=false) String param_mobileAt
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		model.addAttribute("pMenuSeq", param_menuSeq);
		model.addAttribute("pNttSeq", param_nttSeq);
		model.addAttribute("pMvpNttSeq", param_mvpnttSeq);
		model.addAttribute("pNttSj", param_nttSj);
		model.addAttribute("pMobileAt", param_mobileAt);
		
		return  "wzwg/module/cmm/snsCnrsPopup";
		
	}

	/**
	 * ㅁ 에디터 호출 모듈 폼 - 관리자
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/mngr/module/cmm/addform/selectMngrAddform.do")
	public String selectMngrAddform(
			@ModelAttribute("paramVO") MdCmmAddformVO paramVO
			, HttpServletRequest request 
			, ModelMap model
			) throws Exception{

		MdCmmAddformVO addformVO = mdCmmAddformService.selectAddformData(paramVO);
		model.addAttribute("addformVO", addformVO);
		
		return  "wzwg/module/cmm/addform/selectMngrAddform";
	}
	
	/**
	 * ㅁ 에디터 호출 모듈 폼 입력 및 수정 - 관리자
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/mngr/module/cmm/addform/registMngrAddform.do")
	public String registMngrAddform(
			@ModelAttribute("paramVO") MdCmmAddformVO paramVO
			, HttpServletRequest request 
			, ModelMap model
			) throws Exception{
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setFrstRegisterId(loginVO.getUserId());
		
		int result = mdCmmAddformService.registAddformData(paramVO);
		String resultCode = "";
		if(result > 0){
			resultCode = "success";
		}else{
			resultCode = "fail";
		}
		
		return  CmmJsonAjaxResponser.getInstance().setResultCode(resultCode).returnJsp(model);
	}
    
	/**
	 * ㅁ 에디터 호출 모듈 폼 - 사용자
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/module/cmm/addform/selectUsrAddform.do")
	public String selectUsrAddform(
			@ModelAttribute("paramVO") MdCmmAddformVO paramVO
			, HttpServletRequest request 
			, ModelMap model
			) throws Exception{
		
		MdCmmAddformVO addformVO = mdCmmAddformService.selectAddformData(paramVO);
		model.addAttribute("addformVO", addformVO);
		
		return  "wzwg/module/cmm/addform/selectUsrAddform";
	}
    
	/**
	 * ㅁ 에디터 호출 모듈 샘플
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/mngr/module/cmm/addform/selectSampleMngrAddform.do")
	public String selectSampleMngrAddform(
			@ModelAttribute("paramVO") MdCmmAddformVO paramVO
			, HttpServletRequest request 
			, ModelMap model
			) throws Exception{

		return  "wzwg/module/cmm/addform/selectSampleMngrForm";
	}
}
