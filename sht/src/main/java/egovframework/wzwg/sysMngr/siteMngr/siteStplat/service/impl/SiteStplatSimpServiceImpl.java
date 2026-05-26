package egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.impl;

import java.util.IllegalFormatException;
import java.util.List;

import jakarta.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatInfoVO;
import egovframework.wzwg.sysMngr.siteMngr.siteStplat.service.SiteStplatSimpService;


@Service("SiteStplatSimpService")
public class SiteStplatSimpServiceImpl extends EgovAbstractServiceImpl implements SiteStplatSimpService {

    @Resource(name="SiteStplatSimpDAO")
    private SiteStplatSimpDAO siteStplatSimpDAO;
    
    protected static final Log LOG = LogFactory.getLog(SiteStplatSimpServiceImpl.class);

    /************************* 2019.02.28 start **************************/
    
    /** 세부약관 리스트 조회 */
    public List<SiteStplatInfoVO> selectSiteStplatSimpList(SiteStplatInfoVO paramVO) throws Exception {
    	return siteStplatSimpDAO.selectSiteStplatSimpList(paramVO);
    }
    
    /** 세부약관 등록 */
    public Integer registSiteStplatSimp(SiteStplatInfoVO paramVO) throws Exception {
    	
    	/** 마지막으로 등록되어있던 세부약관 종료일 수정 */
    	String stplatSimpSeq = siteStplatSimpDAO.selectBeforeStplatSimpSeqChk(paramVO);
    	
    	if(!("").equals(StringUtils.defaultString(stplatSimpSeq))){
    		
    		SiteStplatInfoVO infoVO = new SiteStplatInfoVO();
    		infoVO.setStplatsimpSeq(stplatSimpSeq);
    		infoVO.setLastUpdusrId(paramVO.getLastUpdusrId());
    		
    		infoVO.setEndDe(paramVO.getOpertnDe());
    		
    		siteStplatSimpDAO.updateStplatSimpEndDe(infoVO);
    	}
    	/**************************************************/
    	
        return siteStplatSimpDAO.registSiteStplatSimp(paramVO);
    }

    /** 세부약관 상세조회 */
    public SiteStplatInfoVO selectSiteStplatSimpDetail(SiteStplatInfoVO paramVO) throws Exception {
    	return siteStplatSimpDAO.selectSiteStplatSimpDetail(paramVO);
    }
    
    /** 세부약관 수정 */
    public Integer modifySiteStplatSimp(SiteStplatInfoVO paramVO) throws Exception {
    	return siteStplatSimpDAO.modifySiteStplatSimp(paramVO);
    }
    
    /** 세부약관 삭제 */
    public Integer deleteSiteStplatSimp(SiteStplatInfoVO paramVO) throws Exception {
        
        int returnVal = 0;
        
        // 상세약관SEQ배열
        String[] stplatsimpSeqArr = paramVO.getStplatsimpSeqArr();
        
        try {
            if (stplatsimpSeqArr != null) {
                for (int i=0; i<stplatsimpSeqArr.length; i++) {
                    paramVO.setStplatsimpSeq(stplatsimpSeqArr[i]);
                    
                    returnVal = siteStplatSimpDAO.deleteSiteStplatSimp(paramVO);
                    
                    if (returnVal < 1) {
                        return returnVal;
                    }
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
       	} 
        
        return returnVal;
    }
    
    
	/**  전체사이트 적용시 사이트마다 세부약관 존재여부 확인 */
	public String selectSysSiteStplatSimpChk(SiteStplatInfoVO paramVO) throws Exception {
		return siteStplatSimpDAO.selectSysSiteStplatSimpChk(paramVO);
	}
    
    /************************* 2019.02.28 end **************************/

    public Integer selectSiteStplatSimpListCnt(SiteStplatInfoVO paramVO) throws Exception {
    	return siteStplatSimpDAO.selectSiteStplatSimpListCnt(paramVO);
    }
    public SiteStplatInfoVO selectSysSiteStplatSimpDetail() throws Exception {
    	return siteStplatSimpDAO.selectSysSiteStplatSimpDetail();
    }
    
    public Integer deleteSysSiteStplatSimp(SiteStplatInfoVO paramVO) throws Exception {
        
        int returnVal = 0;
         
                    returnVal = siteStplatSimpDAO.deleteSiteStplatSimp(paramVO);
                     
        
        return returnVal;
    }
    
    public Integer defaultAllNonSysSiteStplatSimp(SiteStplatInfoVO paramVO) throws Exception {
        return siteStplatSimpDAO.defaultAllNonSysSiteStplatSimp(paramVO);
    }
    
    public Integer defaultSysSiteStplatSimp(SiteStplatInfoVO paramVO) throws Exception {
        return siteStplatSimpDAO.defaultSysSiteStplatSimp(paramVO);
    }
    

    public SiteStplatInfoVO selectStplatSimpBySeq(SiteStplatInfoVO paramVO) throws Exception {
        return siteStplatSimpDAO.selectStplatSimpBySeq(paramVO);
    }

    public SiteStplatInfoVO selectStplatSimpByJoin(SiteStplatInfoVO paramVO) throws Exception {
        return siteStplatSimpDAO.selectStplatSimpByJoin(paramVO);
    }

}
