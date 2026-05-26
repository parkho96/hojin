package egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbInfoService;
import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbQesitmService;
import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbVO;

/**
 * ㅁ 시스템 - 사용자관리 - 가입질문관리
 * ㅁ DC   
 * - 시스템관리자가 가입정보를 관리
 * - 생선된 사용자는 사용자 관리자 페이지를 이용하여 접속
 * @author 김c
 *
 */
@Controller
public class SysMngrSbscrbQesitmController {

    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
    
	@Resource(name="SysMngrSbscrbQesitmService")
	private SysMngrSbscrbQesitmService sbscrbQesitmService;

	@Resource(name="SysMngrSbscrbInfoService")
	private SysMngrSbscrbInfoService sbscrbInfoService;
	
	
	
	
	/**
	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 가입질문
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/usrMngr/siteSbscrb/selectSbscrbQesitmImport.do")
	public String selectSbscrbQesitmImport(
			@ModelAttribute("paramVO") SysMngrSbscrbVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{

		SysMngrSbscrbVO resultVO = new SysMngrSbscrbVO();
		
		String siteSeq = StringUtils.defaultString(paramVO.getSiteSeq());
		
		siteSeq = ("".equals(siteSeq))? CmmSessionUtil.getSessionSiteSeq(request):siteSeq;
		
		paramVO.setSiteSeq(siteSeq);
				
		int result = sbscrbInfoService.selectSbscrbinfoSeq(paramVO);
		
		List<SysMngrSbscrbVO> qesitmList = null;
		List<SysMngrSbscrbVO> iemList   = null;
		
		if(result > 0){
			resultVO 	= sbscrbInfoService.selectSbscrbInfoDetail(paramVO);
			resultVO.setUsrtySeq(paramVO.getUsrtySeq());
			qesitmList 	= sbscrbQesitmService.selectSbscrbQesitmList(resultVO);
			
			if(qesitmList.size() > 0){
				resultVO.setSbscrbinfoSeq(qesitmList.get(0).getSbscrbinfoSeq());
				iemList = sbscrbQesitmService.selectSbscrbIemList(resultVO);
			}
		}else{
			resultVO.setSiteSeq(paramVO.getSiteSeq());
		}
		
		model.addAttribute("qesitmList", qesitmList);
		model.addAttribute("iemList", iemList);
		
		return "wzwg/sysMngr/usrMngr/siteSbscrb/sbscrbQesitm";
	}
	
	/**
	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/usrMngr/siteSbscrb/registSbscrbQesitmAjax.do")
	public ModelAndView registSbscrbQesitm(
			@ModelAttribute("paramVO") SysMngrSbscrbVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) paramVO.setFrstRegisterId(loginVO.getUserId());
		
		result = sbscrbQesitmService.registSbscrbQesitm(paramVO);	// 등록
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 질문삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/usrMngr/siteSbscrb/deleteSbscrbQesitmAjax.do")
	public ModelAndView deleteSbscrbQesitm(
			@RequestParam(value="delQesitmSeq", required=false) String sbscrbqesitmSeq
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		SysMngrSbscrbVO paramVO = new SysMngrSbscrbVO();
		
		paramVO.setSbscrbqesitmSeq(sbscrbqesitmSeq);
		
		if (loginVO != null) paramVO.setLastUpdusrId(loginVO.getUserId());
		
		result = sbscrbQesitmService.deleteSbscrbQesitm(paramVO);	// 삭제
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}


}
