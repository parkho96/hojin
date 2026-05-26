package egovframework.wzwg.module.onlineQustnr.service;

import java.util.List;

public interface ModuleOnlineQustnrQesitmService {

	/** 설문 문항 리스트 조회 */
	List<ModuleOnlineQustnrQesitmVO> selectOnlineQustnrQesitmList(ModuleOnlineQustnrQesitmVO paramVO);

	/** 설문 문항 등록/수정 폼 */
	ModuleOnlineQustnrQesitmVO selectOnlineQustnrQesitmDetail(ModuleOnlineQustnrQesitmVO paramVO);

	/** 설문 문항 등록 */
	int registOnlineQustnrQesitm(ModuleOnlineQustnrQesitmVO paramVO);

	/** 설문 문항 수정 */
	int modifyOnlineQustnrQesitm(ModuleOnlineQustnrQesitmVO paramVO);

	/** 설문 문항 삭제 */
	int deleteOnlineQustnrQesitm(ModuleOnlineQustnrQesitmVO paramVO);

	/** 설문 문항 체크박스 삭제 */
	int deleteOnlineQustnrQesitmArr(ModuleOnlineQustnrQesitmVO paramVO);

	/** 설문 문항 순서 변경 */
	int modifyOnlineQustnrQesitmOrdr(ModuleOnlineQustnrQesitmVO paramVO);

	/** 설문 항목 리스트 조회 */
	List<ModuleOnlineQustnrIemVO> selectOnlineQustnrIemList(ModuleOnlineQustnrIemVO paramVO);
	
	/** 설문 항목 리스트 분기 */
	List<ModuleOnlineQustnrIemVO> selectOnlineQustnrResultIemInit(ModuleOnlineQustnrIemVO paramVO);

	/** 설문 항목 텍스트 리스트 조회 */
	List<ModuleOnlineQustnrIemVO> selectOnlineQustnrIemTextList(ModuleOnlineQustnrIemVO paramVO);
	
}
