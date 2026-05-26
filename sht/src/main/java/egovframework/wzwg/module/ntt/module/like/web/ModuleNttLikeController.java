package egovframework.wzwg.module.ntt.module.like.web;

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
import egovframework.wzwg.module.ntt.module.like.service.ModuleNttLikeService;
import egovframework.wzwg.module.ntt.module.like.service.ModuleNttLikeVO;

@Controller
public class ModuleNttLikeController {


    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

    /** ModuleNttLikeService */
    @Resource(name="ModuleNttLikeService")
    protected ModuleNttLikeService nttLikeService;
    
    
    /**
	 * ㅁ 게시물 좋아요 
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/like/selectNttLikeIncAjax.do")
    public String selectNttLikeInc(
    		@ModelAttribute("nttLikeVO") ModuleNttLikeVO nttLikeVO
    		, HttpServletRequest request
    		, ModelMap model
	    ) throws Exception {

    	String nttSeq = (String) request.getParameter("param_nttSeq");
    	
    	nttLikeVO.setNttSeq(nttSeq);
    	
    	// 좋아요 총 갯수
    	Integer likeCnt = nttLikeService.selectNttLikeListTotCnt(nttLikeVO);
    	nttLikeVO.setLikeCnt(likeCnt.toString());
    	
    	model.addAttribute("likeCnt", likeCnt.toString());
    	
        return "wzwg/module/ntt/module/like/likeInc";
    }
    
    /**
	 * ㅁ 게시물 좋아요 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/like/selectNttLikeFormAjax.do")
    public String selectNttLikeForm(
    		@ModelAttribute("nttLikeVO") ModuleNttLikeVO nttLikeVO
    		, HttpServletRequest request
    		, ModelMap model
	    ) throws Exception {

    	String nttSeq = (String) request.getParameter("param_nttSeq");
    	
    	nttLikeVO.setNttSeq(nttSeq);
    	
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");

		if(loginVO != null){
			nttLikeVO.setUsrSeq(loginVO.getUsrSeq());
		} else {
			nttLikeVO.setUsrSeq("0");
		}	    	
    	
    	// 좋아요 등록여부
    	Integer likeAt = nttLikeService.selectNttLikeAt(nttLikeVO);
    	model.addAttribute("likeAt", likeAt.intValue());
    	
    	// 좋아요 총 갯수
    	Integer likeCnt = nttLikeService.selectNttLikeListTotCnt(nttLikeVO);
    	nttLikeVO.setLikeCnt(likeCnt.toString());
    	
    	model.addAttribute("nttLikeVO", nttLikeVO);
    	
        return "wzwg/module/ntt/module/like/likeForm";
    }
    
    /**
	 * ㅁ 게시물 좋아요 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/like/registNttLikeAjax.do")
	public ModelAndView registNttLike(
			@ModelAttribute("nttLikeVO") ModuleNttLikeVO nttLikeVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		nttLikeVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		if (loginVO != null) {
			nttLikeVO.setUsrSeq(loginVO.getUsrSeq());
			nttLikeVO.setFrstRegisterId(loginVO.getUserId());
		}
		
		result = nttLikeService.registNttLike(nttLikeVO);	// 저장
		
		// 게시물 좋아요 총 갯수
		Integer likeCnt = nttLikeService.selectNttLikeListTotCnt(nttLikeVO); 
				
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn(likeCnt.toString());
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
		
	}
	
	/**
	 * ㅁ 게시물 좋아요 취소
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/like/deleteNttLikeAjax.do")
	public ModelAndView deleteNttLike(
			@ModelAttribute("nttLikeVO") ModuleNttLikeVO nttLikeVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		nttLikeVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		if (loginVO != null) {
			nttLikeVO.setUsrSeq(loginVO.getUsrSeq());
		}
		
		int result = 0;
		
		result = nttLikeService.deleteNttLike(nttLikeVO);	// 저장
		
		// 게시물 좋아요 총 갯수
		Integer likeCnt = nttLikeService.selectNttLikeListTotCnt(nttLikeVO); 
				
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn(likeCnt.toString());
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ 게시물 좋아요 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/like/selectNttLikeListAjax.do")
	public String selectNttLikeList(
			@ModelAttribute("nttLikeVO") ModuleNttLikeVO nttLikeVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		nttLikeVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		List<ModuleNttLikeVO> likeList = nttLikeService.selectNttLikeList(nttLikeVO);	// 목록
		model.addAttribute("likeList", likeList);
		
		model.addAttribute("nttLikeVO", nttLikeVO);
		
		return "wzwg/module/ntt/module/like/likeList";
	}
	
}
