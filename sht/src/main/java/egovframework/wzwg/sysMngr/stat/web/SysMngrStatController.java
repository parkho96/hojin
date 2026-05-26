package egovframework.wzwg.sysMngr.stat.web;

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
import egovframework.wzwg.sysMngr.stat.service.SysMngrStatService;
import egovframework.wzwg.sysMngr.stat.service.SysMngrStatVO;

@Controller
public class SysMngrStatController {
	 
	@Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
 
	@Resource(name="SysMngrStatService")
	private SysMngrStatService sysMngrStatService;

	@RequestMapping(value="/sysMngr/stat/selectVisitStat.do")
	public String selectVistStat(HttpServletRequest request, 
			@ModelAttribute("paramVO") SysMngrStatVO paramVO,
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
		model.addAttribute("searchVO", paramVO);
		return "wzwg/sysMngr/stat/visitStat";
	}
	
	
	@RequestMapping(value="/sysMngr/stat/selectVisitStatAjax.do")
	public String selectVistStatAjax(HttpServletRequest request, 
			@ModelAttribute("paramVO") SysMngrStatVO paramVO,
			ModelMap model) throws Exception{
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		 
		model.addAttribute("statList", sysMngrStatService.selectVisitStatList(paramVO));
		return "wzwg/sysMngr/stat/visitStatAjax";
	}
	
	@RequestMapping(value="/sysMngr/stat/selectVisitStatExcel.do")
	public void selectVisitStatExcel(HttpServletRequest request, 
			HttpServletResponse response,
			SysMngrStatVO paramVO,
			ModelMap model) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");   
		paramVO.setSiteSeq(siteSeq);
		String fileName =  egovMessageSource.getMessage("wzwg.sysMngr.word.periodbyVisitrSttus02");
		HashMap<String ,Object> beans = new HashMap<String ,Object>();  
		beans.put("statList", sysMngrStatService.selectVisitStatListExcel(paramVO));
		ExcelCreater.excelCreate(request,response , beans, "Globals.visitMngrStatExcelForm", fileName) ;
	}
	
	@RequestMapping(value="/sysMngr/stat/selectUsrStat.do")
	public String selectUsrStat(HttpServletRequest request, 
			@ModelAttribute("paramVO") SysMngrStatVO paramVO,
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
		model.addAttribute("searchVO", paramVO);
		return "wzwg/sysMngr/stat/usrStat";
	}
	
	
	@RequestMapping(value="/sysMngr/stat/selectUsrStatAjax.do")
	public String selectUsrStatAjax(HttpServletRequest request, 
			@ModelAttribute("paramVO") SysMngrStatVO paramVO,
			ModelMap model) throws Exception{
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO"); 
		model.addAttribute("statList", sysMngrStatService.selectUsrStatList(paramVO));
		return "wzwg/sysMngr/stat/usrStatAjax";
	}
	
	@RequestMapping(value="/sysMngr/stat/selectUsrStatExcel.do")
	public void selectUsrStatExcel(HttpServletRequest request, 
			HttpServletResponse response,
			SysMngrStatVO paramVO,
			ModelMap model) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");   
		paramVO.setSiteSeq(siteSeq);
		String fileName = egovMessageSource.getMessage("wzwg.sysMngr.word.periodbySignupSttus02");
		HashMap<String ,Object> beans = new HashMap<String ,Object>();  
		beans.put("statList", sysMngrStatService.selectUsrStatListExcel(paramVO));
		ExcelCreater.excelCreate(request,response , beans, "Globals.usrMngrStatExcelForm", fileName) ;
	}
	
	@RequestMapping(value="/sysMngr/stat/selectBbsStat.do")
	public String selectBbsStat(HttpServletRequest request, 
			@ModelAttribute("paramVO") SysMngrStatVO paramVO,
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
		model.addAttribute("searchVO", paramVO);
		return "wzwg/sysMngr/stat/bbsStat";
	}
	
	
	@RequestMapping(value="/sysMngr/stat/selectBbsStatAjax.do")
	public String selectBbsStatAjax(HttpServletRequest request, 
			@ModelAttribute("paramVO") SysMngrStatVO paramVO,
			ModelMap model) throws Exception{
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO"); 
		model.addAttribute("statList", sysMngrStatService.selectBbsStatList(paramVO));
		return "wzwg/sysMngr/stat/bbsStatAjax";
	}
	
	@RequestMapping(value="/sysMngr/stat/selectBbsStatExcel.do")
	public void selectBbsStatExcel(HttpServletRequest request, 
			HttpServletResponse response,
			SysMngrStatVO paramVO,
			ModelMap model) throws Exception{
		
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");   
		paramVO.setSiteSeq(siteSeq);
		String fileName = egovMessageSource.getMessage("wzwg.sysMngr.word.periodbyNttRegistSttus02") ;
		HashMap<String ,Object> beans = new HashMap<String ,Object>();  
		beans.put("statList", sysMngrStatService.selectBbsStatListExcel(paramVO));
		ExcelCreater.excelCreate(request,response , beans, "Globals.bbsMngrStatExcelForm", fileName) ;
	}
}
