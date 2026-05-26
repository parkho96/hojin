package egovframework.wzwg.module.map.service;

import java.util.List;

public interface ModuleMapBassInfoService {

	/** 게시판 기본정보 리스트 */
	List<ModuleMapVO> selectModuleMapList(ModuleMapVO moduleMapVO);

	/** 게시판 기본정보 등록 */
	int registModuleMapAjax(ModuleMapVO moduleMapVO);
	
	String registMapinfoBassInfoInit(ModuleMapVO moduleMapVO);
	
	int registMapBassInfoInit(ModuleMapVO moduleMapVO);

	/** 게시판 기본정보 상세조회 */
	ModuleMapVO selectMapBassInfoDetail(ModuleMapVO moduleMapVO);

    /**
     * 지도 기본정보 상세조회
     */
    ModuleMapVO selectMapinfoBassInfoDetail(ModuleMapVO moduleMapVO);

	/** 게시판 기본정보 수정 */
	int modifyModuleMapAjax(ModuleMapVO moduleMapVO);
    
    void registMapinfoDataCopy(ModuleMapVO moduleMapVO) throws Exception;

}
