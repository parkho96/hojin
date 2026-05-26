package egovframework.wzwg.sysMngr.usrMngr.usrTyCode.web;

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
import egovframework.wzwg.sysMngr.usrMngr.usrTyCode.service.UsrTySbscrbFormService;
import egovframework.wzwg.sysMngr.usrMngr.usrTyCode.service.UsrTySbscrbFormVO;
import net.sourceforge.ajaxtags.xml.AjaxXmlBuilder;

@Controller
public class UsrTySbscrbFormController {
	
	@Resource(name="UsrTySbscrbFormService")
	UsrTySbscrbFormService usrTySbscrbFormService;
	
	// 회원유형코드
	private String grpcode = "MBER_SBSCRB_FORM";
	
    /**
     * 사용자 유형 등록 폼
     * @param sysMngrUsrTyVO
     * @param request
     * @param model
     * @return
     */
    @RequestMapping(value="/sysMngr/usrMngr/usrTyCode/selectUsrTySbscrbFormList.do")
    public String selectUsrTyCodeSbscrbFormList(
            @ModelAttribute("paramVO") UsrTySbscrbFormVO paramVO
            , HttpServletRequest request
            , Model model) throws Exception {
        
        paramVO.setGrpcode(grpcode);
        
        List<UsrTySbscrbFormVO> resultList = usrTySbscrbFormService.selectUsrTySbscrbFormList(paramVO);
        
        model.addAttribute("resultList", resultList);
        model.addAttribute("resultVO", paramVO);
        
        return "wzwg/sysMngr/usrMngr/usrTyCode/usrTySbscrbForm";
    }
    
    /**
     * 사용자 유형 수정
     * @param sysMngrUsrTyVO
     * @param request
     * @param model
     * @return
     * @throws Exception  
     */
    @RequestMapping(value="/sysMngr/usrMngr/usrTyCode/modifyUsrTySbscrbForm.do")
    public ModelAndView modifyUsrTyCodeSbscrbForm(
            @ModelAttribute("paramVO") UsrTySbscrbFormVO paramVO
            , HttpServletRequest request
            , Model model) throws Exception {
        
        /** 로그인 한 사용자 입력 */
        CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        paramVO.setUserId(loginVO.getUserId());
        
        int result = usrTySbscrbFormService.modifyUsrTySbscrbForm(paramVO);
        
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
