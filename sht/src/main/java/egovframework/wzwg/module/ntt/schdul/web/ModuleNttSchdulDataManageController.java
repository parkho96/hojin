package egovframework.wzwg.module.ntt.schdul.web;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.property.EgovPropertyService;
import org.egovframe.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmAjaxUtil;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.cmm.util.CmmXssUtil;
import egovframework.wzwg.cmm.util.JacksonMapperUtil;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsCmmnService;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsCssVO;
import egovframework.wzwg.module.ntt.schdul.service.ModuleNttSchdulDataManageService;
import egovframework.wzwg.module.ntt.schdul.service.ModuleNttSchdulDataManageVO;
import egovframework.wzwg.module.schdul.service.ModuleSchdulBassInfoService;
import egovframework.wzwg.module.schdul.service.ModuleSchdulBassInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthService;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthVO;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeService;
import egovframework.wzwg.sysMngr.cmm.code.service.CmmCodeVO;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;
import egovframework.wzwg.sysMngr.usrMngr.usrInfo.service.SysMngrUsrInfoService;
import egovframework.wzwg.sysMngr.usrMngr.usrInfo.service.SysMngrUsrInfoVO;



@Controller
public class ModuleNttSchdulDataManageController {
	
	/** EgovPropertyService */
	@Resource(name="propertiesService")
	private EgovPropertyService propertyService;

	/** ModuleBbsCmmnService */
	@Resource(name="ModuleNttSchdulDataManageService")
	private ModuleNttSchdulDataManageService shdulDataManageService;
	
    @Resource(name="SysMngrUsrInfoService")
	private SysMngrUsrInfoService usrInfoService;
    
    @Resource(name="ModuleSchdulBassInfoService")
    private ModuleSchdulBassInfoService schdulService;
    
    @Resource(name="CntntsAuthService")
    protected CntntsAuthService cntntsAuthService;	

    /** ModuleBbsCmmnService(CSS 정보조회로 인해 사용) */
    @Resource(name="ModuleBbsCmmnService")
    protected ModuleBbsCmmnService bbsCmmnService;
    
    @Resource(name="CmmCodeService")
    CmmCodeService cmmCodeService;

	/**
	 * 일정 달력형 / 목록형 분기
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
    @RequestMapping(value="/**/module/ntt/schdul/selectSchdulNttInitAjax.do")
    public String selectSchdulNttInitAjax(
    		@ModelAttribute("paramVO") ModuleNttSchdulDataManageVO paramVO
			, HttpServletRequest request 
			, ModelMap model
    	) throws Exception{

		String wzwgContext = CmmSysParameterSetUtil.getUrlWzwgContext(request);
    	
		//일정기본정보 상세 조회
    	ModuleSchdulBassInfoVO paramSchdulBassInfoVO = new ModuleSchdulBassInfoVO();
    	paramSchdulBassInfoVO.setSchdulSeq(paramVO.getSchdulSeq());
		ModuleSchdulBassInfoVO resultVO = schdulService.selectSchdulBassInfoDetail(paramSchdulBassInfoVO);
		
		if(resultVO != null && !("").equals(resultVO.getInitScrin())){
			if(!("L").equals(resultVO.getInitScrin())){
				return "forward:"+wzwgContext+CmmSessionUtil.getSessionMngrSitePrefix(request)+"/module/ntt/schdul/selectSchdulNttMonthAjax.do";
			}else{
				return "forward:"+wzwgContext+CmmSessionUtil.getSessionMngrSitePrefix(request)+"/module/ntt/schdul/selectSchdulNttListAjax.do";
			}
		}else{
			return "forward:"+wzwgContext+CmmSessionUtil.getSessionMngrSitePrefix(request)+"/module/ntt/schdul/selectSchdulNttMonthAjax.do";
		}
    }
	
	/**
	 * ㅁ  일정 - 월간
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/module/ntt/schdul/selectSchdulNttMonthAjax.do", "/**/module/ntt/schdul/schdulFormAjax.do"})
	public String selectSchdulNttMonthAjax(
			@ModelAttribute("paramVO") ModuleNttSchdulDataManageVO paramVO
			, @RequestParam(value="schdulSeq", required=false) String schdulSeq
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{

		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		java.util.Calendar cal = java.util.Calendar.getInstance();
        
		//일정기본정보 상세 조회
    	ModuleSchdulBassInfoVO paramSchdulBassInfoVO = new ModuleSchdulBassInfoVO();
    	paramSchdulBassInfoVO.setSchdulSeq(paramVO.getSchdulSeq());
		ModuleSchdulBassInfoVO schdulBassInfoVO = schdulService.selectSchdulBassInfoDetail(paramSchdulBassInfoVO);
		model.addAttribute("schdulBassInfoVO", schdulBassInfoVO);
		
		
        String sYear = paramVO.getSearchYear();
		String sMonth = paramVO.getSearchMonth();
        
        int iYear = cal.get(java.util.Calendar.YEAR);
		int iMonth = cal.get(java.util.Calendar.MONTH);
		
		//화면 유형이 없을땐 달력형으로 셋팅한다.
		if("".equals(StringUtils.defaultString(paramVO.getSearchCondition()))) {
			paramVO.setSearchCondition("month");
		}
		
		String sSearchDate = "";
		if(sYear == null || sMonth == null || "".equals(StringUtils.defaultString(sYear)) || "".equals(StringUtils.defaultString(sMonth)) ){
			if(Integer.MAX_VALUE > iYear) {
        		sSearchDate += Integer.toString(iYear);
        	}
        	if(Integer.MAX_VALUE > iMonth+1) {
        		if(Integer.toString(iMonth+1).length() == 1) {
        			sSearchDate += "0" + Integer.toString(iMonth+1);
        		} else {
        			sSearchDate += Integer.toString(iMonth+1);
        		}
        	}
        }else{
        	if(Integer.MAX_VALUE > Integer.parseInt(sYear)) {
                sSearchDate += sYear;
            }
        	if(Integer.MAX_VALUE > Integer.parseInt(sMonth)) {
        		if(sMonth.length() == 1) {
        			sSearchDate += "0" + sMonth;
        		} else {
        			sSearchDate += sMonth;
        		}
        	}
        }
        
		paramVO.setSearchYear(sSearchDate.substring(0,4));
		paramVO.setSearchMonth(sSearchDate.substring(4,6));
		paramVO.setSearchDate(sSearchDate);
		paramVO.setFirstIndex(0);
		paramVO.setRecordCountPerPage(999999);
        
		//일정정보 목록 조회
		List<ModuleNttSchdulDataManageVO> schdulList = shdulDataManageService.selectNttSchdulDataList(paramVO);
		
		//일정 범주 조회
//		List<ModuleSchdulCtgryVO> schldulCtgryList = schdulCtgryService.selectSchdulCtgryList(ctgryVO);

		// 일정 권한
		CntntsAuthVO cntntsAuthVO = new CntntsAuthVO();
		cntntsAuthVO.setCntntsSeq(paramVO.getSchdulSeq());
		cntntsAuthVO.setSiteSeq(paramVO.getSiteSeq());
		cntntsAuthVO.setSitecntntsSeq(paramVO.getSitecntntsSeq());
		
		if(loginVO != null){
			cntntsAuthVO.setUsrSeq(loginVO.getUsrSeq());
		} else {
			cntntsAuthVO.setUsrSeq("0");
		}	
		
		CntntsAuthVO nttAuthVO = cntntsAuthService.selectCntntsAuthForNtt(cntntsAuthVO);

		ModuleSchdulBassInfoVO schdulVO = new ModuleSchdulBassInfoVO();
		schdulVO.setSchdulSeq(paramVO.getSchdulSeq());
		String cssSeq = schdulService.selectSchdulCssSeq(schdulVO);
		
		/********* CSS 단순 조회로 인해 공통게시판쪽 service 사용 ************/
		ModuleBbsCssVO moduleBbsCssVO = new ModuleBbsCssVO();
		moduleBbsCssVO.setCssSeq(cssSeq);
		moduleBbsCssVO = bbsCmmnService.selectBbsCssDetail(moduleBbsCssVO);
		/*********************************************************************/
		
        model.addAttribute("year", paramVO.getSearchYear());
        model.addAttribute("month", paramVO.getSearchMonth());
		model.addAttribute("resultVO", paramVO);
		model.addAttribute("nttAuthVO", nttAuthVO);
		model.addAttribute("schdulList", schdulList);
		String schdulListJson = JacksonMapperUtil.convertMapToJson(schdulList);
		model.addAttribute("schdulListJson", schdulListJson);
//		model.addAttribute("schldulCtgryList", schldulCtgryList);
		model.addAttribute("moduleSchdulCssVO",moduleBbsCssVO);
		
		return "wzwg/module/ntt/schdul/schdulMonth";
	}
	
	/**
	 * ㅁ  일정 - 목록형 리스트
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/schdul/selectSchdulNttListAjax.do")
	public String selectSchdulNttListAjax(
			@ModelAttribute("paramVO") ModuleNttSchdulDataManageVO paramVO
			, @RequestParam(value="schdulSeq", required=false) String schdulSeq
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{

		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		paramVO.setSearchCondition("list");
		
		java.util.Calendar cal = java.util.Calendar.getInstance();
        
        String sYear = paramVO.getSearchYear();
		String sMonth = paramVO.getSearchMonth();
        
        int iYear = cal.get(java.util.Calendar.YEAR);
		int iMonth = cal.get(java.util.Calendar.MONTH);
		
		String sSearchDate = "";
		if(sYear == null || sMonth == null || "".equals(StringUtils.defaultString(sYear)) || "".equals(StringUtils.defaultString(sMonth)) ){
			if(Integer.MAX_VALUE > iYear) {
        		sSearchDate += Integer.toString(iYear);
        	}
        	if(Integer.MAX_VALUE > iMonth+1) {
        		if(Integer.toString(iMonth+1).length() == 1) {
        			sSearchDate += "0" + Integer.toString(iMonth+1);
        		} else {
        			sSearchDate += Integer.toString(iMonth+1);
        		}
        	}
        }else{
        	if(Integer.MAX_VALUE > Integer.parseInt(sYear)) {
                sSearchDate += sYear;
            }
        	if(Integer.MAX_VALUE > Integer.parseInt(sMonth)) {
        		if(sMonth.length() == 1) {
        			sSearchDate += "0" + sMonth;
        		} else {
        			sSearchDate += sMonth;
        		}
        	}
        }
        
		paramVO.setSearchYear(sSearchDate.substring(0,4));
		paramVO.setSearchMonth(sSearchDate.substring(4,6));
		paramVO.setSearchDate(sSearchDate);
        
		//일정정보 목록 조회
		List<ModuleNttSchdulDataManageVO> schdulList = shdulDataManageService.selectNttSchdulDataList(paramVO);

		// 일정 권한
		CntntsAuthVO cntntsAuthVO = new CntntsAuthVO();
		cntntsAuthVO.setCntntsSeq(paramVO.getSchdulSeq());
		cntntsAuthVO.setSiteSeq(paramVO.getSiteSeq());
		cntntsAuthVO.setSitecntntsSeq(paramVO.getSitecntntsSeq());
		
		if(loginVO != null){
			cntntsAuthVO.setUsrSeq(loginVO.getUsrSeq());
		} else {
			cntntsAuthVO.setUsrSeq("0");
		}	
		
		CntntsAuthVO nttAuthVO = cntntsAuthService.selectCntntsAuthForNtt(cntntsAuthVO);

		ModuleSchdulBassInfoVO schdulVO = new ModuleSchdulBassInfoVO();
		schdulVO.setSchdulSeq(paramVO.getSchdulSeq());
		String cssSeq = schdulService.selectSchdulCssSeq(schdulVO);
		
		/********* CSS 단순 조회로 인해 공통게시판쪽 service 사용 ************/
		ModuleBbsCssVO moduleBbsCssVO = new ModuleBbsCssVO();
		moduleBbsCssVO.setCssSeq(cssSeq);
		moduleBbsCssVO = bbsCmmnService.selectBbsCssDetail(moduleBbsCssVO);
		/*********************************************************************/

		model.addAttribute("nttAuthVO", nttAuthVO);
		model.addAttribute("schdulList", schdulList);
		model.addAttribute("moduleSchdulCssVO",moduleBbsCssVO);
		
		return "wzwg/module/ntt/schdul/schdulList";
	}

	/**
	 * ㅁ  일정 - 주별
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/schdul/selectSchdulNttWeekAjax.do")
	public String selectSchdulNttWeekAjax(
			@ModelAttribute("paramVO") ModuleNttSchdulDataManageVO paramVO
			, @RequestParam(value="schdulSeq", required=false) String schdulSeq
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{

		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		java.util.Calendar cal = java.util.Calendar.getInstance();
        
		//화면 유형이 없을땐 달력형으로 셋팅한다.
		if("".equals(StringUtils.defaultString(paramVO.getSearchCondition()))) {
			paramVO.setSearchCondition("week");
		}
		
		if(!"".equals(StringUtils.defaultString(paramVO.getSearchWeek()))) {
			cal.set(Calendar.WEEK_OF_YEAR, Integer.parseInt(paramVO.getSearchWeek()));
		} else {
			paramVO.setSearchWeek(cal.get(Calendar.WEEK_OF_YEAR)+"");
		}
		
		cal.set(Calendar.DAY_OF_WEEK, 1);
		
		int iMonth = cal.get(Calendar.MONTH)+1;
		int iDate = cal.get(Calendar.DATE);
		
		String strMonth = iMonth>9?Integer.toString(iMonth):"0"+Integer.toString(iMonth);
		String strDate = iDate>9?Integer.toString(iDate):"0"+Integer.toString(iDate);
		
		paramVO.setBgnde(Integer.toString(cal.get(Calendar.YEAR))+strMonth + strDate);
		paramVO.setSearchYear(Integer.toString(cal.get(Calendar.YEAR)));
		paramVO.setSearchMonth(strMonth);
		
		cal.set(Calendar.DAY_OF_WEEK, 7);
		iMonth = cal.get(Calendar.MONTH)+1;
		iDate = cal.get(Calendar.DATE);
		strMonth = iMonth>9?Integer.toString(iMonth):"0"+Integer.toString(iMonth);
		strDate = iDate>9?Integer.toString(iDate):"0"+Integer.toString(iDate);
		
		paramVO.setEndde(Integer.toString(cal.get(Calendar.YEAR))+strMonth + strDate);
		
		paramVO.setFirstIndex(0);
		paramVO.setRecordCountPerPage(999999);
        
		//일정정보 목록 조회
		List<ModuleNttSchdulDataManageVO> schdulList = shdulDataManageService.selectNttSchdulDataList(paramVO);
		
		// 일정 권한
		CntntsAuthVO cntntsAuthVO = new CntntsAuthVO();
		cntntsAuthVO.setCntntsSeq(paramVO.getSchdulSeq());
		cntntsAuthVO.setSiteSeq(paramVO.getSiteSeq());
		cntntsAuthVO.setSitecntntsSeq(paramVO.getSitecntntsSeq());
		
		if(loginVO != null){
			cntntsAuthVO.setUsrSeq(loginVO.getUsrSeq());
		} else {
			cntntsAuthVO.setUsrSeq("0");
		}	
		
		CntntsAuthVO nttAuthVO = cntntsAuthService.selectCntntsAuthForNtt(cntntsAuthVO);
		
		ModuleSchdulBassInfoVO schdulVO = new ModuleSchdulBassInfoVO();
		schdulVO.setSchdulSeq(paramVO.getSchdulSeq());
		String cssSeq = schdulService.selectSchdulCssSeq(schdulVO);
		
		/********* CSS 단순 조회로 인해 공통게시판쪽 service 사용 ************/
		ModuleBbsCssVO moduleBbsCssVO = new ModuleBbsCssVO();
		moduleBbsCssVO.setCssSeq(cssSeq);
		moduleBbsCssVO = bbsCmmnService.selectBbsCssDetail(moduleBbsCssVO);
		/*********************************************************************/

        model.addAttribute("year", paramVO.getSearchYear());
        model.addAttribute("month", paramVO.getSearchMonth());
        model.addAttribute("week", paramVO.getSearchWeek());
		model.addAttribute("resultVO", paramVO);
		model.addAttribute("schdulList", schdulList);
		model.addAttribute("nttAuthVO", nttAuthVO);
		model.addAttribute("moduleSchdulCssVO",moduleBbsCssVO);

		return "wzwg/module/ntt/schdul/schdulWeek";
	}

	
	/**
	 * ㅁ  일정 - 일별
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/schdul/selectSchdulNttDayAjax.do")
	public String selectSchdulNttDayAjax(
			@ModelAttribute("paramVO") ModuleNttSchdulDataManageVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{

		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		paramVO.setSearchCondition("day");
		//일정정보 목록 조회
		List<ModuleNttSchdulDataManageVO> schdulList = shdulDataManageService.selectNttSchdulDataList(paramVO);
		model.addAttribute("schdulList", schdulList);

		return "wzwg/module/ntt/schdul/schdulDay";
	}
	
	/**
	 * ㅁ 일정 - 미리보기
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/schdul/selectSchdulNttPreviewAjax.do")
	public String selectSchdulNttPreviewAjax(
			@ModelAttribute("paramVO") ModuleNttSchdulDataManageVO paramVO
			, @RequestParam(value="schdulSeq", required=false) String schdulSeq
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{

		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		ModuleNttSchdulDataManageVO detailVO = shdulDataManageService.selectNttSchdulDataDetail(paramVO);
		
		// 일정 권한
		CntntsAuthVO cntntsAuthVO = new CntntsAuthVO();
		cntntsAuthVO.setCntntsSeq(paramVO.getSchdulSeq());
		cntntsAuthVO.setSiteSeq(paramVO.getSiteSeq());
		cntntsAuthVO.setSitecntntsSeq(paramVO.getSitecntntsSeq());
		
		if(loginVO != null){
			cntntsAuthVO.setUsrSeq(loginVO.getUsrSeq());
		} else {
			cntntsAuthVO.setUsrSeq("0");
		}	
		
		CntntsAuthVO nttAuthVO = cntntsAuthService.selectCntntsAuthForNtt(cntntsAuthVO);

		model.addAttribute("detailVO", detailVO);
		model.addAttribute("nttAuthVO", nttAuthVO);

		return "wzwg/module/ntt/schdul/schdulPreview";
	}
	
	/**
	 * ㅁ  일정 - 등록화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/schdul/registSchdulFormAjax.do")
	public String registSchdulForm(
			@ModelAttribute("paramVO") ModuleNttSchdulDataManageVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setFrstRegisterId(loginVO.getUserId());
		}
		
		//스케줄 기본정보 조회
		ModuleSchdulBassInfoVO schdulBassInfoVO = new ModuleSchdulBassInfoVO();
		schdulBassInfoVO.setSchdulSeq(paramVO.getSchdulSeq());
		schdulBassInfoVO = schdulService.selectSchdulBassInfoDetail(schdulBassInfoVO);

		// 일정 권한
		CntntsAuthVO cntntsAuthVO = new CntntsAuthVO();
		cntntsAuthVO.setCntntsSeq(paramVO.getSchdulSeq());
		cntntsAuthVO.setSiteSeq(paramVO.getSiteSeq());
		
		if(loginVO != null){
			cntntsAuthVO.setUsrSeq(loginVO.getUsrSeq());
		} else {
			cntntsAuthVO.setUsrSeq("0");
		}	
		
		CntntsAuthVO nttAuthVO = cntntsAuthService.selectCntntsAuthForNtt(cntntsAuthVO);
		
		List<CmmCodeVO> ctgryColorList = cmmCodeService.selectCmmCodeList("COM_COLOR_CODE");
		model.addAttribute("ctgryColorList", ctgryColorList);
		
		model.addAttribute("schdulBassInfoVO", schdulBassInfoVO);
		model.addAttribute("nttAuthVO", nttAuthVO);

		return "wzwg/module/ntt/schdul/schdulRegist";
		
	}
	
	
	/**
	 * ㅁ  일정 - 등록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/schdul/registSchdulAjax.do")
	public ModelAndView registSchdul(
			@ModelAttribute("paramVO") ModuleNttSchdulDataManageVO paramVO
			, HttpServletRequest request
			, ModelMap model
		) throws Exception{
		
		
		int result = 0;
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setFrstRegisterId(loginVO.getUserId());
		}
		
		paramVO.setCn(CmmXssUtil.unscript(paramVO.getCn()));
		
		//일반
		result = shdulDataManageService.registNttSchdulData(paramVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
		
	}
	
	/**
	 * ㅁ 일정 - 사용자목록
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/schdul/selectUsrInfoListAjax.do")
	public String selectUsrInfoListAjax(
			@ModelAttribute("paramVO") SysMngrUsrInfoVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{

		/** =================== paging 시작 ============================== */
		PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(paramVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(paramVO.getPageUnit());
        paginationInfo.setPageSize(paramVO.getPageSize());
       
        paramVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        paramVO.setLastIndex(paginationInfo.getLastRecordIndex());
        paramVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
        /** =================== paging 끝 =============================== */
        
		// 사용자 정보 목록
		List<SysMngrUsrInfoVO> usrInfoList = usrInfoService.selectUsrInfoList(paramVO);
		
		int totCnt = usrInfoService.selectUsrInfoListCnt(paramVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("usrInfoList", usrInfoList);
		model.addAttribute("paramVO", paramVO);
		
		return "wzwg/module/ntt/schdul/usrInfoList";
	}

	/**
	 * ㅁ  일정 - 수정화면
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/schdul/modifySchdulFormAjax.do")
	public String modifySchdulForm(
			@ModelAttribute("paramVO") ModuleNttSchdulDataManageVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setFrstRegisterId(loginVO.getUserId());
		}
		
		//스케줄 기본정보 조회
		ModuleSchdulBassInfoVO schdulBassInfoVO = new ModuleSchdulBassInfoVO();
		schdulBassInfoVO.setSchdulSeq(paramVO.getSchdulSeq());
		schdulBassInfoVO = schdulService.selectSchdulBassInfoDetail(schdulBassInfoVO);
		
		//일정 상세조회
		ModuleNttSchdulDataManageVO schdulDataDetail = shdulDataManageService.selectNttSchdulDataDetail(paramVO);

		// 일정 권한
		CntntsAuthVO cntntsAuthVO = new CntntsAuthVO();
		cntntsAuthVO.setCntntsSeq(paramVO.getSchdulSeq());
		cntntsAuthVO.setSiteSeq(paramVO.getSiteSeq());
		
		if(loginVO != null){
			cntntsAuthVO.setUsrSeq(loginVO.getUsrSeq());
		} else {
			cntntsAuthVO.setUsrSeq("0");
		}	
		
		CntntsAuthVO nttAuthVO = cntntsAuthService.selectCntntsAuthForNtt(cntntsAuthVO);
		
		model.addAttribute("schdulBassInfoVO", schdulBassInfoVO);
		model.addAttribute("schdulDataDetail", schdulDataDetail);
		model.addAttribute("nttAuthVO", nttAuthVO);
		
		List<CmmCodeVO> ctgryColorList = cmmCodeService.selectCmmCodeList("COM_COLOR_CODE");
		model.addAttribute("ctgryColorList", ctgryColorList);

		return "wzwg/module/ntt/schdul/schdulModify";
	}
	
	/**
	 * ㅁ  일정 - 수정
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/schdul/modifySchdulAjax.do")
	public ModelAndView modifySchdul(
			@ModelAttribute("paramVO") ModuleNttSchdulDataManageVO paramVO
			, HttpServletRequest request
			, ModelMap model
		) throws Exception{
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		paramVO.setCn(CmmXssUtil.unscript(paramVO.getCn()));
		
		int result = 0;
		//일반
		result = shdulDataManageService.modifyNttSchdulData(paramVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	/**
	 * ㅁ  일정 - 삭제
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/schdul/deleteSchdulAjax.do")
	public ModelAndView deleteSchdul(
			@ModelAttribute("paramVO") ModuleNttSchdulDataManageVO paramVO
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{
		
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
		if (loginVO != null) {
			paramVO.setFrstRegisterId(loginVO.getUserId());
			paramVO.setLastUpdusrId(loginVO.getUserId());
		}
		
		//스케줄 기본정보 조회
		ModuleSchdulBassInfoVO schdulBassInfoVO = new ModuleSchdulBassInfoVO();
		schdulBassInfoVO.setSchdulSeq(paramVO.getSchdulSeq());
		schdulBassInfoVO = schdulService.selectSchdulBassInfoDetail(schdulBassInfoVO);
		model.addAttribute("schdulBassInfoVO", schdulBassInfoVO);
		
		int result = shdulDataManageService.deleteNttSchdulData(paramVO);
		
		if(result > 0){
			return CmmAjaxUtil.getAjaxReturn("success");
		}else{
			return CmmAjaxUtil.getAjaxReturn("fail");
		}
	}
	
	
	/**
	 * ㅁ  일정 - 월간
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value={"/**/module/ntt/schdul/selectSchdulNttMonthTestAjax.do"})
	public String selectSchdulNttMonthTestAjax(
			@ModelAttribute("paramVO") ModuleNttSchdulDataManageVO paramVO
			, @RequestParam(value="schdulSeq", required=false) String schdulSeq
			, HttpServletRequest request 
			, ModelMap model
		) throws Exception{

		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		java.util.Calendar cal = java.util.Calendar.getInstance();
        
        String sYear = paramVO.getSearchYear();
		String sMonth = paramVO.getSearchMonth();
        
        int iYear = cal.get(java.util.Calendar.YEAR);
		int iMonth = cal.get(java.util.Calendar.MONTH);
		
		//화면 유형이 없을땐 달력형으로 셋팅한다.
		if("".equals(StringUtils.defaultString(paramVO.getSearchCondition()))) {
			paramVO.setSearchCondition("month");
		}
		
		String sSearchDate = "";
		if(sYear == null || sMonth == null || "".equals(StringUtils.defaultString(sYear)) || "".equals(StringUtils.defaultString(sMonth)) ){
			if(Integer.MAX_VALUE > iYear) {
        		sSearchDate += Integer.toString(iYear);
        	}
        	if(Integer.MAX_VALUE > iMonth+1) {
        		if(Integer.toString(iMonth+1).length() == 1) {
        			sSearchDate += "0" + Integer.toString(iMonth+1);
        		} else {
        			sSearchDate += Integer.toString(iMonth+1);
        		}
        	}
        }else{
        	if(Integer.MAX_VALUE > Integer.parseInt(sYear)) {
                sSearchDate += sYear;
            }
        	if(Integer.MAX_VALUE > Integer.parseInt(sMonth)) {
        		if(sMonth.length() == 1) {
        			sSearchDate += "0" + sMonth;
        		} else {
        			sSearchDate += sMonth;
        		}
        	}
        }
		
		
        
		paramVO.setSearchYear(sSearchDate.substring(0,4));
		paramVO.setSearchMonth(sSearchDate.substring(4,6));
		paramVO.setSearchDate(sSearchDate);
		paramVO.setFirstIndex(0);
		paramVO.setRecordCountPerPage(999999);
        
        model.addAttribute("year", paramVO.getSearchYear());
        model.addAttribute("month", paramVO.getSearchMonth());
		
		model.addAttribute("resultVO", paramVO);
		
		//일정정보 목록 조회
//		List<ModuleNttSchdulDataManageVO> schdulList = shdulDataManageService.selectNttSchdulDataList(paramVO);
		
		return "wzwg/module/ntt/schdul/schdulMonthTest";
	}
	
	/**
	 * ㅁ  일정 - 주별
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/**/module/ntt/schdul/selectSchdulTestJson.do")
    public ModelAndView selectTestJson (
        @ModelAttribute("paramVO") ModuleNttSchdulDataManageVO paramVO
        , HttpServletRequest request ) throws Exception {
    
		ModelAndView model = new ModelAndView();
		
		//화면 유형이 없을땐 달력형으로 셋팅한다.
		if("".equals(StringUtils.defaultString(paramVO.getSearchCondition()))) {
			paramVO.setSearchCondition("month");
		}
		
		paramVO.setSiteSeq(CmmSessionUtil.getSessionSiteSeq(request));
		
		java.util.Calendar cal = java.util.Calendar.getInstance();
        
        String sYear = paramVO.getSearchYear();
		String sMonth = paramVO.getSearchMonth();
        
        int iYear = cal.get(java.util.Calendar.YEAR);
		int iMonth = cal.get(java.util.Calendar.MONTH);
		
		//화면 유형이 없을땐 달력형으로 셋팅한다.
		if("".equals(StringUtils.defaultString(paramVO.getSearchCondition()))) {
			paramVO.setSearchCondition("month");
		}
		
		String sSearchDate = "";
		if(sYear == null || sMonth == null || "".equals(StringUtils.defaultString(sYear)) || "".equals(StringUtils.defaultString(sMonth)) ){
			if(Integer.MAX_VALUE > iYear) {
        		sSearchDate += Integer.toString(iYear);
        	}
        	if(Integer.MAX_VALUE > iMonth+1) {
        		if(Integer.toString(iMonth+1).length() == 1) {
        			sSearchDate += "0" + Integer.toString(iMonth+1);
        		} else {
        			sSearchDate += Integer.toString(iMonth+1);
        		}
        	}
        }else{
        	if(Integer.MAX_VALUE > Integer.parseInt(sYear)) {
                sSearchDate += sYear;
            }
        	if(Integer.MAX_VALUE > Integer.parseInt(sMonth)) {
        		if(sMonth.length() == 1) {
        			sSearchDate += "0" + sMonth;
        		} else {
        			sSearchDate += sMonth;
        		}
        	}
        }
        
		paramVO.setSearchDate(sSearchDate);
		paramVO.setSearchYear(sSearchDate.substring(0,4));
		paramVO.setSearchMonth(sSearchDate.substring(4,6));
		
				
		Map<String, Object> resultMap = shdulDataManageService.createCalendarData(paramVO);
				
				
		model.addObject("calendarData", resultMap.get("calendarList"));
		model.addObject("schdulData", resultMap.get("resultSchdulList"));
		
		model.setViewName("jsonView");

        return model;
    }
}
