package egovframework.wzwg.site.mngr.menu.web;

import java.sql.SQLException;
import java.util.IllegalFormatException;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.Globals;
import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.cmm.util.ajax.AjaxXmlView;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;
import egovframework.wzwg.module.bbs.faq.service.ModuleBbsFaqBassInfoService;
import egovframework.wzwg.module.bbs.image.service.ModuleBbsImageBassInfoService;
import egovframework.wzwg.module.bbs.link.service.ModuleBbsLinkBassInfoService;
import egovframework.wzwg.module.bbs.mvp.service.ModuleBbsMvpBassInfoService;
import egovframework.wzwg.module.bbs.qna.service.ModuleBbsQnaBassInfoService;
import egovframework.wzwg.module.bbs.simp.service.ModuleBbsSimpBassInfoService;
import egovframework.wzwg.module.bbs.unity.service.ModuleBbsUnityBassInfoService;
import egovframework.wzwg.module.cntnts.service.ModuleCntntsBassInfoService;
import egovframework.wzwg.module.cntnts.service.ModuleCntntsCnService;
import egovframework.wzwg.module.cntnts.service.ModuleCntntsVO;
import egovframework.wzwg.module.map.service.ModuleMapBassInfoService;
import egovframework.wzwg.module.map.service.ModuleMapVO;
import egovframework.wzwg.module.onlineReqst.mngr.service.MngrOnlineReqstInfoService;
import egovframework.wzwg.module.onlineReqst.mngr.service.MngrOnlineReqstInfoVO;
import egovframework.wzwg.module.schdul.service.ModuleSchdulBassInfoService;
import egovframework.wzwg.module.schdul.service.ModuleSchdulBassInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthService;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoService;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuService;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuVO;
import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupService;
import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupVO;
import egovframework.wzwg.sysMngr.cntntsMngr.cntntsTmplat.service.CntntsTmplatService;
import egovframework.wzwg.sysMngr.cntntsMngr.cntntsTmplat.service.CntntsTmplatVO;
import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.SysModuleInfoService;
import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.SysModuleInfoVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import net.sourceforge.ajaxtags.xml.AjaxXmlBuilder;

@Controller
@Slf4j
public class SiteMenuController {
	
	@Resource(name="SiteMenuService")
	private SiteMenuService siteMenuService;
	
	@Resource(name="CntntsInfoService")
	private CntntsInfoService cntntsInfoService;
	
	@Resource(name="SysModuleInfoService")
	private SysModuleInfoService sysModuleInfoService;
	
	@Resource(name="CntntsAuthService")
	private CntntsAuthService cntntsAuthService;

	@Resource(name="SiteUsrGroupService")
	private SiteUsrGroupService siteUsrGroupService;
	
    @Resource(name="ModuleBbsUnityBassInfoService")
	private ModuleBbsUnityBassInfoService bbsUnityBassInfoService;
    
    @Resource(name="ModuleBbsImageBassInfoService")
    protected ModuleBbsImageBassInfoService bbsImageBassInfoService;

	@Resource(name="ModuleBbsMvpBassInfoService")
	protected ModuleBbsMvpBassInfoService bbsMvpBassInfoService;
	
    @Resource(name="ModuleBbsQnaBassInfoService")
    protected ModuleBbsQnaBassInfoService bbsQnaBassInfoService;
    
    @Resource(name="ModuleBbsLinkBassInfoService")
    protected ModuleBbsLinkBassInfoService bbsLinkBassInfoService;
    
    @Resource(name="ModuleBbsFaqBassInfoService")
    protected ModuleBbsFaqBassInfoService bbsFaqBassInfoService;
    
	@Resource(name="MngrOnlineReqstInfoService")
	MngrOnlineReqstInfoService mngrOnlineReqstInfoService;

	@Resource(name="ModuleCntntsBassInfoService")
	ModuleCntntsBassInfoService moduleCntntsBassInfoService;
	
	@Resource(name="ModuleMapBassInfoService")
	ModuleMapBassInfoService moduleMapBassInfoService;

	@Resource(name="ModuleCntntsCnService")
	ModuleCntntsCnService moduleCntntsCnService;
	
	@Resource(name="CntntsTmplatService")
	CntntsTmplatService cntntsTmplatService;
	
	@Resource(name="ModuleBbsSimpBassInfoService")
	protected ModuleBbsSimpBassInfoService bbsSimpBassInfoService;
	
	@Resource(name="ModuleSchdulBassInfoService")
	private ModuleSchdulBassInfoService schdulService;
	
	/**
	 * 사이트 메뉴 정보 조회
	 * @param siteMenuVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/menu/selectSiteMenuMngrList.do","/{siteKey}/mngr/menu/selectSiteMenuMngrList.do"})
	public String selectSiteMenuMngrList(
		@ModelAttribute("paramVO")SiteMenuVO siteMenuVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteMenuVO.setSiteSeq(siteSeq);
		
		
		return "wzwg/site/mngr/menu/siteMenuList";
	}
	
	@RequestMapping(value= {"/mngr/menu/selectSiteMenuMngrListAjax.do","/{siteKey}/mngr/menu/selectSiteMenuMngrListAjax.do"})
	public String selectSiteMenuMngrListAjax(
		@ModelAttribute("paramVO")SiteMenuVO siteMenuVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteMenuVO.setSiteSeq(siteSeq);
		
		Map<String, Object> siteMenuList = siteMenuService.selectSiteMenuMngrList(siteMenuVO);
		
		model.addAttribute("resultList", siteMenuList);
		
		return "wzwg/site/mngr/menu/siteMenuListAjax";
	}
	
	
	@RequestMapping(value= {"/mngr/menu/registSiteMenuMngrFrmAjax.do","/{siteKey}/mngr/menu/registSiteMenuMngrFrmAjax.do"})
	public String registSiteMenuMngrAjax(
		@ModelAttribute("paramVO")SiteMenuVO siteMenuVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteMenuVO.setSiteSeq(siteSeq);
		
		Map<String, Object> siteMenuList = siteMenuService.registSiteMenuMngrInfo(siteMenuVO);
		
		model.addAttribute("resultList", siteMenuList);
		
		return "wzwg/site/mngr/menu/siteMenuRegistAjaxFrm";
	}
	

	@RequestMapping(value= {"/mngr/menu/modifySiteMenuMngrFrmAjax.do","/{stieKey}/mngr/menu/modifySiteMenuMngrFrmAjax.do"})
	public String modifySiteMenuMngrAjax(
		@ModelAttribute("paramVO")SiteMenuVO siteMenuVO
		, HttpServletRequest request
		, Model model ) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteMenuVO.setSiteSeq(siteSeq);
		
		Map<String, Object> siteMenuList = siteMenuService.registSiteMenuMngrInfo(siteMenuVO);
		model.addAttribute("subMenuCnt", siteMenuService.selectSubMenuCnt(siteMenuVO));
		model.addAttribute("resultList", siteMenuList);
		model.addAttribute("resultVO", siteMenuService.selectSiteMenu(siteMenuVO));
		
		return "wzwg/site/mngr/menu/siteMenuModifyAjaxFrm";
	}
	
	@RequestMapping(value= {"/mngr/menu/siteMenuCntntListAjax.do","/{siteKey}/mngr/menu/siteMenuCntntListAjax.do"})
	public   String siteMenuCntntList(
			@ModelAttribute("paramVO")SiteMenuVO siteMenuVO
			, HttpServletRequest request
			, HttpServletResponse response
			, Model model ) throws Exception {
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteMenuVO.setSiteSeq(siteSeq);
		model.addAttribute("menuCntntList", siteMenuService.selectSiteMenuCntntList(siteMenuVO));
		
		return "wzwg/site/mngr/menu/siteMenuCntntList";
	}

	
	
	/**
	 * 사이트 메뉴 등록
	 * @param siteMenuVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value= {"/mngr/menu/registSiteMenuMngrAjax.do","/{siteKey}/mngr/menu/registSiteMenuMngrAjax.do"})
	public  ModelAndView registSiteMenuMngr(
			HttpServletRequest request
			, @ModelAttribute("paramVO")SiteMenuVO siteMenuVO
			, SysModuleInfoVO paramVO
			, HttpServletResponse response
			, Model model ) throws Exception {
		ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
		AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		siteMenuVO.setUserId(loginVO.getUserId());
		String menuLv ="1";
		siteMenuVO.setSiteSeq(siteSeq);
		int menuOrdrInt = 1;
		siteMenuVO.setMenuSeq(siteMenuService.seletSiteMenuSeq());
		if(siteMenuService.selectMaxMenuOrdr(siteMenuVO) !=null){
		 menuOrdrInt = siteMenuService.selectMaxMenuOrdr(siteMenuVO)+1;
		}
		SiteMenuVO upperVO  = new SiteMenuVO();
		if(siteMenuVO.getUpperMenuSeq() != null && !"".equals(siteMenuVO.getUpperMenuSeq())){
			SiteMenuVO siteUpperMenuVO  = new SiteMenuVO();
			siteUpperMenuVO.setMenuSeq(siteMenuVO.getUpperMenuSeq());
			siteUpperMenuVO.setSiteSeq(siteSeq);
			upperVO =siteMenuService.selectSiteMenu(siteUpperMenuVO);
			menuLv = String.valueOf((Integer.parseInt(upperVO.getMenuLv())+1));
		//	menuOrdrInt = Integer.parseInt(upperVO.getMenuOrdr())+1;
			if((Integer.parseInt(upperVO.getMenuLv())+1) >3){
				ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "maxMenuLv").toString());
				return ajaxModel;
			}
			
			if(siteMenuVO.getSysmoduleSeq() == null || siteMenuVO.getSysmoduleSeq().trim().isEmpty() && siteMenuVO.getMenuTyCode().trim().isEmpty() || siteMenuVO.getMenuTyCode() == null) {
				if((Integer.parseInt(upperVO.getMenuLv())+1) >2){
					ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "maxGroupLv").toString());
					return ajaxModel;
				}
			}
		//	siteMenuService.modifySiteMenuPlusOrdr(upperVO);
		}else{
			siteMenuVO.setUpperMenuSeq("0");
		}

		siteMenuVO.setMenuLv(menuLv);
		siteMenuVO.setMenuOrdr(String.valueOf(menuOrdrInt));

		String menuTyCode = siteMenuVO.getMenuTyCode();
	    String sysmoduleSeq = siteMenuVO.getSysmoduleSeq();
	    
		if("SC00000033".equals(menuTyCode)){
			siteMenuVO.setMenuLinkUrl(sysModuleInfoService.selectSysModuleInfoDetail(paramVO).getUsrPageUrl());
		}
		if("link".equals(sysmoduleSeq)){
			siteMenuVO.setSysmoduleSeq("");
		}
		if("888888888888".equals(sysmoduleSeq)){
			siteMenuVO.setMenuLinkUrl("/index.do#.anc_"+siteMenuVO.getMenuSeq());
		}
		
		if("bass".equals(siteMenuVO.getSitecntntsSeq())) {
			if("10000000003".equals(siteMenuVO.getSysmoduleSeq())){ //일반게시판
				ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
		   		moduleBbsVO.setBbsNm(siteMenuVO.getMenuNm());
		   		moduleBbsVO.setBbsDc(siteMenuVO.getMenuNm());
		   		moduleBbsVO.setListScrinCode("L");
		   		moduleBbsVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
		   		/*서브사이트 첨부파일 3개로 고정 20.07.02 dhkang*/
		   		moduleBbsVO.setAtchFilePosblAt("Y");
		   		moduleBbsVO.setAtchFilePosblCo("3");
		   		/*서브사이트 글번호 노출 페이지번호로 고정 20.07.09 dhkang*/
		   		moduleBbsVO.setListNumCode("P");
		   		moduleBbsVO.setExpsrAt("N,W,R,I");
		  
		   		String bbs_seq =bbsUnityBassInfoService.registBbsBassInfoInit(moduleBbsVO);
		   	
		   	
		   		CntntsInfoVO cntntsInfoVO = new CntntsInfoVO();

		   		cntntsInfoVO.setModuleTyCode(siteMenuVO.getModuleTyCode());
		        cntntsInfoVO.setSysmoduleSeq(siteMenuVO.getSysmoduleSeq());
		        cntntsInfoVO.setCntntsSeq(bbs_seq); 
		        cntntsInfoVO.setCntntsNm(siteMenuVO.getMenuNm());
		        cntntsInfoVO.setCntntsDc(siteMenuVO.getMenuNm());
		        cntntsInfoVO.setFrstRegisterId(loginVO.getUserId());
		        cntntsInfoVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		        
		        String sitecntntsSeq = cntntsInfoService.registCntntsInfoDefaultAuthInit(cntntsInfoVO);    // 저장
		       
		        siteMenuVO.setSitecntntsSeq(sitecntntsSeq);
			}
			
			if(siteMenuVO.getSysmoduleSeq() != null  && "10000000210".equals(siteMenuVO.getSysmoduleSeq())){  //온라인신청
				MngrOnlineReqstInfoVO mngrOnlineReqstInfoVO = new MngrOnlineReqstInfoVO();
				mngrOnlineReqstInfoVO.setReqstNm(siteMenuVO.getMenuNm());
				mngrOnlineReqstInfoVO.setReqstDc(siteMenuVO.getMenuNm());
				mngrOnlineReqstInfoVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId()); 
		
				String reqSeq =mngrOnlineReqstInfoService.registOnlineReqstInfoReturn(mngrOnlineReqstInfoVO);
		   	
				CntntsInfoVO cntntsInfoVO = new CntntsInfoVO();

		   		cntntsInfoVO.setModuleTyCode(siteMenuVO.getModuleTyCode());
		        cntntsInfoVO.setSysmoduleSeq(siteMenuVO.getSysmoduleSeq());
		        cntntsInfoVO.setCntntsSeq(reqSeq); 
		        cntntsInfoVO.setCntntsNm(siteMenuVO.getMenuNm());
		        cntntsInfoVO.setCntntsDc(siteMenuVO.getMenuNm());
		        cntntsInfoVO.setFrstRegisterId(loginVO.getUserId());
		        cntntsInfoVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		        
		        String sitecntntsSeq = cntntsInfoService.registCntntsInfoDefaultAuthInit(cntntsInfoVO);    // 저장
		       
		        siteMenuVO.setSitecntntsSeq(sitecntntsSeq);
			}
			
			if( siteMenuVO.getSysmoduleSeq() != null  && "10000000213".equals(siteMenuVO.getSysmoduleSeq())){  //지도
				ModuleMapVO moduleMapVO = new ModuleMapVO();
				moduleMapVO.setMapNm(siteMenuVO.getMenuNm());
				
				String temlatMapSeq = EgovProperties.getProperty("Globals.base.mapTemplatSeq");
				moduleMapVO.setTmplatSeq(temlatMapSeq);
		   	
				String mapSeq =moduleMapBassInfoService.registMapinfoBassInfoInit(moduleMapVO);
		   	
				CntntsInfoVO cntntsInfoVO = new CntntsInfoVO();

		   		cntntsInfoVO.setModuleTyCode(siteMenuVO.getModuleTyCode());
		        cntntsInfoVO.setSysmoduleSeq(siteMenuVO.getSysmoduleSeq());
		        cntntsInfoVO.setCntntsSeq(mapSeq); 
		        cntntsInfoVO.setCntntsNm(siteMenuVO.getMenuNm());
		        cntntsInfoVO.setCntntsDc(siteMenuVO.getMenuNm());
		        cntntsInfoVO.setFrstRegisterId(loginVO.getUserId());
		        cntntsInfoVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		        
		        String sitecntntsSeq = cntntsInfoService.registCntntsInfoDefaultAuthInit(cntntsInfoVO);    // 저장
		       
		        siteMenuVO.setSitecntntsSeq(sitecntntsSeq);
			}
			
			if(siteMenuVO.getSysmoduleSeq() != null  && "10000000101".equals(siteMenuVO.getSysmoduleSeq())){ //질의응답게시판
				ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
		   		moduleBbsVO.setBbsNm(siteMenuVO.getMenuNm());
		   		moduleBbsVO.setBbsDc(siteMenuVO.getMenuNm());
		   		moduleBbsVO.setListScrinCode("L");
		   		moduleBbsVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
		   		/*서브사이트 첨부파일 3개로 고정 20.07.02 dhkang*/
		   		moduleBbsVO.setAtchFilePosblAt("Y");
		   		moduleBbsVO.setAtchFilePosblCo("3");
		   		/*서브사이트 글번호 노출 페이지번호로 고정 20.07.09 dhkang*/
		   		moduleBbsVO.setListNumCode("P");
		   		moduleBbsVO.setExpsrAt("N,W,R,I");
		   		
		   		String bbs_seq =bbsQnaBassInfoService.registBbsBassInfoInit(moduleBbsVO);
		   	
		   		CntntsInfoVO cntntsInfoVO = new CntntsInfoVO();

		   		cntntsInfoVO.setModuleTyCode(siteMenuVO.getModuleTyCode());
		        cntntsInfoVO.setSysmoduleSeq(siteMenuVO.getSysmoduleSeq());
		        cntntsInfoVO.setCntntsSeq(bbs_seq); 
		        cntntsInfoVO.setCntntsNm(siteMenuVO.getMenuNm());
		        cntntsInfoVO.setCntntsDc(siteMenuVO.getMenuNm());
		        cntntsInfoVO.setFrstRegisterId(loginVO.getUserId());
		        cntntsInfoVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		        
		        String sitecntntsSeq = cntntsInfoService.registCntntsInfoDefaultAuthInit(cntntsInfoVO);    // 저장
		       
		        siteMenuVO.setSitecntntsSeq(sitecntntsSeq);
			}
			
			if(siteMenuVO.getSysmoduleSeq() != null  && "10000000104".equals(siteMenuVO.getSysmoduleSeq())){ //일정
				ModuleSchdulBassInfoVO schdulBassInfoVO = new ModuleSchdulBassInfoVO();
	   			String newSchdulSeq = schdulService.selectSchdulNextSeq();
	   			schdulBassInfoVO.setSchdulSeq(newSchdulSeq);
	   			schdulBassInfoVO.setSchdulSkll("A");
	   			schdulBassInfoVO.setSchdulNm(siteMenuVO.getMenuNm());
	   			schdulBassInfoVO.setSchdulDc(siteMenuVO.getMenuNm());
	   			schdulBassInfoVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
	   			int i = schdulService.registSchdulBassInfo(schdulBassInfoVO);
		   	
	   			CntntsInfoVO cntntsInfoVO = new CntntsInfoVO();

		   		cntntsInfoVO.setModuleTyCode(siteMenuVO.getModuleTyCode());
		        cntntsInfoVO.setSysmoduleSeq(siteMenuVO.getSysmoduleSeq());
		        cntntsInfoVO.setCntntsSeq(newSchdulSeq); 
		        cntntsInfoVO.setCntntsNm(siteMenuVO.getMenuNm());
		        cntntsInfoVO.setCntntsDc(siteMenuVO.getMenuNm());
		        cntntsInfoVO.setFrstRegisterId(loginVO.getUserId());
		        cntntsInfoVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		        
		        String sitecntntsSeq = cntntsInfoService.registCntntsInfoDefaultAuthInit(cntntsInfoVO);    // 저장
		       
		        siteMenuVO.setSitecntntsSeq(sitecntntsSeq);
			}
			
			if(siteMenuVO.getSysmoduleSeq() != null  && "10000000218".equals(siteMenuVO.getSysmoduleSeq())){ //링크게시판
				ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
		   		moduleBbsVO.setBbsNm(siteMenuVO.getMenuNm());
		   		moduleBbsVO.setBbsDc(siteMenuVO.getMenuNm());
		   		moduleBbsVO.setListScrinCode("L");
		   		moduleBbsVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
		   		/*서브사이트 첨부파일 3개로 고정 20.07.02 dhkang*/
		   		moduleBbsVO.setAtchFilePosblAt("Y");
		   		moduleBbsVO.setAtchFilePosblCo("3");
		   		/*서브사이트 글번호 노출 페이지번호로 고정 20.07.09 dhkang*/
		   		moduleBbsVO.setListNumCode("P");
		   		moduleBbsVO.setExpsrAt("N,W,R,I");
		   		
		   		String bbs_seq =bbsLinkBassInfoService.registBbsBassInfoInit(moduleBbsVO);
		   	
		   		CntntsInfoVO cntntsInfoVO = new CntntsInfoVO();

		   		cntntsInfoVO.setModuleTyCode(siteMenuVO.getModuleTyCode());
		        cntntsInfoVO.setSysmoduleSeq(siteMenuVO.getSysmoduleSeq());
		        cntntsInfoVO.setCntntsSeq(bbs_seq); 
		        cntntsInfoVO.setCntntsNm(siteMenuVO.getMenuNm());
		        cntntsInfoVO.setCntntsDc(siteMenuVO.getMenuNm());
		        cntntsInfoVO.setFrstRegisterId(loginVO.getUserId());
		        cntntsInfoVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		        
		        String sitecntntsSeq = cntntsInfoService.registCntntsInfoDefaultAuthInit(cntntsInfoVO);    // 저장
		       
		   		siteMenuVO.setSitecntntsSeq(sitecntntsSeq);
			}
			
			if(siteMenuVO.getSysmoduleSeq() != null  && "10000000220".equals(siteMenuVO.getSysmoduleSeq())){ //FAQ게시판
				ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
		   		moduleBbsVO.setBbsNm(siteMenuVO.getMenuNm());
		   		moduleBbsVO.setBbsDc(siteMenuVO.getMenuNm());
		   		moduleBbsVO.setListScrinCode("L");
		   		moduleBbsVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
		   		/*서브사이트 첨부파일 3개로 고정 20.07.02 dhkang*/
		   		moduleBbsVO.setAtchFilePosblAt("Y");
		   		moduleBbsVO.setAtchFilePosblCo("3");
		   		/*서브사이트 글번호 노출 페이지번호로 고정 20.07.09 dhkang*/
		   		moduleBbsVO.setListNumCode("P");
		   		moduleBbsVO.setExpsrAt("N,W,R,I");
			 
		   		String bbs_seq =bbsFaqBassInfoService.registBbsBassInfoInit(moduleBbsVO);
			   	
			   	CntntsInfoVO cntntsInfoVO = new CntntsInfoVO();

		   		cntntsInfoVO.setModuleTyCode(siteMenuVO.getModuleTyCode());
		        cntntsInfoVO.setSysmoduleSeq(siteMenuVO.getSysmoduleSeq());
		        cntntsInfoVO.setCntntsSeq(bbs_seq); 
		        cntntsInfoVO.setCntntsNm(siteMenuVO.getMenuNm());
		        cntntsInfoVO.setCntntsDc(siteMenuVO.getMenuNm());
		        cntntsInfoVO.setFrstRegisterId(loginVO.getUserId());
		        cntntsInfoVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		        
		        String sitecntntsSeq = cntntsInfoService.registCntntsInfoDefaultAuthInit(cntntsInfoVO);    // 저장
		       
		        siteMenuVO.setSitecntntsSeq(sitecntntsSeq);
			}
			
			if(siteMenuVO.getSysmoduleSeq() != null  && "10000000204".equals(siteMenuVO.getSysmoduleSeq())){ //동영상게시판
				ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
		   		moduleBbsVO.setBbsNm(siteMenuVO.getMenuNm());
		   		moduleBbsVO.setBbsDc(siteMenuVO.getMenuNm()); 
		   		moduleBbsVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
		   		/*서브사이트 첨부파일 3개로 고정 20.07.02 dhkang*/
		   		moduleBbsVO.setAtchFilePosblAt("Y");
		   		moduleBbsVO.setAtchFilePosblCo("3");
		   		/*서브사이트 글번호 노출 페이지번호로 고정 20.07.09 dhkang*/
		   		moduleBbsVO.setListNumCode("P");
		   		moduleBbsVO.setExpsrAt("N,W,R,I");
		   	
		   		String bbs_seq =bbsMvpBassInfoService.registBbsBassInfoInit(moduleBbsVO);
		   	
		   		CntntsInfoVO cntntsInfoVO = new CntntsInfoVO();
			
		   		cntntsInfoVO.setModuleTyCode(siteMenuVO.getModuleTyCode());
		   		cntntsInfoVO.setSysmoduleSeq(siteMenuVO.getSysmoduleSeq());
		   		cntntsInfoVO.setCntntsSeq(bbs_seq); 
		   		cntntsInfoVO.setCntntsNm(siteMenuVO.getMenuNm());
		   		cntntsInfoVO.setCntntsDc(siteMenuVO.getMenuNm());
		   		cntntsInfoVO.setFrstRegisterId(loginVO.getUserId());
		   		cntntsInfoVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
	        
		   		String sitecntntsSeq = cntntsInfoService.registCntntsInfoDefaultAuthInit(cntntsInfoVO);    // 저장
		   		siteMenuVO.setSitecntntsSeq(sitecntntsSeq);
			}
			
			String temlatSeq = EgovProperties.getProperty("Globals.base.cntntsTemplatSeq");
			if(siteMenuVO.getSysmoduleSeq() != null  && "10000000105".equals(siteMenuVO.getSysmoduleSeq())){ //컨텐츠
				ModuleCntntsVO moduleCntntsVO = new ModuleCntntsVO();
				moduleCntntsVO.setCntntsNm(siteMenuVO.getMenuNm()); 
				moduleCntntsVO.setCntntsDc(siteMenuVO.getMenuNm());
				moduleCntntsVO.setTmplatSeq(temlatSeq);
				moduleCntntsVO.setCntntsVer("1");
				moduleCntntsVO.setUserId(CmmSessionUtil.getSessionUserId());
				moduleCntntsVO.setSiteSeq(siteSeq);
		   	
				String cntnts_seq =moduleCntntsBassInfoService.registCntntsBassInfoInit(moduleCntntsVO);
		   	
				CntntsTmplatVO cntntsTmplatVO = new CntntsTmplatVO();	
				cntntsTmplatVO.setTmplatSeq(temlatSeq);
		   	
				CntntsTmplatVO cntnTmplat=   	cntntsTmplatService.selectCntntsTmplatDetail(cntntsTmplatVO);
				moduleCntntsVO.setCntntsCn(cntnTmplat.getTmplatCn()); 
				moduleCntntsVO.setCntntsSeq(cntnts_seq); 
		   	
		   	
				moduleCntntsCnService.registModuleCntntsCnAjax(moduleCntntsVO); 
		   	
				CntntsInfoVO cntntsInfoVO = new CntntsInfoVO();
				cntntsInfoVO.setModuleTyCode(siteMenuVO.getModuleTyCode());
			    cntntsInfoVO.setSysmoduleSeq(siteMenuVO.getSysmoduleSeq());
			    cntntsInfoVO.setCntntsSeq(cntnts_seq); 
			    cntntsInfoVO.setCntntsNm(siteMenuVO.getMenuNm());
			    cntntsInfoVO.setCntntsDc(siteMenuVO.getMenuNm());
			    cntntsInfoVO.setFrstRegisterId(loginVO.getUserId());
			    cntntsInfoVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
			        
			    String sitecntntsSeq = cntntsInfoService.registCntntsInfoDefaultAuthInit(cntntsInfoVO);    // 저장
			    siteMenuVO.setSitecntntsSeq(sitecntntsSeq);
			}
			
			if(siteMenuVO.getSysmoduleSeq() != null  && "10000000237".equals(siteMenuVO.getSysmoduleSeq())){ //이미지게시판
				ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
		   		moduleBbsVO.setBbsNm(siteMenuVO.getMenuNm());
		   		moduleBbsVO.setBbsDc(siteMenuVO.getMenuNm());
		   		moduleBbsVO.setListScrinCode("I");
		   		moduleBbsVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
		   		/*서브사이트 첨부파일 3개로 고정 20.07.02 dhkang*/
		   		moduleBbsVO.setAtchFilePosblAt("Y");
		   		moduleBbsVO.setAtchFilePosblCo("3");
		   		moduleBbsVO.setAtchImgFilePosblCo("1");
		   		/*서브사이트 글번호 노출 페이지번호로 고정 20.07.09 dhkang*/
		   		moduleBbsVO.setListNumCode("P");
		   		moduleBbsVO.setExpsrAt("N,W,R,I");
		   	
		   		String bbs_seq =bbsImageBassInfoService.registBbsBassInfoInit(moduleBbsVO);
		   	
		   		CntntsInfoVO cntntsInfoVO = new CntntsInfoVO();

		   		cntntsInfoVO.setModuleTyCode(siteMenuVO.getModuleTyCode());
		        cntntsInfoVO.setSysmoduleSeq(siteMenuVO.getSysmoduleSeq());
		        cntntsInfoVO.setCntntsSeq(bbs_seq); 
		        cntntsInfoVO.setCntntsNm(siteMenuVO.getMenuNm());
		        cntntsInfoVO.setCntntsDc(siteMenuVO.getMenuNm());
		        cntntsInfoVO.setFrstRegisterId(loginVO.getUserId());
		        cntntsInfoVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		        
		        String sitecntntsSeq = cntntsInfoService.registCntntsInfoDefaultAuthInit(cntntsInfoVO);    // 저장
		       
		        siteMenuVO.setSitecntntsSeq(sitecntntsSeq);
			}
			
			if(siteMenuVO.getSysmoduleSeq() != null  && "10000000103".equals(siteMenuVO.getSysmoduleSeq())){ //간단게시판
				ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
		   		moduleBbsVO.setBbsNm(siteMenuVO.getMenuNm());
		   		moduleBbsVO.setBbsDc(siteMenuVO.getMenuNm());
		   		moduleBbsVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
		   		
		   		String bbs_seq =bbsSimpBassInfoService.registBbsBassInfoInit(moduleBbsVO);
		   	
		   		CntntsInfoVO cntntsInfoVO = new CntntsInfoVO();

		   		cntntsInfoVO.setModuleTyCode(siteMenuVO.getModuleTyCode());
		        cntntsInfoVO.setSysmoduleSeq(siteMenuVO.getSysmoduleSeq());
		        cntntsInfoVO.setCntntsSeq(bbs_seq); 
		        cntntsInfoVO.setCntntsNm(siteMenuVO.getMenuNm());
		        cntntsInfoVO.setCntntsDc(siteMenuVO.getMenuNm());
		        cntntsInfoVO.setFrstRegisterId(loginVO.getUserId());
		        cntntsInfoVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		        
		        String sitecntntsSeq = cntntsInfoService.registCntntsInfoDefaultAuthInit(cntntsInfoVO);    // 저장
		       
		        siteMenuVO.setSitecntntsSeq(sitecntntsSeq);
			}
		}
		
			
		siteMenuService.registSiteMenu(siteMenuVO);
		ajaxModel.addObject("ajaxXml",xmlBuilder.addItem("result", "success").toString());
		return ajaxModel;
	}
	
	@RequestMapping(value= {"/mngr/menu/modifySiteMenuMngrAjax.do","/{siteKey}/mngr/menu/modifySiteMenuMngrAjax.do"})
	public ModelAndView modifySiteMenuMngr(
			HttpServletRequest request
			, @ModelAttribute("paramVO")SiteMenuVO siteMenuVO
			, SysModuleInfoVO paramVO
			, HttpServletResponse response
			, Model model ) throws Exception {	
		ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
		AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
		try{
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		String menuLv ="1";
		siteMenuVO.setSiteSeq(siteSeq);
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		siteMenuVO.setUserId(loginVO.getUserId());
		int menuOrdrInt =Integer.parseInt(siteMenuVO.getMenuOrdr());
		SiteMenuVO upperVO  = new SiteMenuVO();
		if(siteMenuVO.getUpperMenuSeq() != null && !"".equals(siteMenuVO.getUpperMenuSeq())){
			SiteMenuVO siteUpperMenuVO  = new SiteMenuVO();
			siteUpperMenuVO.setMenuSeq(siteMenuVO.getUpperMenuSeq());
			siteUpperMenuVO.setSiteSeq(siteSeq);
			upperVO =siteMenuService.selectSiteMenu(siteUpperMenuVO);
			menuLv = String.valueOf((Integer.parseInt(upperVO.getMenuLv())+1));
			//menuOrdrInt = Integer.parseInt(upperVO.getMenuOrdr())+1;
			if((Integer.parseInt(upperVO.getMenuLv())+1) >3){
				ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "maxMenuLv").toString());
				return ajaxModel;
			}
			
			if(siteMenuVO.getSysmoduleSeq() == null || siteMenuVO.getSysmoduleSeq().trim().isEmpty() && siteMenuVO.getMenuTyCode().trim().isEmpty() || siteMenuVO.getMenuTyCode() == null) {
				if((Integer.parseInt(upperVO.getMenuLv())+1) >2){
					ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "maxGroupLv").toString());
					return ajaxModel;
				}
			}
			//siteMenuService.modifySiteMenuPlusOrdr(upperVO);
		}
		if(siteMenuVO != null && siteMenuVO.getMenuTyCode() != null) {
			String menuTyCode = siteMenuVO.getMenuTyCode();
		    String sysmoduleSeq = siteMenuVO.getSysmoduleSeq();
		    
		    if ("SC00000033".equals(menuTyCode)) {
				siteMenuVO.setMenuLinkUrl(sysModuleInfoService.selectSysModuleInfoDetail(paramVO).getUsrPageUrl());
			}else if(!"link".equals(menuTyCode) && !"link".equals(sysmoduleSeq)){
				siteMenuVO.setMenuLinkUrl("");
			} 
		    
			if("link".equals(sysmoduleSeq)){
				siteMenuVO.setSysmoduleSeq("");
				siteMenuVO.setSitecntntsSeq("");
				siteMenuVO.setMenuTyCode("");
			}
			if("888888888888".equals(sysmoduleSeq)){
				siteMenuVO.setSitecntntsSeq("");
				siteMenuVO.setMenuTyCode("");
				siteMenuVO.setMenuLinkUrl("/index.do#.anc_"+siteMenuVO.getMenuSeq());
			}
			
			siteMenuVO.setMenuLv(menuLv);
			siteMenuVO.setMenuOrdr(String.valueOf(menuOrdrInt));
			siteMenuService.modifySiteMenu(siteMenuVO);
	   }
		}catch(NullPointerException e){
	       	 log.error("NullPointerException",e);
	   	}catch(NumberFormatException e){
	   		log.error("NumberFormatException",e);
	   	}catch(IllegalFormatException e){
	   		log.error("IllegalFormatException",e);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		log.error("ArrayIndexOutOfBoundsException",e);
	   	}catch(SQLException e){
	   		log.error("ArrayIndexOutOfBoundsException",e);
	   	}
		ajaxModel.addObject("ajaxXml",xmlBuilder.addItem("result", "success").toString());
		return ajaxModel;
	}

	/**
	 * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 전체 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value= {"/mngr/menu/selectCntntsInfoAllListAjax.do","/{siteKey}/mngr/menu/selectCntntsInfoAllListAjax.do"})
	public ModelAndView selectCntntsInfoAllListAjax (
			@ModelAttribute("searchVO")CntntsInfoVO paramVO
			, HttpServletRequest request
			, HttpServletResponse response) throws Exception {
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		
		List<CntntsInfoVO> resultList = cntntsInfoService.selectCntntsInfoAllList(siteSeq);

    	ModelAndView model = new ModelAndView();
    	model.setViewName("jsonView");
        model.addObject("resultList", resultList);
        model.addObject("paramVO", paramVO);
		
		return model;
	}	
	
//	/**
//	 * 사이트 메뉴 등록
//	 * @param siteMenuVO
//	 * @param request
//	 * @param model
//	 * @return
//	 * @throws Exception 
//	 */
	@RequestMapping(value= {"/mngr/menu/modifySiteMenuMngrOrdrAjax.do","/{stieKey}/mngr/menu/modifySiteMenuMngrOrdrAjax.do"})
	public ModelAndView  modifySiteMenuMngrOrdr(
			HttpServletRequest request
			, HttpServletResponse response
			, @ModelAttribute("paramVO")SiteMenuVO siteMenuVO  ) throws Exception {
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteMenuVO.setSiteSeq(siteSeq);
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		siteMenuVO.setUserId(loginVO.getUserId());
		siteMenuService.modifySiteMenuMngrOrdr(siteMenuVO);
		
		ModelAndView model = new ModelAndView();
    	model.setViewName("jsonView"); 
		
		return model;
	}
	
	@RequestMapping(value= {"/mngr/menu/deleteSiteMenuMngrAjax.do","/{siteKey}/mngr/menu/deleteSiteMenuMngrAjax.do"})
	public ModelAndView deleteSiteMenuMngrAjax(
		@ModelAttribute("paramVO")SiteMenuVO siteMenuVO
		, HttpServletRequest request 
		, HttpServletResponse response
		) throws Exception {
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteMenuVO.setSiteSeq(siteSeq);
		siteMenuVO.setUserId(CmmSessionUtil.getSessionUserId());
		
		ModelAndView model = new ModelAndView();
		
		if(siteMenuService.selectSubMenuCnt(siteMenuVO)<1){
			siteMenuService.deleteSiteMenu(siteMenuVO);
			model.addObject("msg","success" );
		}else{
			model.addObject("msg","fail" );	
		}
    	model.setViewName("jsonView"); 
		
		return model;
	}
	
	@RequestMapping(value= {"/mngr/menu/deleteSiteMenuLowAjax.do","/{siteKey}/mngr/menu/deleteSiteMenuLowAjax.do"})
	public ModelAndView deleteSiteMenuLowAjax(
		@ModelAttribute("paramVO")SiteMenuVO siteMenuVO
		, HttpServletRequest request 
		, HttpServletResponse response
		) throws Exception {
		
		String result = "success";
		
		/** 사이트 시퀀스 */
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteMenuVO.setSiteSeq(siteSeq);
		siteMenuVO.setUserId(CmmSessionUtil.getSessionUserId());
		
		try {
		    siteMenuService.deleteSiteMenuLow(siteMenuVO);
		} catch(NullPointerException e){		
			result = "fail";
	   	}catch(NumberFormatException e){	   	 	   		
	   		result = "fail";
	   	}catch(IllegalFormatException e){	   	 
	   		result = "fail";
	   	}catch(ArrayIndexOutOfBoundsException e){	   	 
	   		result = "fail";
	   	}catch(SQLException e){	   	 
	   		result = "fail";
	   	}  
		
		return CmmAjaxUtil.getAjaxReturn(result);
	}
	
	/**
	 * 사이트 메뉴 정보 조회
	 * @param siteMenuVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value={"/mngr/menu/selectSiteMenuByUsrGroup.do","/{siteKey}/mngr/menu/selectSiteMenuByUsrGroup.do"})
	public String selectSiteMenuByUsrGroup(
		@ModelAttribute("paramVO")SiteMenuVO paramVO
		, HttpServletRequest request
		, Model model ) throws Exception {
        
        /** 사이트 시퀀스 */
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        paramVO.setSiteSeq(siteSeq);

        // 그룹 목록
        List<SiteUsrGroupVO> usrGroupList = siteUsrGroupService.selectSiteUsrGroupAllList(siteSeq);
        model.addAttribute("usrGroupList", usrGroupList);
        
        // 메뉴 목록
        List<SiteMenuVO> resultList = siteMenuService.selectSiteMenuList(paramVO);
        model.addAttribute("resultList", resultList);
        
        // 메뉴에 설정된 권한을 조회하기 위한 조건 설정
        String usrgroupSeq = StringUtils.defaultString(paramVO.getSrhUsrGroupSeq());
        if ("".equals(usrgroupSeq)) {
            if (usrGroupList != null && usrGroupList.size() > 0) {
                usrgroupSeq = usrGroupList.get(0).getUsrGroupSeq();
            }
        }
        
        CntntsAuthVO setAuthVO = new CntntsAuthVO();
        setAuthVO.setSiteSeq(siteSeq);
        setAuthVO.setUsrgroupSeq(usrgroupSeq);
        // 검색조건 없을때 기본 회원그룹 셋팅하기 위해 한번 더 넣어줌
        paramVO.setSrhUsrGroupSeq(usrgroupSeq);

        // 기본 회원그룹
        String baseUsrgroupSeq = Globals.BASE_SITE_USRGROUPSEQ;
        String[] baseUsrgroupArr = baseUsrgroupSeq.split(":");
        setAuthVO.setNmbrUsrGroupSeq(baseUsrgroupArr);
        model.addAttribute("baseUsrgroupSeq", baseUsrgroupSeq);
        
        // 해당 회원그룹 설정된 권한 목록
        List<CntntsAuthVO> authList = cntntsAuthService.selectCntntsAuthAllList(setAuthVO);
        model.addAttribute("authList", authList);
        model.addAttribute("paramVO", paramVO);
		
		return "wzwg/site/mngr/menu/siteMenuUsrGroup";
	}
    
    @RequestMapping(value= {"/mngr/menu/registSiteMenuByUsrGroup.do","/{siteKey}/mngr/menu/registSiteMenuByUsrGroup.do"})
    public ModelAndView registSiteMenuByUsrGroup (
        @ModelAttribute("paramVO") CntntsAuthVO paramVO
        , HttpServletRequest request
        , Model model ) throws Exception {
        
        paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        
        int retVal = siteMenuService.registSiteMenuByUsrGroup(paramVO);
        
        return CmmAjaxUtil.getAjaxReturnCmmMap(retVal);
    }
	
	
	/*
	
	*//**
	 * ㅁ 사이트 메뉴 단일모듈 관리자 URL 조회
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 *//*
	
	@RequestMapping(value="/mngr/menu/selectSiteMenuMngrUrlAjax.do")
	public ModelAndView selectSiteMenuMngrUrlAjax(
		@ModelAttribute("paramVO")SiteMenuVO paramVO
		, HttpServletRequest request 
		, HttpServletResponse response
		) throws Exception {
		
		SysModuleInfoVO resultVO = sysModuleInfoService.selectSysModuleInfoDetail(paramVO);
		
		    if(resultVO != null) {
		    	return CmmAjaxUtil.getAjaxReturn(resultVO.getMngrPageUrl());
		    }else {
		    	return CmmAjaxUtil.getAjaxReturn("fail");
		    }
		
		
	}
	
	*/
	
}
