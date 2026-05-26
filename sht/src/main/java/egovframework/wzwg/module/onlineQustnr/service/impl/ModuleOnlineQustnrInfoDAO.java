package egovframework.wzwg.module.onlineQustnr.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrInfoVO;

/**
 * @author 현상
 *
 */
@Repository("ModuleOnlineQustnrInfoDAO")

public class ModuleOnlineQustnrInfoDAO extends EgovAbstractMapper{

	/**
	 * @Method Name : selectOnlineQustnrInfoSeq
	 * @Method 설명 : 설문 시퀀스 조회
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public String selectOnlineQustnrInfoSeq() {
		return (String) selectOne("ModuleOnlineQustnrInfoDAO_selectOnlineQustnrInfoSeq", null);
	}
	
	/**
	 * @Method Name : selectOnlineQustnrInfoTotCnt
	 * @Method 설명 : 설문 총 카운트 조회
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public Integer selectOnlineQustnrInfoTotCnt(ModuleOnlineQustnrInfoVO paramVO) {
		return (Integer) selectOne("ModuleOnlineQustnrInfoDAO_selectOnlineQustnrInfoTotCnt", paramVO);
	}

	/**
	 * @Method Name : selectOnlineQustnrInfoList
	 * @Method 설명 : 설문 리스트 조회
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public List<ModuleOnlineQustnrInfoVO> selectOnlineQustnrInfoList(ModuleOnlineQustnrInfoVO paramVO) {
		return selectList("ModuleOnlineQustnrInfoDAO_selectOnlineQustnrInfoList", paramVO);
	}

	/**
	 * @Method Name : selectOnlineQustnrInfoDetail
	 * @Method 설명 : 설문 상세조회
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public ModuleOnlineQustnrInfoVO selectOnlineQustnrInfoDetail(ModuleOnlineQustnrInfoVO paramVO) {
		return (ModuleOnlineQustnrInfoVO) selectOne("ModuleOnlineQustnrInfoDAO_selectOnlineQustnrInfoDetail", paramVO);
	}

	/**
	 * @Method Name : registOnlineQustnrInfo
	 * @Method 설명 : 설문 등록
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public int registOnlineQustnrInfo(ModuleOnlineQustnrInfoVO paramVO) {
		return update("ModuleOnlineQustnrInfoDAO_registOnlineQustnrInfo", paramVO);
	}

	/**
	 * @Method Name : modifyOnlineQustnrInfo
	 * @Method 설명 : 설문 수정
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public int modifyOnlineQustnrInfo(ModuleOnlineQustnrInfoVO paramVO) {
		return update("ModuleOnlineQustnrInfoDAO_modifyOnlineQustnrInfo", paramVO);
	}

	/**
	 * @Method Name : deleteOnlineQustnrInfo
	 * @Method 설명 : 설문 삭제
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public int deleteOnlineQustnrInfo(ModuleOnlineQustnrInfoVO paramVO) {
		return update("ModuleOnlineQustnrInfoDAO_deleteOnlineQustnrInfo", paramVO);
	}

	/**
	 * @Method Name : registOnlineQustnrUsrty
	 * @Method 설명 : 설문 대상자 등록
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public void registOnlineQustnrUsrty(ModuleOnlineQustnrInfoVO paramVO) {
		update("ModuleOnlineQustnrInfoDAO_registOnlineQustnrUsrty", paramVO);
	}

	/**
	 * @Method Name : deleteOnlineQustnrUsrty
	 * @Method 설명 : 설문 대상자 삭제
	 * @작성일 : 2019. 6. 3.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public void deleteOnlineQustnrUsrty(ModuleOnlineQustnrInfoVO paramVO) {
		update("ModuleOnlineQustnrInfoDAO_deleteOnlineQustnrUsrty", paramVO);
	}

	/**
	 * @Method Name : selectOnlineQustnrUsrtyList
	 * @Method 설명 : 적용중인 설문 대상자 리스트 조회
	 * @작성일 : 2019. 6. 4.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public List<ModuleOnlineQustnrInfoVO> selectOnlineQustnrUsrtyList(ModuleOnlineQustnrInfoVO paramVO) {
		return selectList("ModuleOnlineQustnrInfoDAO_selectOnlineQustnrUsrtyList", paramVO);
	}


}
