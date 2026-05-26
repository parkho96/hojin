package egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.IllegalFormatException;
import java.util.List;

import jakarta.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteEssntlStplatService;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteEssntlStplatVO;


/**
 * ㅁ 시스템 - 사이트필수약관설정
 * ㅁ DC   
 * - 가입/개인정보처리방침/사이트사용약관 등 필수 적으로 동의를 받아야되는 약관을 설정한다
 * @author HyoJuNiRaNe
 *
 */
@Service("SiteEssntlStplatService")
public class SiteEssntlStplatServiceImpl extends EgovAbstractServiceImpl implements SiteEssntlStplatService {

    @Resource(name="SiteEssntlStplatDAO")
    private SiteEssntlStplatDAO siteEssntlStplatDAO;

    @Resource(name="SiteStplatLogDAO")
    private SiteStplatLogDAO siteStplatLogDAO;
    
    protected static final Log LOG = LogFactory.getLog(SiteEssntlStplatServiceImpl.class);
    
    /**
     * ㅁ 사이트 - 사이트필수약관 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<SiteEssntlStplatVO> selectSiteEssntlStplatInfoList(SiteEssntlStplatVO paramVO) throws Exception {
        return siteEssntlStplatDAO.selectSiteEssntlStplatInfoList(paramVO);
    }

    /**
     * ㅁ 시스템 - 사이트약관목록 코드화 조회 
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<SiteEssntlStplatVO> selectSiteEssntlStplatCode(SiteEssntlStplatVO paramVO) throws Exception {
        return siteEssntlStplatDAO.selectSiteEssntlStplatCode(paramVO);
    }

    
    public int applyEssntlStplat(SiteEssntlStplatVO paramVO)  throws Exception {
    	int   returnVal =0;
        paramVO.setStplatTyCode("SC00000020"); 
        
        int estbsChk = siteStplatLogDAO.selectSiteEssntlStplatCheck(paramVO);
        
        if (estbsChk > 0) {
            returnVal = 1;
        } else {
            int cnt = siteEssntlStplatDAO.selectSiteEssntlStplatInfoCheck(paramVO);
            
            if (cnt > 0) {
                returnVal = siteEssntlStplatDAO.modifyEssntlStplat(paramVO); 

                String stplogSeq = siteStplatLogDAO.selectSiteStplatLogSeq(paramVO);

                paramVO.setStplatlogSeq(stplogSeq);
                
                siteStplatLogDAO.registStplatLog(paramVO);
                siteStplatLogDAO.registStplatdetailLog(paramVO);
            } else {
                returnVal = siteEssntlStplatDAO.registEssntlStplat(paramVO);
            }
        }
//    }
        return   returnVal; 
    }
    
    /**
     * ㅁ 시스템 - 사이트 필수약관 저장
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registEssntlStplat(SiteEssntlStplatVO paramVO) throws Exception {
        
        int returnVal = 0;
        
        try {
            
            String[] stplatTyCodeArr = paramVO.getStplatTyCodeArr();
            
            if (stplatTyCodeArr != null && stplatTyCodeArr.length > 0) {
                
                for (int i=0; i<stplatTyCodeArr.length; i++) {
                    String[] getArr = StringUtils.defaultString(stplatTyCodeArr[i]).split(":");
                    
//                    if (getArr.length == 2) {

                        paramVO.setStplatTyCode(getArr[0]);
                        paramVO.setStplatSeq(getArr[1]);
                        
                        int estbsChk = siteStplatLogDAO.selectSiteEssntlStplatCheck(paramVO);
                        
                        if (estbsChk > 0) {
                            returnVal = 1;
                        } else {
                            int cnt = siteEssntlStplatDAO.selectSiteEssntlStplatInfoCheck(paramVO);
                            
                            if (cnt > 0) {
                                returnVal = siteEssntlStplatDAO.modifyEssntlStplat(paramVO); 

                                String stplogSeq = siteStplatLogDAO.selectSiteStplatLogSeq(paramVO);

                                paramVO.setStplatlogSeq(stplogSeq);
                                
                                siteStplatLogDAO.registStplatLog(paramVO);
                                siteStplatLogDAO.registStplatdetailLog(paramVO);
                            } else {
                                returnVal = siteEssntlStplatDAO.registEssntlStplat(paramVO);
                            }
                        }
//                    }
                }
            }
        }catch(NullPointerException e){
        	LOG.error("NullPointerException",e);
	   	}catch(NumberFormatException e){
	   		LOG.error("NumberFormatException",e);
	   	}catch(IllegalFormatException e){
	   		LOG.error("IllegalFormatException",e);
	   	}catch(ArrayIndexOutOfBoundsException e){
	   		LOG.error("ArrayIndexOutOfBoundsException",e);
	   	}catch(IOException e){
	   		LOG.error("IOException",e);
	   	}catch(SQLException e){
	   		LOG.error("SQLException",e);
	   	}  
        
        return returnVal;
    }
    
    public  SiteEssntlStplatVO  selectSiteEssntlStplatSign(SiteEssntlStplatVO paramVO) throws Exception {
        return siteEssntlStplatDAO.selectSiteEssntlStplatSign(paramVO);
    }

}
