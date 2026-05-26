package egovframework.wzwg.sysMngr.siteMngr.menuEstbs.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.cmmn.exception.EgovBizException;
import org.springframework.stereotype.Service;

import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.impl.CntntsInfoDAO;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuVO;
import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.impl.SysModuleInfoDAO;
import egovframework.wzwg.sysMngr.siteMngr.menuEstbs.service.MenuEstbsInfoService;


/**
 * ㅁ 시스템 - 사이트관리
 * ㅁ DC   
 * - 시스템관리자가 사이트를 관리
 * - 생선된 사이트는 사이트 관리자 페이지를 이용하여 접속
 * @author HyoJuNiRaNe
 *
 */
@Service("MenuEstbsInfoService")
public class MenuEstbsInfoServiceImpl extends EgovAbstractServiceImpl implements MenuEstbsInfoService {

    @Resource(name="MenuEstbsInfoDAO")
    private MenuEstbsInfoDAO siteMenuDAO;

    // 시스템모듈정보
    @Resource(name="SysModuleInfoDAO")
    private SysModuleInfoDAO moduleInfoDAO;

    // 컨텐츠정보
    @Resource(name="CntntsInfoDAO")
    private CntntsInfoDAO cntntsInfoDAO;

    /**
     * 사이트 메뉴 정보 조회
     * @throws Exception 
     */
    public Map<String, Object> registSiteMenuMngrInfo(SiteMenuVO siteMenuVO) throws Exception {
        
        Map<String, Object> retMap = new HashMap<String, Object>();
        
        //// 모듈 정보
      // List<SysModuleInfoVO> moduleList = moduleInfoDAO.selectSysModuleInfoAllList();
        
        // 컨텐츠 정보
        List<CntntsInfoVO> cntntsList = cntntsInfoDAO.selectMenuCntntsInfoAllList(siteMenuVO.getSiteSeq());
        
        // 사이트메뉴 정보
        List<SiteMenuVO> menuList = selectSiteFirstMenuList(siteMenuVO);

       // retMap.put("MODULE_LIST", moduleList);
        retMap.put("CNTNTS_LIST", cntntsList);
        retMap.put("MENU_LIST", menuList);
        
        return retMap;
    }
    
    /**
     * 사이트 메뉴 목록 조회
     * @throws Exception 
     */
    public List<SiteMenuVO> selectSiteFirstMenuList(SiteMenuVO siteMenuVO) throws Exception {
        return siteMenuDAO.selectSiteFirstMenuList(siteMenuVO);
    }
    
    public void registSiteMenu(SiteMenuVO siteMenuVO) {

//      List<Object> paramList;
        String nowMenuSeq = siteMenuDAO.seletSiteMenuSeq();
        siteMenuVO.setMenuSeq(nowMenuSeq);
            siteMenuDAO.registSiteMenu(siteMenuVO); 
            // json -> vo 반환 
//          paramList = CmmJsonUtil.getRequestParamToJsonClassList(request, SiteMenuVO.class);
            // key 값으로 여러개의 json parameter를 가져올때
            // InputStream 에서 읽은 전체 json data 취득
    }
    
    public void modifySiteMenuPlusOrdr(SiteMenuVO paramVO) {
        siteMenuDAO.modifySiteMenuPlusOrdr(paramVO);
    }
    
    public SiteMenuVO selectSiteMenu(SiteMenuVO paramVO) {
        return siteMenuDAO.selectSiteMenu(paramVO);
    }
    
    public Integer selectMaxMenuOrdr(SiteMenuVO paramVO) {
        return siteMenuDAO.selectMaxMenuOrdr(paramVO);
    }
    
    public List<SiteMenuVO> selectSiteMenuCntntList(SiteMenuVO siteMenuVO) throws Exception {
        return siteMenuDAO.selectSiteMenuCntntList(siteMenuVO);
    }
    
    public int selectSubMenuCnt(SiteMenuVO paramVO){
          return siteMenuDAO.selectSubMenuCnt(paramVO);
    }
    
    public void modifySiteMenu(SiteMenuVO siteMenuVO){
        siteMenuDAO.modifySiteMenu(siteMenuVO);
    }
    
    /**
     * 사이트 메뉴 삭제
     */
    public void deleteSiteMenu(SiteMenuVO siteMenuVO) {
          siteMenuDAO.deleteSiteMenuMngr(siteMenuVO);
    }

    /**
     * 사이트 메뉴 정보 조회
     * @throws Exception 
     */
    public Map<String, Object> selectSiteMenuMngrList(SiteMenuVO siteMenuVO) throws Exception {
        
        Map<String, Object> retMap = new HashMap<String, Object>();
        
        //// 모듈 정보
       // List<SysModuleInfoVO> moduleList = moduleInfoDAO.selectSysModuleInfoAllList();
        
        // 컨텐츠 정보
       // List<CntntsInfoVO> cntntsList = cntntsInfoDAO.selectMenuCntntsInfoAllList(siteMenuVO.getSiteSeq());
        
        // 사이트메뉴 정보
        List<SiteMenuVO> menuList = selectSiteMenuList(siteMenuVO);

       // retMap.put("MODULE_LIST", moduleList);
        //retMap.put("CNTNTS_LIST", cntntsList);
        retMap.put("MENU_LIST", menuList);
        
        return retMap;
    }
    
    
    /**
     * 사이트 메뉴 목록 조회
     * @throws Exception 
     */
    public List<SiteMenuVO> selectSiteMenuList(SiteMenuVO siteMenuVO) throws Exception {
        return siteMenuDAO.selectSiteMenuList(siteMenuVO);
    }
    
    public void modifySiteMenuMngrOrdr(SiteMenuVO paramVO) {
        siteMenuDAO.modifySiteMenuMngrOrdr(paramVO);
    }
    
    // 하위메뉴포함 삭제
    public int deleteSiteMenuLow(SiteMenuVO siteMenuVO) throws Exception {
        
        int result = 0;
        
        // 메뉴 리스트
        List<SiteMenuVO> menuLowList = siteMenuDAO.selectSiteMenuLow(siteMenuVO);
        
        if (menuLowList != null) {
            
            for (int i=0; i<menuLowList.size(); i++) {
                
                SiteMenuVO getVO = (SiteMenuVO)menuLowList.get(i);
                
                getVO.setUserId(siteMenuVO.getUserId());
                
                // 삭제
                result = siteMenuDAO.deleteSiteMenuMngr(getVO);
                
                if (result < 1) {
                    throw new EgovBizException();
                }
            }
        }  
        
        return result;
    }
}
