package egovframework.wzwg.module.onlineQustnr.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrIemVO;
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrQesitmService;
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrQesitmVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeVO;

@Controller
public class ModuleOnlineQustnrQesitmController {
	
	@Resource(name="ModuleOnlineQustnrQesitmService")
	ModuleOnlineQustnrQesitmService onlineQustnrQesitmService;

	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;

	
	/**
	 * @Method Name : selectOnlineQustnrQesitmList
	 * @Method 설명 : 설문 문항 리스트 조회
	 * @작성일 : 2019. 7. 1.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/mngr/module/onlineQustnr/selectOnlineQustnrQesitmListAjax.do","/{siteKey}/mngr/module/onlineQustnr/selectOnlineQustnrQesitmListAjax.do"})
	public String selectOnlineQustnrQesitmList(
			@ModelAttribute("paramVO")ModuleOnlineQustnrQesitmVO paramVO
			, HttpServletRequest request
			, Model model
			){
		
		List<ModuleOnlineQustnrQesitmVO> resultList = onlineQustnrQesitmService.selectOnlineQustnrQesitmList(paramVO);
		model.addAttribute("resultList", resultList);
		
		return "wzwg/module/onlineQustnr/qustnrQesitmListAjax";
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectOnlineQustnrQesitmFormPopup
	 * @Method 설명 : 설문 문항 등록/수정 폼
	 * @작성일 : 2019. 7. 1.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/mngr/module/onlineQustnr/selectOnlineQustnrQesitmFormPopup.do","/{siteKey}/mngr/module/onlineQustnr/selectOnlineQustnrQesitmFormPopup.do"})
	public String selectOnlineQustnrQesitmFormPopup(
			@ModelAttribute("paramVO")ModuleOnlineQustnrQesitmVO paramVO
			, HttpServletRequest request
			, Model model
			) throws Exception{
		
		/** 문항 유형 리스트 조회(SYSCODE) */
		List<CmmCodeVO> codeList = codeService.selectCmmCodeList("QESITM_TY_CODE");
		model.addAttribute("codeList", codeList);
		
		/** 설문 항목 리스트 조회 */
		if(!("").equals(StringUtils.defaultString(paramVO.getQesitmSeq()))){
			
			/** 설문 문항 상세조회 */
			ModuleOnlineQustnrQesitmVO resultVO = onlineQustnrQesitmService.selectOnlineQustnrQesitmDetail(paramVO) ;
			model.addAttribute("resultVO", resultVO);
			
			/** 설문 항목 리스트 조회*/
			ModuleOnlineQustnrIemVO iemVO = new ModuleOnlineQustnrIemVO();
			iemVO.setQesitmSeq(resultVO.getQesitmSeq());
			List<ModuleOnlineQustnrIemVO> iemList = onlineQustnrQesitmService.selectOnlineQustnrIemList(iemVO);
			model.addAttribute("iemList", iemList);
		}
		
		return "wzwg/module/onlineQustnr/qustnrQesitmForm";
	}
	
	/**
	 * @Method Name : registOnlineQustnrQesitmAjax
	 * @Method 설명 : 설문 문항 등록
	 * @작성일 : 2019. 7. 1.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/mngr/module/onlineQustnr/registOnlineQustnrQesitmAjax.do","/{siteKey}/mngr/module/onlineQustnr/registOnlineQustnrQesitmAjax.do"})
	public ModelAndView registOnlineQustnrQesitmAjax(
			@ModelAttribute("paramVO")ModuleOnlineQustnrQesitmVO paramVO
			, HttpServletRequest request
			, Model model
			){
		
		paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
		
		int result = onlineQustnrQesitmService.registOnlineQustnrQesitm(paramVO);

		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * @Method Name : modifyOnlineQustnrQesitmAjax
	 * @Method 설명 : 설문 문항 수정
	 * @작성일 : 2019. 7. 1.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/mngr/module/onlineQustnr/modifyOnlineQustnrQesitmAjax.do","/{siteKey}/mngr/module/onlineQustnr/modifyOnlineQustnrQesitmAjax.do"})
	public ModelAndView modifyOnlineQustnrQesitmAjax(
			@ModelAttribute("paramVO")ModuleOnlineQustnrQesitmVO paramVO
			, HttpServletRequest request
			, Model model
			){
		
		paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
		
		int result = onlineQustnrQesitmService.modifyOnlineQustnrQesitm(paramVO);

		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * @Method Name : deleteOnlineQustnrQesitmAjax
	 * @Method 설명 : 설문 문항 삭제
	 * @작성일 : 2019. 7. 1.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/mngr/module/onlineQustnr/deleteOnlineQustnrQesitmAjax.do","/{siteKey}/mngr/module/onlineQustnr/deleteOnlineQustnrQesitmAjax.do"})
	public ModelAndView deleteOnlineQustnrQesitmAjax(
			@ModelAttribute("paramVO")ModuleOnlineQustnrQesitmVO paramVO
			, HttpServletRequest request
			, Model model
			){
		
		paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
		
		int result = onlineQustnrQesitmService.deleteOnlineQustnrQesitm(paramVO);

		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * @Method Name : deleteOnlineQustnrQesitmArr
	 * @Method 설명 : 설문 문항 체크박스 삭제
	 * @작성일 : 2019. 7. 1.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/mngr/module/onlineQustnr/deleteOnlineQustnrQesitmArrAjax.do","/{siteKey}/mngr/module/onlineQustnr/deleteOnlineQustnrQesitmArrAjax.do"})
	public ModelAndView deleteOnlineQustnrQesitmArr(
			@ModelAttribute("paramVO")ModuleOnlineQustnrQesitmVO paramVO
			, HttpServletRequest request
			, Model model
			){
		
		paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
		
		int result = onlineQustnrQesitmService.deleteOnlineQustnrQesitmArr(paramVO);

		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * @Method Name : modifyOnlineQustnrQesitmOrdr
	 * @Method 설명 : 설문 문항 순서 변경
	 * @작성일 : 2019. 7. 1.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/mngr/module/onlineQustnr/modifyOnlineQustnrQesitmOrdrAjax.do","/{siteKey}/mngr/module/onlineQustnr/modifyOnlineQustnrQesitmOrdrAjax.do"})
	public ModelAndView modifyOnlineQustnrQesitmOrdr(
			@ModelAttribute("paramVO")ModuleOnlineQustnrQesitmVO paramVO
			, HttpServletRequest request
			, Model model
			){
		
		paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
		
		int result = onlineQustnrQesitmService.modifyOnlineQustnrQesitmOrdr(paramVO);

		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
}
