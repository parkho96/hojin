package egovframework.wzwg.module.ntt.qna.web;

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
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttCmmnService;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;
import egovframework.wzwg.module.ntt.qna.service.ModuleNttQnaReplyService;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthService;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthVO;


@Controller
public class ModuleNttQnaReplyController {


    /** ModuleNttService */
    @Resource(name="ModuleNttCmmnService")
    protected ModuleNttCmmnService nttCmmnService;
    
    /** ModuleNttQnaReplyService */
    @Resource(name="ModuleNttQnaReplyService")
    protected ModuleNttQnaReplyService nttQnaReplyService;
	
    /** CntntsAuthService */
    @Resource(name="CntntsAuthService")
    protected CntntsAuthService cntntsAuthService;	    
    
	/**
	 * ㅁ 질의응답게시물 답변 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/qna/selectNttReplyFormAjax.do")
    public String selectNttReplyForm(
    		@ModelAttribute("nttVO") ModuleNttVO nttVO
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
    	
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		// 게시판 권한
		CntntsAuthVO cntntsAuthVO = new CntntsAuthVO();
		cntntsAuthVO.setCntntsSeq(nttVO.getBbsSeq());
		cntntsAuthVO.setSiteSeq(nttVO.getSiteSeq());

		if(loginVO != null){
			cntntsAuthVO.setUsrSeq(loginVO.getUsrSeq());
		} else {
			cntntsAuthVO.setUsrSeq("0");
		}		

		CntntsAuthVO nttAuthVO = cntntsAuthService.selectCntntsAuthForNtt(cntntsAuthVO);
		
		model.addAttribute("nttAuthVO", nttAuthVO);	
    	
    	model.addAttribute("nttVO", nttVO);
    	model.addAttribute("editorEstbsSe", EgovProperties.getProperty("Globals.editorEstbs"));
    	
        return "wzwg/module/ntt/qna/nttReplyForm";
    }
    
    /**
	 * ㅁ 질의응답게시물 답변 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/qna/selectNttReplyListAjax.do")
    public String selectNttReplyList(
    		@ModelAttribute("nttVO") ModuleNttVO nttVO
    		, HttpServletRequest request
    		, ModelMap model
	    ) throws Exception {
    	
    	nttVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
    	if(nttVO.getOrdrSe() == null){
    		nttVO.setOrdrSe("A");
    	}
    	
    	// 답변 목록
    	List<ModuleNttVO> resultList = nttQnaReplyService.selectNttReplyList(nttVO);

    	model.addAttribute("resultList", resultList);
    	model.addAttribute("nttChoiceAt", nttQnaReplyService.selectNttReplyChoiceAt(nttVO));
    	model.addAttribute("nttVO", nttVO);
    	model.addAttribute("editorEstbsSe", EgovProperties.getProperty("Globals.editorEstbs"));
    	
        return "wzwg/module/ntt/qna/nttReplyList";
    }
    
    /**
	 * ㅁ 질의응답게시물 답변 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/qna/registNttReplyAjax.do")
    public ModelAndView registReply(
            @ModelAttribute("nttVO") ModuleNttVO nttVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		nttVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
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
    @RequestMapping(value="/**/module/ntt/qna/modifyNttReplyAjax.do")
    public ModelAndView modifyReply(
            @ModelAttribute("nttVO") ModuleNttVO nttVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {

		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		nttVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));		
		if (loginVO != null) {
			nttVO.setLastUpdusrId(loginVO.getUserId());
		}
		
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
    @RequestMapping(value="/**/module/ntt/qna/deleteNttReplyAjax.do")
    public ModelAndView deleteReply(
            @ModelAttribute("nttVO") ModuleNttVO nttVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {

		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		nttVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		if (loginVO != null) {
			nttVO.setLastUpdusrId(loginVO.getUserId());
		}
		
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
    @RequestMapping(value="/**/module/ntt/qna/selectNttReplyChoicePopup.do")
    public String selectNttReplyChoicePopup(
    		@ModelAttribute("paramVO") ModuleNttVO paramVO
    		, HttpServletRequest request
    		, ModelMap model
	    ) throws Exception {

    	paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
        return "wzwg/module/ntt/qna/nttReplyChoicePopup";
    }
    
    /**
	 * ㅁ 질의응답게시물 답변채택
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/qna/registNttReplyChoiceAjax.do")
	public ModelAndView registNttReplyChoice(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		Integer result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		if (loginVO != null) {
			paramVO.setFrstRegisterId(loginVO.getUserId());
		}
		
		result = nttQnaReplyService.registNttReplyChoice(paramVO);		// 답변채택
				
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
		
	}
	
}
