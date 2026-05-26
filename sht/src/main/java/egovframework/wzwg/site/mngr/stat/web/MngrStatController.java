package egovframework.wzwg.site.mngr.stat.web;

import java.util.HashMap;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import dggb.util.DateUtils;
import dggb.util.StringUtils;
import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.utl.fcc.service.ExcelCreater;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.stat.service.MngrStatService;
import egovframework.wzwg.site.mngr.stat.service.MngrStatVO;

@Controller
public class MngrStatController {
	
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;

	@Resource(name="MngrStatService")
	private MngrStatService mngrStatService;

	@RequestMapping(value={"/mngr/stat/selectVisitStat.do","/{siteKey}/mngr/stat/selectVisitStat.do"})
	public String selectVistStat(HttpServletRequest request, 
			@ModelAttribute("paramVO") MngrStatVO paramVO,
			ModelMap model) throws Exception{
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		if(StringUtils.nvl(paramVO.getStartYear(),"").equals("")){
			paramVO.setStartYear(DateUtils.getCurrentDate("yyyy"));
		}
		if(StringUtils.nvl(paramVO.getStartMonth(),"").equals("")){
			paramVO.setStartMonth(DateUtils.getCurrentDate("MM"));
		}
		
		if(StringUtils.nvl(paramVO.getEndYear(),"").equals("")){
			paramVO.setEndYear(DateUtils.getCurrentDate("yyyy"));
		}
		if(StringUtils.nvl(paramVO.getEndMonth(),"").equals("")){
			paramVO.setEndMonth(DateUtils.getCurrentDate("MM"));
		}
		model.addAttribute("searchVO", paramVO);
		return "wzwg/site/mngr/stat/visitStat";
	}
	
	
	@RequestMapping(value= {"/mngr/stat/selectVisitStatAjax.do","/{siteKey}/mngr/stat/selectVisitStatAjax.do"})
	public String selectVistStatAjax(HttpServletRequest request, 
			@ModelAttribute("paramVO") MngrStatVO paramVO,
			ModelMap model) throws Exception{
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");  
		paramVO.setSiteSeq(siteSeq);
		model.addAttribute("statList", mngrStatService.selectVisitStatList(paramVO));
		return "wzwg/site/mngr/stat/visitStatAjax";
	}
	
	@RequestMapping(value={"/mngr/stat/selectUsrStat.do","/{siteKey}/mngr/stat/selectUsrStat.do"})
	public String selectUsrStat(HttpServletRequest request, 
			@ModelAttribute("paramVO") MngrStatVO paramVO,
			ModelMap model) throws Exception{
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		if(StringUtils.nvl(paramVO.getStartYear(),"").equals("")){
			paramVO.setStartYear(DateUtils.getCurrentDate("yyyy"));
		}
		if(StringUtils.nvl(paramVO.getStartMonth(),"").equals("")){
			paramVO.setStartMonth(DateUtils.getCurrentDate("MM"));
		}
		
		if(StringUtils.nvl(paramVO.getEndYear(),"").equals("")){
			paramVO.setEndYear(DateUtils.getCurrentDate("yyyy"));
		}
		if(StringUtils.nvl(paramVO.getEndMonth(),"").equals("")){
			paramVO.setEndMonth(DateUtils.getCurrentDate("MM"));
		}
		paramVO.setSiteSeq(siteSeq);
		model.addAttribute("searchVO", paramVO);
		return "wzwg/site/mngr/stat/usrStat";
	}
	
	
	@RequestMapping(value= {"/mngr/stat/selectUsrStatAjax.do","/{siteKey}/mngr/stat/selectUsrStatAjax.do"})
	public String selectUsrStatAjax(HttpServletRequest request, 
			@ModelAttribute("paramVO") MngrStatVO paramVO,
			ModelMap model) throws Exception{
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO"); 
		paramVO.setSiteSeq(siteSeq);
		model.addAttribute("statList", mngrStatService.selectUsrStatList(paramVO));
		return "wzwg/site/mngr/stat/usrStatAjax";
	}
	
	@RequestMapping(value={"/mngr/stat/selectBbsStat.do","/{siteKey}/mngr/stat/selectBbsStat.do"})
	public String selectBbsStat(HttpServletRequest request, 
			@ModelAttribute("paramVO") MngrStatVO paramVO,
			ModelMap model) throws Exception{
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		if(StringUtils.nvl(paramVO.getStartYear(),"").equals("")){
			paramVO.setStartYear(DateUtils.getCurrentDate("yyyy"));
		}
		if(StringUtils.nvl(paramVO.getStartMonth(),"").equals("")){
			paramVO.setStartMonth(DateUtils.getCurrentDate("MM"));
		}
		
		if(StringUtils.nvl(paramVO.getEndYear(),"").equals("")){
			paramVO.setEndYear(DateUtils.getCurrentDate("yyyy"));
		}
		if(StringUtils.nvl(paramVO.getEndMonth(),"").equals("")){
			paramVO.setEndMonth(DateUtils.getCurrentDate("MM"));
		}
		paramVO.setSiteSeq(siteSeq);
		model.addAttribute("searchVO", paramVO);
		return "wzwg/site/mngr/stat/bbsStat";
	}
	
	
	@RequestMapping(value= {"/mngr/stat/selectBbsStatAjax.do","/{siteKey}/mngr/stat/selectBbsStatAjax.do"})
	public String selectBbsStatAjax(HttpServletRequest request, 
			@ModelAttribute("paramVO") MngrStatVO paramVO,
			ModelMap model) throws Exception{
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO"); 
		paramVO.setSiteSeq(siteSeq);
		model.addAttribute("statList", mngrStatService.selectBbsStatList(paramVO));
		return "wzwg/site/mngr/stat/bbsStatAjax";
	}
	
	
	@RequestMapping(value={"/mngr/stat/selectCmntStat.do","/{siteKey}/mngr/stat/selectCmntStat.do"})
	public String selectCmntStat(HttpServletRequest request, 
			@ModelAttribute("paramVO") MngrStatVO paramVO,
			ModelMap model) throws Exception{
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		paramVO.setSiteSeq(siteSeq);
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		 
		model.addAttribute("searchVO", paramVO);
		return "wzwg/site/mngr/stat/cmntStat";
	}
	
	
	@RequestMapping(value= {"/mngr/stat/selectCmntStatAjax.do","/{siteKey}/mngr/stat/selectCmntStatAjax.do"})
	public String selectCmntStatAjax(HttpServletRequest request, 
			@ModelAttribute("paramVO") MngrStatVO paramVO,
			ModelMap model) throws Exception{
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
	//	paramVO.setStartDate(paramVO.getStartDate().replaceAll("-",""));
	//	paramVO.setEndDate(paramVO.getEndDate().replaceAll("-",""));
		paramVO.setSiteSeq(siteSeq);
		model.addAttribute("statList", mngrStatService.selectCmntStatList(paramVO));
		return "wzwg/site/mngr/stat/cmntStatAjax";
	}
	
	@RequestMapping(value={"/mngr/stat/selectMenuStat.do","/{siteKey}/mngr/stat/selectMenuStat.do"})
	public String selectMenuStat(HttpServletRequest request, 
			@ModelAttribute("paramVO") MngrStatVO paramVO,
			ModelMap model) throws Exception{
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		if(StringUtils.nvl(paramVO.getStartYear(),"").equals("")){
			paramVO.setStartYear(DateUtils.getCurrentDate("yyyy"));
		}
		if(StringUtils.nvl(paramVO.getStartMonth(),"").equals("")){
			paramVO.setStartMonth(DateUtils.getCurrentDate("MM"));
		}
		
		if(StringUtils.nvl(paramVO.getEndYear(),"").equals("")){
			paramVO.setEndYear(DateUtils.getCurrentDate("yyyy"));
		}
		if(StringUtils.nvl(paramVO.getEndMonth(),"").equals("")){
			paramVO.setEndMonth(DateUtils.getCurrentDate("MM"));
		}
		paramVO.setSiteSeq(siteSeq);
		model.addAttribute("searchVO", paramVO);
		return "wzwg/site/mngr/stat/menuStat";
	}
	
	
	@RequestMapping(value= {"/mngr/stat/selectMenuStatAjax.do","/{siteKey}/mngr/stat/selectMenuStatAjax.do"})
	public String selectMenuStatAjax(HttpServletRequest request, 
			@ModelAttribute("paramVO") MngrStatVO paramVO,
			ModelMap model) throws Exception{
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO"); 
		paramVO.setSiteSeq(siteSeq);
		model.addAttribute("statList", mngrStatService.selectMenuStatList(paramVO));
		return "wzwg/site/mngr/stat/menuStatAjax";
	}
	
	@RequestMapping(value={"/mngr/stat/selectVisitStatExcel.do","/{siteKey}/mngr/stat/selectVisitStatExcel.do"})
	public void selectVisitStatExcel(HttpServletRequest request, 
			HttpServletResponse response,
			MngrStatVO paramVO,
			ModelMap model) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");   
		paramVO.setSiteSeq(siteSeq);
		String fileName = egovMessageSource.getMessage("wzwg.sysMngr.word.periodbyVisitrSttus02");
		HashMap<String ,Object> beans = new HashMap<String ,Object>();  
		beans.put("statList", mngrStatService.selectVisitStatListExcel(paramVO));
		ExcelCreater.excelCreate(request,response , beans, "Globals.visitMngrStatExcelForm", fileName) ;
	}
	
	@RequestMapping(value={"/mngr/stat/selectUsrStatExcel.do","/{siteKey}/mngr/stat/selectUsrStatExcel.do"})
	public void selectUsrStatExcel(HttpServletRequest request, 
			HttpServletResponse response,
			MngrStatVO paramVO,
			ModelMap model) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");   
		paramVO.setSiteSeq(siteSeq);
		String fileName = egovMessageSource.getMessage("wzwg.sysMngr.word.periodbySignupSttus02");
		HashMap<String ,Object> beans = new HashMap<String ,Object>();  
		beans.put("statList", mngrStatService.selectUsrStatListExcel(paramVO));
		ExcelCreater.excelCreate(request,response , beans, "Globals.usrMngrStatExcelForm", fileName) ;
	}

	@RequestMapping(value={"/mngr/stat/selectCmntStatExcel.do","/{siteKey}/mngr/stat/selectCmntStatExcel.do"})
	public void selectCmntStatExcel(HttpServletRequest request, 
			HttpServletResponse response,
			MngrStatVO paramVO,
			ModelMap model) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");   
		paramVO.setSiteSeq(siteSeq);
		String fileName = egovMessageSource.getMessage("wzwg.site.stat.msg.MSG004");
		HashMap<String ,Object> beans = new HashMap<String ,Object>();  
		beans.put("statList", mngrStatService.selectCmntStatListExcel(paramVO));
		ExcelCreater.excelCreate(request,response , beans, "Globals.cmntMngrStatExcelForm", fileName) ;
	}
	

	@RequestMapping(value={"/mngr/stat/selectMenuStatExcel.do","/{siteKey}/mngr/stat/selectMenuStatExcel.do"})
	public void selectMenurStatExcel(HttpServletRequest request, 
			HttpServletResponse response,
			MngrStatVO paramVO,
			ModelMap model) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");   
		paramVO.setSiteSeq(siteSeq);
		String fileName = egovMessageSource.getMessage("wzwg.site.stat.msg.MSG006");
		HashMap<String ,Object> beans = new HashMap<String ,Object>();  
		beans.put("statList", mngrStatService.selectMenuStatListExcel(paramVO));
		ExcelCreater.excelCreate(request,response , beans, "Globals.menuMngrStatExcelForm", fileName) ;
	}
	

	@RequestMapping(value={"/mngr/stat/selectBBSStatExcel.do","/{siteKey}/mngr/stat/selectBBSStatExcel.do"})
	public void selectBBSStatExcel(HttpServletRequest request, 
			HttpServletResponse response,
			MngrStatVO paramVO,
			ModelMap model) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");   
		paramVO.setSiteSeq(siteSeq);
		String fileName = egovMessageSource.getMessage("wzwg.sysMngr.word.periodbyNttRegistSttus02");
		HashMap<String ,Object> beans = new HashMap<String ,Object>();  
		beans.put("statList", mngrStatService.selectBbsStatListExcel(paramVO));
		ExcelCreater.excelCreate(request,response , beans, "Globals.bbsMngrStatExcelForm", fileName) ;
	}
}
