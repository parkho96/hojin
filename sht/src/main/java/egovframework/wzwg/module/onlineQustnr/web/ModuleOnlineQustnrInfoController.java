package egovframework.wzwg.module.onlineQustnr.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.fcc.service.ExcelCreater;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrIemVO;
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrInfoService;
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrInfoVO;
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrQesitmService;
import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrQesitmVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeVO;
import egovframework.wzwg.sysMngr.usrMngr.usrTy.service.SysMngrUsrTyService;
import egovframework.wzwg.sysMngr.usrMngr.usrTy.service.SysMngrUsrTyVO;

@Controller
public class ModuleOnlineQustnrInfoController {
	
	/** 설문 서비스 */
	@Resource(name="ModuleOnlineQustnrInfoService")
	ModuleOnlineQustnrInfoService onlineQustnrInfoService;
	
	@Resource(name="ModuleOnlineQustnrQesitmService")
	ModuleOnlineQustnrQesitmService onlineQustnrQesitmService;
	
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
	
	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;

	/** 회원유형 서비스 */
	@Resource(name="SysMngrUsrTyService")
	private SysMngrUsrTyService sysMngrUsrTyService;
	
	/**
	 * @Method Name : selectOnlineQustnrInfoList
	 * @Method 설명 : 설문 리스트 조회
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/mngr/module/onlineQustnr/selectOnlineQustnrInfoList.do","/{siteKey}/mngr/module/onlineQustnr/selectOnlineQustnrInfoList.do"})
	public String selectOnlineQustnrInfoList(
			@ModelAttribute("paramVO")ModuleOnlineQustnrInfoVO paramVO
			, HttpServletRequest request
			, Model model
			){
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		/** =================== paging 시작 ============================== */
		PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
        paginationInfo.setPageSize(paramVO.getPageSize());
        
        paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
        paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        Integer totCnt = onlineQustnrInfoService.selectOnlineQustnrInfoTotCnt(paramVO);
        paginationInfo.setTotalRecordCount(totCnt.intValue());
        
        /* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
        /** =================== paging 끝 =============================== */

		List<ModuleOnlineQustnrInfoVO> resultList = onlineQustnrInfoService.selectOnlineQustnrInfoList(paramVO);
		
		model.addAttribute("resultList", resultList);

		model.addAttribute("totCnt", totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "wzwg/module/onlineQustnr/qustnrInfoList";
	}
	
	/**
	 * @Method Name : registOnlineQustnrInfoForm
	 * @Method 설명 : 설문 등록 폼
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value={"/mngr/module/onlineQustnr/registOnlineQustnrInfoForm.do","/{siteKey}/mngr/module/onlineQustnr/registOnlineQustnrInfoForm.do"})
	public String registOnlineQustnrInfoForm(
			@ModelAttribute("paramVO")ModuleOnlineQustnrInfoVO paramVO
			, HttpServletRequest request
			, Model model
			)throws Exception{
		
		/** 사용자 유형 리스트 조회 - start */
		SysMngrUsrTyVO sysMngrUsrTyVO = new SysMngrUsrTyVO();
		sysMngrUsrTyVO.setUseAt("Y");
		sysMngrUsrTyVO.setFirstIndex(0);
		sysMngrUsrTyVO.setRecordCountPerPage(100000);
		sysMngrUsrTyVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));

		List<SysMngrUsrTyVO> usrtyList = sysMngrUsrTyService.selectUsrTyList(sysMngrUsrTyVO);
		/** 사용자 유형 리스트 조회 - end */
		
		model.addAttribute("usrtyList", usrtyList);

		return "wzwg/module/onlineQustnr/qustnrInfoRegistForm";
	}
	
	/**
	 * @Method Name : registOnlineQustnrInfo
	 * @Method 설명 : 설문 등록
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/mngr/module/onlineQustnr/registOnlineQustnrInfoAjax.do","/{siteKey}/mngr/module/onlineQustnr/registOnlineQustnrInfoAjax.do"})
	public ModelAndView registOnlineQustnrInfo(
			@ModelAttribute("paramVO")ModuleOnlineQustnrInfoVO paramVO
			, HttpServletRequest request
			, Model model
			){

		paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));

		int result = onlineQustnrInfoService.registOnlineQustnrInfo(paramVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * @Method Name : modifyOnlineQustnrInfoForm
	 * @Method 설명 : 설문 수정 폼
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/mngr/module/onlineQustnr/modifyOnlineQustnrInfoForm.do","/{siteKey}/mngr/module/onlineQustnr/modifyOnlineQustnrInfoForm.do"})
	public String modifyOnlineQustnrInfoForm(
			@ModelAttribute("paramVO")ModuleOnlineQustnrInfoVO paramVO
			, HttpServletRequest request
			, Model model
			)throws Exception{
	
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));

		/** SYS코드 조회 */
		List<CmmCodeVO> codeList = codeService.selectCmmCodeList("QESITM_TY_CODE");
		
		/** 해당 설문에 적용중인 설문대상자 조회 */
		List<ModuleOnlineQustnrInfoVO> usrtyList = onlineQustnrInfoService.selectOnlineQustnrUsrtyList(paramVO);
		
		ModuleOnlineQustnrInfoVO resultVO = onlineQustnrInfoService.selectOnlineQustnrInfoDetail(paramVO);

		model.addAttribute("codeList", codeList);
		model.addAttribute("usrtyList", usrtyList);
		model.addAttribute("resultVO", resultVO);
		
		return "wzwg/module/onlineQustnr/qustnrInfoModifyForm";
	}
	
	
	/**
	 * @Method Name : modifyOnlineQustnrInfo
	 * @Method 설명 : 설문 수정
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/mngr/module/onlineQustnr/modifyOnlineQustnrInfoAjax.do","/{siteKey}/mngr/module/onlineQustnr/modifyOnlineQustnrInfoAjax.do"})
	public ModelAndView modifyOnlineQustnrInfo(
			@ModelAttribute("paramVO")ModuleOnlineQustnrInfoVO paramVO
			, HttpServletRequest request
			, Model model
			){

		paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
		
		int result = onlineQustnrInfoService.modifyOnlineQustnrInfo(paramVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * @Method Name : deleteOnlineQustnrInfo
	 * @Method 설명 : 설문 삭제 
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/mngr/module/onlineQustnr/deleteOnlineQustnrInfoAjax.do","/{siteKey}/mngr/module/onlineQustnr/deleteOnlineQustnrInfoAjax.do"})
	public ModelAndView deleteOnlineQustnrInfo(
			@ModelAttribute("paramVO")ModuleOnlineQustnrInfoVO paramVO
			, HttpServletRequest request
			, Model model
			){

		paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
		
		int result = onlineQustnrInfoService.deleteOnlineQustnrInfo(paramVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * @Method Name : deleteOnlineQustnrInfoArr
	 * @Method 설명 : 설문 삭제 (다중)
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/mngr/module/onlineQustnr/deleteOnlineQustnrInfoArrAjax.do","/{siteKey}/mngr/module/onlineQustnr/deleteOnlineQustnrInfoArrAjax.do"})
	public ModelAndView deleteOnlineQustnrInfoArr(
			@ModelAttribute("paramVO")ModuleOnlineQustnrInfoVO paramVO
			, HttpServletRequest request
			, Model model
			){

		paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
	
		int result = onlineQustnrInfoService.deleteOnlineQustnrInfoArr(paramVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * @Method Name : selectOnlineQustnrInfoResultPopup
	 * @Method 설명 : 설문 결과보기
	 * @작성일 : 2019. 7. 5.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/mngr/module/onlineQustnr/selectOnlineQustnrInfoResultPopup.do","/{siteKey}/mngr/module/onlineQustnr/selectOnlineQustnrInfoResultPopup.do"})
	public String selectOnlineQustnrInfoResultPopup(
			@ModelAttribute("paramVO")ModuleOnlineQustnrInfoVO paramVO
			, HttpServletRequest request
			, Model model
			){

		ModuleOnlineQustnrInfoVO resultVO = onlineQustnrInfoService.selectOnlineQustnrInfoDetail(paramVO);
		
		ModuleOnlineQustnrQesitmVO qesitmVO = new ModuleOnlineQustnrQesitmVO();
		qesitmVO.setQustnrSeq(paramVO.getQustnrSeq());
		List<ModuleOnlineQustnrQesitmVO> resultList = onlineQustnrQesitmService.selectOnlineQustnrQesitmList(qesitmVO);
		
		model.addAttribute("resultVO", resultVO);
		model.addAttribute("resultList", resultList);

		return "wzwg/module/onlineQustnr/qustnrResult";
	}

	/**
	 * @Method Name : selectOnlineQustnrIemResultList
	 * @Method 설명 : 설문 결과 항목 List조회
	 * @작성일 : 2019. 7. 8.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/mngr/module/onlineQustnr/selectOnlineQustnrIemResultListAjax.do","/{siteKey}/mngr/module/onlineQustnr/selectOnlineQustnrIemResultListAjax.do"})
	public String selectOnlineQustnrIemResultList(
			@ModelAttribute("paramVO")ModuleOnlineQustnrIemVO paramVO
			, HttpServletRequest request
			, Model model
			){
		
		List<ModuleOnlineQustnrIemVO> resultList = onlineQustnrQesitmService.selectOnlineQustnrResultIemInit(paramVO);
		model.addAttribute("resultList", resultList);
		
		return "wzwg/module/onlineQustnr/qustnrResultAjax";
	}
	
	/**
	 * @Method Name : selectOnlineQustnrResultExcel
	 * @Method 설명 : 설문 결과 엑셀 다운로드
	 * @작성일 : 2019. 7. 10.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	@RequestMapping(value= {"/mngr/module/onlineQustnr/selectOnlineQustnrResultExcel.do","/{siteKey}/mngr/module/onlineQustnr/selectOnlineQustnrResultExcel.do"})
	public void selectOnlineQustnrResultExcel(
			@ModelAttribute("paramVO")ModuleOnlineQustnrInfoVO paramVO
			, HttpServletRequest request
			, HttpServletResponse response
			, Model model
			) throws Exception{
		/*
		String fileName = "설문조사결과";
		HashMap<String ,Object> beans = new HashMap<String ,Object>();
		
		ModuleOnlineQustnrInfoVO resultVO = onlineQustnrInfoService.selectOnlineQustnrInfoDetail(paramVO);
		
		ModuleOnlineQustnrQesitmVO qesitmVO = new ModuleOnlineQustnrQesitmVO();
		qesitmVO.setQustnrSeq(paramVO.getQustnrSeq());
		List<ModuleOnlineQustnrQesitmVO> qesitmList = onlineQustnrQesitmService.selectOnlineQustnrQesitmList(qesitmVO);
		
		List<ModuleOnlineQustnrIemVO> resultList = new ArrayList<ModuleOnlineQustnrIemVO>();
		
		for(int i=0; i<qesitmList.size(); i++){
			ModuleOnlineQustnrIemVO iemVO = new ModuleOnlineQustnrIemVO();
			iemVO.setQesitmSeq(qesitmList.get(i).getQesitmSeq());
			iemVO.setQesitmNm(qesitmList.get(i).getQesitmNm());
			iemVO.setQesitmTyCode(qesitmList.get(i).getQesitmTyCode());
			
			resultList.add(iemVO);
			
			resultList.addAll(onlineQustnrQesitmService.selectOnlineQustnrResultIemInit(iemVO));
		}
		
		beans.put("resultVO", resultVO);
		beans.put("resultList", resultList);
		
		ExcelCreater.excelCreate(request, response , beans, "Globals.qustnrExcelForm", fileName) ;*/
		
		String fileName = egovMessageSource.getMessage("wzwg.cmm.msg.MSG500");
		HashMap<String ,Object> beans = new HashMap<String ,Object>();
		
		ModuleOnlineQustnrInfoVO resultVO = onlineQustnrInfoService.selectOnlineQustnrInfoDetail(paramVO);
		
		ModuleOnlineQustnrQesitmVO qesitmVO = new ModuleOnlineQustnrQesitmVO();
		qesitmVO.setQustnrSeq(paramVO.getQustnrSeq());
		List<ModuleOnlineQustnrQesitmVO> qesitmList = onlineQustnrQesitmService.selectOnlineQustnrQesitmList(qesitmVO);
		
		List<String> resultList = new ArrayList<String>();
		
		for(int i=0; i<qesitmList.size(); i++){
			ModuleOnlineQustnrIemVO iemVO = new ModuleOnlineQustnrIemVO();
			iemVO.setQesitmSeq(qesitmList.get(i).getQesitmSeq());
			iemVO.setQesitmTyCode(qesitmList.get(i).getQesitmTyCode());
			
			/** 문항 입력 */
			resultList.add(Integer.toString(i+1) + ". " + qesitmList.get(i).getQesitmNm());
			
			List<ModuleOnlineQustnrIemVO> iemList = onlineQustnrQesitmService.selectOnlineQustnrResultIemInit(iemVO);
			
			for(int j=0; j<iemList.size(); j++){
				if(!("SC00000326").equals(StringUtils.defaultString(qesitmList.get(i).getQesitmTyCode()))){
					resultList.add("  " + iemList.get(j).getIemNm() + "                   " + iemList.get(j).getRespondCount() + egovMessageSource.getMessage("wzwg.cmm.word.person")+" (" + iemList.get(j).getRespondPercent() + "%)");
				}else{
					resultList.add("  " + iemList.get(j).getDscrpAnswer());
				}
			}
			resultList.add(" ");
		}
		
		beans.put("resultVO", resultVO);
		beans.put("resultList", resultList);
		
		ExcelCreater.excelCreate(request, response , beans, "Globals.qustnrExcelForm", fileName) ;
	}
	
	
}
