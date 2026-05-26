package egovframework.wzwg.sysMngr.siteMngr.siteInfo.web;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.IllegalFormatException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
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
 * ㅁ 시스템 - 사이트부가정보관리
 * ㅁ DC   
 * - 사이트 부가정보 관리
 * @author HyoJuNiRaNe
 *
 */
@Controller
@Slf4j
public class SysMngrSiteAdiInfoController {

    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

	/** 모듈첨부파일UTIL **/
    @Resource(name="ModuleUploadFileUtil")
    protected ModuleUploadFileUtil fileUtil;
	
    @Resource(name = "ModuleUploadFileService")
    protected ModuleUploadFileService fileService;
	
	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;

	@Resource(name="SysMngrSiteAdiInfoService")
	private SysMngrSiteAdiInfoService siteAdiInfoService;

    @Resource(name="SiteGroupService")
    private SiteGroupService siteGroupService;

    /** 메뉴설정 **/
    @Resource(name="MenuEstbsService")
    private MenuEstbsService menuEstbsService;
    
    /**
     * 학교분류코드
     * @return 코드 목록
     * @throws Exception 
     */
//    @ModelAttribute("siteClCodeList")
//    public List<CmmCodeVO> getSiteClCodeList() throws Exception {
//        
//        String grpCode = "SITE_CL_CODE";
//        
//        List<CmmCodeVO> resultCodeLIst = codeService.selectCmmCodeList(grpCode);
//        
//        return resultCodeLIst;
//    }

    /**
     * 사이트 대분류 코드
     * @return 코드 목록
     * @throws Exception 
     */
    @ModelAttribute("siteLclasGroupList")
    public List<SiteGroupVO> getSiteClList() throws Exception {
        
        SiteGroupVO paramVO = new SiteGroupVO();
        
        // 1차
        paramVO.setOdr("1");
        
        List<SiteGroupVO> resultList = siteGroupService.selectSiteGroupAjax(paramVO);
        
        return resultList;
    }
	
	/**
	 * ㅁ 시스템 - 사이트 부가정보 등록 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/siteMngr/siteInfo/selectSiteAdiInfoForm.do","/${siteSeq}/**/siteMngr/siteInfo/selectSiteAdiInfoForm.do"})
	public String selectSiteAdiInfoForm(@ModelAttribute("paramVO") SysMngrSiteAdiInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		
		// 수정일경우 상세데이터 가져옴
		SysMngrSiteAdiInfoVO resultVO = siteAdiInfoService.selectSiteAdiInfoDetail(paramVO);

		if (resultVO != null) {
			model.addAttribute("resultVO", resultVO);
		} else {
			model.addAttribute("resultVO", new SysMngrSiteAdiInfoVO());
		}
        
        MenuEstbsVO meVO = new MenuEstbsVO();
        
        List<MenuEstbsVO> menuEstbsList = menuEstbsService.selectMenuEstbsCodeList(meVO);
        
        model.addAttribute("menuEstbsList", menuEstbsList);
		model.addAttribute("paramVO", paramVO);
		
		return "wzwg/sysMngr/siteMngr/siteInfo/siteAdiInfoForm";
	}
	
	 @RequestMapping(value="/**/siteMngr/siteInfo/siteFtrMenuJsonAjax.do")
	    public ModelAndView scrinMenuJsonAjax (
                @ModelAttribute("paramVO") SysMngrSiteAdiInfoVO paramVO
            , HttpServletRequest request ) throws Exception {
            ModelAndView model = new ModelAndView();
         try{
            String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
            
            paramVO.setSiteSeq(siteSeq); 
            // 컨텐츠 데이터를 가져옴
         //   List<SiteHdftrMenuVO> resultList = siteHdftrMenuService.selectSiteHdftrMenuList(paramVO);

       
            model.setViewName("jsonView");
            // 컨텐츠 데이터를 JSON 변환하여 넘김
            model.addObject("ftrMenuInfo", siteAdiInfoService.selectSiteFtrInfoDetail(paramVO));
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
            return model;
        }

	/**
	 * ㅁ 시스템 - 사이트 부가정보 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/siteInfo/registSiteAdiInfo.do")
	public String registSiteAdiInfo(@ModelAttribute("paramVO") SysMngrSiteAdiInfoVO paramVO
			, HttpServletRequest request
			, ModelMap model) throws Exception{
        List<ModuleUploadFileVO> result = null;
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
        
        MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;
        
        String logoImagePath = "";
        String copylightLogoImagePath = "";
        String sIconImagePath="";
        
        if(!"".equals(paramVO.getLogoTImagePath())){
        	logoImagePath = paramVO.getLogoTImagePath();
        }
	
		if(!"".equals(paramVO.getLogoFImagePath())){
			copylightLogoImagePath = paramVO.getLogoFImagePath();
		}
		
		if(!"".equals(paramVO.getIconSImagePath())){
			sIconImagePath= paramVO.getIconSImagePath();
		}
        
        
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    
	    Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	    
 	    while (itr.hasNext()) {
	    	Entry<String, MultipartFile> entry = itr.next();
	    	Map<String, MultipartFile> file = new HashMap<String, MultipartFile>();
	    	
	    	file.put(entry.getKey(), entry.getValue());
	    	
	    	if (!file.isEmpty()) {
	    		
	    		result = fileUtil.parseFileInf(file, "LOG_", 0, "Globals.mdFilePath", "Globals.WhiteImgFileExt", multiRequest, "siteAdiInfo", null, CmmSessionUtil.getSessionSiteSeq(request));
	    		
	    		if("tLogoFile".equals(result.get(0).getName())) {
	    			logoImagePath = fileService.insertFileInfs(result)+"";
	    		} else if("fLogoFile".equals(result.get(0).getName())) {
	    			copylightLogoImagePath = fileService.insertFileInfs(result)+"";
	    		}else if("sIconFile".equals(result.get(0).getName())) {
	    			sIconImagePath = fileService.insertFileInfs(result)+"";
	    		}
	    		
	    	}
	    }
        
 	    paramVO.setLogoTImagePath(logoImagePath);
 	    paramVO.setLogoFImagePath(copylightLogoImagePath);
 	    paramVO.setIconSImagePath(sIconImagePath);
		
		// 사이트 부가정보 등록
		siteAdiInfoService.registSiteAdiInfo(paramVO);
		
		return "forward:"+wzwgContext+CmmSessionUtil.getSessionMngrSitePrefix(request)+"/siteMngr/siteInfo/selectSiteAdiInfoForm.do";
	}
	
}
