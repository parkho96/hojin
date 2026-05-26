package egovframework.wzwg.module.inqryDtls.web;

import java.util.IllegalFormatException;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.inqryDtls.service.SiteInqryDtlsService;
import egovframework.wzwg.site.mngr.inqryDtls.service.SiteInqryDtlsVO;

@Controller
public class ModuleInqryDtlsController {
    
    @Resource(name="SiteInqryDtlsService")
    private SiteInqryDtlsService inqryDtlsService;
    
    @RequestMapping(value= {"/module/inqryDtls/registInqryDtls.do","/{siteKey}/module/inqryDtls/registInqryDtls.do"})
	public ModelAndView registInqryDtls(
			@ModelAttribute("paramVO")SiteInqryDtlsVO paramVO
			,HttpServletRequest request
			, Model model ) {
        
        int result = 1;
        
        try {
            paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    		
    		inqryDtlsService.registSiteInqryDtls(paramVO);
        }  catch(NullPointerException e){
        	result= 0;
    	}catch(NumberFormatException e){
    		result= 0;
    	}catch(IllegalFormatException e){
    		result= 0;
    	}catch(ArrayIndexOutOfBoundsException e){
    		result= 0;
    	}  
        
        return CmmAjaxUtil.getAjaxReturnCmmMap(result);
	}
	
}
