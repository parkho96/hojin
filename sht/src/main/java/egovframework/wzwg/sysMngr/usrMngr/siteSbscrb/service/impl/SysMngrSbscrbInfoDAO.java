package egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.sysMngr.usrMngr.siteSbscrb.service.SysMngrSbscrbVO;

/**
 * ㅁ 시스템 - 사용자관리 - 가입정보관리
 * ㅁ DC   
 * - 시스템관리자가 사용자를 관리
 * - 생선된 사용자는 사용자 관리자 페이지를 이용하여 접속
 * @author 김c
 *
 */
@Repository("SysMngrSbscrbInfoDAO")

public class SysMngrSbscrbInfoDAO extends EgovAbstractMapper {

	
	/**
	 * ㅁ  시스템 - 사용자관리 - 가입정보관리 - 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public List<SysMngrSbscrbVO> selectSbscrbInfoList(SysMngrSbscrbVO paramVO) throws Exception {
    	return selectList("SysMngrSbscrbInfoDAO_selectSbscrbInfoList_S", paramVO);
    }

    /**
	 * ㅁ  시스템 - 사용자관리 - 가입정보관리 - 목록 건수
     * @param paramVO
     * @return
     * @throws Exception
     */
	public Integer selectSbscrbInfoListTotCnt(SysMngrSbscrbVO paramVO) throws Exception {
    	return (Integer)selectOne("SysMngrSbscrbInfoDAO_selectSbscrbInfoListTotCnt_S", paramVO);
    }

    /**
     * ㅁ  시스템 - 사용자관리 - 가입정보관리 - 사이트SEQ+사이트회원유형 = 등록여부 카운트
     * @param paramVO
     * @return
     * @throws Exception
     */
    public Integer selectSbscrbInfoListChk(SysMngrSbscrbVO paramVO) throws Exception {
        return (Integer)selectOne("SysMngrSbscrbInfoDAO_selectSbscrbInfoListChk", paramVO);
    }
	
    /**
	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int registSbscrbInfo(SysMngrSbscrbVO paramVO) throws Exception {
		
		String sbscrbinfoSeq = (String) selectOne("SysMngrSbscrbInfoDAO_selectNextSbscrbinfoSeq_S", new String());
		
		paramVO.setSbscrbinfoSeq(sbscrbinfoSeq);

		return update("SysMngrSbscrbInfoDAO_registSbscrbInfoInfo_I", paramVO);
    }
	
	/**
	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifySbscrbInfo(SysMngrSbscrbVO paramVO) throws Exception {
		
		int result = 0;
		
		result = update("SysMngrSbscrbInfoDAO_updateSbscrbInfoInfo_I", paramVO);
		
		if("N".equals(paramVO.getSbscrbQestnEstbsAt())){
			delete("SysMngrSbscrbInfoDAO_deleteSbscrbInfoQesitmList_D", paramVO);
			delete("SysMngrSbscrbInfoDAO_deleteSbscrbInfoIemList_D", paramVO);
		}
		
		return result;
    }

	
	/**
	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 가입정보설정여부 조회
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int selectSbscrbinfoSeq(SysMngrSbscrbVO paramVO) throws Exception {
		return (Integer) selectOne("SysMngrSbscrbInfoDAO_selectSbscrbinfoSeq_S", paramVO);
    }
	
    /**
	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 상세정보
     * @param paramVO
     * @return
     * @throws Exception
     */
	public SysMngrSbscrbVO selectSbscrbInfoDetail(SysMngrSbscrbVO paramVO) throws Exception {
    	return (SysMngrSbscrbVO) selectOne("SysMngrSbscrbInfoDAO_selectSbscrbInfoDetail_S", paramVO);
    }
    
    /**
     * ㅁ 사이트 회원가입
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int registSbscrbInforspns(SysMngrSbscrbVO paramVO) throws Exception {
        return update("SysMngrSbscrbInfoDAO_registSbscrbInforspns_I", paramVO);
    }
    
    /**
     * ㅁ 사이트 회원가입
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifySbscrbInforspns(SysMngrSbscrbVO paramVO) throws Exception {
        return update("SysMngrSbscrbInfoDAO_modifySbscrbInforspns_I", paramVO);
    }
    
   	public int selectSbscrbInforspnsCnt(SysMngrSbscrbVO paramVO) throws Exception {
   	    return (Integer)selectOne("SysMngrSbscrbInfoDAO_selectSbscrbInforspnsCnt", paramVO);
   	}
    
    /**
     * ㅁ 가입절차에 필요한 정보 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
    public int modifySbscrbProcssInfo(SysMngrSbscrbVO paramVO) throws Exception {
        return update("SysMngrSbscrbInfoDAO_modifySbscrbProcssInfo", paramVO);
    }
}
