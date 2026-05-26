package egovframework.wzwg.sysMngr.siteMngr.siteInfo.web;

import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.Globals;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;
import egovframework.wzwg.sysMngr.siteMngr.siteGroup.service.SiteGroupService;
import egovframework.wzwg.sysMngr.siteMngr.siteGroup.service.SiteGroupVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteOpertNtcService;

/**
 * ㅁ 시스템 - 사이트정보관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
@Controller
public class SysMngrSiteInfoController {

    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

	@Resource(name="SysMngrSiteInfoService")
	private SysMngrSiteInfoService siteInfoService;
	
	@Resource(name="SysMngrSiteOpertNtcService")
	private SysMngrSiteOpertNtcService siteOpertNtcService;

    @Resource(name="SiteGroupService")
    private SiteGroupService siteGroupService;

    /**
     * 사이트 대분류 코드
     * @return 코드 목록
     * @throws Exception 
     */
//    @ModelAttribute("siteLclasGroupList")
//    public List<SiteGroupVO> getSiteClList() throws Exception {
//        
//        SiteGroupVO paramVO = new SiteGroupVO();
//        
//        // 1차
//        paramVO.setOdr("1");
//        
//        List<SiteGroupVO> resultList = siteGroupService.selectSiteGroupAjax(paramVO);
//        
//        return resultList;
//    }
	
	/**
	 * ㅁ 시스템 - 사이트 정보 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/siteMngr/siteInfo/selectSiteInfoList.do","/{siteKey}/**/siteMngr/siteInfo/selectSiteInfoList.do"})
	public String selectSiteInfoList(@ModelAttribute("paramVO") SysMngrSiteInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		
		// 사이트 관리자 = 사이트 상세 정보로 이동
		if (!CmmSessionUtil.getSessionSysMngrAt(request))
			return "forward:"+wzwgContext+CmmSessionUtil.getSessionMngrSitePrefix(request)+"/siteMngr/siteInfo/selectSiteInfoForm.do";

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
		List<SysMngrSiteInfoVO> resultList = siteInfoService.selectSiteInfoList(paramVO);
		
		// 사이트 정보 목록
		Integer resultCnt = siteInfoService.selectSiteInfoListCnt(paramVO);
		
		paginationInfo.setTotalRecordCount(resultCnt.intValue());
		
		/* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
		
		SiteGroupVO siteGroupVO = new SiteGroupVO();
       
		// 1차
		siteGroupVO.setOdr("1");
       
        model.addAttribute("siteLclasGroupList", siteGroupService.selectSiteGroupAjax(siteGroupVO));
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", resultCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		// 대표도메인
		model.addAttribute("reprsntSiteUrl", EgovProperties.getProperty("reprsnt.domn.url"));
		return "wzwg/sysMngr/siteMngr/siteInfo/siteInfoList";
	}

	/**
	 * ㅁ 시스템 - 사이트 등록 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/siteInfo/selectSiteInfoForm.do")
	public String selectSiteInfoForm(@ModelAttribute("paramVO") SysMngrSiteInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		
		// 수정일때 siteSeq 존재함
		String siteSeq = StringUtils.defaultString(paramVO.getSiteSeq());
		Integer resultCnt = siteInfoService.selectSiteInfoListCnt(paramVO);
		// 사이트 관리자 = 무조건 자신 사이트만
		if (!CmmSessionUtil.getSessionSysMngrAt(request)) {
			siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
			paramVO.setSiteSeq(siteSeq);
		}

		if (!"".equals(siteSeq)) {
			// 수정일경우 상세데이터 가져옴
			SysMngrSiteInfoVO resultVO = siteInfoService.selectSiteInfoDetail(paramVO);

			// 사이트명 설정
			paramVO.setSiteFullNm(resultVO.getSiteFullNm());
			
			model.addAttribute("resultVO", resultVO);
		} else {
			model.addAttribute("resultVO", new SysMngrSiteInfoVO());
		}
		model.addAttribute("resultCnt",resultCnt);
		model.addAttribute("paramVO", paramVO);
		
		return "wzwg/sysMngr/siteMngr/siteInfo/siteInfoForm";
	}

	/**
	 * ㅁ 시스템 - 사이트 정보 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/siteInfo/registSiteInfo.do")
	public String registSiteInfo(@ModelAttribute("paramVO") SysMngrSiteInfoVO paramVO
			, HttpServletRequest request
			, ModelMap model) throws Exception{
		
		paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
		
		// 사이트 정보 등록
		siteInfoService.registSiteInfo(paramVO, request);
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		
		return "redirect:"+wzwgContext+CmmSessionUtil.getSessionMngrSitePrefix(request)+"/siteMngr/siteInfo/selectSiteInfoList.do";
	}

	/**
	 * ㅁ 시스템 - 사이트 정보 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/siteInfo/modifySiteInfo.do")
	public String modifySiteInfo(@ModelAttribute("paramVO") SysMngrSiteInfoVO paramVO
			, HttpServletRequest request
			, ModelMap model) throws Exception{
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		
		paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
		
		// 사이트 정보 등록
		siteInfoService.modifySiteInfo(paramVO);
		
		return "forward:"+wzwgContext+CmmSessionUtil.getSessionMngrSitePrefix(request)+"/siteMngr/siteInfo/selectSiteInfoForm.do";
	}

	/**
	 * ㅁ 시스템 - 사이트 상태관리 등록 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/siteMngr/siteInfo/selectSiteSttusForm.do","/{siteKey}/**/siteMngr/siteInfo/selectSiteSttusForm.do"})
	public String selectSiteSttusForm(@ModelAttribute("paramVO") SysMngrSiteInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		
		// 수정일때 siteSeq 존재함
		String siteSeq = StringUtils.defaultString(paramVO.getSiteSeq());

		if (!"".equals(siteSeq)) {
			// 수정일경우 상세데이터 가져옴
			SysMngrSiteInfoVO resultVO = siteInfoService.selectSiteInfoDetail(paramVO);

			// 사이트명 설정
			paramVO.setSiteFullNm(resultVO.getSiteFullNm());
			
			String opertSeq = siteOpertNtcService.selectSiteOpertNtcSeqChk(paramVO);
			
			model.addAttribute("resultVO", resultVO);
			model.addAttribute("opertSeq", opertSeq);
			int sysChek = siteInfoService.selectSiteInfoSysCheck(paramVO);
			if(sysChek >0){
				model.addAttribute("sysChekYn", "Y");
			}else{
				model.addAttribute("sysChekYn", "N");
			}
		} else {
			model.addAttribute("resultVO", new SysMngrSiteInfoVO());
		}
		model.addAttribute("paramVO", paramVO);
		
		return "wzwg/sysMngr/siteMngr/siteInfo/siteSttusForm";
	}

	/**
	 * ㅁ 시스템 - 사이트 상태관리에서 서비스중지 할 경우 Ajax로 HTML 뿌려줌 (홈페이지 서비스중지 페이지)
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/siteInfo/selectSiteSrvcAtChangeAjax.do")
	public String selectSiteSrvcAtChangeAjax(@ModelAttribute("paramVO") SysMngrSiteInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		
		SysMngrSiteInfoVO opertVO = new SysMngrSiteInfoVO();
		
		/** 등록일경우, 수정일경우 나눈다. */
		String opertSeq = siteOpertNtcService.selectSiteOpertNtcSeqChk(paramVO);
		if(!("").equals(opertSeq)){
			paramVO.setOpertSeq(opertSeq);
			opertVO = siteOpertNtcService.selectSiteOpertNtcDetail(paramVO);
			
			model.addAttribute("opertVO", opertVO);
		}else{
			model.addAttribute("opertVO", opertVO);
		}
	
		return "wzwg/sysMngr/siteMngr/siteInfo/siteSttusSrvcAtAjax";
	}
	
	/**
	 * ㅁ 시스템 - 사이트 상태관리에서 서비스중지 할 경우 중지문구 미리보기 팝업
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/siteInfo/selectSiteSrvcAtChangePreviewPopup.do")
	public String selectSiteSrvcAtChangePreviewPopup(
			@ModelAttribute("paramVO") SysMngrSiteInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		
		model.addAttribute("resultVO", paramVO);
		
		return "wzwg/sysMngr/siteMngr/siteInfo/siteSttusSrvcAtPreviewPopup";
	}

	/**
	 * ㅁ 시스템 - 사이트 정보 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/siteInfo/modifySiteSttus.do")
	public String modifySiteSttus(@ModelAttribute("paramVO") SysMngrSiteInfoVO paramVO
			, HttpServletRequest request
			, ModelMap model) throws Exception{
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		
		paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
		
		// 사이트 정보 등록
		siteInfoService.modifySiteSttus(paramVO);
		
		return "forward:"+wzwgContext+CmmSessionUtil.getSessionMngrSitePrefix(request)+"/siteMngr/siteInfo/selectSiteSttusForm.do";
	}
    
    /**
     * ㅁ 조합번호 조회
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/**/siteMngr/siteInfo/selectAsscNoCntAjax.do")
    public ModelAndView selectAsscNoCnt(
            @ModelAttribute("paramVO") SysMngrSiteInfoVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{
        
        int resultCnt = siteInfoService.selectAsscNoCnt(paramVO);
        
        return CmmAjaxUtil.getAjaxReturn(Integer.toString(resultCnt));
    }
    
    /**
     * ㅁ 사이트 정보 엑셀 업로드
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/**/siteMngr/siteInfo/registSiteInfoExcelAjax.do")
    public String registSiteInfoExcelAjax(
            @ModelAttribute("paramVO") SysMngrSiteInfoVO paramVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {
        
        paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
        
        List<Map<String, String>> resultList = siteInfoService.registSiteInfoExcel(paramVO, request);
        
        model.addAttribute("resultList", resultList);
        
        return "wzwg/sysMngr/siteMngr/siteInfo/siteInfoExcelResult";
    }

	/**
	 * 사이트 키 중복체크
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value= {"/**/siteMngr/siteInfo/selectSiteInfoDplctCheckAjax.do","/{siteKey}/**/siteMngr/siteInfo/selectSiteInfoDplctCheckAjax.do"})
	public ModelAndView selectSbscrbUserIdDplctCeck(
            @ModelAttribute("paramVO") SysMngrSiteInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		String siteKey = paramVO.getSiteKey();
		String[] imprtySiteKeyArr = Globals.IMPRTY_SITEKEY.split(",");
		
		for(String str:imprtySiteKeyArr) {
			if((str).equals(siteKey)) {
				return CmmAjaxUtil.getAjaxReturnCmmMsgCode("dplctN");
			}
		}
				
		String result = siteInfoService.selectSiteInfoDplctCheck(paramVO);
		
		return CmmAjaxUtil.getAjaxReturnCmmMsgCode(result);
	}
    
    	
}
