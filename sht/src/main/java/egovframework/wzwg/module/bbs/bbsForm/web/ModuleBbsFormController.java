package egovframework.wzwg.module.bbs.bbsForm.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.service.Globals;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.cmm.util.ajax.AjaxXmlView;
import egovframework.wzwg.module.bbs.bbsForm.service.ModuleBbsFormService;
import egovframework.wzwg.module.bbs.bbsForm.service.ModuleBbsFormVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeVO;
import net.sourceforge.ajaxtags.xml.AjaxXmlBuilder;

@Controller
public class ModuleBbsFormController {
	@Resource(name="ModuleBbsFormService")
	ModuleBbsFormService moduleBbsFormService;
	
	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;

	/**
	 * 게시판 양식 관리 리스트 조회
	 * @param moduleBbsFormVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/**/module/bbs/bbsForm/selectModuleBbsFormList.do","/{siteKey}/**/module/bbs/bbsForm/selectModuleBbsFormList.do"})
	public String selectModuleBbsFormList(
			@ModelAttribute("paramVO")ModuleBbsFormVO moduleBbsFormVO
			, HttpServletRequest request
			, Model model
			){
		 
		moduleBbsFormVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		/** =================== paging 시작 ============================== */
		PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(moduleBbsFormVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(moduleBbsFormVO.getPageUnit());
        paginationInfo.setPageSize(moduleBbsFormVO.getPageSize());
       
        moduleBbsFormVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        moduleBbsFormVO.setLastIndex(paginationInfo.getLastRecordIndex());
        moduleBbsFormVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        int totCnt = moduleBbsFormService.selectModuleBbsFormTotCnt(moduleBbsFormVO);
        paginationInfo.setTotalRecordCount(totCnt);
		
        /* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
        /** =================== paging 끝 =============================== */
				
		List<ModuleBbsFormVO> bbsFormList = moduleBbsFormService.selectModuleBbsFormList(moduleBbsFormVO);
		
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("bbsFormList",bbsFormList);
		
		return "wzwg/module/bbs/bbsForm/moduleBbsFormList";
	}
	
	
	/**
	 * 게시판 양식 관리 적용된 리스트 조회(Ajax로 페이지 조회)
	 * @param moduleBbsFormVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/**/module/bbs/bbsForm/selectModuleBbsFormApplcListAjax.do")
	public String selectModuleBbsFormListAjaxPage(
			@ModelAttribute("paramVO")ModuleBbsFormVO moduleBbsFormVO
			, HttpServletRequest request
			, Model model
			){
		
		moduleBbsFormVO = moduleBbsFormService.selectNttBbsMappingDetail(moduleBbsFormVO);
		model.addAttribute("moduleBbsFormVO", moduleBbsFormVO);
		
		return "wzwg/module/bbs/bbsForm/moduleBbsFormListAjaxPage"; 
	}
	/**
	 * 게시판 양식 관리 등록폼
	 * @param moduleBbsFormVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/**/module/bbs/bbsForm/registModuleBbsFormForm.do","/{siteKey}/**/module/bbs/bbsForm/registModuleBbsFormForm.do"})
	public String registModuleBbsFormForm(
			@ModelAttribute("paramVO")ModuleBbsFormVO moduleBbsFormVO
			, HttpServletRequest request
			, Model model
			)throws Exception{
		
		/** 사용자 유형 리스트 조회(SYSCODE) */
		List<CmmCodeVO> codeList = codeService.selectCmmCodeList("BBS_CL_CODE");
		model.addAttribute("codeList", codeList);
		
		return "wzwg/module/bbs/bbsForm/moduleBbsFormRegistForm";
	}
	
	/**
	 * 게시판 양식 관리 등록
	 * @param moduleBbsFormVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/**/module/bbs/bbsForm/registModuleBbsFormAjax.do")
	public ModelAndView registModuleBbsFormAjax(
			@ModelAttribute("paramVO")ModuleBbsFormVO moduleBbsFormVO
			, HttpServletRequest request
			, Model model
			){
		/** 사이트시퀀스입력 */
		moduleBbsFormVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));

		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		moduleBbsFormVO.setUserId(loginVO.getUserId());

		int registResult = moduleBbsFormService.registModuleBbsFormAjax(moduleBbsFormVO);
		
        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        if(registResult < 1){
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "fail").toString());
        }else{
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        }
        
        return ajaxModel;

	}

	/**
	 * 게시판 양식 관리 상세조회
	 * @param moduleBbsFormVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/**/module/bbs/bbsForm/selectModuleBbsFormDetail.do","/{siteKey}/**/module/bbs/bbsForm/selectModuleBbsFormDetail.do"})
	public String selectModuleBbsFormDetail(
			@ModelAttribute("paramVO")ModuleBbsFormVO moduleBbsFormVO
			, HttpServletRequest request
			, Model model
			){
		
		moduleBbsFormVO = moduleBbsFormService.selectModuleBbsFormDetail(moduleBbsFormVO);
		model.addAttribute("moduleBbsFormVO", moduleBbsFormVO);
		
		return "wzwg/module/bbs/bbsForm/moduleBbsFormDetail";
	}
	
	/**
	 * 게시판 양식 관리 수정폼
	 * @param moduleBbsFormVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/**/module/bbs/bbsForm/modifyModuleBbsFormForm.do","/{siteKey}/**/module/bbs/bbsForm/modifyModuleBbsFormForm.do"})
	public String modifyModuleBbsFormForm(
			@ModelAttribute("paramVO")ModuleBbsFormVO moduleBbsFormVO
			, HttpServletRequest request
			, Model model
			)throws Exception{
		
		/** 게시판 매핑 리스트 조회 */
		ModuleBbsFormVO nttBbsMappingVO = moduleBbsFormService.selectNttBbsMappingDetail(moduleBbsFormVO);
		
		moduleBbsFormVO = moduleBbsFormService.selectModuleBbsFormDetail(moduleBbsFormVO);
		
		model.addAttribute("nttBbsMappingVO", nttBbsMappingVO);
		model.addAttribute("moduleBbsFormVO", moduleBbsFormVO);

		/** 사용자 유형 리스트 조회(SYSCODE) */
		List<CmmCodeVO> codeList = codeService.selectCmmCodeList("BBS_CL_CODE");
		model.addAttribute("codeList", codeList);
		
		return "wzwg/module/bbs/bbsForm/moduleBbsFormModifyForm";
	}
	
	/**
	 * 게시판 양식 관리 수정
	 * @param moduleBbsFormVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/**/module/bbs/bbsForm/modifyModuleBbsFormAjax.do")
	public ModelAndView modifyModuleBbsFormAjax(
			@ModelAttribute("paramVO")ModuleBbsFormVO moduleBbsFormVO
			, HttpServletRequest request
			, Model model
			){

		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		moduleBbsFormVO.setUserId(loginVO.getUserId());

		int modifyResult = moduleBbsFormService.modifyModuleBbsFormAjax(moduleBbsFormVO);

        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        if(modifyResult < 1){
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "fail").toString());
        }else{
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        }
        
        return ajaxModel;
	}
	
	/**
	 * 게시판 양식 관리 삭제
	 * @param moduleBbsFormVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/**/module/bbs/bbsForm/deleteModuleBbsFormAjax.do")
	public ModelAndView deleteModuleBbsFormAjax(
			@ModelAttribute("paramVO")ModuleBbsFormVO moduleBbsFormVO
			, HttpServletRequest request
			, Model model
			){
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		moduleBbsFormVO.setUserId(loginVO.getUserId());
		
		int deleteResult = moduleBbsFormService.deleteModuleBbsFormAjax(moduleBbsFormVO);

        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        if(deleteResult < 1){
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "fail").toString());
        }else{
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        }
        
        return ajaxModel;
	}
	
	/**
	 * 게시판 리스트 조회
	 * @param moduleBbsFormVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/**/module/bbs/bbsForm/selectBbsApplcListPopup.do")
	public String selectBbsApplcListPopup(
			@ModelAttribute("paramVO")ModuleBbsFormVO moduleBbsFormVO
			, HttpServletRequest request
			, Model model
			){
		/** 사이트시퀀스 입력 */
		moduleBbsFormVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		/** 게시판에 적용된 리스트 조회(체크박스 체크값으로 사용) */
		if(!("regist").equals(moduleBbsFormVO.getFormSttusCode())){
			ModuleBbsFormVO nttBbsMappingVO = moduleBbsFormService.selectNttBbsMappingDetail(moduleBbsFormVO);
			model.addAttribute("nttBbsMappingVO", nttBbsMappingVO);
		}
		
		/** 게시판에 적용시킬 리스트 조회 */
		moduleBbsFormVO.setBbsModuleTyCode(Globals.BBS_MODULE_TY_CODE);
		moduleBbsFormVO.setBbsFormUseBbsSeq(Globals.BBS_FORM_USE_BBS_SEQ.split(","));
		List<ModuleBbsFormVO> bbsList = moduleBbsFormService.selectBbsApplcListPopup(moduleBbsFormVO);
		model.addAttribute("bbsList", bbsList);
		
		return "wzwg/module/bbs/bbsForm/bbsApplcListPopup";
	}

	/**
	 * 게시판 양식 리스트에서 바로 MDNTTBBSFORM 테이블 수정
	 */
	@RequestMapping(value="/**/module/bbs/bbsForm/modifyBbsApplcListAjax.do")
	public ModelAndView modifyBbsApplcListAjax(
			@ModelAttribute("paramVO")ModuleBbsFormVO moduleBbsFormVO
			, HttpServletRequest request
			, Model model
			){
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		moduleBbsFormVO.setUserId(loginVO.getUserId());
		
		int modifyResult = moduleBbsFormService.nttBbsFormDstnctn(moduleBbsFormVO);

        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        if(modifyResult < 1){
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "fail").toString());
        }else{
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        }
        
        return ajaxModel;
	}
	
	/**
	 * 게시판 양식 리스트에서 양식 미리보기
	 */
	@RequestMapping(value="/**/module/bbs/bbsForm/selectModuleBbsFormPrevewPopup.do")
	public String selectModuleBbsFormPrevewPopup(
			@ModelAttribute("paramVO")ModuleBbsFormVO moduleBbsFormVO
			, HttpServletRequest request
			, Model model
		){
		
		ModuleBbsFormVO resultVO = moduleBbsFormService.selectModuleBbsFormDetail(moduleBbsFormVO);
	
		model.addAttribute("resultVO", resultVO);
        
        return "wzwg/module/bbs/bbsForm/bbsFormPreview";
	}

}
