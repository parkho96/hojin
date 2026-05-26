package egovframework.wzwg.sysMngr.opnsu.ntt.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttCmmnService;
import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttQnaReplyService;
import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttVO;


@Controller
public class OpnsuNttQnaReplyController {


    /** OpnsuNttCmmnService */
    @Resource(name="OpnsuNttCmmnService")
    protected OpnsuNttCmmnService nttCmmnService;
    
    /** OpnsuNttQnaReplyService */
    @Resource(name="OpnsuNttQnaReplyService")
    protected OpnsuNttQnaReplyService nttQnaReplyService;	
    
	/**
	 * ㅁ 질의응답게시물 답변 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/opnsu/ntt/qna/selectNttReplyFormAjax.do")
    public String selectNttReplyForm(
    		@ModelAttribute("nttVO") OpnsuNttVO nttVO
    		, HttpServletRequest request
    		, ModelMap model
	    ) throws Exception {

    	nttVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
    	String nttSeq 		= (String) request.getParameter("param_nttSeq");
    	String nttSj 		= (String) request.getParameter("param_nttSj");
    	String choiceNttSeq = (String) request.getParameter("param_choiceNttSeq");
    	String bbsSeq 		= (String) request.getParameter("param_bbsSeq");
    	String ntcrId 		= (String) request.getParameter("param_ntcrId");
    	
    	nttVO.setNttSeq(nttSeq);
    	nttVO.setParntsNttSeq(nttSeq);
    	nttVO.setNttSj(nttSj);
    	nttVO.setChoiceNttSeq(choiceNttSeq);
    	nttVO.setBbsSeq(bbsSeq);
    	nttVO.setNtcrId(ntcrId);
    	
    	// 답변 총 갯수
    	Integer nttReplyCnt = nttQnaReplyService.selectNttReplyListTotCnt(nttVO);
    	nttVO.setNttReplyCnt(nttReplyCnt.toString());
    	
    	model.addAttribute("nttVO", nttVO);
    	
		model.addAttribute("fileEstbsSe", 	EgovProperties.getProperty("Globals.fileEstbs"));
		model.addAttribute("editorEstbsSe", EgovProperties.getProperty("Globals.editorEstbs"));
    	
        return "wzwg/sysMngr/opnsu/ntt/qna/nttReplyForm";
    }
    
    /**
	 * ㅁ 질의응답게시물 답변 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/opnsu/ntt/qna/selectNttReplyListAjax.do")
    public String selectNttReplyList(
    		@ModelAttribute("nttVO") OpnsuNttVO nttVO
    		, HttpServletRequest request
    		, ModelMap model
	    ) throws Exception {
    	
    	nttVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
    	if(nttVO.getOrdrSe() == null){
    		nttVO.setOrdrSe("A");
    	}
    	
    	// 답변 목록
    	List<OpnsuNttVO> resultList = nttQnaReplyService.selectNttReplyList(nttVO);

    	model.addAttribute("resultList", resultList);
    	model.addAttribute("nttChoiceAt", nttQnaReplyService.selectNttReplyChoiceAt(nttVO));
    	model.addAttribute("nttVO", nttVO);

		model.addAttribute("editorEstbsSe", EgovProperties.getProperty("Globals.editorEstbs"));
		
        return "wzwg/sysMngr/opnsu/ntt/qna/nttReplyList";
    }
    
    /**
	 * ㅁ 질의응답게시물 답변 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/opnsu/ntt/qna/registNttReplyAjax.do")
    public ModelAndView registReply(
            @ModelAttribute("nttVO") OpnsuNttVO nttVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		if (loginVO != null) {
			nttVO.setNtcrSeq(loginVO.getUsrSeq());
			nttVO.setNtcrId(loginVO.getUserId());
			nttVO.setNtcrNm(loginVO.getUserNm());
		}
		nttVO.setNttSeq(nttCmmnService.selectNextNttSeq(nttVO));
		
		result = nttCmmnService.registNttInfo(nttVO);	// 답변 등록
		
		if(result > 0){
			// 답변 총 갯수
	    	Integer nttReplyCnt = nttQnaReplyService.selectNttReplyListTotCnt(nttVO);
	    	
	    	return CmmAjaxUtil.getAjaxReturn(String.valueOf(nttReplyCnt.intValue()));
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
		
    }
    
    /**
	 * ㅁ 질의응답게시물 답변 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/opnsu/ntt/qna/modifyNttReplyAjax.do")
    public ModelAndView modifyReply(
            @ModelAttribute("nttVO") OpnsuNttVO nttVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {

		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
			
		if (loginVO != null) nttVO.setLastUpdusrId(loginVO.getUserId());

		result = nttQnaReplyService.modifyNttReply(nttVO);	// 답변 수정
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
		
    }
    
    /**
	 * ㅁ 질의응답게시물 답변 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/opnsu/ntt/qna/deleteNttReplyAjax.do")
    public ModelAndView deleteReply(
            @ModelAttribute("nttVO") OpnsuNttVO nttVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {

		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");

		if (loginVO != null) nttVO.setLastUpdusrId(loginVO.getUserId());
		
		result = nttCmmnService.deleteNttInfo(nttVO);	// 답변 삭제
		
		if(result > 0){
			// 답변 총 갯수
	    	Integer nttReplyCnt = nttQnaReplyService.selectNttReplyListTotCnt(nttVO);
	    	
	    	return CmmAjaxUtil.getAjaxReturn(String.valueOf(nttReplyCnt.intValue()));
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
    }
	
    /**
	 * ㅁ 질의응답게시물 답변채택 팝업
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/opnsu/ntt/qna/selectNttReplyChoicePopup.do")
    public String selectNttReplyChoicePopup(
    		@ModelAttribute("paramVO") OpnsuNttVO paramVO
    		, HttpServletRequest request
    		, ModelMap model
	    ) throws Exception {

    	paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
        return "wzwg/sysMngr/opnsu/ntt/qna/nttReplyChoicePopup";
    }
    
    /**
	 * ㅁ 질의응답게시물 답변채택
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/opnsu/ntt/qna/registNttReplyChoiceAjax.do")
	public ModelAndView registNttReplyChoice(
			@ModelAttribute("paramVO") OpnsuNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		Integer result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		if (loginVO != null) paramVO.setFrstRegisterId(loginVO.getUserId());			
		
		result = nttQnaReplyService.registNttReplyChoice(paramVO);		// 답변채택
				
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
		
	}
	
}
