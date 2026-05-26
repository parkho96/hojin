package egovframework.wzwg.cmm.mber.myPage.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.Globals;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.mber.myPage.service.CmmMyPageVO;
import egovframework.wzwg.cmm.mber.myPage.service.CmmMyStplatAgreService;
import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSbscrbService;
import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSbscrbVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoVO;

@Controller
public class CmmMyStplatAgreController {

    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name="CmmSbscrbService")
    private CmmSbscrbService cmmSbscrbService;
    
    @Resource(name="CmmMyStplatAgreService")
    private CmmMyStplatAgreService myStplatAgreService;
    
    /*************************** 2019.03.06 start *******************************/
    
    /**
     * 약관 동의 이력 조회
     * @param paramVO
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value={"/cmm/mber/myPage/selectMyStplatAgreList.do","/{siteKey}/cmm/mber/myPage/selectMyStplatAgreList.do"})
    public String selectMyStplatAgreList(
    		@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
    		, HttpServletRequest request 
    		, ModelMap model
    		) throws Exception{
    	CmmLoginVO loginVO = CmmSessionUtil.getLoginVO();
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
    	
    	if (loginVO != null) {
    		paramVO.setUsrSeq(loginVO.getUsrSeq());
    		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    		
    		List<SiteStplatInfoVO> resultList = myStplatAgreService.selectMyStplatAgreList(paramVO);
    		
    		model.addAttribute("resultList", resultList);
    		
    		return "wzwg/cmm/mber/myPage/stplatAgre/myStplatAgreList"; 
    	} else {
    		model.addAttribute("message", "fail.common.login");
    		return "forward:"+wzwgContext+"/loginForm.do";
    	}
    }
    
    /**
     * 변경된 약관 동의를 위한 화면
     * @param paramVO
     * @param request
     * @param response
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value={"/modifyStplatUpdtForm.do","/{siteKey}/modifyStplatUpdtForm.do"})
    public String modifyStplatUpdtForm(@ModelAttribute("paramVO") CmmMyPageVO paramVO
                , HttpServletRequest request
                , HttpServletResponse response
                , ModelMap model)
            throws Exception {

        CmmLoginVO loginVO = CmmSessionUtil.getLoginVO();
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
        
        if (loginVO != null) {
            
            // 약관 가져오기
            SiteStplatInfoVO searchVO = new SiteStplatInfoVO();
            
            searchVO.setUsrSeq(loginVO.getUsrSeq());
            searchVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
            searchVO.setStplatTyCode(Globals.ESSNTL_STPLAT_CODE_USRJOIN);
            
            List<SiteStplatInfoVO> resultList = cmmSbscrbService.selectSiteStplatList(searchVO);
            
            model.addAttribute("resultList", resultList);
            
            return "wzwg/cmm/mber/login/stplatUpdtForm";
        } else {
            model.addAttribute("message", "fail.common.login");
            return "forward:"+wzwgContext+"/loginForm.do";
        }
    } 

    /**
     * 변경된 약관 재동의 진행
     * @param paramVO
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value= {"/cmm/mber/myPage/modifyMyStplatAgre.do","/{siteKey}/cmm/mber/myPage/modifyMyStplatAgre.do"})
    public String modifyMyStplatAgre(
            @ModelAttribute("paramVO") CmmSbscrbVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
        
        
        CmmLoginVO loginVO = CmmSessionUtil.getLoginVO();
        
        if (loginVO != null) {
            
            paramVO.setUsrSeq(loginVO.getUsrSeq());
            paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
            
            int result = myStplatAgreService.modifyMyStplatAgre(paramVO);
            
            model.addAttribute("result", result);
            model.addAttribute("StplatAgre", true);
            
            return "wzwg/cmm/mber/sbscrb/sbscrbComptPage"; 
        } else {
            model.addAttribute("message", "fail.common.login");
            return "forward:"+wzwgContext+"/loginForm.do";
        }
    }
    /*************************** 2019.03.06 end *******************************/
    

}
