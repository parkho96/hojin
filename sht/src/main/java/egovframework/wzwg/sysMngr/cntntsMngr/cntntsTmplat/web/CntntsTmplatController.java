package egovframework.wzwg.sysMngr.cntntsMngr.cntntsTmplat.web;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.util.EgovUserDetailsHelper;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.cmm.util.ajax.AjaxXmlView;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeVO;
import egovframework.wzwg.sysMngr.cntntsMngr.cntntsTmplat.service.CntntsTmplatService;
import egovframework.wzwg.sysMngr.cntntsMngr.cntntsTmplat.service.CntntsTmplatVO;
import net.sourceforge.ajaxtags.xml.AjaxXmlBuilder;

@Controller
public class CntntsTmplatController {

	@Resource(name="CntntsTmplatService")
	CntntsTmplatService cntntsTmplatService;
	
	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;

	@Resource(name="ModuleUploadFileUtil")
    protected ModuleUploadFileUtil fileUtil;
	
    @Resource(name = "ModuleUploadFileService")
    protected ModuleUploadFileService fileService;
    
	/**
	 * 컨텐츠 템플릿 리스트 조회
	 * @param cntntsTmplatVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value= {"/sysMngr/cntntsMngr/cntntnsTmplat/selectCntntsTmplatList.do","/{siteKey}/sysMngr/cntntsMngr/cntntnsTmplat/selectCntntsTmplatList.do"})
	public String selectCntntsTmplatList(
			@ModelAttribute("paramVO")CntntsTmplatVO cntntsTmplatVO
			, HttpServletRequest request
			, Model model
			)throws Exception{
		
        /** =================== paging 시작 ============================== */
		PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(cntntsTmplatVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(cntntsTmplatVO.getPageUnit());
        paginationInfo.setPageSize(cntntsTmplatVO.getPageSize());
       
        cntntsTmplatVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        cntntsTmplatVO.setLastIndex(paginationInfo.getLastRecordIndex());
        cntntsTmplatVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        
        int totCnt = cntntsTmplatService.selectCntntsTmplatTotCnt(cntntsTmplatVO);
        paginationInfo.setTotalRecordCount(totCnt);
		
        /* 모바일 페이지네이션 설정 */
		PaginationInfo mobilePaginationInfo = new PaginationInfo();
		mobilePaginationInfo.setTotalRecordCount(paginationInfo.getTotalRecordCount());
		mobilePaginationInfo.setCurrentPageNo(paginationInfo.getCurrentPageNo());
		mobilePaginationInfo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		mobilePaginationInfo.setPageSize(5);
		
		model.addAttribute("mobilePaginationInfo", 	mobilePaginationInfo);
        /** =================== paging 끝 =============================== */

        /** 템플릿 유형 코드 */
		List<CmmCodeVO> codeList = codeService.selectCmmCodeList("TMPLAT_CL_CODE");
		model.addAttribute("codeList", codeList);
		
		List<CntntsTmplatVO> cntntsTmplatList = cntntsTmplatService.selectCntntsTmplatList(cntntsTmplatVO);
		
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("cntntsTmplatList", cntntsTmplatList);
		
		return "/wzwg/sysMngr/cntntsMngr/cntntsTmplat/cntntsTmplatList";
	}

	/**
	 * 컨텐츠 템플릿 등록 폼
	 * @param cntntsTmplatVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value= {"/sysMngr/cntntsMngr/cntntnsTmplat/registCntntsTmplatForm.do","/{siteKey}/sysMngr/cntntsMngr/cntntnsTmplat/registCntntsTmplatForm.do"})
	public String registCntntsTmplatForm(
			@ModelAttribute("paramVO")CntntsTmplatVO cntntsTmplatVO
			, HttpServletRequest request
			, Model model
			)throws Exception{

		/** 템플릿 유형 코드 */
		List<CmmCodeVO> codeList = codeService.selectCmmCodeList("TMPLAT_CL_CODE");
		model.addAttribute("codeList", codeList);

		return "/wzwg/sysMngr/cntntsMngr/cntntsTmplat/cntntsTmplatRegistForm";
	}
	
	/**
	 * 컨텐츠 템플릿 등록
	 * @param cntntsTmplatVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(value= {"/sysMngr/cntntsMngr/cntntnsTmplat/registCntntsTmplatAjax.do","/{siteKey}/sysMngr/cntntsMngr/cntntnsTmplat/registCntntsTmplatAjax.do"})
	public ModelAndView registCntntsTmplatAjax(
			@ModelAttribute("paramVO")CntntsTmplatVO cntntsTmplatVO
			, MultipartHttpServletRequest multiRequest
			, HttpServletRequest request
			, Model model
			) throws Exception{
		
		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		cntntsTmplatVO.setUserId(loginVO.getUserId());
		
		List<ModuleUploadFileVO> resultList = null;
	    
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    
	    Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
	    
 	    while (itr.hasNext()) {
	    	Entry<String, MultipartFile> entry = itr.next();
	    	Map<String, MultipartFile> file = new HashMap<String, MultipartFile>();
	    	
	    	file.put(entry.getKey(), entry.getValue());
	    	
	    	if (!file.isEmpty()) {
	    		
	    		resultList = fileUtil.parseFileInf(file, "CNTTMP_", 0, "Globals.mdFilePath", "Globals.WhiteImgFileExt", multiRequest, "cntntsTmplat", null, CmmSessionUtil.getSessionSiteSeq(request));

	    		if(!resultList.isEmpty() || resultList.size() != 0){
	    			cntntsTmplatVO.setAtchFileId(fileService.insertFileInfs(resultList));
	    		}	    		
	    	}
	    }
		
		int registResult = cntntsTmplatService.registCntntsTmplatAjax(cntntsTmplatVO);

        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        if(registResult < 1){
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "fail").toString());
        }else{
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        }
        
        return ajaxModel;
	}
	
	/**
	 * 컨텐츠 템플릿 상세조회
	 * @param cntntsTmplatVO
	 * @param request
	 * @param model
	 * @return
	 */
	
	@RequestMapping(value= {"/sysMngr/cntntsMngr/cntntnsTmplat/selectCntntsTmplatDetail.do","/{siteKey}/sysMngr/cntntsMngr/cntntnsTmplat/selectCntntsTmplatDetail.do"})
	public String selectCntntsTmplatDetail(
			@ModelAttribute("paramVO")CntntsTmplatVO cntntsTmplatVO
			, HttpServletRequest request
			, Model model
			){
			
		cntntsTmplatVO = cntntsTmplatService.selectCntntsTmplatDetail(cntntsTmplatVO);
		model.addAttribute("cntntsTmplatVO", cntntsTmplatVO);
		
		return "/wzwg/sysMngr/cntntsMngr/cntntsTmplat/cntntsTmplatDetail";
	}
	
	/**
	 * 컨텐츠 템플릿 수정 폼
	 * @param cntntsTmplatVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value= {"/sysMngr/cntntsMngr/cntntnsTmplat/modifyCntntsTmplatForm.do","/{siteKey}/sysMngr/cntntsMngr/cntntnsTmplat/modifyCntntsTmplatForm.do"})
	public String modifyCntntsTmplatForm(
			@ModelAttribute("paramVO")CntntsTmplatVO cntntsTmplatVO
			, HttpServletRequest request
			, Model model
			)throws Exception{

		/** 템플릿 유형 코드 */
		List<CmmCodeVO> codeList = codeService.selectCmmCodeList("TMPLAT_CL_CODE");
		model.addAttribute("codeList", codeList);
		
		cntntsTmplatVO = cntntsTmplatService.selectCntntsTmplatDetail(cntntsTmplatVO);
		model.addAttribute("cntntsTmplatVO", cntntsTmplatVO);
		
		return "/wzwg/sysMngr/cntntsMngr/cntntsTmplat/cntntsTmplatModifyForm";
	}
	
	/**
	 * 컨텐츠 템플릿 수정
	 * @param cntntsTmplatVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value= {"/sysMngr/cntntsMngr/cntntnsTmplat/modifyCntntsTmplatAjax.do","/{siteKey}/sysMngr/cntntsMngr/cntntnsTmplat/modifyCntntsTmplatAjax.do"})
	public ModelAndView modifyCntntsTmplatAjax(
			@ModelAttribute("paramVO")CntntsTmplatVO cntntsTmplatVO
			, MultipartHttpServletRequest multiRequest
			, HttpServletRequest request
			, Model model
			) throws Exception{

		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		cntntsTmplatVO.setUserId(loginVO.getUserId());
		
		List<ModuleUploadFileVO> resultList = null;
	    
        final Map<String, MultipartFile> files = multiRequest.getFileMap();
	    
	    Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
 	    while (itr.hasNext()) {
	    	Entry<String, MultipartFile> entry = itr.next();
	    	Map<String, MultipartFile> file = new HashMap<String, MultipartFile>();
	    	
	    	file.put(entry.getKey(), entry.getValue());
	    	
	    	if (!file.isEmpty()) {
	    		resultList = fileUtil.parseFileInf(file, "CNTTMP_", 0, "Globals.mdFilePath", "Globals.WhiteImgFileExt", multiRequest, "cntntsTmplat", null, CmmSessionUtil.getSessionSiteSeq(request));
	    		
	    		if(!resultList.isEmpty() || resultList.size() != 0){
	    			cntntsTmplatVO.setAtchFileId(fileService.insertFileInfs(resultList));
	    		}	    		
	    	}
	    }

		int modifyResult = cntntsTmplatService.modifyCntntsTmplatAjax(cntntsTmplatVO);

        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        if(modifyResult < 1){
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "fail").toString());
        }else{
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        }
        
        return ajaxModel;
	}
	
	/**
	 * 컨텐츠 템플릿 삭제
	 * @param cntntsTmplatVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value= {"/sysMngr/cntntsMngr/cntntnsTmplat/deleteCntntsTmplatAjax.do","/{siteKey}/sysMngr/cntntsMngr/cntntnsTmplat/deleteCntntsTmplatAjax.do"})
	public ModelAndView deleteCntntsTmplatAjax(
			@ModelAttribute("paramVO")CntntsTmplatVO cntntsTmplatVO
			, HttpServletRequest request
			, Model model
			){

		/** 로그인 한 사용자 입력 */
		CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
		cntntsTmplatVO.setUserId(loginVO.getUserId());

		int deleteResult = cntntsTmplatService.deleteCntntsTmplatAjax(cntntsTmplatVO);

        ModelAndView ajaxModel = new ModelAndView(new AjaxXmlView());
        AjaxXmlBuilder xmlBuilder=new AjaxXmlBuilder();
        
        if(deleteResult < 1){
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "fail").toString());
        }else{
        	ajaxModel.addObject("ajaxXml", xmlBuilder.addItem("result", "success").toString());
        }
        
        return ajaxModel;
	}
	
	/**
	 * 컨텐츠 템플릿 미리보기
	 * @param cntntsTmplatVO
	 * @param request
	 * @param model
	 * @return
	 */
	@RequestMapping(value={"/**/cntntsMngr/cntntnsTmplat/selectCntntsTmplatPrevewPopup.do","/{siteKey}/**/cntntsMngr/cntntnsTmplat/selectCntntsTmplatPrevewPopup.do"})
	public String selectCntntsTmplatPrevewPopup(
			@ModelAttribute("paramVO")CntntsTmplatVO cntntsTmplatVO
			, HttpServletRequest request
			, Model model
			){
		
		cntntsTmplatVO = cntntsTmplatService.selectCntntsTmplatDetail(cntntsTmplatVO);
		model.addAttribute("cntntsTmplatVO", cntntsTmplatVO);
		
		return "/wzwg/sysMngr/cntntsMngr/cntntsTmplat/cntntsTmplatPrevewPopup";
	}
	
}
