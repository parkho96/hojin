package egovframework.wzwg.sysMngr.siteMngr.bbsDataMngr.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsCmmnService;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.bbsDataMngr.service.BbsDataMngrService;
import egovframework.wzwg.sysMngr.siteMngr.bbsDataMngr.service.BbsDataMngrVO;
import egovframework.wzwg.sysMngr.siteMngr.siteGroup.service.SiteGroupService;
import egovframework.wzwg.sysMngr.siteMngr.siteGroup.service.SiteGroupVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoVO;

@Controller
public class BbsDataMngrController {

    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
    
	@Resource(name="SysMngrSiteInfoService")
	private SysMngrSiteInfoService siteInfoService;  
	
    @Resource(name="ModuleBbsCmmnService")
    protected ModuleBbsCmmnService bbsCmmnService;	
    
    @Resource(name="BbsDataMngrService")
    protected BbsDataMngrService bbsDataMngrService;
    
    @Resource(name="SiteGroupService")
    private SiteGroupService siteGroupService;    

	/**
	 * 시스템 - 데이터정리 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/siteMngr/bbsDataMngr/selectBbsDataForm.do","/{siteKey}/**/siteMngr/bbsDataMngr/selectBbsDataForm.do"})
	public String selectBbsDataForm(@ModelAttribute("paramVO") BbsDataMngrVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		
		SysMngrSiteInfoVO sysMngrSiteInfoVO = new SysMngrSiteInfoVO();
		boolean sysMngrAt = CmmSessionUtil.getSessionSysMngrAt(request);
		if(sysMngrAt != true){
			/** 사이트 시퀀스 */
			String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
			paramVO.setSiteSeq(siteSeq);
			
			sysMngrSiteInfoVO.setSiteSeq(siteSeq);
			SysMngrSiteInfoVO siteInfoDetail = siteInfoService.selectSiteInfoDetail(sysMngrSiteInfoVO);
			
			model.addAttribute("siteInfoDetail",siteInfoDetail);
			
		}else{
			
	        SiteGroupVO siteGroupVO = new SiteGroupVO();
	        siteGroupVO.setOdr("1");
	        List<SiteGroupVO> siteLclasGroupList = siteGroupService.selectSiteGroupAjax(siteGroupVO);
	        model.addAttribute("siteLclasGroupList", siteLclasGroupList);
		}		
	
		return "wzwg/sysMngr/siteMngr/bbsDataMngr/bbsDataForm";
	}
	
	/**
	 * 시스템 - 데이터정리 게시판 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/bbsDataMngr/selectBbsListAjax.do")
	public String selectBbsListAjax(@ModelAttribute("paramVO") BbsDataMngrVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{

			List<CntntsInfoVO> bbsList = bbsCmmnService.selectBbsList(paramVO.getSiteSeq());
			
			model.addAttribute("bbsList", bbsList);

		return "wzwg/sysMngr/siteMngr/bbsDataMngr/bbsList";
	}	
	
	/**
	 * 사이트 - 작업공지여부 확인
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/bbsDataMngr/selectSiteOpertNtcAtAjax.do")
	public ModelAndView selectSiteOpertNtcAtAjax(@ModelAttribute("paramVO") BbsDataMngrVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		
		boolean sysMngrAt = CmmSessionUtil.getSessionSysMngrAt(request);
		
		int resultCnt = 0;
		
		if(sysMngrAt != true){

			String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
			paramVO.setSiteSeq(siteSeq);
			
			if(siteSeq != null && !siteSeq.equals("")) {
				resultCnt = bbsDataMngrService.selectSiteOpertNtcCnt(paramVO);
			}
		}

		if(resultCnt > 0) {
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * 시스템 - 작업공지여부 확인
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/bbsDataMngr/selectSysOpertNtcAtAjax.do")
	public ModelAndView selectSysOpertNtcAtAjax(@ModelAttribute("paramVO") BbsDataMngrVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		
		boolean sysMngrAt = CmmSessionUtil.getSessionSysMngrAt(request);
		
		int resultCnt = 0;
		
		if(sysMngrAt == true){

			if(paramVO.getOpertClSe() != null && !paramVO.getOpertClSe().equals("")) {
				resultCnt = bbsDataMngrService.selectSysOpertNtcCnt(paramVO);
			}
		}

		if(resultCnt > 0) {
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}	
	
	/**
	 * 시스템 - 데이터정리 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/bbsDataMngr/deleteBbsData.do")
	public ModelAndView deleteBbsData(@ModelAttribute("paramVO") BbsDataMngrVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		
			int resultValue = 0;

			boolean sysMngrAt = CmmSessionUtil.getSessionSysMngrAt(request);
			if(sysMngrAt != true){			

				String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
				paramVO.setSiteSeq(siteSeq);
				
				if(siteSeq != null && !siteSeq.equals("")) {				
					resultValue = bbsDataMngrService.deleteSiteNtt(paramVO);
				}
			
			} else {

				if(paramVO.getOpertClSe() != null && !paramVO.getOpertClSe().equals("")) {
					resultValue = bbsDataMngrService.deleteSysNtt(paramVO);
				}
				
			}

			if(resultValue > 0) {
				return CmmAjaxUtil.getAjaxReturn("success");
			}else{
				return CmmAjaxUtil.getAjaxReturn("fail");
			}
	}	
	
	

	
	
	
}
