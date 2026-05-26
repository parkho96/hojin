package egovframework.wzwg.site.mngr.menu.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.egovframe.rte.fdl.cmmn.exception.EgovBizException;
import org.springframework.stereotype.Service;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.CntntsAuthVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsAuth.service.impl.CntntsAuthDAO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;
import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.impl.CntntsInfoDAO;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuService;
import egovframework.wzwg.site.mngr.menu.service.SiteMenuVO;
import egovframework.wzwg.sysMngr.moduleMngr.sysModuleInfo.service.impl.SysModuleInfoDAO;
import net.sf.json.JSONArray;
import net.sf.json.JSONSerializer;

@Service("SiteMenuService")
public class SiteMenuServiceImpl extends EgovAbstractServiceImpl implements SiteMenuService {
    
    @Resource(name="SiteMenuDAO")
    private SiteMenuDAO siteMenuDAO;

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

    
    public void modifySiteMenu(SiteMenuVO siteMenuVO){
        siteMenuDAO.modifySiteMenu(siteMenuVO);
    }
    
    public String seletSiteMenuSeq() {
        return siteMenuDAO.seletSiteMenuSeq();
    }
    
    public void registSiteMenu(SiteMenuVO siteMenuVO) {

//        List<Object> paramList;
 //       String nowMenuSeq = siteMenuDAO.seletSiteMenuSeq();
  //      siteMenuVO.setMenuSeq(nowMenuSeq);
            siteMenuDAO.registSiteMenu(siteMenuVO);    
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
    public List<SiteMenuVO> selectSiteMenuPathList(SiteMenuVO paramVO) {
        List<SiteMenuVO> menuList = siteMenuDAO.selectSiteMenuPathList(paramVO);
        return menuList;
    }
    
    public List<SiteMenuVO> selectSiteMenuCntntList(SiteMenuVO siteMenuVO) throws Exception {
        return siteMenuDAO.selectSiteMenuCntntList(siteMenuVO);
    }
    
    
    /**
     * 사이트 메뉴 목록 조회
     * @throws Exception 
     */
    public List<SiteMenuVO> selectSiteMenuList(SiteMenuVO siteMenuVO) throws Exception {
        return siteMenuDAO.selectSiteMenuList(siteMenuVO);
    }
    
    
    /**
     * 사이트 메뉴 목록 조회
     * @throws Exception 
     */
    public List<SiteMenuVO> selectSiteFirstMenuList(SiteMenuVO siteMenuVO) throws Exception {
        return siteMenuDAO.selectSiteFirstMenuList(siteMenuVO);
    }
    
    /**
     * 사이트 서브 메뉴 목록 조회
     * @throws Exception 
     */
    public List<SiteMenuVO> selectSiteSubMenuList(SiteMenuVO siteMenuVO) throws Exception {
        
        // 최상위 메뉴SEQ 구함
        String upperMenuSeq = siteMenuDAO.selectTopMenuSeq(siteMenuVO);
        
        siteMenuVO.setUpperMenuSeq(upperMenuSeq);
        
        return siteMenuDAO.selectSiteSubMenuList(siteMenuVO);
    }
    
    /**
     * 초기 메뉴 저장
     * @throws Exception 
     */
    public void registSiteMenuInit(SiteMenuVO siteMenuVO) throws Exception {
        
        String [] menuArr = ((String)EgovProperties.getProperty("Globals.siteMenuNm")).split(",");
        
        for (int i = 0; i < menuArr.length; i++) {
            siteMenuVO.setMenuNm(menuArr[i]);
            siteMenuVO.setMenuDc(menuArr[i]);
            siteMenuVO.setMenuOrdr(i+"");
        }
        siteMenuVO.setMenuSeq(siteMenuDAO.seletSiteMenuSeq());
        siteMenuVO.setSysmoduleSeq(EgovProperties.getProperty("Globals.initSysmoduleSeq"));
        siteMenuDAO.registSiteMenu(siteMenuVO);    
        
    }

    @Override
    public String selectSiteTopLogo(SiteMenuVO siteMenuVO)
            throws Exception {
        // TODO Auto-generated method stub
        return siteMenuDAO.selectTopLogo(siteMenuVO);
    }
    
    public String selectSiteFooterLogo(SiteMenuVO siteMenuVO)
            throws Exception {
        // TODO Auto-generated method stub
        return siteMenuDAO.selectFooterLogo(siteMenuVO);
    }
    
    public SiteMenuVO selectSiteMenu(SiteMenuVO paramVO) {
            return siteMenuDAO.selectSiteMenu(paramVO);
    }
      
    public Integer selectMaxMenuOrdr(SiteMenuVO paramVO) {
          return siteMenuDAO.selectMaxMenuOrdr(paramVO);
    }
      
    public void modifySiteMenuPlusOrdr(SiteMenuVO paramVO) {
        siteMenuDAO.modifySiteMenuPlusOrdr(paramVO);
    }
    public void modifySiteMenuMngrOrdr(SiteMenuVO paramVO) {
        siteMenuDAO.modifySiteMenuMngrOrdr(paramVO);
    }
    
    public int selectSubMenuCnt(SiteMenuVO paramVO){
          return siteMenuDAO.selectSubMenuCnt(paramVO);
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
    public void deleteSiteMenu(SiteMenuVO siteMenuVO) {
          siteMenuDAO.deleteSiteMenuMngr(siteMenuVO);
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
    
public int registSiteMenuByUsrGroup(CntntsAuthVO paramVO) {
        
        int result = 0;
        
        List<Map<String, Object>> resultMap = new ArrayList<Map<String, Object>>();
        
        if(!"".equals(StringUtils.defaultString(paramVO.getAuthorSeStrArr()))) {
            
            if(paramVO.getAuthorSeStrArr() != null){
                paramVO.setAuthorSeStrArr(paramVO.getAuthorSeStrArr().replaceAll("&amp;", "&"));
                paramVO.setAuthorSeStrArr(paramVO.getAuthorSeStrArr().replaceAll("&quot;", "'"));
                paramVO.setAuthorSeStrArr(paramVO.getAuthorSeStrArr().replaceAll("&apos;", "'"));
            }
            
            resultMap = JSONArray.fromObject(JSONSerializer.toJSON(paramVO.getAuthorSeStrArr()));

            for(Map<String, Object> map : resultMap){
                paramVO.setSitecntntsSeq(StringUtils.defaultString((String)map.get("sitecntntsSeq")).toString());
                paramVO.setAuthorSe(StringUtils.defaultString((String)map.get("authorSe"), "N").toString());
                paramVO.setMenuSeq(StringUtils.defaultString((String)map.get("menuSeq")).toString());

              //  if (!"".equals(paramVO.getSitecntntsSeq())) {
                int dupChk = cntntsAuthDAO.selectCntntsAuthChk(paramVO);
                if(dupChk >0) {
                	result = 	cntntsAuthDAO.updateCntntsAuth(paramVO);	
                }else {
                	result =   cntntsAuthDAO.registCntntsAuthInfo(paramVO);
                }
                  //  result = cntntsAuthDAO.registCntntsAuth(paramVO);
//                } else {
//                    SiteMenuVO setParamVO = new SiteMenuVO();
//                    setParamVO.setSiteSeq(paramVO.getSiteSeq());
//                    setParamVO.setMenuSeq(StringUtils.defaultString((String)map.get("menuSeq")).toString());
//                    
//                    if (!"".equals(setParamVO.getMenuSeq())) {
                        // menuSeq - menuTyCode = 솔루션인지 확인
 //                       SiteMenuVO getMenuVO = siteMenuDAO.selectSiteMenu(setParamVO);
                        
                        // 솔루션일땐 컨텐츠 sitecntntsinfo 등록 안되있으면 등록해준다
//                        if (getMenuVO != null && "SC00000033".equals(getMenuVO.getMenuTyCode())) {
//                            
//                            CntntsInfoVO ciVO = new CntntsInfoVO();
//                            ciVO.setSysmoduleSeq(getMenuVO.getSysmoduleSeq());
//                            ciVO.setCntntsNm(getMenuVO.getMenuNm());
//                            ciVO.setCntntsSeq(getMenuVO.getMenuSeq());
//                            ciVO.setSiteSeq(paramVO.getSiteSeq());
//                            ciVO.setCntntsDc(getMenuVO.getModuleDc());
//                            ciVO.setFrstRegisterId(paramVO.getFrstRegisterId());
//                            ciVO.setCntntsNm(getMenuVO.getMenuDc());
//                            
//                            String sitecntntsSeq = cntntsInfoDAO.selectCntntsInfoSeq();
//                            ciVO.setSitecntntsSeq(sitecntntsSeq);
//                            cntntsInfoDAO.registCntntsInfo(ciVO);
//
//                            paramVO.setSitecntntsSeq(sitecntntsSeq);
//                            
//                            result = cntntsAuthDAO.registCntntsAuth(paramVO);
//                        }
                    }
                }
 //           }
 //       }

        return result;
    }

}
