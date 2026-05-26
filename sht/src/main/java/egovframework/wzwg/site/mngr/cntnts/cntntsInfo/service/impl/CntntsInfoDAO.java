package egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.site.mngr.cntnts.cntntsInfo.service.CntntsInfoVO;

@Repository("CntntsInfoDAO")
public class CntntsInfoDAO extends EgovAbstractMapper {

	@Autowired
	HttpSession session;
	
	/**
	 * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 목록
	 * @param CntntsInfoVO
	 * @return
	 */
	
	public List<CntntsInfoVO> selectCntntsInfoList(CntntsInfoVO paramVO) {
		
		String langcode = null;
		
		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		paramVO.setLangCode(langcode);
		
		return selectList("CntntsInfoDAO_selectCntntsInfoList", paramVO);
	}

    /**
	 * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 목록 건수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectCntntsInfoListCnt(CntntsInfoVO paramVO) {
    	return (Integer)selectOne("CntntsInfoDAO_selectCntntsInfoListCnt", paramVO);
    }

    /**
     * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 목록 건수
     * @param paramVO
     * @return
     * @throws Exception
     */
    public CntntsInfoVO selectCntntsInfo(CntntsInfoVO paramVO) {
        return (CntntsInfoVO)selectOne("CntntsInfoDAO_selectCntntsInfo", paramVO);
    }

	/**
	 * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 전체 목록
	 * @param String
	 * @return
	 */
	
	public List<CntntsInfoVO> selectCntntsInfoAllList(String siteSeq) {
		
		CntntsInfoVO paramVO = new CntntsInfoVO();
		
		String langcode = null;
		
		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		paramVO.setLangCode(langcode);
		paramVO.setSiteSeq(siteSeq);
		
		return selectList("CntntsInfoDAO_selectCntntsInfoAllList", paramVO);
	}
	
	/**
	 * ㅁ 컨텐츠정보 - 모듈 메뉴 컨텐츠 정보 전체 목록
	 * @param String
	 * @return
	 */
	
	public List<CntntsInfoVO> selectMenuCntntsInfoAllList(String siteSeq) {
		return selectList("CntntsInfoDAO_selectMenuCntntsInfoAllList", siteSeq);
	}

    /**
     * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 등록
     * @param String
     * @return
     */
    public int registCntntsInfo(CntntsInfoVO paramVO) {

        return update("CntntsInfoDAO_registCntntsInfo", paramVO);
    }

    /**
     * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 등록
     * @param String
     * @return
     */
    public String selectCntntsInfoSeq() {

        return (String)selectOne("CntntsInfoDAO_selectCntntsInfoSeq", null);
    }

    /**
     * ㅁ 컨텐츠정보 - 모듈 컨텐츠 정보 삭제
     * @param String
     * @return
     */
    public int deleteCntntsInfo(CntntsInfoVO paramVO) {

        return update("CntntsInfoDAO_deleteCntntsInfo", paramVO);
    }

    /**
     * ㅁ 컨텐츠정보 - 컨텐츠 API 제공 목록
     * @param String
     * @return
     */
    
    public List<CntntsInfoVO> selectCntntsApiProvdList(CntntsInfoVO paramVO) {
        return selectList("CntntsInfoDAO_selectCntntsApiProvdList", paramVO);
    }
    
    /**
	 * ㅁ 컨텐츠정보 - 컨텐츠 시퀀스 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectSitecntntsSeq() {
    	return (String)selectOne("CntntsInfoDAO_selectSitecntntsSeq");
    }
    
    /**
     * ㅁ 컨텐츠정보 - 모듈 초기 컨텐츠 정보 등록
     * @param String
     * @return
     */
    public int registCntntsInfoInit(CntntsInfoVO paramVO) {
        return update("CntntsInfoDAO_registCntntsInfoInit", paramVO);
    }
    
    /**
     * ㅁ 컨텐츠정보 - 모듈 초기 컨텐츠 정보 수정
     * @param String
     * @return
     */
    public int modifyCntntsInfoInit(CntntsInfoVO paramVO) {
        return update("CntntsInfoDAO_modifyCntntsInfoInit", paramVO);
    }
    
    public CntntsInfoVO selectCntntsBassInfo(CntntsInfoVO paramVO) {
        return (CntntsInfoVO)selectOne("CntntsInfoDAO_selectCntntsBassInfo", paramVO);
    }
    
    /* 이하 컨텐츠 대시보드용 */
    
    public List<CntntsInfoVO> selectCntntsDashboardCnt(CntntsInfoVO paramVO) {
    	return selectList("CntntsInfoDAO_selectCntntsDashboardCnt", paramVO);
    }
    
	public List<CntntsInfoVO> selectBbsInfoList(CntntsInfoVO paramVO) { 
		return selectList("CntntsInfoDAO_selectBbsInfoList", paramVO);
	}
    
    public CntntsInfoVO selectBbsAtchFileIdCheck(String atchFileId) {
    	return (CntntsInfoVO)selectOne("CntntsInfoDAO_selectBbsAtchFileIdCheck", atchFileId);
    }
}
