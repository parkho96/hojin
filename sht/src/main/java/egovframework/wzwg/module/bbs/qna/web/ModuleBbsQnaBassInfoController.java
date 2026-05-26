package egovframework.wzwg.module.bbs.qna.web;

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
import egovframework.wzwg.module.bbs.qna.service.ModuleBbsQnaBassInfoService;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;

@Controller
public class ModuleBbsQnaBassInfoController {


    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

    /** ModuleBbsQnaBassInfoService */
    @Resource(name="ModuleBbsQnaBassInfoService")
    protected ModuleBbsQnaBassInfoService bbsQnaBassInfoService;
    
    /** ModuleBbsCmmnService */
    @Resource(name="ModuleBbsCmmnService")
    protected ModuleBbsCmmnService bbsCmmnService;;
    
    
    /**
	 * ㅁ 질의응답게시판 - 메인
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/module/bbs/qna/selectBbsInc.do","/{siteKey}/**/module/bbs/qna/selectBbsInc.do"})
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
		
		return "wzwg/module/bbs/qna/bbsInc"; 
	}
    
	/**
	 * ㅁ 질의응답게시판 - 기본정보
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/module/bbs/qna/selectQnaBbsBassInfoAjax.do", "/**/module/bbs/qna/bbsFormAjax.do"})
	public String selectQnaBbsBassInfo(
			@ModelAttribute("paramVO") ModuleBbsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		List<ModuleBbsVO> formList = bbsCmmnService.selectBbsFormList(paramVO.getSiteSeq());
    	model.addAttribute("formList", formList);
    	
		ModuleBbsVO resultVO = new ModuleBbsVO();
		
		// 게시판 기본정보
		resultVO = bbsQnaBassInfoService.selectBbsBassInfoDetail(paramVO);

		if(resultVO != null){			
            resultVO.setSitecntntsSeq(paramVO.getSitecntntsSeq());
            resultVO.setPageMode(paramVO.getPageMode());
			model.addAttribute("resultVO", resultVO);
		}else{
			model.addAttribute("resultVO", paramVO);
		}
		
		return "wzwg/module/bbs/qna/bbsBassForm"; 
	}

    /**
     * ㅁ 질의응답게시판 - 기본정보 저장
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/**/module/bbs/qna/modifyBbsBassInfoAjax.do")
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
        
        result = bbsQnaBassInfoService.modifyBbsBassInfo(paramVO);  // 저장
        
        if(result > 0){
            return CmmAjaxUtil.getAjaxReturn("success");
        }else{
            return CmmAjaxUtil.getAjaxReturn("fail");
        }
    }

    /**
     * ㅁ 질의응답게시판 - 기본정보 저장
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/**/module/bbs/qna/registBbsBassInfoAjax.do")
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
        
        result = bbsQnaBassInfoService.registBbsBassInfo(paramVO);  // 저장
        
        if(result > 0){
            return CmmAjaxUtil.getAjaxReturn("success");
        }else{
            return CmmAjaxUtil.getAjaxReturn("fail");
        }
    }
	
	
}
