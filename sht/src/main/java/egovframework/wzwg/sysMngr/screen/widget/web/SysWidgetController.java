package egovframework.wzwg.sysMngr.screen.widget.web;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.FilenameUtils;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import dggb.util.FileUtils;
import dggb.util.StringUtils;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.wzwg.cmm.util.CmmJsonAjaxResponser;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.cmm.util.SecureAES256;
import egovframework.wzwg.cmm.util.SecurePathValidator;
import egovframework.wzwg.site.mngr.screen.service.SiteLayoutVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeVO;
import egovframework.wzwg.sysMngr.screen.widget.service.SysWidgetService;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class SysWidgetController {

	//@Resource(name="SiteLayoutService")
    //private SiteLayoutService siteLayoutService;
	
	@Resource(name="SysWidgetService")
	private SysWidgetService sysWidgetService;
	
	@Resource(name="CmmCodeService")
	private CmmCodeService cmmCodeService;
	
	private final String secureKey = EgovProperties.getProperty("secure.aes256.key");
	private final String paramChek = "YjU0YTU2YmU2MDFmNjdkNGYzYjgwMWNhZTI2MGU4YWQ=";
	
	/**
	 * 위젯관리자 비밀번호 인증
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/sysMngr/screen/widget/selectWidgetMngrAuth.do")
	public String selectWidgetMngrAuth(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
		String widgetPw = request.getParameter("widgetPw");
		if(widgetPw == null) {
			widgetPw = "";
		}
		
		widgetPw = SecureAES256.encryptP(secureKey, widgetPw);
		CmmJsonAjaxResponser cr = CmmJsonAjaxResponser.getInstance();
		if(paramChek.equals(widgetPw)) {
			CmmSessionUtil.setSessionValue(request, "widgetAuth", true);
			cr.setResultCode("success");
		}else{
			cr.setResultCode("fail");
		}
		
		return cr.returnJsp(model);
	}
	
	/**
	 * 위젯 관리자 메인 화면
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/sysMngr/screen/widget/widgetMngr.do")
	public String widgetMngr(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
		
		//위젯 카테고리 코드
		List<CmmCodeVO> widgetCategoryList = cmmCodeService.selectCmmCodeList("WIDG_CTGRY_LIST");
		
		model.addAttribute("widgetCategoryList", widgetCategoryList);
		
		return "wzwg/sysMngr/screen/widget/widgetMngr";
	}
	
	/**
	 * 위젯 관리자 메인 화면
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/sysMngr/screen/widget/widgetCategoryCntAjax.do")
	public String widgetCategoryCntAjax(HttpServletRequest request, HttpServletResponse response, Model model) throws Exception{
		
		
		List<SiteLayoutVO> widgetCategoryCntList = sysWidgetService.selectWidgetInfoCategoryCnt();
		
		return CmmJsonAjaxResponser.getInstance().setResultCode("success").setBodyData("widgetCategoryCntList", widgetCategoryCntList).returnJsp(model);
	}
	
	/**
	 * 위젯 목록 조회
	 * @param paramVO
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sysMngr/screen/widget/selectWidgetListAjax.do")
	public String selectWidgetListAjax(
			@ModelAttribute("paramVO") SiteLayoutVO paramVO
			, HttpServletRequest request
			, Model model ) throws Exception {
		
		boolean widgetAuth = CmmSessionUtil.getSessionBooleanValue(request, "widgetAuth");
		if(widgetAuth == false) {
			return "wzwg/sysMngr/screen/widget/widgetClose";
		}
		
		PaginationInfo paginationInfo = new PaginationInfo();

		String pageIndex = String.valueOf(paramVO.getPageIndex());
		if(StringUtils.isEmpty(pageIndex)){
			pageIndex = "1";
		}
		
		paginationInfo.setCurrentPageNo(Integer.parseInt(pageIndex));
		paginationInfo.setRecordCountPerPage(10);
		paginationInfo.setPageSize(10);

		paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
		paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		int totalCnt = sysWidgetService.selectWidgetTotalCount(paramVO);
		paginationInfo.setTotalRecordCount(totalCnt);
		
		List<SiteLayoutVO> widgetList = null;
		
		if("work".equals(paramVO.getCategory())) {
			widgetList = sysWidgetService.selectWorkWidgetList(paramVO);
		}else {
			widgetList = sysWidgetService.selectWidgetList(paramVO);
		}
		
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("widgetList", widgetList);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "wzwg/sysMngr/screen/widget/widgetListAjax";
	}
	
	
	/**
	 * 위젯 편집 화면
	 * @param request
	 * @param response
	 * @param model
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/sysMngr/screenHidden/widget/widgetEditor.do")
	public String widgetEditor(
		  HttpServletRequest request
		, HttpServletResponse response
		, Model model
		, @ModelAttribute("paramVO") SiteLayoutVO paramVO) throws Exception{
		
		boolean widgetAuth = CmmSessionUtil.getSessionBooleanValue(request, "widgetAuth");
		if(widgetAuth == false) {
			return "wzwg/sysMngr/screen/widget/widgetClose";
		}
		
		SiteLayoutVO orgWidget = null;
		
		if(!"".equals(paramVO.getLayoutcntntsworkSeq()) && paramVO.getLayoutcntntsworkSeq() != null) {
			orgWidget = sysWidgetService.selectWidgetWorkData(paramVO);
		}else {
			orgWidget = sysWidgetService.selectWidgetData(paramVO);
		}
		
		model.addAttribute("widget", orgWidget);
		
		//위젯 카테고리 코드
		List<CmmCodeVO> widgetCategoryList = cmmCodeService.selectCmmCodeList("WIDG_CTGRY_LIST");
		model.addAttribute("widgetCategoryList", widgetCategoryList);
		
		return "wzwg/sysMngr/screen/widget/widgetEditor";
	}
	
	/**
	 * 위젯 생성
	 * @param request
	 * @param response
	 * @param model
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/sysMngr/screenHidden/widget/registWidgetWorkInfo.do")
	public String registWidgetWorkInfo(HttpServletRequest request
			, HttpServletResponse response
			, Model model
			, @ModelAttribute("paramVO") SiteLayoutVO paramVO) throws Exception {
		
		boolean widgetAuth = CmmSessionUtil.getSessionBooleanValue(request, "widgetAuth");
		if(widgetAuth == false) {
			return "wzwg/sysMngr/screen/widget/widgetClose";
		}
		
		String resultCode = "";
    	String layoutcntntsworkSeq = "";
		
		int nmSearchResult = sysWidgetService.selectWidgetNmSearch(paramVO);
		int coursSearchResult = sysWidgetService.selectWidgetFileCoursSearch(paramVO);
		int htmlSearchResult = sysWidgetService.selectWidgetHtmlFileCoursSearch(paramVO);
		
		if (!SecurePathValidator.isValidNumericPath(paramVO.getLayoutcntntsSeq())) {
			throw new IOException("Invalid Path Input");
		}
		
		SiteLayoutVO targetWidget = sysWidgetService.selectWidgetData(paramVO);
		
		String realPath = request.getSession().getServletContext().getRealPath("/");
		
		String targetWidgetDirStr = realPath + targetWidget.getSampleFileCours();
		String widgetDirStr = realPath + paramVO.getSampleFileCours();
		
		
		if(nmSearchResult > 0) {
			resultCode = "fail";
			return CmmJsonAjaxResponser.getInstance().setResultCode(resultCode).setBodyData("failMsg", "nameFail").returnJsp(model);
		}
		
		if(!"img_board".equals(paramVO.getCategory()) && !"mvp_board".equals(paramVO.getCategory())) {
			if(coursSearchResult > 0) {
				resultCode = "fail";
				return CmmJsonAjaxResponser.getInstance().setResultCode(resultCode).setBodyData("failMsg", "fileCoursFail").returnJsp(model);
			}
		}else {
			if(targetWidget.getSampleFileCours().equals(paramVO.getSampleFileCours()) && htmlSearchResult > 0) {
				resultCode = "fail";
				return CmmJsonAjaxResponser.getInstance().setResultCode(resultCode).setBodyData("failMsg", "htmlCoursFail").returnJsp(model);
			}
		}
		
		
		File targetWidgetDir = new File(targetWidgetDirStr);
		File widgetDir = new File(widgetDirStr);
		
		if(!widgetDir.exists()) {
			widgetDir.mkdir();
		}
		
		//경로가 같지않으면 기존폴더 파일 새로운 위젯으로 복사
		if(!targetWidgetDirStr.equals(widgetDirStr)) {
			FileUtils.copyDir(targetWidgetDir, widgetDir);
			
			//경로기준으로 파일명 변경 (생성된위젯Dir, 기존위젯, 생성된위젯)
			sysWidgetService.updateWidgetRename(widgetDir, targetWidget, paramVO);
			//복사된 기존 썸네일 삭제
			sysWidgetService.deleteWidgetThumbnail(widgetDir);
		}else {
			if(!targetWidget.getSampleCssNm().equals(paramVO.getSampleCssNm())) {
				FileUtils.copyFile(new File(targetWidgetDirStr+targetWidget.getSampleCssNm()), new File(widgetDirStr+paramVO.getSampleCssNm()));
			}
			
			if(!targetWidget.getSampleFileNm().equals(paramVO.getSampleFileNm())) {
				FileUtils.copyFile(new File(targetWidgetDirStr+targetWidget.getSampleFileNm()), new File(widgetDirStr+paramVO.getSampleFileNm()));
			}
		}

		int result = sysWidgetService.registWidgetWorkInfo(paramVO);
		
    	if(result > 0){
    		resultCode = "success";
    		layoutcntntsworkSeq = paramVO.getLayoutcntntsworkSeq();
    	}else{
    		resultCode = "fail";
    	}		
		
    	return CmmJsonAjaxResponser.getInstance().setResultCode(resultCode).setBodyData("layoutcntntsworkSeq", layoutcntntsworkSeq).returnJsp(model);
	}

	
	/**
	 * 위젯 정보 수정
	 * @param request
	 * @param response
	 * @param model
	 * @param param
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/sysMngr/screenHidden/widget/modifyWidgetInfoAjax.do")
	public String modifyWidgetInfoAjax(
			@ModelAttribute("paramVO") SiteLayoutVO paramVO
			, HttpServletRequest request
			, ModelMap model) throws Exception{
		
		boolean widgetAuth = CmmSessionUtil.getSessionBooleanValue(request, "widgetAuth");
		
		if(widgetAuth == false) {
			return "wzwg/sysMngr/screen/widget/widgetClose";
		}
		
		SiteLayoutVO orgWidget = null;
		
		if(!"".equals(paramVO.getLayoutcntntsworkSeq()) && paramVO.getLayoutcntntsworkSeq() != null) {
			if (!SecurePathValidator.isValidNumericPath(paramVO.getLayoutcntntsworkSeq())) {
				throw new IOException("Invalid Path Input");
			}
			orgWidget = sysWidgetService.selectWidgetWorkData(paramVO);
		}else {
			if (!SecurePathValidator.isValidNumericPath(paramVO.getLayoutcntntsSeq())) {
				throw new IOException("Invalid Path Input");
			}
			orgWidget = sysWidgetService.selectWidgetData(paramVO);
		}
		
		String fileNm = "";
		if (paramVO.getSampleFileNm() != null) {
			fileNm = paramVO.getSampleFileNm().replace(".html", "");
		}
		String orgfileNm = orgWidget.getSampleFileNm().replace(".html", "");
			
		String realPath =request.getSession().getServletContext().getRealPath("/");
		
		String orgWidgetDirStr = realPath + orgWidget.getSampleFileCours();
		String widgetDirStr = realPath + paramVO.getSampleFileCours();
		
		File orgWidgetDir = new File(orgWidgetDirStr);
		File widgetDir = new File(widgetDirStr);
		
		//디렉토리명 변경
		orgWidgetDir.renameTo(widgetDir);
		
		sysWidgetService.updateWidgetRename(widgetDir, orgWidget, paramVO);
		
		if(!"".equals(orgWidget.getThumbLPath()) && orgWidget.getThumbLPath() != null) {
			paramVO.setThumbLPath(orgWidget.getSampleFileCours()+orgWidget.getThumbLPath().substring(orgWidget.getThumbLPath().lastIndexOf("/")+1).replace(orgfileNm, fileNm));
		}
		
		if(!"".equals(orgWidget.getThumbMPath()) && orgWidget.getThumbMPath() != null) {
			paramVO.setThumbMPath(orgWidget.getSampleFileCours()+orgWidget.getThumbMPath().substring(orgWidget.getThumbMPath().lastIndexOf("/")+1).replace(orgfileNm, fileNm));
		}
		
		if(!"".equals(orgWidget.getThumbHPath()) && orgWidget.getThumbHPath() != null) {
			paramVO.setThumbHPath(orgWidget.getSampleFileCours()+orgWidget.getThumbHPath().substring(orgWidget.getThumbHPath().lastIndexOf("/")+1).replace(orgfileNm, fileNm));
		}
		
		if(!"".equals(orgWidget.getThumbWPath()) && orgWidget.getThumbWPath() != null) {
			paramVO.setThumbWPath(orgWidget.getSampleFileCours()+orgWidget.getThumbWPath().substring(orgWidget.getThumbWPath().lastIndexOf("/")+1).replace(orgfileNm, fileNm));
		}
		
		int result = sysWidgetService.modifyWidgetInfoAjax(paramVO);
		
		if(result > 0){
    		return CmmJsonAjaxResponser.getInstance().setResultCode("success").returnJsp(model);
    	}else{
    		return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
    	}		
		
	}
	
	/**
	 * 위젯 경로내에 img 파일 저장
	 */
	@RequestMapping(value="/sysMngr/screenHidden/registWidgetThumbAjax.do")
	public String registWidgetThumbAjax(
			@RequestParam Map<String, String> paramVO
			, final MultipartHttpServletRequest multiRequest
			, HttpServletRequest request
			, ModelMap model
    )throws Exception {
		
		boolean widgetAuth = CmmSessionUtil.getSessionBooleanValue(request, "widgetAuth");
		
		if(widgetAuth == false) {
			return "wzwg/sysMngr/screen/widget/widgetClose";
		}
		
		SiteLayoutVO orgWidget = null;
		
		if(!"".equals(paramVO.get("layoutcntntsworkSeq")) && paramVO.get("layoutcntntsworkSeq") != null) {
			SiteLayoutVO siteLayoutVo = new SiteLayoutVO();
			siteLayoutVo.setLayoutcntntsworkSeq(paramVO.get("layoutcntntsworkSeq"));
			orgWidget = sysWidgetService.selectWidgetWorkData(siteLayoutVo);
		}else {
			SiteLayoutVO siteLayoutVo = new SiteLayoutVO();
			siteLayoutVo.setLayoutcntntsSeq(paramVO.get("layoutcntntsSeq"));
			orgWidget = sysWidgetService.selectWidgetData(siteLayoutVo);
		}
		
		String widgetPath = request.getServletContext().getRealPath("/") + orgWidget.getSampleFileCours();
		String fileNm = orgWidget.getSampleFileNm().replace(".html", "");
		
		File checkDir = new File(widgetPath);
		if(checkDir.exists() == false) {
			return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
		}
		
		List<MultipartFile> uploadList = multiRequest.getFiles("thumbFile");
		
		MultipartFile uploadFile = uploadList.get(0);
		
		File newFile = null;
		
		if("thumbLPath".equals(paramVO.get("name"))) {
			newFile = new File(widgetPath + "150_"+fileNm+"." + FilenameUtils.getExtension(uploadFile.getOriginalFilename()));
		}else if("thumbMPath".equals(paramVO.get("name"))) {
			newFile = new File(widgetPath + "250_"+fileNm+"." + FilenameUtils.getExtension(uploadFile.getOriginalFilename()));
		}else if("thumbHPath".equals(paramVO.get("name"))) {
			newFile = new File(widgetPath + "350_"+fileNm+"." + FilenameUtils.getExtension(uploadFile.getOriginalFilename()));
		}else if("thumbWPath".equals(paramVO.get("name"))) {
			newFile = new File(widgetPath + "wide_"+fileNm+"." + FilenameUtils.getExtension(uploadFile.getOriginalFilename()));
		}
		
		try {
			uploadFile.transferTo(newFile);
		} catch (IOException e) {
			log.error("IOException",e);
		}
		
		if (orgWidget != null && orgWidget.getSampleFileCours() != null && newFile != null && newFile.getName() != null) {
			paramVO.put("thumbPath", orgWidget.getSampleFileCours()+newFile.getName());
		}
		
		int result = sysWidgetService.updateWidgetImageinfo(paramVO);
		
		if(result > 0) {
			if (orgWidget != null && orgWidget.getSampleFileCours() != null && newFile != null && newFile.getName() != null) {
				return CmmJsonAjaxResponser.getInstance().setResultCode("success").setBodyData("imgPath", orgWidget.getSampleFileCours()+newFile.getName()).returnJsp(model);
			} else {
				return CmmJsonAjaxResponser.getInstance().setResultCode("success").returnJsp(model);
			}
		}else {
			return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
		}
	}
	
	/**
	 * 위젯 경로내에 img 파일 삭제
	 */
	@RequestMapping(value="/sysMngr/screenHidden/deleteWidgetThumbAjax.do")
	public String deleteWidgetThumbAjax(
			@RequestParam Map<String, String> paramVO
			, HttpServletRequest request
			, ModelMap model
    )throws Exception {
		
		boolean widgetAuth = CmmSessionUtil.getSessionBooleanValue(request, "widgetAuth");
		
		if(widgetAuth == false) {
			return "wzwg/sysMngr/screen/widget/widgetClose";
		}
		
		SiteLayoutVO orgWidget = null;
		
		if(!"".equals(paramVO.get("layoutcntntsworkSeq")) && paramVO.get("layoutcntntsworkSeq") != null) {
			SiteLayoutVO siteLayoutVo = new SiteLayoutVO();
			siteLayoutVo.setLayoutcntntsworkSeq(paramVO.get("layoutcntntsworkSeq"));
			orgWidget = sysWidgetService.selectWidgetWorkData(siteLayoutVo);
		}else {
			SiteLayoutVO siteLayoutVo = new SiteLayoutVO();
			siteLayoutVo.setLayoutcntntsSeq(paramVO.get("layoutcntntsSeq"));
			orgWidget = sysWidgetService.selectWidgetData(siteLayoutVo);
		}
		
		String widgetPath = request.getServletContext().getRealPath("/") + orgWidget.getSampleFileCours();
		
		File checkDir = new File(widgetPath);
		if(checkDir.exists() == false) {
			return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
		}
				
		File delFile = null;
		
		if("thumbLPath".equals(paramVO.get("thumbFileNm"))) {
			delFile = new File(request.getServletContext().getRealPath("/") + orgWidget.getThumbLPath());
		}else if("thumbMPath".equals(paramVO.get("thumbFileNm"))) {
			delFile = new File(request.getServletContext().getRealPath("/") + orgWidget.getThumbMPath());
		}else if("thumbHPath".equals(paramVO.get("thumbFileNm"))) {
			delFile = new File(request.getServletContext().getRealPath("/") + orgWidget.getThumbHPath());
		}else if("thumbWPath".equals(paramVO.get("thumbFileNm"))) {
			delFile = new File(request.getServletContext().getRealPath("/") + orgWidget.getThumbWPath());
		}
		
		int result = 0;
		
		// TOCTOU 방지를 위한 synchronized 블록
		synchronized(this) {
			if(delFile != null && delFile.exists()) {
				if(delFile.delete()){
					result = sysWidgetService.deleteWidgetImageinfo(paramVO);
				}
			}
		}
		
		
		if(result > 0) {
			return CmmJsonAjaxResponser.getInstance().setResultCode("success").returnJsp(model);
		}else {
			return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
		}
	}
	
	
	/**
	 * 위젯 파일저장
	 */
	@RequestMapping(value="/sysMngr/screenHidden/widgetFileSaveAjax.do")
	public String widgetFileSaveAjax(
			@ModelAttribute("paramVO") SiteLayoutVO paramVO
			, String htmlCn
			, String cssCn
			, HttpServletRequest request
			, ModelMap model
    )throws Exception {
	
		boolean widgetAuth = CmmSessionUtil.getSessionBooleanValue(request, "widgetAuth");
		
		if(widgetAuth == false) {
			return "wzwg/sysMngr/screen/widget/widgetClose";
		}
		
		SiteLayoutVO orgWidget = null;
		
		if(!"".equals(paramVO.getLayoutcntntsworkSeq()) && paramVO.getLayoutcntntsworkSeq() != null) {
			orgWidget = sysWidgetService.selectWidgetWorkData(paramVO);
		}else {
			orgWidget = sysWidgetService.selectWidgetData(paramVO);
		}
		
		String realPath = request.getServletContext().getRealPath("/");
		String cssPath = realPath + orgWidget.getSampleFileCours() + orgWidget.getSampleCssNm();
		String htmlPath = realPath + orgWidget.getSampleFileCours() + orgWidget.getSampleFileNm();
		
		File cssFile = new File(cssPath);
		File htmlFile = new File(htmlPath);
		
		if(cssFile.exists() == false){
			cssFile.mkdir();
		}
		
		FileWriter cssWriter = new FileWriter(cssFile);
		BufferedWriter cssBw = new BufferedWriter(cssWriter);
		
		try {			
			
			String cssDecodeCn = new String(Base64.getDecoder().decode(cssCn), "UTF-8");
			cssBw.write(cssDecodeCn);
			cssBw.flush();			
			
		} finally {
			
			if (cssBw != null) {
		        try {
		            cssBw.close();
		        } catch (IOException e) {
		            log.debug("Failed to close BufferedWriter for CSS", e);
		        }
			}
			
			if (cssWriter != null) {
		        try {
		        	cssWriter.close();
		        } catch (IOException e) {
		            log.debug("Failed to close FileWriter for CSS", e);
		        }				
				
			}
			
		}
		
//		FileWriter cssWriter = new FileWriter(cssFile);
//		BufferedWriter cssBw = new BufferedWriter(cssWriter);
//		String cssDecodeCn = new String(Base64.getDecoder().decode(cssCn), "UTF-8");
//		cssBw.write(cssDecodeCn);
//		cssBw.flush();
//		cssBw.close();
//		cssWriter.close(); 
		
		if(htmlFile.exists() == false){
			htmlFile.mkdir();
		}
		
		FileWriter htmlWriter = new FileWriter(htmlFile);
		BufferedWriter htmlBw = new BufferedWriter(htmlWriter);
		
		try {
			
			String htmlDecodeCn = new String(Base64.getDecoder().decode(htmlCn), "UTF-8");
			htmlBw.write(htmlDecodeCn);
			htmlBw.flush();						
			
		} finally {
			
			if (htmlBw != null) {
		        try {
		        	htmlBw.close();
		        } catch (IOException e) {
		            log.debug("Failed to close BufferedWriter for CSS", e);
		        }
			}
			
			if (htmlWriter != null) {
		        try {
		        	htmlWriter.close();
		        } catch (IOException e) {
		            log.debug("Failed to close FileWriter for CSS", e);
		        }				
			}
			
		}
		
//		FileWriter htmlWriter = new FileWriter(htmlFile);
//		BufferedWriter htmlBw = new BufferedWriter(htmlWriter);
//		String htmlDecodeCn = new String(Base64.getDecoder().decode(htmlCn), "UTF-8");
//		htmlBw.write(htmlDecodeCn);
//		htmlBw.flush();
//		htmlBw.close();
//		htmlWriter.close(); 
		
		
		return CmmJsonAjaxResponser.getInstance().setResultCode("success").returnJsp(model);
	}
	
	/**
	 * 위젯 삭제
	 */
	@RequestMapping(value="/sysMngr/screenHidden/deleteWidgetAjax.do")
	public String deleteWidgetAjax(
			@ModelAttribute("paramVO") SiteLayoutVO paramVO
			, HttpServletRequest request
			, ModelMap model
    )throws Exception {
		
		boolean widgetAuth = CmmSessionUtil.getSessionBooleanValue(request, "widgetAuth");
		
		if(widgetAuth == false) {
			return "wzwg/sysMngr/screen/widget/widgetClose";
		}
		
		SiteLayoutVO orgWidget = null;
		
		if(!"".equals(paramVO.getLayoutcntntsworkSeq()) && paramVO.getLayoutcntntsworkSeq() != null) {
			orgWidget = sysWidgetService.selectWidgetWorkData(paramVO);
		}else {
			orgWidget = sysWidgetService.selectWidgetData(paramVO);
		}
		
		int coursSearchResult = sysWidgetService.selectWidgetFileCoursSearch(orgWidget);
		
		if(coursSearchResult > 1) {
			return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
		}
		
		String widgetPath = request.getServletContext().getRealPath("/") + orgWidget.getSampleFileCours();
		
		File widgetDir = new File(widgetPath);
		int result = 0;
		
		if(widgetDir.exists() == false) {
			return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
		}else {
			sysWidgetService.deleteWidgetFile(widgetDir);
			result = sysWidgetService.deleteWidgetInfo(paramVO);
		}
		
		
		if(result > 0) {
			return CmmJsonAjaxResponser.getInstance().setResultCode("success").returnJsp(model);
		}else {
			return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
		}
	}
	
	/**
	 * 위젯 생성
	 */
	@RequestMapping(value="/sysMngr/screenHidden/registWidgetAjax.do")
	public String registWidgetAjax(
			@ModelAttribute("paramVO") SiteLayoutVO paramVO
			, HttpServletRequest request
			, ModelMap model
    )throws Exception {
		
		boolean widgetAuth = CmmSessionUtil.getSessionBooleanValue(request, "widgetAuth");
		
		if(widgetAuth == false) {
			return "wzwg/sysMngr/screen/widget/widgetClose";
		}
		
		SiteLayoutVO widgetVO = sysWidgetService.selectWidgetWorkData(paramVO);
		
		int result = 0;
		
		result = sysWidgetService.deleteWidgetInfo(paramVO);
		result = sysWidgetService.registWidgetInfo(widgetVO);
		
		
		if(result > 0) {
			return CmmJsonAjaxResponser.getInstance().setResultCode("success").returnJsp(model);
		}else {
			return CmmJsonAjaxResponser.getInstance().setResultCode("fail").returnJsp(model);
		}
	}
	
	
	
	
	/**
	 * 위젯 이미지관리자 호출
	 * @author moo0506
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/sysMngr/screenHidden/selectWidgetFileMngrAjax.do")
	public String selectWidgetFileMngrAjax(
			  @ModelAttribute("paramVO") SiteLayoutVO paramVO
			, HttpServletRequest request  
			, ModelMap model) throws Exception{
		
		
		boolean widgetAuth = CmmSessionUtil.getSessionBooleanValue(request, "widgetAuth");
		if(widgetAuth == false) {
			return "wzwg/sysMngr/screen/widget/widgetClose";
		}
		
		SiteLayoutVO orgWidget = null;
		
		if(!"".equals(paramVO.getLayoutcntntsworkSeq()) && paramVO.getLayoutcntntsworkSeq() != null) {
			orgWidget = sysWidgetService.selectWidgetWorkData(paramVO);
		}else {
			orgWidget = sysWidgetService.selectWidgetData(paramVO);
		}
		
		//model.addAttribute("widget", orgWidget);
		
		
		
		//System.out.println(templtVO.getTemplateStreCours());
		
		String realPath = request.getSession().getServletContext().getRealPath("/");
		String widgetPath = orgWidget.getSampleFileCours();
		
		//String cssDir = realPath + widgetPath + "css/";
		String imgDir = realPath + widgetPath + "img/";
		//String zipDir = realPath + widgetPath + "backup/zip/";
		
		//String cssPath = widgetPath + "css/";
		String imgPath = widgetPath + "img/";
		//String zipPath = widgetPath + "backup/zip/";
		
		
		
		
		//ArrayList<File> cssList = new ArrayList<File>();
		//findSubFiles(new File(FilenameUtils.separatorsToSystem(cssDir)), cssList);
		//model.addAttribute("cssList", convertFileListToMap(cssList, cssPath));
		
		
		ArrayList<File> imgList = new ArrayList<File>();
		findSubFiles(new File(FilenameUtils.separatorsToSystem(imgDir)), imgList);
		model.addAttribute("imgList", convertFileListToMap(imgList, imgPath));
		
//		ArrayList<File> zipList = new ArrayList<File>();
//		findSubFiles(new File(FilenameUtils.separatorsToSystem(zipDir)), zipList);
//		model.addAttribute("zipList", convertFileListToMap(zipList, zipPath));
		
		//List<Map<String, String>> cssList = addFilePathList(null, cssDir , cssPath, "css", true);
		//model.addAttribute("cssList", cssList);
		
		//List<Map<String, String>> imgList = addFilePathList(null, imgDir , imgPath, "css", true);
		//model.addAttribute("imgList", imgList);
		
		/*CmmJsonAjaxResponser responser = CmmJsonAjaxResponser.getInstance();
		responser.setResultCode("success");
		responser.setResultJsp("fileMngr", "wzwg/sysMngr/screen/siteScreenTemlptFileMngr");
		return responser.returnJsp(model);*/
		model.addAttribute("paramVO", paramVO);
		return "wzwg/sysMngr/screen/widget/widgetFileMngr";
		
	}
	
	/**
	 * 위젯 경로내에 img 파일 저장
	 */
	@RequestMapping(value="/sysMngr/screenHidden/registWidgetImageFileAjax.do")
	public String registScreenTempltResorceFileAjax(
			@ModelAttribute("paramVO") SiteLayoutVO paramVO
			, final MultipartHttpServletRequest multiRequest
			, HttpServletRequest request
			, ModelMap model
		) throws Exception{
		
		
		boolean widgetAuth = CmmSessionUtil.getSessionBooleanValue(request, "widgetAuth");
		if(widgetAuth == false) {
			return "wzwg/sysMngr/screen/widget/widgetClose";
		}
		
		SiteLayoutVO orgWidget = null;
		
		if(!"".equals(paramVO.getLayoutcntntsworkSeq()) && paramVO.getLayoutcntntsworkSeq() != null) {
			orgWidget = sysWidgetService.selectWidgetWorkData(paramVO);
		}else {
			orgWidget = sysWidgetService.selectWidgetData(paramVO);
		}
		
		String realPath = request.getSession().getServletContext().getRealPath("/");
		String templatePath = orgWidget.getSampleFileCours();
		
		String dir = "";
		String path = "";
		
		dir = realPath + templatePath + "img/";
		path = templatePath + "img/";
		
		File imageDir = new File(dir);
		if(imageDir.exists() == false) {
			boolean chkDir = imageDir.mkdirs();
			if(chkDir == false) {
				log.error(":::::::: widget img dir make fail ::::::::");
			}
		}
		
		List<MultipartFile> uploadList = multiRequest.getFiles("imgfiles");
		List<File> fileList = new ArrayList<File>(); 
		for (MultipartFile uploadFile : uploadList) {
			//System.out.println(uploadFile.getOriginalFilename() + "/" + uploadFile.getSize());
			File newFile = new File(dir + uploadFile.getOriginalFilename());
			uploadFile.transferTo(newFile);
			fileList.add(newFile);
		}
		
		//model.addAttribute("fileList", convertFileListToMap(fileList, path));
		
		return CmmJsonAjaxResponser.getInstance().setResultCode("success").setBodyData("fileList", convertFileListToMap(fileList, path)).returnJsp(model);
	}
	
	/**
	 * 위젯 경로내에 파일 삭제
	 */
	@RequestMapping(value="/sysMngr/screenHidden/deleteWidgetImageFileAjax.do")
	public String deleteWidgetImageFileAjax(
			@ModelAttribute("paramVO") SiteLayoutVO paramVO
			, String fileType
			, String fileName
			, HttpServletRequest request
			, ModelMap model
		) throws Exception{
		
		boolean widgetAuth = CmmSessionUtil.getSessionBooleanValue(request, "widgetAuth");
		if(widgetAuth == false) {
			return "wzwg/sysMngr/screen/widget/widgetClose";
		}
		
		SiteLayoutVO orgWidget = null;
		
		if(!"".equals(paramVO.getLayoutcntntsworkSeq()) && paramVO.getLayoutcntntsworkSeq() != null) {
			orgWidget = sysWidgetService.selectWidgetWorkData(paramVO);
		}else {
			orgWidget = sysWidgetService.selectWidgetData(paramVO);
		}
		
		String realPath = request.getSession().getServletContext().getRealPath("/");
		String templatePath = orgWidget.getSampleFileCours();
		
		String dir = realPath + templatePath + "img/";
		
		String result = "";
		
		File f = new File(dir + fileName);
		
		if(f.delete()){
			result = "success";
		}else{
			result = "fail";
		}
		
		
		//model.addAttribute("fileList", convertFileListToMap(fileList, path));
		
		return CmmJsonAjaxResponser.getInstance().setResultCode(result).returnJsp(model);
	}
	
	public void findSubFiles(File parentFile, ArrayList<File> subFiles){
		if(parentFile.isFile()){
			subFiles.add(parentFile);
		}else if(parentFile.isDirectory()){
			subFiles.add(parentFile); 
	        File[] childFiles= parentFile.listFiles(); 
	        //Arrays.sort(childFiles, Collections.reverseOrder());
	        if (childFiles != null) {
		        for(File childFile : childFiles){
		        	findSubFiles(childFile, subFiles);
		        }
	        }
	    } 
	} 
	
	private List<Map<String, String>> convertFileListToMap(List<File> fileList, String srcPath){
		List<Map<String, String>> resultList = new ArrayList<Map<String, String>>();
		
		Collections.sort(fileList);
		for (File file : fileList) {
			if(file.isDirectory()){
				continue;
			}
			//System.out.println(cssPathName + FilenameUtils.getBaseName(file.getPath()));
			String fullPath = FilenameUtils.separatorsToUnix(file.getAbsolutePath());
//			System.out.println(fullPath);
//			System.out.println(srcPath);
//			System.out.println(fullPath.indexOf(srcPath));
			String webPath = fullPath.substring(fullPath.indexOf(srcPath));
			String fileName = FilenameUtils.getName(file.getPath());
			webPath = webPath.replaceAll(fileName, "");
			Map<String, String> item = new HashMap<String, String>();
			item.put("path", webPath);
			item.put("fileName", fileName);
			item.put("size", sizeCalculation(file.length()) );
			resultList.add(item);
		}
		
		return resultList;
	}
	
	private strictfp String sizeCalculation(long size) {
	    String CalcuSize = null;
	    int i = 0;

	    double calcu = (double) size;
	    while (calcu >= 1024 && i < 5) { // 단위 숫자로 나누고 한번 나눌 때마다 i 증가
	        calcu = calcu / 1024;
	        i++;
	    }
	    DecimalFormat df = new DecimalFormat("##0.0");
	    switch (i) {
	        case 0:
	            CalcuSize = df.format(calcu) + "Byte";
	            break;
	        case 1:
	            CalcuSize = df.format(calcu) + "KB";
	            break;
	        case 2:
	            CalcuSize = df.format(calcu) + "MB";
	            break;
	        case 3:
	            CalcuSize = df.format(calcu) + "GB";
	            break;
	        case 4:
	            CalcuSize = df.format(calcu) + "TB";
	            break;
	        default:
	            CalcuSize="ZZ"; //용량표시 불가

	    }
	    return CalcuSize;
	}
}
