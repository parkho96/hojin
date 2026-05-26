package egovframework.wzwg.module.map.service.impl;

import java.util.List;

import org.egovframe.rte.psl.dataaccess.EgovAbstractMapper;
import org.springframework.stereotype.Repository;

import egovframework.wzwg.module.map.service.ModuleMapVO;


@Repository("ModuleMapBassInfoDAO")
public class ModuleMapBassInfoDAO extends EgovAbstractMapper{

	/**
	 * 컨텐츠 기본정보 리스트
	 * @param moduleMapVO
	 * @return
	 */
	public List<ModuleMapVO> selectModuleMapList(ModuleMapVO moduleMapVO) {
		return selectList("ModuleMapBassInfoDAO_selectModuleMapList", moduleMapVO);
	}

	/**
	 * 컨텐츠 기본정보 시퀀스 조회(CNTNTS_SEQ)
	 * @return
	 */
	public String selectModuleMapSeq() {
		return (String) selectOne("ModuleMapBassInfoDAO_selectModuleMapSeq", null);
	}

	/**
	 * 컨텐츠 기본정보 등록
	 * @param moduleMapVO
	 * @return
	 */
	public int registModuleMapAjax(ModuleMapVO moduleMapVO) {
		return update("ModuleMapBassInfoDAO_registModuleMapAjax", moduleMapVO);
	}

	/**
	 * 컨텐츠 기본정보 상세조회
	 * @param moduleMapVO
	 * @return
	 */
	public ModuleMapVO selectMapBassInfoDetail(ModuleMapVO moduleMapVO) {
		return (ModuleMapVO) selectOne("ModuleMapBassInfoDAO_selectMapBassInfoDetail", moduleMapVO);
	}

	/**
	 * 컨텐츠 기본정보 수정
	 * @param moduleMapVO
	 * @return
	 */
	public int modifyModuleMapAjax(ModuleMapVO moduleMapVO) {
		return update("ModuleMapBassInfoDAO_modifyModuleMapAjax", moduleMapVO);
	}
    
    public void registMdmapDataCopy(ModuleMapVO moduleMapVO) throws Exception {
        insert("ModuleMapBassInfoDAO_registMdmapDataCopy", moduleMapVO);
    }
    
    public void registMdmapImgDataCopy(ModuleMapVO moduleMapVO) throws Exception {
        insert("ModuleMapBassInfoDAO_registMdmapImgDataCopy", moduleMapVO);
    }

}
