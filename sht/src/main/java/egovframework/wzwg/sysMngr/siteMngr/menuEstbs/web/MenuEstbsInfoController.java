package egovframework.wzwg.sysMngr.siteMngr.menuEstbs.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.IllegalFormatException;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoService;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuVO;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;
import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.SysModuleInfoService;
import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.SysModuleInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.menuEstbs.service.MenuEstbsInfoService;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

/**
 * ㅁ 시스템 - 메뉴설정그룹관리
 * ㅁ DC   
 * - 시스템관리자가 메뉴설정를 관리
 * - 생선된 메뉴설정는 메뉴설정 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
@Controller
@Slf4j
public class MenuEstbsInfoController {

    @Resource(name="MenuEstbsInfoService")
    private MenuEstbsInfoService siteMenuService;
    
    @Resource(name="CntntsInfoService")
    private CntntsInfoService cntntsInfoService;
    
    @Resource(name="SysModuleInfoService")
    private SysModuleInfoService sysModuleInfoService;

    @RequestMapping(value="/sysMngr/siteMngr/menuEstbsInfo/registSiteMenuMngrFrmAjax.do")
    public String registSiteMenuMngrAjax(
        @ModelAttribute("paramVO")SiteMenuVO siteMenuVO
        , HttpServletRequest request
        , Model model ) throws Exception {
        
        /** 사이트 시퀀스 */
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        siteMenuVO.setSiteSeq(siteSeq);
        
        Map<String, Object> siteMenuList = siteMenuService.registSiteMenuMngrInfo(siteMenuVO);
        
        model.addAttribute("resultList", siteMenuList);
        
        return "wzwg/sysMngr/siteMngr/menuEstbsInfo/siteMenuRegistAjaxFrm";
    }
    
    /**
     * 사이트 메뉴 등록
     * @param siteMenuVO
     * @param request
     * @param model
     * @return
     * @throws Exception 
     */
    @RequestMapping(value="/sysMngr/siteMngr/menuEstbsInfo/registSiteMenuMngrAjax.do")
    public @ResponseBody String registSiteMenuMngr(
            HttpServletRequest request
            , @ModelAttribute("paramVO")SiteMenuVO siteMenuVO
            , SysModuleInfoVO paramVO
            , HttpServletResponse response
            , Model model ) throws Exception {
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
        try{
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        String menuLv ="1";
        siteMenuVO.setSiteSeq(siteSeq);
        int menuOrdrInt = 1;
        if(siteMenuService.selectMaxMenuOrdr(siteMenuVO) !=null){
         menuOrdrInt = siteMenuService.selectMaxMenuOrdr(siteMenuVO)+1;
        }
        SiteMenuVO upperVO  = new SiteMenuVO();
        if(!("").equals(siteMenuVO.getUpperMenuSeq())){
            SiteMenuVO siteUpperMenuVO  = new SiteMenuVO();
            siteUpperMenuVO.setMenuSeq(siteMenuVO.getUpperMenuSeq());
            siteUpperMenuVO.setSiteSeq(siteSeq);
            upperVO =siteMenuService.selectSiteMenu(siteUpperMenuVO);
            menuLv = String.valueOf((Integer.parseInt(upperVO.getMenuLv())+1));
            menuOrdrInt = Integer.parseInt(upperVO.getMenuOrdr())+1;
            siteMenuService.modifySiteMenuPlusOrdr(upperVO);
        }
        
        if(("SC00000033").equals(siteMenuVO.getMenuTyCode())){
            siteMenuVO.setMenuLinkUrl(sysModuleInfoService.selectSysModuleInfoDetail(paramVO).getUsrPageUrl());
        }
        siteMenuVO.setMenuLv(menuLv);
        siteMenuVO.setMenuOrdr(String.valueOf(menuOrdrInt));
        if(("link").equals(siteMenuVO.getSysmoduleSeq())){
            siteMenuVO.setSysmoduleSeq("");
        }
        siteMenuService.registSiteMenu(siteMenuVO);
        }catch(NullPointerException e){
	       	 log.error("NullPointerException",e);
	   	}catch(NumberFormatException e){
	   		log.error("NumberFormatException",e);
	   	}catch(IllegalFormatException e){
	   		log.error("IllegalFormatException",e);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		log.error("ArrayIndexOutOfBoundsException",e);
	   	}catch(IOException e){
	   		log.error("IOException",e);
      }catch(SQLException e){
      	log.error("SQLException",e);
      }
        return "forward:"+wzwgContext+"/sysMngr/siteMngr/menuEstbs/selectMenuEstbsForm.do";
    }

    @RequestMapping(value="/sysMngr/siteMngr/menuEstbsInfo/siteMenuCntntListAjax.do")
    public   String siteMenuCntntList(
            @ModelAttribute("paramVO")SiteMenuVO siteMenuVO
            , HttpServletRequest request
            , HttpServletResponse response
            , Model model ) throws Exception {
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        siteMenuVO.setSiteSeq(siteSeq);
        model.addAttribute("menuCntntList", siteMenuService.selectSiteMenuCntntList(siteMenuVO));
        
        return "wzwg/sysMngr/siteMngr/menuEstbsInfo/siteMenuCntntList";
    }
    

    @RequestMapping(value="/sysMngr/siteMngr/menuEstbsInfo/modifySiteMenuMngrFrmAjax.do")
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
        
        return "wzwg/sysMngr/siteMngr/menuEstbsInfo/siteMenuModifyAjaxFrm";
    }
    
    @RequestMapping(value="/sysMngr/siteMngr/menuEstbsInfo/modifySiteMenuMngrAjax.do")
    public @ResponseBody String modifySiteMenuMngr(
            HttpServletRequest request
            , @ModelAttribute("paramVO")SiteMenuVO siteMenuVO
            , SysModuleInfoVO paramVO
            , HttpServletResponse response
            , Model model ) throws Exception {
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
        try{
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        String menuLv ="1";
        siteMenuVO.setSiteSeq(siteSeq);
        int menuOrdrInt =Integer.parseInt(siteMenuVO.getMenuOrdr());
        SiteMenuVO upperVO  = new SiteMenuVO();
        if(!("").equals(siteMenuVO.getUpperMenuSeq())){
            SiteMenuVO siteUpperMenuVO  = new SiteMenuVO();
            siteUpperMenuVO.setMenuSeq(siteMenuVO.getUpperMenuSeq());
            siteUpperMenuVO.setSiteSeq(siteSeq);
            upperVO =siteMenuService.selectSiteMenu(siteUpperMenuVO);
            menuLv = String.valueOf((Integer.parseInt(upperVO.getMenuLv())+1));
            menuOrdrInt = Integer.parseInt(upperVO.getMenuOrdr())+1;
            siteMenuService.modifySiteMenuPlusOrdr(upperVO);
        }
        if(("SC00000033").equals(siteMenuVO.getMenuTyCode())){
			siteMenuVO.setMenuLinkUrl(sysModuleInfoService.selectSysModuleInfoDetail(paramVO).getUsrPageUrl());
		}else if(!("link").equals(siteMenuVO.getMenuTyCode()) && !("link").equals(siteMenuVO.getSysmoduleSeq())){
			siteMenuVO.setMenuLinkUrl("");
		} 
		if(("link").equals(siteMenuVO.getSysmoduleSeq()) ){
			siteMenuVO.setSysmoduleSeq("");
			siteMenuVO.setSitecntntsSeq("");
			siteMenuVO.setMenuTyCode("");
		}
        siteMenuVO.setMenuLv(menuLv);
        siteMenuVO.setMenuOrdr(String.valueOf(menuOrdrInt));
        siteMenuService.modifySiteMenu(siteMenuVO);
        }catch(NullPointerException e){
	       	 log.error("NullPointerException",e);
	   	}catch(NumberFormatException e){
	   		log.error("NumberFormatException",e);
	   	}catch(IllegalFormatException e){
	   		log.error("IllegalFormatException",e);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		log.error("ArrayIndexOutOfBoundsException",e);
	   	}catch(IOException e){
	   		log.error("IOException",e);
      }catch(SQLException e){
      	log.error("SQLException",e);
      }
        return "forward:"+wzwgContext+"/sysMngr/siteMngr/menuEstbs/selectMenuEstbsForm.do";
    }
    
    @RequestMapping(value="/sysMngr/siteMngr/menuEstbsInfo/deleteSiteMenuMngrAjax.do")
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
    
    @RequestMapping(value="/sysMngr/siteMngr/menuEstbsInfo/selectSiteMenuMngrListAjax.do")
    public String selectSiteMenuMngrListAjax(
        @ModelAttribute("paramVO")SiteMenuVO siteMenuVO
        , HttpServletRequest request
        , Model model ) throws Exception {
        
        /** 사이트 시퀀스 */
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        siteMenuVO.setSiteSeq(siteSeq);
        
        Map<String, Object> siteMenuList = siteMenuService.selectSiteMenuMngrList(siteMenuVO);
        
        model.addAttribute("resultList", siteMenuList);
        
        return "wzwg/sysMngr/siteMngr/menuEstbsInfo/siteMenuListAjax";
    }
    
    @RequestMapping(value="/sysMngr/siteMngr/menuEstbsInfo/modifySiteMenuMngrOrdrAjax.do")
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
    
    @RequestMapping(value="/sysMngr/siteMngr/menuEstbsInfo/deleteSiteMenuLowAjax.do")
    public ModelAndView deleteSiteMenuLowAjax(
        @ModelAttribute("paramVO")SiteMenuVO siteMenuVO
        , HttpServletRequest request 
        , HttpServletResponse response
        ) throws Exception {
        
        /** 사이트 시퀀스 */
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        siteMenuVO.setSiteSeq(siteSeq);
        siteMenuVO.setUserId(CmmSessionUtil.getSessionUserId());
        
        String result = "success";
        
        try {
            siteMenuService.deleteSiteMenuLow(siteMenuVO);
        } catch(NullPointerException e){        	
        	result = "fail";
   	   	}catch(NumberFormatException e){
   	   		result = "fail";   	   	    	   	   	   
   	   	}catch(IOException e){
   	   		result = "fail";   	   	
        }catch(SQLException e){
    		result = "fail";
        }  
        
        return CmmAjaxUtil.getAjaxReturn(result);
    }
}
