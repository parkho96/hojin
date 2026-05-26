package egovframework.wzwg.module.stplat.web;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatSimpService;

/**
 * ㅁ 시스템 - 사이트약관정보관리
 * ㅁ DC   
 * - 시스템관리자가 각 사이트 약관정보을 관리
 * - 전체 시스템에서 사용할 약관정보 관리
 * @author HyoJuNiRaNe
 *
 */
@Controller
public class ModuleStplatController {

    @Resource(name="SiteStplatInfoService")
    private SiteStplatInfoService siteStplatInfoService;

    @Resource(name="SiteStplatSimpService")
    private SiteStplatSimpService siteStplatSimpService;

    /**
     * ㅁ 시스템 - 약관 초기화면(사용자)
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/**/module/stplat/selectStplatInc.do")
    public String selectStplatInc(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
            , HttpServletRequest request 
            , ModelMap model) throws Exception{

        

        return "wzwg/module/stplat/stplatInc";
    }
    
    /**
     * ㅁ 시스템 - 정책 초기화면(사용자)
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/**/module/stplat/selectPolicyInc.do")
    public String selectPolicyInc(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
            , HttpServletRequest request 
            , ModelMap model) throws Exception{

        

        return "wzwg/module/stplat/policyInc";
    }
    
    /**
     * ㅁ 시스템 - 사이트 약관 미리보기
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value="/stplat/{stplatSeq}")
    public String selectStplatDetailBySeq(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
            , @PathVariable(value="stplatSeq") String stplatSeq
            , HttpServletRequest request 
            , ModelMap model) throws Exception{

        paramVO.setStplatSeq(stplatSeq);
        
        // 상세데이터 가져옴
       // List<SiteStplatInfoVO> resultList = siteStplatInfoService.selectStplatDetailBySeq(paramVO);

      //  model.addAttribute("resultList", resultList);
        
        // 상세데이터 가져옴
        SiteStplatInfoVO resultVO = siteStplatSimpService.selectStplatSimpBySeq(paramVO);

        model.addAttribute("resultVO", resultVO);

        return "wzwg/module/stplat/stplatDetail";
    }
    
}
