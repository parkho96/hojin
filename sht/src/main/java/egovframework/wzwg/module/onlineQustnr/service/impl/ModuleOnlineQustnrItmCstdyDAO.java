package egovframework.wzwg.module.onlineQustnr.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrInfoVO;

@Repository("ModuleOnlineQustnrItmCstdyDAO")

public class ModuleOnlineQustnrItmCstdyDAO extends EgovAbstractMapper {

	/**
	 * @Method Name : selectOnlineQustnrItmCstdyTotCnt
	 * @Method 설명 : 내 문항 총 카운트 조회
	 * @작성일 : 2019. 7. 8.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public Integer selectOnlineQustnrItmCstdyTotCnt(ModuleOnlineQustnrInfoVO paramVO) {
		return (Integer) selectOne("ModuleOnlineQustnrItmCstdyDAO_selectOnlineQustnrItmCstdyTotCnt", paramVO);
	}

	/**
	 * @Method Name : selectOnlineQustnrItmCstdyList
	 * @Method 설명 : 내 문항 리스트 조회
	 * @작성일 : 2019. 7. 8.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public List<ModuleOnlineQustnrInfoVO> selectOnlineQustnrItmCstdyList(ModuleOnlineQustnrInfoVO paramVO) {
		return selectList("ModuleOnlineQustnrItmCstdyDAO_selectOnlineQustnrItmCstdyList", paramVO);
	}

	/**
	 * @Method Name : registOnlineQustnrItmCstdy
	 * @Method 설명 : 내 문항 등록
	 * @작성일 : 2019. 7. 8.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public int registOnlineQustnrItmCstdy(ModuleOnlineQustnrInfoVO paramVO) {
		return update("ModuleOnlineQustnrItmCstdyDAO_registOnlineQustnrItmCstdy", paramVO);
	}

	/**
	 * @Method Name : deleteOnlineQustnrItmCstdy
	 * @Method 설명 : 내 문항 삭제
	 * @작성일 : 2019. 7. 8.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public int deleteOnlineQustnrItmCstdy(ModuleOnlineQustnrInfoVO paramVO) {
		return update("ModuleOnlineQustnrItmCstdyDAO_deleteOnlineQustnrItmCstdy", paramVO);
	}
	
	/**
	 * @Method Name : selectOnlineQustnrItmCstdyDplctChk
	 * @Method 설명 : 내 문항 중복체크
	 * @작성일 : 2019. 7. 8.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public int selectOnlineQustnrItmCstdyDplctChk(ModuleOnlineQustnrInfoVO paramVO){
		return (Integer) selectOne("ModuleOnlineQustnrItmCstdyDAO_selectOnlineQustnrItmCstdyDplctChk", paramVO);
	}

}
