package egovframework.wzwg.sysMngr.opnsu.bbs.web;

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
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.sysMngr.opnsu.bbs.service.OpnsuBbsCmmnService;
import egovframework.wzwg.sysMngr.opnsu.bbs.service.OpnsuBbsQnaBassInfoService;
import egovframework.wzwg.sysMngr.opnsu.bbs.service.OpnsuBbsVO;

@Controller
public class OpnsuBbsQnaBassInfoController {


    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

    /** OpnsuBbsQnaBassInfoService */
    @Resource(name="OpnsuBbsQnaBassInfoService")
    protected OpnsuBbsQnaBassInfoService bbsQnaBassInfoService;
    
    /** OpnsuBbsCmmnService */
    @Resource(name="OpnsuBbsCmmnService")
    protected OpnsuBbsCmmnService bbsCmmnService;;
    
    
    /**
	 * ㅁ 질의응답게시판 - 메인
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/opnsu/bbs/qna/selectBbsInc.do","/{siteKey}/**/opnsu/bbs/qna/selectBbsInc.do"})
	public String selectBbsInc(
			@ModelAttribute("paramVO") OpnsuBbsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
    	List<CntntsInfoVO> resultList = bbsCmmnService.selectBbsList(paramVO.getSiteSeq());

    	model.addAttribute("bbsList", resultList);

    	String reqUrl = request.getRequestURI();
    	String sysMngrAt = "N";

    	if(reqUrl.indexOf("/sysMngr/") > -1) {
    		sysMngrAt = "Y";
    	}
	
    	model.addAttribute("sysMngrAt", sysMngrAt);  	
		
		return "wzwg/sysMngr/opnsu/bbs/qna/bbsInc"; 
	}
    
	/**
	 * ㅁ 질의응답게시판 - 기본정보
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/opnsu/bbs/qna/selectQnaBbsBassInfoAjax.do", "/**/opnsu/bbs/qna/bbsFormAjax.do"})
	public String selectQnaBbsBassInfo(
			@ModelAttribute("paramVO") OpnsuBbsVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		OpnsuBbsVO resultVO = new OpnsuBbsVO();
		
		// 게시판 기본정보
		resultVO = bbsQnaBassInfoService.selectBbsBassInfoDetail(paramVO);
		
		if(resultVO != null){
            resultVO.setSitecntntsSeq(paramVO.getSitecntntsSeq());
			model.addAttribute("resultVO", resultVO);
		}else{
			model.addAttribute("resultVO", paramVO);
		}
		
		return "wzwg/sysMngr/opnsu/bbs/qna/bbsBassForm"; 
	}

    /**
     * ㅁ 질의응답게시판 - 기본정보 저장
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/**/opnsu/bbs/qna/modifyBbsBassInfoAjax.do")
    public ModelAndView modifyBbsBassInfo(
            @ModelAttribute("paramVO") OpnsuBbsVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{
        
        int result = 0;
        
        HttpSession session = request.getSession();
        CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
        if (loginVO != null) {			
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
    @RequestMapping(value="/**/opnsu/bbs/qna/registBbsBassInfoAjax.do")
    public ModelAndView registBbsBassInfo(
            @ModelAttribute("paramVO") OpnsuBbsVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{
        
        int result = 0;
        
        HttpSession session = request.getSession();
        CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
        if (loginVO != null) {			
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
