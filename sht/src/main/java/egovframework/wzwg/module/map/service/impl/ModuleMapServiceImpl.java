package egovframework.wzwg.module.map.service.impl;

import java.util.List;

import jakarta.annotation.Resource;

import org.egovframe.rte.fdl.cmmn.EgovAbstractServiceImpl;
import org.springframework.stereotype.Service;

import egovframework.wzwg.module.map.service.ModuleMapService;
import egovframework.wzwg.module.map.service.ModuleMapVO;

@Service("ModuleMapService")
public class ModuleMapServiceImpl extends EgovAbstractServiceImpl implements ModuleMapService {
	@Resource(name="ModuleMapDAO")
	ModuleMapDAO moduleMapDAO;


	/**
	 * 지도 데이터 상세조회
	 * @param moduleCntntsVO
	 * @return
	 */
	public ModuleMapVO selectModuleMapDetail(ModuleMapVO moduleMapVO) {
		return moduleMapDAO.selectModuleMapDetail(moduleMapVO);
	}
	
	
	public List<ModuleMapVO> selectMapScrinMainCntnts(ModuleMapVO moduleMapVO) {
        return moduleMapDAO.selectMapScrinMainCntnts(moduleMapVO);
    }
	  
	/**
	 * 지도 데이터 시퀀스 조회
	 * @return
	 */
	public String selectModuleMapSeq() {
		return moduleMapDAO.selectModuleMapSeq();
	}

	/**
	 * 지도 데이터 등록
	 * @param moduleCntntsVO
	 * @return
	 */
	public void registModuleMapAjax(ModuleMapVO moduleMapVO) {
		 String mapSeq = selectModuleMapSeq();
		 moduleMapVO.setMapSeq(mapSeq);
		  moduleMapDAO.registModuleMapAjax(moduleMapVO);
	}
	
	/**
	 * 지도 데이터 수정
	 * @param moduleCntntsVO
	 * @return
	 */
	public int modifyModuleMapAjax(ModuleMapVO moduleMapVO) {
		return moduleMapDAO.modifyModuleMapAjax(moduleMapVO);
	}

	/**
	 * 지도 데이터 삭제
	 * @param moduleCntntsVO
	 * @return
	 */
	public int deleteModuleMapAjax(ModuleMapVO moduleMapVO) {
		return moduleMapDAO.deleteModuleMapAjax(moduleMapVO);
	}
     
    /**
     * 지도 상세 - 서비스 화면
     */
    public ModuleMapVO selectMapScrinCntnts(ModuleMapVO moduleMapVO) {
        return moduleMapDAO.selectMapScrinCntnts(moduleMapVO);
    }

    /**
     * 지도 이미지 추가
     * @param moduleMapVO
     */
	public void registModuleMapImg(ModuleMapVO moduleMapVO) {
		String mapImgSeq = moduleMapDAO.selectModuleMapImgSeq();
		moduleMapVO.setMapImgSeq(mapImgSeq);
		moduleMapDAO.registModuleMapImg(moduleMapVO);
	}

	/**
     * 지도 이미지 수정/삭제
     * @param moduleMapVO
     * @return
     */
	public int modifyModuleMapImgAjax(ModuleMapVO moduleMapVO) {
		return moduleMapDAO.modifyModuleMapImgAjax(moduleMapVO);
	}
    
	/**
	 * 지도 이미지 목록 조회
	 * @param moduleMapVO
	 * @return
	 */
	public List<ModuleMapVO> selectModuleMapImgListAjax(ModuleMapVO moduleMapVO){
		return moduleMapDAO.selectModuleMapImgListAjax(moduleMapVO);
	}
	
	/**
	 * 지도 이미지 정보의 기본값세팅을 모두 N으로 변경한다
	 * @param moduleMapVO
	 */
	public void modifyModuleMapImgDefaultClear(ModuleMapVO moduleMapVO){
		moduleMapDAO.modifyModuleMapImgDefaultClear(moduleMapVO);
	}
    
}
