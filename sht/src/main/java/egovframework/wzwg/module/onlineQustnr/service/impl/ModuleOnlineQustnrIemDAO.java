package egovframework.wzwg.module.onlineQustnr.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.onlineQustnr.service.ModuleOnlineQustnrIemVO;


@Repository("ModuleOnlineQustnrIemDAO")
public class ModuleOnlineQustnrIemDAO extends EgovAbstractMapper {

	/** 설문 항목 시퀀스 조회 */
	public String selectOnlineQustnrIemSeq() {
		return (String) selectOne("ModuleOnlineQustnrIemDAO_selectOnlineQustnrIemSeq", null);
	}

	/** 설문 항목 순서 조회 */
	public String selectOnlineQustnrIemOrdr(ModuleOnlineQustnrIemVO paramVO) {
		return (String) selectOne("ModuleOnlineQustnrIemDAO_selectOnlineQustnrIemOrdr", paramVO);
	}
	
	/** 설문 항목 리스트 조회 */
	public List<ModuleOnlineQustnrIemVO> selectOnlineQustnrIemList(ModuleOnlineQustnrIemVO paramVO){
		return selectList("ModuleOnlineQustnrIemDAO_selectOnlineQustnrIemList", paramVO);
	}

	/** 설문 항목 등록 */
	public void registOnlineQustnrIem(ModuleOnlineQustnrIemVO paramVO) {
		update("ModuleOnlineQustnrIemDAO_registOnlineQustnrIem", paramVO);
	}

	/** 설문 항목 수정 */
	public void modifyOnlineQustnrIem(ModuleOnlineQustnrIemVO paramVO) {
		update("ModuleOnlineQustnrIemDAO_modifyOnlineQustnrIem", paramVO);
	}
	
	/** 설문 항목 삭제 */
	public void deleteOnlineQustnrIem(ModuleOnlineQustnrIemVO paramVO) {
		update("ModuleOnlineQustnrIemDAO_deleteOnlineQustnrIem", paramVO);
	}

	/** 설문 항목 텍스트 리스트 조회 */
	public List<ModuleOnlineQustnrIemVO> selectOnlineQustnrIemTextList(ModuleOnlineQustnrIemVO paramVO) {
		return selectList("ModuleOnlineQustnrIemDAO_selectOnlineQustnrIemTextList", paramVO);
	}

}
