package egovframework.wzwg.module.onlineQustnr.service.impl;

import java.util.List;

import jakarta.servlet.http.HttpSession;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrQesitmVO;

@Repository("ModuleOnlineQustnrQesitmDAO")

public class ModuleOnlineQustnrQesitmDAO extends EgovAbstractMapper {

	@Autowired
	HttpSession session;
	
	/**
	 * @Method Name : selectOnlineQustnrQesitmSeq
	 * @Method 설명 : 문항 시퀀스 조회
	 * @작성일 : 2019. 7. 2.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public String selectOnlineQustnrQesitmSeq(){
		return (String) selectOne("ModuleOnlineQustnrQesitmDAO_selectOnlineQustnrQesitmSeq", null);
	}
	
	/**
	 * @Method Name : selectOnlineQustnrQesitmOrdr
	 * @Method 설명 : 문항 순서 조회
	 * @작성일 : 2019. 7. 2.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public String selectOnlineQustnrQesitmOrdr(ModuleOnlineQustnrQesitmVO paramVO){
		return (String) selectOne("ModuleOnlineQustnrQesitmDAO_selectOnlineQustnrQesitmOrdr", paramVO);
	}
	
	/**
	 * @Method Name : selectOnlineQustnrQesitmList
	 * @Method 설명 : 설문 문항 리스트 조회
	 * @작성일 : 2019. 7. 1.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public List<ModuleOnlineQustnrQesitmVO> selectOnlineQustnrQesitmList(ModuleOnlineQustnrQesitmVO paramVO) {

		String langcode = null;

		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		paramVO.setLangCode(langcode);
		
		return selectList("ModuleOnlineQustnrQesitmDAO_selectOnlineQustnrQesitmList", paramVO);
	}

	/**
	 * @Method Name : selectOnlineQustnrQesitmDetail
	 * @Method 설명 : 설문 문항 상세조회
	 * @작성일 : 2019. 7. 1.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public ModuleOnlineQustnrQesitmVO selectOnlineQustnrQesitmDetail(ModuleOnlineQustnrQesitmVO paramVO) {

		String langcode = null;

		if(session.getAttribute("useLangCode") != null){
			langcode = session.getAttribute("useLangCode").toString();
		}

		paramVO.setLangCode(langcode);
		
		return (ModuleOnlineQustnrQesitmVO) selectOne("ModuleOnlineQustnrQesitmDAO_selectOnlineQustnrQesitmDetail", paramVO);
	}

	/**
	 * @Method Name : registOnlineQustnrQesitm
	 * @Method 설명 : 설문 문항 등록
	 * @작성일 : 2019. 7. 1.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public int registOnlineQustnrQesitm(ModuleOnlineQustnrQesitmVO paramVO) {
		return update("ModuleOnlineQustnrQesitmDAO_registOnlineQustnrQesitm", paramVO);
	}

	/**
	 * @Method Name : modifyOnlineQustnrQesitm
	 * @Method 설명 : 설문 문항 수정
	 * @작성일 : 2019. 7. 1.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public int modifyOnlineQustnrQesitm(ModuleOnlineQustnrQesitmVO paramVO) {
		return update("ModuleOnlineQustnrQesitmDAO_modifyOnlineQustnrQesitm", paramVO);
	}

	/**
	 * @Method Name : deleteOnlineQustnrQesitm
	 * @Method 설명 : 설문 문항 삭제
	 * @작성일 : 2019. 7. 1.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public int deleteOnlineQustnrQesitm(ModuleOnlineQustnrQesitmVO paramVO) {
		return update("ModuleOnlineQustnrQesitmDAO_deleteOnlineQustnrQesitm", paramVO);
	}

	/**
	 * @Method Name : modifyOnlineQustnrQesitmOrdr
	 * @Method 설명 : 설문 문항 순서 변경
	 * @작성일 : 2019. 7. 1.
	 * @작성자 : hyun
	 * @변경이력 : 
	 */
	public int modifyOnlineQustnrQesitmOrdr(ModuleOnlineQustnrQesitmVO paramVO) {
		return update("ModuleOnlineQustnrQesitmDAO_modifyOnlineQustnrQesitmOrdr", paramVO);
	}
	
}
