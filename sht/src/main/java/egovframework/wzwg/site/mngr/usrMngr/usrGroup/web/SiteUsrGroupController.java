package egovframework.wzwg.site.mngr.usrMngr.usrGroup.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.cmm.util.ajax.AjaxXmlView;
import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupService;
import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupVO;
import egovframework.wzwg.site.mngr.usrMngr.usrLog.service.SiteUsrLogService;
import egovframework.wzwg.site.mngr.usrMngr.usrLog.service.SiteUsrLogVO;
import egovframework.wzwg.sysMngr.usrMngr.usrInfo.service.SysMngrUsrInfoService;
import egovframework.wzwg.sysMngr.usrMngr.usrInfo.service.SysMngrUsrInfoVO;
import egovframework.wzwg.sysMngr.usrMngr.usrTy.service.SysMngrUsrTyService;
import egovframework.wzwg.sysMngr.usrMngr.usrTy.service.SysMngrUsrTyVO;
import net.sourceforge.ajaxtags.xml.AjaxXmlBuilder;

@Controller
public class SiteUsrGroupController {
    
	@Resource(name="SysMngrUsrTyService")
	SysMngrUsrTyService sysMngrUsrTyService;
    
    @Resource(name="SiteUsrGroupService")
    SiteUsrGroupService siteUsrGroupService;
    
    @Resource(name="SysMngrUsrInfoService")
    SysMngrUsrInfoService sysMngrUsrInfoService;
    
    @Resource(name="SiteUsrLogService")
    private SiteUsrLogService siteUsrLogService;
    
	/**
	 * 사이트 사용자 그룹 리스트 조회
	 * @param siteUsrGroupVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/mngr/usrMngr/usrGroup/selectSiteUsrGroupList.do","/{siteKey}/mngr/usrMngr/usrGroup/selectSiteUsrGroupList.do"})
	public String selectSiteUsrGroupList(
			@ModelAttribute("paramVO")SiteUsrGroupVO siteUsrGroupVO
			, HttpServletRequest request
			, Model model 
			){
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteUsrGroupVO.setSiteSeq(siteSeq);
		
		/** =================== paging 시작 ============================== */
		PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(siteUsrGroupVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(siteUsrGroupVO.getPageUnit());
        paginationInfo.setPageSize(siteUsrGroupVO.getPageSize());
       
        siteUsrGroupVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        siteUsrGroupVO.setLastIndex(paginationInfo.getLastRecordIndex());
        siteUsrGroupVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        int totCnt = siteUsrGroupService.selectSiteUsrGroupTotCnt(siteUsrGroupVO);
        paginationInfo.setTotalRecordCount(totCnt);
		
        /* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
        /** =================== paging 끝 =============================== */
		
		List<SiteUsrGroupVO> siteUsrGroupList = siteUsrGroupService.selectSiteUsrGroupList(siteUsrGroupVO);
		
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("siteUsrGroupList", siteUsrGroupList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "/wzwg/site/mngr/usrMngr/usrGroup/SiteUsrGroupList";
	}
	
	/**
	 * 사이트 사용자 그룹 등록 폼
	 * @param siteUsrGroupVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/mngr/usrMngr/usrGroup/registSiteUsrGroupForm.do","/{siteKey}/mngr/usrMngr/usrGroup/registSiteUsrGroupForm.do"})
	public String registSiteUsrGroupForm(
			@ModelAttribute("paramVO")SiteUsrGroupVO paramVO
			,HttpServletRequest request
			, Model model
			){
		
		/** usrty 테이블 코드 조회 */
		List<SysMngrUsrTyVO> usrTyCodeList = sysMngrUsrTyService.selectUsrTyCodeList();
		model.addAttribute("usrTyCodeList", usrTyCodeList);
		
		return "/wzwg/site/mngr/usrMngr/usrGroup/SiteUsrGroupRegistForm";
	}

	/**
	 * 사이트 사용자 그룹 등록
	 * @param siteUsrGroupVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value= {"/mngr/usrMngr/usrGroup/registSiteUsrGroup.do","/{siteKey}/mngr/usrMngr/usrGroup/registSiteUsrGroup.do"})
	public ModelAndView registSiteUsrGroup(
			@ModelAttribute("paramVO")SiteUsrGroupVO siteUsrGroupVO
			,HttpServletRequest request
			, Model model
			){
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		siteUsrGroupVO.setUserId(loginVO.getUserId());
		
		/** 사이트시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteUsrGroupVO.setSiteSeq(siteSeq);
		
		int registResult = siteUsrGroupService.registSiteUsrGroup(siteUsrGroupVO);
		
        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        if(registResult < 1){
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "fail").toString());
        }else{
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        }
        
        return ajaxModel;

	}
	
	/**
	 * 사이트 사용자 그룹 상세 조회
	 * @param siteUsrGroupVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/mngr/usrMngr/usrGroup/selectSiteUsrGroupDetail.do","/{siteKey}/mngr/usrMngr/usrGroup/selectSiteUsrGroupDetail.do"})
	public String selectSiteUsrGroupDetail(
			@ModelAttribute("paramVO") SiteUsrGroupVO paramVO
			,HttpServletRequest request
			, Model model
			){
		
		SiteUsrGroupVO siteUsrGroupVO = new SiteUsrGroupVO();
		
		siteUsrGroupVO.setUsrGroupSeq(paramVO.getUsrGroupSeq());
		
		/** usrty 테이블 코드 조회 */
		siteUsrGroupVO = siteUsrGroupService.selectSiteUsrGroupDetail(siteUsrGroupVO);
		model.addAttribute("siteUsrGroupVO", siteUsrGroupVO);
        
		return "/wzwg/site/mngr/usrMngr/usrGroup/SiteUsrGroupDetail";
	}
	
	@RequestMapping(value= {"/mngr/usrMngr/usrGroup/SiteUsrInfoGroupListAjax.do","/{siteKey}/mngr/usrMngr/usrGroup/SiteUsrInfoGroupListAjax.do"})
	public String SiteUsrInfoGroupList(
			@ModelAttribute("paramVO")SiteUsrGroupVO siteUsrGroupVO
			, SysMngrUsrInfoVO sysMngrUsrInfoVO
			, HttpSession session
			,HttpServletRequest request
			, Model model
			) throws Exception{
		sysMngrUsrInfoVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		/** =================== paging 시작 ============================== */
		PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(sysMngrUsrInfoVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(sysMngrUsrInfoVO.getPageUnit());
        paginationInfo.setPageSize(sysMngrUsrInfoVO.getPageSize());
       
        sysMngrUsrInfoVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        sysMngrUsrInfoVO.setLastIndex(paginationInfo.getLastRecordIndex());
        sysMngrUsrInfoVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        /** =================== paging 끝 =============================== */ 
        
		// 사이트 정보 카운트
		Integer usrInfoCnt = sysMngrUsrInfoService.selectUsrInfoListCnt(sysMngrUsrInfoVO);
		
		// 사용자 정보 목록
		List<SysMngrUsrInfoVO> usrInfoList = sysMngrUsrInfoService.selectUsrInfoList(sysMngrUsrInfoVO);
		
		paginationInfo.setTotalRecordCount(usrInfoCnt.intValue());
		
		/* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
        
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
		
        List<SiteUsrGroupVO> usrGroupCode = siteUsrGroupService.selectSiteUsrGroupCode(sysMngrUsrInfoVO.getSiteSeq());
        
      for(int i =0;i<usrInfoList.size();i++){
    	java.util.Enumeration params = request.getParameterNames();
		String usrlogParam = "";
		boolean bBadWord= false;
		while ( params.hasMoreElements() ) {
			String name = (String)params.nextElement();
			String value = dggb.util.StringUtils.nvl(request.getParameter(name), "");
			if(!name.equals("password") && !name.startsWith("hTel")){
			usrlogParam =usrlogParam+"&"+name+"="+value;
			}
		}
		if(!usrlogParam.equals("")){
		usrlogParam = usrlogParam.substring(1);
		}
    	 CmmLoginVO resultVO2 = new CmmLoginVO(); 
    	SiteUsrLogVO  siteUsrLogVO = new SiteUsrLogVO();
    	siteUsrLogVO.setConectIp(request.getRemoteAddr());
    	siteUsrLogVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId()); 
    	siteUsrLogVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	siteUsrLogVO.setUsrChngCode("SC00000448"); 
    	siteUsrLogVO.setUsrlogParam(usrlogParam);
    	siteUsrLogVO.setUsrlogUrl(request.getRequestURI());
    	siteUsrLogVO.setUsrlogUsrSeq(CmmSessionUtil.getLoginVO().getUsrSeq());
    	siteUsrLogVO.setUsrSeq(usrInfoList.get(i).getUsrSeq());
    	siteUsrLogService.insertSiteUsrLog(siteUsrLogVO);
    }
        
        model.addAttribute("usrGroupCode", usrGroupCode);
        
		model.addAttribute("usrInfoCnt", usrInfoCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("usrInfoList", usrInfoList);
        
		return "/wzwg/site/mngr/usrMngr/usrGroup/SiteUsrInfoGroupList";
	}
	
	
	@RequestMapping(value= {"/mngr/usrMngr/usrGroup/SiteUsrInfoNonGroupListAjax.do","/{siteKey}/mngr/usrMngr/usrGroup/SiteUsrInfoNonGroupListAjax.do"})
	public String SiteUsrInfoNonGroupListAjax(
			@ModelAttribute("paramVO")SiteUsrGroupVO siteUsrGroupVO
			, SysMngrUsrInfoVO sysMngrUsrInfoVO
			, HttpSession session
			,HttpServletRequest request
			, Model model
			) throws Exception{
		sysMngrUsrInfoVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		/** =================== paging 시작 ============================== */
		PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(sysMngrUsrInfoVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(sysMngrUsrInfoVO.getPageUnit());
        paginationInfo.setPageSize(sysMngrUsrInfoVO.getPageSize());
       
        sysMngrUsrInfoVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        sysMngrUsrInfoVO.setLastIndex(paginationInfo.getLastRecordIndex());
        sysMngrUsrInfoVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        /** =================== paging 끝 =============================== */ 
        sysMngrUsrInfoVO.setNonUsrGroupSeq(sysMngrUsrInfoVO.getUsrGroupSeq());
        sysMngrUsrInfoVO.setUsrGroupSeq("");
        
		// 사이트 정보 카운트
		Integer usrInfoCnt = sysMngrUsrInfoService.selectUsrInfoListCnt(sysMngrUsrInfoVO);
		
		// 사용자 정보 목록
		List<SysMngrUsrInfoVO> usrInfoList = sysMngrUsrInfoService.selectUsrInfoList(sysMngrUsrInfoVO);
		
		paginationInfo.setTotalRecordCount(usrInfoCnt.intValue());
		 

        
        List<SiteUsrGroupVO> usrGroupCode = siteUsrGroupService.selectSiteUsrGroupCode(sysMngrUsrInfoVO.getSiteSeq());
        
      for(int i =0;i<usrInfoList.size();i++){
    	java.util.Enumeration params = request.getParameterNames();
		String usrlogParam = "";
		boolean bBadWord= false;
		while ( params.hasMoreElements() ) {
			String name = (String)params.nextElement();
			String value = dggb.util.StringUtils.nvl(request.getParameter(name), "");
			if(!name.equals("password") && !name.startsWith("hTel")){
			usrlogParam =usrlogParam+"&"+name+"="+value;
			}
		}
		if(!usrlogParam.equals("")){
		usrlogParam = usrlogParam.substring(1);
		}
    	 CmmLoginVO resultVO2 = new CmmLoginVO(); 
    	SiteUsrLogVO  siteUsrLogVO = new SiteUsrLogVO();
    	siteUsrLogVO.setConectIp(request.getRemoteAddr());
    	siteUsrLogVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId()); 
    	siteUsrLogVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	siteUsrLogVO.setUsrChngCode("SC00000448"); 
    	siteUsrLogVO.setUsrlogParam(usrlogParam);
    	siteUsrLogVO.setUsrlogUrl(request.getRequestURI());
    	siteUsrLogVO.setUsrlogUsrSeq(CmmSessionUtil.getLoginVO().getUsrSeq());
    	siteUsrLogVO.setUsrSeq(usrInfoList.get(i).getUsrSeq());
    	siteUsrLogService.insertSiteUsrLog(siteUsrLogVO);
    }
        
        model.addAttribute("usrGroupCode", usrGroupCode);
        
		model.addAttribute("usrInfoCnt", usrInfoCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("usrInfoList", usrInfoList);
        
		return "/wzwg/site/mngr/usrMngr/usrGroup/SiteUsrInfoNonGroupList";
	}
	
	/**
	 * 사이트 사용자 그룹 수정 폼
	 * @param siteUsrGroupVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value= {"/mngr/usrMngr/usrGroup/modifySiteUsrGroupForm.do","/{siteKey}/mngr/usrMngr/usrGroup/modifySiteUsrGroupForm.do"})
	public String modifySiteUsrGroupForm(
			@ModelAttribute("paramVO")SiteUsrGroupVO siteUsrGroupVO
			,HttpServletRequest request
			, Model model
			){

		List<SysMngrUsrTyVO> usrTyCodeList = sysMngrUsrTyService.selectUsrTyCodeList();
		model.addAttribute("usrTyCodeList", usrTyCodeList);
		
		siteUsrGroupVO = siteUsrGroupService.selectSiteUsrGroupDetail(siteUsrGroupVO);
		model.addAttribute("siteUsrGroupVO", siteUsrGroupVO);
		
		return "/wzwg/site/mngr/usrMngr/usrGroup/SiteUsrGroupModifyForm";
	}
	
	/**
	 * 사이트 사용자 그룹 수정
	 * @param siteUsrGroupVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value= {"/mngr/usrMngr/usrGroup/modifySiteUsrGroup.do","/{siteKey}/mngr/usrMngr/usrGroup/modifySiteUsrGroup.do"})
	public ModelAndView modifySiteUsrGroup(
			@ModelAttribute("paramVO")SiteUsrGroupVO siteUsrGroupVO
			,HttpServletRequest request
			, Model model
			){

		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		siteUsrGroupVO.setUserId(loginVO.getUserId());
		
		int modifyResult = siteUsrGroupService.modifySiteUsrGroup(siteUsrGroupVO);
		
        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        if(modifyResult < 1){
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "fail").toString());
        }else{
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        }
        
        return ajaxModel;
	}
	
	/**
	 * 사이트  그룹 삭제
	 * @param siteUsrGroupVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value= {"/mngr/usrMngr/usrGroup/deleteSiteUsrGroup.do","/{siteKey}/mngr/usrMngr/usrGroup/deleteSiteUsrGroup.do"})
	public ModelAndView deleteSiteUsrGroup(
			@ModelAttribute("paramVO")SiteUsrGroupVO siteUsrGroupVO
			,HttpServletRequest request
			, Model model
			){
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		siteUsrGroupVO.setUserId(loginVO.getUserId());
		
		int deleteResult = siteUsrGroupService.deleteSiteUsrGroup(siteUsrGroupVO);
		
        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        if(deleteResult < 1){
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "fail").toString());
        }else{
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        }
        
        return ajaxModel;
	}
	
	/**
	 * 사이트 사용자 그룹 삭제
	 * @param siteUsrGroupVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value= {"/mngr/usrMngr/usrGroup/deleteSiteUsrInfoGroup.do","/{siteKey}/mngr/usrMngr/usrGroup/deleteSiteUsrInfoGroup.do"})
	public ModelAndView deleteSiteUsrInfoGroup(
			@ModelAttribute("paramVO")SiteUsrGroupVO siteUsrGroupVO
			, SysMngrUsrInfoVO sysMngrUsrInfoVO
			,HttpServletRequest request
			, Model model
			) throws Exception{
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		siteUsrGroupVO.setUserId(loginVO.getUserId());
		
		sysMngrUsrInfoVO.setLastUpdusrId(loginVO.getUserId());
		sysMngrUsrInfoVO.setUsrGroupSeq("");
		//int deleteResult = siteUsrGroupService.deleteSiteUsrGroup(siteUsrGroupVO);
		int deleteResult = sysMngrUsrInfoService.modifyUsrinfoGroup(sysMngrUsrInfoVO, request);
		
        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        if(deleteResult < 1){
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "fail").toString());
        }else{
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        }
        
        return ajaxModel;
	}
	
	
	/**
	 * 사이트 사용자 그룹 삭제
	 * @param siteUsrGroupVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value= {"/mngr/usrMngr/usrGroup/registSiteUsrInfoGroup.do","/{siteKey}/mngr/usrMngr/usrGroup/registSiteUsrInfoGroup.do"})
	public ModelAndView registSiteUsrInfoGroup(
			@ModelAttribute("paramVO")SiteUsrGroupVO siteUsrGroupVO
			, SysMngrUsrInfoVO sysMngrUsrInfoVO
			,HttpServletRequest request
			, Model model
			) throws Exception{
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		siteUsrGroupVO.setUserId(loginVO.getUserId());
		
		sysMngrUsrInfoVO.setLastUpdusrId(loginVO.getUserId());
		sysMngrUsrInfoVO.setChk(sysMngrUsrInfoVO.getChknon()); 
		//int deleteResult = siteUsrGroupService.deleteSiteUsrGroup(siteUsrGroupVO);
		int deleteResult = sysMngrUsrInfoService.modifyUsrinfoGroup(sysMngrUsrInfoVO, request);
		
        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        if(deleteResult < 1){
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "fail").toString());
        }else{
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        }
        
        return ajaxModel;
	}
	
}
