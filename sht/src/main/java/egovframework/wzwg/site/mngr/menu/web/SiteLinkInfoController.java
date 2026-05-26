package egovframework.wzwg.site.mngr.menu.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.IllegalFormatException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.com.utl.fcc.service.ExcelParser;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmJsonAjaxResponser;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.menu.service.SiteLinkGrpInfoVO;
import egovframework.wzwg.site.mngr.menu.service.SiteLinkInfoService;

@Controller
public class SiteLinkInfoController {
    
//    @Resource(name="LinkInfoInfoService")
//    private ModuleLinkInfoInfoService LinkInfoInfoService;
    
    @Resource(name="LinkInfoService")
    private SiteLinkInfoService linkInfoService;
    
//    @Resource(name="CmmCodeService")
//    private CmmCodeService codeService;

    @RequestMapping(value="/**/menu/linkGrp/selectLinkGrpMapListAjax.do")
    public String selectLinkGrpMapListAjax(
            @ModelAttribute("paramVO") SiteLinkGrpInfoVO paramVO
            , HttpServletRequest request
            , Model model
            ){
        
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        
        List<SiteLinkGrpInfoVO> resultList = linkInfoService.selectLinkGrpMapListAjax(paramVO);
        
        model.addAttribute("resultList", resultList);
        
        return "wzwg/site/mngr/menu/linkGrp/linkGrpMapListAjax";
    }

    @RequestMapping(value="/**/menu/linkGrp/selectLinkInfoDetailMngrAjax.do")
    public String selectLinkInfoDetailMngrAjax(
            @ModelAttribute("paramVO") SiteLinkGrpInfoVO paramVO
            , HttpServletRequest request
            , Model model
            ){
        
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
        paginationInfo.setPageSize(paramVO.getPageSize());
       
        paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
        paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        Integer totCnt = linkInfoService.selectLinkInfoListCnt(paramVO);
        paginationInfo.setTotalRecordCount(totCnt.intValue());
        
        List<SiteLinkGrpInfoVO> resultList = linkInfoService.selectLinkInfoList(paramVO);
        
        model.addAttribute("resultList", resultList);
        model.addAttribute("totCnt", totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "wzwg/site/mngr/menu/linkGrp/linkInfoDetailMngr";
    }

    @RequestMapping(value="/**/menu/linkGrp/selectLinkInfoListMngrAjax.do")
    public String selectLinkInfoListMngrAjax(
            @ModelAttribute("paramVO") SiteLinkGrpInfoVO paramVO
            , HttpServletRequest request
            , Model model
            ){
        
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
        paginationInfo.setPageSize(5);
       
        paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
        paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        Integer totCnt = linkInfoService.selectLinkInfoListCnt(paramVO);
        paginationInfo.setTotalRecordCount(totCnt.intValue());
        
        List<SiteLinkGrpInfoVO> resultList = linkInfoService.selectLinkInfoList(paramVO);
        
        model.addAttribute("resultList", resultList);
        model.addAttribute("totCnt", totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        
        return "wzwg/site/mngr/menu/linkGrp/linkInfoDetailMngrAjax";
    }
    
    @RequestMapping(value="/**/menu/linkGrp/selectLinkInfoDetailMngrFormAjax.do")
    public String selectLinkInfoDetailMngrFormAjax(
            @ModelAttribute("paramVO") SiteLinkGrpInfoVO paramVO
            , HttpServletRequest request
            , Model model
            ){
        
        String linkSeq = StringUtils.defaultString(paramVO.getLinkSeq());
        
        if (!"".equals(linkSeq)) {
            SiteLinkGrpInfoVO resultVO = linkInfoService.selectLinkInfoDetail(paramVO);
            
            model.addAttribute("resultVO", resultVO);
        } else {
            model.addAttribute("resultVO", new SiteLinkGrpInfoVO());
        }
        
        return "wzwg/site/mngr/menu/linkGrp/linkInfoDetailMngrFormAjax";
    }

    @RequestMapping(value="/**/menu/linkGrp/registLinkInfoAjax.do")
    public ModelAndView registLinkInfoAjax(@ModelAttribute("paramVO") SiteLinkGrpInfoVO paramVO
            , HttpServletRequest request
            , ModelMap model) throws Exception{
        
        paramVO.setUserId(CmmSessionUtil.getSessionUserId());
        
        int result = linkInfoService.registLinkInfo(paramVO);
        
        return CmmAjaxUtil.getAjaxReturnCmmMap(result);
    }

    @RequestMapping(value="/**/menu/linkGrp/modifyLinkInfoAjax.do")
    public ModelAndView modifyLinkInfoAjax(@ModelAttribute("paramVO") SiteLinkGrpInfoVO paramVO
            , HttpServletRequest request
            , ModelMap model) throws Exception{
        
        paramVO.setUserId(CmmSessionUtil.getSessionUserId());
        
        int result = linkInfoService.modifyLinkInfo(paramVO);
        
        return CmmAjaxUtil.getAjaxReturnCmmMap(result);
    }
    
    @RequestMapping(value="/**/menu/linkGrp/registLinkGrpAjax.do")
    public ModelAndView registLinkGrpAjax(@ModelAttribute("paramVO") SiteLinkGrpInfoVO paramVO
            , HttpServletRequest request
            , ModelMap model) throws Exception{
        
        paramVO.setUserId(CmmSessionUtil.getSessionUserId());
        
        int result = linkInfoService.registLinkGrp(paramVO);
        
        return CmmAjaxUtil.getAjaxReturnCmmMap(result);
    }
    
    @RequestMapping(value="/**/menu/linkGrp/deleteLinkGrpAjax.do")
    public ModelAndView deleteLinkGrpAjax(@ModelAttribute("paramVO") SiteLinkGrpInfoVO paramVO
            , HttpServletRequest request
            , ModelMap model) throws Exception{
        
        int result = linkInfoService.deleteLinkGrp(paramVO);
        
        return CmmAjaxUtil.getAjaxReturnCmmMap(result);
    }

    @RequestMapping(value="/**/menu/linkGrp/deleteLinkInfoAjax.do")
    public ModelAndView deleteLinkInfoAjax(@ModelAttribute("paramVO") SiteLinkGrpInfoVO paramVO
            , HttpServletRequest request
            , ModelMap model) throws Exception{
        
        paramVO.setUserId(CmmSessionUtil.getSessionUserId());
        
        int result = linkInfoService.deleteLinkInfo(paramVO);
        
        return CmmAjaxUtil.getAjaxReturnCmmMap(result);
    }

    @RequestMapping(value="/**/menu/linkGrp/selectLinkUrlListAjax.do")
    public ModelAndView selectLinkUrlList(
            @ModelAttribute("paramVO") SiteLinkGrpInfoVO paramVO
            , HttpServletRequest request
            , Model model ) throws Exception {
        
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        
        List<SiteLinkGrpInfoVO> resultList = linkInfoService.selectLinkUrlList(paramVO);
        
        return CmmAjaxUtil.getAjaxReturnList(resultList, "linkUrl", "linkNm", true);
    }

    
    @RequestMapping(value="/**/menu/linkGrp/modifySiteLinkGrpOrdrAjax.do")
    public String modifySiteLinkGrpOrdrAjax(
            @ModelAttribute("paramVO") SiteLinkGrpInfoVO paramVO
            , HttpServletRequest request
            , Model model ) throws Exception {
        
    	CmmLoginVO loginVO = (CmmLoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
        paramVO.setLastUpdusrId(loginVO.getUserId());
        paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
        int result = linkInfoService.modifySiteLinkGrpOrdr(paramVO);
        if(result > 0)
            return CmmJsonAjaxResponser.getInstance().setResultCode("success").returnJsp(model);
        else
            return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
    }

    @RequestMapping(value="/**/menu/linkGrp/redistLinkInfoExcelUploadAjax.do")
    public String redistLinkInfoExcelUploadAjax( @ModelAttribute("paramVO") SiteLinkGrpInfoVO paramVO
    		, final MultipartHttpServletRequest multiRequest	
            , HttpServletRequest request
            , Model model ) throws Exception {
    	
		/** 사이트시퀀스,로그인 한 사용자 입력 */
    	String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();		
		paramVO.setLastUpdusrId(loginVO.getUserId());
		paramVO.setFrstRegisterId(loginVO.getUserId());		
		
		int resultCnt = 0;
		int errorCode = 0;		//errorCode 0 정상, 1 에러
		
		final Map<String, MultipartFile> files = multiRequest.getFileMap();

        Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
        MultipartFile file = null;	

        try
        {
            while(itr.hasNext()) 
            {
            	Entry<String, MultipartFile> entry = itr.next();
            	  
                file = entry.getValue();
             	
                ExcelParser ep = new ExcelParser(file);
	            	
                ArrayList<ArrayList<String>> excelList = ep.getExcel(); 

                for (int j = 0; j < excelList.size(); j++) {

                	String linkNm = excelList.get(j).get(0);        
                	String linkDc = excelList.get(j).get(1);       
                	String linkUrl = excelList.get(j).get(2);
                	
                    SiteLinkGrpInfoVO rowData = new SiteLinkGrpInfoVO();
                    
                    rowData.setSiteSeq(siteSeq);
                    rowData.setLinkNm(linkNm);
                    rowData.setLinkDc(linkDc);
                    rowData.setLinkUrl(linkUrl);
                    rowData.setUserId(CmmSessionUtil.getLoginVO().getUserId());
                    
                    if(linkInfoService.registLinkInfo(rowData) > 0) {
                    	resultCnt++;	
                    }
                }

            }
    	} catch(NullPointerException e){
    		errorCode = 1;
	   	}catch(NumberFormatException e){
	   		errorCode = 1;
	   	}catch(IllegalFormatException e){
	   		errorCode = 1;
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		errorCode = 1;
	   	}catch(IOException e){
	   		errorCode = 1;
	   	}
        
		if(errorCode == 0){
				return CmmJsonAjaxResponser.getInstance().setResultCode("success").setBodyData("resultCnt", resultCnt).returnJsp(model);
		} else {
			return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
		}
    }
}
