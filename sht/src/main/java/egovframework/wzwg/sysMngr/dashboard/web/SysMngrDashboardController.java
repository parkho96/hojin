package egovframework.wzwg.sysMngr.dashboard.web;

import java.io.File;
import java.util.HashMap;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.utl.fcc.service.ExcelCreater;
import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.site.mngr.dashboard.service.MngrDashboardService;
import egovframework.wzwg.site.mngr.dashboard.service.MngrDashboardVO;
import egovframework.wzwg.sysMngr.dashboard.service.SysMngrDashboardService;
import egovframework.wzwg.sysMngr.dashboard.service.SysMngrDashboardVO;
import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttQnaDataManageService;
import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttUnityDataManageService;
import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttVO;

@Controller
public class SysMngrDashboardController {
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    /** OpnsuNttUnityDataManageService */
    @Resource(name="OpnsuNttUnityDataManageService")
    protected OpnsuNttUnityDataManageService nttUnityService;	
    
    /** OpnsuNttQnaDataManageService */
    @Resource(name="OpnsuNttQnaDataManageService")
    protected OpnsuNttQnaDataManageService nttQnaService;	
    

	@Resource(name="MngrDashboardService")
	private MngrDashboardService mngrDashboardService;
	
	@Resource(name="SysMngrDashboardService")
	private SysMngrDashboardService sysMngrDashboardService;

	@RequestMapping(value="/**/selectDashboardMain.do")
	public String selectDashboardMain(HttpServletRequest request, 
			ModelMap model) throws Exception{
		MngrDashboardVO mngrDashboardVO = new MngrDashboardVO();
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		mngrDashboardVO.setSiteSeq(siteSeq);
		if (loginVO != null) {			
			mngrDashboardVO.setContectId(loginVO.getUsrSeq());
		}
		mngrDashboardVO.setTodayYn("N");
		
		SysMngrDashboardVO sysMngrDashboardVO = new SysMngrDashboardVO();
		sysMngrDashboardVO.setSiteSeq(siteSeq);
		if (loginVO != null) {
			sysMngrDashboardVO.setContectId(loginVO.getUsrSeq());			
		}
		sysMngrDashboardVO.setTodayYn("N");
		OpnsuNttVO opnsuNttVO = new OpnsuNttVO();
		opnsuNttVO.setBbsSeq("10000000001");
		model.addAttribute("noticeList", nttUnityService.selectNttScrinCntnts(opnsuNttVO));
		
		opnsuNttVO.setBbsSeq("10000000002");
		model.addAttribute("dataList", nttUnityService.selectNttScrinCntnts(opnsuNttVO));
		
		opnsuNttVO.setBbsSeq("10000000004");
		model.addAttribute("faqList", nttUnityService.selectNttScrinCntnts(opnsuNttVO));
		
		opnsuNttVO.setBbsSeq("10000000003");
		model.addAttribute("qnaList", nttQnaService.selectNttScrinCntnts(opnsuNttVO));		
		model.addAttribute("lastLgnDt",mngrDashboardService.selectSiteLastLgnDt(mngrDashboardVO));
		
		model.addAttribute("usrTotCnt",sysMngrDashboardService.selectSiteUsrCnt(sysMngrDashboardVO));
		sysMngrDashboardVO.setTodayYn("Y");
		model.addAttribute("usrTodayCnt",sysMngrDashboardService.selectSiteUsrCnt(sysMngrDashboardVO));
		sysMngrDashboardVO.setTodayYn("N");
		model.addAttribute("vistTodayCnt",sysMngrDashboardService.selectSiteVisitCnt(sysMngrDashboardVO));
		model.addAttribute("visitTotCnt",sysMngrDashboardService.selectSiteVisitTotCnt(sysMngrDashboardVO));
		model.addAttribute("nttTotCnt",sysMngrDashboardService.selectSiteNttCnt(sysMngrDashboardVO));
		sysMngrDashboardVO.setTodayYn("Y");
		model.addAttribute("nttTodayCnt",sysMngrDashboardService.selectSiteNttCnt(sysMngrDashboardVO));
		
		return "wzwg/sysMngr/dashboard/dashboardMain";
	}

	@RequestMapping(value="/**/selectDashboardMainStatsAjax.do")
	public String selectDashboardMainStatsAjax(
			SysMngrDashboardVO paramVO,
			HttpServletRequest request, 
			ModelMap model) throws Exception{

		model.addAttribute("siteStatList", sysMngrDashboardService.selectSiteStatList(paramVO));
		
		return "wzwg/sysMngr/dashboard/dashboardMainStatsAjax";
	}

	@RequestMapping(value="/**/sysMngr/selectSiteStatListExcel.do")
	public void selectSiteStatListExcel(
			SysMngrDashboardVO paramVO,
			HttpServletRequest request, 
			HttpServletResponse response,
			ModelMap model) throws Exception{
		
		String fileName = egovMessageSource.getMessage("wzwg.sysMngr.word.bysiteSttus02");
		HashMap<String ,Object> beans = new HashMap<String ,Object>();  
		beans.put("siteStatList", sysMngrDashboardService.selectSiteStatListExcel(paramVO));
		ExcelCreater.excelCreate(request,response , beans, "Globals.siteStatExcelForm", fileName) ;
	}
	
	@RequestMapping(value={"/mngr/selectDisk.do","/{siteKey}/mngr/selectDisk.do"})
	public strictfp void selectDisk(HttpServletRequest request, HttpServletResponse response,
			ModelMap model) throws Exception{
			String serverPath = request.getSession().getServletContext().getRealPath("/");
			String uploadPath = EgovProperties.getProperty("Globals.fileStorePath");
			File disk = new File(serverPath + uploadPath);
			double totalSpace =  disk.getTotalSpace() / Math.pow(1024, 3);//전체용량
			double useSpace = disk.getUsableSpace() / Math.pow(1024, 3);//남은용량
			double modSpace = totalSpace - useSpace;//사용중인용량
			double useSpaceRate = modSpace / totalSpace *100;
			
			//System.out.println("디스크 용량 : " + (Math.round(totalSpace*100 )/100D) + "GB");
			//System.out.println("사용 용량 : " + (Math.round(modSpace*100 )/100D) + "GB");
			//System.out.println("남은 용량 : " + (Math.round(useSpace*100 )/100D) + "GB");
			//System.out.println("사용율 : " + (Math.round(useSpaceRate*100 )/100D) + "%");
			String msg = "total:" + (Math.round(totalSpace*100 )/100D) + "GB\n";
			msg += "use:" + (Math.round(modSpace*100 )/100D) + "GB\n";
			msg += "free:" + (Math.round(useSpace*100 )/100D) + "GB\n";
			msg += "rate:" + (Math.round(useSpaceRate*100 )/100D) + "%";
			
			response.getWriter().print(msg);
	}
}
