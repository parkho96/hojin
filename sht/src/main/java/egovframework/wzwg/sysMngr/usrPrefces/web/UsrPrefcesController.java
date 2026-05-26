package egovframework.wzwg.sysMngr.usrPrefces.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

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
import egovframework.wzwg.sysMngr.cmm.code.service.CmmGrpCodeVO;
import egovframework.wzwg.sysMngr.usrPrefces.service.UsrPrefcesService;
import egovframework.wzwg.sysMngr.usrPrefces.service.UsrPrefcesVO;
import net.sourceforge.ajaxtags.xml.AjaxXmlBuilder;

@Controller
public class UsrPrefcesController {
	
	@Resource(name="UsrPrefcesService")
	UsrPrefcesService usrPrefcesService;
	
	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;
	
	// 회원관리환경설정 상위 그룹 코드
	private String grpcode = "SGC0000036";
	
	/**
	 * 사용자 유형 리스트조회
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value="/sysMngr/usrMngr/usrPrefces/selectusrPrefcesList.do")
	public String selectCodeInfoList(
			@ModelAttribute("paramVO") UsrPrefcesVO paramVO
			, HttpServletRequest request
			, Model model) throws Exception {

	    List<CmmGrpCodeVO> tablList = codeService.selectCmmGrpCodeList(grpcode);
	    
		model.addAttribute("tablList", tablList);
		
		return "wzwg/sysMngr/usrMngr/usrPrefces/usrPrefcesList";
	}
    
    /**
     * 사용자 유형 리스트조회
     * @param paramVO
     * @param request
     * @param model
     * @return
     * @throws Exception 
     */
    @RequestMapping(value="/sysMngr/usrMngr/usrPrefces/selectusrPrefcesIemAjax.do")
    public String selectusrPrefcesIemList(
            @ModelAttribute("paramVO") UsrPrefcesVO paramVO
            , HttpServletRequest request
            , Model model) throws Exception {

        paramVO.setGrpcode(grpcode);
        
        List<UsrPrefcesVO> resultList = usrPrefcesService.selectusrPrefcesIemList(paramVO);
        
        model.addAttribute("resultList", resultList);
        
        CmmCodeVO codeVO = new CmmCodeVO();
        codeVO.setGrpcodeAbrvNm("PD_ESTBS");
        codeVO.setUpperGrpcode(paramVO.getUsrPrefeCode());
        
        List<CmmCodeVO> codeList = codeService.selectCmmCodeList(codeVO);
        
        model.addAttribute("codeList", codeList);
        
        return "wzwg/sysMngr/usrMngr/usrPrefces/usrPrefcesIem";
    }
    
    /**
     * 사용자 유형 수정
     * @param sysMngrUsrTyVO
     * @param request
     * @param model
     * @return
     * @throws Exception  
     */
    @RequestMapping(value="/sysMngr/usrMngr/usrPrefces/modifyusrPrefces.do")
    public ModelAndView modifyusrPrefces(
            @ModelAttribute("paramVO") UsrPrefcesVO paramVO
            , HttpServletRequest request
            , Model model) throws Exception {
        
        /** 로그인 한 사용자 입력 */
        CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        paramVO.setUserId(loginVO.getUserId());
        
        int result = usrPrefcesService.modifyUsrPrefces(paramVO);
        
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
