package egovframework.wzwg.module.ntt.cmmn.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsCmmnService;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;
import egovframework.wzwg.module.bbs.custom.service.ModuleBbsCustomBassInfoService;
import egovframework.wzwg.module.bbs.custom.service.ModuleBbsCustomVO;
import egovframework.wzwg.module.bbs.unity.service.ModuleBbsUnityBassInfoService;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttCmmnService;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;
import net.sf.json.JSONObject;

@Controller
public class ModuleNttCmmnController {


    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

    /** ModuleNttService */
    @Resource(name="ModuleNttCmmnService")
    protected ModuleNttCmmnService nttService;
    
    /** ModuleBbsCmmnService */
    @Resource(name="ModuleBbsCmmnService")
    protected ModuleBbsCmmnService bbsCmmnService;
    
    /** ModuleBbsUnityBassInfoService */
    @Resource(name="ModuleBbsUnityBassInfoService")
    protected ModuleBbsUnityBassInfoService bbsUnityBassInfoService;
    
    /** ModuleBbsCustomBassInfoService */
    @Resource(name="ModuleBbsCustomBassInfoService")
    protected ModuleBbsCustomBassInfoService bbsCustomBassInfoService;
    
    
    
    /**
	 * ㅁ 통합게시판 - 데이터관리 - 게시물 임시저장
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/cmmn/registTmprnttInfoAjax.do")
	public ModelAndView registTmprnttInfo(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setUsrSeq(loginVO.getUsrSeq());
			paramVO.setNtcrId(loginVO.getUserId());
			paramVO.setNtcrNm(loginVO.getUserNm());
		}

		String tmprnttSeq = StringUtils.defaultString(paramVO.getTmprnttSeq());
		
		if("".equals(tmprnttSeq)){
			paramVO.setTmprnttSeq(nttService.selectNextTmprnttSeq());
			result = nttService.registTmprnttInfo(paramVO);	// 등록
		}else{
			result = nttService.modifyTmprnttInfo(paramVO);	// 수정
		}
		
		// 임시게시물 목록 갯수
		Integer tmprnttListCnt = nttService.selectTmprnttListTotCnt(paramVO); 
				
		if(result > 0){
    		return CmmAjaxUtil.getAjaxReturn(tmprnttListCnt.toString());
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
    /**
	 * ㅁ 게시물 - 임시저장 목록 팝업
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/cmmn/selectTmprnttPopup.do")
	public String selectTmprnttPopup(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		return "wzwg/module/ntt/cmmn/tmprnttPopup";
	}
	
	/**
	 * ㅁ 게시물 - 임시저장 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/cmmn/selectTmprnttListAjax.do")
	public String selectTmprnttList(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setUsrSeq(loginVO.getUsrSeq());
		}
		
		List<ModuleNttVO> tmprnttList = nttService.selectTmprnttList(paramVO);
    	model.addAttribute("tmprnttList", tmprnttList);
		
		return "wzwg/module/ntt/cmmn/tmprnttList";
	}
	
	/**
	 * ㅁ 게시물 - 임시저장 정보
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/cmmn/selectTmprnttDetailAjax.do")
	public ModelAndView selectTmprnttDetailJson(
			@RequestParam(value="searchTmprnttSeq", required=false) String searchTmprnttSeq
			, HttpServletRequest request 
		) throws Exception{
		
		ModuleNttVO resultVO = nttService.selectTmprnttDetail(searchTmprnttSeq);		// 임시게시물 정보
		
		ModelAndView model = new ModelAndView();
	    
        model.setViewName("jsonView");
        model.addObject("rmprnttInfo", JSONObject.fromObject(resultVO));
        
		return model;
	}
	
	/**
	 * ㅁ 게시물 - 임시저장 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/cmmn/deleteTmprnttInfoAjax.do")
	public ModelAndView deleteTmprnttInfo(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		if (loginVO != null) {
			paramVO.setUsrSeq(loginVO.getUsrSeq());
		}
		//paramVO.setTmprnttSeq(tmprnttSeq);
		
		result = nttService.deleteTmprnttInfo(paramVO);		// 임시게시물 삭제
		
		// 임시게시물 목록 갯수
		Integer tmprnttListCnt = nttService.selectTmprnttListTotCnt(paramVO); 
				
		if(result > 0){
    		return CmmAjaxUtil.getAjaxReturn(tmprnttListCnt.toString());
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
    	
	}
	
    /**
	 * ㅁ 게시물 - 이동 팝업
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/cmmn/mvmnNttPopup.do")
	public String mvmnNttPopup(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		List<ModuleNttVO> bbsList = nttService.selectNttMvmnBbsList(paramVO);
    	model.addAttribute("bbsList", bbsList);
		
		return "wzwg/module/ntt/cmmn/mvmnNttPopup";
	}
	
	/**
	 * ㅁ 게시물 - 이동
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/cmmn/mvmnNttAjax.do")
	public ModelAndView mvmnNtt(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		Integer result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		result = nttService.mvmnNtt(paramVO);		// 이동
				
		if(result > 0){
    		return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}

	}
    
	/**
	 * ㅁ 게시물 - 말머리 수정 팝업
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/cmmn/modifySubospecPopup.do")
	public String modifySubospecPopup(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		List<ModuleBbsVO> subospecList = bbsCmmnService.selectBbsSubospecList(paramVO.getBbsSeq());	// 말머리 목록
		model.addAttribute("subospecList", subospecList);
		
		return "wzwg/module/ntt/cmmn/subospecModifyPopup";
	}
	
	/**
	 * ㅁ 게시물 - 말머리 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/cmmn/modifySubospecAjax.do")
	public ModelAndView modifySubospec(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		Integer result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		result = nttService.modifyCheckNttSubospec(paramVO);		// 수정
				
		if(result > 0){
    		return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
    /**
	 * ㅁ 게시물 - 좋아요 정보
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/cmmn/selectNttLikeAjax.do")
	public String selectNttLike(
			@RequestParam(value="nttSeq", required=false) String nttSeq
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		ModuleNttVO resultVO = new ModuleNttVO();
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			resultVO.setUsrSeq(loginVO.getUsrSeq());
		}
		resultVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));

		List<ModuleNttVO> resultList = nttService.selectNttLike(resultVO);		// 좋아요 정보
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultVO", resultVO);
		
		return "wzwg/module/ntt/cmmn/nttLikeList";
	}
	
    /**
	 * ㅁ 게시물 - 좋아요
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/cmmn/registNttLikeAjax.do")
	public ModelAndView registNttLike(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, @RequestParam(value="nttSeq", required=false) String nttSeq
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		Integer result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		if (loginVO != null) {
			paramVO.setUsrSeq(loginVO.getUsrSeq());
			paramVO.setFrstRegisterId(loginVO.getUserId());
		}
		
		result = nttService.registNttLike(paramVO);		// 좋아요
				
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn(result.toString());
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ 게시물 - 좋아요 취소
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/cmmn/deleteNttLikeCanclAjax.do")
	public ModelAndView deleteNttLikeCancl(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, @RequestParam(value="nttSeq", required=false) String nttSeq
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		Integer result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setUsrSeq(loginVO.getUsrSeq());
		}
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		result = nttService.deleteNttLikeCancl(paramVO);		// 좋아요 취소
				
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn(result.toString());
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
		
	}

	/**
	 * ㅁ 게시물 - 게시물 작성자
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/cmmn/selectNttNtcrIdAjax.do")
	public ModelAndView selectNttNtcrId(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, @RequestParam(value="nttSeq", required=false) String nttSeq
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
			String ntcrId = "";

			paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
			paramVO.setNttSeq(nttSeq);
			ntcrId = nttService.selectNttNtcrId(paramVO);

			return CmmAjaxUtil.getAjaxReturn(ntcrId);
	
	}
	
	
	/**
	 * ㅁ 게시물 - 공지사항 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/cmmn/selectNttNoticeListAjax.do")
	public String selectNttNoticeListAjax(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, @RequestParam(value="expsrAt", required=false) String expsrAt
			, @RequestParam(value="adminAuthAt", required=false) String adminAuthAt
			, @RequestParam(value="mobileAt", required=false) String mobileAt
			, @RequestParam(value="subospecSeq", required=false) String subospecSeq
			, @RequestParam(value="noticeSe", required=false) String noticeSe
			, @RequestParam(value="faqTabAt", required=false) String faqTabAt
			, @RequestParam(value="customSe", required=false) String customSe
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		paramVO.setFaqTabAt(faqTabAt);
		
		// 공지게시물 목록
		List<ModuleNttVO> noticeList = nttService.selectNttNoticeList(paramVO);

		model.addAttribute("noticeList", noticeList);
		model.addAttribute("expsrAt", expsrAt);
		model.addAttribute("adminAuthAt", adminAuthAt);
		model.addAttribute("mobileAt", mobileAt);
		model.addAttribute("subospecSeq", subospecSeq);
		model.addAttribute("noticeSe", noticeSe);
		
		if(customSe != null && !"".equals(customSe)){
			
			Map<String, String> fieldVO = new HashMap<String, String>();
			fieldVO.put("siteSeq", paramVO.getSiteSeq());
			fieldVO.put("bbsSeq", paramVO.getBbsSeq());
			List<ModuleBbsCustomVO> fieldList = bbsCustomBassInfoService.selectBbsBassInfoCustomFieldList(fieldVO);
			model.addAttribute("fieldList", fieldList);
			
			List<String> dimListFields = new ArrayList<String>();
			
			for (ModuleBbsCustomVO bbsCustomVO : fieldList) {
				if(bbsCustomVO.getListAt().equalsIgnoreCase("Y") == false){
					dimListFields.add(bbsCustomVO.getFieldId());
				}
			}
			
			// 목록에 포함되지 않는 필드를 제거해준 리스트
			List<ModuleNttVO> resultList2 = new ArrayList<ModuleNttVO>();
			for(int i=0;i <noticeList.size();i++){
				ModuleNttVO moduleNtt = new ModuleNttVO();
				moduleNtt = noticeList.get(i);
				String nttCn = moduleNtt.getNttCn();
				ObjectMapper m = new ObjectMapper();
				Map<String, Object> map = new HashMap<String, Object>();
				map = m.readValue(nttCn, new TypeReference<Map<String,Object>>() {} );
				
				for (String filedKey : dimListFields) {
					if(!filedKey.equals("password")){
					map.put(filedKey, "");
					}
				}
				
				String convertNttCn = m.writeValueAsString(map);
				moduleNtt.setNttCn(convertNttCn);
				
				resultList2.add(moduleNtt);
				
			}
			
		}
		
		return "wzwg/module/ntt/cmmn/noticeList";
		
	}
	
	/**
	 * ㅁ 게시물 - 공지게시물 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/cmmn/modifyNttNoticeAjax.do")
	public ModelAndView modifyNttNoticeAjax(
			@ModelAttribute("paramVO") ModuleNttVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		result = nttService.modifyNttNotice(paramVO);	// 공지게시물 수정
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	

}
