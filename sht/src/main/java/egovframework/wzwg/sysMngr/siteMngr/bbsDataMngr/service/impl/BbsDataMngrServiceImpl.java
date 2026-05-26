package egovframework.wzwg.sysMngr.siteMngr.bbsDataMngr.service.impl;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.sysMngr.siteMngr.bbsDataMngr.service.BbsDataMngrService;
import egovframework.wzwg.sysMngr.siteMngr.bbsDataMngr.service.BbsDataMngrVO;

@Service("BbsDataMngrService")
public class BbsDataMngrServiceImpl extends EgovAbstractServiceImpl implements BbsDataMngrService {
     
    @Resource(name="BbsDataMngrDAO")
    private BbsDataMngrDAO bbsDataMngrDAO;
    
	/**
	 * 사이트 - 작업공지여부 확인
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int selectSiteOpertNtcCnt(BbsDataMngrVO paramVO) throws Exception {
    	return bbsDataMngrDAO.selectSiteOpertNtcCnt(paramVO);
    }    
	
	/**
	 * 시스템 - 작업공지여부 확인
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int selectSysOpertNtcCnt(BbsDataMngrVO paramVO) throws Exception {
    	return bbsDataMngrDAO.selectSysOpertNtcCnt(paramVO);
    }		

	/**
	 * 사이트 - 게시물 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteNtt(BbsDataMngrVO paramVO) throws Exception {
		
		int resultValue = 0;

		resultValue = bbsDataMngrDAO.deleteSiteFileDetail(paramVO);

		resultValue = bbsDataMngrDAO.deleteSiteFile(paramVO);
		
		resultValue = bbsDataMngrDAO.deleteSiteNttLike(paramVO);
		
		resultValue = bbsDataMngrDAO.deleteSiteNttAnswer(paramVO);
		
		resultValue = bbsDataMngrDAO.deleteSiteNttAdiInfo(paramVO);

		resultValue = bbsDataMngrDAO.deleteSiteNtt(paramVO);
	
		resultValue = bbsDataMngrDAO.deleteSiteSimpNttAnswer(paramVO);

		resultValue = bbsDataMngrDAO.deleteSiteSimpNtt(paramVO);
		
		resultValue = 1;

		return resultValue;
	}
 
	/**
	 * 시스템 - 게시물 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSysNtt(BbsDataMngrVO paramVO) throws Exception {
		
		int resultValue = 0;
		
		resultValue = bbsDataMngrDAO.deleteSysFileDetail(paramVO);

		resultValue = bbsDataMngrDAO.deleteSysFile(paramVO);
		
		resultValue = bbsDataMngrDAO.deleteSysNttLike(paramVO);

		resultValue = bbsDataMngrDAO.deleteSysNttAnswer(paramVO);

		resultValue = bbsDataMngrDAO.deleteSysNttAdiInfo(paramVO);

		resultValue = bbsDataMngrDAO.deleteSysNtt(paramVO);

		resultValue = bbsDataMngrDAO.deleteSysSimpNttAnswer(paramVO);

		resultValue = bbsDataMngrDAO.deleteSysSimpNtt(paramVO);
		
		resultValue = 1;

		return resultValue;
	}	
}
