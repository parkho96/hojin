package egovframework.wzwg.site.mngr.usrMngr.sbscrbCrtfcEstbs.web;

import java.util.IllegalFormatException;
import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.service.Globals;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.usrMngr.sbscrbCrtfcEstbs.service.SbscrbCrtfcEstbsService;
import egovframework.wzwg.site.mngr.usrMngr.sbscrbCrtfcEstbs.service.SbscrbCrtfcEstbsVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;
import egovframework.wzwg.sysMngr.usrPrefces.service.UsrPrefcesVO;

@Controller
public class SbscrbCrtfcEstbsController {
	
	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;
	
    @Resource(name="SbscrbCrtfcEstbsService")
    private SbscrbCrtfcEstbsService sbscrbCrtfcEstbsService;

	/** 가입인증설정 목록
	 * @throws Exception */
	@RequestMapping(value={"/mngr/usrMngr/sbscrbCrtfcEstbs/selectSbscrbCrtfcEstbsList.do","/{siteKey}/mngr/usrMngr/sbscrbCrtfcEstbs/selectSbscrbCrtfcEstbsList.do"})
	public String selectSbscrbCrtfcEstbsList (
			@ModelAttribute("paramVO") SbscrbCrtfcEstbsVO paramVO
			, HttpServletRequest request
			, Model model ) throws Exception {
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));

		String grpcode = Globals.USR_CRTFC_PREFE;
		
		/** 회원인증설정 코드 */
		List<UsrPrefcesVO> codeList = sbscrbCrtfcEstbsService.selectCrtfcEstbsList(grpcode);
		model.addAttribute("codeList", codeList);
		
		/** 가입인증설정 목록*/
		List<SbscrbCrtfcEstbsVO> resultList = sbscrbCrtfcEstbsService.selectSbscrbCrtfcEstbsList(paramVO);
		
		model.addAttribute("resultList", resultList);
		
		return "/wzwg/site/mngr/usrMngr/sbscrbCrtfcEstbs/sbscrbCrtfcEstbsList";
	}

	@RequestMapping("/**/mngr/usrMngr/sbscrbCrtfcEstbs/registSbscrbCrtfcEstbs.do")
	public String registSbscrbCrtfcEstbs(
			@ModelAttribute("paramVO") SbscrbCrtfcEstbsVO paramVO
			, HttpServletRequest request
			, Model model ) throws Exception {
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		
		try {
			paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
			paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
			
			sbscrbCrtfcEstbsService.registSbscrbCrtfcEstbs(paramVO);
			
			model.addAttribute("retMsg", "SUCCESS");
		} catch(NullPointerException e){
			model.addAttribute("retMsg", "ERROR");
	 	}catch(NumberFormatException e){
	 		model.addAttribute("retMsg", "ERROR");
	 	}catch(IllegalFormatException e){
	 		model.addAttribute("retMsg", "ERROR");
	 	}catch(ArrayIndexOutOfBoundsException e){
	 		model.addAttribute("retMsg", "ERROR");
	 	} 
		
		return "forward:"+wzwgContext+"/mngr/usrMngr/sbscrbCrtfcEstbs/selectSbscrbCrtfcEstbsList.do";
	}
}
