package egovframework.wzwg.sysMngr.cntntsMngr.cntntsStyle.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.ajax.AjaxXmlView;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cntntsMngr.cntntsStyle.service.CntntsStyleService;
import egovframework.wzwg.sysMngr.cntntsMngr.cntntsStyle.service.CntntsStyleVO;
import net.sourceforge.ajaxtags.xml.AjaxXmlBuilder;

@Controller
public class CntntsStyleController {

	@Resource(name="CntntsStyleService")
	CntntsStyleService cntntsStyleService;
	
	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;
	
	@Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
	
	/**
	 * 컨텐츠 CSS 리스트 조회
	 * @param cntntsStyleVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value= {"/sysMngr/cntntsMngr/cntntnsStyle/selectCntntsStyleList.do","/{siteKey}/sysMngr/cntntsMngr/cntntnsStyle/selectCntntsStyleList.do"})
	public String selectCntntsStyleList(
			@ModelAttribute("paramVO")CntntsStyleVO cntntsStyleVO
			, HttpServletRequest request
			, Model model
			){
		
        /** =================== paging 시작 ============================== */
		cntntsStyleVO.setPageUnit(propertyService.getInt("pageUnit"));
		cntntsStyleVO.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(cntntsStyleVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(cntntsStyleVO.getPageUnit());
		paginationInfo.setPageSize(cntntsStyleVO.getPageSize());

		cntntsStyleVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		cntntsStyleVO.setLastIndex(paginationInfo.getLastRecordIndex());
		cntntsStyleVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        int totCnt = cntntsStyleService.selectCntntsStyleTotCnt(cntntsStyleVO);
        paginationInfo.setTotalRecordCount(totCnt);
        
        /* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
        /** =================== paging 끝 =============================== */
				
		
		List<CntntsStyleVO> cntntsStyleList = cntntsStyleService.selectCntntsStyleList(cntntsStyleVO);
		
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("cntntsStyleList", cntntsStyleList);
		
		return "/wzwg/sysMngr/cntntsMngr/cntntsStyle/cntntsStyleList";
	}

	/**
	 * 컨텐츠 CSS 등록 폼
	 * @param cntntsStyleVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value= {"/sysMngr/cntntsMngr/cntntnsStyle/registCntntsStyleForm.do","/{siteKey}/sysMngr/cntntsMngr/cntntnsStyle/registCntntsStyleForm.do"})
	public String registCntntsStyleForm(
			@ModelAttribute("paramVO")CntntsStyleVO cntntsStyleVO
			, HttpServletRequest request
			, Model model
			)throws Exception{

		/** CSS 적용가능한 모듈 리스트 조회 */
		List<CntntsStyleVO> moduleList = cntntsStyleService.selectCssProvdModuleList(cntntsStyleVO);
		model.addAttribute("moduleList", moduleList);

		return "/wzwg/sysMngr/cntntsMngr/cntntsStyle/cntntsStyleRegistForm";
	}
	
	/**
	 * 컨텐츠 CSS 등록
	 * @param cntntsStyleVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value= {"/sysMngr/cntntsMngr/cntntnsStyle/registCntntsStyleAjax.do","/{siteKey}/sysMngr/cntntsMngr/cntntnsStyle/registCntntsStyleAjax.do"})
	public ModelAndView registCntntsStyleAjax(
			@ModelAttribute("paramVO")CntntsStyleVO cntntsStyleVO
			, HttpServletRequest request
			, Model model
			){
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		cntntsStyleVO.setUserId(loginVO.getUserId());

		int registResult = cntntsStyleService.registCntntsStyleAjax(cntntsStyleVO);

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
	 * 컨텐츠 CSS 상세조회
	 * @param cntntsStyleVO
	 * @param request
	 * @param model
	 * @return
	 */
	
	@RequestMapping(value= {"/sysMngr/cntntsMngr/cntntnsStyle/selectCntntsStyleDetail.do","/{siteKey}/sysMngr/cntntsMngr/cntntnsStyle/selectCntntsStyleDetail.do"})
	public String selectCntntsStyleDetail(
			@ModelAttribute("paramVO")CntntsStyleVO cntntsStyleVO
			, HttpServletRequest request
			, Model model
			){
			
		cntntsStyleVO = cntntsStyleService.selectCntntsStyleDetail(cntntsStyleVO);
		model.addAttribute("cntntsStyleVO", cntntsStyleVO);
		
		return "/wzwg/sysMngr/cntntsMngr/cntntsStyle/cntntsStyleDetail";
	}
	
	/**
	 * 컨텐츠 CSS 수정 폼
	 * @param cntntsStyleVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value= {"/sysMngr/cntntsMngr/cntntnsStyle/modifyCntntsStyleForm.do","/{siteKey}/sysMngr/cntntsMngr/cntntnsStyle/modifyCntntsStyleForm.do"})
	public String modifyCntntsStyleForm(
			@ModelAttribute("paramVO")CntntsStyleVO cntntsStyleVO
			, HttpServletRequest request
			, Model model
			)throws Exception{

		/** CSS 적용가능한 모듈 리스트 조회 */
		List<CntntsStyleVO> moduleList = cntntsStyleService.selectCssProvdModuleList(cntntsStyleVO);
		model.addAttribute("moduleList", moduleList);
		
		cntntsStyleVO = cntntsStyleService.selectCntntsStyleDetail(cntntsStyleVO);
		model.addAttribute("cntntsStyleVO", cntntsStyleVO);
		
		return "/wzwg/sysMngr/cntntsMngr/cntntsStyle/cntntsStyleModifyForm";
	}
	
	/**
	 * 컨텐츠 CSS 수정
	 * @param cntntsStyleVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value= {"/sysMngr/cntntsMngr/cntntnsStyle/modifyCntntsStyleAjax.do","/{siteKey}/sysMngr/cntntsMngr/cntntnsStyle/modifyCntntsStyleAjax.do"})
	public ModelAndView modifyCntntsStyleAjax(
			@ModelAttribute("paramVO")CntntsStyleVO cntntsStyleVO
			, HttpServletRequest request
			, Model model
			){

		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		cntntsStyleVO.setUserId(loginVO.getUserId());

		int modifyResult = cntntsStyleService.modifyCntntsStyleAjax(cntntsStyleVO);

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
	 * 컨텐츠 CSS 삭제
	 * @param cntntsStyleVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value= {"/sysMngr/cntntsMngr/cntntnsStyle/deleteCntntsStyleAjax.do","/{siteKey}/sysMngr/cntntsMngr/cntntnsStyle/deleteCntntsStyleAjax.do"})
	public ModelAndView deleteCntntsStyleAjax(
			@ModelAttribute("paramVO")CntntsStyleVO cntntsStyleVO
			, HttpServletRequest request
			, Model model
			){

		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		cntntsStyleVO.setUserId(loginVO.getUserId());

		int deleteResult = cntntsStyleService.deleteCntntsStyleAjax(cntntsStyleVO);

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
	 * 컨텐츠 CSS 미리보기
	 * @param cntntsStyleVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/**/cntntsMngr/cntntnsStyle/selectCntntsStylePrevewPopup.do")
	public String selectCntntsStylePrevewPopup(
			@ModelAttribute("paramVO")CntntsStyleVO cntntsStyleVO
			, HttpServletRequest request
			, Model model
			){
		
		cntntsStyleVO = cntntsStyleService.selectCntntsStyleDetail(cntntsStyleVO);
		model.addAttribute("cntntsStyleVO", cntntsStyleVO);
		
		return "/wzwg/sysMngr/cntntsMngr/cntntsStyle/cntntsStylePrevewPopup";
	}
	
}
