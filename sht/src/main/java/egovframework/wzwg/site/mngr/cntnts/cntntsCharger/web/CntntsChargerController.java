package egovframework.wzwg.site.mngr.cntnts.cntntsCharger.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.cntnts.cntntsCharger.service.CntntsChargerService;
import egovframework.wzwg.site.mngr.cntnts.cntntsCharger.service.CntntsChargerVO;

@Controller
public class CntntsChargerController {
    
    /** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

    /** 컨텐츠담당자 */
    @Resource(name="CntntsChargerService")
    protected CntntsChargerService cntntsChargerService;
    
    /**
     * ㅁ 컨텐츠담당자정보 - 모듈 컨텐츠 담당자 정보 목록
     * @param ApiVO
     * @return
     */
    @RequestMapping(value= {"/mngr/cntnts/cntntsCharger/selectCntntsChargerAjax.do","/{siteKey}/mngr/cntnts/cntntsCharger/selectCntntsChargerAjax.do"})
    public String selectCntntsChargerAjax (
        @ModelAttribute("paramVO") CntntsChargerVO paramVO
        , HttpServletRequest request
        , Model model ) throws Exception {
        
        return "wzwg/site/mngr/cntnts/cntntsCharger/cntntsChargerAjax";
    }
    
    /**
     * ㅁ 컨텐츠담당자정보 - 모듈 컨텐츠 담당자 정보 목록
     * @param ApiVO
     * @return
     */
    @RequestMapping(value= {"/mngr/cntnts/cntntsCharger/selectCntntsChargerListAjax.do","/{siteKey}/mngr/cntnts/cntntsCharger/selectCntntsChargerListAjax.do"})
    public String selectCntntsChargerList (
        @ModelAttribute("paramVO") CntntsChargerVO paramVO
        , HttpServletRequest request
        , Model model ) throws Exception {
        
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        
        paramVO.setSiteSeq(siteSeq);
        
        List<CntntsChargerVO> resultList = cntntsChargerService.selectCntntsChargerList(paramVO);
        
        model.addAttribute("resultList", resultList);
        
        return "wzwg/site/mngr/cntnts/cntntsCharger/cntntsChargerListAjax";
    }
    
    /**
     * ㅁ 컨텐츠권한정보 - 모듈 컨텐츠 권한 정보 등록
     * @param ApiVO
     * @return
     */
    @RequestMapping(value= {"/mngr/cntnts/cntntsCharger/registCntntsCharger.do","/{siteKey}/mngr/cntnts/cntntsCharger/registCntntsCharger.do"})
    public ModelAndView registCntntsCharger (
        @ModelAttribute("paramVO") CntntsChargerVO paramVO
        , HttpServletRequest request
        , Model model ) throws Exception {
        
        paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
        
        int retVal = cntntsChargerService.registCntntsCharger(paramVO);
        
        return CmmAjaxUtil.getAjaxReturnCmmMap(retVal);
    }
    
    /**
     * ㅁ 컨텐츠권한정보 - 모듈 컨텐츠 권한 정보 삭제
     * @param ApiVO
     * @return
     */
    @RequestMapping(value= {"/mngr/cntnts/cntntsCharger/deleteCntntsCharger.do","/{siteKey}/mngr/cntnts/cntntsCharger/deleteCntntsCharger.do"})
    public ModelAndView deleteCntntsCharger (
        @ModelAttribute("paramVO") CntntsChargerVO paramVO
        , HttpServletRequest request
        , Model model ) throws Exception {
        
        paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
        
        int retVal = cntntsChargerService.deleteCntntsCharger(paramVO);
        
        return CmmAjaxUtil.getAjaxReturnCmmMap(retVal);
    }
    
}
