package egovframework.wzwg.module.stplatLog.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatLogService;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatLogVO;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatSimpService;

@Controller
public class ModuleStplatLogController {
	
	@Resource(name="SiteStplatInfoService")
	private SiteStplatInfoService siteStplatInfoService;

	@Resource(name="SiteStplatSimpService")
	private SiteStplatSimpService stplatSimpService;

	@Resource(name="SiteStplatLogService")
	private SiteStplatLogService siteStplatLogService;

	/************************* 2019.03.05  start **********************************/

	@RequestMapping(value={"/module/stplatLog/selectStplatLogListFormAjax.do","/{siteKey}/module/stplatLog/selectStplatLogListFormAjax.do","/module/stplatLog/selectStplatLogList.do","/{siteKey}/module/stplatLog/selectStplatLogList.do"})
    public String selectStplatLogList(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
            , HttpServletRequest request 
            , ModelMap model) throws Exception{
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        paramVO.setStplatTyCode("SC00000453"); // 약관코드 
        String stplatTyCode = paramVO.getStplatTyCode();
        paramVO.setSiteSeq(siteSeq);
        paramVO.setFirstIndex(0);
        paramVO.setRecordCountPerPage(10000);

        List<SiteStplatInfoVO> resultList = siteStplatInfoService.selectSiteStplatInfoList(paramVO);
        
        String tempStplatSeq = "";
        String tempStplatNum = "";
        
        if(resultList.size() > 0 && !resultList.isEmpty() && resultList != null){
	        if(!("").equals(StringUtils.defaultString(paramVO.getStplatSeq()))){
	        	tempStplatSeq = paramVO.getStplatSeq();
	        	for(int i=0; i<resultList.size(); i++){
	        		if(resultList.get(i).getStplatSeq() != null && resultList.get(i).getStplatSeq().equals(tempStplatSeq)){
	        			tempStplatNum = String.valueOf(i+1);
	        		}
	        	}
	        }else{
	        	tempStplatSeq = resultList.get(0).getStplatSeq();
	        	tempStplatNum = "1";
	        }
        }
        
        model.addAttribute("stplatTyCode", stplatTyCode);
        model.addAttribute("paramStplatSeq",tempStplatSeq);
        model.addAttribute("paramStplatNum",tempStplatNum);

        model.addAttribute("resultList", resultList);
        
        return "wzwg/module/stplatLog/stplatLogList";
    }
	

    @RequestMapping(value={"/module/stplatLog/selectPolicyLogListFormAjax.do","/{siteKey}/module/stplatLog/selectPolicyLogListFormAjax.do","/module/stplatLog/selectPolicyLogList.do","/{siteKey}/module/stplatLog/selectPolicyLogList.do"})
    public String selectPolicyLogList(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
            , HttpServletRequest request 
            , ModelMap model) throws Exception{
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        paramVO.setStplatTyCode("SC00000454"); // 정책코드
        String stplatTyCode = paramVO.getStplatTyCode();
        paramVO.setSiteSeq(siteSeq);
        paramVO.setFirstIndex(0);
        paramVO.setRecordCountPerPage(10000);

        List<SiteStplatInfoVO> resultList = siteStplatInfoService.selectSiteStplatInfoList(paramVO);
        
        String tempStplatSeq = "";
        String tempStplatNum = "";
        
        if(resultList.size() > 0 && !resultList.isEmpty() && resultList != null){
	        if(!("").equals(StringUtils.defaultString(paramVO.getStplatSeq()))){
	        	tempStplatSeq = paramVO.getStplatSeq();
	        	for(int i=0; i<resultList.size(); i++){
	        		if(resultList.get(i).getStplatSeq() != null && resultList.get(i).getStplatSeq().equals(tempStplatSeq)){
	        			tempStplatNum = String.valueOf(i+1);
	        		}
	        	}
	        }else{
	        	tempStplatSeq = resultList.get(0).getStplatSeq();
	        	tempStplatNum = "1";
	        }
        }
        
        model.addAttribute("stplatTyCode", stplatTyCode);
        model.addAttribute("paramStplatSeq",tempStplatSeq);
        model.addAttribute("paramStplatNum",tempStplatNum);

        model.addAttribute("resultList", resultList);
        
        return "wzwg/module/stplatLog/stplatLogList";
    }
	
	@RequestMapping(value= {"/module/stplatLog/selectStplatLogListAjax.do","/{siteKey}/module/stplatLog/selectStplatLogListAjax.do"})
    public String selectStplatLogListAjax(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
            , HttpServletRequest request 
            , ModelMap model) throws Exception{
		
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        paramVO.setSiteSeq(siteSeq);
        
        List<SiteStplatInfoVO> resultList = stplatSimpService.selectSiteStplatSimpList(paramVO);

        model.addAttribute("resultList", resultList);

        
        return "wzwg/module/stplatLog/stplatLogListAjax";
    }
	
	/************************* 2019.03.05  end **********************************/
	

    @RequestMapping(value= {"/module/stplatLog/selectStplatPrivate.do","/{siteKey}/module/stplatLog/selectStplatPrivate.do"})
    public String selectStplatPrivate(@ModelAttribute("paramVO") SiteStplatInfoVO paramVO
            , HttpServletRequest request 
            , ModelMap model) throws Exception{
        
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);

        paramVO.setSiteSeq(siteSeq);
        paramVO.setStplatTyCode("SC00000025");

        List<SiteStplatInfoVO> resultList = siteStplatLogService.selectSiteStplatSimpList(paramVO);

        model.addAttribute("resultList", resultList);
        
        return "wzwg/module/stplatLog/stplatPrivate";
    }
    
    @RequestMapping(value= {"/module/stplatLog/selectStplatLog.do","/{siteKey}/module/stplatLog/selectStplatLog.do"})
    public String selectStplatLog(@ModelAttribute("paramVO") SiteStplatLogVO paramVO
            , HttpServletRequest request 
            , ModelMap model) throws Exception{
        
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        
        paramVO.setSiteSeq(siteSeq);
        
        CmmLoginVO loginVO = CmmSessionUtil.getLoginVO();
        
        if (loginVO != null) {
            paramVO.setUsrSeq(loginVO.getUsrSeq());    
        }

        // 사이트 약관정보 목록
        List<SiteStplatLogVO> resultList = siteStplatLogService.selectSiteStplatLog(paramVO);
        
        model.addAttribute("resultList", resultList);
        
        return "wzwg/module/stplatLog/stplatLog";
    }

    @RequestMapping(value= {"/module/stplatLog/selectStplatLogDetailAjax.do","/{siteKey}/module/stplatLog/selectStplatLogDetailAjax.do"})
    public String selectStplatLogDetailAjax(@ModelAttribute("paramVO") SiteStplatLogVO paramVO
            , HttpServletRequest request 
            , ModelMap model) throws Exception{
        
        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
        
        paramVO.setSiteSeq(siteSeq);

        // 사이트 약관정보 목록
        SiteStplatLogVO resultVO = siteStplatLogService.selectSiteStplatSimpDetail(paramVO);
        
        model.addAttribute("resultVO", resultVO);
        
        return "wzwg/module/stplatLog/stplatLogDetailAjax";
    }

}
