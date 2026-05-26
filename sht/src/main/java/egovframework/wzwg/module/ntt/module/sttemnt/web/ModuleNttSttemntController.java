package egovframework.wzwg.module.ntt.module.sttemnt.web;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttCmmnService;
import egovframework.wzwg.module.ntt.module.sttemnt.service.ModuleNttSttemntService;
import egovframework.wzwg.module.ntt.module.sttemnt.service.ModuleNttSttemntVO;

@Controller
public class ModuleNttSttemntController {

    /** ModuleNttSttemntService */
    @Resource(name="ModuleNttSttemntService")
    protected ModuleNttSttemntService nttSttemntService;
    
    /** ModuleNttService */
    @Resource(name="ModuleNttCmmnService")
    protected ModuleNttCmmnService nttService;
    
    
    /**
   	 * ㅁ 게시물 신고
   	 * @param request
   	 * @param model
   	 * @return
   	 * @throws Exception
   	 */
   	@RequestMapping(value="/**/module/ntt/sttemnt/registNttSttemntAjax.do")
   	public ModelAndView registNttSttemnt(
   			@ModelAttribute("paramVO") ModuleNttSttemntVO paramVO
   			, @RequestParam(value="nttSeq", required=false) String nttSeq
   			, HttpServletRequest request 
   			, ModelMap model
   		) throws Exception{
   		
   		Integer result = 0;
   		
   		HttpSession session = request.getSession();
   		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
   		
   		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
   		if (loginVO != null) {
   			paramVO.setFrstRegisterId(loginVO.getUserId());
   		}
   		paramVO.setSttemntSeq(nttSttemntService.selectNextNttSttemntSeq());
   		
   		result = nttSttemntService.registNttSttemnt(paramVO);		// 신고
   				
   		if(result > 0){
   			return CmmAjaxUtil.getAjaxReturn("success");
   		}else{
   			return CmmAjaxUtil.getAjaxReturn("fail");
   		}
   		
   	}
	
}
