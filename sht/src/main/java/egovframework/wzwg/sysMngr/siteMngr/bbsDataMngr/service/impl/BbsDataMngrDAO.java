package egovframework.wzwg.sysMngr.siteMngr.bbsDataMngr.service.impl;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.siteMngr.bbsDataMngr.service.BbsDataMngrVO;

@Repository("BbsDataMngrDAO")
public class BbsDataMngrDAO extends EgovAbstractMapper {

	/**
	 * 사이트 - 작업공지여부 확인
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int selectSiteOpertNtcCnt(BbsDataMngrVO paramVO) throws Exception {
    	return (Integer)selectOne("BbsDataMngrDAO_selectSiteOpertNtcCnt", paramVO);
    }	
	
	/**
	 * 시스템 - 작업공지여부 확인
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int selectSysOpertNtcCnt(BbsDataMngrVO paramVO) throws Exception {
    	return (Integer)selectOne("BbsDataMngrDAO_selectSysOpertNtcCnt", paramVO);
    }	

	/**
	 * 사이트 - 파일상세정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteFileDetail(BbsDataMngrVO paramVO) throws Exception {
		
		return update("BbsDataMngrDAO_deleteSiteFileDetail", paramVO);
	}
	
	/**
	 * 사이트 - 파일정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteFile(BbsDataMngrVO paramVO) throws Exception {
		
		return update("BbsDataMngrDAO_deleteSiteFile", paramVO);
	}	
	
	/**
	 * 사이트 - 게시물 종아요 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteNttLike(BbsDataMngrVO paramVO) throws Exception {
		
		return update("BbsDataMngrDAO_deleteSiteNttLike", paramVO);
	}
	
	/**
	 * 사이트 - 게시물 댓글 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteNttAnswer(BbsDataMngrVO paramVO) throws Exception {
		
		return update("BbsDataMngrDAO_deleteSiteNttAnswer", paramVO);
	}
 
	/**
	 * 사이트 - 게시물 부가정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteNttAdiInfo(BbsDataMngrVO paramVO) throws Exception {
		
		return update("BbsDataMngrDAO_deleteSiteNttAdiInfo", paramVO);
	}
	    
	/**
	 * 사이트 - 게시물 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteNtt(BbsDataMngrVO paramVO) throws Exception {
		
		return update("BbsDataMngrDAO_deleteSiteNtt", paramVO);
	}
	
	/**
	 * 사이트 - 간단게시판 게시물 댓글 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteSimpNttAnswer(BbsDataMngrVO paramVO) throws Exception {
		
		return update("BbsDataMngrDAO_deleteSiteSimpNttAnswer", paramVO);
	}	
	    
	/**
	 * 사이트 - 간단게시판 게시물 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSiteSimpNtt(BbsDataMngrVO paramVO) throws Exception {
		
		return update("BbsDataMngrDAO_deleteSiteSimpNtt", paramVO);
	}
	
	


	/**
	 * 시스템 - 파일상세정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSysFileDetail(BbsDataMngrVO paramVO) throws Exception {
		
		return update("BbsDataMngrDAO_deleteSysFileDetail", paramVO);
	}
	
	/**
	 * 시스템 - 파일정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSysFile(BbsDataMngrVO paramVO) throws Exception {
		
		return update("BbsDataMngrDAO_deleteSysFile", paramVO);
	}	
	
	/**
	 * 시스템 - 게시물 종아요 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSysNttLike(BbsDataMngrVO paramVO) throws Exception {
		
		return update("BbsDataMngrDAO_deleteSysNttLike", paramVO);
	}
	
	/**
	 * 시스템 - 게시물 댓글 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSysNttAnswer(BbsDataMngrVO paramVO) throws Exception {
		
		return update("BbsDataMngrDAO_deleteSysNttAnswer", paramVO);
	}
 
	/**
	 * 시스템 - 게시물 부가정보 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSysNttAdiInfo(BbsDataMngrVO paramVO) throws Exception {
		
		return update("BbsDataMngrDAO_deleteSysNttAdiInfo", paramVO);
	}
	    
	/**
	 * 시스템 - 게시물 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSysNtt(BbsDataMngrVO paramVO) throws Exception {
		
		return update("BbsDataMngrDAO_deleteSysNtt", paramVO);
	}
	
	/**
	 * 시스템 - 간단게시판 게시물 댓글 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSysSimpNttAnswer(BbsDataMngrVO paramVO) throws Exception {
		
		return update("BbsDataMngrDAO_deleteSysSimpNttAnswer", paramVO);
	}	
	    
	/**
	 * 시스템 - 간단게시판 게시물 삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public int deleteSysSimpNtt(BbsDataMngrVO paramVO) throws Exception {
		
		return update("BbsDataMngrDAO_deleteSysSimpNtt", paramVO);
	}	
   	
}
