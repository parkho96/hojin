package egovframework.wzwg.site.mngr.menu.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.cmmn.exception.EgovBizException;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.impl.CntntsAuthDAO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.impl.CntntsInfoDAO;
import egovframework.wzwg.site.mngr.menu.service.SiteMngrMenuService;
import egovframework.wzwg.site.mngr.menu.service.SiteMngrMenuVO;
import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.impl.SysModuleInfoDAO;

@Service("siteMngrMenuService")
public class SiteMngrMenuServiceImpl extends EgovAbstractServiceImpl implements SiteMngrMenuService {
    
    @Resource(name="siteMngrMenuDAO")
    private SiteMngrMenuDAO siteMngrMenuDAO;

    // 시스템모듈정보
    @Resource(name="SysModuleInfoDAO")
    private SysModuleInfoDAO moduleInfoDAO;

    // 컨텐츠정보
    @Resource(name="CntntsInfoDAO")
    private CntntsInfoDAO cntntsInfoDAO;
    
    @Resource(name="CntntsAuthDAO")
    private CntntsAuthDAO cntntsAuthDAO;

    /**
     * 사이트 메뉴 정보 조회
     * @throws Exception 
     */
    public Map<String, Object> selectSiteMenuMngrList(SiteMngrMenuVO siteMngrMenuVO) throws Exception {
        
        Map<String, Object> retMap = new HashMap<String, Object>();
        
        //// 모듈 정보
       // List<SysModuleInfoVO> moduleList = moduleInfoDAO.selectSysModuleInfoAllList();
        
        // 컨텐츠 정보
       // List<CntntsInfoVO> cntntsList = cntntsInfoDAO.selectMenuCntntsInfoAllList(siteMenuVO.getSiteSeq());
        
        // 사이트메뉴 정보
        List<SiteMngrMenuVO> menuList = selectSiteMenuList(siteMngrMenuVO);

       // retMap.put("MODULE_LIST", moduleList);
        //retMap.put("CNTNTS_LIST", cntntsList);
        retMap.put("MENU_LIST", menuList);
        
        return retMap;
    }
    
 public Map<String, Object> selectSiteMenuMngrLeftList(SiteMngrMenuVO siteMngrMenuVO) throws Exception {
        
        Map<String, Object> retMap = new HashMap<String, Object>();
        
        //// 모듈 정보
       // List<SysModuleInfoVO> moduleList = moduleInfoDAO.selectSysModuleInfoAllList();
        
        // 컨텐츠 정보
       // List<CntntsInfoVO> cntntsList = cntntsInfoDAO.selectMenuCntntsInfoAllList(siteMenuVO.getSiteSeq());
        
        // 사이트메뉴 정보
        List<SiteMngrMenuVO> menuList = selectSiteMenuLeftList(siteMngrMenuVO);

       // retMap.put("MODULE_LIST", moduleList);
        //retMap.put("CNTNTS_LIST", cntntsList);
        retMap.put("MENU_LIST", menuList);
        
        return retMap;
    }
    
    
    /**
     * 사이트 메뉴 정보 조회
     * @throws Exception 
     */
    public Map<String, Object> registSiteMenuMngrInfo(SiteMngrMenuVO siteMngrMenuVO) throws Exception {
        
        Map<String, Object> retMap = new HashMap<String, Object>();
        
        //// 모듈 정보
      // List<SysModuleInfoVO> moduleList = moduleInfoDAO.selectSysModuleInfoAllList();
        
        // 컨텐츠 정보
        List<CntntsInfoVO> cntntsList = cntntsInfoDAO.selectMenuCntntsInfoAllList(siteMngrMenuVO.getSiteSeq());
        
        // 사이트메뉴 정보
        List<SiteMngrMenuVO> menuList = selectSiteFirstMenuList(siteMngrMenuVO);

       // retMap.put("MODULE_LIST", moduleList);
        retMap.put("CNTNTS_LIST", cntntsList);
        retMap.put("MENU_LIST", menuList);
        
        return retMap;
    }

    
    public void modifySiteMenu(SiteMngrMenuVO siteMngrMenuVO){
    	siteMngrMenuDAO.modifySiteMenu(siteMngrMenuVO);
    }
    
    public String seletSiteMenuSeq() {
        return siteMngrMenuDAO.seletSiteMenuSeq();
    }
    
	public void registSiteMenuAuth(SiteMngrMenuVO paramVO) {
		siteMngrMenuDAO.deleteSiteMenuAuth(paramVO);
		
		if(paramVO != null && paramVO.getMngrMenuSeqArry() != null) {
			for(int i =0;i < paramVO.getMngrMenuSeqArry().length;i++) {
				SiteMngrMenuVO siteMngrMenuVO = new SiteMngrMenuVO();
				siteMngrMenuVO.setMngrMenuSeq(paramVO.getMngrMenuSeqArry()[i]);
				siteMngrMenuVO.setUsrSeq(paramVO.getUsrSeq());
				siteMngrMenuVO.setSiteSeq(paramVO.getSiteSeq());
				siteMngrMenuVO.setMngrAuthAt("Y");
				siteMngrMenuVO.setUserId(paramVO.getUserId()); 
				siteMngrMenuDAO.registSiteMenuAuth(siteMngrMenuVO);  
			}
		}
		
	}
    
    public void registSiteMenu(SiteMngrMenuVO siteMngrMenuVO) {

//        List<Object> paramList;
 //       String nowMenuSeq = siteMenuDAO.seletSiteMenuSeq();
  //      siteMenuVO.setMenuSeq(nowMenuSeq);
    	siteMngrMenuDAO.registSiteMenu(siteMngrMenuVO);    
            // json -> vo 반환 
//            paramList = CmmJsonUtil.getRequestParamToJsonClassList(request, SiteMenuVO.class);
            // key 값으로 여러개의 json parameter를 가져올때
            // InputStream 에서 읽은 전체 json data 취득
            /**
            JSONObject jsonObj = CmmJsonUtil.getRequestParamToJson(request);
            
            // json -> vo 반환 
            List<Object> formList = CmmJsonUtil.getJsonToKeyValueClass(jsonObj, SiteMenuVO.class, "I");
            List<Object> delList = CmmJsonUtil.getJsonToKeyValueClass(jsonObj, SiteMenuVO.class, "D");
            List<Object> ordrList = CmmJsonUtil.getJsonToKeyValueClass(jsonObj, SiteMenuVO.class, "O");
        
            HashMap<String, String> upperMenuMap = new HashMap<String, String>();
            
            if (ordrList != null) {

                // 메뉴 등록
                for (int i=0; i<ordrList.size(); i++) {
                    SiteMenuVO getVO = (SiteMenuVO)ordrList.get(i);
                    
                    upperMenuMap.put(getVO.getMenuOrdr(), getVO.getMenuLv()+":"+StringUtils.defaultString(getVO.getUpperMenuSeq()).replace("undefined", ""));
                }
                
            }
            
            if (formList != null) {
                
                String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
                String nowMenuSeq = "";
                String preMenuSeq = "";
                
                String preLv = ""; 
                
                HashMap<String, String> preMenuMap = new HashMap<String, String>();
                
                // 메뉴 등록
                for (int i=0; i<formList.size(); i++) {
                    SiteMenuVO getVO = (SiteMenuVO)formList.get(i);
                    
                    getVO.setSiteSeq(siteSeq);
                    // menuSeq 있으면 수정
                    if (!"".equals(StringUtils.defaultString(getVO.getMenuSeq()))) {
                        siteMenuDAO.modifySiteMenu(getVO);
                    } else {
                        
                        String getMapVal = StringUtils.defaultString((String)upperMenuMap.get(getVO.getMenuOrdr()));
                        
                        String getLv = "";
                        String getUs = "";
                        
                        if (getMapVal != null) {
                            
                            String[] getMapArr = getMapVal.split(":");
                            
                            if (getMapArr.length > 1) {
                                getLv = getMapArr[0];
                                getUs = getMapArr[1];
                            }
                        }
                        
                        int intLv = ("".equals(getLv))? 1:Integer.parseInt(getLv);
                        int intPreLv = ("".equals(preLv))? 1:Integer.parseInt(preLv);
//                              
                        if (intLv > intPreLv) {
                            preMenuMap.remove(getLv);
                            preMenuMap.put(getLv, nowMenuSeq);
                        } else {
                        }
                        
                        String getMenuSeq = StringUtils.defaultString((String)preMenuMap.get(getLv));
                        
                        if (!"".equals(getMenuSeq)) {
                            preMenuSeq = getMenuSeq;
                        } else {
                        }
                        
                        nowMenuSeq = siteMenuDAO.seletSiteMenuSeq();
                        getVO.setMenuSeq(nowMenuSeq);
                        
                        if (!"".equals(getLv) && !"1".equals(getLv)) {
                            if (!"".equals(getUs)) {
                                getVO.setUpperMenuSeq(getUs);
                            } else {
                                getVO.setUpperMenuSeq(preMenuSeq);
                            }
                            getVO.setMenuLv(getLv);
                        } else {
                            getVO.setMenuLv("1");
                            preMenuSeq = nowMenuSeq;
                        }
                        
                        preLv = getLv;
                        
                        siteMenuDAO.registSiteMenu(getVO);    
                    }
                }
            }
        
            // 삭제
            if (delList != null) {
                
                String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
                
                // 메뉴 등록
                for (int i=0; i<delList.size(); i++) {
                    SiteMenuVO getVO = (SiteMenuVO)delList.get(i);
                    
                    getVO.setSiteSeq(siteSeq);
                    
                    siteMenuDAO.deleteSiteMenuMngr(getVO);
                }
            }
        
            // 정렬
            if (ordrList != null) {
                
                String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
                
                // 메뉴 등록
                for (int i=0; i<ordrList.size(); i++) {
                    SiteMenuVO getVO = (SiteMenuVO)ordrList.get(i);
                    
                    if (!"".equals(StringUtils.defaultString(getVO.getMenuSeq()))) {
                        getVO.setSiteSeq(siteSeq);
                        getVO.setUpperMenuSeq(getVO.getUpperMenuSeq().replace("undefined", ""));
                        siteMenuDAO.modifySiteMenuMngrOrdr(getVO);
                    }
                }
            }
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        **/
    }

    /**
     * 사이트 메뉴 경로 목록
     * @return
     */
    public HashMap<String, String> selectSiteMenuPathList(SiteMngrMenuVO paramVO) {

        HashMap<String, String> returnMap = new HashMap<String, String>();
        
        List<SiteMngrMenuVO> menuList = siteMngrMenuDAO.selectSiteMenuPathList(paramVO);

        if (!menuList.isEmpty()) {
            
            for (int i=0; i<menuList.size(); i++) {
            	SiteMngrMenuVO getVO = menuList.get(i);
                
                String menuPath = StringUtils.defaultString(returnMap.get(getVO.getSitecntntsSeq()));
                
                menuPath = ("".equals(menuPath))? getVO.getMenuNmPath():menuPath+","+getVO.getMenuNmPath();
                
                returnMap.put(getVO.getSitecntntsSeq(), menuPath);
            }
        }

        return returnMap;
    }
    
    public List<SiteMngrMenuVO> selectSiteMenuCntntList(SiteMngrMenuVO siteMngrMenuVO) throws Exception {
        return siteMngrMenuDAO.selectSiteMenuCntntList(siteMngrMenuVO);
    }
    
    
    /**
     * 사이트 메뉴 목록 조회
     * @throws Exception 
     */
    public List<SiteMngrMenuVO> selectSiteMenuList(SiteMngrMenuVO siteMngrMenuVO) throws Exception {
        return siteMngrMenuDAO.selectSiteMenuList(siteMngrMenuVO);
    }
    
    /**
     * 사이트 메뉴 목록 조회
     * @throws Exception 
     */
    public List<SiteMngrMenuVO> selectSiteMenuLeftList(SiteMngrMenuVO siteMngrMenuVO) throws Exception {
        return siteMngrMenuDAO.selectSiteMenuLeftList(siteMngrMenuVO);
    }
    
    
    
    /**
     * 사이트 메뉴 목록 조회
     * @throws Exception 
     */
    public List<SiteMngrMenuVO> selectSiteFirstMenuList(SiteMngrMenuVO siteMngrMenuVO) throws Exception {
        return siteMngrMenuDAO.selectSiteFirstMenuList(siteMngrMenuVO);
    }
    
    /**
     * 사이트 서브 메뉴 목록 조회
     * @throws Exception 
     */
    public List<SiteMngrMenuVO> selectSiteSubMenuList(SiteMngrMenuVO siteMngrMenuVO) throws Exception {
        
        // 최상위 메뉴SEQ 구함
        String upperMenuSeq = siteMngrMenuDAO.selectTopMenuSeq(siteMngrMenuVO);
        
        siteMngrMenuVO.setUpperMenuSeq(upperMenuSeq);
        
        return siteMngrMenuDAO.selectSiteSubMenuList(siteMngrMenuVO);
    }
    
    /**
     * 초기 메뉴 저장
     * @throws Exception 
     */
    public void registSiteMenuInit(SiteMngrMenuVO siteMngrMenuVO) throws Exception {
        
        String [] menuArr = ((String)EgovProperties.getProperty("Globals.siteMenuNm")).split(",");
        
        for (int i = 0; i < menuArr.length; i++) {
        	siteMngrMenuVO.setMngrMenuNm(menuArr[i]);
        	siteMngrMenuVO.setMenuDc(menuArr[i]);
        	siteMngrMenuVO.setMenuOrdr(i+"");
        }
        siteMngrMenuVO.setMngrMenuSeq(siteMngrMenuDAO.seletSiteMenuSeq());
        siteMngrMenuVO.setSysmoduleSeq(EgovProperties.getProperty("Globals.initSysmoduleSeq"));
        siteMngrMenuDAO.registSiteMenu(siteMngrMenuVO);    
        
    }

    @Override
    public String selectSiteTopLogo(SiteMngrMenuVO siteMngrMenuVO)
            throws Exception {
        // TODO Auto-generated method stub
        return siteMngrMenuDAO.selectTopLogo(siteMngrMenuVO);
    }
    
    public String selectSiteFooterLogo(SiteMngrMenuVO siteMngrMenuVO)
            throws Exception {
        // TODO Auto-generated method stub
        return siteMngrMenuDAO.selectFooterLogo(siteMngrMenuVO);
    }
    
    public SiteMngrMenuVO selectSiteMenu(SiteMngrMenuVO paramVO) {
            return siteMngrMenuDAO.selectSiteMenu(paramVO);
    }
      
    public Integer selectMaxMenuOrdr(SiteMngrMenuVO paramVO) {
          return siteMngrMenuDAO.selectMaxMenuOrdr(paramVO);
    }
      
    public void modifySiteMenuPlusOrdr(SiteMngrMenuVO paramVO) {
    	siteMngrMenuDAO.modifySiteMenuPlusOrdr(paramVO);
    }
    public void modifySiteMenuMngrOrdr(SiteMngrMenuVO paramVO) {
    	siteMngrMenuDAO.modifySiteMenuMngrOrdr(paramVO);
    }
    
    public int selectSubMenuCnt(SiteMngrMenuVO paramVO){
          return siteMngrMenuDAO.selectSubMenuCnt(paramVO);
    }
      

//    /** 사이트 메뉴 정렬 수정 */
//    public void modifySiteMenuMngrOrdr(HttpServletRequest request) {
//
//        List<Object> formList;
//        List<Object> delList;
//        List<Object> ordrList;
//        try {
//            // key 값으로 여러개의 json parameter를 가져올때
//            // InputStream 에서 읽은 전체 json data 취득
//            JSONObject jsonObj = CmmJsonUtil.getRequestParamToJson(request);
//            
//            // json -> vo 반환 
//            delList = CmmJsonUtil.getJsonToKeyValueClass(jsonObj, SiteMenuVO.class, "D");
//            ordrList = CmmJsonUtil.getJsonToKeyValueClass(jsonObj, SiteMenuVO.class, "O");
//        
//            // 삭제
//            if (delList != null) {
//                
//                String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
//                
//                // 메뉴 등록
//                for (int i=0; i<delList.size(); i++) {
//                    SiteMenuVO getVO = (SiteMenuVO)delList.get(i);
//                    
//                    getVO.setSiteSeq(siteSeq);
//                    
//                    siteMenuDAO.deleteSiteMenuMngr(getVO);
//                }
//            }
//        
//            // 정렬
//            if (ordrList != null) {
//                
//                String siteSeq = CmmSessionUtil.getSessionSiteSeq(request);
//                
//                // 메뉴 등록
//                for (int i=0; i<ordrList.size(); i++) {
//                    SiteMenuVO getVO = (SiteMenuVO)ordrList.get(i);
//                    
//                    getVO.setSiteSeq(siteSeq);
//                    
//                    siteMenuDAO.modifySiteMenuMngrOrdr(getVO);
//                }
//            }
//        } catch (Exception e) {
//            // TODO Auto-generated catch block
//            e.printStackTrace();
//        }
//    }

//    /**
//     * 사이트 메뉴 상세조회
//     */
//    public SiteMenuVO selectSiteMenuDetail(SiteMenuVO siteMenuVO) {
//        return siteMenuDAO.selectSiteMenuDetail(siteMenuVO);
//    }
//
//    /**
//     * 사이트 메뉴 수정
//     */
//    public int modifySiteMenu(SiteMenuVO siteMenuVO) {
//        return siteMenuDAO.modifySiteMenu(siteMenuVO);
//    }
//
    /**
     * 사이트 메뉴 삭제
     */
    public void deleteSiteMenu(SiteMngrMenuVO siteMenuVO) {
    	siteMngrMenuDAO.deleteSiteMenuMngr(siteMenuVO);
    }
    
    // 하위메뉴포함 삭제
    public int deleteSiteMenuLow(SiteMngrMenuVO siteMenuVO) throws Exception {
        
        int result = 0;
        
        // 메뉴 리스트
        List<SiteMngrMenuVO> menuLowList = siteMngrMenuDAO.selectSiteMenuLow(siteMenuVO);
        
        if (menuLowList != null) {
            
            for (int i=0; i<menuLowList.size(); i++) {
                
            	SiteMngrMenuVO getVO = (SiteMngrMenuVO)menuLowList.get(i);
                
                getVO.setUserId(siteMenuVO.getUserId());
                
                // 삭제
                result = siteMngrMenuDAO.deleteSiteMenuMngr(getVO);
                
                if (result < 1) {
                    throw new EgovBizException();
                }
            }
        }  
        
        return result;
    } 
    
	public List<SiteMngrMenuVO> selectMngrMenuAuthList(SiteMngrMenuVO paramVO) {
		return siteMngrMenuDAO.selectMngrMenuAuthList(paramVO);
	}
	
	public SiteMngrMenuVO selectSiteMngrMenuNm(SiteMngrMenuVO paramVO) {
		
		SiteMngrMenuVO resultVO = new SiteMngrMenuVO();
		resultVO = siteMngrMenuDAO.selectSiteMngrMenuNm(paramVO);
		
		if(!"".equals(paramVO.getSysmoduleSeq())) {
			paramVO = siteMngrMenuDAO.selectSiteMngrMenuCntntsNm(paramVO);
			if(paramVO != null) {
				resultVO.setMngrMenuNm(paramVO.getMngrMenuNm());
			}
		}
		
		return resultVO;
	}
	
	public SiteMngrMenuVO selectSiteMngrMenuUrlByAuthSeq(SiteMngrMenuVO paramVO) {
		
		SiteMngrMenuVO resultVO = new SiteMngrMenuVO();
		resultVO = siteMngrMenuDAO.selectSiteMngrMenuUrlByAuthSeq(paramVO);
	 
		return resultVO;
	}
	
	public SiteMngrMenuVO selectSiteMngrUsrSeqByAuthSeq(SiteMngrMenuVO paramVO) {
		
		SiteMngrMenuVO resultVO = new SiteMngrMenuVO();
		resultVO = siteMngrMenuDAO.selectSiteMngrUsrSeqByAuthSeq(paramVO);
	 
		return resultVO;
	}
}
