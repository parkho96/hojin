package egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttCmmnService;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttVO;
import egovframework.wzwg.module.ntt.simp.service.ModuleNttSimpDataManageService;
import egovframework.wzwg.module.ntt.simp.service.ModuleNttSimpVO;

@Aspect
public class NttAuthAspect {
    
    @Resource(name="CntntsAuthService")
    private CntntsAuthService cntntsAuthService;

    @Resource(name="ModuleNttCmmnService")
    protected ModuleNttCmmnService nttCmmnService;

    @Resource(name="ModuleNttSimpDataManageService")
    protected ModuleNttSimpDataManageService nttSimpDataManageService;    

    public void nttDetailAuth(JoinPoint jp) throws Throwable {

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

        ModelAndView retModel = new ModelAndView();
        retModel.setViewName("wzwg/cmm/errorStringMsgForward");
        retModel.addObject("retUrl", "/index.do");        

		String className = jp.getTarget().getClass().getName();
		String methodName = jp.getSignature().getName();  
		
		
		
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);	
		String bbsSeq = request.getParameter("bbsSeq");
		String nttSeq = request.getParameter("nttSeq");
		String parntsNttSeq = request.getParameter("parntsNttSeq");
		String secretAt = request.getParameter("secretAt");
		
		
		// 게시판 권한
		CntntsAuthVO cntntsAuthVO = new CntntsAuthVO();
		cntntsAuthVO.setCntntsSeq(bbsSeq);
		cntntsAuthVO.setSiteSeq(siteSeq);
		
		if(loginVO != null){
			cntntsAuthVO.setUsrSeq(loginVO.getUsrSeq());
		} else {
			cntntsAuthVO.setUsrSeq("0");
		}
		
		CntntsAuthVO nttAuthVO = cntntsAuthService.selectCntntsAuthForNtt(cntntsAuthVO);	
		
		
		String authAt = "N";    
		
		if(session.getAttribute("cmntAuthR") != null && session.getAttribute("cmntAuthR").toString().equals("Y")){
			authAt ="Y";
		} 
		
		if(session.getAttribute("cmntAuthW") != null && session.getAttribute("cmntAuthW").toString().equals("Y")){
			authAt ="Y";
		}
		
		if (CmmSessionUtil.getSessionBooleanValue(request, "cmntMngrAt")) {
			authAt ="Y";
		}				
		
		if(session.getAttribute("SADMIN_AT") != null && CmmSessionUtil.getSessionBooleanValue(request, "SADMIN_AT")) {
			authAt = "Y";
		}
		
		if(session.getAttribute("NADMIN_AT") != null && CmmSessionUtil.getSessionBooleanValue(request, "NADMIN_AT")){
			authAt = "Y";
		}
		
		if(secretAt != null && !secretAt.equals("Y")) {
		
			if(nttAuthVO != null) {
				if(nttAuthVO.getAuthorSe().equals("R") || nttAuthVO.getAuthorSe().equals("W")) {
					authAt = "Y";
				}		
			}
			
		}
		
		if(className.indexOf("Unity") > -1 || className.indexOf("Qna") > -1) {
			if(methodName.indexOf("Detail") > -1) {
				ModuleNttVO moduleNttVO = new ModuleNttVO();
				moduleNttVO.setSiteSeq(siteSeq);
				moduleNttVO.setNttSeq(nttSeq);
				String ntcrId = nttCmmnService.selectNttNtcrId(moduleNttVO);

				if(loginVO != null && ntcrId != null) {
					if(loginVO.getUserId().equals(ntcrId)) {
						authAt = "Y";
					}
				}
				
				if(secretAt != null && secretAt.equals("Y")) {
					moduleNttVO.setNttSeq(parntsNttSeq);
					String parntsNtcrId = nttCmmnService.selectNttNtcrId(moduleNttVO);
					
					if(loginVO != null && parntsNtcrId != null) {
						if(loginVO.getUserId().equals(parntsNtcrId)) {
							authAt = "Y";
						}
					}
				}
				
		        if (authAt.equals("N")) {
		            retModel.addObject("errCd", "fail.common.author");
		            throw new ModelAndViewDefiningException(retModel);
		        }				
			}
		}		
		
    }
    
	public void nttRegistAuth(JoinPoint jp) throws Throwable {

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

		String className = jp.getTarget().getClass().getName();
		String methodName = jp.getSignature().getName();  

    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);	
		String bbsSeq = request.getParameter("bbsSeq");
		String nttSeq = request.getParameter("nttSeq");
		
		
		// 게시판 권한
		CntntsAuthVO cntntsAuthVO = new CntntsAuthVO();
		cntntsAuthVO.setCntntsSeq(bbsSeq);
		cntntsAuthVO.setSiteSeq(siteSeq);

		if(loginVO != null){
			cntntsAuthVO.setUsrSeq(loginVO.getUsrSeq());
		} else {
			cntntsAuthVO.setUsrSeq("0");
		}		

		CntntsAuthVO nttAuthVO = cntntsAuthService.selectCntntsAuthForNtt(cntntsAuthVO);	

		String authAt = "N";    
		
		if(session.getAttribute("cmntAuthW") != null && session.getAttribute("cmntAuthW").toString().equals("Y")){
			authAt ="Y";
		} 
		
		if (CmmSessionUtil.getSessionBooleanValue(request, "cmntMngrAt")) {
			authAt ="Y";
		}		

		if(session.getAttribute("SADMIN_AT") != null && CmmSessionUtil.getSessionBooleanValue(request, "SADMIN_AT")) {
			authAt = "Y";
		}
		
		if(session.getAttribute("NADMIN_AT") != null && CmmSessionUtil.getSessionBooleanValue(request, "NADMIN_AT")){
			authAt = "Y";
		}
		
		if(nttAuthVO != null) {
			if(nttAuthVO.getAuthorSe().equals("W")) {
				authAt = "Y";
			}		
		}
		
		if(methodName.indexOf("Info") > -1 || methodName.indexOf("Form") > -1) {

			ModelAndView retModel = new ModelAndView();
			
			if(methodName.indexOf("Form") > -1) {
		        retModel.setViewName("wzwg/cmm/errorStringMsgForward");
		        retModel.addObject("retUrl", "/index.do");  
			}
			
			if(methodName.indexOf("Info") > -1) {
				if (authAt.equals("N")) {
					retModel = CmmAjaxUtil.getAjaxReturn("fail");
		        }	
			}
			
	        if (authAt.equals("N")) {
	            retModel.addObject("errCd", "fail.common.author");
	            throw new ModelAndViewDefiningException(retModel);
	        }			
		}			

	}    
	
	public void nttModifyAuth(JoinPoint jp) throws Throwable {

        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();

		String className = jp.getTarget().getClass().getName();
		String methodName = jp.getSignature().getName();  

    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);	
		String bbsSeq = request.getParameter("bbsSeq");
		String nttSeq = request.getParameter("nttSeq");
		String simpnttSeq = request.getParameter("simpnttSeq");

		String authAt = "N";    
		
		if(session.getAttribute("cmntAuthW") != null && session.getAttribute("cmntAuthW").toString().equals("Y")){
			authAt ="Y";
		} 
		
		if (CmmSessionUtil.getSessionBooleanValue(request, "cmntMngrAt")) {
			authAt ="Y";
		}
		
		if(session.getAttribute("SADMIN_AT") != null && CmmSessionUtil.getSessionBooleanValue(request, "SADMIN_AT")) {
			authAt = "Y";
		}
		
		if(session.getAttribute("NADMIN_AT") != null && CmmSessionUtil.getSessionBooleanValue(request, "NADMIN_AT")){
			authAt = "Y";
		}
		
		if(methodName.indexOf("Info") > -1 || methodName.indexOf("Form") > -1) {
			
			String ntcrId = "";

			if(className.indexOf("Unity") > -1 || className.indexOf("Qna") > -1) {
				ModuleNttVO moduleNttVO = new ModuleNttVO();
				moduleNttVO.setSiteSeq(siteSeq);
				moduleNttVO.setNttSeq(nttSeq);
				ntcrId = nttCmmnService.selectNttNtcrId(moduleNttVO);
			}
			
			if(className.indexOf("Simp") > -1) {
				ModuleNttSimpVO moduleNttSimpVO = new ModuleNttSimpVO();
				moduleNttSimpVO.setSiteSeq(siteSeq);
				moduleNttSimpVO.setSimpnttSeq(simpnttSeq);
				ntcrId = nttSimpDataManageService.selectNttSimpNtcrId(moduleNttSimpVO);
			}			
			
			if(loginVO != null && ntcrId != null) {
				if(loginVO.getUserId().equals(ntcrId)) {
					authAt = "Y";
				}
			}
			
			ModelAndView retModel = new ModelAndView();
			
			if(methodName.indexOf("Form") > -1) {
		        retModel.setViewName("wzwg/cmm/errorStringMsgForward");
		        retModel.addObject("retUrl", "/index.do");  
			}
			
			if(methodName.indexOf("Info") > -1) {
				if (authAt.equals("N")) {
					retModel = CmmAjaxUtil.getAjaxReturn("fail");
		        }	
			}
			
	        if (authAt.equals("N")) {
	            retModel.addObject("errCd", "fail.common.author");
	            throw new ModelAndViewDefiningException(retModel);
	        }				
			
		}

	}  
	
}