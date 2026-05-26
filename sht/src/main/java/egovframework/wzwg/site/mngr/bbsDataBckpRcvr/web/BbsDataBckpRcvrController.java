package egovframework.wzwg.site.mngr.bbsDataBckpRcvr.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.IllegalFormatException;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.utl.fcc.service.ExcelCreater;
import egovframework.com.utl.fcc.service.ExcelParser;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.site.mngr.bbsDataBckpRcvr.service.BbsDataBckpRcvrService;
import egovframework.wzwg.site.mngr.bbsDataBckpRcvr.service.BbsDataBckpRcvrVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;

@Controller
public class BbsDataBckpRcvrController {

    /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
    
    /** BbsDataBckpRcvrService */
    @Resource(name="BbsDataBckpRcvrService")
    protected BbsDataBckpRcvrService bbsDataBckpRcvrService;


	/**
	 * 게시물 데이터 백업 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/siteMngr/bbsDataBckpRcvr/selectBbsDataBckpForm.do","/{siteKey}/**/siteMngr/bbsDataBckpRcvr/selectBbsDataBckpForm.do"})
	public String selectBbsDataBckpForm(@ModelAttribute("paramVO") BbsDataBckpRcvrVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
		List<CntntsInfoVO> resultList = bbsDataBckpRcvrService.selectBbsModuleList();

		paramVO.setBbsSeq((String) request.getParameter("cntntsSeq"));
		
		model.addAttribute("bbsModuleList", resultList);		
    	
		return "wzwg/site/mngr/bbsDataBckpRcvr/bbsDataBckpForm";
	}	
	
	/**
	 * 게시판 목록(선택)
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/siteMngr/bbsDataBckpRcvr/selectBbsListAjax.do")
    public ModelAndView selectBbsList(
            @ModelAttribute("paramVO") CntntsInfoVO paramVO
            , HttpServletRequest request
        ) throws Exception {

    	List<CntntsInfoVO> resultList = bbsDataBckpRcvrService.selectBbsList(paramVO);
        
        return CmmAjaxUtil.getAjaxReturnList(resultList, "cntntsSeq", "cntntsNm", true);
    }	

	/**
	 * 게시물 데이터 백업 엑셀
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/bbsDataBckpRcvr/selectBbsDataBckpExcel.do")
	public void selectBbsDataBckpExcel(@ModelAttribute("paramVO") BbsDataBckpRcvrVO paramVO
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception{
		
		/*
		 * unity, qna, mvp, simp
		 */
		String moduleSe = bbsDataBckpRcvrService.selectModuleBbsSe(paramVO);

		if(moduleSe != null) {
			
			paramVO.setModuleSe(moduleSe);
			
			List<BbsDataBckpRcvrVO> list = bbsDataBckpRcvrService.selectNttList(paramVO);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("list", list);
			map.put("paramVO", paramVO);
			
		/*	if(moduleSe.equals("custom")){
				map.put("funcList", bbsDataBckpRcvrService.selectCustomFuncList(paramVO));
				map.put("fieldList", bbsDataBckpRcvrService.selectCustomFieldList(paramVO));
			}*/
			
			if(moduleSe.equals("simp")) {
				ExcelCreater.excelCreate(request, response, map, "bbsSimpDataBckpTemplit", "bbsSimpDataBckpTemplit"); 	
			}else if(moduleSe.equals("mvp")){
				ExcelCreater.excelCreate(request, response, map, "bbsMvpDataBckpTemplit", "bbsMvpDataBckpTemplit");
			}else if(moduleSe.equals("link")){
				ExcelCreater.excelCreate(request, response, map, "bbsLinkDataBckpTemplit", "bbsLinkDataBckpTemplit"); 
			/*
			}else if(moduleSe.equals("custom")){
				ExcelCreater.excelCreate(request, response, map, "bbsCustomDataBckpTemplit", "bbsCustomDataBckpTemplit");
			*/
			}else{
				ExcelCreater.excelCreate(request, response, map, "bbsDataBckpTemplit", "bbsDataBckpTemplit"); 			
			}
		
		}

	}  	
	
	/**
	 * 게시물 데이터 복구 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/siteMngr/bbsDataBckpRcvr/selectBbsDataRcvrForm.do","/{siteKey}/**/siteMngr/bbsDataBckpRcvr/selectBbsDataRcvrForm.do"})
	public String selectBbsDataRcvrForm(@ModelAttribute("paramVO") BbsDataBckpRcvrVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
    	
		List<CntntsInfoVO> resultList = bbsDataBckpRcvrService.selectBbsModuleList();

		paramVO.setBbsSeq((String) request.getParameter("cntntsSeq"));
		
		model.addAttribute("bbsModuleList", resultList);		
    	
		return "wzwg/site/mngr/bbsDataBckpRcvr/bbsDataRcvrForm";
	}	
	
	/**
	 * 게시물 데이터 복구
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/bbsDataBckpRcvr/registBbsDataRcvr.do")
	public ModelAndView registBbsDataRcvr(final MultipartHttpServletRequest multiRequest
			, @ModelAttribute("paramVO") BbsDataBckpRcvrVO paramVO
			, @ModelAttribute("cntntsInfoVO") CntntsInfoVO cntntsInfoVO
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception{

		int result = 0;
		int resultCnt = 0;
		int errorCode = 0;

        final Map<String, MultipartFile> files = multiRequest.getFileMap();
        
        Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
        MultipartFile file = null;	

        try {
        	
        	while (itr.hasNext()) {

                Entry<String, MultipartFile> entry = itr.next();
  
                file = entry.getValue();
             	
                ExcelParser ep = new ExcelParser(file);
	            	
                ArrayList<ArrayList<String>> excelList = ep.getExcel(); 

                //errorCode 0 정상, 1 에러
                errorCode = 0;        
               
            	for (int j = 0; j < excelList.size(); j++) {

            		BbsDataBckpRcvrVO bbsDataBckpRcvrVO = new BbsDataBckpRcvrVO();
	            	bbsDataBckpRcvrVO.setSiteSeq(excelList.get(j).get(0));
	            	bbsDataBckpRcvrVO.setBbsSeq(excelList.get(j).get(2));
	            	
	        		/*
	        		 * unity, qna, mvp, simp
	        		 */
	        		String moduleSe = bbsDataBckpRcvrService.selectModuleBbsSe(bbsDataBckpRcvrVO);            	
	            	
	        		if(moduleSe != null){
	        			BbsDataBckpRcvrVO excelVO = new BbsDataBckpRcvrVO();
		        		excelVO.setModuleSe(moduleSe);
		        		
	            		if(moduleSe.equals("simp")) {

	            			excelVO.setSiteSeq(excelList.get(j).get(0));
	            			excelVO.setSimpnttSeq(excelList.get(j).get(1));
			            	excelVO.setBbsSeq(excelList.get(j).get(2));
			            	excelVO.setNttCn(excelList.get(j).get(3));
			            	excelVO.setAtchFileId(excelList.get(j).get(4));
			            	excelVO.setNtcrId(excelList.get(j).get(5));
			            	excelVO.setNtcrNm(excelList.get(j).get(6));
			            	excelVO.setUseAt(excelList.get(j).get(7));
			            	excelVO.setFrstRegisterId(excelList.get(j).get(8));
			            	excelVO.setFrstRegistPnttm(excelList.get(j).get(9));
			            	excelVO.setLastUpdusrId(excelList.get(j).get(10));
			            	excelVO.setLastUpdtPnttm(excelList.get(j).get(11));
			    			
	            		}else if(moduleSe.equals("mvp")) {
	            			
	            			excelVO.setSiteSeq(excelList.get(j).get(0));
	            			excelVO.setMvpnttSeq(excelList.get(j).get(1));
	            			excelVO.setBbsSeq(excelList.get(j).get(2));
	            			excelVO.setSubospecSeq(excelList.get(j).get(3));
	            			excelVO.setNttSj(excelList.get(j).get(4));
	            			excelVO.setNttCn(excelList.get(j).get(5));
	            			excelVO.setInqireCnt(excelList.get(j).get(6));
	            			excelVO.setMvpSe(excelList.get(j).get(7));
	            			excelVO.setMvpKey(excelList.get(j).get(8));
	            			excelVO.setMvpUrl(excelList.get(j).get(9));
	            			excelVO.setMvpCap(excelList.get(j).get(10));
	            			excelVO.setAtchFileId(excelList.get(j).get(11));
	            			excelVO.setThumbAtchFileId(excelList.get(j).get(12));
	            			excelVO.setNtcrId(excelList.get(j).get(13));
	            			excelVO.setNtcrNm(excelList.get(j).get(14));
	            			excelVO.setUseAt(excelList.get(j).get(15));
			            	excelVO.setFrstRegisterId(excelList.get(j).get(16));
			            	excelVO.setFrstRegistPnttm(excelList.get(j).get(17));
			            	excelVO.setLastUpdusrId(excelList.get(j).get(18));
			            	excelVO.setLastUpdtPnttm(excelList.get(j).get(19));
	            			
	            		}else if(moduleSe.equals("link")) {
	            			
	            			excelVO.setSiteSeq(excelList.get(j).get(0));
	            			excelVO.setLinknttSeq(excelList.get(j).get(1));
	            			excelVO.setBbsSeq(excelList.get(j).get(2));
	            			excelVO.setNttSj(excelList.get(j).get(3));
	            			excelVO.setLinkUrl(excelList.get(j).get(4));
	            			excelVO.setLinkDc(excelList.get(j).get(5));
	            			excelVO.setAtchFileId(excelList.get(j).get(6));
	            			excelVO.setNtcrId(excelList.get(j).get(7));
	            			excelVO.setNtcrNm(excelList.get(j).get(8));
	            			excelVO.setUseAt(excelList.get(j).get(9));
			            	excelVO.setFrstRegisterId(excelList.get(j).get(10));
			            	excelVO.setFrstRegistPnttm(excelList.get(j).get(11));
			            	excelVO.setLastUpdusrId(excelList.get(j).get(12));
			            	excelVO.setLastUpdtPnttm(excelList.get(j).get(13));
	            			
	            		/*
	            		}else if(moduleSe.equals("custom")){
	            		*/
	            		}else{
	            			
	            			excelVO.setSiteSeq(excelList.get(j).get(0));
	            			excelVO.setNttSeq(excelList.get(j).get(1));
	            			excelVO.setBbsSeq(excelList.get(j).get(2));            			     
	            			excelVO.setParntsNttSeq(excelList.get(j).get(3));
	            			excelVO.setSubospecSeq(excelList.get(j).get(4));
	            			excelVO.setNttSj(excelList.get(j).get(5));
			            	excelVO.setNttCn(excelList.get(j).get(6));
			            	excelVO.setInqireCnt(excelList.get(j).get(7));
			            	excelVO.setNttSttusCode(excelList.get(j).get(8));
			            	excelVO.setAtchFileId(excelList.get(j).get(9));
			            	excelVO.setNtcrId(excelList.get(j).get(10));
			            	excelVO.setNtcrNm(excelList.get(j).get(11));
			            	excelVO.setUseAt(excelList.get(j).get(12));
			            	excelVO.setFrstRegisterId(excelList.get(j).get(13));
			            	excelVO.setFrstRegistPnttm(excelList.get(j).get(14));
			            	excelVO.setLastUpdusrId(excelList.get(j).get(15));
			            	excelVO.setLastUpdtPnttm(excelList.get(j).get(16));
			            	excelVO.setNttCnChrctr(excelList.get(j).get(17));
			            	excelVO.setAtchImageFileId(excelList.get(j).get(18));
			            	
			            	excelVO.setNoticeAt(excelList.get(j).get(19));
			            	excelVO.setSecretAt(excelList.get(j).get(20));
			            	excelVO.setAnnymtyAt(excelList.get(j).get(21));
			            	excelVO.setAnswerPermAt(excelList.get(j).get(22));
			            	excelVO.setFaqTabAt(excelList.get(j).get(23));
			            	excelVO.setFaqAt(excelList.get(j).get(24));
			            	excelVO.setAnswerChoiceAt(excelList.get(j).get(25));
			            	excelVO.setAnswerChoicePnttm(excelList.get(j).get(26));
			            	excelVO.setPassword(excelList.get(j).get(27));
			            	excelVO.setQestnUsrCm(excelList.get(j).get(28));
			            	excelVO.setFaqRegistPnttm(excelList.get(j).get(29));
			            	
	            		}
	            		
	            		result = bbsDataBckpRcvrService.insertNttRcvrData(excelVO);
		            	
		            	if(result > 0) {
		            		resultCnt++;
		            	}	
	        		}

            	}	               

        	}
        	
        }catch(NullPointerException e){
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
			if(resultCnt > 0) {
				return CmmAjaxUtil.getAjaxReturn("success");
			} else {
				return CmmAjaxUtil.getAjaxReturn("nocnt");
			}
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}        

	}  	
	
	/**
	 * 첨부파일 데이터 백업 엑셀
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/bbsDataBckpRcvr/selectBbsFileDataBckpExcel.do")
	public void selectBbsFileDataBckpExcel(@ModelAttribute("paramVO") BbsDataBckpRcvrVO paramVO
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception{

		String moduleSe = bbsDataBckpRcvrService.selectModuleBbsSe(paramVO);

		if(moduleSe != null) {
			
			paramVO.setModuleSe(moduleSe);
		
			List<BbsDataBckpRcvrVO> fileList = bbsDataBckpRcvrService.selectNttFileList(paramVO);
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("list", fileList);
			map.put("paramVO", paramVO);
			ExcelCreater.excelCreate(request, response, map, "bbsFileDataBckpTemplit", "bbsFileDataBckpTemplit");
			
		}
						
	}
	
	/**
	 * 첨부파일 데이터 복구
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/bbsDataBckpRcvr/registBbsFileDataRcvr.do")
	public ModelAndView registBbsFileDataRcvr(final MultipartHttpServletRequest multiRequest
			, @ModelAttribute("paramVO") BbsDataBckpRcvrVO paramVO
			, @ModelAttribute("cntntsInfoVO") CntntsInfoVO cntntsInfoVO
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception{

		int result = 0;
		int resultCnt = 0;
		int errorCode = 0;

        final Map<String, MultipartFile> files = multiRequest.getFileMap();
        
        Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
        MultipartFile file = null;	

        try {
        	
        	while (itr.hasNext()) {

                Entry<String, MultipartFile> entry = itr.next();
  
                file = entry.getValue();
             	
                ExcelParser ep = new ExcelParser(file);
	            	
                ArrayList<ArrayList<String>> excelList = ep.getExcel(); 

                //errorCode 0 정상, 1 에러
                errorCode = 0;        
               
            	for (int j = 0; j < excelList.size(); j++) {

            		BbsDataBckpRcvrVO bbsDataBckpRcvrVO = new BbsDataBckpRcvrVO();
	            	bbsDataBckpRcvrVO.setSiteSeq(excelList.get(j).get(0));
	            	
	            	bbsDataBckpRcvrVO.setBbsSeq(excelList.get(j).get(2));
	            	

	            	ModuleUploadFileVO ModuleUploadFileVO = new ModuleUploadFileVO();
        			ModuleUploadFileVO.setAtchFileId(excelList.get(j).get(3));
        			ModuleUploadFileVO.setCreatDt(excelList.get(j).get(4));
        			ModuleUploadFileVO.setUseAt(excelList.get(j).get(5));
        			ModuleUploadFileVO.setFileSn(excelList.get(j).get(6));
        			ModuleUploadFileVO.setFileStreCours(excelList.get(j).get(7));
        			ModuleUploadFileVO.setStreFileNm(excelList.get(j).get(8));
        			ModuleUploadFileVO.setOrignlFileNm(excelList.get(j).get(9));
        			ModuleUploadFileVO.setFileExtsn(excelList.get(j).get(10));
        			ModuleUploadFileVO.setFileMg(excelList.get(j).get(11));
        			ModuleUploadFileVO.setFileDc(excelList.get(j).get(12));
        			ModuleUploadFileVO.setThumbStreCours(excelList.get(j).get(13));
        			ModuleUploadFileVO.setThumbFileNm(excelList.get(j).get(14));
          	
	            	result = bbsDataBckpRcvrService.insertNttFileRcvrData(ModuleUploadFileVO);
	            	
	            	if(result > 0) {
	            		resultCnt++;
	            	}
            	}	               

        	}
        	
        }  catch(NullPointerException e){
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
			if(resultCnt > 0) {
				return CmmAjaxUtil.getAjaxReturn("success");
			} else {
				return CmmAjaxUtil.getAjaxReturn("nocnt");
			}
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}        

	}  	
	
	/**
	 * 게시판 모듈 구분 확인
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/siteMngr/bbsDataBckpRcvr/selectModuleBbsSeAjax.do")
	public ModelAndView selectModuleBbsSe(@ModelAttribute("paramVO") BbsDataBckpRcvrVO paramVO
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model) throws Exception{

		return CmmAjaxUtil.getAjaxReturn(bbsDataBckpRcvrService.selectModuleBbsSe(paramVO));       
	} 	
}
