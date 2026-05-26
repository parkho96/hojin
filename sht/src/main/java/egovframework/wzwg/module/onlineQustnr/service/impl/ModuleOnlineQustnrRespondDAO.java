package egovframework.wzwg.module.onlineQustnr.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrRespondVO;

@Repository("ModuleOnlineQustnrRespondDAO")
public class ModuleOnlineQustnrRespondDAO extends EgovAbstractMapper {

	/**
	 * @Method Name : selectOnlineQustnrRespondSeq
	 * @Method 설명 : 온라인설문 답변 시퀀스 조회
	 * @작성일 : 2019. 7. 9.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public String selectOnlineQustnrRespondSeq() {
		return (String) selectOne("ModuleOnlineQustnrRespondDAO_selectOnlineQustnrRespondSeq", null);
	}

	/**
	 * @Method Name : selectQustnrInfoTotCnt
	 * @Method 설명 : 온라인설문 총 카운트 조회
	 * @작성일 : 2019. 7. 9.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public Integer selectQustnrInfoTotCnt(ModuleOnlineQustnrRespondVO paramVO) {
		return (Integer) selectOne("ModuleOnlineQustnrRespondDAO_selectQustnrInfoTotCnt", paramVO);
	}

	/**
	 * @Method Name : selectOnlineQustnrList
	 * @Method 설명 : 온라인설문 리스트 조회
	 * @작성일 : 2019. 7. 9.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	
	public List<ModuleOnlineQustnrRespondVO> selectOnlineQustnrList(ModuleOnlineQustnrRespondVO paramVO) {
		return selectList("ModuleOnlineQustnrRespondDAO_selectOnlineQustnrList", paramVO);
	}

	/**
	 * @Method Name : registOnlineQustnrRespond
	 * @Method 설명 : 온라인설문 답변 등록
	 * @작성일 : 2019. 7. 9.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public int registOnlineQustnrRespond(ModuleOnlineQustnrRespondVO paramVO) {
		return update("ModuleOnlineQustnrRespondDAO_registOnlineQustnrRespond", paramVO);
	}

}
