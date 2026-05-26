package egovframework.wzwg.sysMngr.usrMngr.usrTyCode.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
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
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeVO;
import egovframework.wzwg.sysMngr.usrMngr.usrTy.service.SysMngrUsrTyService;
import net.sourceforge.ajaxtags.xml.AjaxXmlBuilder;

@Controller
public class UsrTyCodeController {
	
	@Resource(name="SysMngrUsrTyService")
	SysMngrUsrTyService sysMngrUsrTyService;
	
	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;
	
	// 회원유형코드
	private String grpcode = "USR_TY_CODE";
	
	/**
	 * 사용자 유형 리스트조회
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/sysMngr/usrMngr/usrTyCode/selectUsrTyCodeList.do")
	public String selectCodeInfoList(
			@ModelAttribute("paramVO") CmmCodeVO paramVO
			, HttpServletRequest request
			, Model model) throws Exception {

        /** =================== paging 시작 ============================== */
		PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
        paginationInfo.setPageSize(paramVO.getPageSize());
       
        paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
        paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        int totCnt = codeService.selectCodeInfoListCnt(grpcode);
        paginationInfo.setTotalRecordCount(totCnt);
		
        /** =================== paging 끝 =============================== */
				
		List<CmmCodeVO> resultList = codeService.selectCodeInfoList(grpcode);
		
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("resultList", resultList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "wzwg/sysMngr/usrMngr/usrTyCode/UsrTyCodeList";
	}
    
    /**
     * 사용자 유형 등록 폼
     * @param sysMngrUsrTyVO
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/sysMngr/usrMngr/usrTyCode/selectUsrTyCodeForm.do")
    public String registUsrTyForm(
            @ModelAttribute("paramVO") CmmCodeVO paramVO
            , HttpServletRequest request
            , Model model) throws Exception {
        
        CmmCodeVO resultVO = new CmmCodeVO();
        
        String code = StringUtils.defaultString(paramVO.getCode());
        
        if (!"".equals(code)) {
            paramVO.setGrpcode(grpcode);
            
            resultVO = codeService.selectCodeInfo(paramVO);
            
            int applcCount = sysMngrUsrTyService.selectUsrTyCodeApplcCnt(code);
            model.addAttribute("applcCount", applcCount);
        }
        
        model.addAttribute("resultVO", resultVO);
        
        return "wzwg/sysMngr/usrMngr/usrTyCode/UsrTyCodeForm";
    }
    
    /**
     * 사용자 유형 등록
     * @param sysMngrUsrTyVO
     * @param request
     * @param model
     * @return
     * @throws Exception  
     */
    @RequestMapping(value="/sysMngr/usrMngr/usrTyCode/registUsrTyCode.do")
    public ModelAndView registUsrTyCode(
            @ModelAttribute("paramVO") CmmCodeVO paramVO
            , HttpServletRequest request
            , Model model) throws Exception {
        
        /** 로그인 한 사용자 입력 */
        CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        paramVO.setUserId(loginVO.getUserId());
        paramVO.setGrpcode(grpcode);
        
        int result = codeService.registCodeInfo(paramVO);
        
        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        if(result < 1){
            ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "fail").toString());
        }else{
            ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        }
        
        return ajaxModel;
    }

    /**
     * 사용자 유형 수정
     * @param sysMngrUsrTyVO
     * @param request
     * @param model
     * @return
     * @throws Exception  
     */
    @RequestMapping(value="/sysMngr/usrMngr/usrTyCode/modifyUsrTyCode.do")
    public ModelAndView modifyUsrTyCode(
            @ModelAttribute("paramVO") CmmCodeVO paramVO
            , HttpServletRequest request
            , Model model) throws Exception {
        
        /** 로그인 한 사용자 입력 */
        CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        paramVO.setUserId(loginVO.getUserId());
        
        int result = codeService.modifyCodeInfo(paramVO);
        
        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        if(result < 1){
            ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "fail").toString());
        }else{
            ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        }
        
        return ajaxModel;
    }

    /**
     * 사용자 유형 삭제
     * @param sysMngrUsrTyVO
     * @param request
     * @param model
     * @return
     * @throws Exception  
     */
    @RequestMapping(value="/sysMngr/usrMngr/usrTyCode/deleteUsrTyCode.do")
    public ModelAndView deleteUsrTyCode(
            @ModelAttribute("paramVO") CmmCodeVO paramVO
            , HttpServletRequest request
            , Model model) throws Exception {
        
        /** 로그인 한 사용자 입력 */
        CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        paramVO.setUserId(loginVO.getUserId());
        
        int result = codeService.deleteCodeInfo(paramVO);
        
        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        if(result < 1){
            ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "fail").toString());
        }else{
            ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        }
        
        return ajaxModel;
    }
    
    
}
