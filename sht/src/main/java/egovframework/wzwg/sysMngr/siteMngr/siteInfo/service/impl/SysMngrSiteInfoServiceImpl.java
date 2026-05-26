package egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.com.cmm.service.Globals;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.wzwg.cmm.mber.sbscrb.service.CmmSbscrbVO;
import egovframework.wzwg.cmm.mber.sbscrb.service.impl.CmmSbscrbDAO;
import egovframework.wzwg.cmm.util.CmmSessionUtil;
import egovframework.wzwg.cmm.util.excel.ExcelRead;
import egovframework.wzwg.cmm.util.excel.ExcelReadOption;
import egovframework.wzwg.module.bbs.unity.service.ModuleBbsUnityBassInfoService;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileUtil;
import egovframework.wzwg.module.upload.file.service.ModuleUploadFileVO;
import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntCfgService;
import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntCfgVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoService;
import egovframework.wzwg.site.mngr.menu.service.SiteHdftrMenuService;
import egovframework.wzwg.site.mngr.menu.service.SiteHdftrMenuVO;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuService;
import egovframework.wzwg.sysMngr.siteMngr.menuEstbs.service.MenuEstbsService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteAdiInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteDomnVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteModuleInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteInfo.service.SysMngrSiteModuleInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteEssntlStplatService;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoService;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatSimpService;


/**
 * ㅁ 시스템 - 사이트관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
@Service("SysMngrSiteInfoService")
public class SysMngrSiteInfoServiceImpl extends EgovAbstractServiceImpl implements SysMngrSiteInfoService {

    /** 모듈첨부파일UTIL **/
	@Resource(name="ModuleUploadFileUtil")
    protected ModuleUploadFileUtil fileUtil;

    @Resource(name="SysMngrSiteInfoDAO")
    private SysMngrSiteInfoDAO siteInfoDAO;

	@Resource(name="SysMngrSiteOpertNtcDAO")
	SysMngrSiteOpertNtcDAO siteOpertNtcDAO;
	
    @Resource(name="SiteMenuService")
    private SiteMenuService siteMenuService;
    
    
    @Resource(name="SysMngrSiteAdiInfoService")
	private SysMngrSiteAdiInfoService siteAdiInfoService;

    // 컨텐츠정보
    @Resource(name="CntntsInfoService")
    private CntntsInfoService cntntsInfoService;
    
    /** ModuleBbsUnityBassInfoService */
    @Resource(name="ModuleBbsUnityBassInfoService")
    protected ModuleBbsUnityBassInfoService bbsUnityBassInfoService;
    
    //탑메뉴서비스
    @Resource(name="SiteHdftrMenuService")
    private SiteHdftrMenuService siteHdftrMenuService;

	@Resource(name="SiteCmntCfgService")
	private SiteCmntCfgService siteCmntCfgService;

	// 메뉴설정
    @Resource(name="MenuEstbsService")
    private MenuEstbsService menuEstbsService;

    // 사이트 도메인
    @Resource(name="SysMngrSiteDomnDAO")
    private SysMngrSiteDomnDAO siteDomnDAO;
    
    // 사이트 가입
    @Resource(name="CmmSbscrbDAO")
    private CmmSbscrbDAO cmmSbscrbDAO;
    
    
    @Resource(name="SiteStplatSimpService")
	private SiteStplatSimpService stplatSimpService;
	
	@Resource(name="SiteStplatInfoService")
	private SiteStplatInfoService siteStplatInfoService;
	
	@Resource(name="SysMngrSiteInfoService")
	private SysMngrSiteInfoService siteInfoService;
	
	@Resource(name="SiteEssntlStplatService")
	private SiteEssntlStplatService siteEssntlStplatService;
	
    
    @Resource(name="SysMngrSiteModuleInfoService")
	private SysMngrSiteModuleInfoService siteModuleInfoService;
    

    /**
	 * ㅁ 시스템 - 사이트 정보 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<SysMngrSiteInfoVO> selectSiteInfoList(SysMngrSiteInfoVO paramVO) throws Exception {
    	return siteInfoDAO.selectSiteInfoList(paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 정보 목록 건수
     * @param paramVO
     * @return
     * @throws Exception
     */
    public Integer selectSiteInfoListCnt(SysMngrSiteInfoVO paramVO) throws Exception {
    	return siteInfoDAO.selectSiteInfoListCnt(paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 정보 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
    public SysMngrSiteInfoVO selectSiteInfoDetail(SysMngrSiteInfoVO paramVO) throws Exception {
    	return siteInfoDAO.selectSiteInfoDetail(paramVO);
    }

    /**
	 * ㅁ 시스템 - 사이트 정보 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void registSiteInfo(SysMngrSiteInfoVO paramVO, HttpServletRequest request) throws Exception {
    	
    	//사이트 시퀀스 획득
    	String siteSeq = siteInfoDAO.selectNextSiteSeq();
    	String sysSiteSeq = "10000000001";
    	//사이트 정보 등록
    	paramVO.setSiteSeq(siteSeq);
    	siteInfoDAO.registSiteInfo(paramVO);
    	
    	SysMngrSiteModuleInfoVO siteModuleInfoVO = new SysMngrSiteModuleInfoVO();
    	
    	siteModuleInfoVO.setSiteSeq(siteSeq);
    	siteModuleInfoVO.setFrstRegisterId("SYSTEM");
    	siteModuleInfoVO.setFrstRegisterIp(request.getRemoteAddr());
    	
    	siteModuleInfoService.registAllSiteModuleInfo(siteModuleInfoVO);
    	
//    	//사이트 초기메뉴 셋팅
//        // 접속한 시스템사이트SEQ
//    	MenuEstbsVO menuEstbsVO = new MenuEstbsVO();
//    	
//        String sysSiteSeq = CmmSessionUtil.getSessionSiteSeq(request);
//        
//        // 현재 접속한 관리자사이트SEQ
//        menuEstbsVO.setSysSiteSeq(sysSiteSeq);
//        
//    	menuEstbsService.registMenuEstbsSiteSetAjax(menuEstbsVO);
    /**	
    	//초기 게시판 정보 등록
    	ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
    	moduleBbsVO.setFrstRegisterId(paramVO.getFrstRegisterId());
    	moduleBbsVO.setListScrinCode("L");
    	
    	String [] menuArr = ((String)EgovProperties.getProperty("Globals.siteBbsNm")).split(",");
    	for (int i = 0; i < menuArr.length; i++) {
    		moduleBbsVO.setBbsNm(menuArr[i]);
    		moduleBbsVO.setBbsDc(menuArr[i]);
    		String cntntsSeq = bbsUnityBassInfoService.registBbsBassInfoInit(moduleBbsVO);
    		
    		//초기 컨텐츠 정보 등록
        	CntntsInfoVO cntntsInfoVO = new CntntsInfoVO();
        	cntntsInfoVO.setSiteSeq(siteSeq);
        	cntntsInfoVO.setCntntsSeq(cntntsSeq);
        	cntntsInfoVO.setCntntsNm(menuArr[i]);
        	cntntsInfoVO.setCntntsDc(menuArr[i]);
        	cntntsInfoVO.setFrstRegisterId(paramVO.getFrstRegisterId());
        	
        	//사이트 컨텐츠 시퀀스 조회
        	String sitecntntsSeq = cntntsInfoService.selectSitecntntsSeq();
        	cntntsInfoVO.setSitecntntsSeq(sitecntntsSeq);
        	cntntsInfoVO.setSysmoduleSeq(EgovProperties.getProperty("Globals.initSysmoduleSeq"));
        	cntntsInfoService.registCntntsInfoInit(cntntsInfoVO);
        	
        	
        	//초기 메뉴 등록 - 컨테츠 시퀀스를 알아야만 매핑할수 있어서 1차메뉴만 생성할수 있게 개발함
        	SiteMenuVO siteMenuVO = new SiteMenuVO();
        	siteMenuVO.setSiteSeq(siteSeq);
        	siteMenuVO.setFrstRegisterId(paramVO.getFrstRegisterId());
        	siteMenuVO.setSitecntntsSeq(sitecntntsSeq);
        	siteMenuVO.setMenuNm(menuArr[i]);
    		siteMenuVO.setMenuDc(menuArr[i]);
    		siteMenuVO.setMenuOrdr(i+"");
    		siteMenuVO.setMenuLv("1");
        	siteMenuService.registSiteMenuInit(siteMenuVO);
		}
    	**/
    	//커뮤니티 기본정보 저장
    	SiteCmntCfgVO siteCmntCfgVO = new SiteCmntCfgVO();
    	siteCmntCfgVO.setSiteSeq(siteSeq);
    	siteCmntCfgVO.setCmntEstblCode("SC00000332");
    	siteCmntCfgVO.setCmntAppvlCode("SC00000334");
    	siteCmntCfgVO.setUserId("SYSTEM");
    	siteCmntCfgVO.setCmntInfo(" ");
    	siteCmntCfgService.registSiteCmntCfg(siteCmntCfgVO);
    	//상단, 하단메뉴 생성
    	createSiteHdftrMenuInfo(siteSeq, paramVO.getFrstRegisterId(), paramVO.getSiteKey());
    	
    	// 기본메뉴 셋팅 - 시작
    	SysMngrSiteAdiInfoVO  sysMngrSiteAdiInfoVO =  new SysMngrSiteAdiInfoVO();
    	sysMngrSiteAdiInfoVO.setSiteSeq(siteSeq);
    	sysMngrSiteAdiInfoVO.setSslUseAt("N");
    	siteAdiInfoService.registSiteAdiInfo(sysMngrSiteAdiInfoVO);
    	// 기본메뉴 셋팅 - 끝
    	
    	/** 기본 약관 설정 - 시작 */
    	SiteStplatInfoVO stplatVO = new SiteStplatInfoVO();
    	stplatVO.setSiteSeq(sysSiteSeq);
    	stplatVO.setFirstIndex(0);
    	stplatVO.setRecordCountPerPage(10000);
		List<SiteStplatInfoVO> stplatList = siteStplatInfoService.selectSiteStplatInfoList(stplatVO);
		
		if(stplatList.size() != 0 && stplatList != null && !stplatList.isEmpty()){
			for(int i=0; i<stplatList.size(); i++){
				if(("Y").equals(StringUtils.defaultString(stplatList.get(i).getDefaultAt()))){
						
					String tempStplatSeq = stplatList.get(i).getStplatSeq();
					String stplatSeq = siteStplatInfoService.selectSiteStplatInfoNextSeq();
					
					SiteStplatInfoVO tempStplatVO = new SiteStplatInfoVO();
					tempStplatVO.setStplatSeq(stplatSeq);
					tempStplatVO.setSiteSeq(siteSeq);
					tempStplatVO.setStplatNm(stplatList.get(i).getStplatNm());
					tempStplatVO.setStplatDc(stplatList.get(i).getStplatDc());
					tempStplatVO.setStplatTyCode(stplatList.get(i).getStplatTyCode());
					tempStplatVO.setFrstRegisterId(paramVO.getFrstRegisterId());
					tempStplatVO.setLastUpdusrId(paramVO.getFrstRegisterId());
					tempStplatVO.setEssntlAt(stplatList.get(i).getEssntlAt());
					tempStplatVO.setSysStplatSeq(tempStplatSeq);
					siteStplatInfoService.registSiteStplatInfo(tempStplatVO);
					
					/** 시스템관리자에 등록되어있는 stplatSeq, siteSeq로 변경 */
					tempStplatVO.setStplatSeq(tempStplatSeq);
					tempStplatVO.setSiteSeq(sysSiteSeq);
			        List<SiteStplatInfoVO> stplatSimpList = stplatSimpService.selectSiteStplatSimpList(tempStplatVO);
			        
			        if(stplatSimpList.size() != 0 && stplatSimpList != null && !stplatSimpList.isEmpty()){
			        	for(int j=1; j<=stplatSimpList.size(); j++){
			        		
			        		SiteStplatInfoVO tempStplatSimpVO = new SiteStplatInfoVO();
			        		tempStplatSimpVO.setSiteSeq(siteSeq);
			        		tempStplatSimpVO.setStplatSeq(stplatSeq);
			        		tempStplatSimpVO.setOpertnDe(stplatSimpList.get(stplatSimpList.size()-j).getOpertnDe().replaceAll("-", ""));
			        		tempStplatSimpVO.setStplatSj(stplatSimpList.get(stplatSimpList.size()-j).getStplatSj());
			        		tempStplatSimpVO.setStplatCn(stplatSimpList.get(stplatSimpList.size()-j).getStplatCn());
			        		tempStplatSimpVO.setFrstRegisterId(stplatSimpList.get(stplatSimpList.size()-j).getFrstRegisterId());
			        		tempStplatSimpVO.setLastUpdusrId(stplatSimpList.get(stplatSimpList.size()-j).getFrstRegisterId());
			        		tempStplatSimpVO.setSysStplatsimpSeq(stplatSimpList.get(stplatSimpList.size()-j).getStplatsimpSeq());
			        		
			        		stplatSimpService.registSiteStplatSimp(tempStplatSimpVO);
			        	}
			        }
				}

			}
		}
		/** 기본 약관 설정 - 끝 */
		if(!paramVO.getSiteKey().equals("")) {
			String siteUrl = EgovProperties.getProperty("reprsnt.domn.url")+"/"+paramVO.getSiteKey();
			SysMngrSiteDomnVO siteDomnVO = new SysMngrSiteDomnVO();
			siteDomnVO.setSiteUrl(siteUrl);
			String domnSeq = siteDomnDAO.selectSiteDomnSeq();
            // domnSeq - map 등록
			siteDomnVO.setDomnSeq(domnSeq);
			siteDomnVO.setSiteSeq(paramVO.getSiteSeq());
			siteDomnVO.setDomnSeCode(Globals.EXCEL_DOMN_SE_CODE);
			siteDomnVO.setUseLangCode(Globals.EXCEL_USE_LANG_CODE);
		    siteDomnVO.setFrstRegisterId("SYSTEM");
		    siteDomnVO.setLastUpdusrId("SYSTEM");
		    siteDomnVO.setReprsntDomnAt("Y");
			siteDomnDAO.registSiteDomn(siteDomnVO);
		}
    }


	/**
	 * ㅁ 시스템 - 사이트 정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void modifySiteInfo(SysMngrSiteInfoVO paramVO) throws Exception {
    	siteInfoDAO.modifySiteInfo(paramVO);
    	
    	String prevSiteKey = StringUtils.defaultString(paramVO.getPrevSiteKey());
    	String siteKey = StringUtils.defaultString(paramVO.getSiteKey());
    	
    	if(("").equals(prevSiteKey) && ("").equals(siteKey)) {
    	}else if(!("").equals(prevSiteKey) && ("").equals(siteKey)) {
    		SysMngrSiteDomnVO siteDomnVO = new SysMngrSiteDomnVO();
    		String prevSiteUrl = EgovProperties.getProperty("reprsnt.domn.url")+"/"+paramVO.getPrevSiteKey();
    		siteDomnVO.setSiteUrl(prevSiteUrl);
    		siteDomnVO.setSiteSeq(paramVO.getSiteSeq());
    		String domnSeq = siteDomnDAO.selectSiteDomnSeqDetail(siteDomnVO);
    		siteDomnVO.setDomnSeq(domnSeq);
    		siteDomnDAO.deleteSiteDomn(siteDomnVO);
    	}else if(("").equals(prevSiteKey) && !("").equals(siteKey)) {
    		String siteUrl = EgovProperties.getProperty("reprsnt.domn.url")+"/"+paramVO.getSiteKey();
			SysMngrSiteDomnVO siteDomnVO = new SysMngrSiteDomnVO();
			siteDomnVO.setSiteUrl(siteUrl);
			String domnSeq = siteDomnDAO.selectSiteDomnSeq();
			siteDomnVO.setDomnSeq(domnSeq);
			siteDomnVO.setSiteSeq(paramVO.getSiteSeq());
			siteDomnVO.setDomnSeCode(Globals.EXCEL_DOMN_SE_CODE);
			siteDomnVO.setUseLangCode(Globals.EXCEL_USE_LANG_CODE);
		    siteDomnVO.setFrstRegisterId("SYSTEM");
		    siteDomnVO.setLastUpdusrId("SYSTEM");
		    siteDomnVO.setReprsntDomnAt("Y");
			siteDomnDAO.registSiteDomn(siteDomnVO);
    	}else {
    		if(!(paramVO.getSiteKey()).equals(paramVO.getPrevSiteKey())) {
	        	SysMngrSiteDomnVO siteDomnVO = new SysMngrSiteDomnVO();
	        	siteDomnVO.setSiteSeq(paramVO.getSiteSeq());
	        	String siteUrl = EgovProperties.getProperty("reprsnt.domn.url")+"/"+paramVO.getSiteKey();
	        	String prevSiteUrl = EgovProperties.getProperty("reprsnt.domn.url")+"/"+paramVO.getPrevSiteKey();
	        	siteDomnVO.setSiteUrl(siteUrl);
	        	siteDomnVO.setPrevSiteUrl(prevSiteUrl);
	        	siteDomnDAO.modifySiteDomnDir(siteDomnVO);
	    	}
    	}
    }

    /**
	 * ㅁ 시스템 - 사이트 상태 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void modifySiteSttus(SysMngrSiteInfoVO paramVO) throws Exception {
    	siteInfoDAO.modifySiteSttus(paramVO);
    	
    	if(("N").equals(paramVO.getSrvcAt())){
    		if(("").equals(paramVO.getOpertSeq())){
    			siteOpertNtcDAO.registSiteOpertNtc(paramVO);
    		}else{
    			siteOpertNtcDAO.modifySiteOpertNtc(paramVO);
    		}
    	}else if(("Y").equals(paramVO.getSrvcAt()) && !("").equals(paramVO.getOpertSeq())){
    		siteOpertNtcDAO.deleteSiteOpertNtc(paramVO);
    	}else{ }
    	
    }

  //상,하단 메뉴 등록
    private void createSiteHdftrMenuInfo(String siteSeq, String userId, String siteKey) {
    	/* 상단메뉴 등록 (로그인전, 로그인후) */
    	//로그인 전
    	String [] siteTopMenuNmLgnY = ((String)EgovProperties.getProperty("Globals.siteTopMenuNmLgnY")).split(",");
    	
    	for (int i = 0; i < siteTopMenuNmLgnY.length; i++) {
    		//topMenuInfo => 0 : 메뉴명, 1 : 메뉴URL
    		String [] topMenuInfo = siteTopMenuNmLgnY[i].split(":");
    		
    		SiteHdftrMenuVO siteHdftrMenuVO = new SiteHdftrMenuVO();
    		
    		siteHdftrMenuVO.setSiteSeq(siteSeq);
    		siteHdftrMenuVO.setHdftrmenuNm(topMenuInfo[0]);
    		siteHdftrMenuVO.setUserId(userId);
    		
    		if(!("").equals(StringUtils.defaultString(siteKey))) {
    			topMenuInfo[1] = "/" + siteKey + topMenuInfo[1];
    		}
    		
    		siteHdftrMenuVO.setHdftrmenuLinkUrl(topMenuInfo[1]);
    		siteHdftrMenuVO.setHdftrmenuTyCode("SC00000080"); //새창(SC00000079), 현재창(SC00000080)
    		siteHdftrMenuVO.setHdftrmenuDc(topMenuInfo[0]);
    		siteHdftrMenuVO.setHdftrCode("SC00000081"); //상단(SC00000081), 하단(SC00000082)
    		siteHdftrMenuVO.setHdftrmenuOrdr(""+(i+1));
    		siteHdftrMenuVO.setLgnAt("N");
    		siteHdftrMenuVO.setDefaultAt("Y");
    		siteHdftrMenuVO.setMenuTySe("N");
    		
    		siteHdftrMenuService.registSiteHdftrMenu(siteHdftrMenuVO);
    	}
    	
    	
    	//로그인 후
    	String [] siteTopMenuNmLgnN = ((String)EgovProperties.getProperty("Globals.siteTopMenuNmLgnN")).split(",");
    	
    	for (int i = 0; i < siteTopMenuNmLgnN.length; i++) {
    		//topMenuInfo => 0 : 메뉴명, 1 : 메뉴URL
    		String [] topMenuInfo = siteTopMenuNmLgnN[i].split(":");
    		
    		SiteHdftrMenuVO siteHdftrMenuVO = new SiteHdftrMenuVO();
    		
    		siteHdftrMenuVO.setSiteSeq(siteSeq);
    		siteHdftrMenuVO.setHdftrmenuNm(topMenuInfo[0]);
    		siteHdftrMenuVO.setUserId(userId);
    		
    		if(!("").equals(StringUtils.defaultString(siteKey))) {
    			topMenuInfo[1] = "/" + siteKey + topMenuInfo[1];
    		}
    		
    		siteHdftrMenuVO.setHdftrmenuLinkUrl(topMenuInfo[1]);
    		siteHdftrMenuVO.setHdftrmenuTyCode("SC00000080");
    		siteHdftrMenuVO.setHdftrmenuDc(topMenuInfo[0]);
    		siteHdftrMenuVO.setHdftrCode("SC00000081");
    		siteHdftrMenuVO.setHdftrmenuOrdr(""+(i+1));
    		siteHdftrMenuVO.setLgnAt("Y");
    		siteHdftrMenuVO.setDefaultAt("Y");
    		siteHdftrMenuVO.setMenuTySe("N");
    		
    		siteHdftrMenuService.registSiteHdftrMenu(siteHdftrMenuVO);
    	}
    	
    	/* 상단메뉴 등록 (로그인전, 로그인후) */
    	//로그인 전
    	String [] siteFooterMenuNmLgnY = ((String)EgovProperties.getProperty("Globals.siteFooterMenuNmLgnY")).split(",");
    	
    	for (int i = 0; i < siteFooterMenuNmLgnY.length; i++) {
    		//topMenuInfo => 0 : 메뉴명, 1 : 메뉴URL
    		String [] footerMenuInfo = siteFooterMenuNmLgnY[i].split(":");
    		if(footerMenuInfo.length >1){
	    		
	    		SiteHdftrMenuVO siteHdftrMenuVO = new SiteHdftrMenuVO();
	    		
	    		siteHdftrMenuVO.setSiteSeq(siteSeq);
	    		siteHdftrMenuVO.setHdftrmenuNm(footerMenuInfo[0]);
	    		siteHdftrMenuVO.setUserId(userId);
	    		
	    		if(!("").equals(StringUtils.defaultString(siteKey))) {
	    			footerMenuInfo[1] = "/" + siteKey + footerMenuInfo[1];
	    		}
	    		
	    		siteHdftrMenuVO.setHdftrmenuLinkUrl(footerMenuInfo[1]);
	    		siteHdftrMenuVO.setHdftrmenuTyCode("SC00000080");
	    		siteHdftrMenuVO.setHdftrmenuDc(footerMenuInfo[0]);
	    		siteHdftrMenuVO.setHdftrCode("SC00000082");
	    		siteHdftrMenuVO.setHdftrmenuOrdr(""+(i+1));
	    		siteHdftrMenuVO.setLgnAt("N");
	    		siteHdftrMenuVO.setDefaultAt("Y");
	    		siteHdftrMenuVO.setMenuTySe("N");
	    		
    		siteHdftrMenuService.registSiteHdftrMenu(siteHdftrMenuVO);
    		}
    	}
    	
    	
    	//로그인 후
    	String [] siteFooterMenuNmLgnN = ((String)EgovProperties.getProperty("Globals.siteFooterMenuNmLgnN")).split(",");
    	
    	for (int i = 0; i < siteFooterMenuNmLgnN.length; i++) {
    		//topMenuInfo => 0 : 메뉴명, 1 : 메뉴URL
    		String [] footerMenuInfo = siteFooterMenuNmLgnN[i].split(":");
    		
    		if(footerMenuInfo.length >1){
	    		SiteHdftrMenuVO siteHdftrMenuVO = new SiteHdftrMenuVO();
	    		
	    		siteHdftrMenuVO.setSiteSeq(siteSeq);
	    		siteHdftrMenuVO.setHdftrmenuNm(footerMenuInfo[0]);
	    		siteHdftrMenuVO.setUserId(userId);
	    		
	    		if(!("").equals(StringUtils.defaultString(siteKey))) {
	    			footerMenuInfo[1] = "/" + siteKey + footerMenuInfo[1];
	    		}
	    		
	    		siteHdftrMenuVO.setHdftrmenuLinkUrl(footerMenuInfo[1]);
	    		siteHdftrMenuVO.setHdftrmenuTyCode("SC00000080");
	    		siteHdftrMenuVO.setHdftrmenuDc(footerMenuInfo[0]);
	    		siteHdftrMenuVO.setHdftrCode("SC00000082");
	    		siteHdftrMenuVO.setHdftrmenuOrdr(""+(i+1));
	    		siteHdftrMenuVO.setLgnAt("Y");
	    		siteHdftrMenuVO.setDefaultAt("Y");
	    		siteHdftrMenuVO.setMenuTySe("N");
	    		siteHdftrMenuService.registSiteHdftrMenu(siteHdftrMenuVO);
    		}
    	}
	}

    /**
     * ㅁ 시스템 - 조합번호 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
    public Integer selectAsscNoCnt(SysMngrSiteInfoVO paramVO) throws Exception {
        return siteInfoDAO.selectAsscNoCnt(paramVO);
    }
    
    /**
     * ㅁ 시스템 - 사이트정보 엑셀 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<Map<String, String>> registSiteInfoExcel(SysMngrSiteInfoVO paramVO, HttpServletRequest request) throws Exception {

        List<Map<String, String>> excelContent = null;

        List<ModuleUploadFileVO> resultFile = null;
        
        MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;
        
        Map<String, MultipartFile> file = new HashMap<String, MultipartFile>();
        
        file.put("excelFile", multiRequest.getFile("excelFile"));
        
        if (!file.isEmpty()) {

            resultFile = fileUtil.parseFileInf(file, "LOG_", 0, "Globals.mdFilePath", "Globals.WhiteExcelFileExt", multiRequest, "siteInfoExcel", null, CmmSessionUtil.getSessionSiteSeq(request));

            if (resultFile != null) {
                
                // 엑셀util 셋팅
                ExcelReadOption excelReadOption = new ExcelReadOption();
                
                excelReadOption.setFilePath(resultFile.get(0).getFileStreCours()+resultFile.get(0).getStreFileNm());
                excelReadOption.setFileExtsn(resultFile.get(0).getFileExtsn());
                
                excelContent =ExcelRead.read(excelReadOption);
                
                if (excelContent != null) {
                    
                    int result = 0;
                    
                    for(Map<String, String> article: excelContent){
                        
                        // 인가번호 중복체크
                        String asscNo = StringUtils.defaultString((String)article.get("C"));
                        
                        if (!"".equals(asscNo)) {
                            
                            int asscNoCnt = siteInfoDAO.selectAsscNoCnt(paramVO);
                            
                            // 인가번호 중복 처리
                            if (asscNoCnt > 0) {

                                // 인가번호 중복
                                article.put("siteInfoResult", "ACCNO_CNT_ERROR");
                            } else {
                                // 도메인 중복체크
                                String domnUrl = StringUtils.defaultString((String)article.get("H"));
                                
                                if (!"".equals(domnUrl)) {
                                    
                                    SysMngrSiteDomnVO domnVO = new SysMngrSiteDomnVO();
                                    domnVO.setSiteUrl(domnUrl.trim());
                                    
                                    int domnCnt = siteDomnDAO.selectSiteDomnDplctChk(domnVO);
                                    
                                    // 도메인 중복 처리
                                    if (domnCnt > 0) {
                                        
                                        // 도메인 중복
                                        article.put("siteInfoResult", "DOMN_CNT_ERROR");
                                    } else {
                                        
                                        // siteSeq
                                        String siteSeq = siteInfoDAO.selectNextSiteSeq();
                                        
                                        // siteSeq - map 등록
                                        article.put("siteSeq", siteSeq);
                                        article.put("frstRegisterId", paramVO.getFrstRegisterId());
                                        
                                        // 대표전화번호 셋팅
                                        String telNo = StringUtils.defaultString((String)article.get("G"));
                                        
                                        if (!"".equals(telNo)) {
                                            
                                            String[] telNoArr = telNo.split("-");
                                            
                                            if (telNoArr != null) {
                                                
                                                for (int i=0; i<telNoArr.length; i++) {
                                                    
                                                    article.put("telno"+i, telNoArr[i]);
                                                }
                                            }
                                        }
                                        
                                        // siteInfo 등록
                                        result = siteInfoDAO.registSiteInfoExcel(article);
                                        
                                        // siteInfo 결과 등록
                                        article.put("siteInfoResult", Integer.toString(result));
                                        
                                        if (result > 0) {
                                            // 도메인SEQ
                                            String domnSeq = siteDomnDAO.selectSiteDomnSeq();
                                            
                                            // domnSeq - map 등록
                                            article.put("domnSeq", domnSeq);
                                            article.put("domnSeCode", Globals.EXCEL_DOMN_SE_CODE);
                                            article.put("useLangCode", Globals.EXCEL_USE_LANG_CODE);

                                            // siteDomain 등록
                                            result = siteDomnDAO.registSiteDomnExcel(article);
                                            
                                            // siteDomain 결과 등록
                                            article.put("siteInfoResult", Integer.toString(result));
                                            
                                            // 관리자 등록
                                            if (result > 0) {
                                                
                                                String userId = StringUtils.defaultString((String)article.get("I")).trim();
                                                String userPw = StringUtils.defaultString((String)article.get("J")).trim();
                                                
                                                if (!"".equals(userId)) {
                                                    
                                                    CmmSbscrbVO mngrUserVO = new CmmSbscrbVO();
                                                    
                                                    mngrUserVO.setUsrtySeq(Globals.AUTH_NORMAL_ADMIN);
                                                    mngrUserVO.setUserId(userId);
                                                    mngrUserVO.setSiteSeq(siteSeq);
                                                    
                                                    String idChk = StringUtils.defaultString(cmmSbscrbDAO.selectSbscrbUserIdDplctCeck(mngrUserVO)); 
                                                    
                                                    if ("".equals(idChk)) {
                                                        
                                                        // 아이디 중복
                                                        article.put("siteInfoResult", "MNGRUSERID_CNT_ERROR");
                                                    } else {
                                                        
                                                        if (!"".equals(userPw)) {
                                                            
                                                            String enpassword = EgovFileScrty.encryptPassword(userPw);
                                                            mngrUserVO.setPassword(enpassword);
                                                    
                                                            mngrUserVO.setUsrSeq(cmmSbscrbDAO.selectNextUsrSeq());
                                                        
                                                            mngrUserVO.setCrtfctSeCode("SC00000026");
                                                        
                                                            // 회원정보 등록
                                                            result = cmmSbscrbDAO.registUsrSbscrbInfo(mngrUserVO);
                                                            
                                                            // siteDomain 결과 등록
                                                            article.put("siteInfoResult", Integer.toString(result));
                                                        } else {
                                                            // 비밀번호 입력 X
                                                            article.put("siteInfoResult", "MNGRUSERPW_ERROR");
                                                        }
                                                    }
                                                } else {
                                                    // 아이디 입력 X
                                                    article.put("siteInfoResult", "MNGRUSERID_ERROR");
                                                }
                                            }
                                        }
                                    }
                                } else {
                                    
                                    // 도메인 없음
                                    article.put("siteInfoResult", "DOMN_ERROR");
                                }
                            }
                        } else {
                            // 인가번호 없음
                            article.put("siteInfoResult", "ACCNO_ERROR");
                        }
                    }
                }
            }
        }
        
        return excelContent;
    }

	@Override
	public int selectSiteInfoSysCheck(SysMngrSiteInfoVO paramVO)
			throws Exception {
		// TODO Auto-generated method stub
		return siteInfoDAO.selectSiteInfoSysCheck(paramVO);
	}
	
	public List<SysMngrSiteInfoVO> selectSiteInfoSignList(SysMngrSiteInfoVO paramVO) throws Exception {
    	return siteInfoDAO.selectSiteInfoSignList(paramVO);
    }
	
	/**
	 * 사이트 키 중복체크
	 */
	public String selectSiteInfoDplctCheck(SysMngrSiteInfoVO paramVO) {
		return siteInfoDAO.selectSiteInfoDplctCheck(paramVO);
	}

}
