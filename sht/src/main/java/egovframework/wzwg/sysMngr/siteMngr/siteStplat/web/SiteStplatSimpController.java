package egovframework.wzwg.sysMngr.siteMngr.siteStplat.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteEssntlStplatService;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteEssntlStplatVO;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatSimpService;

/**
 * ㅁ 시스템 - 사이트약관상세관리
 * ㅁ DC   
 * - 시스템관리자가 각 사이트 약관상세을 관리
 * - 전체 시스템에서 사용할 약관상세 관리
 * @author HyoJuNiRaNe
 *
 */
@Controller
public class SiteStplatSimpController {
    
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

	@Resource(name="SiteStplatSimpService")
	private SiteStplatSimpService stplatSimpService;
	
	@Resource(name="SiteStplatInfoService")
	private SiteStplatInfoService siteStplatInfoService;
	
	@Resource(name="SysMngrSiteInfoService")
	private SysMngrSiteInfoService siteInfoService;
	
	@Resource(name="SiteEssntlStplatService")
	private SiteEssntlStplatService siteEssntlStplatService;
	
    /************************* 2019.02.28  start **********************************/
	
    /** 2019.02.28 세부약관 리스트조회 */
    @RequestMapping(value="/**/siteMngr/siteStplat/simp/selectSiteStplatSimpListAjax.do")
    public String selectSiteStplatSimpList(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
            , HttpServletRequest request 
            , ModelMap model) throws Exception{
        
        String siteSeq = StringUtils.defaultString(paramVO.getSiteSeq());
        
        // 시스템 관리자 - 사이트 관리자에 따른 사이트SEQ 설정
        if ("".equals(siteSeq)) {
            
            if (!CmmSessionUtil.getSessionSysMngrAt(request)) {
                siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
                
                paramVO.setSiteSeq(siteSeq);
            }
        } else {
            model.addAttribute("siteSeq", paramVO.getSiteSeq());   
        }

        List<SiteStplatInfoVO> resultList = stplatSimpService.selectSiteStplatSimpList(paramVO);

        model.addAttribute("resultList", resultList);
        
        return "wzwg/sysMngr/siteMngr/siteStplat/simp/stplatSimpListAjax";
    }

	/** 2019.02.28 세부약관 등록시 사용 */
    @RequestMapping(value="/**/siteMngr/siteStplat/simp/registSiteStplatSimp.do")
    public ModelAndView registSiteStplatsimp(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
            , HttpServletRequest request
            , ModelMap model) throws Exception{
        
        String siteSeq = StringUtils.defaultString(paramVO.getSiteSeq());
        
        paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
        paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
        
        // 시스템 관리자 - 사이트 관리자에 따른 사이트SEQ 설정
        if ("".equals(siteSeq)) {
            
            if (!CmmSessionUtil.getSessionSysMngrAt(request)) {
                siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
                
                paramVO.setSiteSeq(siteSeq);
            }
        }
        
        int result = stplatSimpService.registSiteStplatSimp(paramVO);
        
        return CmmAjaxUtil.getAjaxReturnCmmMap(result);
    }
    
    /** 2019.02.28 세부약관 수정화면으로 이동 */
    @RequestMapping(value="/**/siteMngr/siteStplat/simp/selectSiteStplatSimpAjax.do")
    public String selectSiteStplatSimp(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
            , HttpServletRequest request 
            , ModelMap model) throws Exception{
        
        String siteSeq = StringUtils.defaultString(paramVO.getSiteSeq());
        
        // 시스템 관리자 - 사이트 관리자에 따른 사이트SEQ 설정
        if ("".equals(siteSeq)) {
            
            if (!CmmSessionUtil.getSessionSysMngrAt(request)) {
                siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
                
                paramVO.setSiteSeq(siteSeq);
            }
        } else {
            model.addAttribute("siteSeq", paramVO.getSiteSeq());   
        }

        SiteStplatInfoVO infoSimpVO = stplatSimpService.selectSiteStplatSimpDetail(paramVO);

        model.addAttribute("infoSimpVO", infoSimpVO);
        
        return "wzwg/sysMngr/siteMngr/siteStplat/simp/stplatSimpAjax";
    }

    /** 2019.02.28 상세약관 수정시 사용 */
    @RequestMapping(value="/**/siteMngr/siteStplat/simp/modifySiteStplatSimp.do")
    public ModelAndView modifySiteStplatSimp(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
            , HttpServletRequest request
            , ModelMap model) throws Exception{
        
        String siteSeq = StringUtils.defaultString(paramVO.getSiteSeq());
        
        paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
        
        // 시스템 관리자 - 사이트 관리자에 따른 사이트SEQ 설정
        if ("".equals(siteSeq)) {
            
            if (!CmmSessionUtil.getSessionSysMngrAt(request)) {
                siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
                
                paramVO.setSiteSeq(siteSeq);
            }
        }
        
        int result = stplatSimpService.modifySiteStplatSimp(paramVO);
        
        return CmmAjaxUtil.getAjaxReturnCmmMap(result);
    }
    
    /** 2019.02.28 세부약관 삭제할때 사용함 */
    @RequestMapping(value="/**/siteMngr/siteStplat/simp/deleteSiteStplatSimp.do")
    public ModelAndView deleteSiteStplatsimp(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
            , HttpServletRequest request) throws Exception{
        
        String siteSeq = StringUtils.defaultString(paramVO.getSiteSeq());
        
        paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
        
        // 시스템 관리자 - 사이트 관리자에 따른 사이트SEQ 설정
        if ("".equals(siteSeq)) {
            
            if (!CmmSessionUtil.getSessionSysMngrAt(request)) {
                siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
                
                paramVO.setSiteSeq(siteSeq);
            }
        }

        // 사이트 약관정보매핑 등록
        int result = stplatSimpService.deleteSiteStplatSimp(paramVO);
        
        return CmmAjaxUtil.getAjaxReturnCmmMap(result);
    }

    /************************* 2019.02.28  end **********************************/
    
    
    
    
    
    @RequestMapping(value="/**/siteMngr/sysSiteStplat/sys/registSysSiteStplatSimp.do")
    public ModelAndView registSysSiteStplatSimp(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
            , HttpServletRequest request
            , ModelMap model) throws Exception{
        
    	 String siteSeq = "10000000001";
        
        paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
         
                
                paramVO.setSiteSeq(siteSeq); 
        
        int result = stplatSimpService.registSiteStplatSimp(paramVO);
        
        return CmmAjaxUtil.getAjaxReturnCmmMap(result);
    }
        
    @RequestMapping(value="/**/sysSiteStplat/sys/selectSysSiteStplatSimpList.do")
    public String selectSysSiteStplatSimpList(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
            , HttpServletRequest request 
            , ModelMap model) throws Exception{
        
        String siteSeq = "10000000001";
        paramVO.setSiteSeq(siteSeq);
       
         model.addAttribute("siteSeq", siteSeq);   

        List<SiteStplatInfoVO> resultList = stplatSimpService.selectSiteStplatSimpList(paramVO);

        model.addAttribute("resultList", resultList);
        
        return "wzwg/sysMngr/siteMngr/siteStplat/sys/sysStplatSimpList";
    }
    
    @RequestMapping(value="/**/sysSiteStplat/sys/selectSysSiteStplatSimpRegist.do")
    public String selectSysSiteStplatSimpRegist(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
            , HttpServletRequest request 
            , ModelMap model) throws Exception{
        
        String siteSeq = "10000000001";
        
        
        model.addAttribute("resultVO", paramVO);
         model.addAttribute("siteSeq", siteSeq);   

   
        
        return "wzwg/sysMngr/siteMngr/siteStplat/sys/sysStplatSimpRegist";
    }
    
    
    @RequestMapping(value="/**/siteMngr/sysSiteStplat/sys/selectSysSiteStplatSimpDetail.do")
    public String selectSysSiteStplatSimpDetail(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
            , HttpServletRequest request 
            , ModelMap model) throws Exception{
        
        String siteSeq = "10000000001";
        // 시스템 관리자 - 사이트 관리자에 따른 사이트SEQ 설정
     
                
                paramVO.setSiteSeq(siteSeq);
        
            model.addAttribute("siteSeq", siteSeq);    

        SiteStplatInfoVO infoSimpVO = stplatSimpService.selectSiteStplatSimpDetail(paramVO);

        model.addAttribute("infoSimpVO", infoSimpVO);
        
        return "wzwg/sysMngr/siteMngr/siteStplat/sys/sysStplatSimpDetail";
    }
    
    @RequestMapping(value="/**/siteMngr/sysSiteStplat/sys/modifySysSiteStplatSimp.do")
    public ModelAndView modifySysSiteStplatSimp(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
            , HttpServletRequest request
            , ModelMap model) throws Exception{
        
    	 String siteSeq = "10000000001";
        
        paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
         
        paramVO.setSiteSeq(siteSeq); 
        
        int result = stplatSimpService.modifySiteStplatSimp(paramVO);
        
        return CmmAjaxUtil.getAjaxReturnCmmMap(result);
    }
    
    @RequestMapping(value="/**/siteMngr/sysSiteStplat/sys/defaultSysSiteStplatSimp.do")
    public ModelAndView defaultSysSiteStplatSimp(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
            , HttpServletRequest request
            , ModelMap model) throws Exception{
        
    	 String siteSeq = "10000000001";
        
        paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
         
        paramVO.setSiteSeq(siteSeq); 
        int result =   stplatSimpService.defaultAllNonSysSiteStplatSimp(paramVO);
        result =   stplatSimpService.defaultSysSiteStplatSimp(paramVO);
       
        return CmmAjaxUtil.getAjaxReturnCmmMap(result);
    }
    
    @RequestMapping(value="/**/siteMngr/sysSiteStplat/sys/deleteSysSiteStplatSimp.do")
    public ModelAndView deleteSysSiteStplatSimp(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
            , HttpServletRequest request) throws Exception{
        
    	 String siteSeq = "10000000001";
        
        paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
         
                paramVO.setSiteSeq(siteSeq); 

        // 사이트 약관정보매핑 등록
        int result = stplatSimpService.deleteSysSiteStplatSimp(paramVO);
        
        return CmmAjaxUtil.getAjaxReturnCmmMap(result);
    }
    
    @RequestMapping(value="/**/siteMngr/sysSiteStplat/sys/applySysSiteStplatSimp.do")
    public ModelAndView applySysSiteStplatSimp(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
            , HttpServletRequest request
            , ModelMap model) throws Exception{
        
    	 String siteSeq = "10000000001";
        int result = 0;
        paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
         
        paramVO.setSiteSeq(siteSeq);  
        SiteStplatInfoVO infoSimpVO = stplatSimpService.selectSiteStplatSimpDetail(paramVO);
        SysMngrSiteInfoVO sysMngrSiteInfoVO = new SysMngrSiteInfoVO();
        List<SysMngrSiteInfoVO> siteInfoList = siteInfoService.selectSiteInfoSignList(sysMngrSiteInfoVO);
        for(int i =0 ;i <siteInfoList.size();i++){
        	SysMngrSiteInfoVO sysMngrSiteInfo = siteInfoList.get(i);
        	SiteStplatInfoVO siteStplatInfoVO = new SiteStplatInfoVO();
        	siteStplatInfoVO.setSiteSeq(sysMngrSiteInfo.getSiteSeq());
        	SiteStplatInfoVO siteStplatInfo = new SiteStplatInfoVO();
        	siteStplatInfo = siteStplatInfoService.selectSiteStplatInfoSign(siteStplatInfoVO);
        	String seq ="";
        	if(siteStplatInfo.getStplatSeq() == null){
        		siteStplatInfo =  siteStplatInfoService.selectSysSiteStplatInfoSign(siteStplatInfoVO);
        		siteStplatInfo.setSiteSeq(sysMngrSiteInfo.getSiteSeq());
        		seq = siteStplatInfoService.registSiteStplatInfoInit(siteStplatInfo);
        		siteStplatInfo.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
        		SiteEssntlStplatVO siteEssntlStplatVO = new SiteEssntlStplatVO();
        		SiteEssntlStplatVO siteEssntlStplat = new SiteEssntlStplatVO();
        		siteEssntlStplatVO.setStplatSeq(seq);
        		siteEssntlStplatVO.setSiteSeq(siteSeq);
        		siteEssntlStplat= siteEssntlStplatService.selectSiteEssntlStplatSign(siteEssntlStplatVO);
        		siteEssntlStplat.setSiteSeq(sysMngrSiteInfo.getSiteSeq());
        		siteEssntlStplat.setStplatSeq(seq); 
        		siteEssntlStplat.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
        		siteEssntlStplatService.applyEssntlStplat(siteEssntlStplat);
        		infoSimpVO.setStplatSeq(seq);
        		infoSimpVO.setSiteSeq(sysMngrSiteInfo.getSiteSeq());
        		infoSimpVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
        		result = stplatSimpService.registSiteStplatSimp(infoSimpVO);
        	}else{
        		SiteEssntlStplatVO siteEssntlStplatVO = new SiteEssntlStplatVO();
        		SiteEssntlStplatVO siteEssntlStplat = new SiteEssntlStplatVO(); 
        		siteEssntlStplatVO.setSiteSeq(sysMngrSiteInfo.getSiteSeq());
        		siteEssntlStplat =siteEssntlStplatService.selectSiteEssntlStplatSign(siteEssntlStplatVO);
        		if(siteEssntlStplat== null || siteEssntlStplat.getStplatSeq() == null){
        			siteEssntlStplatVO.setStplatSeq(siteStplatInfo.getStplatSeq());
        			siteEssntlStplatVO.setStplatTyCode("SC00000020");
        			siteEssntlStplatVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
        			siteEssntlStplatService.applyEssntlStplat(siteEssntlStplatVO);
        			infoSimpVO.setStplatSeq(siteStplatInfo.getStplatSeq());
        			infoSimpVO.setSiteSeq(sysMngrSiteInfo.getSiteSeq());
        			infoSimpVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
            		result = stplatSimpService.registSiteStplatSimp(infoSimpVO);
        		}else{
        			infoSimpVO.setStplatSeq(siteEssntlStplat.getStplatSeq());
        			infoSimpVO.setSiteSeq(sysMngrSiteInfo.getSiteSeq());
        			infoSimpVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
            		result = stplatSimpService.registSiteStplatSimp(infoSimpVO);
        		}
        	}
        	
        }
        return CmmAjaxUtil.getAjaxReturnCmmMap(result);
    }
}
