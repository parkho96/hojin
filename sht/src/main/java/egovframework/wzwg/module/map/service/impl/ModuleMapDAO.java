package egovframework.wzwg.module.map.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.map.service.ModuleMapVO;


@Repository("ModuleMapDAO")
public class ModuleMapDAO extends EgovAbstractMapper{
 

	/**
	 * 지도 데이터 상세조회
	 * @param moduleCntntsVO
	 * @return
	 */
	public ModuleMapVO selectModuleMapDetail(ModuleMapVO moduleMapVO) {
		return (ModuleMapVO) selectOne("ModuleMapDAO_selectModuleMapDetail", moduleMapVO);
	}
	
	/**
	 * 지도 데이터 시퀀스 조회
	 * @return
	 */
	public String selectModuleMapSeq() {
		return (String) selectOne("ModuleMapDAO_selectModuleMapSeq", null);
	}

	/**
	 * 지도 데이터 등록
	 * @param moduleCntntsVO
	 * @return
	 */
	public void registModuleMapAjax(ModuleMapVO moduleMapVO) {
		  insert("ModuleMapDAO_registModuleMapAjax", moduleMapVO);
	}
	

	/**
	 * 지도 데이터 삭제
	 * @param moduleCntntsVO
	 * @return
	 */
	public int modifyModuleMapAjax(ModuleMapVO moduleMapVO) {
		return update("ModuleMapDAO_modifyModuleMapAjax", moduleMapVO);
	}
	

	/**
	 * 지도 데이터 삭제
	 * @param moduleCntntsVO
	 * @return
	 */
	public int deleteModuleMapAjax(ModuleMapVO moduleMapVO) {
		return update("ModuleMapDAO_deleteModuleMapAjax", moduleMapVO);
	}
	
    /**
     * 지도 상세 - 서비스 화면
     */
    public ModuleMapVO selectMapScrinCntnts(ModuleMapVO moduleMapVO) {
        return (ModuleMapVO)selectOne("ModuleMapDAO_selectModuleMapDetail", moduleMapVO);
    }
    
    public List<ModuleMapVO> selectMapScrinMainCntnts(ModuleMapVO moduleMapVO) {
        return selectList("ModuleMapDAO_selectMapScrinMainCntnts", moduleMapVO);
    }
    
    /* 이하 지도 이미지 관련 */
    /**
     * 지도 이미지 시퀀스 발급
     * @return
     */
    public String selectModuleMapImgSeq(){
    	return (String) selectOne("ModuleMapDAO_selectModuleMapImgSeq");
    }
    
    /**
     * 지도 이미지 추가
     * @param moduleMapVO
     */
    public void registModuleMapImg(ModuleMapVO moduleMapVO) {
    	insert("ModuleMapDAO_registModuleMapImg", moduleMapVO);
    }
    
    /**
     * 지도 이미지 수정/삭제
     * @param moduleMapVO
     * @return
     */
	public int modifyModuleMapImgAjax(ModuleMapVO moduleMapVO) {
		return update("ModuleMapDAO_modifyModuleMapImgAjax", moduleMapVO);
	}
	
	/**
	 * 지도 이미지 목록 조회
	 * @param moduleMapVO
	 * @return
	 */
	public List<ModuleMapVO> selectModuleMapImgListAjax(ModuleMapVO moduleMapVO){
		return selectList("ModuleMapDAO_selectModuleMapImgListAjax", moduleMapVO);
	}
	
	/**
	 * 지도 이미지 정보의 기본값세팅을 모두 N으로 변경한다
	 * @param moduleMapVO
	 */
	public void modifyModuleMapImgDefaultClear(ModuleMapVO moduleMapVO){
		update("ModuleMapDAO_modifyModuleMapImgDefaultClear", moduleMapVO);
	}

}
