package egovframework.wzwg.sysMngr.cmm.code.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.service.Globals;
import egovframework.wzwg.cmm.util.CmmJsonAjaxResponser;
import egovframework.wzwg.cmm.util.ajax.AjaxXmlView;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmGrpCodeVO;
import egovframework.wzwg.sysMngr.usrPrefces.service.UsrPrefcesService;
import egovframework.wzwg.sysMngr.usrPrefces.service.UsrPrefcesVO;
import net.sourceforge.ajaxtags.xml.AjaxXmlBuilder;

@Controller
public class CmmCodeController {

    /** 공통코드 **/
    @Resource(name="CmmCodeService")
    private CmmCodeService codeService;

    /** 환경설정 코드 **/
    @Resource(name="UsrPrefcesService")
	UsrPrefcesService usrPrefcesService;
    
    
    /**
     * ㅁ 공통코드 그룹 목록 - 상위 그룹 코드로 그룹 목록을 가져온다
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/**/cmm/code/selectCmmGrpCodeList.do") 
    public ModelAndView selectSiteSlatDetCodelList(@ModelAttribute("paramVO") CmmGrpCodeVO paramVO
            , HttpServletRequest request) throws Exception {
        
        ModelAndView model = new ModelAndView(new AjaxXmlView());

        List<CmmGrpCodeVO> resultList = codeService.selectCmmGrpCodeList(paramVO.getUpperGrpcode());

        model.addObject("ajaxXml", new AjaxXmlBuilder().addItems(resultList, "grpcode", "grpcodeNm", true).toString());
        
        return model;   
    }
    
    /**
     * ㅁ 공통코드 그룹 목록 - 상위 그룹 코드로 그룹 목록을 가져온다
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping("/**/cmm/code/selectSessionIntervalAjax.do") 
    public ModelAndView selectSessionIntervalAjax(@ModelAttribute("paramVO") CmmGrpCodeVO paramVO
    		, HttpServletRequest request) throws Exception {
    	
    	UsrPrefcesVO usrPreFcesdVO = new UsrPrefcesVO();
    	usrPreFcesdVO.setUsrPrefeCode(Globals.SESSINTVL_PRE_CODE);
    	
    	String intervalTime = String.valueOf(usrPrefcesService.selectSessionInterval(usrPreFcesdVO));
    	if(intervalTime == null || intervalTime.equals("") || intervalTime.toLowerCase().equals("null")){
    		intervalTime = "0";
    	}
    	
    	return CmmJsonAjaxResponser.getInstance().setResultCode("success").setBodyData("sessionInterval", intervalTime).returnModelAndView();   
    }

}
