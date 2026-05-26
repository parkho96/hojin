package egovframework.wzwg.module.ntt.module.answer.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttCmmnService;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;
import egovframework.wzwg.module.ntt.module.answer.service.ModuleNttAnswerService;
import egovframework.wzwg.module.ntt.module.answer.service.ModuleNttAnswerVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthService;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthVO;

@Controller
public class ModuleNttAnswerController {

    /** ModuleNttAnswerService */
    @Resource(name="ModuleNttAnswerService")
    protected ModuleNttAnswerService nttAnswerService;
    
    /** ModuleNttService */
    @Resource(name="ModuleNttCmmnService")
    protected ModuleNttCmmnService nttService;
    
    /** CntntsAuthService */
    @Resource(name="CntntsAuthService")
    protected CntntsAuthService cntntsAuthService;	   
    
    /**
	 * ㅁ 게시물 댓글
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/answer/selectNttAnswerIncAjax.do")
    public String selectNttAnswerInc(
    		@ModelAttribute("nttAnswerVO") ModuleNttAnswerVO nttAnswerVO
    		, HttpServletRequest request
    		, ModelMap model
	    ) throws Exception {

    	nttAnswerVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
    	String nttSeq = (String) request.getParameter("param_nttSeq");
    	
    	nttAnswerVO.setNttSeq(nttSeq);
    	
    	// 댓글 총 갯수
    	Integer answerCnt = nttAnswerService.selectNttAnswerListTotCnt(nttAnswerVO);
    	
    	model.addAttribute("answerCnt", answerCnt.toString());
    	
        return "wzwg/module/ntt/module/answer/answerInc";
    }
    
    /**
	 * ㅁ 게시물 댓글 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/answer/selectNttAnswerFormAjax.do")
    public String selectNttAnswerForm(
    		@ModelAttribute("nttAnswerVO") ModuleNttAnswerVO nttAnswerVO
    		, HttpServletRequest request
    		, ModelMap model
	    ) throws Exception {

    	nttAnswerVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
    	String nttSeq = (String) request.getParameter("param_nttSeq");
    	String bbsSeq = (String) request.getParameter("param_bbsSeq");
    	
    	nttAnswerVO.setNttSeq(nttSeq);
    	nttAnswerVO.setBbsSeq(bbsSeq);
    	
    	// 댓글 총 갯수
    	Integer answerCnt = nttAnswerService.selectNttAnswerListTotCnt(nttAnswerVO);
    	nttAnswerVO.setAnswerCnt(answerCnt.toString());
    	
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		// 게시판 권한
		CntntsAuthVO cntntsAuthVO = new CntntsAuthVO();
		cntntsAuthVO.setCntntsSeq(nttAnswerVO.getBbsSeq());
		cntntsAuthVO.setSiteSeq(nttAnswerVO.getSiteSeq());

		if(loginVO != null){
			cntntsAuthVO.setUsrSeq(loginVO.getUsrSeq());
		} else {
			cntntsAuthVO.setUsrSeq("0");
		}		

		CntntsAuthVO nttAuthVO = cntntsAuthService.selectCntntsAuthForNtt(cntntsAuthVO);	
		
		model.addAttribute("nttAuthVO", nttAuthVO);	    	
    	
    	model.addAttribute("nttAnswerVO", nttAnswerVO);
    	
        return "wzwg/module/ntt/module/answer/answerForm";
    }
    
    /**
	 * ㅁ 게시물 댓글 팝업 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/answer/selectNttAnswerFormPopup.do")
    public String selectNttAnswerFormPopup(
    		@ModelAttribute("nttAnswerVO") ModuleNttAnswerVO nttAnswerVO
    		, HttpServletRequest request
    		, ModelMap model
	    ) throws Exception {

    	nttAnswerVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
    	ModuleNttVO nttVO = new ModuleNttVO();
    	nttVO.setNttSeq(nttAnswerVO.getNttSeq());
    	nttVO.setSiteSeq(nttAnswerVO.getSiteSeq());
    	
    	ModuleNttVO resultVO = nttService.selectNttDetail(nttVO);
    	model.addAttribute("resultVO", resultVO);
    	
    	// 댓글 총 갯수
    	Integer answerCnt = nttAnswerService.selectNttAnswerListTotCnt(nttAnswerVO);
    	nttAnswerVO.setAnswerCnt(answerCnt.toString());
    	
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		// 게시판 권한
		CntntsAuthVO cntntsAuthVO = new CntntsAuthVO();
		cntntsAuthVO.setCntntsSeq(nttAnswerVO.getBbsSeq());
		cntntsAuthVO.setSiteSeq(nttAnswerVO.getSiteSeq());
		
		if(loginVO != null){
			cntntsAuthVO.setUsrSeq(loginVO.getUsrSeq());
		} else {
			cntntsAuthVO.setUsrSeq("0");
		}		

		CntntsAuthVO nttAuthVO = cntntsAuthService.selectCntntsAuthForNtt(cntntsAuthVO);	
		
		model.addAttribute("nttAuthVO", nttAuthVO);	     	
    	
    	model.addAttribute("nttAnswerVO", nttAnswerVO);
    	
        return "wzwg/module/ntt/module/answer/answerPopup";
    }
	
    /**
	 * ㅁ 게시물 댓글 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/answer/selectNttAnswerListAjax.do")
    public String selectNttAnswerList(
    		@ModelAttribute("nttAnswerVO") ModuleNttAnswerVO nttAnswerVO
    		, HttpServletRequest request
    		, ModelMap model
	    ) throws Exception {
    	
    	nttAnswerVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
    	if(nttAnswerVO.getOrdrSe() == null){
    		nttAnswerVO.setOrdrSe("A");
    	}
    	
    	// 댓글 목록
    	List<ModuleNttAnswerVO> resultList = nttAnswerService.selectNttAnswerList(nttAnswerVO);

    	model.addAttribute("resultList", resultList);
    	model.addAttribute("nttAnswerVO", nttAnswerVO);
    	
        return "wzwg/module/ntt/module/answer/answerList";
    }
    
    /**
	 * ㅁ 게시물 댓글 답글 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/answer/selectNttAnswerReplyFormAjax.do")
    public String selectNttAnswerReplyForm(
    		@ModelAttribute("nttAnswerVO") ModuleNttAnswerVO nttAnswerVO
    		, HttpServletRequest request
    		, ModelMap model
	    ) throws Exception {
    	
    	model.addAttribute("nttAnswerVO", nttAnswerVO);
    	
    	return "wzwg/module/ntt/module/answer/answerReply";
    }

    /**
	 * ㅁ 게시물 댓글 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/answer/registNttAnswerAjax.do")
    public ModelAndView registAnswer(
            @ModelAttribute("nttAnswerVO") ModuleNttAnswerVO nttAnswerVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		nttAnswerVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		if (loginVO != null) {
			nttAnswerVO.setWrterId(loginVO.getUserId());
			nttAnswerVO.setWrterSeq(loginVO.getUsrSeq());
			nttAnswerVO.setWrterNm(loginVO.getUserNm());
		}
		
		result = nttAnswerService.registNttAnswer(nttAnswerVO);	// 댓글 등록
		
		if(result > 0){
			// 댓글 총 갯수
	    	Integer answerCnt = nttAnswerService.selectNttAnswerListTotCnt(nttAnswerVO);
	    	
    		return CmmAjaxUtil.getAjaxReturn(String.valueOf(answerCnt.intValue()));
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
    }
    
    /**
	 * ㅁ 게시물 댓글 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/answer/modifyNttAnswerAjax.do")
    public ModelAndView modifyAnswer(
            @ModelAttribute("nttAnswerVO") ModuleNttAnswerVO nttAnswerVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {

		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		nttAnswerVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));		
		if (loginVO != null) {
			nttAnswerVO.setWrterId(loginVO.getUserId());
			nttAnswerVO.setWrterNm(loginVO.getUserNm());
		}
		
		result = nttAnswerService.modifyNttAnswer(nttAnswerVO);	// 댓글 수정
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
    }
    
    /**
	 * ㅁ 게시물 댓글 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/answer/deleteNttAnswerAjax.do")
    public ModelAndView deleteAnswer(
            @ModelAttribute("nttAnswerVO") ModuleNttAnswerVO nttAnswerVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {

		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		nttAnswerVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		if (loginVO != null) {
			nttAnswerVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		result = nttAnswerService.deleteNttAnswer(nttAnswerVO);	// 댓글 삭제
		
		if(result > 0){
			// 댓글 총 갯수
	    	Integer answerCnt = nttAnswerService.selectNttAnswerListTotCnt(nttAnswerVO);
	    	
	    	return CmmAjaxUtil.getAjaxReturn(String.valueOf(answerCnt.intValue()));
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
		
    }
	
	
}
