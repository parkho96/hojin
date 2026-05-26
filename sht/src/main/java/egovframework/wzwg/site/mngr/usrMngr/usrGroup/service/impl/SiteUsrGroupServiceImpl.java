package egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.impl;

import java.util.IllegalFormatException;
import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupService;
import egovframework.wzwg.site.mngr.usrMngr.usrGroup.service.SiteUsrGroupVO;

@Service("SiteUsrGroupService")
public class SiteUsrGroupServiceImpl extends EgovAbstractServiceImpl implements SiteUsrGroupService {
	@Resource(name="SiteUsrGroupDAO")
	SiteUsrGroupDAO siteUsrGroupDAO;
	
	/**
	 * 사이트 사용자 그룹 총 카운트 조회
	 */
	public int selectSiteUsrGroupTotCnt(SiteUsrGroupVO siteUsrGroupVO) {
		return siteUsrGroupDAO.selectSiteUsrGroupTotCnt(siteUsrGroupVO);
	}

	/**
	 * 사이트 사용자 그룹 리스트 조회
	 */
	public List<SiteUsrGroupVO> selectSiteUsrGroupList(SiteUsrGroupVO siteUsrGroupVO) {
		return siteUsrGroupDAO.selectSiteUsrGroupList(siteUsrGroupVO);
	}
	
	 /**
     * 사이트 사용자 그룹 리스트 전체 조회
     * @param siteUsrGroupVO
     * @return
     */
    public List<SiteUsrGroupVO> selectSiteUsrGroupAllList(String siteSeq) {
        return siteUsrGroupDAO.selectSiteUsrGroupAllList(siteSeq);
    }

	/**
	 * 사이트 사용자 그룹 등록
	 */
	public int registSiteUsrGroup(SiteUsrGroupVO siteUsrGroupVO) {
	    
	    int retVal = 1;
	    
	    try {
    		/** 사이트 사용자 그룹 시퀀스 조회 */
    		String usrGroupSeq = siteUsrGroupDAO.selectSiteUsrGroupSeq();
    		siteUsrGroupVO.setUsrGroupSeq(usrGroupSeq);
    		
    		// 그룹정보 등록
    		siteUsrGroupDAO.registSiteUsrGroup(siteUsrGroupVO);
    		
	    }catch(NullPointerException e){	    	 
	    	 retVal = 0;
	 	}catch(NumberFormatException e){
	 		 retVal = 0;
	 	}catch(IllegalFormatException e){
	 		 retVal = 0;
	 	}catch(ArrayIndexOutOfBoundsException e){
	 		 retVal = 0;
	 	}  
	    
	    return retVal;
	}

	/**
	 * 사이트 사용자 그룹 상세조회
	 */
	public SiteUsrGroupVO selectSiteUsrGroupDetail(SiteUsrGroupVO siteUsrGroupVO) {
		return siteUsrGroupDAO.selectSiteUsrGroupDetail(siteUsrGroupVO);
	}

	/**
	 * 사이트 사용자 그룹 수정
	 */
	public int modifySiteUsrGroup(SiteUsrGroupVO siteUsrGroupVO) {
        
        int retVal = 1;
        
        try {
            // 그룹정보 등록
            siteUsrGroupDAO.modifySiteUsrGroup(siteUsrGroupVO);
            
        } catch(NullPointerException e){	    	 
	    	 retVal = 0;
	 	}catch(NumberFormatException e){	 		 
	 		 retVal = 0;
	 	}catch(IllegalFormatException e){	 		 
	 		 retVal = 0;
	 	}catch(ArrayIndexOutOfBoundsException e){	 		 
	 		 retVal = 0;
	 	} 
        
        return retVal;
	}

	/**
	 * 사이트 사용자 그룹 삭제
	 */
	public int deleteSiteUsrGroup(SiteUsrGroupVO siteUsrGroupVO) {
		return siteUsrGroupDAO.deleteSiteUsrGroup(siteUsrGroupVO);
	}

    /**
     * 사이트 사용자 그룹 리스트 조회 - 코드
     * @param siteUsrGroupVO
     * @return
     */
    public List<SiteUsrGroupVO> selectSiteUsrGroupCode(String siteSeq) {
        return siteUsrGroupDAO.selectSiteUsrGroupCode(siteSeq);
    }

}
