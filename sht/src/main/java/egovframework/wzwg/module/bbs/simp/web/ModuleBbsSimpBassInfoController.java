package egovframework.wzwg.module.bbs.simp.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsCmmnService;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsCssVO;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;
import egovframework.wzwg.module.bbs.simp.service.ModuleBbsSimpBassInfoService;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;

@Controller
public class ModuleBbsSimpBassInfoController {


    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

    /** ModuleBbsSimpBassInfoService */
    @Resource(name="ModuleBbsSimpBassInfoService")
    protected ModuleBbsSimpBassInfoService bbsSimpBassInfoService;
    
    /** ModuleBbsCmmnService */
    @Resource(name="ModuleBbsCmmnService")
    protected ModuleBbsCmmnService bbsCmmnService;;
    
    
    /**
	 * ㅁ 간단게시판 - 메인
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/module/bbs/simp/selectBbsInc.do","/{siteKey}/**/module/bbs/simp/selectBbsInc.do"})
	public String selectBbsInc(
			@ModelAttribute("paramVO") ModuleBbsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
		paramVO.setBbsSeq((String) request.getParameter("cntntsSeq"));
		
    	List<CntntsInfoVO> resultList = bbsCmmnService.selectBbsList(paramVO.getSiteSeq());

    	model.addAttribute("bbsList", resultList);
    	
		ModuleBbsCssVO moduleBbsCssVO = new ModuleBbsCssVO();
		
		moduleBbsCssVO = bbsCmmnService.selectBbsCssSeq(paramVO);
		
		paramVO.setCssSeq(moduleBbsCssVO.getCssSeq());	

		moduleBbsCssVO = bbsCmmnService.selectBbsCssDetail(moduleBbsCssVO);		
		
		model.addAttribute("moduleBbsCssVO", moduleBbsCssVO);    	
    	
    	String reqUrl = request.getRequestURI();
    	String mngrAt = "N";

    	if(reqUrl.indexOf("/mngr/") > -1 || reqUrl.indexOf("/sysMngr/") > -1) {
    		if(reqUrl.indexOf("/mngr/screen/") == -1 || reqUrl.indexOf("/sysMngr/screen/") == -1) {
    			mngrAt = "Y";
    		}
    	}
	
    	model.addAttribute("mngrAt", mngrAt);    	
		
		return "wzwg/module/bbs/simp/bbsInc"; 
	}
	
	/**
	 * ㅁ 간단게시판 - 기본정보
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/module/bbs/simp/selectSimpBbsBassInfoAjax.do", "/**/module/bbs/simp/bbsFormAjax.do"})
	public String selectSimpBbsBassInfo(
			@ModelAttribute("paramVO") ModuleBbsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		ModuleBbsVO resultVO = new ModuleBbsVO();
		
		// 게시판 기본정보
		resultVO = bbsSimpBassInfoService.selectBbsBassInfoDetail(paramVO);	
		
		if(resultVO != null){		
            resultVO.setSitecntntsSeq(paramVO.getSitecntntsSeq());
			model.addAttribute("resultVO", resultVO);
		}else{
			model.addAttribute("resultVO", paramVO);
		}
		
		return "wzwg/module/bbs/simp/bbsBassForm"; 
	}

    /**
     * ㅁ 간단게시판 - 기본정보 저장
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/**/module/bbs/simp/modifyBbsBassInfoAjax.do")
    public ModelAndView modifyBbsBassInfo(
            @ModelAttribute("paramVO") ModuleBbsVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{
        
        int result = 0;
        
        HttpSession session = request.getSession();
        CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");

        if(loginVO != null && loginVO.getUserId() != null) {
        	paramVO.setFrstRegisterId(loginVO.getUserId());
        }
        
        result = bbsSimpBassInfoService.modifyBbsBassInfo(paramVO); // 저장
        
        if(result > 0){
            return CmmAjaxUtil.getAjaxReturn("success");
        }else{
            return CmmAjaxUtil.getAjaxReturn("fail");
        }
    }

    /**
     * ㅁ 간단게시판 - 기본정보 저장
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/**/module/bbs/simp/registBbsBassInfoAjax.do")
    public ModelAndView registBbsBassInfo(
            @ModelAttribute("paramVO") ModuleBbsVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{
        
        int result = 0;
        
        HttpSession session = request.getSession();
        CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
        
        if(loginVO != null && loginVO.getUserId() != null) {
        	paramVO.setFrstRegisterId(loginVO.getUserId());
        }
        
        result = bbsSimpBassInfoService.registBbsBassInfo(paramVO); // 저장
        
        if(result > 0){
            return CmmAjaxUtil.getAjaxReturn("success");
        }else{
            return CmmAjaxUtil.getAjaxReturn("fail");
        }
    }
	
	
}
