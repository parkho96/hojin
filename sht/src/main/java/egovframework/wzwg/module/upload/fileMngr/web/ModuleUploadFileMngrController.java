package egovframework.wzwg.module.upload.fileMngr.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.module.upload.fileMngr.service.ModuleUploadFileMngrService;

/**
 * ㅁ 시스템 - 사이트정보관리 - 사이트 첨부파일관리
 * ㅁ DC   
 * - 시스템관리자가 사이트별 첨부파일 용량 및 확장자 관리
 * @author CK
 *
 */
@Controller
public class ModuleUploadFileMngrController {

	@Resource(name="ModuleUploadFileMngrService")
	private ModuleUploadFileMngrService moduleUploadFileMngrService;
	

	@RequestMapping(value="/**/module/upload/fileMngr/fileEstbs/selectFileEstbsMngrForm.do")
	public String selectFileEstbsMngrForm(
			@ModelAttribute("resultVO") ModuleUploadFileVO resultVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		List<ModuleUploadFileVO> resultList = moduleUploadFileMngrService.selectFileTyCodeList();
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("fileEstbsSe", EgovProperties.getProperty("Globals.fileEstbs"));
		
		return "wzwg/module/upload/fileMngr/fileEstbsForm";
	}

	@RequestMapping(value="/**/module/upload/fileMngr/fileEstbs/modifyFileEstbsMngr.do")
	public ModelAndView modifyFileEstbsMngr(
			@ModelAttribute("resultVO") ModuleUploadFileVO resultVO
			, HttpServletRequest request
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			resultVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		result = moduleUploadFileMngrService.modifyFileEstbsMngr(resultVO);	// 저장
        
        if(result > 0){
            return CmmAjaxUtil.getAjaxReturn("success");
        }else{
            return CmmAjaxUtil.getAjaxReturn("fail");
        }
	}
	
	@RequestMapping(value="/**/module/upload/fileEstbs/selectFileEstbsInfoFormAjax.do")
	public String selectFileEstbsInfoForm(
			@ModelAttribute("resultVO") ModuleUploadFileVO resultVO
			, @RequestParam(value="sitecntntsSeq", required=false) String sitecntntsSeq
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		resultVO.setSitecntntsSeq(sitecntntsSeq);
		
		List<ModuleUploadFileVO> resultList = moduleUploadFileMngrService.selectEstbsFileTyCodeList(resultVO);
		
		model.addAttribute("resultList", resultList);
		
		return "wzwg/module/upload/file/fileEstbs";
	}
	
	@RequestMapping(value="/**/module/upload/fileEstbs/modifyFileEstbsInfo.do")
	public ModelAndView modifyFileEstbsInfo(
			@ModelAttribute("resultVO") ModuleUploadFileVO resultVO
			, HttpServletRequest request
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			resultVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		result = moduleUploadFileMngrService.modifyFileEstbsInfo(resultVO);	// 저장
        
        if(result > 0){
            return CmmAjaxUtil.getAjaxReturn("success");
        }else{
            return CmmAjaxUtil.getAjaxReturn("fail");
        }
	}
	
}
