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
@Repository("SysMngrSbscrbQesitmDAO")

public class SysMngrSbscrbQesitmDAO extends EgovAbstractMapper {

	
	/**
	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 가입문항 SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
	public String selectNextSbscrbQesitmSeq() throws Exception {
		return (String) selectOne("SysMngrSbscrbQesitmDAO_selectNextSbscrbQesitmSeq_S", new String());
	}

    /**
     * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 가입문항 SEQ 추출
     * @param paramVO
     * @return
     * @throws Exception
     */
    public String selectSbscrbinfoSeq(SysMngrSbscrbVO paramVO) throws Exception {
        return (String) selectOne("SysMngrSbscrbQesitmDAO_selectSbscrbinfoSeq", paramVO);
    }
	
	/**
	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 가입문항 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public void registSbscrbQesitm(SysMngrSbscrbVO paramVO) throws Exception {
		insert("SysMngrSbscrbQesitmDAO_registSbscrbQesitm_I", paramVO);
	}
	
	/**
	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 가입항목 등록
     * @param paramVO
     * @return
     * @throws Exception
     */
	public void registSbscrbQesitmIem(SysMngrSbscrbVO paramVO) throws Exception {
		insert("SysMngrSbscrbQesitmDAO_registSbscrbQesitmIem_I", paramVO);
	}
	
	/**
	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 가입문항 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifySbscrbQesitm(SysMngrSbscrbVO paramVO) throws Exception {
		return update("SysMngrSbscrbQesitmDAO_updateSbscrbQesitm_U", paramVO);
	}
	
	/**
	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 가입항목 수정
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int modifySbscrbQesitmIem(SysMngrSbscrbVO paramVO) throws Exception {
		return update("SysMngrSbscrbQesitmDAO_updateSbscrbQesitmIem_U", paramVO);
	}
	
	/**
	 * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 객관식 가입항목 삭제
     * @param paramVO
     * @return
     * @throws Exception
     */
	public int deleteSbscrbQesitmObjctIemList(SysMngrSbscrbVO paramVO) throws Exception {
		return update("SysMngrSbscrbQesitmDAO_deleteSbscrbQesitmObjctIemList_D", paramVO);
	}
	
	/**
     * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 가입문항 목록
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
	public List<SysMngrSbscrbVO> selectSbscrbQesitmList(SysMngrSbscrbVO paramVO) throws Exception {
   		return selectList("SysMngrSbscrbQesitmDAO_selectSbscrbQesitmList_S", paramVO);
   	}
	
   	/**
     * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 객관식 항목 목록 
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
   	public List<SysMngrSbscrbVO> selectSbscrbIemList(SysMngrSbscrbVO paramVO) throws Exception {
   		return selectList("SysMngrSbscrbQesitmDAO_selectSbscrbIemList_S", paramVO);
   	}
   	
   	/**
     * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 질문삭제
	 * @param paramVO
	 * @return
	 * @throws Exception
	 */
   	public int deleteSbscrbQesitm(SysMngrSbscrbVO paramVO) throws Exception {
   		return update("SysMngrSbscrbQesitmDAO_deleteSbscrbQesitm_D", paramVO);
   	}
    
    /**
     * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 가입문항 -사용자 답변 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<SysMngrSbscrbVO> selectSbscrbIemUsrRspns(SysMngrSbscrbVO paramVO) throws Exception {
        return selectList("SysMngrSbscrbQesitmDAO_selectSbscrbIemUsrRspns_S", paramVO);
    }
    
    /**
     * ㅁ 시스템 - 사용자관리 - 가입정보관리 - 가입문항 -사용자 답변 목록
     * @param paramVO
     * @return
     * @throws Exception
     */
    public List<SysMngrSbscrbVO> selectSbscrbQesitmUsrRspns(SysMngrSbscrbVO paramVO) throws Exception {
        return selectList("SysMngrSbscrbQesitmDAO_selectSbscrbQesitmUsrRspns_S", paramVO);
    }
   	
}
