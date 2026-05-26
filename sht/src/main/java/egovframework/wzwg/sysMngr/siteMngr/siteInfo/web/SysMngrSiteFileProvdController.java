package egovframework.wzwg.sysMngr.siteMngr.siteInfo.web;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteFileProvdService;

/**
 * ㅁ 시스템 - 사이트정보관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
@Controller
public class SysMngrSiteFileProvdController {

    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

	@Resource(name="SysMngrSiteAdiInfoService")
	private SysMngrSiteAdiInfoService siteAdiInfoService;

	@Resource(name="SysMngrSiteFileProvdService")
	private SysMngrSiteFileProvdService siteFileProvdService;
    
    /**
     * ㅁ 첨부파일 제공용량 화면
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/**/siteMngr/siteInfo/selectSiteFileProvdForm.do")
    public String selectSiteFileProvdForm(
            @ModelAttribute("paramVO") SysMngrSiteAdiInfoVO paramVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {
    	
    	SysMngrSiteAdiInfoVO resultVO = new SysMngrSiteAdiInfoVO();
    	resultVO.setSiteSeq(paramVO.getSiteSeq());
    	
    	model.addAttribute("resultVO", siteAdiInfoService.selectSiteAdiInfoDetail(resultVO));
    	
        return "wzwg/sysMngr/siteMngr/siteInfo/siteFileProvdForm";
    }
    
    /**
     * ㅁ 첨부파일 제공용량 수정
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/**/siteMngr/siteInfo/modifySiteFileProvdAjax.do")
    public ModelAndView modifySiteFileProvdAjax(
            @ModelAttribute("resultVO") SysMngrSiteAdiInfoVO resultVO
            , HttpServletRequest request
            , ModelMap model
        ) throws Exception {
    	
    	int result = 0;
    	
    	resultVO.setLastUpdusrId(CmmSessionUtil.getSessionUserId());
    	
    	result = siteFileProvdService.modifySiteFileProvd(resultVO);	// 저장
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
    }
	
}
