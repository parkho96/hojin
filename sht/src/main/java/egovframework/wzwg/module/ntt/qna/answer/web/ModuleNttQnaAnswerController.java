package egovframework.wzwg.module.ntt.qna.answer.web;

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
import egovframework.wzwg.module.ntt.module.answer.service.ModuleNttAnswerVO;
import egovframework.wzwg.module.ntt.qna.answer.service.ModuleNttQnaAnswerService;

@Controller
public class ModuleNttQnaAnswerController {

    /** ModuleNttQnaAnswerService */
    @Resource(name="ModuleNttQnaAnswerService")
    protected ModuleNttQnaAnswerService nttQnaAnswerService;
    
    /** ModuleNttCmmnService */
    @Resource(name="ModuleNttCmmnService")
    protected ModuleNttCmmnService nttCmmnService;
    
    

	/**
	 * ㅁ 질의응답게시물 답변 - 댓글 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/qna/answer/selectNttQnaAnswerFormAjax.do")
    public String selectNttQnaAnswerForm(
    		@ModelAttribute("nttAnswerVO") ModuleNttAnswerVO nttAnswerVO
    		, HttpServletRequest request
    		, ModelMap model
	    ) throws Exception {

    	nttAnswerVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
    	String nttSeq 		= (String) request.getParameter("param_nttSeq");
    	String parntsNttSeq	= (String) request.getParameter("param_parntsNttSeq");
    	
    	nttAnswerVO.setNttSeq(nttSeq);
    	
    	// 댓글 총 갯수
    	Integer answerCnt = nttQnaAnswerService.selectNttQnaAnswerListTotCnt(nttAnswerVO);
    	nttAnswerVO.setAnswerCnt(answerCnt.toString());
    	
    	model.addAttribute("parntsNttSeq", parntsNttSeq);
    	model.addAttribute("nttAnswerVO", nttAnswerVO);
    	
        return "wzwg/module/ntt/qna/answer/answerForm";
    }
	
    /**
	 * ㅁ 질의응답게시물 답변 - 댓글 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/qna/answer/selectNttQnaAnswerListAjax.do")
    public String selectNttQnaAnswerList(
    		@ModelAttribute("nttAnswerVO") ModuleNttAnswerVO nttAnswerVO
    		, HttpServletRequest request
    		, ModelMap model
	    ) throws Exception {
    	
    	nttAnswerVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));

    	// 댓글 목록
    	List<ModuleNttAnswerVO> resultList = nttQnaAnswerService.selectNttQnaAnswerList(nttAnswerVO);

    	model.addAttribute("resultList", resultList);
    	model.addAttribute("nttAnswerVO", nttAnswerVO);
    	
        return "wzwg/module/ntt/qna/answer/answerList";
    }
    
    /**
	 * ㅁ 질의응답게시물 답변 - 댓글 답글 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/qna/answer/selectNttQnaAnswerReplyFormAjax.do")
    public String selectNttQnaAnswerReplyForm(
    		@ModelAttribute("nttAnswerVO") ModuleNttAnswerVO nttAnswerVO
    		, HttpServletRequest request
    		, ModelMap model
	    ) throws Exception {
    	
    	model.addAttribute("nttAnswerVO", nttAnswerVO);
    	
    	return "wzwg/module/ntt/qna/answer/answerReply";
    }

    /**
	 * ㅁ 질의응답게시물 답변 - 댓글 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/qna/answer/registNttQnaAnswerAjax.do")
    public ModelAndView registNttQnaAnswer(
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
			nttAnswerVO.setWrterSeq(loginVO.getUsrSeq());
		}
		
		result = nttQnaAnswerService.registNttQnaAnswer(nttAnswerVO);	// 댓글 등록
		
		if(result > 0){
			// 댓글 총 갯수
	    	Integer answerCnt = nttQnaAnswerService.selectNttQnaAnswerListTotCnt(nttAnswerVO);
	    	
	    	return CmmAjaxUtil.getAjaxReturn(String.valueOf(answerCnt.intValue()));
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
    }
    
    /**
	 * ㅁ 질의응답게시물 답변 - 댓글 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/qna/answer/modifyNttQnaAnswerAjax.do")
    public ModelAndView modifyNttQnaAnswer(
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
		
		result = nttQnaAnswerService.modifyNttQnaAnswer(nttAnswerVO);	// 댓글 수정
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
    }
    
    /**
	 * ㅁ 질의응답게시물 답변 - 댓글 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/qna/answer/deleteNttQnaAnswerAjax.do")
    public ModelAndView deleteNttQnaAnswer(
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
		
		result = nttQnaAnswerService.deleteNttQnaAnswer(nttAnswerVO);	// 댓글 삭제
		
		if(result > 0){
			// 댓글 총 갯수
	    	Integer answerCnt = nttQnaAnswerService.selectNttQnaAnswerListTotCnt(nttAnswerVO);
	    	
	    	return CmmAjaxUtil.getAjaxReturn(String.valueOf(answerCnt.intValue()));
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
		
    }
    
}
