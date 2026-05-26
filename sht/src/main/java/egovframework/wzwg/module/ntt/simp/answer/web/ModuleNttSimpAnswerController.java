package egovframework.wzwg.module.ntt.simp.answer.web;

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
import egovframework.wzwg.module.ntt.simp.answer.service.ModuleNttSimpAnswerService;
import egovframework.wzwg.module.ntt.simp.answer.service.ModuleNttSimpAnswerVO;

@Controller
public class ModuleNttSimpAnswerController {

    /** ModuleNttSimpAnswerService */
    @Resource(name="ModuleNttSimpAnswerService")
    protected ModuleNttSimpAnswerService nttAnswerService;
    
    
    /**
	 * ㅁ 게시물 댓글
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/simp/answer/selectNttSimpAnswerIncAjax.do")
    public String  selectNttSimpAnswerInc(
    		@ModelAttribute("nttSimpAnswerVO") ModuleNttSimpAnswerVO nttSimpAnswerVO
    		, HttpServletRequest request
    		, ModelMap model
	    ) throws Exception {

    	nttSimpAnswerVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
    	String simpnttSeq = (String) request.getParameter("param_simpnttSeq");
    	
    	nttSimpAnswerVO.setSimpnttSeq(simpnttSeq);
    	
    	// 댓글 총 갯수
    	Integer answerCnt = nttAnswerService.selectNttSimpAnswerListTotCnt(nttSimpAnswerVO);
    	
    	model.addAttribute("answerCnt", answerCnt.toString());
    	
        return "wzwg/module/ntt/simp/answer/answerInc";
    }   
    
    /**
	 * ㅁ 게시물 댓글 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/simp/answer/selectNttSimpAnswerFormAjax.do")
    public String selectNttSimpAnswerForm(
    		@ModelAttribute("nttSimpAnswerVO") ModuleNttSimpAnswerVO nttSimpAnswerVO
    		, HttpServletRequest request
    		, ModelMap model
	    ) throws Exception {

    	nttSimpAnswerVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
    	String simpnttSeq = (String) request.getParameter("param_simpnttSeq");
    	
    	nttSimpAnswerVO.setSimpnttSeq(simpnttSeq);
    	
    	// 댓글 총 갯수
    	Integer answerCnt = nttAnswerService.selectNttSimpAnswerListTotCnt(nttSimpAnswerVO);
    	nttSimpAnswerVO.setAnswerCnt(answerCnt.toString());
    	
    	model.addAttribute("nttSimpAnswerVO", nttSimpAnswerVO);
    	
        return "wzwg/module/ntt/simp/answer/answerForm";
    }
	
    /**
	 * ㅁ 게시물 댓글 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/simp/answer/selectNttSimpAnswerListAjax.do")
    public String selectNttSimpAnswerList(
    		@ModelAttribute("nttSimpAnswerVO") ModuleNttSimpAnswerVO nttSimpAnswerVO
    		, HttpServletRequest request
    		, ModelMap model
	    ) throws Exception {
    	
    	nttSimpAnswerVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
    	if(nttSimpAnswerVO.getOrdrSe() == null){
    		nttSimpAnswerVO.setOrdrSe("A");
    	}

    	// 댓글 목록
    	List<ModuleNttSimpAnswerVO> resultList = nttAnswerService.selectNttSimpAnswerList(nttSimpAnswerVO);

    	model.addAttribute("resultList", resultList);
    	model.addAttribute("nttSimpAnswerVO", nttSimpAnswerVO);
    	
        return "wzwg/module/ntt/simp/answer/answerList";
    }
    
    /**
	 * ㅁ 게시물 댓글 답글 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/simp/answer/selectNttSimpAnswerReplyFormAjax.do")
    public String selectNttSimpAnswerReplyForm(
    		@ModelAttribute("nttSimpAnswerVO") ModuleNttSimpAnswerVO nttSimpAnswerVO
    		, HttpServletRequest request
    		, ModelMap model
	    ) throws Exception {
    	
    	model.addAttribute("nttSimpAnswerVO", nttSimpAnswerVO);
    	
    	return "wzwg/module/ntt/simp/answer/answerReply";
    }

    /**
	 * ㅁ 게시물 댓글 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/simp/answer/registNttSimpAnswerAjax.do")
    public ModelAndView registAnswer(
            @ModelAttribute("nttSimpAnswerVO") ModuleNttSimpAnswerVO nttSimpAnswerVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {
    	
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		nttSimpAnswerVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		if (loginVO != null) {
			nttSimpAnswerVO.setWrterId(loginVO.getUserId());
			nttSimpAnswerVO.setWrterNm(loginVO.getUserNm());
			nttSimpAnswerVO.setWrterSeq(loginVO.getUsrSeq());
		}
		
		result = nttAnswerService.registNttSimpAnswer(nttSimpAnswerVO);	// 댓글 등록
		
		if(result > 0){
			// 댓글 총 갯수
	    	Integer answerCnt = nttAnswerService.selectNttSimpAnswerListTotCnt(nttSimpAnswerVO);
	    	
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
    @RequestMapping(value="/**/module/ntt/simp/answer/modifyNttSimpAnswerAjax.do")
    public ModelAndView modifyAnswer(
            @ModelAttribute("nttSimpAnswerVO") ModuleNttSimpAnswerVO nttSimpAnswerVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		nttSimpAnswerVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));		
		if (loginVO != null) {
			nttSimpAnswerVO.setWrterId(loginVO.getUserId());
			nttSimpAnswerVO.setWrterNm(loginVO.getUserNm());
			nttSimpAnswerVO.setWrterSeq(loginVO.getUsrSeq());
		}
		
		result = nttAnswerService.modifyNttSimpAnswer(nttSimpAnswerVO);	// 댓글 수정
		
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
    @RequestMapping(value="/**/module/ntt/simp/answer/deleteNttSimpAnswerAjax.do")
    public ModelAndView deleteAnswer(
            @ModelAttribute("nttSimpAnswerVO") ModuleNttSimpAnswerVO nttSimpAnswerVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {

		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		nttSimpAnswerVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		if (loginVO != null) {
			nttSimpAnswerVO.setLastUpdusrId(loginVO.getUserId());
			nttSimpAnswerVO.setWrterSeq(loginVO.getUsrSeq());
		}
		
		result = nttAnswerService.deleteNttSimpAnswer(nttSimpAnswerVO);	// 댓글 삭제
		
		if(result > 0){
			// 댓글 총 갯수
	    	Integer answerCnt = nttAnswerService.selectNttSimpAnswerListTotCnt(nttSimpAnswerVO);
	    	
	    	return CmmAjaxUtil.getAjaxReturn(String.valueOf(answerCnt.intValue()));
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
    }
	
	
}
