package egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoService;
import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbInfoService;
import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbQesitmService;
import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbVO;

/**
 * ㅁ 시스템 - 사용자관리 - 가입정보관리
 * ㅁ DC   
 * - 시스템관리자가 가입정보를 관리
 * - 생선된 사용자는 사용자 관리자 페이지를 이용하여 접속
 * @author 김c
 *
 */
@Controller
public class SysMngrSbscrbInfoController {

    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

    @Resource(name="SysMngrSiteInfoService")
	private SysMngrSiteInfoService siteInfoService;
    
	@Resource(name="SysMngrSbscrbInfoService")
	private SysMngrSbscrbInfoService sbscrbInfoService;

	@Resource(name="SysMngrSbscrbQesitmService")
	private SysMngrSbscrbQesitmService sbscrbQesitmService;
	

	
	/**
	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/usrMngr/siteSbscrb/selectSbscrbInfoList.do")
	public String selectSbscrbInfoList(
			@ModelAttribute("paramVO") SysMngrSbscrbVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{

		paramVO.setPageUnit(propertyService.getInt("pageUnit"));
		paramVO.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
		paginationInfo.setPageSize(paramVO.getPageSize());

		paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
		paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		// 사이트 정보 목록
		List<SysMngrSbscrbVO> resultList = sbscrbInfoService.selectSbscrbInfoList(paramVO);
		
		// 사이트 정보 목록
		Integer resultCnt = sbscrbInfoService.selectSbscrbInfoListTotCnt(paramVO);
		
		paginationInfo.setTotalRecordCount(resultCnt.intValue());
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", resultCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "wzwg/sysMngr/usrMngr/siteSbscrb/sbscrbInfoList";
	}

	/**
	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 설정 화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/usrMngr/siteSbscrb/selectSbscrbInfoForm.do")
	public String selectSbscrbInfoForm(
			@ModelAttribute("paramVO") SysMngrSbscrbVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{

		SysMngrSbscrbVO resultVO = new SysMngrSbscrbVO();
		
		String siteSeq = StringUtils.defaultString(paramVO.getSiteSeq());
		
		siteSeq = ("".equals(siteSeq))? CmmSessionUtil.getSessionSiteSeq(request):siteSeq;
		
		paramVO.setSiteSeq(siteSeq);
				
		int result = sbscrbInfoService.selectSbscrbinfoSeq(paramVO);
		
		if(result > 0){
			resultVO 	= sbscrbInfoService.selectSbscrbInfoDetail(paramVO);
		}

		resultVO.setSiteSeq(paramVO.getSiteSeq());
		
		model.addAttribute("resultVO", resultVO);
		
		return "wzwg/sysMngr/usrMngr/siteSbscrb/sbscrbInfoForm"; 
	}
	
	
	/**
	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/usrMngr/siteSbscrb/registSbscrbInfoAjax.do")
	public ModelAndView registSbscrbInfo(
			@ModelAttribute("paramVO") SysMngrSbscrbVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) paramVO.setFrstRegisterId(loginVO.getUserId());
		
		result = sbscrbInfoService.registSbscrbInfo(paramVO);	// 등록
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/usrMngr/siteSbscrb/modifySbscrbInfoAjax.do")
	public ModelAndView modifySbscrbInfo(
			@ModelAttribute("paramVO") SysMngrSbscrbVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) paramVO.setLastUpdusrId(loginVO.getUserId());
		
		result = sbscrbInfoService.modifySbscrbInfo(paramVO);	// 수정
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 미리보기
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/usrMngr/siteSbscrb/sbscrbInfoPreviewPopup.do")
	public String sbscrbInfoPreviewPopup(
			@ModelAttribute("paramVO") SysMngrSbscrbVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		SysMngrSbscrbVO resultVO = new SysMngrSbscrbVO();
		
		int result = sbscrbInfoService.selectSbscrbinfoSeq(paramVO);
		
		List<SysMngrSbscrbVO> qesitmList = null;
		List<SysMngrSbscrbVO> iemList   = null;
		
		if(result > 0){
			resultVO 	= sbscrbInfoService.selectSbscrbInfoDetail(paramVO);
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
		model.addAttribute("resultVO", resultVO);
		
		return "wzwg/sysMngr/usrMngr/siteSbscrb/sbscrbInfoPreview";
	}
	

}
