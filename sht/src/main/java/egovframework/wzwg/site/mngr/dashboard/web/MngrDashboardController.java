package egovframework.wzwg.site.mngr.dashboard.web;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import egovframework.wzwg.cmm.mber.login.service.CmmLoginVO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileUtil;
import egovframework.wzwg.site.mngr.dashboard.service.MngrDashboardService;
import egovframework.wzwg.site.mngr.dashboard.service.MngrDashboardVO;
import egovframework.wzwg.sysMngr.cmm.util.CmmSysParameterSetUtil;
import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttQnaDataManageService;
import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttUnityDataManageService;
import egovframework.wzwg.sysMngr.opnsu.ntt.service.OpnsuNttVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoVO;

@Controller
public class MngrDashboardController {

	

	@Resource(name="MngrDashboardService")
	private MngrDashboardService mngrDashboardService;
	
    /** OpnsuNttUnityDataManageService */
    @Resource(name="OpnsuNttUnityDataManageService")
    protected OpnsuNttUnityDataManageService nttUnityService;	
    
    /** OpnsuNttQnaDataManageService */
    @Resource(name="OpnsuNttQnaDataManageService")
    protected OpnsuNttQnaDataManageService nttQnaService;
	
    @Resource(name="ModuleUploadFileUtil")
    protected ModuleUploadFileUtil moduleUploadFileUtil;
    
    @Resource(name="SysMngrSiteAdiInfoService")
	private SysMngrSiteAdiInfoService siteAdiInfoService;
    
	@RequestMapping(value={"/mngr/selectDashboardMain.do","/{siteKey}/mngr/selectDashboardMain.do"})
	public String selectDashboardMain(HttpServletRequest request, 
			ModelMap model) throws Exception{
		MngrDashboardVO mngrDashboardVO = new MngrDashboardVO();
		String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
		HttpSession session = request.getSession();
		CmmLoginVO loginVO = (CmmLoginVO) session.getAttribute("loginVO");
		
	       boolean nadminAt =  CmmSessionUtil.getSessionBooleanValue(request, "NADMIN_AT"); 
	       boolean sadminAt =  CmmSessionUtil.getSessionBooleanValue(request, "SADMIN_AT");
		if(loginVO == null || !(nadminAt || sadminAt)) { 
			String wzwgContext =CmmSysParameterSetUtil.getUrlWzwgContext(request);
			return "redirect:"+wzwgContext+"/mngrLoginForm.do";
		}
		
		mngrDashboardVO.setSiteSeq(siteSeq);
		mngrDashboardVO.setContectId(loginVO.getUsrSeq());
		mngrDashboardVO.setTodayYn("N");
		model.addAttribute("lastLgnDt",mngrDashboardService.selectSiteLastLgnDt(mngrDashboardVO));
		model.addAttribute("usrTotCnt",mngrDashboardService.selectSiteUsrCnt(mngrDashboardVO));
		mngrDashboardVO.setTodayYn("Y");
		model.addAttribute("usrTodayCnt",mngrDashboardService.selectSiteUsrCnt(mngrDashboardVO));
		mngrDashboardVO.setTodayYn("N");
		model.addAttribute("vistTodayCnt",mngrDashboardService.selectSiteVisitCnt(mngrDashboardVO));
		model.addAttribute("visitTotCnt",mngrDashboardService.selectSiteVisitTotCnt(mngrDashboardVO));
		model.addAttribute("nttTotCnt",mngrDashboardService.selectSiteNttCnt(mngrDashboardVO));
		mngrDashboardVO.setTodayYn("Y");
		model.addAttribute("nttTodayCnt",mngrDashboardService.selectSiteNttCnt(mngrDashboardVO));
		model.addAttribute("nttStatList", mngrDashboardService.selectSiteNttStatList(mngrDashboardVO));
		model.addAttribute("usrStatList", mngrDashboardService.selectSiteUsrStatList(mngrDashboardVO));
		
		OpnsuNttVO opnsuNttVO = new OpnsuNttVO();
		opnsuNttVO.setBbsSeq("10000000001");
		model.addAttribute("noticeList", nttUnityService.selectNttScrinCntnts(opnsuNttVO));
		
		opnsuNttVO.setBbsSeq("10000000002");
		model.addAttribute("dataList", nttUnityService.selectNttScrinCntnts(opnsuNttVO));
		
		opnsuNttVO.setBbsSeq("10000000004");
		model.addAttribute("faqList", nttUnityService.selectNttScrinCntnts(opnsuNttVO));
		
		opnsuNttVO.setBbsSeq("10000000003");
		opnsuNttVO.setSiteSeq(siteSeq);
		model.addAttribute("qnaList", nttQnaService.selectNttScrinCntnts(opnsuNttVO));
		
		SysMngrSiteAdiInfoVO resultVO = new SysMngrSiteAdiInfoVO();
    	resultVO.setSiteSeq(siteSeq);
    	
    	resultVO = siteAdiInfoService.selectSiteAdiInfoDetail(resultVO);
    	
    	if(resultVO != null && "Y".equals(resultVO.getFileProvdAt())){
	    	model.addAttribute("siteAdiInfo", resultVO);
	    	
			model.addAttribute("siteAtchFileSize", moduleUploadFileUtil.getFolderSize(request, resultVO.getFileCpctySe()));
    	}
    	
		return "wzwg/site/mngr/dashboard/dashboardMain";
	}
	
}
