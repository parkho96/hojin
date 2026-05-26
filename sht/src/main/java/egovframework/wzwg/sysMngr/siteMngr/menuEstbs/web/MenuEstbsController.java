package egovframework.wzwg.sysMngr.siteMngr.menuEstbs.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.IllegalFormatException;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;
import egovframework.wzwg.sysMngr.siteMngr.menuEstbs.service.MenuEstbsService;
import egovframework.wzwg.sysMngr.siteMngr.menuEstbs.service.MenuEstbsVO;
import egovframework.wzwg.sysMngr.siteMngr.siteGroup.service.SiteGroupService;
import egovframework.wzwg.sysMngr.siteMngr.siteGroup.service.SiteGroupVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
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
public class MenuEstbsController {

    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
    
    /** EgovMessageSource */
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

	@Resource(name="MenuEstbsService")
	private MenuEstbsService menuEstbsService;

    @Resource(name="SiteGroupService")
    private SiteGroupService siteGroupService;

    /* 사이트부가정보 */
    @Resource(name="SysMngrSiteAdiInfoService")
    private SysMngrSiteAdiInfoService siteAdiInfoService;

    /**
     * 사이트 대분류 코드
     * @return 코드 목록
     * @throws Exception 
     */
    @ModelAttribute("siteLclasGroupList")
    public List<SiteGroupVO> getSiteClList() throws Exception {
        
        SiteGroupVO paramVO = new SiteGroupVO();
        
        // 1차
        paramVO.setOdr("2");
        paramVO.setUpperGrpSeq("10000000011");
        
        List<SiteGroupVO> resultList = siteGroupService.selectSiteGroupAjax(paramVO);
        
        return resultList;
    }

    /**
     * 사이트 대분류 코드
     * @return 코드 목록
     * @throws Exception 
     */
    @ModelAttribute("siteMlsfcGroupList")
    public List<SiteGroupVO> getSiteMlList() throws Exception {
        
        SiteGroupVO paramVO = new SiteGroupVO();
        
        // 1차
        paramVO.setOdr("2");
        paramVO.setUpperGrpSeq("10000000012");
        
        List<SiteGroupVO> resultList = siteGroupService.selectSiteGroupAjax(paramVO);
        
        return resultList;
    }
	
	/**
	 * ㅁ 시스템 - 메뉴설정 그룹 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sysMngr/siteMngr/menuEstbs/selectMenuEstbsList.do")
	public String selectMenuEstbsList(@ModelAttribute("paramVO") MenuEstbsVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception {

		paramVO.setPageUnit(propertyService.getInt("pageUnit"));
		paramVO.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
		paginationInfo.setPageSize(paramVO.getPageSize());

		paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
		paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		// 메뉴설정 그룹 목록
		List<MenuEstbsVO> resultList = menuEstbsService.selectMenuEstbsList(paramVO);
		
		// 메뉴설정 그룹 목록
		Integer resultCnt = menuEstbsService.selectMenuEstbsListCnt(paramVO);
		
		paginationInfo.setTotalRecordCount(resultCnt.intValue());
		
		/* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", resultCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "wzwg/sysMngr/siteMngr/menuEstbs/menuEstbsList";
	}

	/**
	 * ㅁ 시스템 - 메뉴설정 등록 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sysMngr/siteMngr/menuEstbs/selectMenuEstbsForm.do")
	public String selectMenuEstbsForm(@ModelAttribute("paramVO") MenuEstbsVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		
		// 수정일때 estbsinfoSeq 존재함
		String estbsinfoSeq = StringUtils.defaultString(paramVO.getEstbsinfoSeq());
		
		if (!"".equals(estbsinfoSeq)) {
			// 수정일경우 상세데이터 가져옴
			MenuEstbsVO resultVO = menuEstbsService.selectMenuEstbsDetail(paramVO);

	        // 메뉴설정 불러옴
//	        List<MenuEstbsVO> resultList = menuEstbsService.selectMenuEstbsMlsfcList(paramVO);
			
			model.addAttribute("resultVO", resultVO);
//            model.addAttribute("resultList", resultList);
		} else {
		    MenuEstbsVO resultVO = new MenuEstbsVO();
		    
			model.addAttribute("resultVO", resultVO);
		}
		model.addAttribute("paramVO", paramVO);
		
		return "wzwg/sysMngr/siteMngr/menuEstbs/menuEstbsForm";
	}

	/**
	 * ㅁ 시스템 - 메뉴설정 그룹 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sysMngr/siteMngr/menuEstbs/registMenuEstbs.do")
	public String registMenuEstbs(@ModelAttribute("paramVO") MenuEstbsVO paramVO
			, HttpServletRequest request
			, ModelMap model) throws Exception{
		
		paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
		paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
		
		// 메뉴설정 그룹 등록
		menuEstbsService.registMenuEstbs(paramVO);
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);

        return "redirect:"+wzwgContext+"/sysMngr/siteMngr/menuEstbs/selectMenuEstbsList.do";
	}

	/**
	 * ㅁ 시스템 - 메뉴설정 그룹 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sysMngr/siteMngr/menuEstbs/modifyMenuEstbs.do")
	public String modifyMenuEstbs(@ModelAttribute("paramVO") MenuEstbsVO paramVO
			, HttpServletRequest request
			, ModelMap model) throws Exception{
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		
		paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
		
		// 메뉴설정 그룹 등록
		menuEstbsService.modifyMenuEstbs(paramVO);
		
	    return "forward:"+wzwgContext+"/sysMngr/siteMngr/menuEstbs/selectMenuEstbsForm.do";
	}

    /**
     * ㅁ 시스템 - 메뉴설정 그룹 등록 폼
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/sysMngr/siteMngr/menuEstbs/selectMenuEstbsMlsfcForm.do")
    public String selectMenuEstbsMlsfcForm(@ModelAttribute("paramVO") MenuEstbsVO paramVO
            , HttpServletRequest request 
            , ModelMap model) throws Exception{

//        // 2차 수정 완료시 1차 상세보기로 보내려고 셋팅
//        paramVO.setSitegrpSeq(paramVO.getUpperGrpSeq());
//    
//        // 수정일경우 상세데이터 가져옴
//        MenuEstbsVO resultVO = menuEstbsService.selectMenuEstbsDetail(paramVO);
//
//        // 2차 그룹 목록
//        String upperGrpSeq = StringUtils.defaultString(resultVO.getSitegrpSeq());
//        
//        paramVO.setUpperGrpSeq(upperGrpSeq);
//
//        // 메뉴설정 2차 그룹 목록
//        List<MenuEstbsVO> resultList = menuEstbsService.selectMenuEstbsMlsfcList(paramVO);
//        
//        model.addAttribute("resultVO", resultVO);
//        model.addAttribute("resultList", resultList);
//        model.addAttribute("paramVO", paramVO);
        
        return "wzwg/sysMngr/siteMngr/menuEstbs/menuEstbsForm";
    }
    
    /**
     * ㅁ  시스템 - 메뉴설정 그룹 목록(selectbox)
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/**/siteMngr/menuEstbs/selectMenuEstbsCodeListAjax.do")
    public ModelAndView selectMenuEstbsCodeListAjax(
            @ModelAttribute("paramVO") MenuEstbsVO paramVO
            , @RequestParam(value="searchBbsSeq", required=false) String searchBbsSeq
            , HttpServletRequest request
        ) throws Exception {
        
        List<MenuEstbsVO> subospecList = menuEstbsService.selectMenuEstbsCodeList(paramVO);
        
        return CmmAjaxUtil.getAjaxReturnList(subospecList, "estbsinfoSeq", "estbsinfoNm", true);
    }
    
    /**
     * ㅁ  시스템 - 사이트 설정 메뉴 셋팅
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/**/siteMngr/menuEstbs/registerMenuEstbsSiteSetAjax.do")
    public ModelAndView registerMenuEstbsSiteSetAjax(
            @ModelAttribute("paramVO") MenuEstbsVO paramVO
            , @RequestParam(value="searchBbsSeq", required=false) String searchBbsSeq
            , HttpServletRequest request
        ) throws Exception {
        
        int result = 0;
        
        // 접속한 시스템사이트SEQ
        String sysSiteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        
        paramVO.setSysSiteSeq("10000000001");
        paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());

        SysMngrSiteAdiInfoVO siteAdiVO = new SysMngrSiteAdiInfoVO();
        siteAdiVO.setSiteSeq(paramVO.getSiteSeq());
        
        try {
            
            String menuEstbsAt = StringUtils.defaultString(siteAdiInfoService.selectSiteMenuEstbsAt(siteAdiVO));
            
            // 메뉴 설정 여부가 N 일떄 실행
            if ("".equals(menuEstbsAt) || "N".equals(menuEstbsAt)) {
                // 메뉴설정여부 Y 변경 - 메뉴초기설정 못하게 막음
                siteAdiVO.setMenuEstbsAt("Y");
                siteAdiInfoService.modifySiteMenuEstbsAt(siteAdiVO);
                
                result = menuEstbsService.registMenuEstbsSiteSetAjax(paramVO);
            } else {
                return CmmAjaxUtil.getAjaxReturnCmmMsgCode(99);
            }
        } catch(NullPointerException e){
	       	 log.error("NullPointerException",e);
	         siteAdiVO.setMenuEstbsAt("N");
	            // 메뉴설정여부 - N 설정으로 변경
	            siteAdiInfoService.modifySiteMenuEstbsAt(siteAdiVO);
	   	}catch(NumberFormatException e){
	   		log.error("NumberFormatException",e);
	   	  siteAdiVO.setMenuEstbsAt("N");
        // 메뉴설정여부 - N 설정으로 변경
        siteAdiInfoService.modifySiteMenuEstbsAt(siteAdiVO);
	   	}catch(IllegalFormatException e){
	   		log.error("IllegalFormatException",e);
	   	  siteAdiVO.setMenuEstbsAt("N");
        // 메뉴설정여부 - N 설정으로 변경
        siteAdiInfoService.modifySiteMenuEstbsAt(siteAdiVO);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		log.error("ArrayIndexOutOfBoundsException",e);
	   	  siteAdiVO.setMenuEstbsAt("N");
        // 메뉴설정여부 - N 설정으로 변경
        siteAdiInfoService.modifySiteMenuEstbsAt(siteAdiVO);
	   	}catch(SQLException e){
 		log.error("ArrayIndexOutOfBoundsException",e);
	   	  siteAdiVO.setMenuEstbsAt("N");
        // 메뉴설정여부 - N 설정으로 변경
        siteAdiInfoService.modifySiteMenuEstbsAt(siteAdiVO);
	   	}    
        
        return CmmAjaxUtil.getAjaxReturnCmmMsgCode(result);
    }
    
    /**
     * ㅁ  시스템 - 사이트 설정 메뉴 셋팅 초기화
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/**/siteMngr/menuEstbs/modifySiteMenuEstbsAtAjax.do")
    public ModelAndView modifySiteMenuEstbsAtAjax(
            @ModelAttribute("paramVO") MenuEstbsVO paramVO
            , @RequestParam(value="searchBbsSeq", required=false) String searchBbsSeq
            , HttpServletRequest request
        ) throws Exception {
        
        int result = 0;
        
        paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
        
        try {
            SysMngrSiteAdiInfoVO siteAdiVO = new SysMngrSiteAdiInfoVO();
            siteAdiVO.setSiteSeq(paramVO.getSiteSeq());
            // 메뉴설정여부 - N 설정으로 변경
            siteAdiVO.setMenuEstbsAt("N");
            siteAdiInfoService.modifySiteMenuEstbsAt(siteAdiVO);
            result = 1;
        } catch(NullPointerException e){
          	 result = 0;
   	   	}catch(NumberFormatException e){
   	   	 result = 0;
   	   	}catch(IllegalFormatException e){
   	   	 result = 0;
   	   	}catch(ArrayIndexOutOfBoundsException e){
   	   	 result = 0;
   	   	} catch(SQLException e){
   		   	 result = 0;
   		} 
        
        return CmmAjaxUtil.getAjaxReturnCmmMsgCode(result);
    }
    
    /**
     * ㅁ 시스템 - 메뉴설정 그룹 등록
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/sysMngr/siteMngr/menuEstbs/modifyMenuEstbsAt.do")
    public String modifyMenuEstbsAt(@ModelAttribute("paramVO") MenuEstbsVO paramVO
            , HttpServletRequest request
            , ModelMap model) throws Exception{
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);

        int result = 0;
        
        try {
            paramVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
            
            // 메뉴설정여부 변경
            result = menuEstbsService.modifyMenuEstbsAt(paramVO);
            
            if (result > 0) {
                model.addAttribute("message", egovMessageSource.getMessage("success.common.update"));
            } else {
                model.addAttribute("message", egovMessageSource.getMessage("fail.common.msg"));
            }
        } catch(NullPointerException e){
        	  model.addAttribute("message", egovMessageSource.getMessage("fail.common.msg"));
  	   	}catch(NumberFormatException e){
  	   	  model.addAttribute("message", egovMessageSource.getMessage("fail.common.msg"));
  	   	}catch(IllegalFormatException e){
  	   	  model.addAttribute("message", egovMessageSource.getMessage("fail.common.msg"));
  	   	}catch(ArrayIndexOutOfBoundsException e){
  	   	  model.addAttribute("message", egovMessageSource.getMessage("fail.common.msg"));
  	   	} catch(SQLException e){
  	   	  model.addAttribute("message", egovMessageSource.getMessage("fail.common.msg"));
  		} catch(IOException e){
  	   	  model.addAttribute("message", egovMessageSource.getMessage("fail.common.msg"));
  		}      

        return "forward:"+wzwgContext+"/sysMngr/siteMngr/menuEstbs/selectMenuEstbsList.do";
    }
}
