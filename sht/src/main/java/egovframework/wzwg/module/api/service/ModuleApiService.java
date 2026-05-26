package egovframework.wzwg.module.api.service;

import java.util.List;

public interface ModuleApiService {

	/** API관리 -> 총 카운트 조회 */
	Integer selectModuleApiTotCnt(ModuleApiVO moduleApiVO);

	/** API관리 -> API 리스트 조회 */
	List<ModuleApiVO> selectModuleApiList(ModuleApiVO moduleApiVO);

	/** API관리 -> API 상세조회 */
	ModuleApiVO selectModuleApiDetail(ModuleApiVO moduleApiVO);

	/** API관리 -> API 등록 */
	int registModuleApi(ModuleApiVO moduleApiVO);

	/** API관리 -> API 수정 */
	int modifyModuleApi(ModuleApiVO moduleApiVO);

	/** API관리 -> API 삭제 */
	int deleteModuleApi(ModuleApiVO moduleApiVO);

	/** 네이버지도 -> 사용자(임시) */
	ModuleApiVO selectMapDetail(ModuleApiVO moduleApiVO);

}
