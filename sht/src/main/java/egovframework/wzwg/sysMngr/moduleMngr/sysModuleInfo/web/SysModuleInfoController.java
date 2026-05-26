package egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.web;

import java.util.List;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeVO;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;
import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.SysModuleInfoService;
import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.SysModuleInfoVO;

/**
 * * ㅁ 시스템 - 시스템 모듈관리
 * ㅁ DC   
 * - 시스템 모듈관리
 * @author njeil
 *
 */
@Controller
public class SysModuleInfoController {
	
	 /** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;

	/** 공통코드 **/
	@Resource(name="CmmCodeService")
	private CmmCodeService codeService;
	
	@Resource(name="SysModuleInfoService")
	private SysModuleInfoService sysModuleInfoService;
	

	@ModelAttribute("moduleTyCodeList")
    public List<CmmCodeVO> selectModuleTyCodeList() throws Exception {
	     
	    return codeService.selectCmmCodeList("MODULE_TY_CODE");   
	}

	/**
	 * ㅁ 시스템 - 시스템 모듈정보 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/moduleMngr/sysModuleInfo/selectSysModuleInfoList.do")
	public String selectSysModuleInfoList(@ModelAttribute("paramVO") SysModuleInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		
		paramVO.setPageUnit(propertyService.getInt("pageUnit"));
		paramVO.setPageSize(propertyService.getInt("pageSize"));

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
		paginationInfo.setPageSize(paramVO.getPageSize());

		paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
		paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		// 시스템 모듈 목록
		List<SysModuleInfoVO> resultList = sysModuleInfoService.selectSysModuleInfoList(paramVO);
		
		int resultcnt = sysModuleInfoService.selectSysModuleInfoListCnt(paramVO);
		
		paginationInfo.setTotalRecordCount(resultcnt);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", resultcnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("paramVO", paramVO);
		
		return "wzwg/sysMngr/moduleMngr/sysModuleInfo/sysModuleInfoList";
	}
	
	/**
	 * ㅁ 시스템 - 시스템 모듈정보 상세
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/moduleMngr/sysModuleInfo/selectSysModuleInfoDetail.do")
	public String selectSysModuleInfoDetail(@ModelAttribute("paramVO") SysModuleInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		
		SysModuleInfoVO resultVO = sysModuleInfoService.selectSysModuleInfoDetail(paramVO);

		if (resultVO != null) {
			model.addAttribute("resultVO", resultVO);
		} else {
			model.addAttribute("resultVO", new SysModuleInfoVO());
		}
		model.addAttribute("paramVO", paramVO);
		
		return "wzwg/sysMngr/moduleMngr/sysModuleInfo/sysModuleInfoDetail";
	}
	
	/**
	 * ㅁ 시스템 - 시스템 모듈정보 등록페이지
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/moduleMngr/sysModuleInfo/selectSysModuleInfoForm.do")
	public String selectSysModuleInfoForm(@ModelAttribute("paramVO") SysModuleInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		
		return "wzwg/sysMngr/moduleMngr/sysModuleInfo/sysModuleInfoForm";
	}
	
	/**
	 * ㅁ 시스템 - 시스템 모듈정보 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/moduleMngr/sysModuleInfo/registSysModuleInfo.do")
	public String registSysModuleInfo(@ModelAttribute("paramVO") SysModuleInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		
		sysModuleInfoService.registSysModuleInfo(paramVO);
		
		return "forward:"+wzwgContext+"/sysMngr/moduleMngr/sysModuleInfo/selectSysModuleInfoList.do";
	}
	
	/**
	 * ㅁ 시스템 - 시스템 모듈정보 수정페이지
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/moduleMngr/sysModuleInfo/selectSysModuleInfoModifyForm.do")
	public String selectSysModuleInfoModifyForm(@ModelAttribute("paramVO") SysModuleInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		
		SysModuleInfoVO resultVO = sysModuleInfoService.selectSysModuleInfoDetail(paramVO);

		if (resultVO != null) {
			model.addAttribute("resultVO", resultVO);
		} else {
			model.addAttribute("resultVO", new SysModuleInfoVO());
		}
		model.addAttribute("paramVO", paramVO);

		
		return "wzwg/sysMngr/moduleMngr/sysModuleInfo/sysModuleInfoModifyForm";
	}
	
	/**
	 * ㅁ 시스템 - 시스템 모듈정보 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/moduleMngr/sysModuleInfo/modifySysModuleInfo.do")
	public String modifySysModuleInfo(@ModelAttribute("paramVO") SysModuleInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		
		sysModuleInfoService.modifySysModuleInfo(paramVO);
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		
		return "forward:"+wzwgContext+"/sysMngr/moduleMngr/sysModuleInfo/selectSysModuleInfoList.do";
	}
	
	/**
	 * ㅁ 시스템 - 시스템 모듈정보 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/moduleMngr/sysModuleInfo/deleteSysModuleInfo.do")
	public String deleteSysModuleInfo(@ModelAttribute("paramVO") SysModuleInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model) throws Exception{
		
		sysModuleInfoService.deleteSysModuleInfo(paramVO);
		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		
		return "forward:"+wzwgContext+"/sysMngr/moduleMngr/sysModuleInfo/selectSysModuleInfoList.do";
	}
	
}
