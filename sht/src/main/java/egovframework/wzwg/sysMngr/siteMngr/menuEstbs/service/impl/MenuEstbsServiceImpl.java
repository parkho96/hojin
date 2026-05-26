package egovframework.wzwg.sysMngr.siteMngr.menuEstbs.service.impl;

import java.io.IOException;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.IllegalFormatException;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.util.ReflectionUtils;

import egovframework.com.cmm.context.SpringApplicationContext;
import egovframework.com.cmm.service.Globals;
import egovframework.wzwg.module.bbs.cmmn.service.ModuleBbsVO;
import egovframework.wzwg.module.bbs.custom.service.impl.ModuleBbsCustomBassInfoDAO;
import egovframework.wzwg.module.bbs.unity.service.ModuleBbsUnityBassInfoService;
import egovframework.wzwg.module.cmnt.service.CmntMenuAuthService;
import egovframework.wzwg.module.cmnt.service.CmntMenuService;
import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntInfoService;
import egovframework.wzwg.site.mngr.cmnt.service.SiteCmntInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.impl.CntntsAuthDAO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoService;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuVO;
import egovframework.wzwg.site.mngr.menu.service.impl.SiteMenuDAO;
import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.SysModuleInfoVO;
import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.impl.SysModuleInfoDAO;
import egovframework.wzwg.sysMngr.siteMngr.menuEstbs.service.MenuEstbsService;
import egovframework.wzwg.sysMngr.siteMngr.menuEstbs.service.MenuEstbsVO;
import egovframework.wzwg.sysMngr.usrMngr.usrInfo.service.SysMngrUsrInfoService;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;


/**
 * ㅁ 시스템 - 사이트관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
@Slf4j
@Service("MenuEstbsService")
public class MenuEstbsServiceImpl extends EgovAbstractServiceImpl implements MenuEstbsService {

    /** 메뉴설정정보 **/
    @Resource(name="MenuEstbsDAO")
    private MenuEstbsDAO menuEstbsDAO;

    /** 셋팅메뉴정보 **/
    @Resource(name="MenuEstbsInfoDAO")
    private MenuEstbsInfoDAO menuEstbsInfoDAO;

    /** 시스템모듈정보 **/
    @Resource(name="SysModuleInfoDAO")
    private SysModuleInfoDAO sysModuleInfoDAO;

    /** 사이트컨텐츠정보 **/
    @Resource(name="CntntsInfoService")
    private CntntsInfoService cntntsInfoService;

    /** 사이트컨텐츠권한 **/
    @Resource(name="CntntsAuthDAO")
    private CntntsAuthDAO cntntsAuthDAO;
    
    /** 사이트메뉴 **/
    @Resource(name="SiteMenuDAO")
    private SiteMenuDAO siteMenuDAO;
    
    /** 사이트커뮤니티정보 **/
    @Resource(name="SiteCmntInfoService")
    private SiteCmntInfoService siteCmntInfoService;

    /** 사이트커뮤니티-메뉴 **/
   @Resource(name="CmntMenuService")
    private CmntMenuService cmntMenuService;

   /** 사이트커뮤니티-권한 **/
   @Resource(name="CmntMenuAuthService")
   private CmntMenuAuthService cmntMenuAuthService;

   /** 사이트커뮤니티-통합게시판 **/
   @Resource(name="ModuleBbsUnityBassInfoService")
   private ModuleBbsUnityBassInfoService bbsUnityBassInfoService;

   /** 시스템관리자-사용자정보 **/
   @Resource(name="SysMngrUsrInfoService")
   private SysMngrUsrInfoService usrInfoService;

   /** 게시판-커스텀게시판 **/
   @Resource(name="ModuleBbsCustomBassInfoDAO")
   private ModuleBbsCustomBassInfoDAO bbsCustomBassInfoDAO;   
   
   
    
    /**
     * ㅁ 시스템 - 사이트 그룹 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<MenuEstbsVO> selectMenuEstbsList(MenuEstbsVO paramVO) throws Exception {
        
        return menuEstbsDAO.selectMenuEstbsList(paramVO);
    }

    /**
     * ㅁ 시스템 - 사이트 그룹 목록 건수
     * @param paramVO
     * @return
     * @throws Exception
     */
    public Integer selectMenuEstbsListCnt(MenuEstbsVO paramVO) throws Exception {

        return menuEstbsDAO.selectMenuEstbsListCnt(paramVO);
    }

    /**
     * ㅁ 시스템 - 사이트 그룹 상세
     * @param paramVO
     * @return
     * @throws Exception
     */
    public MenuEstbsVO selectMenuEstbsDetail(MenuEstbsVO paramVO) throws Exception {

        return menuEstbsDAO.selectMenuEstbsDetail(paramVO);
    }

    /**
     * ㅁ 시스템 - 사이트 그룹 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void registMenuEstbs(MenuEstbsVO paramVO) throws Exception {

        String estbsAt = StringUtils.defaultString(paramVO.getEstbsAt());
        
        if ("Y".equals(estbsAt)) {

            // 전체 메뉴설정여부 N 초기화
            menuEstbsDAO.modifyMenuEstbsAtInitl(paramVO);
        }
        
        menuEstbsDAO.registMenuEstbs(paramVO);
    }

    /**
     * ㅁ 시스템 - 사이트 그룹 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public void modifyMenuEstbs(MenuEstbsVO paramVO) throws Exception {

        String estbsAt = StringUtils.defaultString(paramVO.getEstbsAt());
        
        if ("Y".equals(estbsAt)) {

            // 전체 메뉴설정여부 N 초기화
            menuEstbsDAO.modifyMenuEstbsAtInitl(paramVO);
        }
        
        menuEstbsDAO.modifyMenuEstbs(paramVO);
    }

    /**
     * ㅁ 시스템 - 사이트 2차 그룹 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<MenuEstbsVO> selectMenuEstbsMlsfcList(MenuEstbsVO paramVO) throws Exception {

        return menuEstbsDAO.selectMenuEstbsMlsfcList(paramVO);
    }

    /**
     * ㅁ 시스템 - 사이트 그룹 셀렉트 박스
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<MenuEstbsVO> selectMenuEstbsAjax(MenuEstbsVO paramVO) throws Exception {

        return menuEstbsDAO.selectMenuEstbsAjax(paramVO);
    }

    /**
     * ㅁ 시스템 - select box 출력을 위한 조회 - 사이트 그룹 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<MenuEstbsVO> selectMenuEstbsCodeList(MenuEstbsVO paramVO) throws Exception {
        
        return menuEstbsDAO.selectMenuEstbsCodeList(paramVO);
    }

    /**
     * ㅁ 시스템 - 메뉴설정 사이트 셋팅
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registMenuEstbsSiteSetAjax(MenuEstbsVO paramVO) throws Exception {

        int result = 0;
        
        try {
            // 메뉴설정SEQ
    //        String estbsSetSeq = menuEstbsDAO.selectMenuEstbsSeq();
    //        paramVO.setEstbsinfoSeq(estbsSetSeq);
            
            String siteSeq = StringUtils.defaultString(paramVO.getSiteSeq());
            
            //System.out.println("**** 대상 사이트SEQ : " + siteSeq);
            
            HashMap<String, String> menuSeqMap = new HashMap<String, String>();
            
            if (!"".equals(siteSeq)) {
    
                SiteMenuVO setParamVO = new SiteMenuVO();
    
                // 일단 하드코딩 - 설정한 슈퍼관리자 사이트ID
                setParamVO.setSiteSeq(paramVO.getSysSiteSeq());
                setParamVO.setEstbsinfoSeq(paramVO.getEstbsinfoSeq());
                
                // 설정메뉴 조회
                List<SiteMenuVO> estbsMenuList = menuEstbsInfoDAO.selectSiteMenuEstbsInfoList(setParamVO);
                
                if (estbsMenuList != null) {
                    
                    SiteMenuVO delVO = new SiteMenuVO();
                    
                    delVO.setSiteSeq(siteSeq);
                    delVO.setFrstRegisterId(paramVO.getFrstRegisterId());
                    
                    // 기존 메뉴 연결 컨텐츠 삭제
//                    menuEstbsDAO.deleteMenuEstbsConnCntntsAll(paramVO);
                    
                    // 커뮤니티 예외처리
                    // 커뮤니티 삭제 대상 메뉴가 커뮤니티일경우 기존 커뮤니티 비승인 처리
                    // 사이트에 개설된 모든 커뮤니티 비공개+미승인 처리
                    SiteCmntInfoVO cmntVO = new SiteCmntInfoVO();
                    
                    cmntVO.setSiteSeq(siteSeq);
                    cmntVO.setCmntApprovalCode(Globals.CMNT_APPVL_CODE);
//                    cmntVO.setCmntOpenCode(Globals.CMNT_OPEN_CODE);
                    
//                    siteCmntInfoService.modifySiteCmntInfoApprovalAll(cmntVO);
                    
                    // 기존 메뉴 삭제
                    siteMenuDAO.deleteSiteMenuAll(delVO);
                    
                    for (int i=0; i<estbsMenuList.size(); i++) {
                        
                        SiteMenuVO getMenuVO = estbsMenuList.get(i);
    
                        String sysMdSeq = StringUtils.defaultString(getMenuVO.getSysmoduleSeq());
                        //System.out.println("**** 모듈여부 : " + sysMdSeq);
                        
                        String getSiteCntntsSeq = null;
                        
                        // 그룹? 모듈? 판단
                        if (!"".equals(sysMdSeq)) {
    
                            // 사이트 컨텐츠
                            String siteCntntsSeq = StringUtils.defaultString(getMenuVO.getSitecntntsSeq());
                            String cntntsSeq = StringUtils.defaultString(getMenuVO.getCntntsSeq());
                          //  System.out.println("**** 컨텐츠여부 : " + siteCntntsSeq);
                            
                            // 컨텐츠 등록이 필요한가?
                            if (!"".equals(siteCntntsSeq)) {
    
                              //  System.out.println("***** SYS기준 > 시스템모듈정보 조회 - 시작");
                                // 모듈정보조회
                                SysModuleInfoVO getMdIfVO = sysModuleInfoDAO.selectSysModuleInfoDetail(sysMdSeq);
                             //   System.out.println("***** SYS기준 > 시스템모듈정보 조회 - 끝");
                                
                                // 모듈 인스턴스생성
                                String masterInstcNm = getMdIfVO.getMasterInstcNm();
                          //      System.out.println("***** SYS기준 > 해당 모듈 인스턴스 - masterInstcNm : " + masterInstcNm);
                                
                                if (masterInstcNm != null && !"".equals(StringUtils.defaultString(masterInstcNm))) {
                                    Object getObject = SpringApplicationContext.getBean(masterInstcNm);
                                    Class<? extends Object> beanClass = null;
                                    if (getObject != null) {
                                    	beanClass = getObject.getClass();                                    	
                                    }
        
                                    // VO
                                    String voPackage = getMdIfVO.getMasterModuleVo();
                               //     System.out.println("***** SYS기준 > 해당 모듈 VO - voPackage : " + voPackage);

                                    // 패키지 경로 검증
                                    if (voPackage != null && (!voPackage.startsWith("egovframework.wzwg.") || !voPackage.endsWith("VO"))) {
                                        throw new SecurityException("허용되지 않은 클래스 접근입니다.");
                                    }
                                    Class voClass = Class.forName(voPackage);
                                    
                                    Object voObj = voClass.getDeclaredConstructor().newInstance();

                                    // 모듈 닉네임
                                    String modulePNcnm = getMdIfVO.getModuleNcnm();
                                //    System.out.println("***** SYS기준 > 해당 모듈 닉네임 - modulePNcnm : " + modulePNcnm);
                                    
                                    // 메소드명
                                    String seqNm = "set";
                                    seqNm += modulePNcnm.substring(0, 1).toUpperCase();
                                    seqNm += modulePNcnm.substring(1, modulePNcnm.length());
                                    seqNm += "Seq";
                                    
                                    Method setSeqMethod = voObj.getClass().getMethod(seqNm, String.class);
                                    ReflectionUtils.invokeMethod(setSeqMethod, voObj, cntntsSeq);
                                    
                                    // 메소드명
                                    String methodNm = "select";
                                    methodNm += modulePNcnm.substring(0, 1).toUpperCase();
                                    methodNm += modulePNcnm.substring(1, modulePNcnm.length());
                                    methodNm += "BassInfoDetail";
        
                                //    System.out.println("***** SYS기준 > 해당 모듈 상세정보 조회 - 실행 메소드명 : " + methodNm);
                                    
                                    // 모듈상세정보 조회     ----- 인스턴스 메소드 실행
                                    Method getMethod = beanClass.getMethod(methodNm, voObj.getClass());
                                    Object returnDetailObj = (Object)ReflectionUtils.invokeMethod(getMethod, getObject, voObj);
        
                                    methodNm = "regist";
                                    methodNm += modulePNcnm.substring(0, 1).toUpperCase();
                                    methodNm += modulePNcnm.substring(1, modulePNcnm.length());
                                    methodNm += "BassInfoInit";
                                    
                                    // 모듈SEQ 조회     ----- 인스턴스 메소드 실행
                                    // 모듈 등록     ----- 인스턴스 메소드 실행
                                    // 모듈 등록 후 SEQ 리턴 받음
                                    Method getRegistMethod = beanClass.getMethod(methodNm, voObj.getClass());
                                    Object returnSeqObj = (Object)ReflectionUtils.invokeMethod(getRegistMethod, getObject, returnDetailObj);
                                    String returnSeq = "";
                                    if (returnSeqObj != null) {
                                    	returnSeq = returnSeqObj.toString();                                    	
                                    }
                                    // 사이트모듈 조회
                                    // siteSeq
                                    // sysmoduleSeq
                                    // sitecntntsSeq
                                    CntntsInfoVO setCntInfoVO = new CntntsInfoVO();
                                    
                                    // 일단 하드코딩
                                    setCntInfoVO.setSiteSeq(paramVO.getSysSiteSeq());
                                    setCntInfoVO.setSysmoduleSeq(sysMdSeq);
                                    setCntInfoVO.setSitecntntsSeq(siteCntntsSeq);
                                    
                                    
        
                                //    System.out.println("***** SYS기준 > 사이트모듈 조회 - 시작 - SITECNTNTSINFO");
                                    CntntsInfoVO getCntInfoVO = cntntsInfoService.selectCntntsInfo(setCntInfoVO); 
                                    if (getCntInfoVO != null) {
                                    	// 사이트정보 셋팅
                                    	getCntInfoVO.setSiteSeq(siteSeq);
                                    	getCntInfoVO.setCntntsSeq(returnSeq);                                    	
                                    }
                              //      System.out.println("\n\n\n\n\nreturnSeqObj.toString() : "+returnSeqObj.toString());
                             //       System.out.println("***** 사이트기준 > 사이트모듈 등록 - 시작 - SITECNTNTSINFO");
                                    // 사이트모듈 등록
                                    getSiteCntntsSeq = cntntsInfoService.registCntntsInfoRetSeq(getCntInfoVO);
                                //   System.out.println("***** 사이트기준 > 사이트모듈 등록 - 끝 - SITECNTNTSINFO");
                                    
                                    // 커스텀 게시판
                                    if (sysMdSeq.equals(Globals.BASE_MODULE_CUSTOM_SEQ) && getMenuVO != null && returnDetailObj != null) {
                                        ((ModuleBbsVO)returnDetailObj).setSysSiteSeq(paramVO.getSysSiteSeq());
                                        ((ModuleBbsVO)returnDetailObj).setSysCntntsSeq(cntntsSeq);
                                        ((ModuleBbsVO)returnDetailObj).setSiteSeq(siteSeq);
                                        ((ModuleBbsVO)returnDetailObj).setBbsSeq(returnSeq);
                                        
                                        ((ModuleBbsVO)returnDetailObj).setOriSiteSeq(getMenuVO.getSiteSeq());
                                        ((ModuleBbsVO)returnDetailObj).setOriBbsSeq(getMenuVO.getCntntsSeq());

                                        // 펀션 복사
                                        bbsCustomBassInfoDAO.registBbsCustomFunctionInfoCopy((ModuleBbsVO)returnDetailObj);
                                        
                                        // 필드 복사
                                        bbsCustomBassInfoDAO.registBbsBassInfoCustomFieldCopy((ModuleBbsVO)returnDetailObj);
                                    }
                                    
                                    // 매핑 권한 등록 - 시작
                                    // 대산 컨텐츠 권한 목록
                                    List<CntntsAuthVO> cntntsAuthList =  cntntsAuthDAO.selectCntntsAuthInfo(siteCntntsSeq);
                                    
                                    if (cntntsAuthList != null) {
                                        
                                        for (int j=0; j<cntntsAuthList.size(); j++) {
                                            CntntsAuthVO getAuthVO = (CntntsAuthVO)cntntsAuthList.get(j);
                                            
                                            // 새로 등록된 사이트컨텐츠SEQ 셋팅
                                            getAuthVO.setSitecntntsSeq(getSiteCntntsSeq);
                                            getAuthVO.setFrstRegisterId(paramVO.getFrstRegisterId());
                                            
                                            // 권한 등록
                                            cntntsAuthDAO.registCntntsAuthInfo(getAuthVO);
                                        }
                                    }
                                    // 매핑 권한 등록 - 끝
                                    
                                    // 데이터 복사 대상인지?
                                    if ("Y".equals(StringUtils.defaultString(getMdIfVO.getDataCopyAt()))) {
                                        
                                        // 사이트모듈 생성 완료되었으니 데이터를 이관한다
    
                                        // 시스템사이트SEQ
                                        Method sysSiteSeqMethod = voObj.getClass().getMethod("setSysSiteSeq", String.class);
                                        ReflectionUtils.invokeMethod(sysSiteSeqMethod, voObj, paramVO.getSysSiteSeq());
    
                                        // 시스템컨텐츠SEQ
                                        Method sysCntntsSeqMethod = voObj.getClass().getMethod("setSysCntntsSeq", String.class);
                                        ReflectionUtils.invokeMethod(sysCntntsSeqMethod, voObj, cntntsSeq);
    
                                        // 등록할 사이트SEQ
                                        Method siteSeqMethod = voObj.getClass().getMethod("setSiteSeq", String.class);
                                        ReflectionUtils.invokeMethod(siteSeqMethod, voObj, siteSeq);
    
                                        // 등록할 컨텐츠SEQ
                                        Method setCntntsSeqMethod = voObj.getClass().getMethod(seqNm, String.class);
                                        ReflectionUtils.invokeMethod(setCntntsSeqMethod, voObj, returnSeq);
                                        
                                        methodNm = "regist";
                                        methodNm += modulePNcnm.substring(0, 1).toUpperCase();
                                        methodNm += modulePNcnm.substring(1, modulePNcnm.length());
                                        methodNm += "DataCopy";
                                        
                                        Method getDataCopyMethod = beanClass.getMethod(methodNm, voObj.getClass());
                                        ReflectionUtils.invokeMethod(getDataCopyMethod, getObject, voObj);
                                    }
                                }
                            } else {
                                // sitecntntsinfo 등록이 필요없는 경우
                                // sysmoduleInfo 정보는 메뉴에 등록됨
                                // 커뮤니티 등록
//                                if (sysMdSeq.equals(Globals.BASE_MODULE_CMNT_SEQ)) {
//                                    
//                                    SiteCmntInfoVO cmntInfoVO = new SiteCmntInfoVO();
//                                    
//                                    // 시스템 관리자의 커뮤니티 목록조회를 위해 슈퍼관리자SEQ를 넣는다
//                                    cmntInfoVO.setSiteSeq(paramVO.getSysSiteSeq());
//                                    
//                                    // 슈퍼관리자 - 커뮤니티 목록
//                                    List<SiteCmntInfoVO> cmntList = siteCmntInfoService.selectSiteCmntInfoListAll(cmntInfoVO);
//                                    
//                                    if (cmntList != null) {
//                                        
//                                        SysMngrUsrInfoVO sysMngrUsrVO = new SysMngrUsrInfoVO();
//                                        
//                                        sysMngrUsrVO.setSiteSeq(siteSeq);
//                                        sysMngrUsrVO.setUsrtySeq(EgovProperties.getProperty("Globals.login.auth.normalAdmin"));
//                                        SysMngrUsrInfoVO getMngrUsrVO = usrInfoService.selectUsrInfoMngr(sysMngrUsrVO);
//                                        
//                                        String siteMngrUsrSeq = (getMngrUsrVO != null)? getMngrUsrVO.getUsrSeq():CmmSessionUtil.getSessionUserSeq();
//                                        
//                                        for (int j=0; j<cmntList.size(); j++) {
//                                            SiteCmntInfoVO getCmntVO = (SiteCmntInfoVO)cmntList.get(j);
//                                            
//                                            getCmntVO.setSiteSeq(siteSeq);
//                                            getCmntVO.setCmntMngrSeq(siteMngrUsrSeq);
//
//                                            int cmntSeq  = siteCmntInfoService.selectSiteCmntSeq(getCmntVO);
//                                            getCmntVO.setCmntSeq(String.valueOf(cmntSeq));
//                                            CmmLoginVO loginVO = (CmmLoginVO) EgovUserDetailsHelper.getAuthenticatedUser();
//                                            getCmntVO.setFrstRegisterId(loginVO.getUserId());
//                                            siteCmntInfoService.registSiteCmntInfo(getCmntVO);
//                                            getCmntVO.setCmntApprovalCode("SC00000339");
//                                            siteCmntInfoService.modifySiteCmntInfoApproval(getCmntVO);
//                                            
//                                            CmntMenuAuthVO cmntMenuAuthVO = new CmntMenuAuthVO();
//                                            
//                                            ModuleBbsVO moduleBbsVO = new ModuleBbsVO();
//                                            moduleBbsVO.setBbsNm("공지사항");
//                                            moduleBbsVO.setBbsDc("공지사항");
//                                            moduleBbsVO.setListScrinCode("L");
//                                            moduleBbsVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
//                                            moduleBbsVO.setCmntUseAt("Y");
//                                            String bbs_seq =bbsUnityBassInfoService.registBbsBassInfoInit(moduleBbsVO);
//                                            CmntMenuVO cmntMenuVO = new CmntMenuVO();
//                                            cmntMenuVO.setMenuSeq(cmntMenuService.selectCmntMenuSeq());
//                                            cmntMenuAuthVO.setMenuSeq(cmntMenuVO.getMenuSeq());
//                                            cmntMenuVO.setBbsSeq(bbs_seq);
//                                            cmntMenuVO.setMenuOrdr("1");
//                                            cmntMenuVO.setFrstRegisterId(CmmSessionUtil.getSessionUserId());
//                                            cmntMenuVO.setSiteSeq(siteSeq);
//                                            cmntMenuVO.setCmntSeq(String.valueOf(cmntSeq));
//                                            cmntMenuVO.setMenuNm("공지사항");
//                                            cmntMenuAuthVO.setSiteSeq(siteSeq);
//                                            cmntMenuAuthVO.setCmntSeq(String.valueOf(cmntSeq));
//                                            cmntMenuService.registCmntMenu(cmntMenuVO);
//                                            cmntMenuAuthVO.setApprvlCode("SC00000339");
//                                            cmntMenuAuthVO.setAuthSe("C");
//                                            cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO);
//                                            cmntMenuAuthVO.setApprvlCode("SC00000339");
//                                            cmntMenuAuthVO.setAuthSe("R");
//                                            cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO);
//                                            cmntMenuAuthVO.setApprvlCode("SC00000340");
//                                            cmntMenuAuthVO.setAuthSe("C");
//                                            cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO);
//                                            cmntMenuAuthVO.setApprvlCode("SC00000340");
//                                            cmntMenuAuthVO.setAuthSe("R");
//                                            cmntMenuAuthService.registCmntMenuAuth(cmntMenuAuthVO);
//                                        }
//                                    }
//                                    
//                                }
                            }
                        }
                        
                        // 사이트SEQ 셋팅
                        getMenuVO.setSiteSeq(siteSeq);
    
                        //System.out.println("***** 사이트기준 > 메뉴 생성 - 시작 - SITEMENUINFO");
                        
                        // 메뉴SEQ
                        String menuSeq = siteMenuDAO.seletSiteMenuSeq();
                        
                        // 메뉴SEQ 이력 - 기존SEQ 기준으로 새로운 메뉴SEQ 넣는다
                        menuSeqMap.put(getMenuVO.getMenuSeq(), menuSeq);
                        
                        // 상위메뉴SEQ
                        String upperMenuSeq = StringUtils.defaultString(getMenuVO.getUpperMenuSeq());
                        
                        // 부모메뉴SEQ 셋팅
                        if (!"".equals(upperMenuSeq)) {
                            String getUpperMenuSeq = StringUtils.defaultString(menuSeqMap.get(upperMenuSeq));
                            
                            getMenuVO.setUpperMenuSeq(getUpperMenuSeq);
                        }
                        
                        getMenuVO.setMenuSeq(menuSeq);
                        getMenuVO.setSitecntntsSeq(getSiteCntntsSeq);
                        
                        // 메뉴생성
                        siteMenuDAO.registSiteMenu(getMenuVO);
                        //System.out.println("***** 사이트기준 > 메뉴 생성 - 끝 - SITEMENUINFO");
                    }
                }
            }
            
            result = 1;
        } catch(NullPointerException e){
	    	log.debug("NullPointerException: " + "오류");	    	
	   	}catch(NumberFormatException e){
	   		log.debug("NumberFormatException: " + "오류");	   		
	   	}catch(IllegalFormatException e){
	   		log.debug("IllegalFormatException: " + "오류");	   		
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		log.debug("ArrayIndexOutOfBoundsException: " + "오류");	   		
	   	}catch(IOException e){
	   		log.debug("IOException: " + "오류");	   		
	   	} 
        
		return result;
    }

    /**
     * ㅁ 시스템 - 사이트메뉴설정여부 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifyMenuEstbsAt(MenuEstbsVO paramVO) throws Exception {

        // 전체 메뉴설정여부 N 초기화
        menuEstbsDAO.modifyMenuEstbsAtInitl(paramVO);
        
        // 메뉴설정여부 수정
        return menuEstbsDAO.modifyMenuEstbsAt(paramVO);
    }
    
}
