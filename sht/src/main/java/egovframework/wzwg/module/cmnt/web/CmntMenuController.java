package egovframework.wzwg.module.cmnt.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;
import egovframework.wzwg.module.bbs.unity.service.ModuleBbsUnityBassInfoService;
import egovframework.wzwg.module.cmnt.service.CmntMenuAuthService;
import egovframework.wzwg.module.cmnt.service.CmntMenuAuthVO;
import egovframework.wzwg.module.cmnt.service.CmntMenuService;
import egovframework.wzwg.module.cmnt.service.CmntMenuVO;
import egovframework.wzwg.module.cmnt.service.CmntUserService;
import egovframework.wzwg.module.cmnt.service.CmntUserVO;
import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntCfgService;
import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntInfoService;
import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.usrMngr.usrInfo.service.SysMngrUsrInfoService;

@Controller
public class CmntMenuController {
	
	@Resource(name="SiteCmntCfgService")
	private SiteCmntCfgService siteCmntCfgService;
	
	/** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
    
    @Resource(name="SiteCmntInfoService")
	private SiteCmntInfoService siteCmntInfoService;
    
    @Resource(name="CmmCodeService")
    private CmmCodeService codeService;
    
    @Resource(name="SiteUsrGroupService")
	SiteUsrGroupService siteUsrGroupService;
    
    @Resource(name="SysMngrUsrInfoService")
	private SysMngrUsrInfoService usrInfoService;
    
    @Resource(name="CmntMenuService")
	private CmntMenuService cmntMenuService;
    
    @Resource(name="CmntMenuAuthService")
  	private CmntMenuAuthService cmntMenuAuthService;
  
    @Resource(name="ModuleBbsUnityBassInfoService")
   	private ModuleBbsUnityBassInfoService bbsUnityBassInfoService;
    
    @Resource(name="CmntUserService")
	private CmntUserService cmntUserService;
	
	@RequestMapping(value= {"/module/cmnt/mngr/cmntMeunAjax.do","/{siteKey}/module/cmnt/mngr/cmntMeunAjax.do"})
	public String cmntMeunAjax(
			@ModelAttribute("paramVO") CmntMenuVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq); 
		model.addAttribute("menuList", cmntMenuService.selectCmntMenuList(paramVO));
		return "wzwg/module/cmnt/cmntMngrMenu";
	}
	
	@RequestMapping(value= {"/module/cmnt/mngr/modifyCmntMenuAjax.do","/{siteKey}/module/cmnt/mngr/modifyCmntMenuAjax.do"})
   	public ModelAndView modifyCmntMenuFormAjax (
   			@ModelAttribute("paramVO")CmntMenuVO paramVO
   			,@ModelAttribute("cmntMenuAuthVO") CmntMenuAuthVO cmntMenuAuthVO
   			, HttpServletRequest request 
   			, HttpServletResponse response
   			) throws Exception {
   			ModelAndView model = new ModelAndView();
   	    	model.setViewName("jsonView"); 
   		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
   		paramVO.setSiteSeq(siteSeq);  
   		cmntMenuAuthVO.setSiteSeq(siteSeq);
	   		cmntMenuService.modifyCmntMenu(paramVO);
	   		ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
	   		moduleBbsVO.setBbsNm(paramVO.getMenuNm());
	   		moduleBbsVO.setBbsDc(paramVO.getMenuNm());
	   		moduleBbsVO.setListScrinCode(paramVO.getListScrinCode());
	   		moduleBbsVO.setAtchFilePosblAt(paramVO.getAtchFilePosblAt());
	   		moduleBbsVO.setAtchFilePosblCo(paramVO.getAtchFilePosblCo());
	   		moduleBbsVO.setListNumCode("P");
	   		moduleBbsVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
	   		moduleBbsVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
	   		moduleBbsVO.setBbsSeq(paramVO.getBbsSeq());
	   		moduleBbsVO.setExpsrAt("N,W,R,I");
	   		bbsUnityBassInfoService.modifyBbsBassInfo(moduleBbsVO);
	   		cmntMenuAuthService.deleteCmntMenuAuth(cmntMenuAuthVO);
	   		
	   		if(cmntMenuAuthVO.getAuthSeAppC() !=null && cmntMenuAuthVO.getAuthSeAppC().equals("Y")){
	   		cmntMenuAuthVO.setApprvlCode("SC00000339");
	   		cmntMenuAuthVO.setAuthSe("C");
	   		cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO);
	   		}
	   		if(cmntMenuAuthVO.getAuthSeAppR() !=null && cmntMenuAuthVO.getAuthSeAppR().equals("Y")){
	   		cmntMenuAuthVO.setApprvlCode("SC00000339");
	   		cmntMenuAuthVO.setAuthSe("R");
	   		cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO);
	   		}
	   		if(cmntMenuAuthVO.getAuthSeAppW() !=null && cmntMenuAuthVO.getAuthSeAppW().equals("Y")){
	   		cmntMenuAuthVO.setApprvlCode("SC00000339");
	   		cmntMenuAuthVO.setAuthSe("W");
	   		cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO);
	   		}
	   		
	   		if(cmntMenuAuthVO.getAuthSeNappC() !=null && cmntMenuAuthVO.getAuthSeNappC().equals("Y")){
	   		cmntMenuAuthVO.setApprvlCode("SC00000340");
	   		cmntMenuAuthVO.setAuthSe("C");
	   		cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO);
	   		}
	   		if(cmntMenuAuthVO.getAuthSeNappR() !=null && cmntMenuAuthVO.getAuthSeNappR().equals("Y")){
	   		cmntMenuAuthVO.setApprvlCode("SC00000340");
	   		cmntMenuAuthVO.setAuthSe("R");
	   		cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO);
	   		}
	   		if(cmntMenuAuthVO.getAuthSeNappW() !=null && cmntMenuAuthVO.getAuthSeNappW().equals("Y")){
	   		cmntMenuAuthVO.setApprvlCode("SC00000340");
	   		cmntMenuAuthVO.setAuthSe("W");
	   		cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO);
	   		}	
   	
   		return model;
   	}
	
	@RequestMapping(value= {"/module/cmnt/mngr/selectCmntMeunDetailAjax.do","/{siteKey}/module/cmnt/mngr/selectCmntMeunDetailAjax.do"})
	public ModelAndView selectCmntMeunDetailAjax(
			@ModelAttribute("paramVO") CmntMenuVO paramVO
			,@ModelAttribute("cmntMenuAuthVO") CmntMenuAuthVO cmntMenuAuthVO
			, HttpServletRequest request 
   			, HttpServletResponse response
   			) throws Exception {
   			ModelAndView model = new ModelAndView();
   	    	model.setViewName("jsonView"); 
		
		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq); 
		cmntMenuAuthVO.setSiteSeq(siteSeq);
		model.addObject("resultVO", cmntMenuService.selectCmntMenuDetail(paramVO));
		model.addObject("authList", cmntMenuAuthService.selectCmntMenuAuthList(cmntMenuAuthVO));
		return model;
	}
	
	@RequestMapping(value= {"/module/cmnt/mngr/registCmntMenuAjax.do","/{siteKey}/module/cmnt/mngr/registCmntMenuAjax.do"})
   	public ModelAndView registCmntMenuAjax (
   			@ModelAttribute("paramVO")CmntMenuVO paramVO
   			,@ModelAttribute("cmntMenuAuthVO") CmntMenuAuthVO cmntMenuAuthVO
   			, HttpServletRequest request 
   			, HttpServletResponse response
   			) throws Exception {
   			ModelAndView model = new ModelAndView();
   	    	model.setViewName("jsonView"); 
   		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
   		paramVO.setSiteSeq(siteSeq);  
   		paramVO.setMenuSeq(cmntMenuService.selectCmntMenuSeq());
   		cmntMenuAuthVO.setMenuSeq(paramVO.getMenuSeq());
   		cmntMenuAuthVO.setSiteSeq(siteSeq);
   		int menuCnt = 0;
   		menuCnt = cmntMenuService.selectCmntMenuTotCnt(paramVO);
   		if(menuCnt <7){
   			
	   		ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
	   		moduleBbsVO.setBbsNm(paramVO.getMenuNm());
	   		moduleBbsVO.setBbsDc(paramVO.getMenuNm());
	   		moduleBbsVO.setListScrinCode(paramVO.getListScrinCode());
	   		moduleBbsVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
	   		moduleBbsVO.setCmntUseAt("Y");
	   		moduleBbsVO.setAtchFilePosblAt(paramVO.getAtchFilePosblAt());
	   		moduleBbsVO.setAtchFilePosblCo(paramVO.getAtchFilePosblCo());
	   		moduleBbsVO.setListNumCode("P");
	   		moduleBbsVO.setExpsrAt("N,W,R,I");
	   	String bbs_seq =bbsUnityBassInfoService.registBbsBassInfoInit(moduleBbsVO);
	   	paramVO.setBbsSeq(bbs_seq);
	   	paramVO.setMenuOrdr(String.valueOf(menuCnt+1));
	   	paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
   		cmntMenuService.registCmntMenu(paramVO);
	   		if(cmntMenuAuthVO.getAuthSeAppC() !=null && cmntMenuAuthVO.getAuthSeAppC().equals("Y")){
	   		cmntMenuAuthVO.setApprvlCode("SC00000339");
	   		cmntMenuAuthVO.setAuthSe("C");
	   		cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO);
	   		}
	   		if(cmntMenuAuthVO.getAuthSeAppR() !=null && cmntMenuAuthVO.getAuthSeAppR().equals("Y")){
	   		cmntMenuAuthVO.setApprvlCode("SC00000339");
	   		cmntMenuAuthVO.setAuthSe("R");
	   		cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO);
	   		}
	   		if(cmntMenuAuthVO.getAuthSeAppW() !=null && cmntMenuAuthVO.getAuthSeAppW().equals("Y")){
	   		cmntMenuAuthVO.setApprvlCode("SC00000339");
	   		cmntMenuAuthVO.setAuthSe("W");
	   		cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO);
	   		}
	   		if(cmntMenuAuthVO.getAuthSeNappC() !=null && cmntMenuAuthVO.getAuthSeNappC().equals("Y")){
	   		cmntMenuAuthVO.setApprvlCode("SC00000340");
	   		cmntMenuAuthVO.setAuthSe("C");
	   		cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO);
	   		}
	   		if(cmntMenuAuthVO.getAuthSeNappR() !=null && cmntMenuAuthVO.getAuthSeNappR().equals("Y")){
	   		cmntMenuAuthVO.setApprvlCode("SC00000340");
	   		cmntMenuAuthVO.setAuthSe("R");
	   		cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO);
	   		}
	   		if(cmntMenuAuthVO.getAuthSeNappW() !=null && cmntMenuAuthVO.getAuthSeNappW().equals("Y")){
	   		cmntMenuAuthVO.setApprvlCode("SC00000340");
	   		cmntMenuAuthVO.setAuthSe("W");
	   		cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO);
	   		}	
   		}	
   		model.addObject("menuCnt", menuCnt);
   		return model;
   	}
	
	@RequestMapping(value= {"/module/cmnt/mngr/registCmntMeunFormAjax.do","/{siteKey}/module/cmnt/mngr/registCmntMeunFormAjax.do"})
	public String registCmntMeunFormAjax(
			@ModelAttribute("paramVO") CmntMenuVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		/** 사이트 시퀀스 입력 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq); 
		return "wzwg/module/cmnt/cmntMngrMenu";
	}
	
	@RequestMapping(value= {"/module/cmnt/setCmntMenuSeqAjax.do","/{siteKey}/module/cmnt/setCmntMenuSeqAjax.do"})
   	public ModelAndView setCmntMenuSeqAjax (
   			@ModelAttribute("paramVO")CmntMenuVO paramVO
   			,@ModelAttribute("cmntMenuAuthVO") CmntMenuAuthVO cmntMenuAuthVO
   			, HttpServletRequest request
   			, HttpSession session
   			, HttpServletResponse response
   			) throws Exception {
   			ModelAndView model = new ModelAndView();
   	    	model.setViewName("jsonView"); 
//   		 if(session.getAttribute("cmntMenuSeq")!=null){
//   			 session.removeAttribute("cmntMenuSeq");
//   		 }
   	    	
   	    	
//   		 session.setAttribute("cmntMenuseq", value);
   	    	if(session.getAttribute("cmntAuthC") != null){
    			session.removeAttribute("cmntAuthC");
    		}
    		if(session.getAttribute("cmntAuthR") != null){
    			session.removeAttribute("cmntAuthR");
    		}
    		if(session.getAttribute("cmntAuthW") != null){
    			session.removeAttribute("cmntAuthW");
    		}
    		
   	 		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
   	    	CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
   	    	CmntUserVO cmntUserVO = new CmntUserVO();
   			CmntUserVO cmntUser = new CmntUserVO();
   			String cmntSeq = paramVO.getCmntSeq();

   			cmntUserVO.setSiteSeq(siteSeq);
   			cmntUserVO.setCmntSeq(cmntSeq);
   			
   			if(cmntSeq != null && !"".equals(cmntSeq) && cmntSeq.matches("^[0-9]+$")) {
   	   			session.setAttribute("cmntSeq", cmntSeq);
   			}
   			if(loginVO == null || loginVO.getUsrSeq() == null){
   	   			cmntUserVO.setUsrSeq("0");
   	   		}else{
   	   		cmntUserVO.setUsrSeq(loginVO.getUsrSeq());
   	   		}
   			
   	    	cmntUser = cmntUserService.selectCmntUser(cmntUserVO);
   	    	if(cmntUser == null){
   	    		if(session.getAttribute("cmntAuthC") != null){
   	    			session.removeAttribute("cmntAuthC");
   	    		}
   	    		if(session.getAttribute("cmntAuthR") != null){
   	    			session.removeAttribute("cmntAuthR");
   	    		}
   	    		if(session.getAttribute("cmntAuthW") != null){
   	    			session.removeAttribute("cmntAuthW");
   	    		}
   	    	}
   	    	cmntMenuAuthVO.setSiteSeq(siteSeq);
   	    	
   	    	if(cmntUser != null){
   	    		cmntMenuAuthVO.setApprvlCode(cmntUser.getApprvlCode());
   	    	}
   	    	
   	    	List<CmntMenuAuthVO> cmntMenuAuthList=	cmntMenuAuthService.selectCmntMenuAuthDetail(cmntMenuAuthVO);
   	    	if(cmntMenuAuthList !=null){
	   	    	for(int i =0;i<cmntMenuAuthList.size();i++){
	   	    		CmntMenuAuthVO  cmntMenuAuth = cmntMenuAuthList.get(i);
	   	    		if(cmntMenuAuth.getAuthSe().equals("C")){
	   	    			session.setAttribute("cmntAuthC", "Y");
	   	    		}
	   	    		
	   	    		if(cmntMenuAuth.getAuthSe().equals("R")){
	   	    			session.setAttribute("cmntAuthR", "Y");
	   	    		}
	   	    		
	   	    		if(cmntMenuAuth.getAuthSe().equals("W")){
	   	    			session.setAttribute("cmntAuthW", "Y");
	   	    		}
	   	    	}
   	    	}else{
   	    		if(session.getAttribute("cmntAuthC") != null){
   	    			session.removeAttribute("cmntAuthC");
   	    		}
   	    		if(session.getAttribute("cmntAuthR") != null){
   	    			session.removeAttribute("cmntAuthR");
   	    		}
   	    		if(session.getAttribute("cmntAuthW") != null){
   	    			session.removeAttribute("cmntAuthW");
   	    		}
   	    	}
   		return model;
   	}
	
	@RequestMapping(value= {"/module/cmnt/mngr/modifyCmntMeunOrdAjax.do","/{siteKey}/module/cmnt/mngr/modifyCmntMeunOrdAjax.do"})
	public ModelAndView modifyCmntMeunOrdAjax(
			@ModelAttribute("paramVO") CmntMenuVO paramVO
			,@ModelAttribute("cmntMenuAuthVO") CmntMenuAuthVO cmntMenuAuthVO
			, String selectMnSeq
			, String targetMnSeq
			, String selectMnOrd
			, String targetMnOrd
			, HttpServletRequest request 
   			, HttpServletResponse response
   			) throws Exception {
   			ModelAndView model = new ModelAndView();
   	    	model.setViewName("jsonView"); 
		
   	    	String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
   			//paramVO.setSiteSeq(siteSeq); 
   			
   	    	CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
   	    	
   			CmntMenuVO selectMenuVO = new CmntMenuVO();
   			selectMenuVO.setMenuOrdr(targetMnOrd); // 선택된 순번과 타겟의 순번을 바꿔서 넣어 준다
   			selectMenuVO.setMenuSeq(selectMnSeq);
   			selectMenuVO.setSiteSeq(siteSeq); 
   			selectMenuVO.setCmntSeq(paramVO.getCmntSeq());
   			selectMenuVO.setLastUpdusrId(loginVO.getUserId());
   			
   			CmntMenuVO targetMenuVO = new CmntMenuVO();
   			targetMenuVO.setMenuOrdr(selectMnOrd); // 선택된 순번과 타겟의 순번을 바꿔서 넣어 준다
   			targetMenuVO.setMenuSeq(targetMnSeq);
   			targetMenuVO.setSiteSeq(siteSeq); 
   			targetMenuVO.setCmntSeq(paramVO.getCmntSeq());
   			targetMenuVO.setLastUpdusrId(loginVO.getUserId());
   			
   			cmntMenuService.modifyCmntMenuOrd(selectMenuVO);
   			cmntMenuService.modifyCmntMenuOrd(targetMenuVO);
   			
   			model.addObject("result", "success");
		return model;
	}
	
	@RequestMapping(value= {"/module/cmnt/mngr/deleteCmntMeunAjax.do","/{siteKey}/module/cmnt/mngr/deleteCmntMeunAjax.do"})
	public ModelAndView deleteCmntMeunAjax(
			@ModelAttribute("paramVO") CmntMenuVO paramVO
			,@ModelAttribute("cmntMenuAuthVO") CmntMenuAuthVO cmntMenuAuthVO
			, HttpServletRequest request 
			, HttpServletResponse response
			) throws Exception {
		ModelAndView model = new ModelAndView();
		model.setViewName("jsonView"); 
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		//paramVO.setSiteSeq(siteSeq); 
		
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		
		paramVO.setSiteSeq(siteSeq);
		paramVO.setLastUpdusrId(loginVO.getUserId());
		
		cmntMenuService.deleteCmntMenu(paramVO);
		
		model.addObject("result", "success");
		return model;
	}
	
}
