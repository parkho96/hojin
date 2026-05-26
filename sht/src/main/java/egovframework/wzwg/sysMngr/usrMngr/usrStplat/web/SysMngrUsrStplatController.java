package egovframework.wzwg.sysMngr.usrMngr.usrStplat.web;

import java.util.List;

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

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.ajax.AjaxXmlView;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoService;
import egovframework.wzwg.sysMngr.usrMngr.usrStplat.service.SysMngrUsrStplatService;
import egovframework.wzwg.sysMngr.usrMngr.usrStplat.service.SysMngrUsrStplatVO;
import net.sourceforge.ajaxtags.xml.AjaxXmlBuilder;

/**
 * ㅁ 시스템 - 사용자관리 - 약관관리
 * ㅁ DC   
 * - 시스템관리자가 가입정보를 관리
 * - 생선된 사용자는 사용자 관리자 페이지를 이용하여 접속
 * @author 김c
 *
 */
@Controller
public class SysMngrUsrStplatController {

    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

	@Resource(name="SysMngrUsrStplatService")
	private SysMngrUsrStplatService usrStplatService;

	@Resource(name="SysMngrSiteInfoService")
	private SysMngrSiteInfoService siteInfoService;
	
	/**
	 * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/usrMngr/usrStplat/selectUsrStplatList.do")
	public String selectUsrStplatList(
			@ModelAttribute("paramVO") SysMngrUsrStplatVO paramVO
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
		
		// 가입 약관 목록
		List<SysMngrUsrStplatVO> resultList = usrStplatService.selectUsrStplatList(paramVO);
		
		// 가입 약관 목록 총 갯수
		Integer resultCnt = usrStplatService.selectUsrStplatListTotCnt(paramVO);
		
		paginationInfo.setTotalRecordCount(resultCnt.intValue());
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", resultCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "wzwg/sysMngr/usrMngr/usrStplat/usrStplatList";
	}
    
    /**
     * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 목록
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/sysMngr/usrMngr/usrStplat/selectSysUsrStplatList.do")
    public String selectSysUsrStplatList(
            @ModelAttribute("paramVO") SysMngrUsrStplatVO paramVO
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
        
        // 가입 약관 목록
        List<SysMngrUsrStplatVO> resultList = usrStplatService.selectSysUsrStplatList(paramVO);
        
        // 가입 약관 목록 총 갯수
        Integer resultCnt = usrStplatService.selectSysUsrStplatListCnt(paramVO);
        
        paginationInfo.setTotalRecordCount(resultCnt.intValue());
        
        model.addAttribute("resultList", resultList);
        model.addAttribute("resultCnt", resultCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "wzwg/sysMngr/usrMngr/usrStplat/sysUsrStplatList";
    }
    
    /**
     * ㅁ 시스템 - 사용자관리 - 가입약관관리 - 목록
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/sysMngr/usrMngr/usrStplat/selectSysUsrStplatForm.do")
    public String selectSysUsrStplatForm(
            @ModelAttribute("paramVO") SysMngrUsrStplatVO paramVO
            , HttpServletRequest request 
            , ModelMap model
        ) throws Exception{

        String usrStplatSeq = StringUtils.defaultString(paramVO.getUsrstplatSeq());
        
        SysMngrUsrStplatVO resultVO = null;
        List<SysMngrUsrStplatVO> resultHistList = null;
        
        if (!"".equals(usrStplatSeq)) {
            
            // 가입 약관 목록
            resultVO = usrStplatService.selectSysUsrStplat(paramVO);
            
            model.addAttribute("resultVO", resultVO);
            
            // 가입 약관 목록
            resultHistList = usrStplatService.selectSysUsrStplatHistList(paramVO);
            
            model.addAttribute("resultHistList", resultHistList);
        }
        
        model.addAttribute("resultVO", resultVO);
        model.addAttribute("resultHistList", resultHistList);
        
        return "wzwg/sysMngr/usrMngr/usrStplat/sysUsrStplatForm";
    }
    
    @RequestMapping(value="/sysMngr/usrMngr/usrStplat/registSysUsrStplat.do")
    public ModelAndView registSysUsrStplat(
            @ModelAttribute("paramVO") SysMngrUsrStplatVO paramVO
            , HttpServletRequest request 
            , ModelMap model) throws Exception {
        
        /** 로그인 한 사용자 입력 */
        CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        paramVO.setUserId(loginVO.getUserId());
        
        int result = usrStplatService.registSysUsrStplat(paramVO);
        
        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        if(result < 1){
            ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "fail").toString());
        }else{
            ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        }
        
        return ajaxModel;
    }
    
    @RequestMapping(value="/sysMngr/usrMngr/usrStplat/modifySysUsrStplat.do")
    public ModelAndView modifySysUsrStplat(
            @ModelAttribute("paramVO") SysMngrUsrStplatVO paramVO
            , HttpServletRequest request 
            , ModelMap model) throws Exception {
        
        /** 로그인 한 사용자 입력 */
        CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        paramVO.setUserId(loginVO.getUserId());
        
        int result = usrStplatService.modifySysUsrStplat(paramVO);
        
        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        if(result < 1){
            ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "fail").toString());
        }else{
            ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        }
        
        return ajaxModel;
    }
    
    @RequestMapping(value="/sysMngr/usrMngr/usrStplat/deleteSysUsrStplat.do")
    public ModelAndView deleteSysUsrStplat(
            @ModelAttribute("paramVO") SysMngrUsrStplatVO paramVO
            , HttpServletRequest request 
            , ModelMap model) throws Exception {
        
        /** 로그인 한 사용자 입력 */
        CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        paramVO.setUserId(loginVO.getUserId());
        
        int result = usrStplatService.deleteSysUsrStplat(paramVO);
        
        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        if(result < 1){
            ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "fail").toString());
        }else{
            ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        }
        
        return ajaxModel;
    }
    
    @RequestMapping(value="/sysMngr/usrMngr/usrStplat/deleteSysUsrStplatHist.do")
    public ModelAndView deleteSysUsrStplatHist(
            @ModelAttribute("paramVO") SysMngrUsrStplatVO paramVO
            , HttpServletRequest request 
            , ModelMap model) throws Exception {
        
        /** 로그인 한 사용자 입력 */
        CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
        paramVO.setUserId(loginVO.getUserId());
        
        int result = usrStplatService.deleteSysUsrStplatHist(paramVO);
        
        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        if(result < 1){
            ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "fail").toString());
        }else{
            ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        }
        
        return ajaxModel;
    }

}
