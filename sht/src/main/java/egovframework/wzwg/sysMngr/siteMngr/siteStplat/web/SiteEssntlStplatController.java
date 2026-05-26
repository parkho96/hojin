package egovframework.wzwg.sysMngr.siteMngr.siteStplat.web;

import java.util.HashMap;
import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.service.Globals;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteEssntlStplatService;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteEssntlStplatVO;

/**
 * ㅁ 시스템 - 사이트필수약관설정
 * ㅁ DC   
 * - 가입/개인정보처리방침/사이트사용약관 등 필수 적으로 동의를 받아야되는 약관을 설정한다
 * @author HyoJuNiRaNe
 *
 */
@Controller
public class SiteEssntlStplatController {

    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

	@Resource(name="SiteEssntlStplatService")
	private SiteEssntlStplatService siteEssntlStplatService;
    
    /**
     * ㅁ 시스템 - 사이트 약관정보 목록
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/**/siteMngr/siteStplat/info/selectEssntlStplatInfoList.do")
    public String selectEssntlStplatInfoList(@ModelAttribute("paramVO") SiteEssntlStplatVO paramVO
            , HttpServletRequest request 
            , ModelMap model) throws Exception{
        
        String siteSeq = StringUtils.defaultString(paramVO.getSiteSeq());
        
        // 시스템 관리자 - 사이트 관리자에 따른 사이트SEQ 설정
        if ("".equals(siteSeq)) {
            
            if (!CmmSessionUtil.getSessionSysMngrAt(request)) {
                siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
                
                paramVO.setSiteSeq(siteSeq);
            }
        } else {
            model.addAttribute("siteSeq", paramVO.getSiteSeq());   
        }
        
        // 약관코드
        paramVO.setStplatTyCode(Globals.ESSNTL_STPLAT_CODE);
        
        // 사이트 필수 약관 목록
        List<SiteEssntlStplatVO> resultList = siteEssntlStplatService.selectSiteEssntlStplatInfoList(paramVO);
//        selectSiteEssntlStplatCode
        
        HashMap<String, List<SiteEssntlStplatVO>> resultMap = new HashMap<String, List<SiteEssntlStplatVO>>();
        
        // 등록된 약관을 코드화 시켜서 넘긴다
        if (resultList != null) {
            
            for (int i=0; i<resultList.size(); i++) {
                SiteEssntlStplatVO getVO = (SiteEssntlStplatVO)resultList.get(i);
                
                paramVO.setStplatTyCode(getVO.getStplatTyCode());
                
                // 약관유형별로 map에 담는다
                List<SiteEssntlStplatVO> getList = siteEssntlStplatService.selectSiteEssntlStplatCode(paramVO);
                
                resultMap.put(getVO.getStplatTyCode(), getList);
            }
        }
        
        model.addAttribute("resultList", resultList);
        model.addAttribute("resultMap", resultMap);
        
        return "wzwg/sysMngr/siteMngr/siteInfo/siteEssntlSbscrbList";
    }

    /**
     * ㅁ 시스템 - 사이트 약관정보 저장
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/**/siteMngr/siteStplat/info/registEssntlStplatAjax.do")
    public ModelAndView registEssntlStplatAjax(@ModelAttribute("paramVO") SiteEssntlStplatVO paramVO
            , HttpServletRequest request) throws Exception{
        
        // 저장 요청자 ID
        paramVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
        
        // 사이트 약관정보매핑 등록
        int result = siteEssntlStplatService.registEssntlStplat(paramVO);
        
        return CmmAjaxUtil.getAjaxReturnCmmMap(result);
    }

}
