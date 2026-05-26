package egovframework.wzwg.module.calc.web;

import java.util.HashMap;
import java.util.IllegalFormatException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.calc.service.ModuleCalcService;
import egovframework.wzwg.module.calc.service.ModuleCalcVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ModuleCalcController {
	@Resource(name="ModuleCalcService")
	ModuleCalcService moduleCalcService;
	
	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;
	
	/**
	 * 금융계산기 데이터 상세
	 */
	@RequestMapping(value="/**/module/calc/selectCalcDetailAjax.do")
	public String selectCalcDetailAjax(
			@ModelAttribute("paramVO") ModuleCalcVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		/** 금융계산기 세율 리스트 조회(SYSCODE) */
		List<CmmCodeVO> codeList = codeService.selectCmmCodeList("CALC_GRP_CODE");
		
		model.addAttribute("codeList", codeList);
		
		model.addAttribute("result", moduleCalcService.selectModuleCalcDetail(paramVO));
		model.addAttribute("resultVO",paramVO);
		return "wzwg/module/calc/calcDetail";
	}
	
	/**
	 * 금융계산기 데이터 등록 폼
	 */
//	@RequestMapping(value="/**/module/calc/registModuleCalcFormAjax.do")
//	public String registModuleCalcFormAjax(
//			@ModelAttribute("paramVO") ModuleCalcVO paramVO
//			, HttpServletRequest request 
//			, ModelMap model
//		) throws Exception{
//		
//		/** 수정일때는 등록되어있는 데이터 조회 // 등록일 경우에는 적용되어있는 템플릿 조회 */
//		if(!("").equals(paramVO.getCalcSeq())){
//
//			/** 사이트 시퀀스 입력 */
//			String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
//			paramVO.setSiteSeq(siteSeq);
//			
//			ModuleCalcVO resultVO = moduleCalcService.selectModuleCalcDetail(paramVO);
//			model.addAttribute("resultVO", resultVO);
//			
//		}else{
//			model.addAttribute("resultVO", paramVO);
//		}
//		
//		return "wzwg/module/calc/calcForm";
//	}

	
	/**
	 * 금융계산기 데이터 등록 
	 */
	@RequestMapping(value="/**/module/calc/registModuleCalcAjax.do")
	public ModelAndView registModuleCntntsCnAjax(
			@ModelAttribute("paramVO") ModuleCalcVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setUserId(loginVO.getUserId());

			moduleCalcService.registModuleCalcAjax(paramVO);
		
			return CmmAjaxUtil.getAjaxReturn("success");
	}
	
	/**
	 * 금융계산기 데이터 수정 
	 */
	@RequestMapping(value="/**/module/calc/modifyModuleCalcAjax.do")
	public ModelAndView modifyModuleCalcAjax(
			@ModelAttribute("paramVO") ModuleCalcVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setUserId(loginVO.getUserId());

			int resultCnt = moduleCalcService.modifyModuleCalcAjax(paramVO);
			if(resultCnt >0){
				return CmmAjaxUtil.getAjaxReturn("success");
			}else{
				return CmmAjaxUtil.getAjaxReturn("fail");
			}
	}
	
	
	/**
	 * 금융계산기 데이터 컨텐츠 삭제 
	 */
	@RequestMapping(value="/**/module/calc/modifyModuleCalcCnDeleteAjax.do")
	public ModelAndView modifyModuleCalcCnDeleteAjax(
			@ModelAttribute("paramVO") ModuleCalcVO paramVO
			, HttpServletRequest request 
			, ModelMap model
			) throws Exception{
		
		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setUserId(loginVO.getUserId());
		
		int resultCnt = moduleCalcService.modifyModuleCalcCnDeleteAjax(paramVO);
		if(resultCnt >0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	
	/**
	 * 금융계산기 데이터 삭제 
	 */
	@RequestMapping(value="/**/module/calc/deleteModuleCalcAjax.do")
	public ModelAndView deleteModuleCntntsCnAjax(
			@ModelAttribute("paramVO") ModuleCalcVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		paramVO.setUserId(loginVO.getUserId());
		
		int deleteResult = moduleCalcService.deleteModuleCalcAjax(paramVO);
		
		if(deleteResult > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * 금융계산기 보기
	 */
	@RequestMapping(value="/**/module/calc/selectCalcViewAjax.do")
	public String selectCalcViewAjax(
			@ModelAttribute("paramVO") ModuleCalcVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		ModuleCalcVO result = moduleCalcService.selectModuleCalcDetail(paramVO);
		
		model.addAttribute("result", result);
       
		return "wzwg/module/calc/" + paramVO.getCalcType();
	}

	
	/**
	 * 유저페이지
	 * @param args
	 */
	
	/**
	 * 금융계산기 보기
	 */
	@RequestMapping(value="/**/module/calc/selectUsrCalcDetailAjax.do")
	public String selectUsrCalcDetailAjax(
			@ModelAttribute("paramVO") ModuleCalcVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		try {
			paramVO.setCalcinfoSeq(paramVO.getCntntsSeq());
			
		}catch(NullPointerException e){
			log.error("NullPointerException",e);
    	}catch(NumberFormatException e){
    		log.error("NumberFormatException",e);
    	}catch(IllegalFormatException e){
    		log.error("IllegalFormatException",e);
    	}catch(ArrayIndexOutOfBoundsException e){
    		log.error("ArrayIndexOutOfBoundsException",e);
    	}   
		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		
		/** 금융계산기 세율 리스트 조회(SYSCODE) */
		List<CmmCodeVO> codeList = codeService.selectCmmCodeList("CALC_GRP_CODE");
		
		model.addAttribute("codeList", codeList);
		
		model.addAttribute("result", moduleCalcService.selectModuleCalcDetail(paramVO));
		model.addAttribute("resultVO",paramVO);
		model.addAttribute("userMode","true");
		return "wzwg/module/calc/calcUsrDetail";
	}
	
	/**
	 * 수퍼관리자
	 */
	
	/**
	 * 금융계산기 데이터 상세
	 */
	@RequestMapping(value="/**/module/calc/selectCalcTax.do")
	public String selectCalcTax(
			@ModelAttribute("paramVO") ModuleCalcVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		
		
		/** 금융계산기 세율 리스트 조회(SYSCODE) */
		List<CmmCodeVO> codeList = codeService.selectCmmCodeList("CALC_GRP_CODE");
		
		model.addAttribute("codeList", codeList);
       
		return "wzwg/module/calc/calcTax";
	}
	
	/**
	 * 금융계산기 데이터 상세
	 */
	@RequestMapping(value="/**/module/calc/modifyCalcTaxAjax.do")
	public String modifyCalcTaxAjax(
			@RequestParam Map<String, String> paramVO
			, HttpServletRequest request 
			, ModelMap model
			) throws Exception{
		
		
		
		/** 금융계산기 세율 리스트 조회(SYSCODE) */
		List<CmmCodeVO> codeList = codeService.selectCmmCodeList("CALC_GRP_CODE");
		//model.addAttribute("codeList", codeList);
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		//paramVO.setUserId(loginVO.getUserId());
		int dataCnt = -1;
		//System.out.println(paramVO);
		for (CmmCodeVO cmmCodeVO : codeList) {
			Iterator<String> i = paramVO.keySet().iterator();
			String dataKey = cmmCodeVO.getCode();
			while(i.hasNext()){
				String paramKey = i.next(); // 파라미터의 키 이름을 찾아서
				
				if(dataKey.equals(paramKey)){ // 파라미터 키 이름과 code 값이 같으면 codeDc에 넘어온 값을 넣어서 수정한다
					cmmCodeVO.setCodeDc(paramVO.get(paramKey));
					cmmCodeVO.setUserId(loginVO.getUserId());
					cmmCodeVO.setUseAt("Y");
					if(codeService.modifyCodeInfo(cmmCodeVO) > 0){
						dataCnt++;
					};
				}
				
			}
			
		}
		
//		int resultCnt = moduleCalcService.modifyModuleCalcAjax(paramVO);
		Map<String, String> ajaxResponse = new HashMap<String, String>();
		if(dataCnt > 0){
			ajaxResponse.put("result", "success");
		}else{
			ajaxResponse.put("result", "fail");
		}
		model.addAttribute("ajaxResponse", ajaxResponse);
		return "wzwg/webModule/json";
	}
}
