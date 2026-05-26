package egovframework.wzwg.module.tabMenu.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.Globals;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.pageCallCtrl.service.PageCallCtrlVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.cmm.util.CmmXssUtil;
import egovframework.wzwg.module.ntt.cmmn.service.ModuleNttCmmnService;
import egovframework.wzwg.module.scrin.service.ScrinCntntsService;
import egovframework.wzwg.module.scrin.service.ScrinCntntsVO;
import egovframework.wzwg.module.tabMenu.service.ModuleTabMenuDataService;
import egovframework.wzwg.module.tabMenu.service.ModuleTabMenuDataVO;
import egovframework.wzwg.module.tabMenu.service.ModuleTabMenuInfoService;
import egovframework.wzwg.module.tabMenu.service.ModuleTabMenuInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoService;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuService;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuVO;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;
import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.SysModuleInfoService;
import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.SysModuleInfoVO;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ModuleTabMenuDataController {

	/** EgovPropertyService */
    @Resource(name="propertiesService")
    protected EgovPropertyService propertyService;
    
    /** ModuleTabMenuInfoService */
    @Resource(name="ModuleTabMenuInfoService")
    protected ModuleTabMenuInfoService tabMenuInfoService;
    
    /** ModuleTabMenuDataService */
    @Resource(name="ModuleTabMenuDataService")
    protected ModuleTabMenuDataService tabMenuDataService;
    
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    /** ModuleNttService */
    @Resource(name="ModuleNttCmmnService")
    protected ModuleNttCmmnService nttCmmnService;
    
    @Resource(name="SiteMenuService")
	private SiteMenuService siteMenuService;
    
    @Resource(name="SysModuleInfoService")
	private SysModuleInfoService sysModuleInfoService;
    
    /** 화면 컨텐츠 **/
    @Resource(name="ScrinCntntsService")
    private ScrinCntntsService scrinCntntsService;
    
    @Resource(name="CntntsInfoService")
	private CntntsInfoService cntntsInfoService;
    
    /**
	 * ㅁ 탭 메뉴 - 데이터관리 - 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/tabMenu/selectTabMenuDataListAjax.do")
	public String selectTabMenuList(
			@ModelAttribute("paramVO") ModuleTabMenuDataVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");

		if(loginVO != null){
			paramVO.setUsrSeq(loginVO.getUsrSeq());
		} else {
			paramVO.setUsrSeq("0");
		}		
		
		//List<CntntsInfoVO> tabMenuList = tabMenuInfoService.selectTabMenuInfoList(paramVO.getSiteSeq());
    	//
    	//if(paramVO.getTabSeq() == null && tabMenuList.size() > 0){
    	//	paramVO.setTabSeq(tabMenuList.get(0).getCntntsSeq());
    	//}
    	//
    	//model.addAttribute("bbsList", tabMenuList);
    	
    	ModuleTabMenuInfoVO resultVO = new ModuleTabMenuInfoVO();
		
		resultVO.setTabSeq(paramVO.getTabSeq());
		
		// 게시판 기본정보
		resultVO = tabMenuInfoService.selectTabMenuInfoDetail(resultVO);

		model.addAttribute("resultVO",	resultVO);

		// 목록
		List<ModuleTabMenuDataVO> resultList = tabMenuDataService.selectTabMenuDataList(paramVO);
		//
		//String firstNttSeq = "";
		//
		//if(resultList != null && resultList.size() > 0){
		//	if("".equals(paramVO.getTabSeq())){
		//		firstNttSeq = resultList.get(0).getTabSeq();
		//	}
		//}
		//
		//model.addAttribute("firstNttSeq", firstNttSeq);
		
//		model.addAttribute("nttAuthVO", 		nttCmmnService.selectCntntsAuthForNtt(request, paramVO.getMenuSeq()));
		model.addAttribute("resultList", 		resultList);

		
		return "wzwg/module/tabmenu/data/tabDataList";
		
	}
		
	/**
	 * ㅁ 탭 메뉴 - 데이터관리 - 상세보기
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/tabMenu/selectTabMenuDataDetailAjax.do")
	public String selectTabMenuDataDetail(
			@ModelAttribute("paramVO") ModuleTabMenuDataVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		ModuleTabMenuInfoVO moduleTabInfoVO = new ModuleTabMenuInfoVO();
		
		moduleTabInfoVO.setTabSeq(paramVO.getTabSeq());
		
		// 게시판 기본정보
		moduleTabInfoVO = tabMenuInfoService.selectTabMenuInfoDetail(moduleTabInfoVO);
		
		model.addAttribute("moduleTabInfoVO", moduleTabInfoVO);	
		
		// 조회수 증가 (이딴건 하지 않는다)
		//nttCmmnService.modifyNttInqireCnt(paramVO);
				
		ModuleTabMenuDataVO resultVO = tabMenuDataService.selectTabMenuDataDetail(paramVO);
		
		//model.addAttribute("nttAuthVO", nttCmmnService.selectCntntsAuthForNtt(request, paramVO.getMenuSeq()));		
		
		if(resultVO != null){
			model.addAttribute("resultVO", resultVO);
			
			//ModuleNttTagVO tagVO = new ModuleNttTagVO();
			//tagVO.setSiteSeq(paramVO.getSiteSeq());
			//tagVO.setNttSeq(paramVO.getNttSeq());
			//
			//List<ModuleNttTagVO> tagList = nttTagService.selectNttTagList(tagVO);
			//model.addAttribute("tagList", tagList);
			
			
		}else{
			model.addAttribute("resultVO", paramVO);
		}
    
		//model.addAttribute("fileEstbsSe", 	EgovProperties.getProperty("Globals.fileEstbs"));
		if(resultVO != null) {
			if(resultVO.getTabClSe().equals("M")) {
				SysModuleInfoVO sysmoduleParamVO = new SysModuleInfoVO();
				sysmoduleParamVO.setSysmoduleSeq(resultVO.getSysmoduleSeq());
				SysModuleInfoVO moduleVO = sysModuleInfoService.selectSysModuleInfoDetail(sysmoduleParamVO);
				model.addAttribute("moduleVO", moduleVO);
				
				CntntsInfoVO cntntsInfoParamVO = new CntntsInfoVO();
				cntntsInfoParamVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
				cntntsInfoParamVO.setSearchCntntsSeq(resultVO.getSitecntntsSeq());
				CntntsInfoVO cntntsInfoVO = cntntsInfoService.selectCntntsBassInfo(cntntsInfoParamVO);
				model.addAttribute("cntntsInfoVO", cntntsInfoVO);
			}
		}
		
		return "wzwg/module/tabmenu/data/tabDataDetail"; 
	}
	
	
	/**
	 * ㅁ 탭 메뉴 - 데이터관리 - 등록 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/**/module/tabMenu/registTabMenuDataFormAjax.do")
	public String registTabMenuDataForm(
			@ModelAttribute("paramVO") ModuleTabMenuDataVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		//CntntsAuthVO nttAuthVO = nttCmmnService.selectCntntsAuthForNtt(request, paramVO.getMenuSeq());
		//boolean mngrAt = nttCmmnService.sessionMngrAuthForNtt(request);
        //
		//if(!mngrAt && !"W".equals(nttAuthVO.getAuthorSe())){
		//	model.addAttribute("authorMessage", egovMessageSource.getMessage("wzwg.cmm.msg.MSG084"));
		//	return "forward:" + Globals.URL_PREFIX + "/module/ntt/cl/selectNttListAjax.do";
		//}
		
		//List<CntntsInfoVO> bbsList = bbsCmmnService.selectBbsList(paramVO.getSiteSeq());
    	//model.addAttribute("bbsList", bbsList);
    	
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setUsrSeq(loginVO.getUsrSeq());
		}
		
		//String formCn = nttCmmnService.selectNttFormCn(paramVO.getBbsSeq());
		
		//if(formCn != null){
		//	paramVO.setNttCn(formCn);
		//}
		
    	// 임시게시물 목록
    	//Integer tmprnttListCnt = nttCmmnService.selectTmprnttListTotCnt(paramVO);
    	//model.addAttribute("tmprnttListCnt", tmprnttListCnt);
		
    	//ModuleNttTagVO tagVO = new ModuleNttTagVO();
		//tagVO.setSiteSeq(paramVO.getSiteSeq());
		//tagVO.setUsrSeq(loginVO.getUsrSeq());
		
		// 나의 태그 목록
		//List<ModuleNttTagVO> myTagList = nttTagService.selectNttUsrTagList(tagVO);
		//model.addAttribute("myTagList", myTagList);
		
		//model.addAttribute("nttAuthVO", nttAuthVO);		
    
		//model.addAttribute("fileEstbsSe", 	EgovProperties.getProperty("Globals.fileEstbs"));
		//model.addAttribute("editorEstbsSe", EgovProperties.getProperty("Globals.editorEstbs"));
		
		
		
		/**
		 * 모듈 연결을 위해 추가 tabsub
		 */
		SiteMenuVO siteMenuVO = new SiteMenuVO();
		siteMenuVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		Map<String, Object> siteMenuList = siteMenuService.registSiteMenuMngrInfo(siteMenuVO);
		
		List<CntntsInfoVO> cntntsList = (List<CntntsInfoVO>)siteMenuList.get("CNTNTS_LIST");
		List<CntntsInfoVO> moduleList = getUseModuleFilter(cntntsList);
    
		model.addAttribute("moduleList", moduleList);
		
		
		
		/* 코트라전용 지도탭CSS 선택시 지방지원단 목록을 불러오기 위한 조치 */
		//ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
		//moduleBbsVO.setBbsSeq(paramVO.getBbsSeq());
		//ModuleBbsCssVO moduleBbsCssVO = new ModuleBbsCssVO();
		//
		//moduleBbsCssVO = bbsCmmnService.selectBbsCssSeq(moduleBbsVO);
		//
		//if(moduleBbsCssVO != null && moduleBbsCssVO.getCssSeq() != null && moduleBbsCssVO.getCssSeq().equals("10000000146")) {
		//	moduleBbsCssVO = bbsCmmnService.selectBbsCssDetail(moduleBbsCssVO);		
		//
		//	//지도목록cSS 일 경우 지원단목록 조회
		//	KDeptCodeVO deptCodeVO = new KDeptCodeVO();
		//	deptCodeVO.setUpperDeptCd("8920");//지방지원단 부모코드
		//	List<KDeptCodeVO> deptCodeList = kDeptCodeService.selectDeptCodeKSCList(deptCodeVO);
		//	
		//	model.addAttribute("deptCodeList", deptCodeList);
		//	
		//	//ModuleNttVO nttDeptVO = nttClService.selectNttAdiInfoDeptCd(paramVO);
		//	//model.addAttribute("nttDeptVO", nttDeptVO);
		//}
		//
		//model.addAttribute("moduleBbsCssVO", moduleBbsCssVO);
		
		return "wzwg/module/tabmenu/data/tabDataRegist"; 
	}
	
	/**
	 * ㅁ 탭 메뉴 - 데이터관리 - 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/tabMenu/registTabMenuDataAjax.do")
	public ModelAndView registTabMenuDataAjax(
			@ModelAttribute("paramVO") ModuleTabMenuDataVO paramVO
			, HttpServletRequest request
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setNtcrId(loginVO.getUserId());
			paramVO.setNtcrNm(loginVO.getUserNm());
			paramVO.setUsrSeq(loginVO.getUsrSeq());
			paramVO.setNtcrSeq(loginVO.getUsrSeq());
		}
		paramVO.setTabdataSeq(tabMenuDataService.selectNextTabMenuDataSeq(paramVO));
		paramVO.setTabdataSj(CmmXssUtil.unscript(paramVO.getTabdataSj()));
		//paramVO.setTabCn(paramVO.getTabCn().replaceAll("&quot;", "\""));
		
		result = tabMenuDataService.registTabMenuData(paramVO);	// 저장
		
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn(paramVO.getTabdataSeq());
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ 탭 메뉴 - 데이터관리 - 수정 폼
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/tabMenu/modifyTabMenuDataFormAjax.do")
	public String modifyTabMenuDataForm(
			@ModelAttribute("paramVO") ModuleTabMenuDataVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		//CntntsAuthVO nttAuthVO = nttCmmnService.selectCntntsAuthForNtt(request, paramVO.getMenuSeq());
		//boolean mngrAt = nttCmmnService.sessionMngrAuthForNtt(request);
        //
		//if(!mngrAt && !"W".equals(nttAuthVO.getAuthorSe())){
		//	model.addAttribute("authorMessage", egovMessageSource.getMessage("wzwg.cmm.msg.MSG084"));
		//	return "forward:" + Globals.URL_PREFIX + "/module/ntt/cl/selectNttListAjax.do";
		//}
		
		//List<CntntsInfoVO> bbsList = bbsCmmnService.selectBbsList(paramVO.getSiteSeq());
    	//model.addAttribute("bbsList", bbsList);
    	
    	HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
    	ModuleTabMenuDataVO resultVO = tabMenuDataService.selectTabMenuDataDetail(paramVO);
    	
		if(resultVO != null){
			
			//if(!mngrAt && !loginVO.getUserId().equals(resultVO.getNtcrId())){
			//	model.addAttribute("authorMessage", egovMessageSource.getMessage("wzwg.cmm.msg.MSG084"));
			//	return "forward:" + Globals.URL_PREFIX + "/module/ntt/cl/selectNttListAjax.do";
			//}
			
			//ModuleNttTagVO tagVO = new ModuleNttTagVO();
			//tagVO.setSiteSeq(paramVO.getSiteSeq());
			//tagVO.setNttSeq(paramVO.getNttSeq());
			//tagVO.setUsrSeq(loginVO.getUsrSeq());
			//
			//// 등록된 태그 목록
			//List<ModuleNttTagVO> tagList = nttTagService.selectNttTagList(tagVO);
			//
			//if(tagList.size() > 0){
			//	String tagArr = "";
			//	
			//	for(int i = 0; i < tagList.size(); i++) {
			//		tagArr += tagList.get(i).getTagNm() + ",";
			//	}
			//	
			//	resultVO.setTagArr(tagArr.substring(0, tagArr.length() - 1));
			//}
			
			model.addAttribute("resultVO", resultVO);			
			
			if (loginVO != null) {
				paramVO.setUsrSeq(loginVO.getUsrSeq());
			}
			
			// 임시게시물 목록
	    	//Integer tmprnttListCnt = nttCmmnService.selectTmprnttListTotCnt(paramVO);
	    	//model.addAttribute("tmprnttListCnt", tmprnttListCnt);
    
			// 나의 태그 목록
			//List<ModuleNttTagVO> myTagList = nttTagService.selectNttUsrTagList(tagVO);
			//model.addAttribute("myTagList", myTagList);
			
		}else{
			model.addAttribute("resultVO", paramVO);
		}
		
		//model.addAttribute("nttAuthVO", nttAuthVO);
    
		//model.addAttribute("fileEstbsSe", 	EgovProperties.getProperty("Globals.fileEstbs"));
		//model.addAttribute("editorEstbsSe", EgovProperties.getProperty("Globals.editorEstbs"));
		
		
		/**
		 * 모듈 연결을 위해 추가 tabsub
		 */
		SiteMenuVO siteMenuVO = new SiteMenuVO();
		siteMenuVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		Map<String, Object> siteMenuList = siteMenuService.registSiteMenuMngrInfo(siteMenuVO);
		
		List<CntntsInfoVO> cntntsList = (List<CntntsInfoVO>)siteMenuList.get("CNTNTS_LIST");
		List<CntntsInfoVO> moduleList = getUseModuleFilter(cntntsList);
				
		model.addAttribute("moduleList", moduleList);
		
		
		return "wzwg/module/tabmenu/data/tabDataModify"; 
	}
	
	/**
	 * ㅁ 탭 메뉴 - 데이터관리 - 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/tabMenu/modifyTabMenuDataAjax.do")
	public ModelAndView modifyTabMenuData(
			@ModelAttribute("paramVO") ModuleTabMenuDataVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setUsrSeq(loginVO.getUsrSeq());
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		paramVO.setTabdataSj(CmmXssUtil.unscript(paramVO.getTabdataSj()));
		//paramVO.setTabCn(paramVO.getTabCn().replaceAll("&quot;", "\""));
		
		result = tabMenuDataService.modifyTabMenuData(paramVO);	// 수정
		
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ 탭 메뉴 - 데이터관리 - 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/tebMenu/deleteTabMenuDataAjax.do")
	public ModelAndView deleteTabMenuData(
			@ModelAttribute("paramVO") ModuleTabMenuDataVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		result = tabMenuDataService.deleteTabMenuData(paramVO);			// 삭제
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ 탭 메뉴 - 데이터관리 - 순서 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/tabMenu/modifyTabMenuListOrdrAjax.do")
	public ModelAndView modifyTabMenuListOrdrAjax(
			@ModelAttribute("paramVO") ModuleTabMenuDataVO paramVO
			, HttpServletRequest request 
			, ModelMap model
			) throws Exception{
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		result = tabMenuDataService.modifyTabDataListOrdr(paramVO);	// 수정
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ 휴지통 - 목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	//@RequestMapping(value="/**/module/ntt/cl/selectNttRecycleListAjax.do")
	//public String selectNttRecycleList(
	//		@ModelAttribute("paramVO") ModuleNttVO paramVO
	//		, HttpServletRequest request 
	//		, ModelMap model
	//	) throws Exception{
	//	
    //	HttpSession session = request.getSession();
	//	CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
    //
	//	if(loginVO != null){
	//		paramVO.setUsrSeq(loginVO.getUsrSeq());
	//	} else {
	//		paramVO.setUsrSeq("0");
	//	}		
	//	
	//	List<CntntsInfoVO> bbsList = bbsCmmnService.selectBbsList(paramVO.getSiteSeq());
    //	
    //	if(paramVO.getBbsSeq() == null && bbsList.size() > 0){
    //		paramVO.setBbsSeq(bbsList.get(0).getCntntsSeq());
    //	}
    //	
    //	model.addAttribute("bbsList", bbsList);
    //	
	//	paramVO.setPageUnit(propertyService.getInt("pageUnit"));
	//	paramVO.setPageSize(propertyService.getInt("pageSize"));
    //
	//	PaginationInfo paginationInfo = new PaginationInfo();
    //
	//	paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
	//	paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
	//	paginationInfo.setPageSize(paramVO.getPageSize());
    //
	//	paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
	//	paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
	//	paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	//	
	//	ModuleBbsVO resultVO = new ModuleBbsVO();
	//	
	//	resultVO.setBbsSeq(paramVO.getBbsSeq());
	//	
	//	// 게시판 기본정보
	//	resultVO = bbsClBassInfoService.selectBbsBassInfoDetail(resultVO);
	//	
	//	model.addAttribute("resultVO", 			resultVO);
	//	
	//	// 목록
	//	List<ModuleNttVO> resultList = nttClService.selectNttRecycleList(paramVO);
	//	
	//	// 목록 총 갯수
	//	Integer resultCnt = nttClService.selectNttRecycleListTotCnt(paramVO);
	//	
	//	paginationInfo.setTotalRecordCount(resultCnt.intValue());
	//	
	//	model.addAttribute("nttAuthVO", 		nttCmmnService.selectCntntsAuthForNtt(request, paramVO.getMenuSeq()));
	//	
	//	model.addAttribute("resultList", 		resultList);
	//	model.addAttribute("resultCnt", 		resultCnt);
	//	model.addAttribute("paginationInfo", 	paginationInfo);
    //
	//	/** 코트라 부서권한 조회 추가 */
	//	KCntntsAuthVO kAuthVO = new KCntntsAuthVO();
	//	kAuthVO.setCntntsSn(paramVO.getSitecntntsSeq());
	//	List<KCntntsAuthVO> KCntntsAuthList = kCntntsAuthService.selectCntntsDeptAuthList(kAuthVO);
	//	model.addAttribute("KCntntsAuthList", KCntntsAuthList);
	//	
	//	return "wzwg/module/ntt/cl/nttRecycleList";
	//	
	//}	

	/**
	 * ㅁ 휴지통 - 복원
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	//@RequestMapping(value="/**/module/ntt/cl/modifyNttRecycleAjax.do")
	//public ModelAndView modifyNttRecycle(
	//		@ModelAttribute("paramVO") ModuleNttVO paramVO
	//		, HttpServletRequest request 
	//		, ModelMap model
	//	) throws Exception{
	//	
	//	int result = 0;
	//	
	//	HttpSession session = request.getSession();
	//	CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
	//	
	//	paramVO.setLastUpdusrId(loginVO.getUserId());
	//	
	//	if(paramVO.getCheckNttSeq() == null){
	//		result = nttCmmnService.modifyNttRecycle(paramVO);			// 복원
	//	}else{
	//		result = nttCmmnService.modifyCheckNttRecycle(paramVO);	// 체크박스 목록 복원
	//	}
	//	
	//	if(result > 0){
	//		return CmmAjaxUtil.getAjaxReturn("success");
	//	}else{
	//		return CmmAjaxUtil.getAjaxReturn("fail");
	//	}
	//}
	
	/**
	 * ㅁ 휴지통 - 선택삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	//@RequestMapping(value="/**/module/ntt/cl/deleteNttAjax.do")
	//public ModelAndView deleteNtt(
	//		@ModelAttribute("paramVO") ModuleNttVO paramVO
	//		, HttpServletRequest request 
	//		, ModelMap model
	//	) throws Exception{
	//	
	//	int result = 0;
	//	
	//	HttpSession session = request.getSession();
	//	CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
	//	
	//	if(loginVO == null){
	//		paramVO.setBbsSeq("0");
	//	}		
	//	
	//	paramVO.setDelSe("");
	//	result = nttCmmnService.deleteSiteNtt(paramVO);
    //
	//	if(result > 0){
	//		return CmmAjaxUtil.getAjaxReturn("success");
	//	}else{
	//		return CmmAjaxUtil.getAjaxReturn("fail");
	//	}
	//}	
	
	/**
	 * ㅁ 휴지통 - 전체삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	//@RequestMapping(value="/**/module/ntt/cl/deleteNttAllAjax.do")
	//public ModelAndView deleteNttAll(
	//		@ModelAttribute("paramVO") ModuleNttVO paramVO
	//		, HttpServletRequest request 
	//		, ModelMap model
	//	) throws Exception{
	//	
	//	int result = 0;
	//	
	//	HttpSession session = request.getSession();
	//	CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
	//	
	//	if(loginVO == null){
	//		paramVO.setBbsSeq("0");
	//	}		
	//	
	//	paramVO.setDelSe("ALL");
	//	result = nttCmmnService.deleteSiteNtt(paramVO);
    //
	//	if(result > 0){
	//		return CmmAjaxUtil.getAjaxReturn("success");
	//	}else{
	//		return CmmAjaxUtil.getAjaxReturn("fail");
	//	}
	//}	
	
	@RequestMapping(value="/**/module/tabMenu/siteMenuCntntListAjax.do")
	public   String siteMenuCntntList(
			@ModelAttribute("paramVO")SiteMenuVO siteMenuVO
			, HttpServletRequest request
			, HttpServletResponse response
			, Model model ) throws Exception {
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		siteMenuVO.setSiteSeq(siteSeq);
		model.addAttribute("menuCntntList", siteMenuService.selectSiteMenuCntntList(siteMenuVO));
		
		return "wzwg/module/tabmenu/data/siteMenuCntntList";
	}
	
	/**
     * ㅁ RESTFUL 서브페이지 목록 호출 제어
     * 분류게시판 모듈 호출 코어 프로세스
     * @param request
     * @param model
     * @return
     * @throws Exception
     */
    @RequestMapping(value={"/subList/{sysmoduleSeq}/tabMenuModuleCallAjax.do","/{siteKey}/subList/{sysmoduleSeq}/tabMenuModuleCallAjax.do"})
    public String tabMenuModuleCallAjax(ScrinCntntsVO paramVO
    		, String pmode
    		, String nttSeq
            , HttpServletRequest request
            , HttpSession session
            , Model model) throws Exception {
    	String returnUrl = "wzwg/module/test";
    	try{
		//        PageCallCtrlVO paramVO = new PageCallCtrlVO(); 
		        
		        String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		        
		//        paramVO.setSiteSeq(siteSeq);
		//        paramVO.setMenuSeq(menuSeq);
		        
		        // 메뉴에 매핑된 모듈을 알수있는 SEQ 값을 가져온다
		//        String sitecntntsSeq = pageCallCtrlService.selectMenuSeqBySiteCntntsSeq(paramVO);
		       // String sitecntntsSeq = (String)request.getAttribute("sitecntntsSeq");
		        
		        //ScrinCntntsVO scrinVO = new ScrinCntntsVO();
		        PageCallCtrlVO  pageVO = new PageCallCtrlVO();
		        
		        paramVO.setSiteSeq(siteSeq);
		        //scrinVO.setSitecntntsSeq(paramVO.getSitecntntsSeq());
		        //scrinVO.setMenuSeq(menuSeq);
		        
		        pageVO.setSiteSeq(siteSeq);
		        //pageVO.setMenuSeq(menuSeq);
		
		        if(paramVO.getModuleTyCode().equals("SC00000033")) {
		        	//솔루션 타입일 경우
		        	SysModuleInfoVO sysmoduleVO = new SysModuleInfoVO();
		        	sysmoduleVO.setSysmoduleSeq(paramVO.getSysmoduleSeq());
		        	
		        	SysModuleInfoVO solutionVO = sysModuleInfoService.selectSysModuleInfoDetail(sysmoduleVO);
		        	model.addAttribute("url", CmmSysParameterSetUtil.getUrlWzwgContext(request) +  solutionVO.getUsrPageUrl());
	        		returnUrl = "/wzwg/module/tabmenu/data/tabModuleCall";
		        }else {
		        	ScrinCntntsVO cntntsInfo = null;
		        	//if(menuLinkUrl.equals("")){
		        	// 컨텐츠 정보를 가져옴
		        	cntntsInfo = scrinCntntsService.selectSitecntntsSeqByModuleInfo(paramVO);
		        	
		        	// 컨텐츠 데이터를 가져옴
		        	Object cntntsData = scrinCntntsService.selectScrinCntntsObject(cntntsInfo);
		        	
		        	// 컨텐츠 데이터를 JSON 변환하여 넘김
		        	model.addAttribute("cntntsData", cntntsData);
		        	model.addAttribute("cntntsInfo", cntntsInfo);
		        	//}
		        	
		        	
		        	// 컨텐츠 모듈일떄...
		        	if (Globals.CNTNTS_MODULE_SEQ.equals(cntntsInfo.getModuleTyCode())) {
		        		returnUrl = "/wzwg/module/cmm/cntntsView";
		        	}
		        	
		        	String wzwgContextPath = CmmSysParameterSetUtil.getUrlWzwgContext(request);
		        	
		        	// 게시판 모듈일떄...
		        	if (Globals.BBS_MODULE_TY_CODE.equals(cntntsInfo.getModuleTyCode())) {
		        		String pckagePath = "/" + cntntsInfo.getPckagePath();
		        		String cntntsSeq = cntntsInfo.getCntntsSeq();
		        		returnUrl = "redirect:" + wzwgContextPath + pckagePath + "/selectBbsInc.do?cntntsSeq=" + cntntsSeq + "&sitecntntsSeq="+cntntsInfo.getSitecntntsSeq()+"&menuSeq=" + CmmSessionUtil.getSessionValue(request, "menuSeq");
		        		if(pmode != null && pmode.equals("") == false) {
		        			returnUrl += "&pmode=" + pmode + "&nttSeq=" + nttSeq; 	
		        		}
		        	}
		        	
		        	// 일반 모듈일떄...
		        	if (Globals.NOMAL_MODULE_TY_CODE.equals(cntntsInfo.getModuleTyCode())) {
		        		String usrPageUrl = cntntsInfo.getUsrPageUrl();
		        		String pckagePath = "/" + cntntsInfo.getPckagePath();
		        		String cntntsSeq = cntntsInfo.getCntntsSeq();
		        		model.addAttribute("url", "/" + usrPageUrl + "?cntntsSeq=" + cntntsSeq + "&sitecntntsSeq="+cntntsInfo.getSitecntntsSeq()+"&menuSeq=" + CmmSessionUtil.getSessionValue(request, "menuSeq"));
		        		returnUrl = "/wzwg/module/tabmenu/data/tabModuleCall";
		        	}
		        	
		        	if (Globals.SCHDUL_MODULE_TY_CODE.equals(cntntsInfo.getModuleTyCode())) {
		        		String usrPageUrl = cntntsInfo.getUsrPageUrl();
		        		String pckagePath = "/" + cntntsInfo.getPckagePath();
		        		model.addAttribute("url", "/" + usrPageUrl + "?&sitecntntsSeq="+cntntsInfo.getSitecntntsSeq()+"&menuSeq=" + CmmSessionUtil.getSessionValue(request, "menuSeq"));
		        		returnUrl = "/wzwg/module/tabmenu/data/tabModuleCall";
		        	} 
		        	
		        }
		        
    		}catch(RuntimeException e){
    			log.error("nttClModuleCallAjax error ==== " , e);
    		}
    	
    	//System.out.println(returnUrl);
    	
    	return returnUrl;
    }
    
    /**
     * 탭에 사용될 모듈 필터
     * @param cntntsList
     * @return
     */
    private List<CntntsInfoVO> getUseModuleFilter(List<CntntsInfoVO> cntntsList) {
		List<CntntsInfoVO> moduleList = new ArrayList<CntntsInfoVO>();
		for (CntntsInfoVO cntntsInfoVO : cntntsList) {
			if(cntntsInfoVO.getModuleTyCode().equals("SC00000030")		//게시판이거나
				|| cntntsInfoVO.getModuleTyCode().equals("SC00000031")	//일정 지도일때
				|| cntntsInfoVO.getModuleTyCode().equals("SC00000032")	//컨텐츠 타입
					) {
				//moduleList.add(cntntsInfoVO);
				
				if(cntntsInfoVO.getSysmoduleSeq().equals("10000000238") == false		//탭메뉴 제외(본인모듈)
						&& cntntsInfoVO.getSysmoduleSeq().equals("10000000216") == false	//탭게시판 제외
						&& cntntsInfoVO.getSysmoduleSeq().equals("10000000210") == false	//온라인신청 제외
						) {
					moduleList.add(cntntsInfoVO);
				}
			}
			
		}
		
		return moduleList;
    }
    
}
