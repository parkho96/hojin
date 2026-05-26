package egovframework.wzwg.module.map.service;

import java.util.List;

public interface ModuleMapService {

	/**
	 * 지도 데이터 상세조회
	 * @param moduleCntntsVO
	 * @return
	 */
	public ModuleMapVO selectModuleMapDetail(ModuleMapVO moduleMapVO);
	
	public List<ModuleMapVO> selectMapScrinMainCntnts(ModuleMapVO moduleMapVO);
     
	
	/**
	 * 지도 데이터 시퀀스 조회
	 * @return
	 */
	public String selectModuleMapSeq() ;
	/**
	 * 지도 데이터 등록
	 * @param moduleCntntsVO
	 * @return
	 */
	public void registModuleMapAjax(ModuleMapVO moduleMapVO);
	
	/**
	 * 지도 데이터 수정
	 * @param moduleCntntsVO
	 * @return
	 */
	public int modifyModuleMapAjax(ModuleMapVO moduleMapVO);

	/**
	 * 지도 데이터 삭제
	 * @param moduleCntntsVO
	 * @return
	 */
	public int deleteModuleMapAjax(ModuleMapVO moduleMapVO) ;
	
    /**
     * 지도 상세 - 서비스 화면
     */
    public ModuleMapVO selectMapScrinCntnts(ModuleMapVO moduleMapVO);
    
    /**
     * 지도 이미지 추가
     * @param moduleMapVO
     */
    public void registModuleMapImg(ModuleMapVO moduleMapVO);
    
    /**
     * 지도 이미지 수정/삭제
     * @param moduleMapVO
     * @return
     */
    public int modifyModuleMapImgAjax(ModuleMapVO moduleMapVO);

    /**
	 * 지도 이미지 목록 조회
	 * @param moduleMapVO
	 * @return
	 */
	public List<ModuleMapVO> selectModuleMapImgListAjax(ModuleMapVO moduleMapVO);
	
	/**
	 * 지도 이미지 정보의 기본값세팅을 모두 N으로 변경한다
	 * @param moduleMapVO
	 */
	public void modifyModuleMapImgDefaultClear(ModuleMapVO moduleMapVO);
}
